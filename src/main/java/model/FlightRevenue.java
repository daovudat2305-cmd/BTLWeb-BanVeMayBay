package model;

public class FlightRevenue {
	private Flight flight;
	private int ticketsSold;
	private double totalRevenue;
	
	public FlightRevenue() {}
	
	public FlightRevenue(Flight flight, int ticketsSold, double totalRevenue) {
		super();
		this.flight = flight;
		this.ticketsSold = ticketsSold;
		this.totalRevenue = totalRevenue;
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

	public int getTicketsSold() {
		return ticketsSold;
	}

	public void setTicketsSold(int ticketsSold) {
		this.ticketsSold = ticketsSold;
	}

	public double getTotalRevenue() {
		return totalRevenue;
	}

	public void setTotalRevenue(double totalRevenue) {
		this.totalRevenue = totalRevenue;
	}
	
}
