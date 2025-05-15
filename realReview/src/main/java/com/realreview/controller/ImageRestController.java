package com.realreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.realreview.model.Image;
import com.realreview.model.Rating;
import com.realreview.service.ImageService;

@RestController
@RequestMapping("/api/images")
public class ImageRestController {
    @Autowired
    private ImageService imageService;

    @GetMapping("")
    public List<Image> getAllImages() {
        return imageService.getAllImages();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Image> getImage(@PathVariable Long id) {
        Image img = imageService.getImageById(id);
        if (img == null)
            return ResponseEntity.notFound().build();
        return ResponseEntity.ok(img);
    }

    @GetMapping("/{id}/ratings")
    public List<Rating> getRatings(@PathVariable Long id) {
        return imageService.getRatingsForImage(id);
    }
}
