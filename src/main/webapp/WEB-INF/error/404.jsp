<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            text-align: center;
            padding-top: 10%;
        }
        h1 {
            font-size: 48px;
            color: #ff4c4c;
        }
        p {
            font-size: 20px;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
    </style>
</head>
<body>
<h1>404 - Page Not Found</h1>
<p>Sorry, the page you're looking for doesn't exist.</p>
<p><a href="<%= request.getContextPath() %>/">Go back to Home</a></p>
</body>
</html>
