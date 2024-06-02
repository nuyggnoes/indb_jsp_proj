package com.example.controller;

import com.example.dto.StoreDTO;
import com.example.dto.UserDTO;
import com.example.service.StoreService;

import java.io.*;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/")
public class MainController extends HttpServlet {

    private StoreService storeService;
    public void init() {
        storeService = new StoreService();
    }
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println("[GET] / (main.jsp)");
        List<StoreDTO> store_list = storeService.getAllStoreInfo();
        request.getSession().setAttribute("store_list", store_list);
        request.getRequestDispatcher("/screen/main.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 검색
    }

}