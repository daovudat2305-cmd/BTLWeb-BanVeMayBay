package model;

import java.sql.Timestamp;

public class Booking {
    private String bookingId;
    private String username;
    private String flightId;
    private String passengerName;
    private String cccd;
    private String phone;
    private String email;
    private Timestamp bookingTime;
    private String status;
    private String returnFlightId;
    private Flight flight;

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFlightId() {
        return flightId;
    }

    public void setFlightId(String flightId) {
        this.flightId = flightId;
    }

    public String getPassengerName() {
        return passengerName;
    }

    public void setPassengerName(String passengerName) {
        this.passengerName = passengerName;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(Timestamp bookingTime) {
        this.bookingTime = bookingTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReturnFlightId() {
        return returnFlightId;
    }

    public void setReturnFlightId(String returnFlightId) {
        this.returnFlightId = returnFlightId;
    }

    public Flight getFlight() {
        return flight;
    }

    public void setFlight(Flight flight) {
        this.flight = flight;
    }

    public boolean isUpcoming() {
        return flight != null
            && flight.getDepartureTime() != null
            && flight.getDepartureTime().after(new Timestamp(System.currentTimeMillis()));
    }

    public boolean isCompleted() {
        return flight != null
            && flight.getDepartureTime() != null
            && !isUpcoming();
    }
}
