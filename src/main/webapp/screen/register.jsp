<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/register.css">
</head>
<body>
<div class="register_container">
    <h2>회원가입</h2>
    <form method="post" action="<%= request.getContextPath() %>/register">
        <div class="input_group">
            <label for="username">아이디</label>
            <input type="text" id="username" name="username" required placeholder="Username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" />
        </div>
        <div class="input_group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required placeholder="Password" />
        </div>
        <div class="input_group">
            <label for="password_check">비밀번호 확인</label>
            <input type="password" id="password_check" name="password_check" required placeholder="Check Password" oninput="checkPassword()" onfocusout="checkPassword()"/>
        </div>
        <div class="pwdCheckText">비밀번호가 일치하지 않습니다.</div>
        <div class="input_group">
            <label for="person_name">이름</label>
            <input type="text" id="person_name" name="person_name" required placeholder="Name" value="<%= request.getAttribute("person_name") != null ? request.getAttribute("person_name") : "" %>" />
        </div>
        <div class="input_group">
            <label for="phone_number">휴대폰</label>
            <input type="text" id="phone_number" name="phone_number" required placeholder="Phone Number" value="<%= request.getAttribute("phone_number") != null ? request.getAttribute("phone_number") : "" %>" />
        </div>
        <button type="submit" class="btn">회원가입</button>
    </form>
</div>
<script>
    function checkPassword() {
        console.log("checkPassword");
        const password = document.querySelector("#password");
        const passwordCheck = document.querySelector("#password_check");
        const checkText = document.querySelector(".pwdCheckText");

        if (password.value !== passwordCheck.value) {
            console.log("pwd diff");
            checkText.style.visibility = "visible";
        } else {
            console.log("pwd same");
            checkText.style.visibility = "hidden";
        }
    }
</script>
</body>
</html>
