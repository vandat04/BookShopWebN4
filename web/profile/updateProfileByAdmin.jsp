<%-- 
    Document   : updateProfileByAdmin
    Created on : Mar 23, 2025, 6:07:40 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile By Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/updateProfileByAdmin.css"> 
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">
            <a href="${pageContext.request.contextPath}/profile/editProfileByAdmin.jsp" class="btn btn-outline-secondary">Back</a>
            <p>Update Profile User</p>
        </h2>

        <%-- Kiểm tra nếu userNeedToEdit không tồn tại --%>
        <c:if test="${empty requestScope.userNeedToEdit}">
            <p class="text-danger">User profile to edit not found.</p>
        </c:if>

        <%-- Hiển thị form nếu userNeedToEdit tồn tại --%>
        <c:if test="${not empty requestScope.userNeedToEdit}">
            <!-- User profile form -->
            <form action="${pageContext.request.contextPath}/EditProfileByAdmin" method="POST">
                <input type="hidden" name="type" value="edit">
                <input type="hidden" name="adminID" value="${sessionScope.user.userID}">
                <input type="hidden" name="userID" value="${requestScope.userNeedToEdit.userID}">
                <div class="mb-3">
                    <label class="form-label"><strong>UserID:</strong></label>
                    <input type="text" class="form-control" value="${requestScope.userNeedToEdit.userID}" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>User Name:</strong></label>
                    <input type="text" class="form-control" value="${requestScope.userNeedToEdit.username}" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Password:</strong></label>
                    <input type="text" class="form-control" name="password" value="${requestScope.userNeedToEdit.password}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Full Name:</strong></label>
                    <input type="text" class="form-control" name="fullName" value="${requestScope.userNeedToEdit.fullName}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Date Of Birth:</strong></label>
                    <input type="date" class="form-control" name="dateOfBirth" value="${requestScope.userNeedToEdit.dateOfBirth}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Email:</strong></label>
                    <input type="email" class="form-control" name="email" value="${requestScope.userNeedToEdit.email}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Phone Number:</strong></label>
                    <input type="text" class="form-control" name="phone" value="${requestScope.userNeedToEdit.phone}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Address:</strong></label>
                    <input type="text" class="form-control" name="address" value="${requestScope.userNeedToEdit.address}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Total Money:</strong></label>
                    <input type="text" class="form-control" value="${requestScope.userNeedToEdit.money}" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Registration Date:</strong></label>
                    <input type="text" class="form-control" value="${requestScope.userNeedToEdit.registrationDate}" readonly>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>