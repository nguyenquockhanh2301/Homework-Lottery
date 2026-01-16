package com.greencity.controller;

import com.greencity.dao.ApplicantDAO;
import com.greencity.model.Applicant;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ApplicantsController extends HttpServlet {
    private String jdbcUrl;
    private String dbUser;
    private String dbPass;
    private static final int PAGE_SIZE = 20;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        jdbcUrl = getServletContext().getInitParameter("db.url");
        dbUser = getServletContext().getInitParameter("db.user");
        dbPass = getServletContext().getInitParameter("db.password");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Math.max(1, Integer.parseInt(pageParam));
            } catch (NumberFormatException ignored) {
                page = 1;
            }
        }

        ApplicantDAO dao = new ApplicantDAO(jdbcUrl, dbUser, dbPass);
        try {
            int totalApplicants = dao.countApplicants();
            int totalPages = (int) Math.ceil(totalApplicants / (double) PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            int offset = (page - 1) * PAGE_SIZE;
            List<Applicant> applicants = dao.getApplicantsPage(offset, PAGE_SIZE);

            req.setAttribute("applicants", applicants);
            req.setAttribute("page", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalApplicants", totalApplicants);
            req.setAttribute("pageSize", PAGE_SIZE);
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}