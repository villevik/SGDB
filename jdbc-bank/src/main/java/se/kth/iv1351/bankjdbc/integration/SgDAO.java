package se.kth.iv1351.bankjdbc.integration;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import se.kth.iv1351.bankjdbc.model.*;

public class SgDAO {
    
    private Connection connection;
    private PreparedStatement getInstrumentListStmt;
    private PreparedStatement insertInstrumentStmt;
    private PreparedStatement getNumberOfRentalsStmt;
    private PreparedStatement updateInstrumentStmt;
    private PreparedStatement getIsRentedStmt;
    private PreparedStatement endRentalStmt;
    private PreparedStatement archiveRentalStmt;

    public SgDAO() throws SGDBException {
        try {
            connectToBankDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new SGDBException("Could not connect to datasource.", exception);
        }
    }
    /**
     * Lists all instruments of a ceratin kind (guitar, saxophone, etc) that are available 
     * to rent. Instruments which are already rented shall not be included in the listing. 
     * The listing shall show brand and price for each listed instrument.
     * 
     * @param kind
     * @throws BankDBException
     */
    public List<Instrument> listInstruments(String kind) throws SQLException,SGDBException{
        String failureMsg = "No matches for picked kind";
        ResultSet result = null;
        List<Instrument> list = new ArrayList<>();
        try
        {
            getInstrumentListStmt.setString(1, kind);
            result = getInstrumentListStmt.executeQuery();
            //System.out.println(result.toString());
            while (result.next())
            {
                list.add(new Instrument(
                        //result.getString("kind"),
                        
                        result.getInt("id"),
                        result.getString("name_of_instrument"),
                        result.getString("brand"),
                        result.getDouble("cost"),
                        result.getInt("student_id")
                        //result.getBoolean("isRented")
                        ));
            }
            //System.out.println(list.toString() + " res");
            connection.commit();
        } catch (SQLException sqle)
        {
            handleException(failureMsg, sqle);
        } finally
        {
            closeResultSet(failureMsg, result);
        }
        return list;
    }

    /**
     * Rent instrument It shall be possible to specify which student is renting the instrument, 
     * and which instrument is being rented. Since different instruments of the same kind 
     * might have different prices, it must be possible to specify exactly which particular 
     * instrument to rent, not just any instrument of the desired kind. Remember that a student 
     * is not allowed to rent more than two instruments at the same time, 
     * your program must check that this limit is not exceeded.
     * 
     * @param account
     * @throws BankDBException
     */
    public void rentInstrument(int studentID, int instrumentID) throws SQLException{
        if(checkIfAllowed(studentID) && !checkIfRented(instrumentID)){

            updateInstrumentStmt.setInt(1, studentID);
            updateInstrumentStmt.setDate(2,Date.valueOf(LocalDate.now()));
            updateInstrumentStmt.setInt(3, instrumentID);
            
            updateInstrumentStmt.execute();
            connection.commit();
        }
        else{
            System.out.println("Can't rent more than 2 instruments...");
        }
    }
    public void newInstrument(int id, String name, String brand, int quantity) throws SQLException, SGDBException{
        String failureMsg = "Failed to insert";
        try{
            insertInstrumentStmt.setInt(1, id);
            insertInstrumentStmt.setString(2, name);
            insertInstrumentStmt.setString(3, brand);
            insertInstrumentStmt.setInt(4, quantity);
            insertInstrumentStmt.execute();
            connection.commit();
        }
        catch(SQLException sqle){
            handleException(failureMsg, sqle);
        }
        
    }
    /**
     * Terminate rental It shall be possible to terminate an ongoing rental. 
     * You are free to decide how the user specifies which rental to terminate. 
     * You are not allowed to delete all information about a terminated rental from the database. 
     * Instead, the database must still contain all information about the rental, 
     * but also show that the rental has been terminated.
     * @param studentID
     * @param instrument
     */
    public void endRental(int studentID, int instrumentID) throws SQLException, SGDBException{
        String failureMsg = "Failed to end rental";
        try{
            archiveRental(instrumentID);
            endRentalStmt.setInt(1, instrumentID);
            endRentalStmt.executeUpdate();
            connection.commit();
            System.out.println("Succeeded in ending rental for student-ID " + studentID + ", instrument-ID: " + instrumentID);
        }catch(SQLException sqle){
            handleException(failureMsg, sqle);
        }
    }

    public boolean checkIfAllowed(int studentID) throws SQLException{
        int rentals = 0;
        getNumberOfRentalsStmt.setInt(1, studentID);;
        ResultSet res = getNumberOfRentalsStmt.executeQuery();
        if(res.next()){
            rentals = res.getInt(1);
        }
        return rentals < 2;
    }
    public boolean checkIfRented(int instrumentID) throws SQLException{
        boolean rented = false;
        getIsRentedStmt.setInt(1,instrumentID);
        ResultSet res = getIsRentedStmt.executeQuery();
        if(res.next()){
            if(res.getInt(1) != 0) rented = true;
        }
        return rented;
    }
    public void archiveRental(int id) throws SQLException{
        archiveRentalStmt.setInt(1, id);
        archiveRentalStmt.executeUpdate();
        connection.commit();
    }
    /**
     * Commits the current transaction.
     * 
     * @throws SGDBException If unable to commit the current transaction.
     */
    public void commit() throws SGDBException {
        try {
            connection.commit();
        } catch (SQLException e) {
            handleException("Failed to commit", e);
        }
    }

    private void connectToBankDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sgdb2",
                                                 "postgres", "skinka");
        // connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb",
        //                                          "mysql", "mysql");
        connection.setAutoCommit(false);
    }
    private void prepareStatements() throws SQLException {
        getInstrumentListStmt = connection.prepareStatement("SELECT * FROM instrument_for_rent "
        + "WHERE name_of_instrument=? AND student_id='0'");
        insertInstrumentStmt = connection.prepareStatement("INSERT INTO instrument_for_rent VALUES('null',?,?,?,?)");
        getNumberOfRentalsStmt = connection.prepareStatement("SELECT COUNT(*) FROM instrument_for_rent WHERE student_id=?");
        updateInstrumentStmt = connection.prepareStatement("UPDATE instrument_for_rent SET student_id=?, date=? WHERE id=?");
        getIsRentedStmt = connection.prepareStatement("SELECT student_id FROM instrument_for_rent WHERE id=?");
        endRentalStmt = connection.prepareStatement("UPDATE instrument_for_rent SET student_id='0', date=null WHERE id=?");
        archiveRentalStmt = connection.prepareStatement("INSERT INTO rental_archive SELECT id, student_id, name_of_instrument, cost, date FROM instrument_for_rent WHERE id=?");
    }
    private void handleException(String failureMsg, Exception cause) throws SGDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg + 
            ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new SGDBException(failureMsg, cause);
        } else {
            throw new SGDBException(failureMsg);
        }
    }
    private void closeResultSet(String failureMsg, ResultSet result) throws SGDBException
    {
        try
        {
            result.close();
        } catch (SQLException e)
        {
            throw new SGDBException(failureMsg + " Could not close result set.", e);
        }
    }
}
