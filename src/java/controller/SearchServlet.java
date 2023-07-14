/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AccountDAO;
import dal.MusicDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.AccInfo;
import model.Account;
import model.Genre;
import model.Track;

/**
 *
 * @author lvhn1
 */
@WebServlet(name="SearchServlet", urlPatterns={"/search"})
public class SearchServlet extends HttpServlet {
   
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
            out.println("<title>Servlet SearchServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchServlet at " + request.getContextPath () + "</h1>");
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
        HttpSession session = request.getSession();
        
        Account mainAcc = (Account) session.getAttribute("acc");
        
        if (mainAcc != null) {
            AccInfo main_info = db.getAccInfo(mainAcc);
            request.setAttribute("main_info", main_info);
            Cookie[] cookies = request.getCookies();

            List<Track> listTracks = new ArrayList<>();
            for (Cookie c : cookies) {
                if (c.getName().equalsIgnoreCase(mainAcc.getUsername())) {
                    String ids[] = c.getValue().split("/");
                    for (String id_raw : ids) {
                        int id = Integer.parseInt(id_raw);
                        Track track = mdb.getTrack(id);
                        if (track != null)
                            listTracks.add(track);
                    }
                }
            }
            request.setAttribute("playedTrack", listTracks);
        }
        
        List<Genre> listGen = mdb.listGenre();
        request.setAttribute("listGen", listGen);
        
        request.getRequestDispatcher("search.jsp").forward(request, response);
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
        String search = request.getParameter("search");
        int genId = Integer.parseInt(request.getParameter("eGenre"));
        String order = request.getParameter("eOrder");
        String arr = request.getParameter("eArr");
        
        AccountDAO db = new AccountDAO();
        MusicDAO mdb = new MusicDAO();
        
        List<AccInfo> listArtist = db.searchArtist(search, genId);
        List<Track> listTrack = mdb.searchTrack(search, genId, order, arr);
        
        request.setAttribute("searchText", search);
        request.setAttribute("searchArtist", listArtist);
        request.setAttribute("searchTrack", listTrack);
        doGet(request, response);
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
