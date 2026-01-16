package com.greencity.dao;

import com.greencity.model.Applicant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicantDAO {
    private final String jdbcUrl;
    private final String dbUser;
    private final String dbPass;

    public ApplicantDAO(String jdbcUrl, String dbUser, String dbPass) {
        this.jdbcUrl = jdbcUrl;
        this.dbUser = dbUser;
        this.dbPass = dbPass;
    }

    private Connection getConnection() throws SQLException {
        // Explicitly load driver in case ServiceLoader auto-registration is disabled in the container
        try {
            if (jdbcUrl != null) {
                if (jdbcUrl.startsWith("jdbc:h2:")) {
                    Class.forName("org.h2.Driver");
                } else if (jdbcUrl.startsWith("jdbc:mysql:")) {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                }
            }
        } catch (ClassNotFoundException ignored) {
            // If driver is already loaded or not on classpath, let DriverManager handle the error
        }
        return DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
    }

    public List<Applicant> getAllApplicants() throws SQLException {
        List<Applicant> list = new ArrayList<>();
        String sql = "SELECT id, name, status FROM Applicant";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Applicant a = new Applicant(rs.getInt("id"), rs.getString("name"), rs.getString("status"));
                list.add(a);
            }
        }
        return list;
    }

    public List<Applicant> getApplicantsPage(int offset, int limit) throws SQLException {
        List<Applicant> list = new ArrayList<>();
        String sql = "SELECT id, name, status FROM Applicant ORDER BY id LIMIT ? OFFSET ?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Applicant(rs.getInt("id"), rs.getString("name"), rs.getString("status")));
                }
            }
        }
        return list;
    }

    public int countApplicants() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Applicant";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public void saveWinners(List<Applicant> winners, long seed) throws SQLException {
        String sql = "INSERT INTO Winner(applicant_id, seed, draw_time) VALUES (?, ?, ?)";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            for (Applicant a : winners) {
                ps.setInt(1, a.getId());
                ps.setLong(2, seed);
                ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }
}
