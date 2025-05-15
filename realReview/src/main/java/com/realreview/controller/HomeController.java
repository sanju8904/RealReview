package com.realreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.realreview.model.Image;
import com.realreview.service.ImageService;

@Controller
public class HomeController {

    @Autowired
    private ImageService imageService;

    @GetMapping("")
    public String home(@RequestParam(defaultValue = "1") int page, Model model) {
        int pageSize = 9;
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        Page<Image> imagePage = imageService.getApprovedImages(pageable);
        model.addAttribute("images", imagePage.getContent());
        model.addAttribute("totalPages", imagePage.getTotalPages());
        model.addAttribute("currentPage", page);
        // Optionally add user info if logged in
        // model.addAttribute("user", ...);
        return "index";
    }
}
