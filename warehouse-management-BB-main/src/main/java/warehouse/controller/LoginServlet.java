package warehouse.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DEMO_EMAIL = "user@example.com";
    private static final String DEMO_PASSWORD = "password123";


    public LoginServlet() {
        super();
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if(email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if(authenticateUser(email, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("isLoggedIn", true);

            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }


    private boolean authenticateUser(String email, String password) {

        return email.equals(DEMO_EMAIL) && password.equals(DEMO_PASSWORD);
    }
}