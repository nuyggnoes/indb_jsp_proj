package com.example.dao;

import com.example.dto.ReviewDTO;
import com.jdbc.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public boolean insertReview(ReviewDTO review){
        boolean check = false;
        System.out.println("-------ReviewDAO : insertReview-------");
        String query = "INSERT INTO store_review (username, store_id, content, rating) VALUES (?,?,?,?)";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, review.getPerson_name());
            preparedStatement.setInt(2, review.getStore_id());
            preparedStatement.setString(3, review.getContent());
            preparedStatement.setInt(4, review.getRating());

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new review was inserted successfully!");
                check = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return check;
    }

    public List<ReviewDTO> selectReviewByStoreId(int storeId) {
        System.out.println("-------ReviewDAO : findAllReviewByStoreID-------");
        String query = "SELECT * FROM store_review where store_id = ?";
        List<ReviewDTO> reviewList = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, storeId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setPerson_name(resultSet.getString("username"));
                review.setStore_id(resultSet.getInt("store_id"));
                review.setContent(resultSet.getString("content"));
                review.setRating(resultSet.getInt("rating"));
                reviewList.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviewList;
    }

    public boolean deleteReviewByPersonName(String personName) {
        System.out.println("-------ReviewDAO : deleteReviewByPersonName-------");
        String query = "DELETE * FROM store_review where username = ?";
        List<ReviewDTO> reviewList = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, personName);

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new review was deleted successfully!");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
