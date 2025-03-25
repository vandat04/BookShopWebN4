<%-- 
    Document   : banner
    Created on : Mar 15, 2025, 3:02:55 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lora:wght@700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<!-- Link to external CSS file -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/banner.css">

<!-- Banner Section -->
<section class="jumbotron">
    
    
    <!-- Content area with image and carousel -->
    <div class="banner-content">
        <!-- Banner image on the left (2/3 width) -->
        <div class="banner-image">
            <img src="<%=request.getContextPath()%>/images/4.png" alt="BookShop">
        </div>
        
        <!-- Image carousel on the right (1/3 width) -->
        <div class="banner-carousel">
            <!-- All slides - each represents one full image -->
            <div class="carousel-slide active">
                <img src="<%=request.getContextPath()%>/images/CleanCode.png" alt="Book 1">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/ThePragmaticProgrammer.png" alt="Book 2">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/IntroductionToAlgorithms.png" alt="Book 3">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/DesignPatterns.png" alt="Book 4">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/1984.jpg" alt="Book 5">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/ToKillAMockingbird.jpg" alt="Book 6">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/TheGreatGatsby.png" alt="Book 7">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/PrideAndPrejudice.jpg" alt="Book 8">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/NhatKyDangThuyTram.jpg" alt="Book 9">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/TatDen.jpg" alt="Book 10">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/SoDo.jpg" alt="Book 11">
            </div>
            <div class="carousel-slide">
                <img src="<%=request.getContextPath()%>/images/DeMenPhieuLuuKy.jpg" alt="Book 12">
            </div>
            
<!--             Current slide counter 
            <div class="slide-counter" id="slideCounter">1 / 12</div>-->
            
            <!-- Navigation arrows -->
            <div class="carousel-nav">
                <button class="carousel-prev" onclick="moveSlide(-1)">&#10094;</button>
                <button class="carousel-next" onclick="moveSlide(1)">&#10095;</button>
            </div>
            
            <!-- Indicators -->
            <div class="carousel-indicators" id="carouselIndicators">
                <!-- Will be populated by JavaScript -->
            </div>
        </div>
    </div>
</section>

<!-- JavaScript for carousel functionality -->
<script>

    let currentSlideIndex = 0;
    const slides = document.querySelectorAll(".carousel-slide");
    const totalSlides = slides.length;

    // Debug: Kiểm tra số lượng slide
    console.log("Total slides:", totalSlides);
    if (totalSlides === 0) {
        console.error("Không tìm thấy slide nào. Kiểm tra lại .carousel-slide elements.");
    }

    // Initialize indicators
    const indicatorsContainer = document.getElementById("carouselIndicators");
    for (let i = 0; i < totalSlides; i++) {
        const indicator = document.createElement("span");
        indicator.className = i === 0 ? "indicator active" : "indicator";
        indicator.addEventListener("click", () => currentSlide(i));
        indicatorsContainer.appendChild(indicator);
    }

    function moveSlide(direction) {
        console.log("Moving slide, direction:", direction); // Debug
        showSlide(currentSlideIndex + direction);
    }

    function currentSlide(index) {
        console.log("Current slide selected:", index); // Debug
        showSlide(index);
    }

    function showSlide(index) {
        // Handle loop around
        if (index >= totalSlides) index = 0;
        if (index < 0) index = totalSlides - 1;

        // Hide all slides
        slides.forEach(slide => {
            slide.classList.remove("active");
        });

        // Show the current slide
        slides[index].classList.add("active");

        // Update indicators
        const indicators = document.querySelectorAll(".indicator");
        indicators.forEach((indicator, i) => {
            indicator.classList.toggle("active", i === index);
        });

        // Update counter
        const slideCounter = document.getElementById("slideCounter");
        if (slideCounter) {
            slideCounter.textContent = `${index + 1} / ${totalSlides}`; // Loại bỏ khoảng trắng thừa
            console.log("Slide counter updated:", slideCounter.textContent); // Debug
        } else {
            console.error("Không tìm thấy slideCounter.");
        }

        currentSlideIndex = index;
        console.log("Current slide index:", currentSlideIndex); // Debug
    }

    // Auto-rotate slides
    let slideInterval = setInterval(() => {
        console.log("Auto moving slide"); // Debug
        moveSlide(1);
    }, 5000);

    // Pause auto-rotation when hovering over carousel
    const carousel = document.querySelector(".banner-carousel");
    carousel.addEventListener("mouseenter", () => {
        clearInterval(slideInterval);
        console.log("Auto slide paused"); // Debug
    });

    carousel.addEventListener("mouseleave", () => {
        slideInterval = setInterval(() => {
            moveSlide(1);
        }, 5000);
        console.log("Auto slide resumed"); // Debug
    });

    // Hiển thị slide đầu tiên
    showSlide(0);

</script>