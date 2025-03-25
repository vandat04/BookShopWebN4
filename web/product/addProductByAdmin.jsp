<%-- 
    Document   : addProductByAdmin
    Created on : Mar 17, 2025, 1:16:24 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/headerForAdmin.jsp" %>

<!DOCTYPE html>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/addProductByAdmin.css">

<div class="container mt-5">
    <div class="bg-white p-4 border rounded shadow-lg">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-center flex-grow-1">Add New Book</h2>
        </div>

        <!-- Hiển thị thông báo thành công nếu có -->
        <c:if test="${not empty requestScope.addSuccess}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong>${requestScope.addSuccess}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/AddProductServlet" method="post">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="title" class="form-label">Title:</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="author" class="form-label">Author:</label>
                    <input type="text" class="form-control" id="author" name="author" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="genre" class="form-label">Genre:</label>
                    <input type="text" class="form-control" id="genre" name="genre" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="publishedYear" class="form-label">Published Year:</label>
                    <input type="number" class="form-control" id="publishedYear" name="publishedYear" min="1000" max="2100" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="publisher" class="form-label">Publisher:</label>
                    <input type="text" class="form-control" id="publisher" name="publisher" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="language" class="form-label">Language:</label>
                    <input type="text" class="form-control" id="language" name="language" required>
                </div>

                <div class="col-12 mb-3">
                    <label for="description" class="form-label">Description:</label>
                    <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="totalCopies" class="form-label">Total Copies:</label>
                    <input type="number" class="form-control" id="totalCopies" name="totalCopies" min="0" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="availableCopies" class="form-label">Available Copies:</label>
                    <input type="number" class="form-control" id="availableCopies" name="availableCopies" min="0" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="price" class="form-label">Price ($):</label>
                    <input type="number" step="0.01" class="form-control" id="price" name="price" min="0" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label for="imagePath" class="form-label">Image Path:</label>
                    <input type="text" class="form-control" id="imagePath" name="imagePath">
                </div>

                <div class="col-md-6 mb-3">
                    <label for="pageCount" class="form-label">Page Count:</label>
                    <input type="number" class="form-control" id="pageCount" name="pageCount" min="1" required>
                </div>
            </div>

            <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-primary shadow-sm">
                    <i class="fa-solid fa-plus"></i> Add New Book
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/YOUR_FA_KIT.js" crossorigin="anonymous"></script>