package Servlets;

import Classes.Comment;
import Classes.DBManager;
import Classes.News;
import Classes.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/newsDetails")
public class NewsDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        News news = DBManager.getNewsById(id);
        req.setAttribute("OneNews",news);

        List<Comment> commentsList = DBManager.getComments(id);
        req.setAttribute("comments", commentsList);
        req.getRequestDispatcher("/WEB-CONTENT/newsDetails.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("session");
        Long id = Long.valueOf(req.getParameter("blogId"));
        String redirect = "";
        if(user!=null) {
            String comm = req.getParameter("comment");
            News news = DBManager.getNewsById(id);

            Comment comment = new Comment();
            comment.setUser_id(user);
            comment.setNews_id(news);
            comment.setComment(comm);

            if(DBManager.addComment(comment)) {
                redirect = "/newsDetails?id=" + id;
            }
        } else {
            redirect = "/newsDetails?logError&id="+id;
        }
        resp.sendRedirect(redirect);
    }
}
