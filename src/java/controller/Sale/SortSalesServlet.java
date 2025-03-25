/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Sale;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import model.Sales;
import model.SalesDB;
import model.Users;

/**
 *
 * @author ACER
 */
@WebServlet(name = "SortSalesServlet", urlPatterns = {"/SortSalesServlet"})
public class SortSalesServlet extends HttpServlet {

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
            out.println("<title>Servlet SortSalesServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SortSalesServlet at " + request.getContextPath() + "</h1>");
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
        Users user = (Users) request.getSession().getAttribute("user");
        ArrayList<Sales> listSale;
        // Định nghĩa thứ tự trạng thái mong muốn
        List<String> statusOrder = Arrays.asList("Pending", "Completed", "Pending Refund", "Refunded", "Cancelled");

        if (user.isAdmin()) {
            listSale = (ArrayList) SalesDB.listAllSales();
            // Sắp xếp danh sách theo thứ tự trạng thái
            listSale.sort(Comparator.comparing(Sales::getStatus, (status1, status2) -> {
                return Integer.compare(statusOrder.indexOf(status1), statusOrder.indexOf(status2));
            }));
            request.getSession().setAttribute("listSale", listSale);
            request.getRequestDispatcher("/sales/saleHistoryForAdmin.jsp").forward(request, response);
        } else {
            listSale = (ArrayList) SalesDB.getListSaleByID(user.getUserID());
            // Sắp xếp danh sách theo thứ tự trạng thái
            listSale.sort(Comparator.comparing(Sales::getStatus, (status1, status2) -> {
                return Integer.compare(statusOrder.indexOf(status1), statusOrder.indexOf(status2));
            }));
            request.getSession().setAttribute("listSale", listSale);
            request.getRequestDispatcher("/sales/saleHistoryForUser.jsp").forward(request, response);
        }
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
