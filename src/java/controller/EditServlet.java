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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import model.AccInfo;
import model.Account;

/**
 *
 * @author lvhn1
 */
@WebServlet(name="EditServlet", urlPatterns={"/edit"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class EditServlet extends HttpServlet {
   
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
            out.println("<title>Servlet EditServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditServlet at " + request.getContextPath () + "</h1>");
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
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        AccountDAO db = new AccountDAO();
        
        HttpSession session = request.getSession();
        
        Account mainAcc = (Account) session.getAttribute("acc");
        AccInfo main_info = db.getAccInfo(mainAcc);
        
        MusicDAO mdb = new MusicDAO();
        request.setAttribute("genres", mdb.listGenre());
        request.setAttribute("track", mdb.getTrack(id));
        request.setAttribute("fArtist", mdb.getfArtist(id, mainAcc.getUsername()));
        
        request.setAttribute("main_info", main_info);
        request.getRequestDispatcher("edit.jsp").forward(request, response);
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
        int id = Integer.parseInt(request.getParameter("trackid"));
        String title = request.getParameter("title");
        String genre_raw = request.getParameter("genre");
        String artists = request.getParameter("listArtist");
        String coverURL_raw = request.getParameter("coverURL");
        
        int genreID;
        try {
            genreID = Integer.parseInt(genre_raw);
        } catch (NumberFormatException e) {
            genreID = 0;
        }
        
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        
        if (!artists.trim().equals(""))
            artists = ", " + artists;
        artists = acc.getUsername() + artists;
        
        Part fileCover = request.getPart("cover");
        
        String uploadPath = request.getServletContext().getRealPath("") + "user-data\\" + genreID + "\\";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) 
            uploadDir.mkdir();
        
        String fileName = artists + " - " + title;
        String coverURL = "";
        
        if (fileCover.getSize() != 0) {
            fileCover.write(uploadPath + fileName + "_cover.png");
            coverURL = "./user-data/" + genreID + "/" + fileName + "_cover.png";
        } else {
            coverURL = coverURL_raw;
        }
        
        MusicDAO mdb = new MusicDAO();
        mdb.updateTrack(id, title, genreID, artists, coverURL);
        
        response.sendRedirect("home");
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
