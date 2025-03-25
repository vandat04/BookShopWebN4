/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Product;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Books;
import model.BooksDB;
import model.SalesDB;
import model.Users;
import model.UsersDB;

/**
 *
 * @author ACER
 */
@WebServlet(name = "AddToCardServlet", urlPatterns = {"/AddToCardServlet"})
public class AddToCardServlet extends HttpServlet {

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
            out.println("<title>Servlet BuyBookServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuyBookServlet at " + request.getContextPath() + "</h1>");
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

        String userID = request.getParameter("userID");
        String bookID = request.getParameter("bookID");
        String number = request.getParameter("numberOfBook");
        // Kiểm tra number có giá trị và là số hợp lệ
        int numberOfBooks;
        try {
            numberOfBooks = Integer.parseInt(number);
            if (numberOfBooks <= 0) {
                request.setAttribute("err", "1");
                request.getRequestDispatcher("detailProductForUser.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("err", "1");
            request.getRequestDispatcher("detailProductForUser.jsp").forward(request, response);
            return;
        }
        //Tính tiền sách
        Books book = BooksDB.getBookByID(Integer.parseInt(bookID));
        Double total = book.getPrice() * numberOfBooks;
        //Add vô giỏ hàng
        boolean newSale = SalesDB.addSale(Integer.parseInt(userID), Integer.parseInt(bookID), numberOfBooks, total);
        //Cập nhật lại thông tin sách để hiển thị thay đổi
        Users user = UsersDB.getUserByID(Integer.parseInt(userID));
        book = BooksDB.getBookByID(Integer.parseInt(bookID));
        //Gửi thông tin qua cho jsp làm việc
        request.getSession().setAttribute("bookDetailForUser", book);
        request.getSession().setAttribute("user", user);
        if (!newSale) {
            request.setAttribute("err", "1");
        } else {
            request.setAttribute("err", "0");
        }
        
        request.getRequestDispatcher("/product/detailProduct.jsp").forward(request, response);
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
