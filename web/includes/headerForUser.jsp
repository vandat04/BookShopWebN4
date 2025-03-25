<%-- 
    Document   : headerForUser
    Created on : Mar 15, 2025, 3:02:48 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/headerForUser.css">

<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Header with Logo and Logout -->
<div class="container-fluid bg-light py-3">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/includes/homeForUser.jsp">
            <p class="header-title">Welcome to BookStore N4</p>
        </a>
        <!-- Simplified Logout Button -->
        <c:choose>
            <c:when test="${not empty sessionScope.username}">
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="text-decoration-none">
                    <div class="logout-btn d-flex align-items-center">
                        <span class="logout-title text-danger me-2">LOGOUT</span>
                        <span class="logout-username text-muted">(${sessionScope.username})</span>
                    </div>
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/users/login.jsp" class="text-decoration-none">
                    <div class="logout-btn d-flex align-items-center">
                        <span class="logout-title text-danger me-2">LOGIN</span>
                    </div>
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Menu as Cards -->
<div class="container custom-container mt-4">
    <div class="row justify-content-center">
        <!-- Card 1: Search -->
        <div class="col-6 col-md-4 col-lg-3 mb-4">
            <a href="${pageContext.request.contextPath}/product/searchByUser.jsp" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-primary me-3">
                            <i class="fas fa-search fa-2x text-white"></i>
                        </div>
                        <h5 class="card-title text-danger">SEARCH</h5>
                    </div>
                </div>
            </a>
        </div>

        <!-- Card 2: Sales -->
        <div class="col-6 col-md-4 col-lg-3 mb-4">
            <a href="${pageContext.request.contextPath}/SaleHistoryServlet" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-success me-3">
                            <i class="fas fa-shopping-cart fa-2x text-white"></i>
                        </div>
                        <h5 class="card-title text-danger">SALES</h5>
                    </div>
                </div>
            </a>
        </div>

        <!-- Card 3: Deposit -->
        <div class="col-6 col-md-4 col-lg-3 mb-4">
            <a href="${pageContext.request.contextPath}/DepositHistoryServlet" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-info me-3">
                            <i class="fas fa-credit-card fa-2x text-white"></i>
                        </div>
                        <h5 class="card-title text-danger">DEPOSIT</h5>
                    </div>
                </div>
            </a>
        </div>

        <!-- Card 4: Profile -->
        <div class="col-6 col-md-4 col-lg-3 mb-4">
            <a href="${pageContext.request.contextPath}/ProfileServlet" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-warning me-3">
                            <i class="fas fa-user fa-2x text-white"></i>
                        </div>
                        <h5 class="card-title text-danger">PROFILE</h5>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>