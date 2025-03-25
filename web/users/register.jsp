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
    <title>Sign Up - Book Library</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/registerCSS.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center">
    <div class="form-container">
        <h3 class="text-center mb-4">Membership Registration</h3>

        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
            <c:if test="${not empty requestScope.err && requestScope.err == 'Register Failed'}">
                <div class="alert alert-danger">
                    <c:out value="Registration failed! Username or Email already exists."/>
                </div>
            </c:if>

            <div class="mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" class="form-control" id="username" name="username" value="${param.username}" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>  

            <div class="mb-3">
                <label for="fullName" class="form-label">Fullname:</label>
                <input type="text" class="form-control" id="fullName" name="fullName" value="${param.fullName}" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" class="form-control" id="email" name="email" value="${param.email}" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number:</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${param.phone}" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Address:</label>
                <input type="text" class="form-control" id="address" name="address" value="${param.address}" required>
            </div>

            <div class="mb-3">
                <label for="dateOfBirth" class="form-label">Date Of Birth:</label>
                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${param.dateOfBirth}" required>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-success">Register</button>
                <a href="${pageContext.request.contextPath}/users/login.jsp" class="btn btn-outline-secondary">Back</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>