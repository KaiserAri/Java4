package com.javaservlet.servlet;

import com.javaservlet.entity.User;
import com.javaservlet.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(urlPatterns = {"/finding"})
public class FindingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Hiển thị trang Home.jsp với form tìm kiếm trống
        req.getRequestDispatcher("/views/Home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        System.out.println("--------------------------");
        System.out.println(">>> username: " + username);

        String message = null;
        List<Map<String, Object>> users = new ArrayList<>();

        if (username != null && !username.trim().isEmpty()) {
            // 1. Tìm kiếm user theo username từ DB
            UserService userService = new UserService();
            List<User> listUser = userService.getUsersByUsername(username.trim());

            if (listUser != null && !listUser.isEmpty()) {
                // 2. Chuyển dữ liệu sang dạng an toàn (Tránh lỗi Proxy của Hibernate)
                for (User u : listUser) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("userId", u.getUserId());
                    map.put("username", u.getUsername());
                    map.put("hoVaTen", u.getHoVaTen());
                    map.put("phoneNumber", u.getPhoneNumber());
                    map.put("roleName", u.getRole() != null ? u.getRole().getRoleName() : "N/A");
                    map.put("isActive", u.getActive());
                    users.add(map);
                }
            } else {
                message = "Tìm không thấy";
            }
        }

        // 3. Đẩy dữ liệu sang JSP
        req.setAttribute("users", users);
        req.setAttribute("message", message);
        req.getRequestDispatcher("/views/Home.jsp").forward(req, resp);
    }
}
