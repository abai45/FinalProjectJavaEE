<%@ page import="Classes.News" %><%--
  Created by IntelliJ IDEA.
  User: parsifal
  Date: 28.02.2024
  Time: 23:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add News</title>
    <style>
        body {
            font-family: sans-serif,Arial;
            margin: 0;
            padding: 0;
        }
        .mainContent {
            margin: 0 auto;
            margin-top: 20px;
            width: 70%;
            gap:20px;
        }

        input, select  {
            width: 800px;
            font-size: 18px;
            margin-top: 5px;
            padding: 5px 10px;
        }
        .popup__inputArea {
            padding: 20px 10px;
            line-height: 28px;
            width: 100%;
        }
        .popup__content {
            background-color: #fff;
            color: #000;
            max-width: 900px;
            padding: 30px;
            border-radius: 3px;
        }

        .popup_buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            gap: 20px;
        }

        .popup__save{
            font-size: 15px;
            text-decoration: none;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            background-color: #940101;
            border: none;
        }

        .popup__title {
            font-size: 30px;
            font-weight: bold;
            margin: 0 0 1em;
        }

        input,textarea {
            margin-bottom: 20px;
            margin-top: 10px;
            border: #252525;
        }
        textarea {
            width: 100%;
            height: 300px;
            font-size: 18px;
        }
        .error {
            margin-top: 15px;
            color: #fff;
            background: rgba(169, 24, 24, 0.7);
            border-radius: 5px;
            padding: 10px;
            font-size: 14px;
        }
        .popup__select {
            width: 100%;
            padding: 5px 10px;
            font-size: 18px;
            margin-top: 5px;
            border: #252525;
            background-color: #fff;
            border-radius: 3px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        .popup__select option {
            font-size: 18px;
        }
    </style>
</head>
<body>
<%@include file="vendor/navBar.jsp"%>
<div class="mainContent">
    <form action="/editNews" method="post">
        <%
            News news = (News) request.getAttribute("OneNews");
        %>
        <div class="popup__content">
            <div class="popup__title">Редактирование новости</div>
            <div class="popup__text">
                Заголовок:
            </div>
            <input type="text" class="popup__inputTitle" placeholder="Заголовок" name="title" value="<%=news.getTitle()%>">
            <div class="popup__text">
                Контент:
            </div>
            <textarea type="text" class="popup__inputArea" placeholder="Контент" name="content"><%=news.getContent()%></textarea>
            <div class="popup__text">
                Категория:
            </div>
            <select name="category" class="popup__select">
                <option value="1">Politics</option>
                <option value="2">Sport</option>
                <option value="3">Crime</option>
                <option value="4">Buisness</option>
                <option value="5">Other</option>
            </select>
            <div class="popup_buttons">
                <button type="submit" class="popup__save">Отредактировать</button>
            </div>
            <input type="hidden" name="newsId" value="<%=news.getId()%>">
            <input type="hidden" name="newsPostDate" value="<%=news.getPost_date()%>">
            <%
                if(request.getParameter("errorTitle")!=null) {
            %>
            <div class="error">
                Error: Пожалуйста, заполните заголовок
            </div>
            <%
            } else if (request.getParameter("errorContent")!=null) {
            %>
            <div class="error">
                Error: Пожалуйста, заполните контент
            </div>
            <%
                }
            %>
        </div>
    </form>
</div>
</body>
</html>
