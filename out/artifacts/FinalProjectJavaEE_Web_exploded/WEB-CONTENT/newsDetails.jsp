<%@ page import="java.util.ArrayList" %>
<%@ page import="Classes.News" %>
<%@ page import="Classes.DBManager" %>
<%@ page import="java.util.List" %>
<%@ page import="Classes.Comment" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>News Details</title>
    <style>
        <%@include file="vendor/src/main.css"%>
        .blogCards {
            width: 70%;
            margin: 0 auto;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .blogCard, .comments {
            width: 100%;
            margin-top: 20px;
            background-color: rgb(211, 211, 211);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .title {
            font-size: 24px;
            margin: 10px 0;
        }

        .content {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .timestamp,.email {
            font-style: italic;
        }
        .authorDiv {
            display: flex;
            justify-content: space-between;
        }
        .author {
            font-weight: bold;
        }
        .blogLink {
            text-decoration: none;
            color: #fff;
            background-color: #940101;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            font-size: 14px;
            margin-top: 10px;
            cursor: pointer;
            text-align: center;
            width: 200px;
        }
        .commentArea {
            width:100%;
            padding: 5px;
            font-size: 14px;
            height: 150px;
            border: none;
            border-radius: 5px;

        }
        .commentBlock {
            display: flex;
            flex-direction: column;
        }
        .line {
            background-color: #333333;
            width: 100%;
            height: 1px;
            margin-bottom: 10px;
        }
        .error {
            color: #fff;
            background: rgb(157, 48, 48);
            border-radius: 5px;
            padding: 10px;
            font-size: 14px;
            margin-top: 20px;
        }
        .buttonsEdit {
            width: 100%;
            display: flex;
            gap: 20px;
            align-items: center;
            height: 60px;
        }
        .editLink, .deleteLink {
            text-decoration: none;
            color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-size: 14px;
            text-align: center;
            min-width: 100px;
            max-height: 70%;
            cursor: pointer;
        }
        .editLink {
            background-color: #63903a;

        }
        .deleteLink {
            margin-top: 15px;
            background-color: #940101;
        }
    </style>
</head>
<body>
<%@include file="vendor/navBar.jsp"%>
<div class="blogCards">
    <%
        News news = (News) request.getAttribute("OneNews");
        if(news!=null) {
    %>
    <div class="blogCard">
        <h5 class="title"><%=news.getTitle()%></h5>
        <p class="content"><%=news.getContent()%></p>
        <p class="timestamp"><%=news.getPost_date()%></p>
        <div class="authorDiv">
            <p class="author">Category: <%=news.getCategory().getName()%></p>
        </div>
        <%
            if(user != null && user.getRoleId() != null && user.getRoleId().equals("admin")) {
        %>
        <div class="buttonsEdit">
            <a href="/editNews?id=<%=news.getId()%>" class="editLink">Отредактировать</a>
            <form action="/deleteNews" method="post">
                <input type="hidden" name="newsIdDelete" value="<%=news.getId()%>">
                <button class="deleteLink" type="submit" name="delete">Удалить</button>
            </form>
        </div>
        <%
            }
        %>
        <form action="/newsDetails" method="post">
            <input type="hidden" value="<%=news.getId()%>" name="blogId">
            <div class="commentBlock">
                <div class="line"></div>
                <textarea class="commentArea" placeholder="Оставить комментарий..." name="comment"></textarea>
                <button class="blogLink" type="submit">Оставить комментарий</button>
            </div>
            <%
                if(request.getParameter("logError")!=null) {
            %>
            <div class="error">
                Error: Authorization error
            </div>
            <%
                }
            %>
        </form>
    </div>
    <%
        }
    %>
    <%
        List<Comment> comments = (List<Comment>) request.getAttribute("comments");
        for(Comment c: comments) {
    %>
    <div class="comments">
        <p class="author"><%=c.getUser_id().getFullname()%></p>
        <p class="content"><%=c.getComment()%></p>
        <p class="content"><%=c.getPost_date()%></p>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
