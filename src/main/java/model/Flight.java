package model;

import java.sql.Timestamp;

public class Flight {
	private String flightId;
    private String airlineName;
    private String departureAirport;
    private String destinationAirport;  
    private Timestamp departureTime;
    private Timestamp arrivalTime;
    private double price;
    private int availableSeats;

    private String departureAirportName;
    private String destinationAirportName;

    public Flight(String flightId, String airlineName, String departureAirport, String destinationAirport,
                  Timestamp departureTime, Timestamp arrivalTime, double price, int availableSeats,
                  String departureAirportName, String destinationAirportName) {
        this.flightId = flightId;
        this.airlineName = airlineName;
        this.departureAirport = departureAirport;
        this.destinationAirport = destinationAirport;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.price = price;
        this.availableSeats = availableSeats;
        
        this.departureAirportName = cleanAirportName(departureAirportName);
        this.destinationAirportName = cleanAirportName(destinationAirportName);
    }

    // --- CÁC HÀM GETTER VÀ SETTER ---
    public String getFlightId() { return flightId; }
    public void setFlightId(String flightId) { this.flightId = flightId; }

    public String getAirlineName() { return airlineName; }
    public void setAirlineName(String airlineName) { this.airlineName = airlineName; }

    public String getDepartureAirport() { return departureAirport; }
    public void setDepartureAirport(String departureAirport) { this.departureAirport = departureAirport; }

    public String getDestinationAirport() { return destinationAirport; }
    public void setDestinationAirport(String destinationAirport) { this.destinationAirport = destinationAirport; }

    public Timestamp getDepartureTime() { return departureTime; }
    public void setDepartureTime(Timestamp departureTime) { this.departureTime = departureTime; }
    
    public Timestamp getArrivalTime() { return arrivalTime; }
	public void setArrivalTime(Timestamp arrivalTime) { this.arrivalTime = arrivalTime; }

	public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }
    
    public String getDepartureAirportName() { return departureAirportName; }
    public void setDepartureAirportName(String departureAirportName) { this.departureAirportName = departureAirportName; }
    
    public String getDestinationAirportName() { return destinationAirportName; }
    public void setDestinationAirportName(String destinationAirportName) { this.destinationAirportName = destinationAirportName; }
    
    // lược bỏ phần sân bay
    private String cleanAirportName(String fullName) {
        if (fullName == null) {
            return null;
        }
        // Xóa cụm dài trước, cụm ngắn sau để tránh bị sót chữ "quốc tế"
        return fullName.replace("Sân bay quốc tế ", "")
                       .replace("Sân bay ", "");
    }
}
