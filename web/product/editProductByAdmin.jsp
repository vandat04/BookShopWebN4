<%-- 
    Document   : editProductByAdmin
    Created on : Mar 17, 2025, 12:33:01 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<link href="${pageContext.request.contextPath}/css/editProductByAdmin.css" rel="stylesheet">

<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Book</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="bg-white p-4 border rounded shadow-lg">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <a href="${pageContext.request.contextPath}/includes/homeForAdmin.jsp" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left"></i> Back
                    </a>
                    <h2 class="text-center flex-grow-1">Edit Book</h2>
                </div>

                <!-- Hiển thị thông báo trạng thái cập nhật -->
                <c:if test="${not empty requestScope.upd}">
                    <div class="alert ${requestScope.upd == 'Update successfully' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                        <strong>${requestScope.upd}</strong>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Form chỉnh sửa sách -->
                <c:if test="${not empty requestScope.bookForEdit}">
                    <form action="${pageContext.request.contextPath}/EditProductServlet" method="post">
                        <div class="row">
                            <!-- Book ID -->
                            <div class="col-md-6 mb-3">
                                <label for="bookID" class="form-label">Book ID:</label>
                                <input type="text" class="form-control" id="bookID" name="bookID" value="${requestScope.bookForEdit.bookID}" readonly>
                            </div>

                            <!-- Title -->
                            <div class="col-md-6 mb-3">
                                <label for="title" class="form-label">Title:</label>
                                <input type="text" class="form-control" id="title" name="title" value="${requestScope.bookForEdit.title}" required>
                            </div>

                            <!-- Author -->
                            <div class="col-md-6 mb-3">
                                <label for="author" class="form-label">Author:</label>
                                <input type="text" class="form-control" id="author" name="author" value="${requestScope.bookForEdit.author}" required>
                            </div>

                            <!-- Genre -->
                            <div class="col-md-6 mb-3">
                                <label for="genre" class="form-label">Genre:</label>
                                <input type="text" class="form-control" id="genre" name="genre" value="${requestScope.bookForEdit.genre}" required>
                            </div>

                            <!-- Published Year -->
                            <div class="col-md-6 mb-3">
                                <label for="publishedYear" class="form-label">Published Year:</label>
                                <input type="number" class="form-control" id="publishedYear" name="publishedYear" value="${requestScope.bookForEdit.publishedYear}" required>
                            </div>

                            <!-- Publisher -->
                            <div class="col-md-6 mb-3">
                                <label for="publisher" class="form-label">Publisher:</label>
                                <input type="text" class="form-control" id="publisher" name="publisher" value="${requestScope.bookForEdit.publisher}" required>
                            </div>

                            <!-- Total Copies -->
                            <div class="col-md-6 mb-3">
                                <label for="totalCopies" class="form-label">Total Copies:</label>
                                <input type="number" class="form-control" id="totalCopies" name="totalCopies" value="${requestScope.bookForEdit.totalCopies}" required>
                            </div>

                            <!-- Available Copies -->
                            <div class="col-md-6 mb-3">
                                <label for="availableCopies" class="form-label">Available Copies:</label>
                                <input type="number" class="form-control" id="availableCopies" name="availableCopies" value="${requestScope.bookForEdit.availableCopies}" required>
                            </div>

                            <!-- Price -->
                            <div class="col-md-6 mb-3">
                                <label for="price" class="form-label">Price ($):</label>
                                <input type="number" class="form-control" id="price" name="price" value="${requestScope.bookForEdit.price}" required>
                            </div>

                            <!-- Image Path -->
                            <div class="col-md-6 mb-3">
                                <label for="imagePath" class="form-label">Image Path:</label>
                                <input type="text" class="form-control" id="imagePath" name="imagePath" value="${requestScope.bookForEdit.imagePath}">
                            </div>

                            <!-- Page Count -->
                            <div class="col-md-6 mb-3">
                                <label for="pageCount" class="form-label">Page Count:</label>
                                <input type="number" class="form-control" id="pageCount" name="pageCount" value="${requestScope.bookForEdit.pageCount}" required>
                            </div>

                            <!-- Language -->
                            <div class="col-md-6 mb-3">
                                <label for="language" class="form-label">Language:</label>
                                <input type="text" class="form-control" id="language" name="language" value="${requestScope.bookForEdit.language}" required>
                            </div>

                            <!-- Added Date -->
                            <div class="col-md-6 mb-3">
                                <label for="addedDate" class="form-label">Added Date:</label>
                                <input type="text" class="form-control" id="addedDate" name="addedDate" value="${requestScope.bookForEdit.addedDate}" readonly>
                            </div>

                            <!-- Description -->
                            <div class="col-12 mb-3">
                                <label for="description" class="form-label">Description:</label>
                                <textarea class="form-control" id="description" name="description" rows="3" required>${requestScope.bookForEdit.description}</textarea>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end">
                            <button type="submit" class="btn btn-primary shadow-sm">
                                <i class="fa-solid fa-save"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </c:if>

                <!-- Thông báo nếu không tìm thấy sách -->
                <c:if test="${empty requestScope.bookForEdit}">
                    <div class="alert alert-warning" role="alert">
                        No book found to edit.
                    </div>
                </c:if>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/YOUR_FA_KIT.js" crossorigin="anonymous"></script>
    </body>
</html>