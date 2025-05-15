package com.realreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.realreview.service.ImageService;

@RestController
@RequestMapping("/api/admin")
public class AdminRestController {
    @Autowired
    private ImageService imageService;

    @PostMapping("/approve/{id}")
    public ResponseEntity<?> approveImage(@PathVariable Long id) {
        try {
            imageService.approveImage(id);
            return ResponseEntity.ok("Image approved");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to approve image");
        }
    }

    @PostMapping("/reject/{id}")
    public ResponseEntity<?> rejectImage(@PathVariable Long id) {
        try {
            imageService.rejectImage(id);
            return ResponseEntity.ok("Image rejected");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to reject image");
        }
    }
}
