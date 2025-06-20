package com.ijse.cms.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ijse.cms.dao.ComplaintDAO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/mycomplaints")
public class MyComplaints extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            PreparedStatement stm = ds.getConnection().prepareStatement("SELECT * FROM complaints where submitted_by = ?");
            stm.setString(1, req.getParameter("userEmail"));
            ResultSet rs = stm.executeQuery();
            List<ComplaintDAO> complaintList = new ArrayList<>();
            while (rs.next()) {
                ComplaintDAO complaint = new ComplaintDAO();
                complaint.setId(rs.getString("id"));
                complaint.setTitle(rs.getString("title"));
                complaint.setDescription(rs.getString("description"));
                complaint.setPriority(rs.getString("priority"));
                complaint.setStatus(rs.getString("status"));
                complaint.setSubmittedBy(rs.getString("submitted_by"));
                complaint.setSubmittedTime(rs.getString("submitted_at"));
                complaintList.add(complaint);
            }
            System.out.println(complaintList.size());
            if (complaintList.size() > 0) {
                req.getSession().setAttribute("complaintList", complaintList);
                resp.sendRedirect(req.getContextPath() + "/view/pages/dashboard.jsp?view=complaints");
            }else {
                req.getSession().setAttribute("complaintList", complaintList);
                resp.sendRedirect(req.getContextPath() + "/view/pages/dashboard.jsp?view=complaints");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
