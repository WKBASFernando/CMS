package com.ijse.cms.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebFilter("/view/pages/dashboard.jsp")
public class DashboardDataFilterServlet implements Filter {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        int newComplaints = 0, pending = 0, resolved = 0;

        try (Connection con = ds.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT status, COUNT(*) AS count FROM complaints GROUP BY status");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String status = rs.getString("status").toLowerCase();
                int count = rs.getInt("count");

                switch (status) {
                    case "open": newComplaints = count; break;
                    case "in progress": pending = count; break;
                    case "resolved": resolved = count; break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println(newComplaints);
        System.out.println(pending);
        System.out.println(resolved);
        // Inject data into the request scope
        request.setAttribute("newComplaints", newComplaints);
        request.setAttribute("pending", pending);
        request.setAttribute("resolved", resolved);

        // Pass the request forward
        chain.doFilter(request, response);
    }
}


