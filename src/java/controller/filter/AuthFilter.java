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

@WebFilter({"/ProfileServlet", "/DepositHistoryServlet", "/SaleHistoryServlet"}) // 👈 Chỉ áp dụng cho các servlet này
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (session == null || session.getAttribute("user") == null) {
            // Thêm contextPath để đảm bảo đường dẫn chính xác
            res.sendRedirect(req.getContextPath() + "/users/login.jsp");
            return;
        }

        // Nếu hợp lệ, tiếp tục xử lý yêu cầu
        chain.doFilter(request, response);
    }
}