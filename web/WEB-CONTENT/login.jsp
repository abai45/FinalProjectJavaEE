<%--
  Created by IntelliJ IDEA.
  User: parsifal
  Date: 28.02.2024
  Time: 23:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        <%@include file="vendor/src/main.css"%>

        .loginContent {
            width: 30%;
            margin: 0 auto;
            text-align: center;
            margin-top: 20px;
            padding: 20px;
            display: flex;
            background-color: rgba(17, 17, 17, 0.2);
            align-items: center;
            flex-direction: column;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .loginEmail, .loginPassword {
            margin: 20px;
        }
        input {
            width: 80%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .error {
            color: #fff;
            background: rgba(169, 24, 24, 0.7);
            border-radius: 5px;
            padding: 10px;
            font-size: 14px;
        }
        #logIn {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            overflow: hidden;
            margin: 20px;
            width: 200px;
            color: #fff;
            background-color: #940101;
            padding: 10px;
            border: none;
            cursor: pointer;
            display: inline-block;
        }

        #logIn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
<%@include file="vendor/navBar.jsp"%>

<form action="/login" method="post">
    <div class="loginContent">
        <div class="loginEmail">
            Email:
        </div>
        <input type="email" name="userEmail" placeholder="Email">
        <div class="loginPassword">
            Password:
        </div>
        <input type="password" name="userPassword" placeholder="Password">
        <button id="logIn" type="submit">Log In</button>
        <%
            if(request.getParameter("error")!=null) {
        %>
        <div class="error">
            Error: Inputs is empty
        </div>
        <%
        } else if(request.getParameter("errorCredits")!=null) {
        %>
        <div class="error">
            Error: Credits is not correct
        </div>
        <%
            }
        %>
    </div>
</form>
</body>
</html>
