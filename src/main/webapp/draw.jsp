<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Draw Results</title>
    <style>
        :root {
            --bg: #0f172a;
            --card: #111827;
            --accent: #10b981;
            --accent-2: #22d3ee;
            --text: #e5e7eb;
            --muted: #94a3b8;
            --border: #1f2937;
            --radius: 12px;
            --shadow: 0 10px 40px rgba(0,0,0,0.35);
        }
        body {
            margin: 0;
            font-family: "Inter", "Segoe UI", system-ui, -apple-system, sans-serif;
            background: radial-gradient(circle at 10% 20%, rgba(16,185,129,0.08), transparent 25%),
                        radial-gradient(circle at 90% 10%, rgba(34,211,238,0.08), transparent 25%),
                        var(--bg);
            color: var(--text);
            min-height: 100vh;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 32px; }
        .card { background: var(--card); border: 1px solid var(--border); border-radius: var(--radius); padding: 22px; box-shadow: var(--shadow); }
        h1 { margin: 0 0 10px; letter-spacing: -0.4px; }
        .muted { color: var(--muted); }
        table { width: 100%; border-collapse: collapse; margin-top: 16px; }
        th, td { padding: 10px 12px; text-align: left; }
        th { color: var(--muted); font-size: 13px; border-bottom: 1px solid var(--border); letter-spacing: 0.4px; }
        tr { border-bottom: 1px solid var(--border); }
        tr:last-child { border-bottom: none; }
        .btn { display: inline-block; margin-top: 16px; padding: 12px 14px; border-radius: 10px; text-decoration: none; font-weight: 700; color: #0c1224; background: linear-gradient(135deg, var(--accent), var(--accent-2)); box-shadow: 0 8px 24px rgba(16,185,129,0.35); }
        .pill { display: inline-block; padding: 6px 10px; border-radius: 999px; background: rgba(16,185,129,0.12); color: #a7f3d0; font-weight: 700; font-size: 12px; }
    </style>
</head>
<body>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container">
    <div class="card">
        <h1>Draw Results</h1>
        <p class="muted">Seed used: <span class="pill">${seed}</span></p>
        <table>
            <thead>
            <tr><th>#</th><th>ID</th><th>Name</th><th>Status</th></tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${winners}" varStatus="st">
                <tr>
                    <td>${st.index + 1}</td>
                    <td>${a.id}</td>
                    <td>${a.name}</td>
                    <td>${a.status}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <a class="btn" href="${ctx}/applicants">Back to applicants</a>
    </div>
</div>
</body>
</html>
