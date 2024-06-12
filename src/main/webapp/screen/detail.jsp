<%@ page import="com.example.dto.StoreDTO" %>
<%@ page import="com.example.dto.ReviewDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    StoreDTO store = (StoreDTO) request.getAttribute("store");
    int storeID = store.getStore_id();
    String storeLngLat = store.getLng_n_lat();
    String storeDescription = store.getDescription().replaceAll("(\r\n|\n)", "<br>");
    String[] storeCategoryArr = store.getCategory().split(",");
    List<ReviewDTO> reviewList = (List<ReviewDTO>) request.getAttribute("reviewList");
    int total = 0;
    int cnt = 0;
    for(ReviewDTO review : reviewList){
        if(review.getStore_id() == storeID){
            total += review.getRating();
            cnt ++;
        }
    }
    float avgRating = Math.round((float) total /cnt * 10) / 10.0f;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>DETAIL</title>
    <link rel="stylesheet" href="./css/detail.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<header class="nav">
    <div class="nav-container">
        <a href="<%=request.getContextPath()%>/">
            <div class="nav-logo">
                <i class='bx bxs-bong' style="margin-right: 10px"></i>
                <div class="nav-logo-text">SOJU HELPER</div>
            </div>
        </a>
        <ul class="nav-list">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/profile" class="nav-text">${sessionScope.user.username}님 환영합니다.</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/screen/logout.jsp" class="logout-btn">로그아웃</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/login_or_register" class="nav-text">로그인</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</header>
<main class="main-screen">
    <div class="slider-container">
        <button class="slider-button left" onclick="slideToPrevImage()">&#10094;</button>
        <div class="slider">
            <div class="slider-track">
                <img src="imgServlet?store_id=${requestScope.store.store_id}" />
                <img src="imgServlet?store_id=${requestScope.store.store_id}" />
                <img src="imgServlet?store_id=${requestScope.store.store_id}" />
                <img src="imgServlet?store_id=${requestScope.store.store_id}" />
            </div>
        </div>
        <button class="slider-button right" onclick="slideToNextImage()">&#10095;</button>
    </div>
    <div class="content-container">
        <div class="store-title-container">
            <div class="store-title-rating">
                <div>${requestScope.store.store_name}</div>
                <div class="store-rating"><%=avgRating%></div>
            </div>
            <div class="store-category-container">
                <div class="store-category"># <%=storeCategoryArr[0]%></div>
                <div class="store-category"># <%=storeCategoryArr[1]%></div>
            </div>
            <div class="review-count">
                <a href="#" id="review-link"><i class="bx bxs-star"></i> 리뷰(<%= reviewList != null ? reviewList.size() : 0 %>)</a>
            </div>
        </div>
        <div class="detail-first">
            <div class="store-description-container">
                <div>
                    <h1>가게 정보</h1>
                    <p>
                        <%=storeDescription%>
                    </p>
                </div>
                <div class="store-option-icon">
                    <div class="icon-n-detail"><i class="bx bx-map"></i>${requestScope.store.location}</div>
                    <div class="icon-n-detail"><i class="bx bx-phone"></i> ${requestScope.store.store_number}</div>
                </div>
            </div>
            <div id="map" style="width: 48%; height: 400px; background-color: midnightblue"></div>
        </div>
        <div class="review-list-container" id="review">
            <div class="review-title">
                <h1><%= reviewList != null ? reviewList.size() : 0 %>건의 방문자 평가</h1>
                <a href="#" id="openDialogBtn">리뷰 작성하기</a>
            </div>
            <div class="review-box">
                <div class="rating-statistic">
                    <div class="avg-rating">
                        <i class="bx bxs-star" style="color: gold"></i>
                        <span><%=avgRating%>점</span>
                    </div>
                    <div id="chartContainer">
                        <canvas id="ratingChart"></canvas>
                    </div>
                </div>
                <div class="review-list">
                <c:choose>
                    <c:when test="${not empty requestScope.reviewList}">
                        <c:forEach var="review" items="${requestScope.reviewList}">
                                <div class="review-item-container">
                                    <div class="review-item-title">
                                        <div id="nickname">${review.person_name}</div>
                                        <div class="rating">
                                            <c:forEach var="i" begin="1" end="5">
                                                <c:choose>
                                                    <c:when test="${i <= review.rating}">
                                                        <i class="bx bxs-star"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bx bx-star"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="review-item-content">
                                            ${review.content}
                                    </div>
                                    <div class="review-time">
                                        2024년 6월 1일
                                    </div>
                                </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-review">
                            등록된 리뷰가 존재하지 않습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
                </div>
            </div>
        </div>
<%--        <div class="review-write-container">--%>
<%--            <div class="review-title">--%>
<%--                <h1>리뷰 작성하기</h1>--%>
<%--            </div>--%>
<%--            <div>--%>
<%--                <form name="rating-form" id="rating-form" onsubmit="return validationBeforeSubmit()" method="post">--%>
<%--                    <div class="rating-field">--%>
<%--                        <div class="star-rating">--%>
<%--                            <span data-value="1">★</span>--%>
<%--                            <span data-value="2">★</span>--%>
<%--                            <span data-value="3">★</span>--%>
<%--                            <span data-value="4">★</span>--%>
<%--                            <span data-value="5">★</span>--%>
<%--                        </div>--%>
<%--                        <span class="text-bold">별점을 선택해주세요.</span>--%>
<%--                        <input type="hidden" name="reviewStar" id="reviewStar" value="0" />--%>
<%--                    </div>--%>
<%--                    <div>--%>
<%--                        <textarea--%>
<%--                                class="form-control"--%>
<%--                                type="text"--%>
<%--                                id="reviewContents"--%>
<%--                                name="reviewContents"--%>
<%--                                placeholder="좋은 리뷰를 남겨주시면 가게에 큰 힘이 됩니다."--%>
<%--                                onfocus="validationCheck()"></textarea>--%>
<%--                    </div>--%>
<%--                    <input type="submit" value="리뷰 등록하기" onclick="validationCheck()"/>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>

        <div id="reviewDialog" class="dialog">
            <div class="dialog-content">
                <span id="closeDialogBtn" class="close-btn">&times;</span>
                <div class="review-title">
                    <h1>리뷰 작성하기</h1>
                </div>
                <form name="rating-form" id="rating-form" onsubmit="return validationBeforeSubmit()" method="post">
                    <div class="rating-field">
                        <div class="star-rating">
                            <span data-value="1">★</span>
                            <span data-value="2">★</span>
                            <span data-value="3">★</span>
                            <span data-value="4">★</span>
                            <span data-value="5">★</span>
                        </div>
                        <span class="text-bold">별점을 선택해주세요.</span>
                        <input type="hidden" name="reviewStar" id="reviewStar" value="0" />
                    </div>
                    <div>
                        <textarea
                                class="form-control"
                                type="text"
                                id="reviewContents"
                                name="reviewContents"
                                placeholder="좋은 리뷰를 남겨주시면 가게에 큰 힘이 됩니다."
                                onfocus="validationCheck()"></textarea>
                    </div>
                    <input type="submit" value="리뷰 등록하기" onclick="validationCheck()"/>
                </form>

            </div>
        </div>
    </div>
</main>
<footer class="footer">
    <div class="footer-container">
        <ul class="footer-list">
            <li class="footer-list-item">
                <a href="#">인터넷DB응용 4팀</a>
            </li>
            <li class="footer-list-item">
                <a href="#">공재성</a>
            </li>
            <li class="footer-list-item">
                <a href="#">임성균</a>
            </li>
            <li class="footer-list-item">
                <a href="#">최지인</a>
            </li>
        </ul>
    </div>
    <div class="footer-logo">
        <div class="footer-logo-icon">
            <i class="bx bxl-microsoft"></i>
        </div>
        <div class="footer-logo-text">
            <div>InternetDB</div>
        </div>
    </div>
</footer>
<script
        type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f8f6f6817f7cfcd384bc8e7e9378fb1a"></script>
<script>
    const sliderTrack = document.querySelector(".slider-track");
    const images = document.querySelectorAll(".slider img");
    const imageCount = images.length;
    let imageWidth = 300;
    let currentIndex = 0;

    function slideToNextImage() {
        currentIndex++;
        if (currentIndex >= imageCount - 1) {
            currentIndex = 0;
        }
        updateSliderPosition();
    }

    function slideToPrevImage() {
        currentIndex--;
        if (currentIndex < 0) {
            currentIndex = imageCount - 1;
        }
        updateSliderPosition();
    }

    function updateSliderPosition() {
        const offset = -currentIndex * imageWidth;
        sliderTrack.style.transform = 'translateX(' + offset+'px)';
    }

    window.addEventListener("resize", () => {
        imageWidth = images[0].clientWidth;
        updateSliderPosition();
    });
    document.querySelector("#review-link").addEventListener("click", function (event) {
        event.preventDefault();
        document.querySelector("#review").scrollIntoView({ behavior: "smooth", block: "center" });
    });
    // kakao map 추가
    // 지도를 초기화하는 함수
    let storeLocation = "<%=storeLngLat%>"
    let coords = storeLocation.split(',');
    let lat = parseFloat(coords[0]);
    let lng = parseFloat(coords[1]);
    let mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
            level: 3, // 지도의 확대 레벨
        };

    // 지도를 생성
    let map = new kakao.maps.Map(mapContainer, mapOption);

    // 마커를 생성
    let markerPosition = new kakao.maps.LatLng(lat, lng);
    let marker = new kakao.maps.Marker({
        position: markerPosition,
    });

    // 마커를 지도에 표시
    marker.setMap(map);

    // 별점
    const stars = document.querySelectorAll(".star-rating span");
    const reviewStarInput = document.querySelector("#reviewStar");
    stars.forEach((star) => {
        star.addEventListener("click", function () {
            const value = this.getAttribute("data-value");
            resetStars();
            highlightStars(value);
            reviewStarInput.value = value;
            console.log(value);
        });
        star.addEventListener("mouseover", function () {
            const value = this.getAttribute("data-value");
            resetStars();
            highlightStars(value);
        });

        star.addEventListener("mouseout", function () {
            const selectedValue = reviewStarInput.value;
            resetStars();
            highlightStars(selectedValue);
        });
    });

    function resetStars() {
        stars.forEach((star) => {
            star.classList.remove("selected");
            star.style.color = "lightgray";
        });
    }

    function highlightStars(value) {
        stars.forEach((star) => {
            if (star.getAttribute("data-value") <= value) {
                star.classList.add("selected");
                star.style.color = "gold";
            }
        });
    }

    const form = document.querySelector('#rating-form');
    form.addEventListener("submit", function(event){
        const confirmed = confirm('리뷰를 등록하시겠습니까?');
        if (!confirmed) {
            event.preventDefault();
        }
    })
    function validationCheck(){
        const userSession = "<%=session.getAttribute("user") != null ? session.getAttribute("user").toString() : "" %>";
        if (userSession === "") {
            // const textarea = document.querySelector("#reviewContents");
            // const submitButton = document.querySelector("#rating-form input[type=submit]");
            const confirmed = confirm("로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?");
            if (!confirmed) {
                const reviewDialog = document.getElementById('reviewDialog');
                reviewDialog.style.display = 'none';
            }
            else{
                window.location.href = "login_or_register";
            }
        }
        console.log(userSession);
        console.log(typeof userSession);
    }

    // 차트
    const ratings = [5, 4, 3, 2, 1];
    const reviewList = JSON.parse('<%= new Gson().toJson(request.getAttribute("reviewList")).replaceAll("\\\\", "\\\\\\\\").replaceAll("\"", "\\\\\"") %>');
    console.log(reviewList);
    const counts = [0, 0, 0, 0, 0];
    reviewList.forEach(review => {
        if (review.rating >= 1 && review.rating <= 5) {
            counts[5 - review.rating]++;
        }
    });
    // 별점 개수
    const ratingLabels = ratings.map(function(rating){
        return "⭐️" + rating;
    });
    const totalReviews = reviewList.length;

    const canvas = document.getElementById("ratingChart");
    canvas.width = 800;
    canvas.height = 600;

    // 막대 그래프 그리기
    const ctx = canvas.getContext("2d");
    const ratingChart = new Chart(ctx, {
        type: "bar",
        data: {
            labels: ratingLabels,
            datasets: [
                {
                    label: "별점 개수",
                    data: counts,
                    backgroundColor: "gold",
                    borderWidth: 0,
                },
            ],
        },
        options: {
            indexAxis: "y",
            scales: {
                x: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0,
                        stepSize: 1,
                    },
                    min: 0,
                    max: totalReviews,
                },
                y: {
                    offset: true,
                },
            },
            plugins: {
                legend: {
                    display: false,
                },
            },
            elements: {
                bar: {
                    categoryPercentage: 1,
                    barPercentage: 0.5,
                },
            },
        },
    });
    // 리뷰 작성 리뉴얼
    const openDialogBtn = document.getElementById('openDialogBtn');
    console.log(openDialogBtn);
    const reviewDialog = document.getElementById('reviewDialog');
    const closeDialogBtn = document.getElementById('closeDialogBtn');

    // "리뷰 작성하기" 버튼 클릭 시 다이얼로그 열기
    openDialogBtn.addEventListener('click', (event) => {
        console.log(event.target)
        reviewDialog.style.display = 'block';
    });

    closeDialogBtn.addEventListener('click', () => {
        reviewDialog.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === reviewDialog) {
            reviewDialog.style.display = 'none';
        }
    });
</script>
</body>
</html>
