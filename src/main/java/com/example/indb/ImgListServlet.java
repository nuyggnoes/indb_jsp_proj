package com.example.indb;
import com.jdbc.util.DBUtil;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/imgListServlet")
public class ImgListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String store_id = request.getParameter("store_id");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT img_id FROM img_table WHERE store_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, store_id);
            rs = stmt.executeQuery();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    json.append(",");
                }
                first = false;
                int imgId = rs.getInt("img_id");
                String imgUrl = "imgServlet?img_id=" + imgId;
                json.append("\"").append(imgUrl).append("\"");
            }
            json.append("]");

            response.getWriter().write(json.toString());
            System.out.println("이미지 리스트 불러오기 성공");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
