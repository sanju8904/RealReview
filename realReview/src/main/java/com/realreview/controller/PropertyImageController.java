package com.realreview.controller;

import com.realreview.model.PropertyImage;
import com.realreview.service.PropertyImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/images")
public class PropertyImageController {

    @Autowired
    private PropertyImageService propertyImageService;

    @GetMapping("/upload")
    public String showUploadForm() {
        return "uploadForm"; // This will refer to uploadForm.jsp
    }

    @PostMapping("/upload")
    public String uploadImage(@ModelAttribute PropertyImage propertyImage) {
        try {
            propertyImageService.uploadImage(propertyImage);
            return "redirect:/images";
        } catch (Exception e) {
            return "error";
        }
    }

    @GetMapping
    public String listImages(Model model) {
        model.addAttribute("images", propertyImageService.getAllImages());
        return "index"; // This will refer to index.jsp
    }

    @PostMapping("/approve/{id}")
    public String approveImage(@PathVariable Long id) {
        propertyImageService.approveImage(id);
        return "redirect:/images";
    }

    @PostMapping("/reject/{id}")
    public String rejectImage(@PathVariable Long id) {
        propertyImageService.rejectImage(id);
        return "redirect:/images";
    }
}
