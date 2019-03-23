<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signing out...</title>
</head>
<body>
	<%
	response.sendRedirect("display.jsp");
	session.setAttribute("_username", null);

	%>
</body>
</html>