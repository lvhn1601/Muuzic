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
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import model.AccInfo;
import model.Account;
import model.Track;

/**
 *
 * @author lvhn1
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
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
        MusicDAO mdb = new MusicDAO();
        HttpSession session = request.getSession();

        Account acc = db.getAccount(request.getParameter("id"));
        AccInfo accInfo = db.getAccInfo(acc);

        Account mainAcc = (Account) session.getAttribute("acc");
        if (mainAcc != null) {
            AccInfo main_info = db.getAccInfo(mainAcc);
            request.setAttribute("main_info", main_info);
            request.setAttribute("isFollowing", db.checkFollow(mainAcc.getUsername(), acc.getUsername()));
        }
        request.setAttribute("acc_info", accInfo);

        List<Track> spotlight = mdb.getListTrack(request.getParameter("id"));
        List<Track> recent = mdb.listRecently(request.getParameter("id"));
        request.setAttribute("spotlight", spotlight);
        request.setAttribute("recent", recent);

        int count[] = {
            db.countFollower(request.getParameter("id")),
            db.countFollowing(request.getParameter("id")),
            db.countTracks(request.getParameter("id"))
        };
        request.setAttribute("count", count);

        if (mainAcc != null) {
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

        request.getRequestDispatcher("profile.jsp").forward(request, response);
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

        String dName = request.getParameter("displayName");
        String fName = request.getParameter("fName");
        String lName = request.getParameter("lName");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String bio = request.getParameter("bio");

        AccountDAO db = new AccountDAO();

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");

        Part fileAvatar = request.getPart("avatar");
        Part fileWallpaper = request.getPart("wallpaper");

        String uploadPath = request.getServletContext().getRealPath("") + "user-data\\" + acc.getUsername() + "\\";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        if (fileAvatar.getSize() != 0) {
            fileAvatar.write(uploadPath + "avatar.png");
            db.editAccImg(acc, "avatar_url", "./user-data/" + acc.getUsername() + "/avatar.png");
        }
        if (fileWallpaper.getSize() != 0) {
            fileWallpaper.write(uploadPath + "wallpaper.png");
            db.editAccImg(acc, "wallpaper_url", "./user-data/" + acc.getUsername() + "/wallpaper.png");
        }

        db.editAccount(acc, dName, fName, lName, city, country, bio);
        response.sendRedirect("profile?id=" + acc.getUsername());
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
