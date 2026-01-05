-- Schema for Green City Lottery (MySQL compatible)
-- Create database and use it (run as a single script in phpMyAdmin or mysql CLI)
CREATE DATABASE IF NOT EXISTS greencity CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE greencity;

CREATE TABLE IF NOT EXISTS Applicant (
  id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  status VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS Winner (
  ticket_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  applicant_id INT NOT NULL,
  seed BIGINT NOT NULL,
  draw_time TIMESTAMP NOT NULL,
  CONSTRAINT fk_applicant FOREIGN KEY (applicant_id) REFERENCES Applicant(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
