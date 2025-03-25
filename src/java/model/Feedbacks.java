/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
/**
 *
 * @author ACER
 */
import java.util.Date;

public class Feedbacks {
    private int userID;
    private int bookID;
    private int rating;
    private String comment;
    private Date feedbackDate;
    private int Rating;

    // Constructor
    public Feedbacks( int userID, int bookID,  int rating, String comment, Date feedbackDate) {
        this.userID = userID;
        this.bookID = bookID;
        this.rating = rating;
        this.comment = comment;
        this.feedbackDate = feedbackDate;
    }
    public Feedbacks( int userID, int bookID, int rating, String comment, int Rating) {
        this.userID = userID;
        this.bookID = bookID;
        this.rating = rating;
        this.comment = comment;
        this.rating = rating;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(Date feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    @Override
    public String toString() {
        return "Feedbacks{" +
                ", userID=" + userID +
                ", bookID=" + bookID +
                ", rating=" + rating +
                ", comment='" + comment + '\'' + 
                ", dateFeedbacks='" + feedbackDate;
                }
}