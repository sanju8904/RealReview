<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Images - RealReview</title>
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

        .success {
            color: #28a745; /* Green for success */
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

        input[type="file"],
        input[type="text"], 
        button {
            width: 100%; /* Full width input */
            padding: 10px; /* Padding inside inputs */
            margin-bottom: 15px; /* Space between inputs */
            border: 1px solid #ccc; /* Border style */
            border-radius: 4px; /* Rounded corners */
            font-size: 16px; /* Font size */
        }

        button {
            background-color: #1976d2; /* Button color */
            color: white; /* Button text */
            border: none; /* No border */
            cursor: pointer; /* Pointer cursor */
            transition: background-color 0.3s; /* Transition for hover */
        }

        button:hover {
            background-color: #0d47a1; /* Darker on hover */
        }

        h2 {
            margin-top: 30px; /* Margin above images list heading */
            text-align: center;
            color: #1976d2;
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
        <a href="/">Home</a> &gt; <span>Upload Image</span>
    </div>
    
    <h2>Upload New Image</h2>
    
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div> <!-- Error message display -->
    </c:if>
    <c:if test="${not empty success}">
        <div class="success">${success}</div> <!-- Success message display -->
    </c:if>
    
    <form method="post" action="/images/upload" enctype="multipart/form-data">
        <label for="file">Select Image:</label>
        <input type="file" id="file" name="file" accept="image/*" required>
        
        <label for="location">Location:</label>
        <input type="text" id="location" name="location" required>
        
        <label for="uploader">Your Name:</label>
        <input type="text" id="uploader" name="uploader" required>
        
        <button type="submit">Upload</button>
    </form>
    
    <h2>Images List</h2>
    <!-- Images and metadata will be listed here (Placeholder for future content) -->
</div>

</body>
</html>