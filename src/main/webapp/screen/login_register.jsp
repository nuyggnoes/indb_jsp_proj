<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LOGIN</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login_n_register.css">
</head>
<body>
<div id="container" class="container">
    <!-- FORM SECTION -->
    <form method="post" action="<%= request.getContextPath() %>/login_or_register">
        <input type="hidden" id="action" name="action" value="">
        <div class="row">
            <!-- SIGN UP -->
            <div class="col align-items-center flex-col sign-up">
                <div class="form-wrapper align-items-center">
                    <div class="form sign-up">
                        <div class="input-group">
                            <i class='bx bxs-lock-alt'></i>
                            <input id="name" name="person_name" type="text" placeholder="닉네임">
                        </div>
                        <div class="input-group">
                            <i class='bx bxs-lock-alt'></i>
                            <input id="number" name="phone" type="text" placeholder="전화번호">
                        </div>
                        <div class="input-group">
                            <i class='bx bxs-user'></i>
                            <input id="username_signup" name="username_signup" type="text" placeholder="아이디">
                        </div>
                        <div class="input-group">
                            <i class='bx bx-mail-send'></i>
                            <input id="password_signup" name="password_signup" type="password" placeholder="비밀번호">
                        </div>
                        <div class="input-group">
                            <i class='bx bxs-lock-alt'></i>
                            <input id="password_check" name="password_check" type="password" placeholder="비밀번호 확인" oninput="checkPassword()" onfocusout="checkPassword()">
                        </div>
                        <div class="pwdCheckText">비밀번호가 일치하지 않습니다.</div>

                        <button type="button" onclick="submitForm('signup')">회원가입</button>
                        <p>
                            <span>Already have an account?</span>
                            <b onclick="toggle()" class="pointer">로그인</b>
                        </p>
                    </div>
                </div>
            </div>
            <!-- END SIGN UP -->
            <!-- SIGN IN -->
            <div class="col align-items-center flex-col sign-in">
                <div class="form-wrapper align-items-center">
                    <div class="form sign-in">
                        <div class="input-group">
                            <i class='bx bxs-user'></i>
                            <input type="text" name="username" placeholder="아이디" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
                        </div>
                        <div class="input-group">
                            <i class='bx bxs-lock-alt'></i>
                            <input type="password" name="password" placeholder="비밀번호">
                        </div>
                        <div class="wrong_container"><%=request.getAttribute("errorMessage")%></div>
                        <button type="button" onclick="submitForm('login')">
                            LOGIN
                        </button>
                        <p>
                            <b style="cursor: pointer" onclick="forgotPassword()">
                                패스워드를 잊으셨나요?
                            </b>
                        </p>
                        <p>
                      <span>
                        Don't have an account?
                      </span>
                            <b onclick="toggle()" class="pointer">
                                회원가입
                            </b>
                        </p>
                    </div>
                </div>
                <div class="form-wrapper">

                </div>
            </div>
            <!-- END SIGN IN -->
        </div>
    </form>
    <!-- END FORM SECTION -->
    <!-- CONTENT SECTION -->
    <div class="row content-row">
        <!-- SIGN IN CONTENT -->
        <div class="col align-items-center flex-col">
            <div class="text sign-in">
                <h2>
                    SOJU HELPER
                </h2>

            </div>
            <div class="img sign-in">

            </div>
        </div>
        <!-- END SIGN IN CONTENT -->
        <!-- SIGN UP CONTENT -->
        <div class="col align-items-center flex-col">
            <div class="img sign-up">

            </div>
            <div class="text sign-up">
                <h2>
                    환영합니다 !
                </h2>

            </div>
        </div>
        <!-- END SIGN UP CONTENT -->
    </div>
    <!-- END CONTENT SECTION -->
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
<script>
    let container = document.getElementById('container')

    toggle = () => {
        container.classList.toggle('sign-in')
        container.classList.toggle('sign-up')
    }

    setTimeout(() => {
        container.classList.add('sign-in')
    }, 200)
    function forgotPassword(){
        alert("서비스 준비중 . . .");
    }

    function checkPassword() {
        const password = document.querySelector("#password_signup");
        const passwordCheck = document.querySelector("#password_check");
        const checkText = document.querySelector(".pwdCheckText");

        if (password.value !== passwordCheck.value) {
            checkText.style.visibility = "visible";
        } else {
            checkText.style.visibility = "hidden";
        }
    }
    function submitForm(action) {
        document.getElementById('action').value = action;
        document.forms[0].submit();
    }
</script>

</body>
</html>