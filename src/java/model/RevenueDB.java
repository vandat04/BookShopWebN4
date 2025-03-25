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
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.SQLException;

public class RevenueDB implements DatabaseInfo {

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

    public static Revenue getRevenue(Date revenueDate) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT TotalSales, TotalRevenue FROM Revenue WHERE RevenueDate=?");
            stmt.setDate(1, revenueDate);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int totalSales = rs.getInt(1);
                double totalRevenue = rs.getDouble(2);
                return new Revenue(revenueDate, totalSales, totalRevenue);
            }
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(RevenueDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static ArrayList<Revenue> listAll() {
        ArrayList<Revenue> list = new ArrayList<>();
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT RevenueDate, TotalSales, TotalRevenue FROM Revenue");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Revenue(
                        rs.getDate(1),
                        rs.getInt(2),
                        rs.getDouble(3)));
            }
            con.close();
            return list;
        } catch (Exception ex) {
            Logger.getLogger(RevenueDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static boolean increaseRevenue(Date revenueDate, int salesIncrease, double revenueIncrease) {
        try (Connection con = getConnect()) {
            // Kiểm tra xem ngày này đã có trong bảng chưa
            PreparedStatement checkStmt = con.prepareStatement("SELECT TotalSales, TotalRevenue FROM Revenue WHERE RevenueDate = ?");
            checkStmt.setDate(1, revenueDate);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Ngày đã tồn tại -> Cập nhật giá trị mới
                int updatedSales = rs.getInt("TotalSales") + salesIncrease;
                double updatedRevenue = rs.getDouble("TotalRevenue") + revenueIncrease;

                PreparedStatement updateStmt = con.prepareStatement("UPDATE Revenue SET TotalSales = ?, TotalRevenue = ? WHERE RevenueDate = ?");
                updateStmt.setInt(1, updatedSales);
                updateStmt.setDouble(2, updatedRevenue);
                updateStmt.setDate(3, revenueDate);

                int rows = updateStmt.executeUpdate();
                return rows > 0;
            } else {
                // Ngày chưa tồn tại -> Thêm mới
                PreparedStatement insertStmt = con.prepareStatement("INSERT INTO Revenue (RevenueDate, TotalSales, TotalRevenue) VALUES (?, ?, ?)");
                insertStmt.setDate(1, revenueDate);
                insertStmt.setInt(2, salesIncrease);
                insertStmt.setDouble(3, revenueIncrease);

                int rows = insertStmt.executeUpdate();
                return rows > 0;
            }
        } catch (Exception ex) {
            Logger.getLogger(RevenueDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean decreaseRevenue(Date revenueDate, int salesDecrease, double revenueDecrease) {
        try (Connection con = getConnect()) {
            // Kiểm tra xem ngày này có tồn tại không
            PreparedStatement checkStmt = con.prepareStatement("SELECT TotalSales, TotalRevenue FROM Revenue WHERE RevenueDate = ?");
            checkStmt.setDate(1, revenueDate);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Lấy giá trị hiện tại
                int currentSales = rs.getInt("TotalSales");
                double currentRevenue = rs.getDouble("TotalRevenue");

                // Tính giá trị mới (đảm bảo không âm)
                int updatedSales = Math.max(0, currentSales - salesDecrease);
                double updatedRevenue = Math.max(0, currentRevenue - revenueDecrease);

                PreparedStatement updateStmt = con.prepareStatement("UPDATE Revenue SET TotalSales = ?, TotalRevenue = ? WHERE RevenueDate = ?");
                updateStmt.setInt(1, updatedSales);
                updateStmt.setDouble(2, updatedRevenue);
                updateStmt.setDate(3, revenueDate);

                int rows = updateStmt.executeUpdate();
                return rows > 0;
            }
        } catch (Exception ex) {
            Logger.getLogger(RevenueDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) throws SQLException {
        decreaseRevenue(Date.valueOf("2000-11-11"), 1, 10);
    }
}
