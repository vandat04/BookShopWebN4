package controller.Chatbox;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.HashMap;
import java.util.Map;
import model.DatabaseInfo;
import org.apache.http.client.methods.*;
import org.apache.http.entity.*;
import org.apache.http.impl.client.*;
import org.apache.http.util.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet("/ChatbotServlet")
public class ChatbotServlet extends HttpServlet implements DatabaseInfo{

    private static final String API_KEY = "AIzaSyBIZ-wuqfU37N4Vsa6npV-DtXB7L0i7S0k"; // Thay bằng API key
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + API_KEY;
//    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-BCICGTP0\\SQL2019A;databaseName=BookShop;encrypt=false;trustServerCertificate=TRUE;loginTimeout=30;";
//    private static final String DB_USER = "sa";
//    private static final String DB_PASSWORD = "12345";
    private static final String PROPERTIES_FILE = "/WEB-INF/systemInstruction.properties";
    private static final Logger logger = (Logger) LogManager.getLogger(ChatbotServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doPost được gọi với userMessage: " + request.getParameter("message")); // Thêm log
        HttpSession session = request.getSession();
        String userMessage = request.getParameter("message");

        // Kiểm tra đầu vào
        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> jsonResponse = new HashMap<>();
            jsonResponse.put("error", "Tin nhắn không được để trống.");
            mapper.writeValue(response.getWriter(), jsonResponse);
            return;
        }

        String chatHistory = (String) session.getAttribute("chatHistory");
        if (chatHistory == null) {
            chatHistory = "";
        }

        // Gọi getBotResponse với session
        String botText = getBotResponse(userMessage, chatHistory, session);

        // Cập nhật lịch sử trò chuyện
        chatHistory += "Khách hàng: " + userMessage + "\nBot: " + botText + "\n";
        session.setAttribute("chatHistory", chatHistory);

        @SuppressWarnings("unchecked")
        List<String[]> conversation = (List<String[]>) session.getAttribute("conversation");
        if (conversation == null) {
            conversation = new ArrayList<>();
        }
        conversation.add(new String[]{userMessage, botText});
        session.setAttribute("conversation", conversation);

        // Trả về phản hồi JSON cho AJAX
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> jsonResponse = new HashMap<>();
        jsonResponse.put("botText", botText);
        mapper.writeValue(response.getWriter(), jsonResponse);
    }

    private String getBotResponse(String userMessage, String chatHistory, HttpSession session) {
        String botText = "";
        ObjectMapper mapper = new ObjectMapper();

        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(API_URL);
            httpPost.setHeader("Content-Type", "application/json");

            // Lấy dữ liệu từ cơ sở dữ liệu
            String textData = fetchDataFromDatabase(userMessage);

            if ("not_found".equals(textData)) {
                botText = "Rất tiếc, tôi không tìm thấy sách phù hợp với yêu cầu của bạn. Bạn có thể thử từ khóa khác không?";
                return botText;
            }

            // Đọc system instruction từ file properties
            String systemInstruction = readSystemInstruction();
            if (systemInstruction == null) {
                systemInstruction = "Bạn là chatbot hỗ trợ khách hàng cho dịch vụ thuê sách. Trả lời bằng tiếng Việt.";
            }
            String systemInstructionText = systemInstruction.replace("{dbData}", textData);

            // Chuẩn bị request body cho API Gemini
            Map<String, Object> requestBody = new HashMap<>();

            // System Instruction
            Map<String, Object> sysInstr = new HashMap<>();
            List<Map<String, String>> sysParts = new ArrayList<>();
            Map<String, String> sysPart = new HashMap<>();
            sysPart.put("text", systemInstructionText);
            sysParts.add(sysPart);
            sysInstr.put("parts", sysParts);
            requestBody.put("systemInstruction", sysInstr);

            // Contents (lịch sử trò chuyện)
            @SuppressWarnings("unchecked")
            List<String[]> conversation = (List<String[]>) session.getAttribute("conversation");
            if (conversation == null) {
                conversation = new ArrayList<>();
            }

            List<Map<String, Object>> contents = new ArrayList<>();
            for (String[] conv : conversation) {
                Map<String, Object> userCont = new HashMap<>();
                userCont.put("role", "user");
                List<Map<String, String>> userParts = new ArrayList<>();
                Map<String, String> userPart = new HashMap<>();
                userPart.put("text", conv[0]);
                userParts.add(userPart);
                userCont.put("parts", userParts);
                contents.add(userCont);

                Map<String, Object> botCont = new HashMap<>();
                botCont.put("role", "model");
                List<Map<String, String>> botParts = new ArrayList<>();
                Map<String, String> botPart = new HashMap<>();
                botPart.put("text", conv[1]);
                botParts.add(botPart);
                botCont.put("parts", botParts);
                contents.add(botCont);
            }

            Map<String, Object> newUserCont = new HashMap<>();
            newUserCont.put("role", "user");
            List<Map<String, String>> newUserParts = new ArrayList<>();
            Map<String, String> newUserPart = new HashMap<>();
            newUserPart.put("text", userMessage);
            newUserParts.add(newUserPart);
            newUserCont.put("parts", newUserParts);
            contents.add(newUserCont);

            requestBody.put("contents", contents);

            String jsonPayload = mapper.writeValueAsString(requestBody);
            httpPost.setEntity(new StringEntity(jsonPayload, "UTF-8"));

            CloseableHttpResponse apiResponse = httpClient.execute(httpPost);
            String responseString = EntityUtils.toString(apiResponse.getEntity(), "UTF-8");

            botText = extractTextFromResponse(responseString);
            botText = botText.replaceAll("\\*\\*", "").replaceAll("\\*", "")
                    .replace("Tên sách: (", "Tên sách:\n(")
                    .replace("Tác giả: (", "Tác giả:\n(");

        } catch (Exception e) {
            logger.error("Error occurred in getBotResponse: ", e);
            botText = "Xin lỗi, có lỗi xảy ra: " + e.getMessage();
        }

        return botText;
    }

    private String readSystemInstruction() {
        Properties props = new Properties();
        try (InputStream is = getServletContext().getResourceAsStream(PROPERTIES_FILE)) {
            if (is == null) {
                throw new IOException("Không tìm thấy file properties");
            }
            props.load(is);
            return props.getProperty("instruction");
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String fetchDataFromDatabase(String userMessage) {
        StringBuilder textData = new StringBuilder();

        // Đăng ký driver JDBC
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("Driver registered successfully");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            textData.append("Không thể đăng ký driver JDBC.");
            return textData.toString();
        }

        try (Connection conn = DriverManager.getConnection(DBURL, USERDB, PASSDB)) {
            StringBuilder query = new StringBuilder("SELECT Title, Author, Genre, Price, TotalCopies FROM Books WHERE 1=1");
            List<Object> parameters = new ArrayList<>();

            String message = userMessage.toLowerCase().trim();

            if (message.contains("sách")) {
                int index = message.indexOf("sách");
                if (index + 4 < message.length()) {
                    String bookName = message.substring(index + 4).trim();
                    if (!bookName.isEmpty()) {
                        query.append(" AND (Title LIKE ? OR Genre LIKE ?)");
                        parameters.add("%" + bookName + "%");
                        parameters.add("%" + bookName + "%");
                    }
                }
            }

            if (message.contains("tác giả")) {
                int index = message.indexOf("tác giả");
                if (index + 7 < message.length()) {
                    String authorName = message.substring(index + 7).trim();
                    if (!authorName.isEmpty()) {
                        query.append(" AND Author LIKE ?");
                        parameters.add("%" + authorName + "%");
                    }
                }
            }

            if (message.contains("thể loại")) {
                int index = message.indexOf("thể loại");
                if (index + 8 < message.length()) {
                    String genre = message.substring(index + 8).trim();
                    if (!genre.isEmpty()) {
                        query.append(" AND Genre LIKE ?");
                        parameters.add("%" + genre + "%");
                    }
                }
            }

            if (message.contains("dưới") || message.contains("giá dưới")) {
                String priceStr = message.replaceAll("[^0-9]", "");
                if (!priceStr.isEmpty()) {
                    int price = Integer.parseInt(priceStr);
                    query.append(" AND Price <= ?");
                    parameters.add(price);
                }
            }

            if (message.contains("còn hàng")) {
                query.append(" AND TotalCopies > 0");
            }

            try (PreparedStatement pstmt = conn.prepareStatement(query.toString())) {
                for (int i = 0; i < parameters.size(); i++) {
                    pstmt.setObject(i + 1, parameters.get(i));
                }

                System.out.println("Query: " + query.toString());
                System.out.println("Parameters: " + parameters);

                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String title = rs.getString("Title");
                    String author = rs.getString("Author");
                    String genre = rs.getString("Genre");
                    double price = rs.getDouble("Price");
                    int totalCopies = rs.getInt("TotalCopies");

                    textData.append(String.format("Tên sách: %s, Tác giả: %s, Thể loại: %s, Giá: %.0f USD, Tình trạng: %s. ",
                            title, author, genre, price, totalCopies > 0 ? "Còn hàng" : "Hết hàng"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            textData.append("Không thể lấy dữ liệu từ database: " + e.getMessage());
        }

        return textData.length() > 0 ? textData.toString() : "not_found";
    }

    private String extractTextFromResponse(String jsonResponse) {
        int startIndex = jsonResponse.indexOf("\"text\": \"") + 9;
        int endIndex = jsonResponse.indexOf("\"", startIndex);
        if (startIndex != -1 && endIndex != -1) {
            String text = jsonResponse.substring(startIndex, endIndex);
            return text.replace("\\n", "\n");
        }
        return "Không nhận được phản hồi từ bot.";
    }

    public static void main(String[] args) {
        Object[] ob = test("sách clean code");
        String textData = (String) ob[0];
        System.out.println(textData);
    }

    private static Object[] test(String userMessage) {
        StringBuilder textData = new StringBuilder();
        List<String> imageUrls = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DBURL, USERDB, PASSDB)) {
            String query = "SELECT Title, Author, Genre, Price, TotalCopies FROM Books WHERE 1=1";
            PreparedStatement pstmt = null;

            if (userMessage.toLowerCase().contains("sách")) {
                int index = userMessage.indexOf("sách");
                String bookName = userMessage.substring(index + 5);
                if (!bookName.isEmpty()) {

                    query += " AND Title LIKE ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, "%" + bookName + "%");

//                    System.out.println("Query: " + query);
//                    System.out.println("Parameter: %" + bookName + "%");
                }
            }

            if (!query.contains("WHERE")) {
                pstmt = conn.prepareStatement(query);
            }

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String title = rs.getString("Title");
                String author = rs.getString("Author");
                String genre = rs.getString("Genre");
                textData.append(String.format("Sách: %s, Tác giả: %s, Thể loại: %s. ",
                        title, author, genre));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            textData.append("Không thể lấy dữ liệu từ database.");
        }
        return new Object[]{textData.length() > 0 ? textData.toString() : "Không có dữ liệu phù hợp."};
    }
}
