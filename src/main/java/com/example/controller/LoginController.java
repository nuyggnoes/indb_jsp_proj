package com.example.controller;

import com.example.dto.UserDTO;
import com.example.service.UserService;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserService userService;
    public void init() {
        userService = new UserService();

    }
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println("login page get");
        request.getRequestDispatcher("/screen/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        System.out.println("ID : " + username + " / " + "PASSWORD : " + password);

        UserDTO loginResult = userService.loginUser(username, password);
        if (loginResult != null) {
            req.getSession().setAttribute("user", loginResult);
            resp.sendRedirect(req.getContextPath() + "/screen/main.jsp");
        } else {
            req.setAttribute("username", username);
            req.setAttribute("errorMessage", "아이디 또는 비밀번호가 틀렸습니다.");
            req.getRequestDispatcher("/screen/login.jsp").forward(req, resp);
        }
    }

}