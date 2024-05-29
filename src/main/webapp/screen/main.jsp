<%@ page import="com.example.dto.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>메인페이지</title>
    <link rel="stylesheet" href="../css/main.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
</head>
<body>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
%>
<header class="nav">
    <div class="nav-container">
        <div class="nav-logo">
            <i class="bx bxs-cube"></i>
            <a href="#" class="nav-logo-text">MainLogo</a>
        </div>
        <div class="search-container">
            <div class="search-bar">
                <input id="search" type="text" placeholder="검색" />
            </div>
            <form method="get">
                <button class="search-icon" type="submit">
                    <label for="search">
                        <i class="bx bx-search"></i>
                    </label>
                </button>
            </form>
        </div>
<%--        <ul class="nav-list">--%>
<%--            <li class="nav-item">--%>
<%--                <a href="#" target="_blank" class="nav-text">로그인</a>--%>
<%--            </li>--%>
<%--            <li class="nav-item">--%>
<%--                <a href="#" target="_blank" class="nav-text">회원가입</a>--%>
<%--            </li>--%>
<%--        </ul>--%>
        <ul class="nav-list">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a href="#" class="nav-text">${sessionScope.user.username}</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/logout" class="nav-text">로그아웃</a>
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
    <div class="category-list-container">
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
    </div>
    <div class="grid-container">
        <div class="new-card-container">
            <img src="./img/하이바 경성대점.png" />
            <div class="overlay">
                <div class="text-container">
                    <div class="store-title">하이바</div>
                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>
                </div>
            </div>
        </div>
        <div class="new-card-container">
            <img src="./img/하이바 경성대점.png" />
            <div class="overlay">
                <div class="text-container">
                    <div class="store-title">하이바</div>
                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>
                </div>
            </div>
        </div>
        <div class="new-card-container">
            <img src="./img/하이바 경성대점.png" />
            <div class="overlay">
                <div class="text-container">
                    <div class="store-title">하이바</div>
                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>
                </div>
            </div>
        </div>
        <div class="new-card-container">
            <img src="./img/하이바 경성대점.png" />
            <div class="overlay">
                <div class="text-container">
                    <div class="store-title">하이바</div>
                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>
                </div>
            </div>
        </div>
        <div class="new-card-container">
            <img src="./img/하이바 경성대점.png" />
            <div class="overlay">
                <div class="text-container">
                    <div class="store-title">하이바</div>
                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>
                </div>
            </div>
        </div>
        <div class="new-card-container">
            <img src="./img/하이바 경성대점.png" />
            <div class="overlay">
                <div class="text-container">
                    <div class="store-title">하이바</div>
                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>
                </div>
            </div>
        </div>
        <div class="new-card-container">
            <img src="./img/하이바 경성대점.png" />
            <div class="overlay">
                <div class="text-container">
                    <div class="store-title">하이바</div>
                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>
                </div>
            </div>
        </div>
        <!-- <div class="card-container">
          <div class="img-container"><img src="./img/하이바 경성대점.png" /></div>
          <div class="text-container">
            <div class="store-rating">4.4</div>
            <div class="store-title">하이바</div>
            <div class="store-location">남구 용소로13번길 32 1, 2층</div>
            <div class="store-menu">자허블 사와 하이볼, 레몬 사와 하이볼, 피치블라썸 하이볼</div>
            <div class="store-review">
              <i class="bx bxs-star"></i>
              <span>12</span>
            </div>
          </div>
        </div> -->
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
<script>
    const categoryBoxes = document.querySelectorAll(".category-box");

    categoryBoxes.forEach((box) => {
        box.addEventListener("click", (event) => {
            console.log(event.target.innerText);
            box.classList.toggle("active");
        });
    });
</script>
</body>

</html>