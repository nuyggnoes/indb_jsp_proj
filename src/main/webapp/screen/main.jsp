<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="store_list" class="java.util.ArrayList" scope="session" />
<%
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    String inputValue = "";
    String category = searchKeyword;
    if (searchKeyword != null && !searchKeyword.startsWith("#")) {
        inputValue = searchKeyword;
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MAIN</title>
    <link rel="stylesheet" href="./css/main.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Tiny5&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
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
<%--                    <li class="nav-item">--%>
<%--                        <a href="<%=request.getContextPath()%>/login_or_register" class="nav-text">회원가입</a>--%>
<%--                    </li>--%>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</header>
<div class="banner-container">
    <img src="./img/pknubanner.png" />
    <div class="banner-overlay">
        <div class="banner-text">
            <div style="color: #4EA685; text-align: center; font-size: 35px; margin-bottom: 20px">부경대 술집 추천 커뮤니티</div>
            <div style="color: white; text-align: center">SOJU HELPER에 오신 것을 환영합니다.</div>
        </div>
        <div class="search-container">
            <form method="get">
                <div class="search-bar">
                    <input id="searchKeyword" name="searchKeyword" type="text" placeholder="검색" value="<%= inputValue %>"/>
                </div>
                <button class="search-icon" type="submit">
                    <label for="searchKeyword">
                        <i class="bx bx-search"></i>
                    </label>
                </button>
            </form>
        </div>
    </div>
</div>
<main class="main-screen">
    <form method="get">
        <div class="category-list-container">
            <input id="category_1" name="searchKeyword" type="submit" hidden="hidden">
            <label class="category-label" for="category_1">
                <div class="category-box"># 안주가 맛있는</div>
            </label>
            <input id="category_2" name="searchKeyword" type="submit" hidden="hidden">
            <label class="category-label" for="category_2">
                <div class="category-box"># 가성비 좋은</div>
            </label>
            <input id="category_3" name="searchKeyword" type="submit" hidden="hidden">
            <label class="category-label" for="category_3">
                <div class="category-box"># 분위기 있는</div>
            </label>
            <input id="category_4" name="searchKeyword" type="submit" hidden="hidden">
            <label class="category-label" for="category_4">
                <div class="category-box"># 특색 있는 메뉴</div>
            </label>
        </div>
    </form>
    <c:choose>
        <c:when test="${not empty sessionScope.store_list}">
            <div class="grid-container">
                <c:forEach var="store" items="${sessionScope.store_list}">
                    <a href="detail?store_id=${store.store_id}">
                        <div class="new-card-container">
                            <img src="imgServlet?store_id=${store.store_id}" />
                            <div class="overlay">
                                <div class="text-container">
                                    <div class="store-title">${store.store_name}</div>
                                    <div class="store-location">${store.location}</div>
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-search-container">검색 결과가 존재하지 않습니다.</div>
        </c:otherwise>
    </c:choose>
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
    const categoryText = "<%=category%>";
    const categoryBoxes = document.querySelectorAll(".category-box");

    categoryBoxes.forEach((box) => {
        if(box.innerHTML === categoryText){
            box.classList.toggle("active");
        }
        box.addEventListener("click", (event) => {
            console.log(event.target.innerText);
            box.classList.toggle("active");
        });
    });

    document.querySelectorAll("label").forEach((label) => {
        label.addEventListener("click", function () {
            const input = document.getElementById(this.htmlFor);
            const divText = this.querySelector(".category-box").innerText;
            input.value = divText.trim();
        });
    });
</script>
</body>
</html>