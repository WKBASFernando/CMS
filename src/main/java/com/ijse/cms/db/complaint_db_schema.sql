
-- Database: complaint_db

CREATE DATABASE IF NOT EXISTS complaint_db;
USE complaint_db;

-- Table: users
CREATE TABLE IF NOT EXISTS users (
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(100) NOT NULL,
  role ENUM('employee', 'admin') DEFAULT 'employee',
  PRIMARY KEY (email)
);

-- Table: complaints
CREATE TABLE IF NOT EXISTS complaints (
  id VARCHAR(10) NOT NULL,
  title VARCHAR(255) DEFAULT NULL,
  description TEXT,
  priority VARCHAR(20) DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'Open',
  submitted_by VARCHAR(50) NOT NULL,
  submitted_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (submitted_by) REFERENCES users(email) ON DELETE CASCADE ON UPDATE CASCADE
);
