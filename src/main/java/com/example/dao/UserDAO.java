package com.example.dao;

import com.example.dto.UserDTO;
import com.jdbc.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public UserDTO findUserByUsername(String username) {
        System.out.println("-------UserDAO : findUserByUsername-------");
        String query = "SELECT * FROM user_table WHERE username = ?";
        UserDTO user = new UserDTO();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user.setUser_id(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setPerson_name(resultSet.getString("person_name"));
                user.setPhone_number(resultSet.getString("phone_number"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean existsByUsername(String username){
        if(findUserByUsername(username) != null){
            return true;
        }
        return false;
    }
    public void insertUser(UserDTO user){
        System.out.println("-------UserDAO : insertUser-------");
        String query = "INSERT INTO user_table (username, password, person_name, phone_number) VALUES (?,?,?,?)";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getPerson_name());
            preparedStatement.setString(4, user.getPhone_number());

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new user was inserted successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
