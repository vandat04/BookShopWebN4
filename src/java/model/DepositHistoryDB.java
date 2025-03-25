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
import static model.DatabaseInfo.DBURL;
import static model.DatabaseInfo.DRIVERNAME;
import static model.DatabaseInfo.PASSDB;
import static model.DatabaseInfo.USERDB;

public class DepositHistoryDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public static int addDeposit(int userID, String bankName, double value) {
        String query = "INSERT INTO DepositHistory (UserID, bankName, value) VALUES (?, ?, ?)";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userID);
            ps.setString(2, bankName);
            ps.setDouble(3, value);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Lấy depositID vừa tạo
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Trả về depositID
                    } else {
                        Logger.getLogger(DepositHistoryDB.class.getName()).log(Level.SEVERE,
                                "Không thể lấy depositID mặc dù giao dịch đã được thêm.");
                        return -1;
                    }
                }
            } else {
                Logger.getLogger(DepositHistoryDB.class.getName()).log(Level.SEVERE,
                        "Không có hàng nào được thêm vào DepositHistory.");
                return -1;
            }
        } catch (SQLException e) {
            Logger.getLogger(DepositHistoryDB.class.getName()).log(Level.SEVERE,
                    "Lỗi khi thêm giao dịch vào DepositHistory: " + e.getMessage(), e);
            return -1;
        }
    }

    public static List<DepositHistory> allListDeposit() {
        List<DepositHistory> depositList = new ArrayList<>();
        String query = "SELECT * FROM DepositHistory";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DepositHistory deposit = new DepositHistory(
                        rs.getInt("DepositID"),
                        rs.getInt("UserID"),
                        rs.getString("BankName"),
                        rs.getDouble("Value"),
                        rs.getDate("DepositDate"),
                        rs.getString("Status")
                );
                depositList.add(deposit);
            }
        } catch (SQLException e) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return depositList;
    }

    // Thêm nạp tiền vào cơ sở dữ liệu
    public static boolean addMoney(int userID, double value) {
        String updateMoneyQuery = "UPDATE Users SET Money = Money + ? WHERE UserID = ?";

        try (Connection conn = getConnect(); PreparedStatement updateMoneyPs = conn.prepareStatement(updateMoneyQuery)) {
            updateMoneyPs.setDouble(1, value);
            updateMoneyPs.setInt(2, userID);
            return updateMoneyPs.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DepositHistoryDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    // Cập nhật số dư sau khi mua sách
    public static boolean deductMoneyAfterPurchase(int userID, double totalPrice) {
        String query = "UPDATE Users SET Money = Money - ? WHERE UserID = ? AND Money >= ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setDouble(1, totalPrice);
            ps.setInt(2, userID);
            ps.setDouble(3, totalPrice);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DepositHistoryDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static List<DepositHistory> getDepositByID(int userID) {
        List<DepositHistory> depositList = new ArrayList<>();
        String query = "SELECT * FROM DepositHistory WHERE UserID = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userID); // Gán tham số UserID vào câu truy vấn
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DepositHistory deposit = new DepositHistory(
                            rs.getInt("DepositID"),
                            rs.getInt("UserID"),
                            rs.getString("BankName"),
                            rs.getDouble("Value"),
                            rs.getDate("DepositDate"),
                            rs.getString("Status")
                    );
                    depositList.add(deposit);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DepositHistoryDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return depositList;
    }

    public static DepositHistory getDepositByDepositID(int DepositID) {
        String query = "SELECT * FROM DepositHistory WHERE DepositID = ?";
        DepositHistory deposit = null;
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, DepositID); // Gán tham số UserID vào câu truy vấn
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    deposit = new DepositHistory(
                            rs.getInt("DepositID"),
                            rs.getInt("UserID"),
                            rs.getString("BankName"),
                            rs.getDouble("Value"),
                            rs.getDate("DepositDate"),
                            rs.getString("Status")
                    );
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DepositHistoryDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return deposit;
    }

    public static boolean updateStatus(int depositID, String status) {
        String updateStatusQuery = "UPDATE DepositHistory SET Status = ? WHERE DepositID = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(updateStatusQuery)) {

            if (conn == null) {
                Logger.getLogger(DepositHistoryDB.class.getName()).log(Level.SEVERE, "Failed to connect to database");
                return false;
            }

            ps.setString(1, status); // Sử dụng giá trị status truyền vào
            ps.setInt(2, depositID);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                DepositHistory deposit = DepositHistoryDB.getDepositByDepositID(depositID);
                addMoney(deposit.getUserID(), deposit.getValue());
                return true;
            } else {
                return false;
            }

        } catch (SQLException e) {
            return false;
        }
    }

    public static void main(String[] args) {
        System.out.println(addDeposit(13, "NCB", 2000));
    }
}
