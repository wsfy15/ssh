<%--
  Created by IntelliJ IDEA.
  User: CLNSX
  Date: 2018-12-20
  Time: 10:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>作业提交</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/xadmin.css">
    <script type="text/javascript" src="../lib/jquery-3.3.1.min.js"></script>
    <script src="../lib1/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../lib/xadmin.js"></script>
    <script>
        var assignID;
        function stampToTime(timestamp) {
            if(timestamp == 0) {
                return "";
            }else{
                var date = new Date(timestamp );//时间戳为10位需*1000，时间戳为13位的话不需乘1000
                var Y = date.getFullYear();
                var M = date.getMonth()+ 1;
                var D = date.getDate();
                var h = date.getHours();
                var m = date.getMinutes();
                var s = date.getSeconds();
                var datestring = Y + "-";
                if (M < 10) datestring += "0";
                datestring += M + "-";
                if (D < 10) datestring += "0";
                datestring += D + " ";
                if (h < 10) datestring += "0";
                datestring += h + ":";
                if (m < 10) datestring += "0";
                datestring += m + ":";
                if (s < 10) datestring += "0";
                datestring += s;
                return datestring;
            }
        }
        var params1;
        $(function () {
            let courseId = window.sessionStorage.getItem("courseid");
            let username=window.sessionStorage.getItem("usname");
            let userid=window.sessionStorage.getItem("usid");
            console.log(courseId+" "+username+" "+userid);
            params1={"co_id":courseId,"us_id":userid};
            let params = {
                "co_id": courseId
            };
            let url = "${ pageContext.request.contextPath }/student/student_getAssign.action";
            $.post(url, params, function (data) {
                var assigns = [];
                $.each(data, function (i, o) {
                    var assign = {};
                    assign.as_id = o.as_id;
                    assign.as_name = o.as_name;
                    assign.as_weight = o.as_weight;
                    assign.as_describe = o.as_describe;
                    assign.as_assigntime =stampToTime(o.as_assigntime);
                    assign.as_ddl = stampToTime(o.as_ddl);
                    assigns.push(assign);
                });

                let count = data.size - 1;
                console.log("count: " + count);
                var cols = [
                    ,{field: 'as_id', title: 'ID', width:80}
                    ,{field: 'as_name', title: '作业名', width:80}
                    ,{field: 'as_weight', title: '权重', width: 80 }
                    ,{field: 'as_describe', title: '描述', width:80}
                    ,{field: 'as_assigntime', title: '布置时间', width: 80}
                    ,{field: 'as_ddl', title: 'deadline', width: 177}
                ];

                layui.use(['table'], function (table) {
                    table.render({
                        elem: '#group',
                        height: 200,
                        data: assigns,
                        page: true,
                        cols: [cols]
                    });
                });
            }, "json");
        })
        $(function () {
            let url = "${ pageContext.request.contextPath }/student/student_getHomework1.action";
            $.post(url, params1, function (data) {
                var homeworks = [];
                $.each(data, function (i, o) {
                    var homework = {};
                    homework.id = o.id;
                    homework.ho_time = stampToTime(o.ho_time);
                    homework.ho_name = o.ho_name;
                    homeworks.push(homework);
                });

                let count = data.size - 1;
                console.log("count: " + count);
                var cols = [
                    ,{field: 'id', title: 'ID', width:'auto'}
                    ,{field: 'ho_name', title: '作业名称', width: 'auto' }
                    ,{field: 'ho_time', title: '提交时间', width:'auto'}
                ];
                layui.use(['table'], function (table) {
                    table.render({
                        elem: '#homework',
                        title:"已交作业",
                        height: 200,
                        data: homeworks,
                        page: true,
                        cols: [cols]
                    });
                });
            }, "json");
        })
    </script>
</head>
<body>
<div>
    <table id="group" lay-filter="test"></table>

    <table id="homework" lay-filter="test"></table>
</div>
<button type="button" class="layui-btn" id="test1"name="uploadfile2">
    <i class="layui-icon">&#xe67c;</i>选择文件
</button>
<button type="button" class="layui-btn" id="testListAction" name="uploadfile" onclick="return confirm('确定上传吗？')">

    <i class="layui-icon">&#xe67c;</i>上传文件
</button>

<script>
    layui.use(['upload','table'], function(){
        var upload = layui.upload;
        var table=layui.table;

        //执行实例
        upload.render({
            elem: '#test1'
            ,url: '${pageContext.request.contextPath}/student/student_uploadFile.action'
            ,data:params1
            ,auto: false //选择文件后不自动上传
            ,bindAction: '#testListAction' //指向一个按钮触发上传
            ,accept:'file'
            ,choose: function(obj){
                //将每次选择的文件追加到文件队列
                var files = obj.pushFile();

            }
            ,field:"uploadFile"
            ,done:function(res){
                alert("上传成功");
                window.location.reload();
            }


        });
// 选中情况
        table.on('radio(test)', function(obj){
            console.log(obj.checked); //当前是否选中状态
            console.log(obj.data); //选中行的相关数据
            assignID=obj.data.as_id;
        });
    });


</script>
</body>
</html>
