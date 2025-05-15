package com.realreview.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.realreview.service.ImageService;

@RestController
@RequestMapping("/api/ratings")
public class RatingRestController {
    @Autowired
    private ImageService imageService;

    @PostMapping("")
    public ResponseEntity<?> rateImage(@RequestParam Long imageId, @RequestParam int value, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).body("Unauthorized: Please log in to rate.");
        }

        String username = principal.getName();
        try {
            imageService.rateImage(imageId, value, username);
            return ResponseEntity.ok("Rating submitted");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to submit rating");
        }
    }

}
