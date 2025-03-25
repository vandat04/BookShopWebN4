<%-- 
    Document   : header
    Created on : Mar 15, 2025, 3:02:48 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/CSS/main.css">

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/includes/homeForUser.jsp">
        <img src="${pageContext.request.contextPath}/images/LogoBookShop.png" alt="Nhom4" style="height: 40px;">
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" 
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/product/searchByUser.jsp">Search</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/SaleHistoryServlet">Sales</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/DepositHistoryServlet">Deposit</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/ProfileServlet">Profile</a>
            </li>
            <li class="nav-item active">
                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServlet">${sessionScope.username} (Logout)</a>
                    </c:when>
                    <c:otherwise>
                        <a class="nav-link" href="${pageContext.request.contextPath}/users/login.jsp">Login</a>
                    </c:otherwise>
                </c:choose>
            </li>
        </ul>
    </div>
</nav>