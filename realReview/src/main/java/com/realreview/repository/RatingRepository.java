package com.realreview.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.realreview.model.Rating;
import com.realreview.model.Image;

import java.util.List;

public interface RatingRepository extends JpaRepository<Rating, Long> {
    public List<Rating> findByImage(Image image);
}
