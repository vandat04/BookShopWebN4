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

public class Sales {
    private int saleID;
    private int userID;
    private int bookID;
    private Date saleDate;
    private int quantity;
    private double totalPrice;
    private String status;

    public Sales() {
    }
    public Sales(int user, int book, int quantity, double totalPrice) {
        this.userID = user;
        this.bookID = book;
        this.saleDate = new Date();
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    public Sales(int saleID, int user, int book,Date saleDate,  int quantity, double totalPrice, String status) {
        this.saleID = saleID;
        this.userID = user;
        this.bookID = book;
        this.saleDate = saleDate;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.status = status;
    }
    public int getSaleID() {
        return saleID;
    }
    public void setSaleID(int saleID) {
        this.saleID = saleID;
    }
    public int getUserID() {
        return userID;
    }
    public void setUserID(int user) {
        this.userID = user;
    }
    public int getBookID() {
        return bookID;
    }
    public void setBookID(int book) {
        this.bookID = book;
    }
    public Date getSaleDate() {
        return saleDate;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Sales{" +
                "saleID=" + saleID +
                ", user=" + userID +
                ", book=" + bookID +
                ", saleDate=" + saleDate +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                ", status='" + status + '\'' +
                '}';
    }
}
