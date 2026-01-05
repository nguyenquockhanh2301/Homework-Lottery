# Green City Lottery - Homework Module

Simple Java Servlet + JSP (Model-2) app that performs a fair draw using `SecureRandom` and Fisher‑Yates.

Quick start (using Maven + Tomcat):

1. Build:

```bash
mvn package
```

2. Deploy the generated WAR in `target/` to a Servlet container (Tomcat 9+/Jakarta compatible).

3. Initialize DB (H2): run `sql/schema.sql` against the H2 database or let the app create the file on first run.

Defaults are configured in `WEB-INF/web.xml` (H2 embedded URL). Change `db.url`, `db.user`, `db.password` as needed.

Usage:
- Open `index.jsp`, optionally provide a seed value, and submit the draw.
- Results displayed on `draw.jsp` and persisted into the `Winner` table with seed and timestamp.

Next steps (optional):
- Add export to PDF/Excel
- Add authentication and admin UI
