/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;


import java.math.BigDecimal;

import model.DAO;
import entity.Game;
import java.io.IOException;
import java.sql.Date;
    
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AddGames", urlPatterns = {"/AddGames"})
public class AddGames extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddGames</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddGames at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
       try {
            // Lấy dữ liệu từ form
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            Date releaseDate = Date.valueOf(request.getParameter("releaseDate"));
            String developer = request.getParameter("developer");
            String publisher = request.getParameter("publisher");
            String genre = request.getParameter("genre");
            String platform = request.getParameter("platform");
            int stock = Integer.parseInt(request.getParameter("stock"));
            String imageUrl = request.getParameter("imageUrl"); // 🖼️ Lấy đường dẫn hình ảnh từ form

            // Tạo đối tượng Game mới
            Game newGame = new Game(0, title, description, price, releaseDate, developer, publisher, genre, platform, stock, null, imageUrl);

            // Gọi DAO để thêm game vào database
            DAO.addGame(newGame);

            // Chuyển hướng về trang quản lý game
            response.sendRedirect("managerGames.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("managerGames.jsp?error=1");
        }
    
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
