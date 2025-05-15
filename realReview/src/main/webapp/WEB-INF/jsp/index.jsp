<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RealReview Home</title>
    <link rel="stylesheet" type="text/css" href="/style.css" />
    <style>
        /* Reset and general styles */
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #e3f2fd, #bbdefb);
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 100%; /* Full width */
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        /* Header and Navigation */
        h2.header-title {
            text-align: center;
            color: #1976d2;
            margin: 0;
            font-size: 2.5em;
            padding: 20px; /* Added padding for spacing */
            background-color: #f4f4f4; /* Background color to separate */
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #1976d2;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        .nav a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .nav a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        /* Grid layout for the image cards */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 15px;
        }

        /* Card Styles */
        .card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }

        .card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .card img:hover {
            transform: scale(1.1);
        }

        /* Card Meta Information */
        .meta {
            padding: 15px;
            font-size: 0.95em;
            color: #555;
            background: #f4f4f4;
        }

        .reviews {
            padding: 10px 15px;
            font-size: 0.9em;
            color: #444;
        }

        /* Pagination Styling */
        .pagination {
            text-align: center;
            margin: 20px 0;
        }

        .pagination a {
            margin: 0 5px;
            padding: 8px 12px;
            border-radius: 4px;
            background: #1976d2;
            color: #ffffff;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .pagination a.active {
            background: #0d47a1;
        }

        .pagination a:hover {
            background: #0d47a1;
        }

        /* Button Styles */
        button, select {
            padding: 8px;
            border: 1px solid #1976d2;
            border-radius: 4px;
            background-color: #f4f4f4;
            color: #1976d2;
            cursor: pointer;
            transition: background-color 0.4s, color 0.4s;
        }

        button:hover, select:hover {
            background-color: #1976d2;
            color: #ffffff;
        }

        .btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 15px;
            color: white;
            background-color: #28a745;
            border-radius: 4px;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.4s;
        }

        .btn:hover {
            background-color: #218838;
        }

        .ajax-rating-msg {
            margin-left: 10px;
            color: #27ae60;
        }

        /* Responsive Styles */
        @media (max-width: 600px) {
            .grid {
                grid-template-columns: 1fr;
            }

            .nav {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.ajax-rating-form').forEach(function(form) {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    const formData = new FormData(form);
                    fetch('/api/ratings', {
                        method: 'POST',
                        body: formData
                    })
                    .then(res => res.ok ? res.text() : Promise.reject(res))
                    .then(msg => {
                        form.querySelector('.ajax-rating-msg').textContent = 'Thank you for rating!';
                    })
                    .catch(() => {
                        form.querySelector('.ajax-rating-msg').textContent = 'Failed to submit rating.';
                    });
                });
            });
        });
    </script>
</head>
<body>
<div class="container">
    <h2 class="header-title">RealReview</h2>
    <div class="nav">
        <div class="logo">
            <a href="/">Home</a>
        </div>
        <div class="menu">
            <a href="/images">Gallery</a>

            <sec:authorize access="isAnonymous()">
                <a href="/login">Login</a>
                <a href="/register">Register</a>
            </sec:authorize>

            <sec:authorize access="isAuthenticated()">
                <form action="/logout" method="post" style="display:inline;">
                    <button type="submit" style="background:none; border:none; color:white; cursor:pointer;">Logout</button>
                </form>
            </sec:authorize>

            <sec:authorize access="hasRole('ADMIN')">
                <a href="/admin">Admin Panel</a>
            </sec:authorize>
        </div>
    </div>

    <h2>All Verified Property Images</h2>
    <div class="grid">
        <c:forEach var="img" items="${images}">
            <div class="card">
                <img src="/uploads/${img.filename}" alt="Property Image" />
                <div class="meta">
                    Uploaded by <b>${img.uploader}</b> on <b>${img.uploadTimeFormatted}</b>
                </div>
                <div class="reviews">
                    <c:choose>
                        <c:when test="${empty img.ratings}">
                            <div>No reviews yet.</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="review" items="${img.ratings}">
                                <div>⭐ ${review.value} by ${review.username}</div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:choose>
                    <c:when test="${not empty user}">
                        <form class="ajax-rating-form">
                            <input type="hidden" name="imageId" value="${img.id}" />
                            <input type="hidden" name="username" value="${user.username}" />
                            <select name="value">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>
                            <button type="submit">Rate</button>
                            <span class="ajax-rating-msg"></span>
                        </form>
                    </c:when>
                    <!-- <c:otherwise>
                        <a href="/login">Login to rate</a>
                    </c:otherwise> -->
                </c:choose>
                <a href="/images/details/${img.id}" class="btn">View Details</a>
            </div>
        </c:forEach>
    </div>
    <div class="pagination">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="/?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
    </div>
</div>
</body>
</html>