/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ACER
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SalesDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public static Sales getSale(int saleID) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Sales WHERE SaleID = ?");
            stmt.setInt(1, saleID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Sales(
                        rs.getInt("SaleID"),
                        rs.getInt("UserID"),
                        rs.getInt("BookID"),
                        rs.getDate("SaleDate"),
                        rs.getInt("Quantity"),
                        rs.getDouble("TotalPrice"),
                        rs.getString("Status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(SalesDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static List<Sales> getListSaleByID(int userID) {
    List<Sales> saleList = new ArrayList<>();
    try (Connection con = getConnect()) {
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM Sales WHERE UserID = ?");
        stmt.setInt(1, userID);
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            Sales sale = new Sales(
                    rs.getInt("SaleID"),
                    rs.getInt("UserID"),
                    rs.getInt("BookID"),
                    rs.getDate("SaleDate"),
                    rs.getInt("Quantity"),
                    rs.getDouble("TotalPrice"),
                    rs.getString("Status")
            );
            saleList.add(sale);
        }
    } catch (SQLException ex) {
        Logger.getLogger(SalesDB.class.getName()).log(Level.SEVERE, null, ex);
    }
    return saleList;
}
    
    public static ArrayList<Sales> listAllSales() {
        ArrayList<Sales> list = new ArrayList<>();
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Sales");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Sales(
                        rs.getInt("SaleID"),
                        rs.getInt("UserID"),
                        rs.getInt("BookID"),
                        rs.getTimestamp("SaleDate"),
                        rs.getInt("Quantity"),
                        rs.getDouble("TotalPrice"),
                        rs.getString("Status")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SalesDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Thêm đơn hàng, nếu cập nhật kho thất bại thì xóa đơn hàng vừa thêm
    public static boolean addSale(int userID, int bookID, int quantity, double totalPrice) {
        String query = "INSERT INTO Sales (UserID, BookID, Quantity, TotalPrice) VALUES (?, ?, ?, ?)";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ps.setInt(3, quantity);
            ps.setDouble(4, totalPrice);

            int result = ps.executeUpdate();
            if (result > 0) {
                // Lấy SaleID vừa tạo
                ResultSet rs = ps.getGeneratedKeys();
                int saleID = -1;
                if (rs.next()) {
                    saleID = rs.getInt(1);
                }

                // Cập nhật kho sách
                if (!updateBookStock(bookID, quantity)) {
                    deleteSale(saleID); // Xóa đơn hàng nếu cập nhật kho thất bại
                    return false;
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật số lượng sách khi có đơn hàng mới
    public static boolean updateBookStock(int bookID, int quantity) {
        String query = "UPDATE Books SET AvailableCopies = AvailableCopies - ? WHERE BookID = ? AND AvailableCopies >= ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, quantity);
            ps.setInt(2, bookID);
            ps.setInt(3, quantity);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa đơn hàng khi cần rollback (nếu cập nhật kho thất bại)
    public static void deleteSale(int saleID) {
        String query = "DELETE FROM Sales WHERE SaleID = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, saleID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Hủy đơn hàng và hoàn lại số lượng sách
    public static boolean cancelSale(int saleID, int bookID, int quantity) {
        String query = "DELETE FROM Sales WHERE SaleID = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, saleID);
            int result = ps.executeUpdate();

            if (result > 0) {
                return restoreBookStock(bookID, quantity); // Hoàn lại số sách
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hoàn lại số lượng sách khi hủy đơn hàng
    public static boolean restoreBookStock(int bookID, int quantity) {
        String query = "UPDATE Books SET AvailableCopies = AvailableCopies + ? WHERE BookID = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, quantity);
            ps.setInt(2, bookID);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updateSaleStatus(int saleID, String newStatus) {
        String query = "UPDATE Sales SET Status = ? WHERE SaleID = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, newStatus);
            ps.setInt(2, saleID);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {

        System.out.println(getListSaleByID(5));

    }
}
