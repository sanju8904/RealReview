package com.realreview.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.realreview.model.Image;

public interface ImageRepository extends JpaRepository<Image, Long> {
    List<Image> findByApproved(boolean approved);

    List<Image> findByArchived(boolean archived);

    Page<Image> findByApprovedAndArchived(boolean approved, boolean archived, Pageable pageable);

    List<Image> findByApprovedAndArchived(boolean approved, boolean archived);
}
