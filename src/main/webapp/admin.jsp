<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.library.utils.DBUtil" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null 
        || !"admin".equals(sessionObj.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) sessionObj.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
</head>
<body class="container mt-5">
    <h2>Admin Dashboard - Welcome, <%= username %>!</h2>
    <a href="logout" class="btn btn-danger">Logout</a>

    <h3 class="mt-4">Add New Book</h3>
    <form action="addBook" method="post" class="mt-3">
        <input type="text" name="title" placeholder="Title" class="form-control mb-2" required>
        <input type="text" name="author" placeholder="Author" class="form-control mb-2" required>
        <button class="btn btn-success">Add Book</button>
    </form>

    <h3 class="mt-4">All Books</h3>
    <table class="table table-bordered mt-3">
        <tr>
            <th>ID</th><th>Title</th><th>Author</th><th>Available</th>
        </tr>
        <%
            try (Connection conn = DBUtil.getConnection()) {
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM books");
                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("book_id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("author") %></td>
                <td><%= rs.getBoolean("available") ? "Yes" : "No" %></td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error loading books</td></tr>");
            }
        %>
    </table>
</body>
</html>
