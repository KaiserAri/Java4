package com.javaservlet.servlet;

import com.google.gson.Gson;
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String proleName = req.getParameter("pRoleName");
        System.out.println("--------------------------");
        System.out.println(">>> roleName: " + proleName);
        String roleName = "null";
        if(proleName != null && !proleName.trim().isEmpty()){
            roleName = proleName.trim();
        }
        System.out.println(">>> roleName: " + roleName);
        // -----------------
        // 1. Lấy dữ liệu từ DB
        UserService userService = new UserService();
        List<User> listUser = null;
        if(!roleName.equalsIgnoreCase("null")) {
            listUser = userService.getUsersByRoleName(roleName);
        } else {
            listUser = userService.getAllUsers();
        }
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
    }
}
