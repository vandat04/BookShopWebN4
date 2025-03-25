package controller.User;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;
import model.UsersDB;

/**
 *
 * @author ACER
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        String username = request.getParameter("username");
        String pass_raw = request.getParameter("password");
        String save = request.getParameter("savePass");
        Users user = null;
        //Lay password real
        user = UsersDB.validateLogin(username, pass_raw);
        if (user != null && username != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            Cookie cusername;
            Cookie cpass;
            Cookie csave;
            if (save != null && save.equals("true")) {
                cusername = new Cookie("username", username);
                cpass = new Cookie("pass", pass_raw);
                csave = new Cookie("save", "checked");
            } else {
                cusername = new Cookie("username", "");
                cpass = new Cookie("pass", "");
                csave = new Cookie("save", "");
            }
            cusername.setMaxAge(24 * 60 * 60);
            cpass.setMaxAge(24 * 60 * 60);
            csave.setMaxAge(24 * 60 * 60);

            response.addCookie(csave);
            response.addCookie(cpass);
            response.addCookie(cusername);

            request.getSession().setAttribute("user", user);
            if (user.isAdmin()) {
                //chuyen den giao dien cho admin
                request.getRequestDispatcher("/includes/homeForAdmin.jsp").forward(request, response);
            } else {
                //chuyen den giao dien cho user
                request.getRequestDispatcher("/includes/homeForUser.jsp").forward(request, response);
            }
            //chuyen trang:
        } else {
            request.getRequestDispatcher("/users/login.jsp?loginErr=1").forward(request, response);
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
