package com.javaservlet;

import com.javaservlet.entity.User;
import com.javaservlet.service.UserService;

import java.util.List;

public class TestApp {
    public static void main(String[] args) {
        UserService userService = new UserService();
        List<User> us = userService.getAllUsers();
        for (User user : us) {
            user.input();
        }
    }
}
