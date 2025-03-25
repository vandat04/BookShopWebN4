<%-- 
    Document   : salesHistoryForAdmin
    Created on : Mar 17, 2025, 12:56:11 AM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<div class="container mt-5">
    <h2 class="mb-4">
        <a href="${pageContext.request.contextPath}/includes/homeForAdmin.jsp" class="btn btn-outline-secondary">Back</a> Sales Management
    </h2>

    <!-- Phần 1: Danh sách các đơn hàng có Status là Pending Refund -->
    <h4>Pending Refund Requests</h4>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>Sale ID</th>
                <th>User ID</th>
                <th>Book ID</th>
                <th>Sale Date</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty sessionScope.listSale}">
                    <tr>
                        <td colspan="8" class="text-center text-muted">No pending refund requests found.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:set var="hasPendingRefunds" value="false"/>
                    <c:forEach var="sale" items="${sessionScope.listSale}">
                        <c:if test="${sale.status eq 'Pending Refund'}">
                            <c:set var="hasPendingRefunds" value="true"/>
                            <tr>
                                <td>${sale.saleID}</td>
                                <td>${sale.userID}</td>
                                <td>${sale.bookID}</td>
                                <td>${sale.saleDate}</td>
                                <td>${sale.quantity}</td>
                                <td>$${sale.totalPrice}</td>
                                <td>
                                    <span class="badge bg-warning">${sale.status}</span>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/ConfirmRefundServlet" method="post" class="d-inline">
                                        <input type="hidden" name="saleID" value="${sale.saleID}">
                                        <input type="hidden" name="status" value="Refunded">
                                        <button type="submit" class="btn btn-success btn-sm" 
                                                onclick="return confirmAction('confirm this refund?')">Confirm</button>
                                    </form>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${not hasPendingRefunds}">
                        <tr>
                            <td colspan="8" class="text-center text-muted">No pending refund requests found.</td>
                        </tr>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- Phần 2: Danh sách các đơn hàng có Status khác Pending Refund -->
    <h4 class="mt-5">Other Sales</h4>
    <a href="${pageContext.request.contextPath}/SortSalesServlet"> Sort By Status</a>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>Sale ID</th>
                <th>User ID</th>
                <th>Book ID</th>
                <th>Sale Date</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty sessionScope.listSale}">
                    <tr>
                        <td colspan="7" class="text-center text-muted">No other sales found.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:set var="hasOtherSales" value="false"/>
                    <c:forEach var="sale" items="${sessionScope.listSale}">
                        <c:if test="${sale.status ne 'Pending Refund'}">
                            <c:set var="hasOtherSales" value="true"/>
                            <tr>
                                <td>${sale.saleID}</td>
                                <td>${sale.userID}</td>
                                <td>${sale.bookID}</td>
                                <td>${sale.saleDate}</td>
                                <td>${sale.quantity}</td>
                                <td>$${sale.totalPrice}</td>
                                <td>
                                    <span class="badge 
                                        <c:choose>
                                            <c:when test="${sale.status eq 'Pending'}">bg-warning</c:when>
                                            <c:when test="${sale.status eq 'Completed'}">bg-success</c:when>
                                            <c:otherwise>bg-danger</c:otherwise>
                                        </c:choose>">
                                        ${empty sale.status ? 'Unknown' : sale.status}
                                    </span>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${not hasOtherSales}">
                        <tr>
                            <td colspan="7" class="text-center text-muted">No other sales found.</td>
                        </tr>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmAction(message) {
        return confirm("Are you sure you want to " + message);
    }
</script>