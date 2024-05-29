<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="login_container">
    <h2>로그인</h2>
    <form method="post" action="<%= request.getContextPath() %>/login">
        <div class="input_group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required placeholder="Username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"/>
        </div>
        <div class="input_group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Password" />
        </div>
        <div class="wrong_container"><%=request.getAttribute("errorMessage")%></div>
        <div class="login_option">
            <div>
                <input type="checkbox" />
                <p>Keep me logged in</p>
            </div>
            <a href="#">Forgot your password?</a>
        </div>
        <button type="submit" class="btn">Login</button>
    </form>
    <hr />
    <div class="register_text">Don't have an account? <a href="<%=request.getContextPath()%>/register">Sign up</a></div>
</div>

<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
<script type="text/javascript">
        console.log("error");
        const wrong = document.querySelector(".wrong_container");
        wrong.style.visibility = "visible";
</script>
<%
    }
%>
</body>
</html>
