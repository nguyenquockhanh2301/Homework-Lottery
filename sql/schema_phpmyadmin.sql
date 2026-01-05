-- phpMyAdmin-friendly schema for Green City Lottery
-- Import this file into your chosen database (select the DB in phpMyAdmin first)

-- Applicants table
CREATE TABLE IF NOT EXISTS `Applicant` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `status` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Winners table
CREATE TABLE IF NOT EXISTS `Winner` (
  `ticket_id` BIGINT NOT NULL AUTO_INCREMENT,
  `applicant_id` INT NOT NULL,
  `seed` BIGINT NOT NULL,
  `draw_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ticket_id`),
  KEY `idx_applicant` (`applicant_id`),
  CONSTRAINT `fk_applicant` FOREIGN KEY (`applicant_id`) REFERENCES `Applicant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Optional: small sample insert (uncomment to use)
-- INSERT INTO `Applicant` (id, name, status) VALUES (1,'Applicant 1','valid'), (2,'Applicant 2','valid');

-- Note:
-- - Use phpMyAdmin Import and select the target database before importing this file.
-- - For bulk test data (1200 rows) run the project's DBPopulator or use the provided sample script.
