package com.jdbc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String JDBC_DRIVER = "oracle.jdbc.OracleDriver";
    private static final String USER = "system";
    private static final String PASSWORD = "1234";

    public static Connection getConnection() {
        try {
            Class.forName(JDBC_DRIVER);
            return DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC 드라이버 로드 실패");
            throw new RuntimeException(e);
        } catch (SQLException e) {
            System.out.println("JDBC 연결 실패");
            throw new RuntimeException(e);
        }
    }
}
