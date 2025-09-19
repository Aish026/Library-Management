package com.library.servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.library.utils.DBUtil;
import java.sql.*;
import java.time.LocalDate;

public class BorrowBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");

        try (Connection conn = DBUtil.getConnection()) {
            // Find user_id
            PreparedStatement ps1 = conn.prepareStatement("SELECT user_id FROM users WHERE username=?");
            ps1.setString(1, username);
            ResultSet rs1 = ps1.executeQuery();
            if (!rs1.next()) {
                response.sendRedirect("dashboard.jsp?error=usernotfound");
                return;
            }
            int userId = rs1.getInt("user_id");

            // Insert transaction
            PreparedStatement ps2 = conn.prepareStatement(
                "INSERT INTO transactions(user_id, book_id, borrow_date) VALUES (?, ?, ?)"
            );
            ps2.setInt(1, userId);
            ps2.setInt(2, bookId);
            ps2.setDate(3, java.sql.Date.valueOf(LocalDate.now()));
            ps2.executeUpdate();

            // Mark book unavailable
            PreparedStatement ps3 = conn.prepareStatement("UPDATE books SET available=FALSE WHERE book_id=?");
            ps3.setInt(1, bookId);
            ps3.executeUpdate();

            response.sendRedirect("dashboard.jsp?msg=borrowed");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=server");
        }
    }
}
