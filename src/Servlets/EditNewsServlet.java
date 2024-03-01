package Servlets;

import Classes.Category;
import Classes.DBManager;
import Classes.News;
import Classes.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;

@WebServlet(value = "/editNews")
public class EditNewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        News news = DBManager.getNewsById(id);
        req.setAttribute("OneNews",news);
        req.getRequestDispatcher("/WEB-CONTENT/updateNews.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String categoryIdString = req.getParameter("category");
        Long categoryId = Long.parseLong(categoryIdString);
        Long id = Long.valueOf(req.getParameter("newsId"));
        Timestamp post_date = Timestamp.valueOf(req.getParameter("newsPostDate"));
        String redirect="";


        if (categoryIdString != null) {
            News news = new News();
            news.setId(id);
            news.setTitle(title);
            news.setContent(content);
            Category category = DBManager.getCategory(categoryId);
            news.setCategory(category);
            news.setPost_date(post_date);
            if(DBManager.updateNews(news)) {
                redirect = "/news";
            }
        } else {
            redirect = "/editNews?error";
        }
        resp.sendRedirect(redirect);
    }
}
