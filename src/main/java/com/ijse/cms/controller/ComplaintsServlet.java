package com.ijse.cms.controller;


import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ijse.cms.crud.IdGeneratorWithPrefix;
import com.ijse.cms.dao.ComplaintDAO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/saveComplaint")
public class ComplaintsServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("_method");

        // Check if this is a PUT request (update)
        if ("PUT".equalsIgnoreCase(method)) {
            handleUpdateComplaint(req, resp);
            return;
        }

        // Check if this is a Delete request (Delete)
        if ("DELETE".equalsIgnoreCase(method)) {
            String user = req.getParameter("_user");
            handleDeleteComplaint(req, resp, user);
            return;
        }

        // Handle normal POST request (create new complaint)
        try {
            PreparedStatement stm = ds.getConnection().prepareStatement("INSERT INTO complaints values(?,?,?,?,?,?,?)");
            String nextID = IdGeneratorWithPrefix.generateNextId(ds, "Complaints", "id", "C", 3);
            System.out.println(nextID);
            stm.setString(1, nextID);
            stm.setString(2, req.getParameter("title"));
            stm.setString(3, req.getParameter("description"));
            stm.setString(4, req.getParameter("priority"));
            stm.setString(5, "Open");
            stm.setString(6, req.getParameter("submittedBy"));
            stm.setString(7, req.getParameter("submittedAt"));
            int i = stm.executeUpdate();
            if (i > 0) {
                req.getSession().setAttribute("complaintSaved", "Complaint Saved");
            } else {
                req.getSession().setAttribute("complaintNotSaved", "Complaint NOT Saved");
            }
            System.out.println(i);
            resp.sendRedirect(req.getContextPath() + "/view/pages/dashboard.jsp");

        } catch (Exception e) {
            req.getSession().setAttribute("complaintNotSaved", "Complaint NOT Saved");
            resp.sendRedirect(req.getContextPath() + "/view/pages/dashboard.jsp");
            e.printStackTrace();
        }
    }

    // Separate method to handle complaint Deletes
    private void handleDeleteComplaint(HttpServletRequest req, HttpServletResponse resp, String user) throws IOException, ServletException {
        try {
            String employeeMail = req.getParameter("userEmail");
            String id = req.getParameter("id");

            // Delete the complaint
            PreparedStatement deleteStm = ds.getConnection().prepareStatement("DELETE FROM complaints WHERE id = ?");
            deleteStm.setString(1, id);
            int i = deleteStm.executeUpdate();

            System.out.println(i + " Deleted");

            if (i > 0) {
                List<ComplaintDAO> complaintList = new ArrayList<>();
                PreparedStatement fetchStm;

                // Fetch complaints depending on the role
                if (!user.equals("EMPLOYEE")) {
                    fetchStm = ds.getConnection().prepareStatement("SELECT * FROM complaints");
                } else {
                    fetchStm = ds.getConnection().prepareStatement("SELECT * FROM complaints WHERE submitted_by = ?");
                    fetchStm.setString(1, employeeMail);
                }

                ResultSet rs = fetchStm.executeQuery();

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

                req.getSession().setAttribute("complaintList", complaintList);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        // Redirect back to complaints view for both roles
        resp.sendRedirect(req.getContextPath() + "/view/pages/dashboard.jsp?view=complaints");
    }

    // Separate method to handle complaint updates
    private void handleUpdateComplaint(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String complaintId = req.getParameter("complaintId");
            String status = req.getParameter("status");

            System.out.println("Updating complaint ID: " + complaintId + " with status: " + status);

            PreparedStatement stm = ds.getConnection().prepareStatement(
                    "UPDATE complaints SET status = ? WHERE id = ?"
            );
            stm.setString(1, status);
            stm.setString(2, complaintId);

            int rowsUpdated = stm.executeUpdate();

            if (rowsUpdated > 0) {
                req.getSession().setAttribute("complaintUpdated", "Complaint status updated successfully");
            } else {
                req.getSession().setAttribute("complaintUpdateFailed", "Failed to update complaint status");
            }
            // fetch updated complaint list
            PreparedStatement fetchStm = ds.getConnection().prepareStatement("SELECT * FROM complaints");
            ResultSet rs = fetchStm.executeQuery();
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

            req.getSession().setAttribute("complaintList", complaintList);

        } catch (SQLException e) {
            e.printStackTrace();
            req.getSession().setAttribute("complaintUpdateFailed", "Database error occurred");
        }

        // Redirect back to complaints view
        resp.sendRedirect(req.getContextPath() + "/view/pages/dashboard.jsp?view=complaints");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            PreparedStatement stm = ds.getConnection().prepareStatement("SELECT * FROM complaints");
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

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
