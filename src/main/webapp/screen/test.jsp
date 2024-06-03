<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Oracle DB URL
    String user = "system";
    String password = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    OutputStream os = null;

    try {
        // JDBC 드라이버 로드
        Class.forName("oracle.jdbc.OracleDriver");
        // 데이터베이스 연결
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT * FROM img_test";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            byte[] imgData = rs.getBytes("img");
            response.setContentType("image/png");
            os = response.getOutputStream();
            os.write(imgData);
            os.flush();
        } else {
            response.getWriter().write("No image found for store");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
            if (os != null) os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
  <h1>img test</h1>
    <img src="displayImage" alt="Store Image" />
</body>
</html>
