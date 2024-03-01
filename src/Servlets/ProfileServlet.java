package Servlets;

import Classes.DBManager;
import Classes.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/profile")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-CONTENT/profile.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("userEmail");
        String fullName = req.getParameter("userName");
        String password = req.getParameter("userPassword");
        String repeatPass = req.getParameter("userRepeatPass");
        String role = req.getParameter("userRole");
        Long id = Long.valueOf(req.getParameter("userId"));

        if (password.equals(repeatPass)) {
            User user = new User();
            user.setId(id);
            user.setEmail(email);
            user.setPassword(password);
            user.setFullname(fullName);
            user.setRoleId(role);

            if(DBManager.updateUser(user)) {
                req.getSession().setAttribute("session", user);
                resp.sendRedirect("/profile");
            }
        } else {
            resp.sendRedirect("/profile?error");
        }
    }
}
