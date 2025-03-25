<%-- 
    Document   : editProfileByAdmin
    Created on : Mar 15, 2025, 4:24:06 PM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/headerForAdmin.jsp" %>

<!-- Thêm link đến file CSS mới -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/editProfileByAdmin.css">

<div class="container mt-5">
    <h2 class="mb-4">
        <p class="text-center">Manage user profiles</p>
    </h2>
    <c:choose>
        <c:when test="${empty sessionScope.listUser}">
            <p class="text-danger">User list not found.</p>
        </c:when>
        <c:otherwise>
            <h3 class="mt-5">All Users</h3>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>User name</th>
                        <th>Full name</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Address</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${sessionScope.listUser}">
                        <tr>
                            <td>${user.userID}</td>
                            <td>${user.username}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>${user.address}</td>
                            <td>${user.admin ? 'Admin' : 'User'}</td>
                            <td> 
                                <c:if test="${user.userID != 1}">
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/EditProfileByAdmin?userID=${user.userID}&adminID=${sessionScope.user.userID}"                           
                                           class="btn btn-success btn-sm">Edit</a>

                                        <form action="${pageContext.request.contextPath}/EditProfileByAdmin" method="post">
                                            <input type="hidden" name="type" value="delete">
                                            <input type="hidden" name="adminID" value="${sessionScope.user.userID}">
                                            <input type="hidden" name="userID" value="${user.userID}">
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>

                                        <form action="${pageContext.request.contextPath}/EditProfileByAdmin" method="post">
                                            <input type="hidden" name="type" value="isadmin">
                                            <input type="hidden" name="adminID" value="${sessionScope.user.userID}">
                                            <input type="hidden" name="userID" value="${user.userID}">
                                            <input type="hidden" name="adminAccept" value="true">
                                            <button type="submit" class="btn btn-success btn-sm">Upgrade</button>
                                        </form>

                                        <form action="${pageContext.request.contextPath}/EditProfileByAdmin" method="post">
                                            <input type="hidden" name="type" value="isadmin">
                                            <input type="hidden" name="adminID" value="${sessionScope.user.userID}">
                                            <input type="hidden" name="userID" value="${user.userID}">
                                            <input type="hidden" name="adminAccept" value="false">
                                            <button type="submit" class="btn btn-danger btn-sm">Downgrade</button>
                                        </form>
                                    </div>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">