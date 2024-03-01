<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <style>
        <%@include file="vendor/src/main.css"%>

        .loginContent {
            width: 30%;
            margin: 0 auto;
            text-align: center;
            background-color: rgba(17, 17, 17, 0.2);
            margin-top: 20px;
            padding: 20px;
            display: flex;
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
            background: rgb(98, 8, 8);
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

<form action="/register" method="post">
    <div class="loginContent">
        <div class="loginEmail">
            Email:
        </div>
        <input type="email" name="userEmail" placeholder="Email">
        <div class="loginEmail">
            Full Name:
        </div>
        <input type="text" name="userName" placeholder="Email">
        <div class="loginPassword">
            Password:
        </div>
        <input type="password" name="userPassword" placeholder="Password">
        <div class="loginPassword">
            Repeat password:
        </div>
        <input type="password" name="userRepeatPass" placeholder="Password">
        <button id="logIn" type="submit">Register</button>
        <%
            if(request.getParameter("emailIsBusy")!=null) {
        %>
        <div class="error">
            Error: Email Already is busy
        </div>
        <%
        } else if(request.getParameter("enterName")!=null) {
        %>
        <div class="error">
            Error: U need to write ur full name
        </div>
        <%
        } else if(request.getParameter("PassNotMatch")!=null) {
        %>
        <div class="error">
            Error: Pass Not Match
        </div>
        <%
            }
        %>
    </div>
</form>
</body>
</html>
