<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - RealReview</title>
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
            max-width: 900px; /* Maximum width */
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

        /* Success and Error Messages */
        .success {
            color: #28a745; /* Green for success messages */
            text-align: center;
            margin-bottom: 15px;
        }

        .error {
            color: #ff0000; /* Red for error messages */
            text-align: center;
            margin-bottom: 15px;
        }

        /* Table Styles */
        table {
            width: 100%; /* Full width tables */
            border-collapse: collapse; /* Collapse borders */
            margin-top: 20px; /* Space above tables */
        }

        th, td {
            padding: 10px; /* Padding in cells */
            text-align: left; /* Left align text */
        }

        th {
            background: #1976d2; /* Header background color */
            color: white; /* Header text color */
        }

        tr:nth-child(even) {
            background-color: #f4f4f4; /* Zebra striping for rows */
        }

        img {
            max-width: 100px; /* Max width for images */
            border-radius: 4px; /* Rounded corners for images */
        }

        button {
            padding: 8px 12px; /* Button padding */
            background-color: #1976d2; /* Button color */
            color: white; /* Button text */
            border: none; /* No border */
            border-radius: 4px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor */
            transition: background-color 0.3s; /* Transition for hover */
            margin: 5px; /* Margin around buttons */
        }

        button:hover {
            background-color: #0d47a1; /* Darker on hover */
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
    <h2 class="header-title">RealReview Admin Panel</h2>

    <div class="breadcrumbs">
        <a href="/">Home</a> &gt; <span>Admin Panel</span>
    </div>
    
    <!-- Success and Error Messages -->
    <c:if test="${not empty success}">
        <div class="success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty status}">
        <div class="success">${status}</div>
    </c:if>

    <h3>Pending Images for Approval</h3>
    <table>
        <thead>
            <tr>
                <th>Image</th>
                <th>Uploader</th>
                <th>Location</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="img" items="${pendingImages}">
                <tr>
                    <td><img src="/uploads/${img.filename}" alt="Pending Image" /></td>
                    <td>${img.uploader}</td>
                    <td>${img.location}</td>
                    <td>
                        <form method="post" action="${pageContext.request.contextPath}/admin/approve" style="display:inline;">
                            <input type="hidden" name="imageId" value="${img.id}" />
                            <button type="submit">Approve</button>
                        </form>
                        <form method="post" action="${pageContext.request.contextPath}/admin/reject" style="display:inline;">
                            <input type="hidden" name="imageId" value="${img.id}" />
                            <button type="submit">Reject</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <form method="get" action="/admin/archive" style="margin-top: 20px;">
        <button type="submit">Archive Old Images</button>
    </form>
</div>
</body>
</html>