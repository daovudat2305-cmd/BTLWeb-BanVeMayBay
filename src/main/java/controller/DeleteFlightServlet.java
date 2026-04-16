/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.FlightDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Flight;

/**
 *
 * @author phant
 */
@WebServlet(urlPatterns = {"/DeleteFlightServlet"})
public class DeleteFlightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try{
            String flightId = request.getParameter("id");
            if (flightId != null && !flightId.trim().isEmpty()) {
            
            FlightDAO dao = new FlightDAO();
            boolean success = dao.deleteFlight(flightId);
            
            if (success) {
                response.sendRedirect("adminFlights?msg=delete_success");
            } else {
                response.sendRedirect("adminFlights?msg=delete_error");
            }
        } else {
            response.sendRedirect("adminFlights?msg=error");
            }
        }
        catch(Exception e){
            e.getStackTrace();
        }
    }
}
