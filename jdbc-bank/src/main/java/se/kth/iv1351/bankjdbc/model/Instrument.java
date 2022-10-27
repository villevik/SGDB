package se.kth.iv1351.bankjdbc.model;

public class Instrument implements InstrumentDTO{
    private final String name;
    private final String brand;
    private final int id;
    private final double cost;
    private boolean isRented;
    public Instrument(int id, String name, String brand,  double cost, int student_id){
        
        this.name = name;
        this.brand = brand;
        this.id = id;
        this.cost = cost;
        if(student_id == 0) this.isRented = false;
        else this.isRented = true;

    }
    public Instrument(int id, String name){
        this.id = id;
        this.name = name;
        this.brand = "no brand";
        this.cost = 0;
        this.isRented = false;
    }
    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Name: " + name);

        sb.append(", Brand: " + brand);
        sb.append(", id: " + id);
        sb.append(", cost: " + cost);
        sb.append(", is rented: " + isRented);
        return sb.toString();
    }
    public String getName(){
        return name;
    }

    public String getBrand(){
        return brand;
    }
    public int getID(){
        return id;
    }
    public double getCost(){
        return cost;
    }
    public boolean isRented(){
        return isRented;
    }
}
