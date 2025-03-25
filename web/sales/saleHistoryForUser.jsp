<%-- 
    Document   : salesHistoryForUser
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
        <a href="${pageContext.request.contextPath}/includes/homeForUser.jsp" class="btn btn-outline-secondary">Back</a> Your Sales
    </h2>

    <!-- Hiển thị thông báo lỗi nếu không đủ tiền -->
    <c:if test="${not empty requestScope.err and requestScope.err eq 'Not Enough Money'}">
        <p class="text-danger">Nạp thêm tiền, số dư không đủ!</p>
    </c:if>
        
    <a href="${pageContext.request.contextPath}/SortSalesServlet"> Sort By Status</a>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>Sale ID</th>
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
                        <td colspan="7" class="text-center text-muted">No sales found.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:set var="hasSales" value="false"/>
                    <c:forEach var="sale" items="${sessionScope.listSale}">
                        <c:if test="${sale.userID eq sessionScope.user.userID}">
                            <c:set var="hasSales" value="true"/>
                            <tr>
                                <td>${sale.saleID}</td>
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
                                <td>
                                    <c:choose>
                                        <c:when test="${sale.status eq 'Pending'}">
                                            <form action="${pageContext.request.contextPath}/PayOrCancelServlet" method="post" class="d-inline">
                                                <input type="hidden" name="type" value="Completed">
                                                <input type="hidden" name="saleID" value="${sale.saleID}">
                                                <input type="hidden" name="status" value="Completed">
                                                <button type="submit" class="btn btn-success btn-sm" 
                                                        onclick="return confirmAction('complete this sale?')">Completed</button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/PayOrCancelServlet" method="post" class="d-inline">
                                                <input type="hidden" name="type" value="CancelledPending">
                                                <input type="hidden" name="saleID" value="${sale.saleID}">
                                                <input type="hidden" name="status" value="Cancelled">
                                                <button type="submit" class="btn btn-danger btn-sm" 
                                                        onclick="return confirmAction('cancel this sale?')">Cancel</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${sale.status eq 'Completed'}">
                                            <form action="${pageContext.request.contextPath}/PayOrCancelServlet" method="post" class="d-inline">
                                                <input type="hidden" name="type" value="Return">
                                                <input type="hidden" name="saleID" value="${sale.saleID}">
                                                <input type="hidden" name="status" value="Pending Refund">
                                                <button type="submit" class="btn btn-danger btn-sm" 
                                                        onclick="return confirmAction('request a refund?')">Refund</button>
                                            </form>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${not hasSales}">
                        <tr>
                            <td colspan="7" class="text-center text-muted">No sales found.</td>
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