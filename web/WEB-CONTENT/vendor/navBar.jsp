<%@ page import="Classes.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>News</title>
    <style>
        .container {
            max-width: 100%;
            background-color: #252525;
        }

        .navBar {
            display: flex;
            align-items: center;
            max-width: 70%;
            justify-content: space-between;
            margin: 0 auto;
            padding: 10px;
            color: #fff;
        }

        .logoText, .link{
            text-decoration: none;
            color: #fff;
        }
        .logoText {
            font-size: 24px;
            font-weight: bold;
            background-color: #940101;
            padding: 10px 15px;
            height: 100%;
            margin-right: 20px;
        }
        .logo .link {
            margin-right: 20px;
        }
        .link {
            font-size: 18px;
        }
        .navLink .link{
            margin-right: 15px;
            color: #fff;
            text-decoration: none;
        }
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("session");
%>
<section class="container">
    <div class="navBar">
        <div class="logo">
            <a class="logoText" href="/news">NEWS</a>
            <%
                if(user != null && user.getRoleId() != null && user.getRoleId().equals("admin")) {
            %>
            <a class="link" href="/addNews">Add News</a>
            <%
                }
            %>
        </div>
        <div class="navLink">
            <%
                if(user!=null) {
            %>
            <a class="link" href="/profile">Profile</a>
            <a class="link" href="/logout">Log Out</a>
            <%} else { %>
            <a class="link" href="/login">Log In</a>
            <a class="link" href="/register">Registration</a>

            <% } %>
        </div>
    </div>
</section>
</body>
</html>
