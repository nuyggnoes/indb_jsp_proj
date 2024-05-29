<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script>
    window.onload = function() {
        alert('<%= request.getAttribute("message") %>');
        window.location.href = '<%= request.getAttribute("redirectUrl") %>';
    };
</script>
<body>

</body>
</html>
