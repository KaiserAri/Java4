package com.javaservlet.servlet;

import com.google.gson.Gson;
import com.javaservlet.entity.User; // Đổi lại package Entity cho đúng với code của anh
import com.javaservlet.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/", "/login", "/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();

        if (path.equals("/home")) {
            // 1. Lấy dữ liệu từ DB
            UserService userService = new UserService();
            List<User> listUser = userService.getAllUsers();
            // 2. Chuyển dữ liệu sang dạng an toàn (Tránh lỗi Proxy của Hibernate)
            List<Map<String, Object>> safeUsers = new ArrayList<>();
            for (User u : listUser) {
                Map<String, Object> map = new HashMap<>();
                map.put("userId", u.getUserId());
                map.put("hoVaTen", u.getHoVaTen());
                map.put("phoneNumber", u.getPhoneNumber());
                // Lấy tên Role, nếu Role null thì để N/A tránh lỗi NullPointerException
                map.put("roleName", u.getRole() != null ? u.getRole().getRoleName() : "N/A");
                map.put("isActive", u.getActive());
                safeUsers.add(map);
            }
            // 3. Dùng Gson biến List Map thành chuỗi JSON
            Gson gson = new Gson();
            String usersJson = gson.toJson(safeUsers);
            // 4. Đẩy chuỗi JSON sạch sẽ này sang JSP
            req.setAttribute("usersJson", usersJson);
            req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();

        if (path.equals("/login")) {
            String u = req.getParameter("username");
            String p = req.getParameter("password");

            System.out.println("====================================");
            System.out.println("LOG LOGIN: " + u + " / " + p);
            System.out.println("====================================");

            if (u != null && !u.isEmpty()) {
                req.getSession().setAttribute("userLogged", u);
                // Redirect về đúng context path để không bị lỗi URL
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/login?error=1");
            }
        }
    }
}