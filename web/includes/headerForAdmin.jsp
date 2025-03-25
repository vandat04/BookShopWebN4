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
    <a class="navbar-brand" href="${pageContext.request.contextPath}/includes/homeForAdmin.jsp">
        <img src="${pageContext.request.contextPath}/images/LogoBookShop.png" alt="Nhom4" style="height: 40px;">
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" 
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/RenvenueServlet">Tong thu</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/includes/homeForAdmin.jsp">List sasch</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/ProfileServlet">List User</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/SaleHistoryServlet">Don mua</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/DepositHistoryServlet"">Yeu cau nap 6tien </a>
            </li>
            <li class="nav-item active">                     
                <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServlet">${sessionScope.username} (Logout)</a>
            </li>
        </ul>
    </div>
</nav>