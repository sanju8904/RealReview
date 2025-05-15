package com.realreview.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.realreview.model.Image;
import com.realreview.service.ImageService;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private ImageService imageService;

    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

    @GetMapping("")
    public String adminPanel(Model model, @RequestParam(value = "status", required = false) String status) {
        logger.info("Admin panel accessed");
        List<Image> pendingImages = imageService.getPendingImages();
        logger.info("Pending images for approval: count={}", pendingImages.size());
        for (Image img : pendingImages) {
            logger.info("Pending image: id={}, filename={}, uploader={}", img.getId(), img.getFilename(),
                    img.getUploader());
        }
        model.addAttribute("pendingImages", pendingImages);
        if (status != null) {
            model.addAttribute("status", status);
        }
        model.addAttribute("success", model.asMap().get("success"));
        model.addAttribute("error", model.asMap().get("error"));
        return "admin";
    }

    @PostMapping("/approve")
    public String approveImage(@RequestParam(required = false) Long imageId, Model model) {
        logger.info("Received approve request for imageId: {}", imageId);
        if (imageId == null) {
            logger.error("No imageId provided in approve request");
            return "redirect:/admin?status=No+image+selected+for+approval";
        }
        try {
            logger.info("Approving image with id {}", imageId);
            imageService.approveImage(imageId);
            return "redirect:/admin?status=Image+approved+successfully";
        } catch (Exception e) {
            logger.error("Failed to approve image {}: {}", imageId, e.getMessage());
            return "redirect:/admin?status=Failed+to+approve+image";
        }
    }

    @PostMapping("/reject")
    public String rejectImage(@RequestParam(required = false) Long imageId, Model model) {
        logger.info("Received reject request for imageId: {}", imageId);
        if (imageId == null) {
            logger.error("No imageId provided in reject request");
            return "redirect:/admin?status=No+image+selected+for+rejection";
        }
        try {
            logger.info("Rejecting image with id {}", imageId);
            imageService.rejectImage(imageId);
            return "redirect:/admin?status=Image+rejected+and+deleted";
        } catch (Exception e) {
            logger.error("Failed to reject image {}: {}", imageId, e.getMessage());
            return "redirect:/admin?status=Failed+to+reject+image";
        }
    }

    @GetMapping("/archive")
    public String archiveOldImages(Model model) {
        try {
            logger.info("Archiving old images");
            imageService.archiveOldImages();
            model.addAttribute("success", "Old images archived successfully.");
        } catch (Exception e) {
            logger.error("Failed to archive old images: {}", e.getMessage());
            model.addAttribute("error", "Failed to archive old images.");
        }
        return "redirect:/admin";
    }
}