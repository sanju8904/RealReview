package com.realreview.service;

import com.realreview.model.PropertyImage;
import com.realreview.repository.PropertyImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class PropertyImageService {

    @Autowired
    private PropertyImageRepository propertyImageRepository;

    private final Path rootLocation = Paths.get("uploaded-images");

    public PropertyImage uploadImage(PropertyImage image) throws Exception {
        // Simulating image file upload (this can be replaced with actual file upload logic)
        Files.createDirectories(rootLocation);
        Path filePath = rootLocation.resolve(image.getTitle() + ".jpg");
        Files.write(filePath, new byte[0]); // Simulate writing file
        
        image.setFilePath(filePath.toString());
        image.setUploadTime(LocalDateTime.now());
        image.setStatus(PropertyImage.Status.PENDING);
        
        return propertyImageRepository.save(image);
    }

    public List<PropertyImage> getAllImages() {
        return propertyImageRepository.findAll();
    }

    public PropertyImage approveImage(Long imageId) {
        PropertyImage image = propertyImageRepository.findById(imageId).orElseThrow(() -> new RuntimeException("Image not found"));
        image.setStatus(PropertyImage.Status.APPROVED);
        return propertyImageRepository.save(image);
    }

    public PropertyImage rejectImage(Long imageId) {
        PropertyImage image = propertyImageRepository.findById(imageId).orElseThrow(() -> new RuntimeException("Image not found"));
        image.setStatus(PropertyImage.Status.REJECTED);
        return propertyImageRepository.save(image);
    }

    public void archiveOldImages() {
        List<PropertyImage> images = propertyImageRepository.findAll();
        images.forEach(image -> {
            if (image.getUploadTime().isBefore(LocalDateTime.now().minusMonths(6))) {
                image.setStatus(PropertyImage.Status.ARCHIVED);
                propertyImageRepository.save(image);
            }
        });
    }
}
