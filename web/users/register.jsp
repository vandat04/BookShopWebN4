<%-- 
    Document   : register
    Created on : Mar 15, 2025, 10:21:09 AM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Register JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                height: 100vh;
            }
            .form-container {
                width: 40%; /* Chiếm 40% màn hình */
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body class="d-flex align-items-center justify-content-center">
        <div class="form-container">
            <h3 class="text-center mb-4">Sign Up</h3>

            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                <!-- Display registration failure message -->
                <c:if test="${not empty requestScope.err && requestScope.err == 'Dang ki that bai'}">
                    <div class="alert alert-danger">
                        <c:out value="Đăng ký không thành công! Username hoặc Email đã tồn tại."/>
                    </div>
                </c:if>

                <!-- Nhập Username -->
                <div class="mb-3">
                    <label for="username" class="form-label">UserName: </label>
                    <input type="text" class="form-control" id="username" name="username" value="${param.username}" required>
                </div>

                <!-- Nhập Password -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password: </label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>  

                <!-- Nhập Full Name -->
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name: </label>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="${param.fullName}" required>
                </div>

                <!-- Nhập Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email: </label>
                    <input type="email" class="form-control" id="email" name="email" value="${param.email}" required>
                </div>

                <!-- Nhập Số điện thoại -->
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone: </label>
                    <input type="text" class="form-control" id="phone" name="phone" value="${param.phone}" required>
                </div>

                <!-- Nhập Địa chỉ -->
                <div class="mb-3">
                    <label for="address" class="form-label">Address: </label>
                    <input type="text" class="form-control" id="address" name="address" value="${param.address}" required>
                </div>

                <!-- Nhập Ngày sinh -->
                <div class="mb-3">
                    <label for="dateOfBirth" class="form-label">Birthday: </label>
                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${param.dateOfBirth}" required>
                </div>

                <!-- Nút Đăng ký -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success">Sign up</button>
                    <a href="${pageContext.request.contextPath}/users/login.jsp" class="btn btn-outline-secondary">Back</a>
                </div>
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>