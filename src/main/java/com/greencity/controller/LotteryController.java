package com.greencity.controller;

import com.greencity.dao.ApplicantDAO;
import com.greencity.model.Applicant;
import com.greencity.service.LotteryService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class LotteryController extends HttpServlet {
    private String jdbcUrl;
    private String dbUser;
    private String dbPass;
    private int winnersCount = 500;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        jdbcUrl = getServletContext().getInitParameter("db.url");
        dbUser = getServletContext().getInitParameter("db.user");
        dbPass = getServletContext().getInitParameter("db.password");
        String wc = getServletContext().getInitParameter("winners.count");
        if (wc != null) {
            try { winnersCount = Integer.parseInt(wc); } catch (NumberFormatException ignored) {}
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String seedParam = req.getParameter("seed");
        Long seed = null;
        try {
            if (seedParam != null && !seedParam.isEmpty()) seed = Long.parseLong(seedParam);
        } catch (NumberFormatException ignored) {}

        ApplicantDAO dao = new ApplicantDAO(jdbcUrl, dbUser, dbPass);
        try {
            List<Applicant> applicants = dao.getAllApplicants();
            LotteryService service = new LotteryService();
            List<Applicant> winners = service.draw(applicants, winnersCount, seed);
            long actualSeed = (seed != null) ? seed : System.currentTimeMillis();
            dao.saveWinners(winners, actualSeed);
            // Store results in session and redirect to results page (PRG pattern)
            req.getSession().setAttribute("winners", winners);
            req.getSession().setAttribute("seed", actualSeed);
            resp.sendRedirect(req.getContextPath() + "/results");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
