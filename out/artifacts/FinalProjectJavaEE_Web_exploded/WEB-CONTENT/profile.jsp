<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <style>
        <%@include file="vendor/src/main.css"%>
        .welcomeProfile {
            width: 70%;
            margin: 0 auto;
            margin-top: 20px;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            font-weight: bold;
            text-align: center;
        }

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
<%
    if (user!=null) {
%>
<div class="welcomeProfile">
    Добро пожаловать, <%=user.getFullname()%>!
</div>
<form action="/profile" method="post">
    <div class="loginContent">
        <div class="loginEmail">
            Email:
        </div>
        <input type="email" name="userEmail" placeholder="Email" readonly value="<%=user.getEmail()%>">
        <div class="loginEmail">
            Full Name:
        </div>
        <input type="text" name="userName" placeholder="Email" value="<%=user.getFullname()%>">
        <div class="loginPassword">
            Password:
        </div>
        <input type="password" name="userPassword" placeholder="Password" value="<%=user.getPassword()%>">
        <div class="loginPassword">
            Repeat password:
        </div>
        <input type="password" name="userRepeatPass" placeholder="Password">
        <input type="hidden" name="userRole" placeholder="Password" value="<%=user.getRoleId()%>">
        <input type="hidden" name="userId" placeholder="Password" value="<%=user.getId()%>">
        <button id="logIn" type="submit">Update</button>
        <%
        if(request.getParameter("PassNotMatch")!=null) {
        %>
        <div class="error">
            Error: Pass Not Match
        </div>
        <%
            }
        %>
    </div>
    <%
        }
    %>
</form>
</body>
</html>
