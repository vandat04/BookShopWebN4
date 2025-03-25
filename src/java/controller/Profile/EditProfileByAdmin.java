/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Profile;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Users;
import model.UsersDB;

/**
 *
 * @author ACER
 */
@WebServlet(name = "EditProfileByAdmin", urlPatterns = {"/EditProfileByAdmin"})
public class EditProfileByAdmin extends HttpServlet {

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
            out.println("<title>Servlet EditProfileByAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProfileByAdmin at " + request.getContextPath() + "</h1>");
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
        //<a href="${pageContext.request.contextPath}/EditProfileByAdmin?userID=${user.userID}&adminID=${sessionScope.user.userID}" 
        //class="btn btn-success btn-sm" style="white-space: nowrap;">Sửa</a>
        String userID = request.getParameter("userID");
        request.setAttribute("userNeedToEdit", UsersDB.getUserByID(Integer.parseInt(userID)));
        String adminID = request.getParameter("adminID");
        request.setAttribute("user", UsersDB.getUserByID(Integer.parseInt(adminID)));
        request.getRequestDispatcher("/profile/updateProfileByAdmin.jsp").forward(request, response);
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
        String type = request.getParameter("type");
        String adminID = request.getParameter("adminID");
        String userID = request.getParameter("userID");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        java.sql.Date dateOfBirth = null;
        if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
            try {
                dateOfBirth = java.sql.Date.valueOf(dateOfBirthStr);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Định dạng ngày sinh không hợp lệ.");
            }
        }

        switch (type) {
            case "delete":
                UsersDB.deleteUserByID(Integer.parseInt(userID));
                break;
            case "isadmin":
                UsersDB.updateIsAdmin(Integer.parseInt(userID), Boolean.parseBoolean(request.getParameter("adminAccept")));
                break;
            case "edit":
                UsersDB.updateUser(Integer.parseInt(userID), password, fullName, email, phone, address, dateOfBirth);
                request.setAttribute("userNeedToEdit", UsersDB.getUserByID(Integer.parseInt(userID)));
                request.getRequestDispatcher("/profile/updateProfileByAdmin.jsp").forward(request, response);
                break;
            default:
                break;
        }

        // Cập nhật danh sách người dùng và quay lại editProfileByAdmin.jsp
        ArrayList<Users> userList = (ArrayList<Users>) UsersDB.allListUsers();
        request.getSession().setAttribute("listUser", userList); // Đặt danh sách vào session scope
        request.getRequestDispatcher("/profile/editProfileByAdmin.jsp").forward(request, response);
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
