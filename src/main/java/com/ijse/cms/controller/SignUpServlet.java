package com.ijse.cms.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.PreparedStatement;

@WebServlet("/signupServlet")
public class SignUpServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PreparedStatement stm = ds.getConnection().prepareStatement("insert into users values(?,?,?,?)");
            stm.setString(1, req.getParameter("name"));
            stm.setString(2, req.getParameter("email"));
            stm.setString(3, req.getParameter("password"));
            stm.setString(4, "employee");
            int isCreated = stm.executeUpdate();

            if (isCreated > 0) {
                System.out.println("User has been created");
                req.getSession().setAttribute("success", "User has been created successfully!");
                resp.sendRedirect(req.getContextPath() + "/view/pages/signinPage.jsp");
            } else {
                System.out.println("User has not been created");
                req.getSession().setAttribute("userNotSaved", "Failed to create user. Please try again.");
                resp.sendRedirect(req.getContextPath() + "/view/pages/signupPage.jsp");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("userNotSaved", "An error occurred: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/view/pages/signupPage.jsp");
            throw new RuntimeException(e);
        }
    }
}
