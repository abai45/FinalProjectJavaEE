package Servlets;

import Classes.DBManager;
import Classes.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-CONTENT/register.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("userEmail");
        String fullName = req.getParameter("userName");
        String password = req.getParameter("userPassword");
        String repeatPass = req.getParameter("userRepeatPass");
        User newUser = DBManager.getUser(email);

        String redirect = "";
        if(newUser!=null) {
            redirect = "/register?emailIsBusy";
        } else {
            if (password.equals(repeatPass)) {
                User user = new User();

                user.setEmail(email);
                user.setPassword(password);
                user.setFullname(fullName);

                if(DBManager.createUser(user)) {
                    redirect = "/login";
                }
            } else {
                redirect = "/register?passwordDontMatch";
            }
        }
        resp.sendRedirect(redirect);
    }
}
