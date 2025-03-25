<%-- 
    Document   : depositHistory
    Created on : Mar 16, 2025, 12:50:03 AM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/headerForAdmin.css">
<!-- Thêm vào phần head -->
<%@ include file="/includes/headerForAdmin.jsp" %>  
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/depositHistory.css" rel="stylesheet">
<!-- Thêm vào phần head -->
<br>
<h2 class="mb-4">
    Deposit History
</h2>         
<!-- Phần 1: Giao dịch đang chờ (Waiting) -->
<div class="section-container">
    <h4>Pending Deposits (Waiting)</h4>

    <c:choose>
        <c:when test="${empty sessionScope.listDeposit}">
            <div class="alert alert-warning" role="alert">
                No pending deposits found.
            </div>
        </c:when>
        <c:otherwise>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Deposit ID</th>
                        <th>User ID</th>
                        <th>Bank</th>
                        <th>Value</th>
                        <th>Deposit Date</th>
                            <c:if test="${sessionScope.user.admin}">
                            <th>Action</th>
                            </c:if>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="deposit" items="${sessionScope.listDeposit}">
                        <c:if test="${deposit.status == 'Waiting'}">
                            <c:choose>
                                <c:when test="${not sessionScope.user.admin && deposit.userID == sessionScope.user.userID}">
                                    <tr>
                                        <td>${deposit.depositID}</td>
                                        <td>${deposit.userID}</td>
                                        <td>${deposit.bankName}</td>
                                        <td>${deposit.value}</td>
                                        <td>${deposit.depositDate}</td>
                                    </tr>
                                </c:when>
                                <c:when test="${sessionScope.user.admin}">
                                    <tr>
                                        <td>${deposit.depositID}</td>
                                        <td>${deposit.userID}</td>
                                        <td>${deposit.bankName}</td>
                                        <td>${deposit.value}</td>
                                        <td>${deposit.depositDate}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/ConfirmDepositServlet" method="post">
                                                <input type="hidden" name="depositID" value="${deposit.depositID}">
                                                <button type="submit" class="btn btn-success btn-sm">Confirm</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
<!-- Phần 2: Các giao dịch khác (Không phải Waiting) -->
<div class="section-container">
    <h4 class="mt-5">Other Transactions</h4>

    <c:choose>
        <c:when test="${empty sessionScope.listDeposit}">
            <div class="alert alert-warning" role="alert">
                No other transactions found.
            </div>
        </c:when>
        <c:otherwise>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Deposit ID</th>
                        <th>User ID</th>
                        <th>Bank</th>
                        <th>Value</th>
                        <th>Deposit Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="deposit" items="${sessionScope.listDeposit}">
                        <c:if test="${deposit.status != 'Waiting'}">
                            <c:choose>
                                <c:when test="${not sessionScope.user.admin && deposit.userID == sessionScope.user.userID}">
                                    <tr>
                                        <td>${deposit.depositID}</td>
                                        <td>${deposit.userID}</td>
                                        <td>${deposit.bankName}</td>
                                        <td>${deposit.value}</td>
                                        <td>${deposit.depositDate}</td>
                                        <td>${deposit.status}</td>
                                    </tr>
                                </c:when>
                                <c:when test="${sessionScope.user.admin}">
                                    <tr>
                                        <td>${deposit.depositID}</td>
                                        <td>${deposit.userID}</td>
                                        <td>${deposit.bankName}</td>
                                        <td>${deposit.value}</td>
                                        <td>${deposit.depositDate}</td>
                                        <td>${deposit.status}</td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
<!-- Bootstrap JS và Font Awesome -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
