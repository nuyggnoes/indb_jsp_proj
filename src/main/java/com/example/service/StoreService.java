package com.example.service;

import com.example.dao.StoreDAO;
import com.example.dto.StoreDTO;
import com.example.dto.UserDTO;

import java.util.ArrayList;
import java.util.List;

public class StoreService {
    private StoreDAO storeDAO = new StoreDAO();

    public List<StoreDTO> getAllStoreInfo() {
        return storeDAO.findAllStore();
    }

    public StoreDTO getStoreById(int store_id){
        return storeDAO.findStoreById(store_id);
    }

    public List<StoreDTO> searchStoreByKeyword(String keyword){
        return storeDAO.findStoreByKeyword(keyword);
    }
}
