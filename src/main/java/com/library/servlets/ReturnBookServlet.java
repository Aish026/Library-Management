package com.library.servlets;

import java.io.*;

import com.library.utils.DBUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.sql.*;
import java.time.LocalDate;

public class ReturnBookServlet extends HttpServlet {
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

            // Update transaction with return date
            PreparedStatement ps2 = conn.prepareStatement(
                "UPDATE transactions SET return_date=? WHERE user_id=? AND book_id=? AND return_date IS NULL"
            );
            ps2.setDate(1, java.sql.Date.valueOf(LocalDate.now()));
            ps2.setInt(2, userId);
            ps2.setInt(3, bookId);
            ps2.executeUpdate();

            // Mark book available again
            PreparedStatement ps3 = conn.prepareStatement("UPDATE books SET available=TRUE WHERE book_id=?");
            ps3.setInt(1, bookId);
            ps3.executeUpdate();

            response.sendRedirect("dashboard.jsp?msg=returned");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=server");
        }
    }
}
