package com.example.service;

import com.example.dao.ReviewDAO;
import com.example.dto.ReviewDTO;
import java.util.List;

public class ReviewService {
    private final ReviewDAO reviewDAO = new ReviewDAO();
    public boolean writeReview(ReviewDTO review){
        return reviewDAO.insertReview(review);
    }

    public List<ReviewDTO> getAllReviewByStoreId(int storeId) {
        return reviewDAO.selectReviewByStoreId(storeId);
    }
    public boolean delelteReview(String person_name){
        return reviewDAO.deleteReviewByPersonName(person_name);
    }
}
