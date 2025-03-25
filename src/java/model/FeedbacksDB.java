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

public class FeedbacksDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    // Thêm phản hồi mới vào cơ sở dữ liệu
    public static boolean addFeedback(int userID, int bookID, int rating, String comment) {
        String query = "INSERT INTO Feedbacks (UserID, BookID,  Rating, Comment) VALUES (?,  ?, ?, ?)";
        
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ps.setInt(3, rating);
            ps.setString(4, comment);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(FeedbacksDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    // Lấy danh sách phản hồi theo BookID
    public static List<Feedbacks> getFeedbacksByBookID(int bookID) {
        List<Feedbacks> feedbackList = new ArrayList<>();
        String query = "SELECT * FROM Feedbacks WHERE BookID = ?";
        
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, bookID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedbacks feedback = new Feedbacks(
                    rs.getInt("UserID"),
                    rs.getInt("BookID"),
                    rs.getInt("Rating"),
                    rs.getString("Comment"),
                    rs.getTimestamp("FeedbackDate")
                );
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbacksDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return feedbackList;
    }

    // Xóa phản hồi theo ID
    public static boolean deleteFeedback(int feedbackID) {
        String query = "DELETE FROM Feedbacks WHERE FeedbackID = ?";
        
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, feedbackID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(FeedbacksDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    // Cập nhật phản hồi
    public static boolean updateFeedback(int feedbackID, int rating, String comment) {
        String query = "UPDATE Feedbacks SET Rating = ?, Comment = ? WHERE FeedbackID = ?";
        
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, rating);
            ps.setString(2, comment);
            ps.setInt(3, feedbackID);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(FeedbacksDB.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static void main(String[] args) {
        System.out.println(deleteFeedback(3));
        
    }
}
