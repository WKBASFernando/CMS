package com.ijse.cms.dao;

public class ComplaintDAO {
    private String id;
    private String title;
    private String description;
    private String priority;
    private String status;
    private String submittedBy;
    private String submittedTime;

    public ComplaintDAO() {}

    public ComplaintDAO(String id, String title, String description, String priority, String status, String submittedBy, String submittedTime) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.priority = priority;
        this.status = status;
        this.submittedBy = submittedBy;
        this.submittedTime = submittedTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSubmittedBy() {
        return submittedBy;
    }

    public void setSubmittedBy(String submittedBy) {
        this.submittedBy = submittedBy;
    }

    public String getSubmittedTime() {
        return submittedTime;
    }

    public void setSubmittedTime(String submittedTime) {
        this.submittedTime = submittedTime;
    }

    @Override
    public String toString() {
        return "ComplaintModel{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", priority='" + priority + '\'' +
                ", status='" + status + '\'' +
                ", submittedBy='" + submittedBy + '\'' +
                ", submittedTime='" + submittedTime + '\'' +
                '}';
    }
}
