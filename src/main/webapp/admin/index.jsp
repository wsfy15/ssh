<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>admin</title>
    </head>
    <body>
        <% String id = (String)session.getAttribute("id"); %>

        <h1>admin</h1>
        <p>
            <%=id%>
        </p>
    </body>
</html>