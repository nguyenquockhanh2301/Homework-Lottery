<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Draw Results</title>
</head>
<body>
<h1>Draw Results</h1>
<p>Seed used: <c:out value="${seed}"/></p>
<table border="1">
    <tr><th>#</th><th>ID</th><th>Name</th><th>Status</th></tr>
    <c:forEach var="a" items="${winners}" varStatus="st">
        <tr>
            <td><c:out value="${st.index + 1}"/></td>
            <td><c:out value="${a.id}"/></td>
            <td><c:out value="${a.name}"/></td>
            <td><c:out value="${a.status}"/></td>
        </tr>
    </c:forEach>
</table>
<p><a href="index.jsp">Back</a></p>
</body>
</html>
