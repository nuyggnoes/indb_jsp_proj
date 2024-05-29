package com.example.indb;

import java.sql.*;

public class ConnectionTest {

    public static void main(String[] args) {
        String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
        String jdbc_url = "jdbc:oracle:thin:@localhost:1521:XE";

        try {
            Class.forName(jdbc_driver);
            Connection conn = DriverManager.getConnection(jdbc_url, "system", "1234");

            String query = "SELECT * FROM user_table";
            System.out.println("Executing query: " + query);
            PreparedStatement pstmt = conn.prepareStatement(query);

            ResultSet rs = pstmt.executeQuery();
            System.out.println("ResultSet: " + rs);

            boolean hasResults = false;
            while (rs.next()) {
                hasResults = true;
                System.out.println("userID : " + rs.getInt("user_id"));
                System.out.println("username : " + rs.getString("username"));
                System.out.println("password : " + rs.getString("password"));
            }

            if (!hasResults) {
                System.out.println("No data found.");
            }

            rs.close();
            pstmt.close();
            conn.close();

            System.out.println("JDBC 연결 성공");

        } catch (ClassNotFoundException e) {
            System.out.println("JDBC 드라이버 로드 실패");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("JDBC 연결 실패");
            e.printStackTrace();
        }
    }
}
