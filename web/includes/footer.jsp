<%--
    Document   : footer
    Created on : Mar 15, 2025, 3:03:00 PM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            footer {
                background: linear-gradient(135deg, #f8f9fa, #e9ecef); /* Gradient background */
                padding: 30px 0 20px; /* Increased padding */
                box-shadow: 0 -3px 10px rgba(0, 0, 0, 0.1); /* Enhanced shadow */
                position: relative; /* For scroll-to-top button positioning */
            }

            .footer-content {
                display: flex;
                justify-content: center;
                align-items: stretch; /* Đảm bảo các cột có chiều cao bằng nhau */
                flex-wrap: wrap;
            }

            .footer-col {
                flex: 1;
                max-width: 450px; /* Chiều rộng tối đa */
                margin: 0 15px;
                display: flex;
                align-items: stretch;
            }

            .footer-logo {
                max-width: 150px;
                margin-bottom: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .contact-info {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
                transition: transform 0.3s ease;
                height: 100%; /* Chiều cao 100% */
                width: 100%; /* Chiều rộng 100% */
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .contact-info:hover {
                transform: translateY(-5px);
            }

            .contact-info h5 {
                color: #007bff;
                font-weight: bold;
                margin-bottom: 15px;
                font-size: 1.2rem;
                border-bottom: 2px solid #e9ecef;
                padding-bottom: 8px;
                text-align: center;
            }

            .contact-info-text {
                /* Căn giữa khối văn bản */
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .contact-info p {
                margin: 8px 0;
                color: #333;
                /* Tạo phần đệm bên trong trái để căn chỉnh các icon */
                display: flex;
                width: 100%;
                max-width: 300px;
            }

            .contact-info p i {
                color: #007bff;
                margin-right: 10px;
                width: 20px; /* Chiều rộng cố định cho icon */
                text-align: center;
            }

            .contact-info p span {
                flex: 1; /* Phần nội dung văn bản */
            }

            .map-wrapper {
                width: 100%;
                height: 100%; /* Chiều cao 100% */
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
                display: flex; /* Sử dụng flexbox */
                align-items: stretch; /* Đảm bảo con có chiều cao bằng cha */
            }

            .map-wrapper:hover {
                transform: scale(1.01);
            }

            .map-wrapper iframe {
                width: 100%;
                min-height: 275px; /* Chiều cao tối thiểu */
                height: 100%;
                border: none;
                display: block;
                flex: 1; /* Mở rộng để lấp đầy không gian có sẵn */
            }

            .social-icons {
                margin-top: 15px;
                text-align: center;
            }

            .social-icons a {
                display: inline-block;
                width: 36px;
                height: 36px;
                background-color: #007bff;
                color: white;
                border-radius: 50%;
                text-align: center;
                line-height: 36px;
                margin: 0 5px;
                transition: all 0.3s ease;
            }

            .social-icons a:hover {
                background-color: #0056b3;
                transform: translateY(-3px);
            }

            .copyright {
                margin-top: 20px;
                padding-top: 15px;
                border-top: 1px solid #dee2e6;
                text-align: center;
                color: #6c757d;
                font-size: 0.9rem;
            }

            /* Nút lướt lên đầu trang */
            .scroll-to-top {
                position: fixed;
                bottom: 20px;
                right: 20px;
                width: 50px;
                height: 50px;
                background-color: #007bff;
                color: white;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                cursor: pointer;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .scroll-to-top.active {
                opacity: 1;
                visibility: visible;
            }

            .scroll-to-top:hover {
                background-color: #0056b3;
                transform: translateY(-3px);
            }

            /* Media query để đảm bảo responsive */
            @media (max-width: 991px) {
                .footer-col {
                    margin: 10px 0;
                    width: 100%;
                    max-width: 100%;
                }

                .map-wrapper iframe {
                    height: 250px;
                }
            }
        </style>
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
                                    <!-- Logo image -->
                                    <div class="text-center">
                                        <img src="images\fpt.jpg" alt="FPT Logo" class="footer-logo">
                                    </div>

                                    <h5>Contact</h5>

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
    </body>
</html>