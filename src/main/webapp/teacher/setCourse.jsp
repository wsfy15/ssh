<%@ page language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="show.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div id="platform">
        <form method="post" action="${pageContext.request.contextPath }/course_save.action">
            <p >课程名:<input type="text" name="co_name" /></p>
            <p>开课时间: <input type="date" name="co_data" /></p>
            <p>课程描述: <input type="text" name="co_describe" /></p>
            <p>点名次数: <input type="number" min="0" name="co_ro_num" /></p>
            <input type="submit" value="Submit" />
        </form>
    </div>
</body>
</html>