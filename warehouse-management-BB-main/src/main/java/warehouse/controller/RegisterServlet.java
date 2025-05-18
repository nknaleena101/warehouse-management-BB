package warehouse.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public RegisterServlet() {
        super();
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");

        if(fullName == null || email == null || fullName.trim().isEmpty() || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Full name and email are required");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if(!isValidEmail(email)) {
            request.setAttribute("errorMessage", "Please enter a valid email address");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if(isEmailAlreadyRegistered(email)) {
            request.setAttribute("errorMessage", "This email is already registered");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        boolean registrationSuccess = registerUser(fullName, email);

        if(registrationSuccess) {
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userName", fullName);
            session.setAttribute("isLoggedIn", true);

            request.setAttribute("successMessage", "Registration successful! Welcome to Style Haven.");

            response.sendRedirect("welcome.jsp");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again later.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }


    private boolean isValidEmail(String email) {
        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return email.matches(emailPattern);
    }


    private boolean isEmailAlreadyRegistered(String email) {

        return false;
    }


    private boolean registerUser(String fullName, String email) {

        return true;
    }
}