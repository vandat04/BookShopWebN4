<%-- 
    Document   : productForAdmin
    Created on : Mar 23, 2025
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/productForAdmin.css">

<div class="container mt-4">
    <div class="row align-items-center mb-4">
        
        <div class="col-md-12 text-center">
            <h2 class="mb-0">Book List</h2>
        </div>
    </div>

    <div class="table-container">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr> 
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Genre</th>
                    <th>Year</th>
                    <th>Publisher</th>
                    <th>Description</th>
                    <th>Total Copies</th>
                    <th>Available Copies</th>
                    <th>Price</th>
                    <th>Page Count</th>
                    <th>Language</th>
                    <th>Added Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%-- Lặp qua danh sách sách bằng JSTL --%>
                <c:forEach var="book" items="${listBook}">
                    <tr>
                        <td><c:out value="${book.bookID}" /></td>
                        <td><c:out value="${book.title}" /></td>
                        <td><c:out value="${book.author}" /></td>
                        <td><c:out value="${book.genre}" /></td>
                        <td><c:out value="${book.publishedYear}" /></td>
                        <td><c:out value="${book.publisher}" /></td>
                        <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            <c:out value="${book.description}" />
                        </td>
                        <td><c:out value="${book.totalCopies}" /></td>
                        <td><c:out value="${book.availableCopies}" /></td>
                        <td>$<c:out value="${book.price}" /></td>
                        <td><c:out value="${book.pageCount}" /></td>
                        <td><c:out value="${book.language}" /></td>
                        <td><c:out value="${book.addedDate}" /></td>
                        <td>
                            <!-- Edit Form -->
                            <form action="${pageContext.request.contextPath}/EditProductServlet" method="get" class="d-inline">
                                <input type="hidden" name="bookID" value="${book.bookID}">
                                <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                            </form>

                            <!-- Delete Form -->
                            <form action="${pageContext.request.contextPath}/DeleteProductServlet" method="get" class="d-inline" 
                                  onsubmit="return confirmDelete('${book.bookID}');">
                                <input type="hidden" name="bookID" value="${book.bookID}">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function confirmDelete(bookID) {
        return confirm("Are you sure you want to delete this book (ID: " + bookID + ")?");
    }
</script>

<!--<style>
    body {
        font-size: 16px;
    }
    .table-container {
        width: 100%;
        overflow-x: auto;
    }
    table {
        width: 100%;
        font-size: 14px;
        white-space: nowrap;
    }
    th, td {
        text-align: center;
        vertical-align: middle;
        padding: 10px;
    }
    .btn-sm {
        font-size: 12px;
    }
</style>-->