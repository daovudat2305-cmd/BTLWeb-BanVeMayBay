/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.FlightDAO;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "SearchFlightServlet", urlPatterns = {"/SearchFlightServlet"})
public class UserSearchFlightServlet extends HttpServlet{
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    String depCode = request.getParameter("depCode");
    String destCode = request.getParameter("destCode");
    
    String[] selectedAirlines = request.getParameterValues("airline");

    FlightDAO dao = new FlightDAO();
    List<Flight> list = dao.searchWithFilter(depCode, destCode, selectedAirlines);

 
    request.setAttribute("outboundList", list);
    
    request.setAttribute("oldDep", depCode);
    request.setAttribute("oldDest", destCode);
    request.setAttribute("selectedAirlines", selectedAirlines); 
    request.getRequestDispatcher("flight_list.jsp").forward(request, response);
    }
}
