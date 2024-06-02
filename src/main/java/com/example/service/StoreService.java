package com.example.service;

import com.example.dao.StoreDAO;
import com.example.dto.StoreDTO;
import com.example.dto.UserDTO;

import java.util.List;

public class StoreService {
    private StoreDAO storeDAO = new StoreDAO();

    public List<StoreDTO> getAllStoreInfo() {
       List<StoreDTO> store_list = storeDAO.findAllStore();
        return store_list;
    }
}
