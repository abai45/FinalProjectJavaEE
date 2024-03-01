package Servlets;

import Classes.DBManager;
import Classes.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.swing.text.html.HTML;
import java.io.IOException;

@WebServlet(value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-CONTENT/login.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("userEmail");
        String password = req.getParameter("userPassword");
        User user = DBManager.getUser(email);

        HttpSession session = req.getSession();
        session.setAttribute("session", user);
        String redirect = "";
        if(user!=null) {
            if(user.getEmail().equals(email) && user.getPassword().equals(password)) {
                redirect = "/profile";
                System.out.println("LogIn");
            } else {
                redirect = "/login?errorCredits";
            }
        } else {
            redirect="/login?error";
        }
        resp.sendRedirect(redirect);
    }
}
