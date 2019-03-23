<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="weather.database" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\
<%
database _database = (database)session.getAttribute("my_database");
String username = request.getParameter("username");
String password = request.getParameter("password");
Boolean userExists = false;
Boolean success = false;
System.out.print(username);
System.out.print(password);

//if the username really exists in the database
if(_database.checkUser(username)){
	userExists = true;
}
if(_database.Validation(username, password)){
	success = true;
}

%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Authenticate</title>
	</head>
	<body>
		<%
		if(!userExists){
			response.sendRedirect("login.jsp?error=noUserName");
			System.out.println("username does not exist");
		}
		else if (!success){
			response.sendRedirect("login.jsp?error=doesnotMatch");
		}
		else {
			response.sendRedirect("display.jsp?username=" + username);
		}
		%>
	</body>
</html>