
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Users;

@WebFilter("/*")
public class RoleFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        Users role = (session != null) ? (Users) session.getAttribute("user") : null;
        String path = req.getRequestURI();
        
         // ⚠️ Bỏ qua kiểm tra với các trang công khai
        if (path.endsWith("login.jsp") || path.endsWith("register.jsp") || path.contains("/static/") ||
            path.contains("home.jsp") || path.contains("searchByUser.jsp") || path.contains("HomeServlet") ||
                path.contains("SearchProductBy") || path.contains("HomeServlet")) { 
            chain.doFilter(request, response);
            return;
        }
        
        if (role == null && (path.toLowerCase().contains("admin") || path.toLowerCase().contains("user") )){
            request.getRequestDispatcher("/includes/homeForUser.jsp").forward(request, response);
        }
        
        if (role != null) {
            if (!role.isAdmin() && path.toLowerCase().contains("admin")) {
                request.getRequestDispatcher("/includes/homeForUser.jsp").forward(request, response);
                return;
            }

            //  Nếu là admin mà truy cập trang user -> Chặn lại
            if (role.isAdmin() && path.toLowerCase().contains("user")) {
                request.getRequestDispatcher("/includes/homeForAdmin.jsp").forward(request, response);
                return;
            }
        } 
        //  Nếu hợp lệ, tiếp tục request bình thường
        chain.doFilter(request, response);
    }
}
