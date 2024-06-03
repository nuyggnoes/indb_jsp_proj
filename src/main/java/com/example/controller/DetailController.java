package com.example.controller;

import com.example.dto.ReviewDTO;
import com.example.dto.StoreDTO;
import com.example.dto.UserDTO;
import com.example.service.ReviewService;
import com.example.service.StoreService;

import java.io.*;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/detail")
public class DetailController extends HttpServlet {

    private StoreService storeService;
    private ReviewService reviewService;
    public void init() {
        storeService = new StoreService();
        reviewService = new ReviewService();
    }
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println("[GET] /detail (detail.jsp)");
        int store_id = Integer.parseInt(request.getParameter("store_id"));
        StoreDTO store = storeService.getStoreById(store_id);
        List<ReviewDTO> reviewList = reviewService.getAllReviewByStoreId(store_id);
        request.setAttribute("reviewList", reviewList);
        request.setAttribute("store", store);
        request.getRequestDispatcher("/screen/detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 리뷰쓰기
        request.setCharacterEncoding("UTF-8");
        System.out.println("[POST] /detail (detail.jsp)");
        int storeId = Integer.parseInt(request.getParameter("store_id"));
        int reviewStar = Integer.parseInt(request.getParameter("reviewStar"));
        String reviewContents = request.getParameter("reviewContents");
        UserDTO loginUserInfo = (UserDTO) request.getSession().getAttribute("user");
        int userId = loginUserInfo.getUser_id();
        String personName = loginUserInfo.getPerson_name();


        System.out.println("storeID : " + storeId);
        System.out.println("userID : " + userId);
        System.out.println("content : " + reviewContents);
        System.out.println("reviewStar : " + reviewStar);

        ReviewDTO reviewInfo = new ReviewDTO();
        reviewInfo.setPerson_name(personName);
        reviewInfo.setStore_id(storeId);
        reviewInfo.setContent(reviewContents);
        reviewInfo.setRating(reviewStar);
        boolean isReviewWritten = reviewService.writeReview(reviewInfo);
        if (isReviewWritten) {
            System.out.println("리뷰 등록 성공");
            request.setAttribute("message", "리뷰 등록 완료");
            request.setAttribute("redirectUrl", request.getContextPath() + "/detail?store_id=" + storeId);
            request.getRequestDispatcher("/screen/success.jsp").forward(request, response);
        }
    }

}