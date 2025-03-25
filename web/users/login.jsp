    <%-- 
    Document   : login
    Created on : Mar 15, 2025, 9:53:28 AM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đăng nhập</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                height: 100vh;
            }
            .form-container {
                width: 33%; /* Chiếm 1/3 màn hình */
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body class="d-flex align-items-center justify-content-center">
        <div class="form-container">
            <h3 class="text-center mb-4">Login</h3>

            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <!-- Display login error or registration success -->
                <c:if test="${not empty param.loginErr}">
                    <div class="alert alert-danger">
                        <span class="text-danger"><b>Wrong Password!</b></span>
                    </div>
                </c:if>
                <c:if test="${not empty requestScope.err && requestScope.err == 'Dang ki thanh cong'}">
                    <div class="alert alert-success">
                        <c:out value="Đăng ký thành công! Vui lòng đăng nhập."/>
                    </div>
                </c:if>

                <!-- Nhập Username -->
                <div class="mb-3">
                    <label for="username" class="form-label">UserName: </label>
                    <input type="text" class="form-control" id="username" name="username" value="${cookie.username.value}" required>
                </div>

                <!-- Nhập Password -->
                <div class="mb-3">
                    <label for="password" class="form-label">PassWord: </label>
                    <input type="password" class="form-control" id="password" name="password" value="${cookie.pass.value}" required>
                </div>         

                <!-- Checkbox nhớ mật khẩu -->
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="savePass" name="savePass" value="true" ${cookie.save.value == 'checked' ? 'checked' : ''}>
                    <label class="form-check-label" for="savePass">Save PassWord</label>
                </div>

                <!-- Nút Đăng nhập -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Login</button>
                    <a href="${pageContext.request.contextPath}/includes/homeForUser.jsp" class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>

            <!-- Thêm phần "Chưa có tài khoản?" -->
            <div class="text-center mt-3">
                <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/users/register.jsp" class="btn btn-link">Sign up</a></p>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>