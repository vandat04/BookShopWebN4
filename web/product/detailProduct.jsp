<%-- 
    Document   : detailProduct
    Created on : Mar 16, 2025, 8:01:31 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container">
    <a href="${pageContext.request.contextPath}/includes/homeForUser.jsp" class="btn btn-secondary back-btn">Back to Home</a>
    <div class="row book-detail">
        <div class="col-md-4 image-section">
            <img src="${pageContext.request.contextPath}${sessionScope.bookDetailForUser.imagePath}" 
                 alt="${sessionScope.bookDetailForUser.title}" class="book-image">
        </div>
        <div class="col-md-8 info-section">
            <h1>${sessionScope.bookDetailForUser.title}</h1>
            <p><strong>Author: </strong> ${sessionScope.bookDetailForUser.author}</p>
            <p><strong>Genre: </strong> ${sessionScope.bookDetailForUser.genre}</p>
            <p><strong>Published Year: </strong> ${sessionScope.bookDetailForUser.publishedYear}</p>
            <p><strong>Publisher: </strong> ${sessionScope.bookDetailForUser.publisher}</p>
            <p><strong>Page Count: </strong> ${sessionScope.bookDetailForUser.pageCount}</p>
            <p><strong>Language: </strong> ${sessionScope.bookDetailForUser.language}</p>
            <p><strong>Price: </strong> ${sessionScope.bookDetailForUser.price} vnđ</p>
            <p><strong>Status: </strong> 
                <span class="${sessionScope.bookDetailForUser.availableCopies > 0 ? 'in-stock' : 'out-of-stock'}">
                    ${sessionScope.bookDetailForUser.availableCopies > 0 ? 'In Stock' : 'Out Of Stock'}
                </span>
            </p>
            <p><strong>Available Copies: </strong> ${sessionScope.bookDetailForUser.availableCopies} / ${sessionScope.bookDetailForUser.totalCopies}</p>

            <!-- Form Add to Cart hoặc nút Login -->
            <c:choose>
                <c:when test="${err == '1'}">
                    Add thất bại
                </c:when>
                <c:when test="${err == '0'}">
                    Add thành công
                </c:when>
                <c:otherwise>
                    <%-- Không hiển thị gì khi err là null hoặc giá trị khác --%>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <form action="${pageContext.request.contextPath}/AddToCardServlet" method="POST">
                        <input type="hidden" name="userID" value="${sessionScope.user.userID}">
                        <input type="hidden" name="bookID" value="${sessionScope.bookDetailForUser.bookID}">
                        <input type="text" name="numberOfBook" class="form-control mb-2" placeholder="Enter quantity" required>
                        <button type="submit" class="btn btn-primary">Add To Cart</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/users/login.jsp" class="btn btn-primary">Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="description">
        <h2>Description: </h2>
        <p>${sessionScope.bookDetailForUser.description}</p>
    </div>

    <div class="feedback-section">
        <h2>User Reviews: </h2>
        <div class="feedback-list">
            <c:choose>
                <c:when test="${empty sessionScope.feedback}">
                    <p class="text-muted">No reviews yet.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="fb" items="${sessionScope.feedback}">
                        <div class="feedback-item">
                            <p><strong>UserID: </strong> ${fb.userID}</p>
                            <p>Comment: ${fb.comment}</p>
                            <p>Rating: ${fb.rating}★</p>
                            <p class="date">${fb.feedbackDate}</p>
                            <hr/>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Form nhập feedback -->
        <c:if test="${not empty sessionScope.user}">
            <h3>Submit Your Review: </h3>
            <form action="${pageContext.request.contextPath}/SubmitFeedbackServlet" method="post" class="feedback-form">
                <input type="hidden" name="userID" value="${sessionScope.user.userID}">
                <input type="hidden" name="bookID" value="${sessionScope.bookDetailForUser.bookID}">
                <textarea name="comment" rows="6" class="form-control" required placeholder="Enter your review..."></textarea>
                <label>Rating:</label>
                <div class="rating">
                    <input type="radio" id="star5" name="rating" value="5" required>
                    <label for="star5">★</label>
                    <input type="radio" id="star4" name="rating" value="4">
                    <label for="star4">★</label>
                    <input type="radio" id="star3" name="rating" value="3">
                    <label for="star3">★</label>
                    <input type="radio" id="star2" name="rating" value="2">
                    <label for="star2">★</label>
                    <input type="radio" id="star1" name="rating" value="1">
                    <label for="star1">★</label>
                </div>
                <button type="submit" class="btn btn-primary btn-submit">Send</button>
            </form>
        </c:if>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>