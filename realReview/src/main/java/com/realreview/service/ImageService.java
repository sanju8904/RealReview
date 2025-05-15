package com.realreview.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.realreview.model.Image;
import com.realreview.model.Rating;
import com.realreview.repository.ImageRepository;
import com.realreview.repository.RatingRepository;

@Service
public class ImageService {
    @Autowired
    private ImageRepository imageRepository;

    @Autowired
    private RatingRepository ratingRepository;

    public List<Image> getAllImages() {
        return imageRepository.findAll();
    }

    public void saveImage(MultipartFile file, String location, String uploader) throws IOException {
        String uploadDir = System.getProperty("user.dir") + File.separator + "uploads" + File.separator;
        File dir = new File(uploadDir);
        if (!dir.exists())
            dir.mkdirs();
        String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        File dest = new File(uploadDir + filename);
        file.transferTo(dest);
        Image image = new Image();
        image.setFilename(filename);
        image.setUploader(uploader);
        image.setLocation(location);
        image.setUploadTime(java.time.LocalDate.now());
        image.setApproved(false);
        image.setArchived(false);
        imageRepository.save(image);
    }

    public void rateImage(Long imageId, int value, String username) {
        java.util.Optional<Image> imageOpt = imageRepository.findById(imageId);
        if (imageOpt.isPresent()) {
            Rating rating = new Rating();
            rating.setImage(imageOpt.get());
            rating.setValue(value);
            rating.setUsername(username);
            ratingRepository.save(rating);
        }
    }

    public Image getImageById(Long id) {
        return imageRepository.findById(id).orElse(null);
    }

    public List<Rating> getRatingsForImage(Long imageId) {
        java.util.Optional<Image> imageOpt = imageRepository.findById(imageId);
        if (imageOpt.isPresent()) {
            return ratingRepository.findByImage(imageOpt.get());
        }
        return java.util.Collections.emptyList();
    }

    public List<Image> getPendingImages() {
        // Only show images that are not approved and not archived
        return imageRepository.findByApprovedAndArchived(false, false);
    }

    public void approveImage(Long imageId) {
        imageRepository.findById(imageId).ifPresent(image -> {
            image.setApproved(true);
            imageRepository.save(image);
        });
    }

    public void rejectImage(Long imageId) {
        imageRepository.findById(imageId).ifPresent(image -> {
            imageRepository.delete(image);
        });
    }

    public void archiveOldImages() {
        LocalDate cutoff = LocalDate.now().minusDays(30); // archive images older than 30 days
        imageRepository.findAll().forEach(image -> {
            if (image.getUploadTime() != null && image.getUploadTime().isBefore(cutoff)) {
                image.setArchived(true);
                imageRepository.save(image);
            }
        });
    }

    public Page<Image> getApprovedImages(Pageable pageable) {
        Page<Image> page = imageRepository.findByApprovedAndArchived(true, false, pageable);
        // Attach ratings to each image for the view
        page.getContent().forEach(img -> {
            img.setRatings(ratingRepository.findByImage(img));
        });
        return page;
    }
}
