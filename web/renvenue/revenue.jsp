<%-- 
    Document   : revenue
    Created on : Mar 17, 2025, 11:28:02 AM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<!-- Bootstrap 5 & Font Awesome -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<div class="container mt-5">
    <h2 class="mb-4">
        <a href="${pageContext.request.contextPath}/includes/homeForAdmin.jsp" class="btn btn-outline-secondary">
            <i class="fa-solid fa-arrow-left"></i> Back
        </a>
        All Revenue
    </h2>

    <table class="table table-striped table-hover table-bordered text-center">
        <thead class="table-dark">
            <tr>
                <th><i class="fa-solid fa-calendar-days"></i> Revenue Date</th>
                <th><i class="fa-solid fa-cart-shopping"></i> Total Sales</th>
                <th><i class="fa-solid fa-dollar-sign"></i> Total Revenue</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty requestScope.listRenvenue}">
                    <tr>
                        <td colspan="3" class="text-muted text-center">No revenue data available.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="revenue" items="${requestScope.listRenvenue}">
                        <tr>
                            <td>${revenue.revenueDate}</td>
                            <td><span class="badge bg-primary fs-6">${revenue.totalSales}</span></td>
                            <td><span class="fw-bold text-success">$${revenue.totalRevenue}</span></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>