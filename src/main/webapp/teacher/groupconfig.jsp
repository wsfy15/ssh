<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>课程</title>
    <script src="lib/jquery-3.3.1.min.js">
    </script>
</head>
<body>

<table border="1" width="100%">
    <thead>
    <tr>
        <th rowspan="2">课程id</th>
        <th rowspan="2">课名</th>
        <th rowspan="2">课程简介</th>
        <th colspan="2">前缀</th>
        <th rowspan="2">小组最小人数</th>
        <th rowspan="2">小组最大人数</th>
        <th rowspan="2">设置</th>
    </tr>
    <tr>
        <th>year</th>
        <th>class</th>
    </tr>
    <s:iterator value="courseList" var="course">
        <tr>
            <th id="cid"> <s:property value="#course.co_id" /> </th>
            <th id="cname"> <s:property value="#course.co_name" /> </th>
            <th id="cintro"> <s:property value="#course.co_describe" /> </th>
            <th id="cpreyear"> <s:property value="#course.co_gr_preyear " /> </th>
            <th id="cpreclass"> <s:property value="#course.co_gr_preclass " /> </th>
            <th id="cgroupmin"><s:property value="#course.co_gr_min " /></th>
            <th id="cgroupmax"><s:property value="#course.co_gr_max " /></th>
            <th id="cconfig"><input type="button" id="configbutton" value="设置" onclick="editData(this)"></th>
        </tr>
    </s:iterator>
    </thead>
</table>
    <script type="text/javascript">
        $(function() {
            var list = "<s:property value='courseList'/>";

                alert(list["course.co_id"]);



        });
        function editData(t) {
            var td = t.parentNode.parentNode.getElementsByTagName("th");
            td[3].innerHTML="<input size='4'type='number'min='2008' max='2058' value='"+td[3].innerText+"'/>";
            td[4].innerHTML="<input size='2'type='number'min='0' max='99' value='"+td[4].innerText+"'/>";
            td[5].innerHTML="<input size='1'type='number'min='1' max='9' value='"+td[5].innerText+"'/>";
            td[6].innerHTML="<input size='1'type='number'min='1' max='9'value='"+td[6].innerText+"'/>";
            td[7].innerHTML="<input type='button' id='cancel' value='取消'onclick='cancel(this)' ><input type='button' id='save' value='保存' >"
            alert(td[1].innerHTML);
        }
    </script>
</body>
</html>
