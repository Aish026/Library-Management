<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
</head>
<body class="container mt-5">
    <h2>Login</h2>
    <form action="login" method="post" class="mt-3">
        <div class="mb-3">
            <input type="text" name="username" placeholder="Username" class="form-control" required>
        </div>
        <div class="mb-3">
            <input type="password" name="password" placeholder="Password" class="form-control" required>
        </div>
        <button class="btn btn-primary">Login</button>
        <a href="register.jsp" class="btn btn-link">Register</a>
    </form>

    <% if(request.getParameter("error") != null) { %>
        <p class="text-danger mt-2">Invalid credentials!</p>
    <% } %>
    <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("registered")) { %>
        <p class="text-success mt-2">Registration successful! Please login.</p>
    <% } %>
</body>
</html>
