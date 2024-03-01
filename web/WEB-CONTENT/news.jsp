<%@ page import="java.util.List" %>
<%@ page import="Classes.News" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>News</title>
    <style>
        <%@include file="vendor/src/main.css"%>

    </style>
</head>
<body>
    <%@include file="vendor/navBar.jsp"%>
    <div class="news">
        <%
            List<News> news = (List<News>) request.getAttribute("news");
            for(News n: news) {
                %>
                <div class="newsCard">
                    <div class="newsTitle">
                        <%=n.getTitle()%>
                    </div>
                    <div class="newsContent">
                        <%=n.getContent()%>
                    </div>
                    <div class="newsInfo">
                        <div class="newsPostDate">
                            Post Date: <%=n.getPost_date()%>
                        </div>
                        <div class="newsCategory">
                            Category: <%=n.getCategory().getName()%>
                        </div>
                    </div>
                    <div class="newsLink">
                        <a href="/newsDetails?id=<%=n.getId()%>" class="blogLink">Go to news</a>
                    </div>
                </div>
                <%
            }
        %>
    </div>
</body>
</html>
