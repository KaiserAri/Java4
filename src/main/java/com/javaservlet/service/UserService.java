package com.javaservlet.service;

import com.javaservlet.entity.User;

import javax.persistence.EntityManager;
import java.util.List;
public class UserService {
    EntityManager ec = EntityConnectivity.getEntityManager();
    public List<User> getAllUsers() {
        List<User> result = null;
        try{
            result = ec.createQuery("select u from User u", User.class).getResultList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            ec.close();
        }
        return result;
    }

    public List<User> getUsersByRoleName(String roleName) {
        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            // JPQL sử dụng dấu "." để truy cập thuộc tính của đối tượng liên kết (Role)
            String jpql = "SELECT u FROM User u WHERE u.role.roleName = :roleName";

            return em.createQuery(jpql, User.class)
                    .setParameter("roleName", roleName) // Chống SQL Injection
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
