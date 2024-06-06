package com.example.service;

import com.example.dto.UserDTO;
import com.example.dao.UserDAO;

public class UserService {
    private final UserDAO userDao = new UserDAO();

    public String registerUser(UserDTO userDTO) {
        if (userDao.existsByUsername(userDTO.getUsername())) {
            return "중복 아이디";
        }
        userDao.insertUser(userDTO);
        return "";
    }

    public UserDTO loginUser(String username, String password) {
        UserDTO user = userDao.findUserByUsername(username);
        if (user == null) {
            System.out.println("회원 정보 없음");
            return null;
        }
        if (!user.getPassword().equals(password)) {
            System.out.println("비밀번호 틀림");
            return null;
        }
        return user;
    }
}