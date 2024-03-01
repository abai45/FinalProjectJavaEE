package Servlets;

import Classes.Category;
import Classes.News;
import Classes.User;
import Classes.DBManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/addNews")
public class AddNewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-CONTENT/addNews.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String categoryIdString = req.getParameter("category");
        String redirect="";

        if (categoryIdString != null) {
            Long categoryId = Long.parseLong(categoryIdString);
            if(title.equals("")) {
                redirect = "/addBlog?errorTitle";
            } else if (content.equals("")) {
                redirect = "/addBlog?errorContent";
            } else {
                News news = new News();
                User currentUser = (User) req.getSession().getAttribute("session");
                if (currentUser==null) {
                    redirect = "/login";
                } else {
                    news.setTitle(title);
                    news.setContent(content);
                    Category category = DBManager.getCategory(categoryId);
                    news.setCategory(category);
                    DBManager.addNews(news);
                    redirect = "/news";
                }
            }
        } else {
            redirect="/addNews?categoryError";
        }
        resp.sendRedirect(redirect);
    }
}
