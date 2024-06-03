<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session = request.getSession(false);
    if (session != null) {
        session.removeAttribute("user");
    }
    response.sendRedirect(request.getContextPath());
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
