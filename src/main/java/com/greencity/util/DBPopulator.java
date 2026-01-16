package com.greencity.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBPopulator {
    private static final String JDBC_URL = System.getProperty("db.url", "jdbc:h2:./data/greencity;MODE=MySQL;AUTO_SERVER=TRUE");
    private static final String USER = System.getProperty("db.user", "sa");
    private static final String PASS = System.getProperty("db.pass", "");

    public static void main(String[] args) throws Exception {
        try (Connection c = DriverManager.getConnection(JDBC_URL, USER, PASS)) {
            try (Statement s = c.createStatement()) {
                s.execute("CREATE TABLE IF NOT EXISTS Applicant (id INT PRIMARY KEY, name VARCHAR(255) NOT NULL, status VARCHAR(50))");
                s.execute("CREATE TABLE IF NOT EXISTS Winner (ticket_id BIGINT AUTO_INCREMENT PRIMARY KEY, applicant_id INT NOT NULL, seed BIGINT NOT NULL, draw_time TIMESTAMP NOT NULL)");
            }

            try (PreparedStatement ps = c.prepareStatement("SELECT COUNT(*) FROM Applicant"); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    if (count >= 1200) {
                        System.out.println("Applicants already populated: " + count);
                        return;
                    }
                }
            }

            String upsertSql;
            if (JDBC_URL.startsWith("jdbc:mysql:") || JDBC_URL.startsWith("jdbc:mariadb:")) {
                upsertSql = "INSERT INTO Applicant(id, name, status) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE name=VALUES(name), status=VALUES(status)";
            } else {
                upsertSql = "MERGE INTO Applicant(id, name, status) KEY(id) VALUES (?, ?, ?)";
            }

            try (PreparedStatement ins = c.prepareStatement(upsertSql)) {
                for (int i = 1; i <= 1200; i++) {
                    ins.setInt(1, i);
                    ins.setString(2, "Applicant " + i);
                    ins.setString(3, "valid");
                    ins.addBatch();
                    if (i % 200 == 0) ins.executeBatch();
                }
                ins.executeBatch();
            }
            System.out.println("Inserted 1200 sample applicants into H2 DB at: " + JDBC_URL);
        }
    }
}
