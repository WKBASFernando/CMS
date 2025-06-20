package com.ijse.cms.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // false to avoid creating if it doesn't exist
        if (session != null) {
            session.invalidate(); // remove all session attributes
        }
        response.sendRedirect(request.getContextPath() + "/view/pages/signinPage.jsp"); // or wherever your login is
    }
}
