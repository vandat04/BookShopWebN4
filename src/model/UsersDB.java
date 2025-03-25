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

public class UsersDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public static Users validateLogin(String username, String password) {
        Users user = null;
        String query = "SELECT * FROM Users WHERE Username = ? AND Password = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new Users(
                        rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getDate("DateOfBirth"),
                        rs.getBoolean("IsAdmin"),
                        rs.getDouble("Money")
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return user;
    }

    public static boolean registerUser(String username, String password, String fullName, String email, String phone, String address, Date dateOfBirth) {
        String query = "INSERT INTO Users (Username, Password, FullName, Email, Phone, Address, DateOfBirth) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, fullName);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, address);
            ps.setDate(7, dateOfBirth);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static boolean updateIsAdmin(int userID, boolean isAdmin) {
        String query = "UPDATE Users SET IsAdmin = ? WHERE UserID = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setBoolean(1, isAdmin);
            ps.setInt(2, userID);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static boolean updateUser(int userID, String password, String fullName, String email, String phone, String address, Date dateOfBirth) {
        // SQL query to update user details
        String query = "UPDATE Users SET Password = ?, FullName = ?, Email = ?, Phone = ?, Address = ?, DateOfBirth = ? WHERE UserID = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {
            // Set the parameters for the query
            ps.setString(1, password);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setDate(6, dateOfBirth); // Assuming the date format is `java.sql.Date`
            ps.setInt(7, userID);

            // Execute the update and return true if successful
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static List<Users> allListUsers() {
        List<Users> userList = new ArrayList<>();
        String query = "SELECT * FROM Users";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Users user = new Users(
                        rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getDate("DateOfBirth"),
                        rs.getBoolean("IsAdmin"),
                        rs.getDouble("Money")
                );
                userList.add(user);
            }
        } catch (SQLException e) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return userList;
    }

    public static Users getUserByID(int userID) {
        Users user = null;
        String query = "SELECT * FROM Users WHERE UserID = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {

            // Set the UserID parameter in the query
            ps.setInt(1, userID);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Create the user object from the result set
                    user = new Users(
                            rs.getInt("UserID"),
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("FullName"),
                            rs.getString("Email"),
                            rs.getString("Phone"),
                            rs.getString("Address"),
                            rs.getDate("DateOfBirth"),
                            rs.getBoolean("IsAdmin"),
                            rs.getDouble("Money")
                    );
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return user;
    }

    public static int deleteUserByID(int UserID) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("Delete from Users where UserID =?");
            stmt.setInt(1, UserID);
            int rc = stmt.executeUpdate();
            con.close();
            return rc;
        } catch (Exception ex) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public static boolean deductBalance(int userID, double amount) {
        String checkBalanceQuery = "SELECT Money FROM Users WHERE UserID = ?";
        String updateBalanceQuery = "UPDATE Users SET Money = Money - ? WHERE UserID = ?";

        try (Connection conn = getConnect();
             PreparedStatement checkStmt = conn.prepareStatement(checkBalanceQuery);
             PreparedStatement updateStmt = conn.prepareStatement(updateBalanceQuery)) {

            conn.setAutoCommit(false); // Bắt đầu transaction

            // 1. Kiểm tra số dư
            checkStmt.setInt(1, userID);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getDouble("Money") >= amount) {
                // 2. Trừ tiền
                updateStmt.setDouble(1, amount);
                updateStmt.setInt(2, userID);
                if (updateStmt.executeUpdate() > 0) {
                    conn.commit();
                    return true;
                }
            }
            conn.rollback();
        } catch (SQLException e) {
            Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }
    
    public static boolean refundBalance(int userID, double amount) {
    String updateBalanceQuery = "UPDATE Users SET Money = Money + ? WHERE UserID = ?";

    try (Connection conn = getConnect();
         PreparedStatement updateStmt = conn.prepareStatement(updateBalanceQuery)) {

        conn.setAutoCommit(false); // Bắt đầu transaction

        // 1. Cộng tiền vào tài khoản
        updateStmt.setDouble(1, amount);
        updateStmt.setInt(2, userID);

        if (updateStmt.executeUpdate() > 0) {
            conn.commit(); // Xác nhận giao dịch
            return true;
        }
        conn.rollback(); // Nếu thất bại, quay lui giao dịch
    } catch (SQLException e) {
        Logger.getLogger(UsersDB.class.getName()).log(Level.SEVERE, null, e);
    }
    return false;
}
    
    public static void main(String[] args) {
        System.out.println(deleteUserByID(13));
    }

}
