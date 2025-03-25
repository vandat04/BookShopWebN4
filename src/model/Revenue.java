/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Date;
/**
 *
 * @author ACER
 */
public class Revenue {
    private Date revenueDate;
    private int totalSales;
    private double totalRevenue;

    public Revenue() {
    }

    public Revenue( Date revenueDate, int totalSales, double totalRevenue) {
        this.revenueDate = revenueDate;
        this.totalSales = totalSales;
        this.totalRevenue = totalRevenue;
    }

    public Date getRevenueDate() {
        return revenueDate;
    }

    public void setRevenueDate(Date revenueDate) {
        this.revenueDate = revenueDate;
    }

    public int getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(int totalSales) {
        this.totalSales = totalSales;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    @Override
    public String toString() {
        return "Revenue{" +
                ", revenueDate=" + revenueDate +
                ", totalSales=" + totalSales +
                ", totalRevenue=" + totalRevenue +
                '}';
    }
}
