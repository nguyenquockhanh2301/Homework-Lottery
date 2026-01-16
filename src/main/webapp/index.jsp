<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Green City Lottery</title>
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
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: "Inter", "Segoe UI", system-ui, -apple-system, sans-serif;
            background: radial-gradient(circle at 10% 20%, rgba(16,185,129,0.08), transparent 25%),
                        radial-gradient(circle at 90% 10%, rgba(34,211,238,0.08), transparent 25%),
                        var(--bg);
            color: var(--text);
            min-height: 100vh;
        }
        header {
            padding: 28px 32px 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
        }
        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .brand-mark {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent), var(--accent-2));
            display: grid;
            place-items: center;
            color: #0b1021;
            font-weight: 800;
            letter-spacing: -0.5px;
            box-shadow: var(--shadow);
        }
        .subtitle { color: var(--muted); font-size: 14px; margin: 4px 0 0; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 32px 32px; }
        .grid { display: grid; grid-template-columns: 1.1fr 0.9fr; gap: 24px; }
        .card {
            background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.00)), var(--card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px 22px;
            box-shadow: var(--shadow);
        }
        .section-title { margin: 0 0 12px; font-size: 18px; letter-spacing: -0.2px; }
        .muted { color: var(--muted); }
        form.draw-form { display: grid; gap: 10px; margin-top: 8px; }
        label { font-size: 14px; color: var(--muted); }
        input[type="text"] {
            padding: 10px 12px;
            border-radius: 10px;
            border: 1px solid var(--border);
            background: #0b1224;
            color: var(--text);
            outline: none;
        }
        input[type="text"]:focus { border-color: var(--accent); box-shadow: 0 0 0 3px rgba(16,185,129,0.15); }
        .btn {
            border: none;
            border-radius: 10px;
            padding: 12px 14px;
            cursor: pointer;
            font-weight: 700;
            letter-spacing: 0.2px;
            color: #0c1224;
            background: linear-gradient(135deg, var(--accent), var(--accent-2));
            box-shadow: 0 8px 24px rgba(16,185,129,0.35);
            transition: transform 120ms ease, box-shadow 120ms ease;
        }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 12px 30px rgba(16,185,129,0.4); }
        .btn:active { transform: translateY(0); }
        table { width: 100%; border-collapse: collapse; margin-top: 12px; }
        th, td { padding: 10px 12px; text-align: left; }
        th { color: var(--muted); font-size: 13px; letter-spacing: 0.4px; border-bottom: 1px solid var(--border); }
        tr { border-bottom: 1px solid var(--border); }
        tr:last-child { border-bottom: none; }
        .pill { display: inline-block; padding: 6px 10px; border-radius: 999px; background: rgba(16,185,129,0.12); color: #a7f3d0; font-weight: 600; font-size: 12px; }
        .pagination { display: flex; gap: 8px; flex-wrap: wrap; margin-top: 14px; }
        .page-link {
            padding: 8px 12px;
            border-radius: 10px;
            border: 1px solid var(--border);
            color: var(--text);
            text-decoration: none;
            background: #0b1224;
        }
        .page-link.active { background: var(--accent); color: #0c1224; border-color: var(--accent); font-weight: 700; }
        .page-link:hover { border-color: var(--accent); }
        .stats { display: flex; gap: 16px; flex-wrap: wrap; margin-top: 12px; }
        .stat-card { padding: 14px 16px; border-radius: 12px; background: #0b1224; border: 1px solid var(--border); min-width: 140px; }
        .stat-label { font-size: 12px; color: var(--muted); margin: 0 0 4px; }
        .stat-value { font-size: 20px; font-weight: 800; margin: 0; }
        @media (max-width: 900px) { .grid { grid-template-columns: 1fr; } header { flex-direction: column; align-items: flex-start; } }
    </style>
</head>
<body>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<header>
    <div class="brand">
        <div class="brand-mark">GC</div>
        <div>
            <h2 style="margin:0">Green City Lottery</h2>
            <p class="subtitle">Fair, reproducible draws with SecureRandom</p>
        </div>
    </div>
    <div class="pill">500 winners from 1200 applicants</div>
</header>

<div class="container">
    <div class="grid">
        <section class="card">
            <h3 class="section-title">Applicants</h3>
            <p class="muted">Browse applicants 20 at a time. Use the draw panel to run the lottery.</p>

            <div class="stats">
                <div class="stat-card">
                    <p class="stat-label">Total Applicants</p>
                    <p class="stat-value">${totalApplicants}</p>
                </div>
                <div class="stat-card">
                    <p class="stat-label">Page</p>
                    <p class="stat-value">${page} / ${totalPages}</p>
                </div>
            </div>

            <table>
                <thead>
                <tr>
                    <th>#</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="a" items="${applicants}" varStatus="st">
                    <tr>
                        <td>${(page - 1) * pageSize + st.index + 1}</td>
                        <td>${a.id}</td>
                        <td>${a.name}</td>
                        <td>${a.status}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="pagination">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a class="page-link ${p == page ? 'active' : ''}" href="${ctx}/applicants?page=${p}">${p}</a>
                </c:forEach>
            </div>
        </section>

        <section class="card">
            <h3 class="section-title">Run Draw</h3>
            <p class="muted">Optional seed lets you reproduce a draw for audits.</p>
            <form class="draw-form" action="${ctx}/draw" method="post">
                <label for="seed">Seed (optional)</label>
                <input id="seed" type="text" name="seed" placeholder="e.g. 20240116" />
                <button class="btn" type="submit">Run Lottery</button>
                <a class="page-link" style="text-align:center" href="${ctx}/results">View last results</a>
            </form>
        </section>
    </div>
</div>

</body>
</html>
