package com.realreview.service;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class LocationValidationService {
    private static final String NOMINATIM_URL = "https://nominatim.openstreetmap.org/search?format=json&q=";

    public boolean isValidLocation(String location) {
        try {
            RestTemplate restTemplate = new RestTemplate();
            String url = NOMINATIM_URL + location.replace(" ", "+");
            ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
            ObjectMapper mapper = new ObjectMapper();
            JsonNode arr = mapper.readTree(response.getBody());
            return arr.isArray() && arr.size() > 0;
        } catch (Exception e) {
            return false;
        }
    }
}
