package com.example.indb;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ImgTest {
    public static void main(String[] args) {
        String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:XE";
        String JDBC_DRIVER = "oracle.jdbc.OracleDriver";
        String USER = "system";
        String PASSWORD = "1234";

        String filePath = "/Users/imseong-gyun/Desktop/inDB_img/sample3.png";

        Connection conn = null;
        PreparedStatement pstmt = null;
        FileInputStream fis = null;

        try {
            // JDBC 드라이버 로드
            Class.forName(JDBC_DRIVER);
            // 데이터베이스 연결
            conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);

            String sql = "INSERT INTO img_table (store_id, img_name, img) VALUES (?, ?,?)";
            pstmt = conn.prepareStatement(sql);

            // 데이터 준비
            pstmt.setInt(1, 2); // store_id
            pstmt.setString(2, "sample3");

            // 이미지 파일을 읽어 BLOB로 설정
            File imgFile = new File(filePath);
            fis = new FileInputStream(imgFile);
            pstmt.setBinaryStream(3, fis, (int) imgFile.length());

            // 쿼리 실행
            pstmt.executeUpdate();
            System.out.println("Image inserted successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (fis != null) fis.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
