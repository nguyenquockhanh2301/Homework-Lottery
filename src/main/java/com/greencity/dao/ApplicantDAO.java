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
