package com.example.dao;

import com.example.dto.StoreDTO;
import com.example.dto.UserDTO;
import com.jdbc.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StoreDAO {

    public List<StoreDTO> findAllStore() {
        System.out.println("-------StoreDAO : findAllStoreInfo-------");
        String query = "SELECT * FROM store";
        List<StoreDTO> store_list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                StoreDTO store = new StoreDTO();
                store.setStore_id(resultSet.getInt("store_id"));
                store.setStore_name(resultSet.getString("store_name"));
                store.setDescription(resultSet.getString("description"));
                store.setCategory(resultSet.getString("category"));
                store.setLocation(resultSet.getString("location"));
                store.setRating(resultSet.getFloat("rating"));
                store.setStore_number(resultSet.getString("store_number"));
                store_list.add(store);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return store_list;
    }

    public StoreDTO findStoreById(int store_id){
        System.out.println("-------StoreDAO : findAllStoreInfo-------");
        String query = "SELECT * FROM store where store_id = ?";
        StoreDTO store = new StoreDTO();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, store_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                store.setStore_id(resultSet.getInt("store_id"));
                store.setStore_name(resultSet.getString("store_name"));
                store.setDescription(resultSet.getString("description"));
                store.setCategory(resultSet.getString("category"));
                store.setLocation(resultSet.getString("location"));
                store.setRating(resultSet.getFloat("rating"));
                store.setStore_number(resultSet.getString("store_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return store;
    }

    public List<StoreDTO> findStoreByKeyword(String keyword){
        System.out.println("-------StoreDAO : findStoreByKeyword-------");
        String query = "SELECT * FROM store WHERE store_name LIKE ?";
        List<StoreDTO> store_list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, "%" + keyword + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                StoreDTO store = new StoreDTO();
                store.setStore_id(resultSet.getInt("store_id"));
                store.setStore_name(resultSet.getString("store_name"));
                store.setDescription(resultSet.getString("description"));
                store.setCategory(resultSet.getString("category"));
                store.setLocation(resultSet.getString("location"));
                store.setRating(resultSet.getFloat("rating"));
                store.setStore_number(resultSet.getString("store_number"));
                store_list.add(store);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return store_list;
    }
}
