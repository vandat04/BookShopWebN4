<%-- 
    Document   : editProfileByAdmin
    Created on : Mar 15, 2025, 4:24:06 PM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
    <h2 class="mb-4">
        <a href="${pageContext.request.contextPath}/includes/homeForAdmin.jsp" class="btn btn-outline-secondary">
            <i class="fa-solid fa-arrow-left"></i> Quay lại
        </a>
        Quản lý hồ sơ người dùng
    </h2>

    <!-- Kiểm tra nếu listUser không tồn tại -->
    <c:choose>
        <c:when test="${empty sessionScope.listUser}">
            <p class="text-danger">Không tìm thấy danh sách người dùng.</p>
        </c:when>
        <c:otherwise>
            <h3 class="mt-5">Tất cả người dùng</h3>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Tên người dùng</th>
                        <th>Họ và tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Địa chỉ</th>
                        <th>Vai trò</th>
                        <th>Hành động</th>
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
                                <div style="display: flex; gap: 3px;">
                                    <!-- Nút Edit -->
                                    <a href="${pageContext.request.contextPath}/EditProfileByAdmin?userID=${user.userID}&adminID=${sessionScope.user.userID}" 
                                       class="btn btn-success btn-sm" style="white-space: nowrap;">Sửa</a>

                                    <!-- Nút Delete -->
                                    <form action="${pageContext.request.contextPath}/EditProfileByAdmin" method="post" style="white-space: nowrap;">
                                        <input type="hidden" name="type" value="delete">
                                        <input type="hidden" name="adminID" value="${sessionScope.user.userID}">
                                        <input type="hidden" name="userID" value="${user.userID}">
                                        <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                    </form>

                                    <!-- Nút Up Level -->
                                    <form action="${pageContext.request.contextPath}/EditProfileByAdmin" method="post" style="white-space: nowrap;">
                                        <input type="hidden" name="type" value="isadmin">
                                        <input type="hidden" name="adminID" value="${sessionScope.user.userID}">
                                        <input type="hidden" name="userID" value="${user.userID}">
                                        <input type="hidden" name="adminAccept" value="true">
                                        <button type="submit" class="btn btn-success btn-sm">Nâng cấp</button>
                                    </form>

                                    <!-- Nút Down Level -->
                                    <form action="${pageContext.request.contextPath}/EditProfileByAdmin" method="post" style="white-space: nowrap;">
                                        <input type="hidden" name="type" value="isadmin">
                                        <input type="hidden" name="adminID" value="${sessionScope.user.userID}">
                                        <input type="hidden" name="userID" value="${user.userID}">
                                        <input type="hidden" name="adminAccept" value="false">
                                        <button type="submit" class="btn btn-danger btn-sm">Hạ cấp</button>
                                    </form>
                                </div>
                            </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">