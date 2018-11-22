<%@ page language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <style type="text/css">
        a {
            text-decoration: none;
            display: block;
            line-height: 30px;
            padding-left: 20px;
            color: #fff;
        }
        ul {
            width: 30%;
            min-width: 150px;
            max-width: 240px;
            height: 600px;
            display: block;
            padding-top: 30px;
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
            float: left;
            width: 70%;
            height: 600px;
            padding-top: 30px;
            background: #ccc;
        }

        .iframe {
            width: 100%;
            height:100%;
            border-style: none;

        }

    </style>
    <script type="text/javascript">
        var selectedLi;
        function change(page) {
            if (selectedLi == null) {
                selectedLi = page;
                selectedLi.className = null;
            } else {
                selectedLi.className = null;
                selectedLi = page;
            }
            document.getElementById('content').src = page.rel;
        }

    </script>
</head>
<body>

    <ul id="menu">
        <li>
            <a onclick="change(this)" href="javascript:" rel="${ pageContext.request.contextPath }/teacher/setCourse.jsp" class="li">设置课程</a>
        </li>
        <li>
            <a onclick="change(this)" href="javascript:" rel="${ pageContext.request.contextPath }/teacher/setStudent.html">添加学生名单</a>
        </li>
        <li>
            <a onclick="change(this)" href="javascript:" rel="${ pageContext.request.contextPath }/teacher/3.html">placeholder</a>
        </li>
    </ul>

    <div id="container" class="container">
        <iframe id="content" class="iframe" src="${ pageContext.request.contextPath }/teacher/setCourse.jsp"></iframe>
    </div>
    <!--<script type="text/javascript">
        var ul = document.getElementById("menu");
        var li = ul.getElementsByTagName("li")[0];
        selectedLi = li.getElementsByTagName("a")[0];
    </script>-->
</body>
</html>