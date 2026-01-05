<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Green City Lottery</title>
</head>
<body>
<h1>Green City Lottery</h1>
<form action="draw" method="post">
    <label>Optional seed (for reproducible draw):</label>
    <input type="text" name="seed" />
    <button type="submit">Run Draw</button>
</form>
</body>
</html>
