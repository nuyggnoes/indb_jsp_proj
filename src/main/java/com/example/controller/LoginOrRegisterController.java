package com.example.controller;

import com.example.dto.UserDTO;
import com.example.service.UserService;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/login_or_register")
public class LoginOrRegisterController extends HttpServlet {
    private UserService userService;
    public void init() {
        userService = new UserService();
    }
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println("[GET] new login page");
        request.getRequestDispatcher("/screen/login_register.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        System.out.println("[doPost] new login post");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String action = req.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(req, resp, username, password);
        } else if ("signup".equals(action)) {
            username = req.getParameter("username_signup");
            password = req.getParameter("password_signup");
            String personName = req.getParameter("person_name");
            String phoneNumber = req.getParameter("phone");
            handleSignup(req, resp, username, password, personName, phoneNumber);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }
    private void handleLogin(HttpServletRequest req, HttpServletResponse resp, String username, String password) throws ServletException, IOException {
        System.out.println("handleLogin()");

        UserDTO loginResult = userService.loginUser(username, password);
        if (loginResult != null) {
            req.getSession().setAttribute("user", loginResult);
            resp.sendRedirect(req.getContextPath() + "/");
        } else {
            req.setAttribute("username", username);
            req.setAttribute("errorMessage", "아이디 또는 비밀번호가 틀렸습니다.");
            req.getRequestDispatcher("/screen/login_register.jsp").forward(req, resp);
        }
    }

    private void handleSignup(HttpServletRequest req, HttpServletResponse resp, String username, String password, String personName, String phoneNumber) throws ServletException, IOException {
        System.out.println("handleSignup()");
        UserDTO newUser = new UserDTO();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setPerson_name(personName);
        newUser.setPhone_number(phoneNumber);

        String result = userService.registerUser(newUser);
        if ("".equals(result)) {
            System.out.println("회원가입 성공");
            req.setAttribute("message", "회원가입에 성공했습니다!");
            req.setAttribute("redirectUrl", req.getContextPath() + "/login_or_register");
            req.getRequestDispatcher("/screen/success.jsp").forward(req, resp);
        } else {
            System.out.println("중복 아이디");
            req.setAttribute("username", username);
            req.setAttribute("person_name", personName);
            req.setAttribute("phone_number", phoneNumber);
            req.setAttribute("errorMessage", "이미 존재하는 아이디입니다.");
            req.getRequestDispatcher("/screen/login_register.jsp").forward(req, resp);
        }
    }

}