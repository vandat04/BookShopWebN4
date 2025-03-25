<%-- 
    Document   : login
    Created on : Mar 15, 2025, 9:53:28 AM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginCSS.css">
    </head>
    <body>
        <div class="form-container">
            <h3>Login</h3>
            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <!-- Hiển thị lỗi đăng nhập hoặc thông báo đăng ký -->
                <c:if test="${not empty param.loginErr}">
                    <div class="alert alert-danger">
                        <span><b>Wrong Password!</b></span>
                    </div>
                </c:if>
                <c:if test="${not empty requestScope.err && requestScope.err == 'Register Successfully'}">
                    <div class="alert alert-success">
                        <c:out value="Registration successful! Please login."/>
                    </div>
                </c:if>
                
                <!-- Nhập Username -->
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" 
                           value="${cookie.username.value}" required>
                </div>
                
                <!-- Nhập Password -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" 
                           value="${cookie.pass.value}" required>
                </div>         
                
                <!-- Checkbox nhớ mật khẩu -->
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="savePass" 
                           name="savePass" value="true" 
                           ${cookie.save.value == 'checked' ? 'checked' : ''}>
                    <label class="form-check-label" for="savePass">Remember password</label>
                </div>
                
                <!-- Nút Đăng nhập -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Login</button>
                    <a href="${pageContext.request.contextPath}/includes/homeForUser.jsp" 
                       class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
            
            <!-- Phần đăng ký -->
            <div class="text-center mt-3">
                <p>No account yet? 
                    <a href="${pageContext.request.contextPath}/users/register.jsp" class="btn-link">Register</a>
                </p>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>