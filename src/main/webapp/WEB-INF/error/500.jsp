<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>500 - Internal Server Error</title>
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

        pre {
            background-color: #eee;
            color: #333;
            padding: 10px;
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<h1>500 - Internal Server Error</h1>
<p>Oops! Something went wrong on our end.</p>
<p>Please try again later.</p>
<% if (exception != null) { %>
<pre><%= exception.getMessage() %></pre>
<% } %>
</body>
</html>
