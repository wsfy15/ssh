<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生作业系统</title>
    <style type="text/css">
        html{
            height: 100%;
        }
        body{
            height: 100%;
        }
        a {
            text-decoration: none;
            display: block;
            line-height: 30px;
            padding-left: 20px;
            color: #fff;
        }
        ul {
            width: 10%;
            /*min-width: 150px;*/
            /*max-width: 240px;*/
            height: 100%;
            display: block;
            padding-top: 30px;
            padding-right: 30px;
            background: #333;
            margin: auto;
            float: left;
        }
        li {
            list-style: none;
            width: 120px;
            height: 30px;
            border: 1px solid #ccc;
            margin-top: 10px;
        }
        .li {
            background:#fff;
            color:#333;
        }
        .container {
            float: right;
            width: 85.3%;
            height: 100%;
            padding-top: 30px;
            background: #ccc;
        }

        .iframe {
            width: 100%;
            height:100%;
            border-style: none;

        }
    </style>

    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
        var selectedLi;
        function change(page) {
            selectedLi = page;
            selectedLi.className = null;

            document.getElementById('content').src = page.rel;
        }



        function queryCourse(){
            var url = "${ pageContext.request.contextPath }/student_getAllCourse.action";
            var id="<%=session.getAttribute("id")%>";
            var param = {"id": id };
            $.post(url, param, function(data){
                // 遍历
                $(data).each(function(i,n){
                    console.log(n);
                    $('#table1').append("<tr></tr>");
                    $('#table1').children(':last-child').append("<th>"+ n.co_id + "</th>");
                    $('#table1').children(':last-child').append("<th>"+ n.co_name + "</th>");
                    $('#table1').children(':last-child').append("<th>"+ n.co_describe + "</th>");
                    $('#table1').children(':last-child').append("<th>"+ n.teacher_name + "</th>");
                    $('#table1').children(':last-child').append("<th>???</th>");
                });
            },"json");
        }

    </script>
</head>
<body>
    <ul id="menu">
        <li>
            <a onclick="queryCourse(this)" href="javascript:" >
                查看课程
            </a>
        </li>

        <li>
            <a onclick="change(this)" href="javascript:" rel="${ pageContext.request.contextPath }/student/infor.html" class="li">个人信息</a>
        </li>

        <li>
            <a onclick="change(this)" href="javascript:" rel="${ pageContext.request.contextPath }/error.html">123</a>
        </li>
    </ul>

    <div id="container" class="container">
        <table id="table1" border="1">
            <tr>
                <th>课程id</th>
                <th>课名</th>
                <th>课程简介</th>
                <th>教师</th>
                <th>小组情况</th>
            </tr>
        </table>
    </div>
    <!--<script type="text/javascript">
        var ul = document.getElementById("menu");
        var li = ul.getElementsByTagName("li")[0];
        selectedLi = li.getElementsByTagName("a")[0];
    </script>-->
</body>
</html>
