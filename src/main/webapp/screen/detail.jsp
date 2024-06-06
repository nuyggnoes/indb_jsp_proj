<%@ page import="com.example.dto.StoreDTO" %>
<%@ page import="com.example.dto.ReviewDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    StoreDTO store = (StoreDTO) request.getAttribute("store");
    String storeLocation = store.getLocation();
    List<ReviewDTO> reviewList = (List<ReviewDTO>) request.getAttribute("reviewList");
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
                <i class="bx bxs-cube"></i>
                <div class="nav-logo-text">MainLogo</div>
            </div>
        </a>
        <div class="search-container">
            <form method="get">
                <div class="search-bar">
                    <input id="search" type="text" placeholder="검색" />
                </div>
                <button class="search-icon" type="submit">
                    <label for="search">
                        <i class="bx bx-search"></i>
                    </label>
                </button>
            </form>
        </div>
        <ul class="nav-list">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/profile" class="nav-text">${sessionScope.user.username}님 환영합니다.</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/login" class="nav-text">로그인</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/register" class="nav-text">회원가입</a>
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
                <div class="store-rating">${requestScope.store.rating}</div>
            </div>
            <div class="store-category-container">
                <div class="store-category">#카테고리</div>
                <div class="store-category">#카테고리</div>
            </div>
            <div class="review-count">
                <a href="#" id="review-link"><i class="bx bxs-star"></i>리뷰(<%= reviewList != null ? reviewList.size() : 0 %>)</a>
            </div>
        </div>
        <div class="detail-first">
            <div class="store-description-container">
                <div>
                    <h1>매장 소개</h1>
                    <p>
                        하이볼 단 하나만 생각합니다' 오직 하이볼만을 생각하고 고민하여 만든 하이바(Haiba)만의 감성과 철학을 담아
                        하이볼 바라기가 만든 하이볼 전문점, 하이바입니다.
                    </p>
                </div>
                <div class="store-option-icon">
                    <div class="icon-n-detail"><i class="bx bx-map"></i>부산 남구 용소로 19번길 62-10 샤인빌 204호</div>
                    <div class="icon-n-detail"><i class="bx bx-phone"></i> 010-1234-1234</div>
                </div>
            </div>
            <div id="map" style="width: 47%; height: 400px; background-color: midnightblue"></div>
        </div>
        <div class="review-list-container" id="review">
            <div class="review-title">
                <h1><%= reviewList != null ? reviewList.size() : 0 %>건의 방문자 평가</h1>
                <a href="#" id="move-to-review-write">리뷰 작성하기</a>
            </div>
            <div class="review-box">
                <div class="rating-statistic">
                    <div class="avg-rating">
                        <i class="bx bxs-star" style="color: gold"></i>
                        <span>4.2점</span>
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
                                            <i id="rate12" class="bx bxs-star"></i>
                                            <i id="rate22" class="bx bxs-star"></i>
                                            <i id="rate32" class="bx bxs-star"></i>
                                            <i id="rate42" class="bx bxs-star"></i>
                                            <i id="rate52" class="bx bxs-star"></i>
                                        </div>
                                    </div>
                                    <div class="review-item-content">
                                            ${review.content}
                                    </div>
                                </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                            <div class="review-item-container">
                                <div class="review-item-content">
                                    등록된 리뷰가 존재하지 않습니다.
                                </div>
                            </div>
                    </c:otherwise>
                </c:choose>
                </div>
            </div>
<%--            <div class="review-list">--%>
<%--                <div class="review-item-container">--%>
<%--                    <div class="review-item-title">--%>
<%--                        <div class="nickname">pknu1234</div>--%>
<%--                        <div class="rating">--%>
<%--                            <i id="rate1" class="bx bxs-star"></i>--%>
<%--                            <i id="rate2" class="bx bxs-star"></i>--%>
<%--                            <i id="rate3" class="bx bxs-star"></i>--%>
<%--                            <i id="rate4" class="bx bxs-star"></i>--%>
<%--                            <i id="rate5" class="bx bxs-star"></i>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="review-item-content">--%>
<%--                        하이볼도 맛있었구요!!에그인헬도 맛있었어요!! 매장도 깔끔 깨끗했고 화장실도 깨끗해서 좋았어요!!--%>
<%--                        직원분들도 엄청 친절하셨어요😊 밥을 먹고 2차로 가서 간단히 먹었는데 넘 좋더라구요~! 다음에 다른 메뉴--%>
<%--                        맛보러 다시 방문해야겠어요!--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

        </div>
        <div class="review-write-container">
            <div class="review-title">
                <h1>리뷰 작성하기</h1>
            </div>
            <div>
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
        if (currentIndex >= imageCount) {
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
    document.querySelector("#move-to-review-write").addEventListener("click", function (event) {
        event.preventDefault();
        document.querySelector(".review-write-container").scrollIntoView({ behavior: "smooth", block: "center" });
    });
    // kakao map 추가
    // 지도를 초기화하는 함수
    let mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(35.1368993, 129.102391), // 지도의 중심좌표
            level: 3, // 지도의 확대 레벨
        };

    // 지도를 생성
    let map = new kakao.maps.Map(mapContainer, mapOption);
    let storeLocation = "<%=storeLocation%>"
    let coords = storeLocation.split(',');
    let lat = parseFloat(coords[0]);
    let lng = parseFloat(coords[1]);
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
            const textarea = document.querySelector("#reviewContents");
            const submitButton = document.querySelector("#rating-form input[type=submit]");

            const confirmed = confirm("로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?");
            if (!confirmed) {
                textarea.blur();
                submitButton.disabled = true;
            }
            else{
                // login.jsp로 이동
                window.location.href = "login";
            }
        }
        console.log(userSession);
        console.log(typeof userSession);
    }

    // 차트
    // 별점 데이터
    const ratings = [5, 4, 3, 2, 1];
    const counts = [3, 2, 2, 0, 1]; // 각 별점에 해당하는 개수
    const ratingLabels = ratings.map(function(rating){
        return "⭐️" + rating;
    });

    const canvas = document.getElementById("ratingChart");
    canvas.width = 800; // 원하는 너비 설정
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
</script>
</body>
</html>
