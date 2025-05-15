package com.realreview.controller;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.realreview.service.ImageService;
import com.realreview.service.LocationValidationService;
import com.realreview.repository.UserRepository;
import com.realreview.model.User;

@Controller
@RequestMapping("/images")
public class ImageController {
    @Autowired
    private ImageService imageService;

    @Autowired
    private LocationValidationService locationValidationService;

    @Autowired
    private UserRepository userRepository;

    private static final Logger logger = LoggerFactory.getLogger(ImageController.class);

    @GetMapping("")
    public String listImages(Model model) {
        logger.info("Listing all images for /images page");
        model.addAttribute("images", imageService.getAllImages());
        return "images";
    }

    @PostMapping("/upload")
    public String uploadImage(@RequestParam("file") MultipartFile file,
            @RequestParam("location") String location,
            @RequestParam("uploader") String uploader,
            Model model) throws IOException {
        logger.info("Uploading image by user: {} at location: {}", uploader, location);
        if (!locationValidationService.isValidLocation(location)) {
            logger.warn("Invalid location provided: {}", location);
            model.addAttribute("error", "Invalid location. Please enter a valid address or place name.");
            return "images";
        }
        imageService.saveImage(file, location, uploader);
        model.addAttribute("success", "Image uploaded successfully and is pending admin approval.");
        return "images";
    }

    @PostMapping("/rate")
    public String rateImage(@RequestParam("imageId") Long imageId,
            @RequestParam("rating") int rating,
            @RequestParam("username") String username) {
        logger.info("User {} rating image {} with value {}", username, imageId, rating);
        imageService.rateImage(imageId, rating, username);
        return "redirect:/images/details/" + imageId;
    }

    @GetMapping("/details/{id}")
    public String imageDetails(@PathVariable Long id, Model model) {
        logger.info("Fetching details for image {}", id);
        model.addAttribute("image", imageService.getImageById(id));
        model.addAttribute("ratings", imageService.getRatingsForImage(id));
        return "image-details";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth != null ? auth.getName() : null;
        if (username != null && !"anonymousUser".equals(username)) {
            User user = userRepository.findByUsername(username);
            model.addAttribute("user", user);
            model.addAttribute("userImages", imageService.getAllImages().stream()
                    .filter(img -> img.getUploader().equals(username)).collect(java.util.stream.Collectors.toList()));
            model.addAttribute("userRatings",
                    imageService.getAllImages().stream()
                            .flatMap(img -> img.getRatings() != null ? img.getRatings().stream()
                                    : java.util.stream.Stream.empty())
                            .filter(r -> r.getUsername().equals(username))
                            .collect(java.util.stream.Collectors.toList()));
        }
        return "dashboard";
    }
}
