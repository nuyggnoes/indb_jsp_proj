package com.example.controller;

import com.example.dto.StoreDTO;
import com.example.service.StoreService;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/detail")
public class DetailController extends HttpServlet {

    private StoreService storeService;
    public void init() {
        storeService = new StoreService();
    }
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println("[GET] / (detail.jsp)");
        int store_id = Integer.parseInt(request.getParameter("store_id"));
        System.out.println(store_id);
        // select * from store where store_id = 1;
        request.getRequestDispatcher("/screen/detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 검색
    }

}