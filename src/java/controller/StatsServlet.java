/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.AccountDAO;
import dal.MusicDAO;
import dal.StatsDAO;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.AccInfo;
import model.Account;
import model.Track;

/**
 *
 * @author lvhn1
 */
@WebServlet(name="StatsServlet", urlPatterns={"/stats"})
public class StatsServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StatsServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StatsServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        AccountDAO db = new AccountDAO();
        MusicDAO mdb = new MusicDAO();
        
        Account acc = (Account) request.getSession().getAttribute("acc");
        AccInfo info = db.getAccInfo(acc);
        
        List<Track> listTrack = mdb.getListTrack(acc.getUsername());
        
        request.setAttribute("main_info", info);
        request.setAttribute("listTrack", listTrack);
        
        int trackID = 0;
        if (request.getParameter("trackid") != null)
            trackID = Integer.parseInt(request.getParameter("trackid"));
        
        // Get Stream numbers chart
        Gson gsonObj = new Gson();
        Map<Object, Object> map = null;
        List<Map<Object,Object>> list = new ArrayList<>();
        
        StatsDAO sdb = new StatsDAO();
        
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        LocalDateTime now = LocalDateTime.now();
        
        for (int i=6; i>=0; i--) {
            String date = dtf.format(now.minusDays(i));
            
            map = new HashMap<>(); 
            map.put("label", date.substring(5));
            map.put("y", trackID == 0 ? sdb.getNumInDate(date, acc.getUsername()) : sdb.getNumInDate(date, trackID)); 
            list.add(map);
        }
        
        String streamPoints = gsonObj.toJson(list);
        
        request.setAttribute("streamPoints", streamPoints);
        
        //Get top fan stream chart
        gsonObj = new Gson();
        map = null;
        list = new ArrayList<>();
        
        List<String> listFan = sdb.getTopFan(acc.getUsername(), trackID);
        for (int i=listFan.size()-1; i>=0; i--) {
            map = new HashMap<>(); 
            map.put("label", listFan.get(i)); 
            map.put("y", sdb.getNumOfFan(acc.getUsername(), listFan.get(i), trackID)); 
            list.add(map);
        }
        
        String fanPoints = gsonObj.toJson(list);
        
        request.setAttribute("fanPoints", fanPoints);
        
        //Get each track stream numbers chart
        gsonObj = new Gson();
        map = null;
        list = new ArrayList<>();
        
        for (Track track : listTrack) {
            map = new HashMap<>(); 
            map.put("label", track.getTitle()); 
            map.put("y", sdb.getTotalNum(track.getId())); 
            list.add(map);
        }
        
        String trackPoints = gsonObj.toJson(list);
        
        request.setAttribute("trackPoints", trackPoints);
        
        if (trackID != 0) {
            Track track = mdb.getTrack(trackID);
            request.setAttribute("recent", track.getTitle());
        } else {
            request.setAttribute("recent", "all tracks");
        }
        
        request.getRequestDispatcher("stats.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
        //request.getRequestDispatcher("stats.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
