package com.example.controller;

import com.example.dto.UserDTO;
import com.example.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("register.jsp get");
        req.getRequestDispatcher("/screen/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String personName = req.getParameter("person_name");
        String phoneNumber = req.getParameter("phone_number");

        UserDTO newUser = new UserDTO();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setPerson_name(personName);
        newUser.setPhone_number(phoneNumber);

        String result = userService.registerUser(newUser);
        if ("".equals(result)) {
            System.out.println("회원가입 성공");
            req.setAttribute("message", "회원가입에 성공했습니다!");
            req.setAttribute("redirectUrl", req.getContextPath() + "/login");
            req.getRequestDispatcher("/screen/success.jsp").forward(req, resp);
        } else {
            System.out.println("중복 아이디");
            req.getSession().setAttribute("username", username);
            req.getSession().setAttribute("password", password);
            req.getSession().setAttribute("person_name", personName);
            req.getSession().setAttribute("phone_number", phoneNumber);
            req.getSession().setAttribute("errorMessage", "이미 존재하는 아이디입니다.");
            resp.sendRedirect(req.getContextPath() + "/screen/register.jsp");
        }
    }
}