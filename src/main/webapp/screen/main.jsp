<%@ page import="com.example.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.dto.StoreDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>메인페이지</title>
    <link rel="stylesheet" href="./css/main.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
</head>
<body>
<%
    List<StoreDTO> storeList = (List<StoreDTO>) session.getAttribute("store_list");
    UserDTO user = (UserDTO) session.getAttribute("user");
%>
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
                    <input id="searchKeyword" name="searchKeyword" type="text" placeholder="검색" />
                </div>
                <button class="search-icon" type="submit">
                    <label for="searchKeyword">
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
    <div class="category-list-container">
        <div class="category-box">#main.jsp</div>
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
        <div class="category-box">#카테고리</div>
    </div>
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
<%--        <div class="new-card-container">--%>
<%--            <img src="imgServlet?imgName=sample1" />--%>
<%--            <div class="overlay">--%>
<%--                <div class="text-container">--%>
<%--                    <div class="store-title">하이바</div>--%>
<%--                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="new-card-container">--%>
<%--            <img src="imgServlet?imgName=sample1" />--%>
<%--            <div class="overlay">--%>
<%--                <div class="text-container">--%>
<%--                    <div class="store-title">하이바</div>--%>
<%--                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="new-card-container">--%>
<%--            <img src="imgServlet?imgName=sample1" />--%>
<%--            <div class="overlay">--%>
<%--                <div class="text-container">--%>
<%--                    <div class="store-title">하이바</div>--%>
<%--                    <div class="store-location">남구 용소로13번길 32 1, 2층</div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
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