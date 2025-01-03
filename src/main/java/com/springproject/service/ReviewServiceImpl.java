package com.springproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Review;
import com.springproject.repository.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	ReviewRepository reviewRepository;

	@Override
	public void addReview(Review review) { reviewRepository.addReview(review); }
	
	@Override
	public List<Review> getPlaceAllReview(String placeID) { return reviewRepository.getPlaceAllReview(placeID); }

	@Override
	public void updateReview(String millisID, String reviewText) { reviewRepository.updateReview(millisID, reviewText); }

	@Override
	public Review getReviewByMillis(long millis) { return reviewRepository.getReviewByMillis(millis); }

	@Override
	public List<Review> getReviewById(String userId) { return reviewRepository.getReviewById(userId); }

	@Override
	public void deleteReview(long millis) { reviewRepository.deleteReview(millis); }

	@Override
	public List<Review> getReviewList() { return reviewRepository.getReviewList(); }

	@Override
	public List<Review> getReviewList(String keyword) { return reviewRepository.getReviewList(keyword); }



}
