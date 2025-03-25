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

public class BooksDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public static Books getBookByTitle(String title) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Books WHERE Title = ?");
            stmt.setString(1, title);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Books(
                        rs.getInt("BookID"),
                        rs.getString("Title"),
                        rs.getString("Author"),
                        rs.getString("Genre"),
                        rs.getInt("PublishedYear"),
                        rs.getString("Publisher"),
                        rs.getString("Description"),
                        rs.getInt("TotalCopies"),
                        rs.getInt("AvailableCopies"),
                        rs.getDouble("Price"),
                        rs.getString("ImagePath"),
                        rs.getInt("PageCount"),
                        rs.getString("Language"),
                        rs.getDate("AddedDate")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static Books getBookByID(int bookID) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Books WHERE BookID = ?");
            stmt.setInt(1, bookID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Books(
                        rs.getInt("BookID"),
                        rs.getString("Title"),
                        rs.getString("Author"),
                        rs.getString("Genre"),
                        rs.getInt("PublishedYear"),
                        rs.getString("Publisher"),
                        rs.getString("Description"),
                        rs.getInt("TotalCopies"),
                        rs.getInt("AvailableCopies"),
                        rs.getDouble("Price"),
                        rs.getString("ImagePath"),
                        rs.getInt("PageCount"),
                        rs.getString("Language"),
                        rs.getDate("AddedDate")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static Books getBookByGenre(String title) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Books WHERE Genre = ?");
            stmt.setString(1, title);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Books(
                        rs.getInt("BookID"),
                        rs.getString("Title"),
                        rs.getString("Author"),
                        rs.getString("Genre"),
                        rs.getInt("PublishedYear"),
                        rs.getString("Publisher"),
                        rs.getString("Description"),
                        rs.getInt("TotalCopies"),
                        rs.getInt("AvailableCopies"),
                        rs.getDouble("Price"),
                        rs.getString("ImagePath"),
                        rs.getInt("PageCount"),
                        rs.getString("Language"),
                        rs.getDate("AddedDate")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static List<Books> getAllList() {
        List<Books> booksList = new ArrayList<>();
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Books");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Books book = new Books(
                        rs.getInt("BookID"),
                        rs.getString("Title"),
                        rs.getString("Author"),
                        rs.getString("Genre"),
                        rs.getInt("PublishedYear"),
                        rs.getString("Publisher"),
                        rs.getString("Description"),
                        rs.getInt("TotalCopies"),
                        rs.getInt("AvailableCopies"),
                        rs.getDouble("Price"),
                        rs.getString("ImagePath"),
                        rs.getInt("PageCount"),
                        rs.getString("Language"),
                        rs.getDate("AddedDate")
                );
                booksList.add(book);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return booksList;
    }

    public static boolean bookExists(String title) {
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement("SELECT COUNT(*) FROM Books WHERE Title = ?")) {
            stmt.setString(1, title);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean updateBook(Books book) {
        try (Connection con = getConnect()) {
            String sql = "UPDATE Books SET Title=?, Author=?, Genre=?, PublishedYear=?, Publisher=?, Description=?, TotalCopies=?, AvailableCopies=?, Price=?, ImagePath=?, PageCount=?, Language=? WHERE BookID=?";
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getGenre());
            stmt.setInt(4, book.getPublishedYear());
            stmt.setString(5, book.getPublisher());
            stmt.setString(6, book.getDescription());
            stmt.setInt(7, book.getTotalCopies());
            stmt.setInt(8, book.getAvailableCopies());
            stmt.setDouble(9, book.getPrice());
            stmt.setString(10, book.getImagePath());
            stmt.setInt(11, book.getPageCount());
            stmt.setString(12, book.getLanguage());
            stmt.setInt(13, book.getBookID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean deleteBook(int bookID) {
        try (Connection con = getConnect()) {
            String sql = "DELETE FROM Books WHERE BookID=?";
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setInt(1, bookID);

            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean addBook(Books book) {
        try (Connection con = getConnect()) {
            String sql = "INSERT INTO Books (Title, Author, Genre, PublishedYear, Publisher, Description, TotalCopies, AvailableCopies, Price, ImagePath, PageCount, Language) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getGenre());
            stmt.setInt(4, book.getPublishedYear());
            stmt.setString(5, book.getPublisher());
            stmt.setString(6, book.getDescription());
            stmt.setInt(7, book.getTotalCopies());
            stmt.setInt(8, book.getAvailableCopies());
            stmt.setDouble(9, book.getPrice());
            stmt.setString(10, book.getImagePath());
            stmt.setInt(11, book.getPageCount());
            stmt.setString(12, book.getLanguage());

            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static List<Books> searchBooks(String title, String genre, Integer year) {
        List<Books> booksList = new ArrayList<>();

        try (Connection con = getConnect()) {
            StringBuilder sql = new StringBuilder("SELECT * FROM Books WHERE");

            // Danh sách tham số động
            List<Object> params = new ArrayList<>();
            boolean conditionAdded = false;

            if (title != null && !title.isEmpty()) {
                sql.append(" Title LIKE ?");
                params.add("%" + title + "%");
                conditionAdded = true;
            }

            if (genre != null && !genre.isEmpty()) {
                if (conditionAdded) {
                    sql.append(" OR");
                }
                sql.append(" Genre LIKE ?");
                params.add("%" + genre + "%");
                conditionAdded = true;
            }

            if (year != null && year > 0) {
                if (conditionAdded) {
                    sql.append(" OR");
                }
                sql.append(" PublishedYear = ?");
                params.add(year);
            }

            // In ra câu SQL và tham số để debug
            System.out.println("SQL Query: " + sql.toString());
            System.out.println("Params: " + params);

            PreparedStatement stmt = con.prepareStatement(sql.toString());

            // Gán giá trị tham số động vào câu lệnh SQL
            int paramIndex = 1;
            for (Object param : params) {
                if (param instanceof Integer) {
                    stmt.setInt(paramIndex, (Integer) param);
                } else {
                    stmt.setString(paramIndex, (String) param);
                }
                paramIndex++;
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Books book = new Books(
                        rs.getInt("BookID"),
                        rs.getString("Title"),
                        rs.getString("Author"),
                        rs.getString("Genre"),
                        rs.getInt("PublishedYear"),
                        rs.getString("Publisher"),
                        rs.getString("Description"),
                        rs.getInt("TotalCopies"),
                        rs.getInt("AvailableCopies"),
                        rs.getDouble("Price"),
                        rs.getString("ImagePath"),
                        rs.getInt("PageCount"),
                        rs.getString("Language"),
                        rs.getDate("AddedDate")
                );
                booksList.add(book);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BooksDB.class.getName()).log(Level.SEVERE, "Lỗi khi tìm kiếm sách!", ex);
        }

        return booksList;
    }

    public static void main(String[] args) {
        System.out.println(searchBooks("Clean", "", 1999));
    }
}
