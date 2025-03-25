<%--
    Document   : footer
    Created on : Mar 15, 2025, 3:03:00 PM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css"/>
        
    </head>
    <body>
        <!-- Footer Section -->
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="footer-content">
                            <!-- Map column -->
                            <div class="footer-col">
                                <div class="map-wrapper">
                                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3835.8561681211872!2d108.25831637472791!3d15.968885884696201!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142116949840599%3A0x365b35580f52e8d5!2sFPT%20University%20Danang!5e0!3m2!1sen!2s!4v1742201358695!5m2!1sen!2s" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                </div>
                            </div>

                            <!-- Contact information column -->                           
                            <div class="footer-col">
                                <div class="contact-info">
                                    <!-- Logo and heading in same line -->
                                    <div class="text-center">
                                        <img src="images\fpt.jpg" alt="FPT Logo" class="footer-logo">
                                        <h5>Contact</h5>
                                    </div>

                                    <!-- Container for all contact information -->
                                    <div class="contact-info-container">
                                        <div class="contact-info-text">
                                            <p>
                                                <i class="fas fa-phone-alt"></i>
                                                <span>HotLine: 012345678</span>
                                            </p>
                                            <p>
                                                <i class="fas fa-envelope"></i>
                                                <span>Email: support@example.com</span>
                                            </p>
                                            <p>
                                                <i class="fas fa-map-marker-alt"></i>
                                                <span>Địa chỉ: FPT University Da Nang</span>
                                            </p>
                                        </div>

                                        <!-- Social media icons -->
                                        <div class="social-icons">
                                            <a href="https://www.facebook.com/@daihocfptdanang" target="_blank"><i class="fab fa-facebook-f"></i></a>
                                            <a href="#"><i class="fab fa-twitter"></i></a>
                                            <a href="#"><i class="fab fa-instagram"></i></a>
                                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Copyright section -->
                <div class="row">
                    <div class="col-12">
                        <div class="copyright">
                            <p>© 2025 FPT University. All rights reserved.</p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <div id="chatIcon" onclick="toggleChat()">
            <img src="https://cdn-icons-png.flaticon.com/512/138/138275.png" alt="Chat Icon">
        </div>

        <div id="chatWindow">
            <div id="chatHeader">
                <span>Chatbot Thuê Sách</span>
                <span id="closeChat" onclick="toggleChat()">×</span>
            </div>
            <div id="chatBox">
                <% 
                    @SuppressWarnings("unchecked")
                    List<String[]> conversation = (List<String[]>) request.getAttribute("conversation");
                    if (conversation != null) {
                        for (String[] entry : conversation) {
                            String userMessage = entry[0];
                            String botText = entry[1];
                            String imageUrls = entry[2];
                %>
                <div class="message user">
                    <span><%= userMessage %></span>
                </div>
                <div class="message bot">
                    <span><%= botText %></span>
                    <% if (imageUrls != null) { 
                        String[] images = imageUrls.split(",");
                        for (String imageUrl : images) { %>
                    <img src="images/<%= imageUrl %>" alt="Ảnh sách" onerror="this.style.display='none';">
                    <% } %>
                    <% } %>
                </div>
                <% 
                        }
                    }
                %>
            </div>
            <form id="chatForm" onsubmit="sendMessage(event)">
                <input type="text" id="messageInput" name="message" placeholder="Nhập câu hỏi..." required />
                <button type="submit">Gửi</button>
            </form>
        </div>


        <script>
            // Hàm bật/tắt cửa sổ chat
            function toggleChat() {
                var chatWindow = document.getElementById("chatWindow");
                if (chatWindow.style.display === "none" || chatWindow.style.display === "") {
                    chatWindow.style.display = "flex";
                } else {
                    chatWindow.style.display = "none";
                }
                scrollToBottom();
            }

            // Hàm cuộn xuống dưới cùng
            function scrollToBottom() {
                var chatBox = document.getElementById("chatBox");
                chatBox.scrollTop = chatBox.scrollHeight;
            }

            // Gửi tin nhắn bằng AJAX
            function sendMessage(event) {
                event.preventDefault();

                var messageInput = document.getElementById("messageInput");
                var userMessage = messageInput.value.trim();
                if (!userMessage)
                    return;

                // Hiển thị tin nhắn người dùng
                var chatBox = document.getElementById("chatBox");
                chatBox.innerHTML += '<div class="message user"><span>' + userMessage + '</span></div>';
                messageInput.value = "";

                // Thêm hiệu ứng Typing
                chatBox.innerHTML += '<div class="typing" id="typingIndicator"><div class="dot"></div><div class="dot"></div><div class="dot"></div></div>';
                scrollToBottom();

                // Gửi AJAX
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "ChatbotServlet", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        // Xóa hiệu ứng Typing
                        var typingIndicator = document.getElementById("typingIndicator");
                        if (typingIndicator)
                            typingIndicator.remove();

                        // Hiển thị phản hồi bot
                        var response = JSON.parse(xhr.responseText);
                        var botText = response.botText;
                        var imageUrls = response.imageUrls || "";

                        var botMessage = '<div class="message bot"><span>' + botText + '</span>';
                        if (imageUrls) {
                            imageUrls.split(",").forEach(function (url) {
                                botMessage += '<img src="images/' + url + '" alt="Ảnh sách" onerror="this.style.display=\'none\';">';
                            });
                        }
                        botMessage += '</div>';
                        chatBox.innerHTML += botMessage;
                        scrollToBottom();
                    }
                };
                xhr.send("message=" + encodeURIComponent(userMessage));
            }

            // Cuộn xuống dưới cùng khi tải trang
            window.onload = function () {
                scrollToBottom();
            };
            
            
            
        </script>
        <!-- Nút lướt lên đầu trang -->
        <div class="scroll-to-top" id="scrollToTop">
            <i class="fas fa-arrow-up"></i>
        </div>

        <!-- Bootstrap JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- JavaScript cho nút lướt lên đầu trang -->
        <script>
            // Hiển thị nút khi cuộn xuống 300px
            window.onscroll = function () {
                if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
                    document.getElementById("scrollToTop").classList.add("active");
                } else {
                    document.getElementById("scrollToTop").classList.remove("active");
                }
            };

            // Lướt lên đầu trang khi nhấp vào nút
            document.getElementById("scrollToTop").addEventListener("click", function () {
                window.scrollTo({
                    top: 0,
                    behavior: "smooth"
                });
            });
        </script>
        
        
<!--thêm mới-->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const chatIcon = document.getElementById('chatIcon');
                const chatWindow = document.getElementById('chatWindow');
                const chatHeader = document.getElementById('chatHeader');
                const closeChat = document.getElementById('closeChat');

                // Làm cho chatIcon có thể di chuyển
                makeDraggable(chatIcon);

                // Làm cho chatWindow có thể di chuyển qua chatHeader
                makeDraggable(chatWindow, chatHeader);

                // Xử lý sự kiện click cho chat icon để hiện/ẩn khung chat
                chatIcon.onclick = function() {
                    toggleChat();
                };

                // Xử lý sự kiện đóng chat
                closeChat.onclick = function() {
                    chatWindow.style.display = 'none';
                };

                // Cuộn xuống dưới cùng khi tải trang
                scrollToBottom();
            });

            // Hàm bật/tắt cửa sổ chat
            function toggleChat() {
                var chatWindow = document.getElementById("chatWindow");
                if (chatWindow.style.display === "none" || chatWindow.style.display === "") {
                    chatWindow.style.display = "flex";
                    // Đặt vị trí khung chat cố định gần icon
                    updateChatWindowPosition();
                } else {
                    chatWindow.style.display = "none";
                }
                scrollToBottom();
            }

            // Đặt vị trí khung chat gần icon
            function updateChatWindowPosition() {
                const chatIcon = document.getElementById('chatIcon');
                const chatWindow = document.getElementById('chatWindow');
                const iconRect = chatIcon.getBoundingClientRect();
                // Hiển thị khung chat phía trên và bên phải icon
                chatWindow.style.left = (iconRect.left + 70) + 'px'; // Dịch sang phải 70px
                chatWindow.style.top = (iconRect.top - chatWindow.offsetHeight - 10) + 'px'; // Phía trên icon
                // Giữ khung chat trong viewport
                keepInViewport(chatWindow);
            }

            // Hàm làm cho phần tử có thể di chuyển
            function makeDraggable(element, dragHandle = null) {
                const handle = dragHandle || element;
                let pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;

                handle.onmousedown = dragMouseDown;

                function dragMouseDown(e) {
                    e.preventDefault();
                    pos3 = e.clientX;
                    pos4 = e.clientY;
                    document.onmouseup = closeDragElement;
                    document.onmousemove = elementDrag;
                }

                function elementDrag(e) {
                    e.preventDefault();
                    pos1 = pos3 - e.clientX;
                    pos2 = pos4 - e.clientY;
                    pos3 = e.clientX;
                    pos4 = e.clientY;
                    element.style.top = (element.offsetTop - pos2) + "px";
                    element.style.left = (element.offsetLeft - pos1) + "px";
                    keepInViewport(element);
                    // Nếu là icon, cập nhật vị trí khung chat khi khung chat đang mở
                    if (element.id === 'chatIcon' && chatWindow.style.display === "flex") {
                        updateChatWindowPosition();
                    }
                }

                function closeDragElement() {
                    document.onmouseup = null;
                    document.onmousemove = null;
                }

                // Giữ phần tử trong viewport
                function keepInViewport(el) {
                    const rect = el.getBoundingClientRect();
                    const viewportWidth = window.innerWidth;
                    const viewportHeight = window.innerHeight;

                    if (rect.left < 0) el.style.left = "0px";
                    if (rect.right > viewportWidth) el.style.left = (viewportWidth - rect.width) + "px";
                    if (rect.top < 0) el.style.top = "0px";
                    if (rect.bottom > viewportHeight) el.style.top = (viewportHeight - rect.height) + "px";
                }
            }

            // Hàm cuộn xuống dưới cùng
            function scrollToBottom() {
                var chatBox = document.getElementById("chatBox");
                if (chatBox) {
                    chatBox.scrollTop = chatBox.scrollHeight;
                }
            }

            // Gửi tin nhắn bằng AJAX
            function sendMessage(event) {
                event.preventDefault();
                var messageInput = document.getElementById("messageInput");
                var userMessage = messageInput.value.trim();
                if (!userMessage) return;

                var chatBox = document.getElementById("chatBox");
                chatBox.innerHTML += '<div class="message user"><span>' + userMessage + '</span></div>';
                messageInput.value = "";

                chatBox.innerHTML += '<div class="typing" id="typingIndicator"><div class="dot"></div><div class="dot"></div><div class="dot"></div></div>';
                scrollToBottom();

                var xhr = new XMLHttpRequest();
                xhr.open("POST", "ChatbotServlet", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var typingIndicator = document.getElementById("typingIndicator");
                        if (typingIndicator) typingIndicator.remove();

                        var response = JSON.parse(xhr.responseText);
                        var botText = response.botText;
                        var imageUrls = response.imageUrls || "";

                        var botMessage = '<div class="message bot"><span>' + botText + '</span>';
                        if (imageUrls) {
                            imageUrls.split(",").forEach(function (url) {
                                botMessage += '<img src="images/' + url + '" alt="Ảnh sách" onerror="this.style.display=\'none\';">';
                            });
                        }
                        botMessage += '</div>';
                        chatBox.innerHTML += botMessage;
                        scrollToBottom();
                    }
                };
                xhr.send("message=" + encodeURIComponent(userMessage));
            }
        </script>
    </body>
</html>