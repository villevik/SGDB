package se.kth.iv1351.bankjdbc.model;
import java.sql.Date;
public interface RentDTO {
    public int getInstrument_id();
    public int getStudentID();
    public String getStudentName();
    public String getInstrument_name();
    public Date getDate();
}
