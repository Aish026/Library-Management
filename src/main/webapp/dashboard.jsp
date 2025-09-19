<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.library.utils.DBUtil" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) sessionObj.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
</head>
<body class="container mt-5">
    <h2>Welcome, <%= username %>!</h2>
    <a href="logout" class="btn btn-danger">Logout</a>

    <h3 class="mt-4">Available Books</h3>
    <table class="table table-bordered mt-3">
        <tr>
            <th>ID</th><th>Title</th><th>Author</th><th>Action</th>
        </tr>
        <%
            try (Connection conn = DBUtil.getConnection()) {
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE available=TRUE");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("book_id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("author") %></td>
                <td>
                    <form action="borrowBook" method="post">
                        <input type="hidden" name="bookId" value="<%= rs.getInt("book_id") %>">
                        <button class="btn btn-primary">Borrow</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error loading books</td></tr>");
            }
        %>
    </table>

    <h3 class="mt-4">My Borrowed Books</h3>
    <table class="table table-bordered mt-3">
        <tr>
            <th>ID</th><th>Title</th><th>Borrowed</th><th>Action</th>
        </tr>
        <%
            try (Connection conn = DBUtil.getConnection()) {
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT t.book_id, b.title, t.borrow_date FROM transactions t " +
                    "JOIN books b ON t.book_id=b.book_id " +
                    "JOIN users u ON t.user_id=u.user_id " +
                    "WHERE u.username=? AND t.return_date IS NULL"
                );
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("book_id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getDate("borrow_date") %></td>
                <td>
                    <form action="returnBook" method="post">
                        <input type="hidden" name="bookId" value="<%= rs.getInt("book_id") %>">
                        <button class="btn btn-warning">Return</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error loading borrowed books</td></tr>");
            }
        %>
    </table>
</body>
</html>
