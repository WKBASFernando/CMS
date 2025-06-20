package com.ijse.cms.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.ijse.cms.model.UserModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PreparedStatement stm = ds.getConnection().prepareStatement("select * from users where email = ? and password = ?");
            stm.setString(1, req.getParameter("email"));
            stm.setString(2, req.getParameter("password"));
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                UserModel user = new UserModel();
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setName(rs.getString("name"));
                req.getSession().setAttribute("user", user);

                // Create session and store user data
                HttpSession session = req.getSession();
                session.setAttribute("loggedIn", true);
                session.setAttribute("user", user);
                session.setAttribute("userName", user.getName());
                session.setAttribute("userEmail", user.getEmail());
                System.out.println(user.getEmail());

                session.setAttribute("userRole", user.getRole());
//                req.getRequestDispatcher("/view/pages/dashboard.jsp").forward(req, resp);
                resp.sendRedirect( req.getContextPath() + "/view/pages/dashboard.jsp");
            }else {
                req.getSession().setAttribute("error", "Invalid Email or Password");
                resp.sendRedirect(req.getContextPath() + "/view/pages/signinPage.jsp");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
