<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Details - RealReview</title>
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
        }

        /* Rating style */
        .rating-container {
            margin: 15px 0;
        }

        /* Image Styles */
        img {
            width: 100%; /* Full width images */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px; /* Space below images */
        }

        /* Form and Label Styles */
        label {
            font-weight: bold;
            margin: 10px 0 5px; /* Margin for labels */
            display: block; /* Block display for labels */
        }

        select,
        button {
            width: 100%; /* Full width select and button */
            padding: 10px; /* Padding within elements */
            margin-top: 5px; /* Space above elements */
            border-radius: 4px; /* Rounded corners */
            border: 1px solid #ccc; /* Border style */
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

        /* Success Message */
        #ajax-rating-msg {
            color: #27ae60; /* Green for success messages */
            margin-top: 10px; /* Space above message */
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Header Title -->
    <h2 class="header-title">RealReview</h2>

    <div class="breadcrumbs">
        <a href="/">Home</a> &gt; <span>Image Details</span>
    </div>

    <h2>Image Details</h2>
    
    <c:if test="${not empty image}">
        <img src="/uploads/${image.filename}" alt="Image Details" />
        <p><strong>Uploader:</strong> ${image.uploader}</p>
        <p><strong>Location:</strong> ${image.location}</p>
        <p><strong>Uploaded At:</strong> ${image.uploadTime}</p>
        <p><strong>Status:</strong> <c:choose><c:when test="${image.approved}">Approved</c:when><c:otherwise>Pending</c:otherwise></c:choose></p>
        
        <h4>Ratings</h4>
        <c:forEach var="rating" items="${ratings}">
            <div>⭐ ${rating.value} by ${rating.username}</div>
        </c:forEach>

        <div class="rating-container">
            <form id="ajax-rating-form" method="post" action="/api/ratings">
                <input type="hidden" name="imageId" value="${image.id}" />
                <input type="hidden" name="username" value="${user.username}" />
                <label for="rating">Rate this image:</label>
                <select id="rating" name="value">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
                <button type="submit">Submit Rating</button>
                <span id="ajax-rating-msg"></span>
            </form>
        </div>
    </c:if>

    <!-- Displayed if image does not exist -->
    <c:if test="${empty image}">
        <p class="error-message">Image not found.</p>
    </c:if>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var form = document.getElementById('ajax-rating-form');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(form);
            fetch('/api/ratings', {
                method: 'POST',
                body: formData
            })
            .then(res => res.ok ? res.text() : Promise.reject(res))
            .then(msg => {
                document.getElementById('ajax-rating-msg').textContent = 'Thank you for rating!';
            })
            .catch(() => {
                document.getElementById('ajax-rating-msg').textContent = 'Failed to submit rating.';
            });
        });
    }
});
</script>
</body>
</html>