<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@   page   import= "entity.*"%>
<%@   page   import= "java.util.Set"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="js/jquery-3.3.1.min.js"></script>
    <!--<script>-->
        <!--//ajax获取数据-->

        <!--var text='{"1":"a", "2":"b", "3":"c"}';-->
        <!--//通过parse获取json对应键值-->
        <!--var jsonObject = JSON.parse(text, null);-->

    <!--</script>-->
    <link href="/student/studshow.css" rel="stylesheet" type="text/css">
</head>

<body>
    <div id="leftcontainer">
        <span class="setleft wid80">
            <span class="fyhbx">*</span>选择课程
        </span>
        <div class=" posirelative select-out-div">
            <select class="m-wrap" id="uli" style="width: 180px; padding: 2px 0;">
            </select>
            <button id="but1">显示课程</button>
            <span class="select-hide-span" >
                <b class="select-show-b"></b>
            </span>
        </div>
    </div>
    <div id="rightcontainer">
        <table id="table1" border="1">
            <tr>
                <th>课程id</th>
                <th>课名</th>
                <th>课程简介</th>
                <th>教师</th>
                <th>小组情况</th>
            </tr>
            <c:forEach items="${courses}" var="course">
                <tr>
                    <th id="cid">${course.co_id}</th>
                    <th id="cname">${course.co_name}</th>
                    <th id="cintro">${course.co_describe}</th>
                    <th id="cteach"> ${course}.getTeacher().getName() </th>
                    <th id="cgroup">???</th>
                </tr>
            </c:forEach>


        </table>
    </div>
    <!--<script>-->

        <!--$(function () {-->

            <!--//ajax返回一个json包（学生选的课 key：value形式为 0："计算机科学"）-->
        <!--/*   $.getJSON("DZHI","XUESHENG",function(result){-->
                <!--$.each(result, function(i, value){-->
                    <!--var txt=$("<li></li>").value(value);-->
                    <!--$("#uli").append(txt);-->
                <!--})})*/-->

            <!--$.each(jsonObject,function (key,value) {-->
                <!--var txt=$("<option></option>").text(value).val(key);-->
                <!--$("#uli").append(txt);-->
            <!--})-->

            <!--var result={0:"a",1:"b",2:"c",3:"d",4:"asdffffffffffffffffffffffffffffffffffff"};-->
            <!--$.each(result, function(i, value) {-->
                <!--if (i == 0) {-->
                    <!--$("#cid").html(value);-->
                <!--}-->
                <!--if (i == 1) {-->
                    <!--$("#cname").html(value);-->
                <!--}-->
                <!--if (i == 2) {-->
                    <!--$("#cintro").html(value);-->
                <!--}-->
                <!--if (i == 3) {-->
                    <!--$("#cteach").html(value);-->
                <!--}-->
                <!--if (i == 4) {-->
                    <!--$("#cgroup").html(value);-->
                <!--}-->
            <!--})-->

            <!--//通过发送课程的名字获取课程具体内容-->
            <!--$("#but1").click(function () {-->
                <!--//获取课程名-->
                <!--var data=$("#uli").find("option:selected").text();-->
                <!--alert(data);-->
                <!--var kvalue=$("#uli").find("option:selected").val();-->
                <!--alert(kvalue);-->

                <!--//获取json,格式为（0：id,1:课名，2：课程简介，3：教师，4：小组情况）-->
                <!--$.getJSON("DZHI",data,function(result){-->
                    <!--$.each(result, function(i, value){-->
                        <!--if(i==0){-->
                            <!--$("#cid").html(value);-->
                        <!--}-->
                        <!--if(i==1){-->
                            <!--$("#cname").html(value);-->
                        <!--}-->
                        <!--if(i==2){-->
                            <!--$("#cintro").html(value);-->
                        <!--}-->
                        <!--if(i==3){-->
                            <!--$("#cteach").html(value);-->
                        <!--}-->
                        <!--if(i==4){-->
                            <!--$("#cgroup").html(value);-->
                        <!--}-->

                    <!--})})-->
            <!--})-->
        <!--})-->
    <!--</script>-->
</body>
</html>