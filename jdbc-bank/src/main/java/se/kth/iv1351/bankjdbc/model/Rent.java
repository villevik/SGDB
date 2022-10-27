package se.kth.iv1351.bankjdbc.model;

import java.sql.Date;

public class Rent implements RentDTO{
    private final int instrument_id;
    private final int studentID;
    private final String studentName;
    private final String instrument_name;
    private final Date date;

    public Rent(int instrument_id, int studentID, String studentName, String instrument_name, Date date){
        this.instrument_id = instrument_id;
        this.studentID = studentID;
        this.studentName = studentName;
        this.instrument_name = instrument_name;
        this.date = date;
    }

    public int getInstrument_id(){
        return instrument_id;
    }

    public int getStudentID(){
        return studentID;
    }
    public String getStudentName(){
        return studentName;
    }
    public String getInstrument_name(){
        return instrument_name;
    }
    public Date getDate(){
        return date;
    }
}
