<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/headerForUser.jsp" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/editProfileByUser.css"> 
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">
            <a href="${pageContext.request.contextPath}/includes/homeForUser.jsp" class="btn btn-outline-secondary">Back</a> <p>User Profile</p>
        </h2>

        <c:if test="${not empty sessionScope.user}">
            <form action="EditProfileByUser" method="POST" class="form-container">
                <div class="mb-3">
                    <label class="form-label"><strong>UserID:</strong></label>
                    <input type="text" class="form-control" name="userID" value="${sessionScope.user.userID}" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Username:</strong></label>
                    <input type="text" class="form-control" value="${sessionScope.user.username}" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Password:</strong></label>
                    <input type="text" class="form-control" name="password" value="${sessionScope.user.password}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Full Name:</strong></label>
                    <input type="text" class="form-control" name="fullName" value="${sessionScope.user.fullName}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>BirthDay:</strong></label>
                    <input type="text" class="form-control" name="dateOfBirth" value="${sessionScope.user.dateOfBirth}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Email:</strong></label>
                    <input type="email" class="form-control" name="email" value="${sessionScope.user.email}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Phone:</strong></label>
                    <input type="text" class="form-control" name="phone" value="${sessionScope.user.phone}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Address:</strong></label>
                    <input type="text" class="form-control" name="address" value="${sessionScope.user.address}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Money:</strong></label>
                    <input type="text" class="form-control" value="${sessionScope.user.money}" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label"><strong>Registration Date:</strong></label>
                    <input type="text" class="form-control" value="${sessionScope.user.registrationDate}" readonly>
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