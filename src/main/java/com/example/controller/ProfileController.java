package com.example.controller;

import com.example.service.StoreService;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println("[GET] /profile (profile.jsp)");
        request.getRequestDispatcher("/screen/profile.jsp").forward(request, response);
    }

}