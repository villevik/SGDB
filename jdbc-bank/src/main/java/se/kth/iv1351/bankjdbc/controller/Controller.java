/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package se.kth.iv1351.bankjdbc.controller;
import java.sql.SQLException;

import java.util.List;



import se.kth.iv1351.bankjdbc.model.InstrumentDTO;
import se.kth.iv1351.bankjdbc.model.InstrumentException;


import se.kth.iv1351.bankjdbc.integration.SGDBException;
import se.kth.iv1351.bankjdbc.integration.SgDAO;


/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */
public class Controller {
    //private final BankDAO bankDb;
    private final SgDAO sgDb;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     * 
     * @throws SGDBException If unable to connect to the database.
     */
    public Controller() throws SGDBException {

        sgDb = new SgDAO();
    }
    public List<? extends InstrumentDTO> getInstrumentList(String kind) throws InstrumentException {
        String failureMsg = "Unable to find list for: " + kind;
        try
        {
            return sgDb.listInstruments(kind);
        } catch (SQLException | SGDBException e)
        {
            throw new InstrumentException(failureMsg, e);
        }
    }
    public String rentInstrument(int studentID, int instrumentID){
        String msg = "Fail!";
        try{
            sgDb.rentInstrument(studentID, instrumentID);
            msg = "Succeeded!";
        }catch(Exception e){
            System.out.println(e);
        }
        return msg;
    }
    public void endRental(int studentID, int instrumentID) throws InstrumentException{
        String failureMsg = "Unable to end rental for: " + instrumentID;
        try{
            sgDb.endRental(studentID, instrumentID);
        }
        catch(SQLException | SGDBException e)
        {
            throw new InstrumentException(failureMsg, e);
        }
    }
    public void newInstrument(int id, String name, String brand, int quantity) throws InstrumentException{
        String failureMsg = "Unable to insert instrument";
        try{
            sgDb.newInstrument(id, name, brand, quantity);
        }
        catch(SQLException | SGDBException e){
            throw new InstrumentException(failureMsg, e);
        }
    }
}
