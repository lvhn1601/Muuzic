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
import model.Track;

/**
 *
 * @author lvhn1
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO db = new AccountDAO();
        HttpSession session = request.getSession();
        Account mainAcc = (Account) session.getAttribute("acc");
        AccInfo main_info = db.getAccInfo(mainAcc);
        request.setAttribute("main_info", main_info);

        MusicDAO mdb = new MusicDAO();
        request.setAttribute("listNewest", mdb.listFollowNewest(mainAcc.getUsername()));
        request.setAttribute("listRecently", mdb.listRecently(mainAcc.getUsername()));
        request.setAttribute("listTop", mdb.listTop());
        
        request.setAttribute("listAcc", db.recommendAcc(mainAcc.getUsername()));
        
        String recGenre = mdb.getRecGenre(mainAcc.getUsername());
        if (recGenre == null)
            recGenre = "Pop";
        request.setAttribute("recGenre", recGenre);
        request.setAttribute("listTopGen", mdb.listTop(recGenre, 10));

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

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
