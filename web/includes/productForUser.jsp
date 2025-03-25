<%-- 
    Document   : productForUser
    Created on : Mar 23, 2025
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/productForUser.css">

<div class="container">
    <hr/>
    <h2 class="text-center my-4">List Book</h2>
    
    <%-- Kiểm tra danh sách sách có rỗng hay không --%>
    <c:choose>
        <c:when test="${not empty listBook}">
            <div class="row">
                <%-- Lặp qua danh sách sách --%>
                <c:forEach var="book" items="${listBook}" varStatus="status">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body">
                                <img src="${pageContext.request.contextPath}${book.imagePath}" 
                                     alt="${book.title}" class="img-fluid"/>
                                <h5 class="card-title">Title: ${book.title}</h5>
                                <p class="card-text">Genre: ${book.genre}</p>
                                <p class="card-text">Price: ${book.price}</p>
                                <p class="card-text">Language: ${book.language}</p>
                            </div>
                            <div class="card-footer text-center">  
                                <form action="${pageContext.request.contextPath}/GetDetailsServlet" method="POST">
                                    <input type="hidden" name="userID" value="${user.userID}">
                                    <input type="hidden" name="bookID" value="${book.bookID}">
                                    <button type="submit" class="btn btn-primary">View Details</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <%-- Xuống hàng sau mỗi 3 sản phẩm --%>
                    <c:if test="${(status.index + 1) % 3 == 0}">
                        </div><div class="row">
                    </c:if>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <p class="text-center">No Books Found</p>
        </c:otherwise>
    </c:choose>
</div>