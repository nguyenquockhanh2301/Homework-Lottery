CREATE TABLE IF NOT EXISTS `Applicant` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `status` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `Winner` (
  `ticket_id` BIGINT NOT NULL AUTO_INCREMENT,
  `applicant_id` INT NOT NULL,
  `seed` BIGINT NOT NULL,
  `draw_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ticket_id`),
  KEY `idx_applicant` (`applicant_id`),
  CONSTRAINT `fk_applicant` FOREIGN KEY (`applicant_id`) REFERENCES `Applicant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
