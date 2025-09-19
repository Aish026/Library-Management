package com.library.servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.library.utils.DBUtil;
import java.sql.*;

public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO books(title, author, available) VALUES (?, ?, TRUE)"
            );
            ps.setString(1, title);
            ps.setString(2, author);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("admin.jsp?msg=bookadded");
            } else {
                response.sendRedirect("admin.jsp?error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?error=server");
        }
    }
}
