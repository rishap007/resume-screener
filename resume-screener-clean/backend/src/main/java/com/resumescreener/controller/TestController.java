package com.resumescreener.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:3000")
public class TestController {
    
    @GetMapping("/users/test")
    public String test() {
        return "Backend is working! 🚀";
    }
}
