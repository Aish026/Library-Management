package com.library.servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.library.utils.DBUtil;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users(username, password, role) VALUES (?, ?, 'user')"
            );
            ps.setString(1, username);
            ps.setString(2, password);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("login.jsp?msg=registered");
            } else {
                response.sendRedirect("register.jsp?error=failed");
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            response.sendRedirect("register.jsp?error=exists");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=server");
        }
    }
}
