<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
</head>
<body class="container mt-5">
    <h2>Register</h2>
    <form action="register" method="post" class="mt-3">
        <div class="mb-3">
            <input type="text" name="username" placeholder="Username" class="form-control" required>
        </div>
        <div class="mb-3">
            <input type="password" name="password" placeholder="Password" class="form-control" required>
        </div>
        <button class="btn btn-success">Register</button>
        <a href="login.jsp" class="btn btn-link">Back to Login</a>
    </form>

    <% if(request.getParameter("error") != null) { %>
        <p class="text-danger mt-2">Registration failed. Try again.</p>
    <% } %>
</body>
</html>
