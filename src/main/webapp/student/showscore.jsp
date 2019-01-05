<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>课程信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <script type="text/javascript" src="../lib/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../lib/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">课程管理</a>
        <a>
          <cite>课程信息</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<table id="demo" lay-filter="test"></table>
<script>
    layui.use('table', function(){
        var table = layui.table;
        userId = window.sessionStorage.getItem("usid");
        data1 = {"userId": userId};
        //第一个实例
        $(function () {
            let url = "${ pageContext.request.contextPath }/student/student_getScoure.action";
            $.post(url, data1, function (data) {
                var grades = [];
                $.each(data, function (i, o) {
                    var grade1 = {};
                    grade1.courseId = o.course_id;
                    grade1.courseScore=o.final_grade;
                    grades.push(grade1);
                });

                let count = data.size - 1;
                console.log("count: " + count);
                var cols = [ //表头
                    {field: 'courseId', title: 'courseId', width:80, sort: true, fixed: 'left'}
                    ,{field: 'courseScore', title: '课程得分', width:80}
                ];
                layui.use(['table'], function (table) {
                    table.render({
                        elem: '#demo',
                        title:"成绩",
                        height: 200,
                        data: grades,
                        page: true,
                        cols: [cols]
                    });
                });
            }, "json");
        })
    });
</script>

</body>
</html>