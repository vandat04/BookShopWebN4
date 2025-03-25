<%-- 
    Document   : detailProduct
    Created on : Mar 16, 2025, 8:01:31 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<%@ include file="/includes/headerForUser.jsp" %>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link href="${pageContext.request.contextPath}/css/detailProduct.css" rel="stylesheet">

<div class="container">
    <br>
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
                    <div class="error-message error">
                        <i class="fas fa-times-circle me-2"></i>
                        We Don't Have Enough Books
                    </div>
                </c:when>
                <c:when test="${err == '0'}">
                    <div class="error-message success">
                        <i class="fas fa-check-circle me-2"></i>
                        Add successfully
                    </div>
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

                            <div class="quantity-container mb-3">
                                <button type="button" class="quantity-btn" onclick="decreaseQuantity()">-</button>
                                <input type="number" name="numberOfBook" id="quantityInput" class="quantity-input" value="1" min="1" max="${sessionScope.bookDetailForUser.availableCopies}" required>
                                <button type="button" class="quantity-btn" onclick="increaseQuantity()">+</button>
                            </div>

                            <button type="submit" class="btn btn-primary">Add To Cart</button>
                        </form>
                    </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/users/login.jsp" class="btn btn-primary">Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
            
            
    <!-- Form nhập Description -->
    <br>
    <div class="section-container">
        <div class="section-box description-box">
            <h2>Description: </h2>
            <p>${sessionScope.bookDetailForUser.description}</p>
        </div>

        <div class="section-box reviews-box">
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
        </div>

        <!-- Form nhập feedback -->
        <c:if test="${not empty sessionScope.user}">
            <div class="section-box submit-review-box">
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
            </div>
        </c:if>
    </div>   
</div>
    
<!--    nút tăng giảm-->
        <script>
        function decreaseQuantity() {
            const input = document.getElementById('quantityInput');
            let value = parseInt(input.value);
            if (value > 1) {
                input.value = value - 1;
            }
        }

        function increaseQuantity() {
            const input = document.getElementById('quantityInput');
            let value = parseInt(input.value);
            const max = parseInt(input.max);
            if (value < max) {
                input.value = value + 1;
            }
        }
        </script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>