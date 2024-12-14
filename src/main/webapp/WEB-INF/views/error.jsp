<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오류 발생</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8d7da;
        }
        .error-container {
            text-align: center;
            background-color: #ffffff;
            border: 1px solid #f5c2c7;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .error-container h1 {
            color: #721c24;
        }
        .error-container p {
            margin: 10px 0;
            color: #721c24;
        }
        .error-container a {
            text-decoration: none;
            color: white;
            background-color: #007bff;
            padding: 10px 15px;
            border-radius: 5px;
        }
        .error-container a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>오류 발생</h1>
        <p>${errorMessage}</p>
        <p>
            <a href="<c:url value='/board/list' /> ">목록으로 돌아가기</a>
        </p>
    </div>
</body>
</html>
