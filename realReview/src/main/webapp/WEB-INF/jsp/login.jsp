<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - RealReview</title>
    <link rel="stylesheet" type="text/css" href="/style.css" />
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #e3f2fd, #bbdefb);
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 100%; /* Full width */
            max-width: 600px; /* Maximum width */
            margin: 50px auto; /* Centered with margin */
            padding: 20px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        /* Header Title */
        h2.header-title {
            text-align: center;
            color: #1976d2;
            margin: 20px 0;
            font-size: 2.5em;
        }

        /* Breadcrumbs */
        .breadcrumbs {
            text-align: center;
            margin: 10px 0;
        }

        .breadcrumbs a {
            color: #1976d2;
            text-decoration: none;
        }

        .error-message {
            color: #ff0000; /* Red for errors */
            text-align: center;
            margin-bottom: 15px;
        }

        /* Form Styles */
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            margin: 10px 0 5px; /* Margin for labels */
            font-weight: bold;
            text-align: left;
            width: 100%;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%; /* Full width input */
            padding: 10px; /* Padding inside inputs */
            margin-bottom: 15px; /* Space between inputs */
            border: 1px solid #ccc; /* Border style */
            border-radius: 4px; /* Rounded corners */
            font-size: 16px; /* Font size */
        }

        button {
            width: 100%; /* Full width button */
            padding: 10px; /* Padding inside button */
            background-color: #1976d2; /* Button color */
            color: white; /* Button text */
            border: none; /* No border */
            border-radius: 4px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor */
            font-size: 16px; /* Button text size */
            transition: background-color 0.3s; /* Transition for hover */
        }

        button:hover {
            background-color: #0d47a1; /* Darker on hover */
        }

        p {
            text-align: center; /* Centered text */
        }

        /* Responsive styles */
        @media (max-width: 600px) {
            .container {
                margin: 20px; /* Less margin on smaller screens */
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Header Title -->
    <h2 class="header-title">RealReview</h2>
    
    <div class="breadcrumbs">
        <a href="/">Home</a> &gt; <span>Login</span>
    </div>
    
    <h2>Login</h2>
    
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div> <!-- Error message display -->
    </c:if>
    
    <form method="post" action="/login">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        
        <button type="submit">Login</button>
    </form>

    <p>Don't have an account? <a href="/register">Register here</a></p>
</div>
</body>
</html>