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



public class Books {
    private int bookID;
    private String title;
    private String author;
    private String genre;
    private int publishedYear;
    private String publisher;
    private String description;
    private int totalCopies;
    private int availableCopies;
    private double price;    
    private String imagePath;
    private int pageCount;
    private String language;
    private Date addedDate;

    public Books() {
    }

    public Books(int bookID,String title, String author, String genre, int publishedYear, String publisher, 
                 String description, int totalCopies, int availableCopies, double price, 
                 String imagePath, int pageCount, String language) {
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.publishedYear = publishedYear;
        this.publisher = publisher;
        this.description = description;
        this.totalCopies = totalCopies;
        this.availableCopies = availableCopies;
        this.price = price;
        this.imagePath = imagePath;
        this.pageCount = pageCount;
        this.language = language;
        this.addedDate = new Date();
    }

    public Books(String title, String author, String genre, int publishedYear, String publisher, String description, int totalCopies, int availableCopies, double price, String imagePath, int pageCount, String language) {
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.publishedYear = publishedYear;
        this.publisher = publisher;
        this.description = description;
        this.totalCopies = totalCopies;
        this.availableCopies = availableCopies;
        this.price = price;
        this.imagePath = imagePath;
        this.pageCount = pageCount;
        this.language = language;
    }

    
    
    public Books(int bookID, String title, String author, String genre, int publishedYear, String publisher, String description, int totalCopies, int availableCopies, double price, String imagePath, int pageCount, String language, Date addedDate) {
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.publishedYear = publishedYear;
        this.publisher = publisher;
        this.description = description;
        this.totalCopies = totalCopies;
        this.availableCopies = availableCopies;
        this.price = price;
        this.imagePath = imagePath;
        this.pageCount = pageCount;
        this.language = language;
        this.addedDate = addedDate;
    }
    
    

    public int getBookID() {
        return bookID;
    }
    public void setBookID(int bookID) {
        this.bookID = bookID;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
    public String getGenre() {
        return genre;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }
    public int getPublishedYear() {
        return publishedYear;
    }
    public void setPublishedYear(int publishedYear) {
        this.publishedYear = publishedYear;
    }
    public String getPublisher() {
        return publisher;
    }
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public int getTotalCopies() {
        return totalCopies;
    }
    public void setTotalCopies(int totalCopies) {
        this.totalCopies = totalCopies;
    }
    public int getAvailableCopies() {
        return availableCopies;
    }
    public void setAvailableCopies(int availableCopies) {
        this.availableCopies = availableCopies;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    public int getPageCount() {
        return pageCount;
    }
    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }
    public String getLanguage() {
        return language;
    }
    public void setLanguage(String language) {
        this.language = language;
    }
    public Date getAddedDate() {
        return addedDate;
    }

    @Override
    public String toString() {
        return "Books{" +
                "bookID=" + bookID +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", genre='" + genre + '\'' +
                ", publishedYear=" + publishedYear +
                ", publisher='" + publisher + '\'' +
                ", description='" + description + '\'' +
                ", totalCopies=" + totalCopies +
                ", availableCopies=" + availableCopies +
                ", price=" + price +
                ", imagePath='" + imagePath + '\'' +
                ", pageCount=" + pageCount +
                ", language='" + language + '\'' +
                ", addedDate=" + addedDate +
                '}';
    }
}

