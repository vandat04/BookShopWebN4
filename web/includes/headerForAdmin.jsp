<%-- 
    Document   : header
    Created on : Mar 15, 2025, 3:02:48 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/headerForAdmin.css">

<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="/CSS/main.css">

<!-- Header with Logo and Logout -->
<div class="container-fluid bg-light py-3">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/includes/homeForAdmin.jsp">
            <p class="header-title">Management System</p>
        </a>
        <!-- Simplified Logout Button -->
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="text-decoration-none">
            <div class="logout-btn d-flex align-items-center">
                <span class="logout-title text-danger me-2">LOGOUT</span>
                <span class="logout-username text-muted">(${sessionScope.username})</span>
            </div>
        </a>
    </div>
</div>

<!-- Menu as Cards -->
<div class="container custom-container mt-4">
    <div class="row">
        
        <!-- Card 1: List sách -->
        <div class="col-6 col-md-4 col-lg-2 mb-4">
            <a href="${pageContext.request.contextPath}/includes/homeForAdmin.jsp" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-primary me-3">
                            <i class="fas fa-book fa-2x text-white"></i>
                        </div>
                        <div>
                            <h5 class="card-title text-danger">LIST ALL BOOK</h5>
                            <p class="card-text">View Details</p>
                            <small class="text-muted">List of books in the store</small>
                        </div>
                    </div>
                </div>
            </a>
        </div>
                
        <!-- Card 2: Tổng thu -->
        <div class="col-6 col-md-4 col-lg-2 mb-4">
            <a href="${pageContext.request.contextPath}/RenvenueServlet" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-success me-3">
                            <i class="fas fa-money-bill-wave fa-2x text-white"></i>
                        </div>
                        <div>
                            <h5 class="card-title text-danger">TOTAL REVENUE</h5>
                            <p class="card-text">View Details</p>
                            <small class="text-muted">Total store revenue</small>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        

        <!-- Card 3: List User -->
        <div class="col-6 col-md-4 col-lg-2 mb-4">
            <a href="${pageContext.request.contextPath}/ProfileServlet" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-warning me-3">
                            <i class="fas fa-users fa-2x text-white"></i>
                        </div>
                        <div>
                            <h5 class="card-title text-danger">LIST USER</h5>
                            <p class="card-text">View Details</p>
                            <small class="text-muted">List of users</small>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Card 4: Đơn mua -->
        <div class="col-6 col-md-4 col-lg-2 mb-4">
            <a href="${pageContext.request.contextPath}/SaleHistoryServlet" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-info me-3">
                            <i class="fas fa-shopping-cart fa-2x text-white"></i>
                        </div>
                        <div>
                            <h5 class="card-title text-danger">PURCHASE ORDER</h5>
                            <p class="card-text">View Details</p>
                            <small class="text-muted">Order history</small>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Card 5: Yêu cầu nạp tiền -->
        <div class="col-6 col-md-4 col-lg-2 mb-4">
            <a href="${pageContext.request.contextPath}/DepositHistoryServlet" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-secondary me-3">
                            <i class="fas fa-credit-card fa-2x text-white"></i>
                        </div>
                        <div>
                            <h5 class="card-title text-danger">DEPOSIT REQUEST</h5>
                            <p class="card-text">View Details</p>
                            <small class="text-muted">List of deposit requests</small>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Card 6: Add New Book -->
        <div class="col-6 col-md-4 col-lg-2 mb-4">
            <a href="${pageContext.request.contextPath}/product/addProductByAdmin.jsp" class="text-decoration-none">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon-circle bg-secondary me-3">
                            <i class="fas fa-plus-circle fa-2x text-white"></i>
                        </div>
                        <div>
                            <h5 class="card-title text-danger">ADD NEW BOOK</h5>
                            <p class="card-text">View Details</p>
                            <small class="text-muted">Add new book</small>
                        </div>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Add this CSS to your main.css file -->
<!--<style>
    /* Header title styling without LED animation */
    .header-title {
        font-size: 2rem;
        font-weight: bold;
        color: #000000; /* Black color */
        margin: 0;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    /* Icon circle styling */
    .icon-circle {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* Card styling */
    .card {
        border: none;
        border-radius: 10px;
        transition: transform 0.2s;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .card-title {
        font-size: 1rem;
        font-weight: bold;
        margin-bottom: 0.5rem;
    }

    .card-text {
        font-size: 0.9rem;
        font-weight: bold;
        margin-bottom: 0.25rem;
    }

    .text-muted {
        font-size: 0.75rem;
    }

    /* Adjust card body padding for smaller cards */
    .card-body {
        padding: 1rem;
    }

    /* Logout button styling */
    .logout-btn {
        background-color: #f8d7da; /* Light red background */
        border: 1px solid #f5c6cb;
        border-radius: 5px;
        padding: 0.5rem 1rem;
        transition: background-color 0.3s;
    }

    .logout-btn:hover {
        background-color: #f1b0b7; /* Slightly darker red on hover */
    }

    .logout-title {
        font-size: 1rem;
        font-weight: bold;
    }

    .logout-username {
        font-size: 0.9rem;
    }
</style>-->