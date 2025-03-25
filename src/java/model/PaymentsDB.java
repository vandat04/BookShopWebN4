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

public class PaymentsDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public static boolean addPayment(int saleID, int userID, double amount, String status) {
        String query = "INSERT INTO Payments (SaleID, UserID, Amount, Status) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, saleID);
            ps.setInt(2, userID);
            ps.setDouble(3, amount);
            ps.setString(4, status);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updatePaymentStatus(int paymentID, String status) {
        String query = "UPDATE Payments SET Status = ? WHERE PaymentID = ?";
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, paymentID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static ArrayList<String> listAllPayments() {
        ArrayList<String> list = new ArrayList<>();
        String query = "SELECT PaymentID, SaleID, UserID, Amount, PaymentDate, Status FROM Payments";
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add("PaymentID: " + rs.getInt("PaymentID") + ", SaleID: " + rs.getInt("SaleID") +
                        ", UserID: " + rs.getInt("UserID") + ", Amount: " + rs.getDouble("Amount") +
                        ", Date: " + rs.getTimestamp("PaymentDate") + ", Status: " + rs.getString("Status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        System.out.println(listAllPayments());
    }
}