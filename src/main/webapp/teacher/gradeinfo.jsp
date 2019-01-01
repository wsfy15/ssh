<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>成绩信息</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport"
        content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>

  <link rel="stylesheet" href="../css/font.css">
  <link rel="stylesheet" href="../css/xadmin.css">
  <script type="text/javascript" src="../lib/jquery-3.3.1.min.js"></script>
  <script src="../lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="../lib/xadmin.js"></script>
  <script type="text/javascript" src="../js/utils.js"></script>

  <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->

  <script>
      var grades;
      var courseId = window.sessionStorage.getItem("co_id");
      var params = {
          "co_id": courseId
      };

      function updateGrade(){
          $.post("${ pageContext.request.contextPath }/teacher_updateGrade.action", params, function (data) {
              if(data === "success"){
                  self.location.reload();
              } else if(data === "notfound") {
                  layui.use('layer', function (layer) {
                      layer.msg("查无此课", {icon: 5, time: 1000});
                  })
              } else if(data === "checkrollcall") {
                  layui.use('layer', function (layer) {
                      layer.msg("点名次数未满", {icon: 5, time: 1000});
                  })
              }
          })
      }

      $(function () {
          // 加载成績信息
          let url = "${ pageContext.request.contextPath }/teacher_getGrade.action";
          $.post(url, params, function (data) {
              grades = [];
              console.log(data);

              // 存储每个学生的成绩数据
              $.each(data, function (i, o) {
                  var grade = {};
                  grade.id = o.student_id;
                  grade.name = o.student_name;
                  grade.classNo = o.student_class;
                  grade.final_grade = o.final_grade;


                  for(let i = 0; i < o.rollcall.length; i++){
                      let index = "rollcall_" + o.rollcall[i];
                      console.log(index);
                      grade[index] = "未到";
                  }

                  for(var key in o.homework){
                      grade[key] = o.homework[key];
                  }

                  grades.push(grade);
              });
              console.log(grades);

              // 表头
              let rollcallCount = 0;
              let assignments = null;
              $.post("${ pageContext.request.contextPath }/teacher/teacher_getCourseDetail.action", params, function (data) {
                  console.log(data);
                  rollcallCount = data.co_ro_num; // 总点名次数
                  assignments = data.assignments; // 作业次数

                  let secondRow = [];
                  for(let i = 1; i <= rollcallCount; i++){
                      secondRow.push({field: 'rollcall_' + i, title: '点名' + i});
                  }
                  for(let i = 1; i <= assignments.length; i++){
                      secondRow.push({field: assignments[i-1].as_name, title: assignments[i-1].as_name});
                  }
                  var cols = [
                      [
                          {field: 'id', title: '学号', sort: true, fixed: 'left', rowspan : 2},
                          {field: 'classNo', title: '班级', rowspan : 2},
                          {field: 'name', title: '姓名', rowspan : 2},
                          {align: 'center', title: '点名(' + data.co_peacetimeProportion + '%)', colspan : rollcallCount},
                          {align: 'center', title: '作业('+ (100 - data.co_peacetimeProportion) + '%)', colspan : assignments.length},
                          {field: 'final_grade', title: '总成绩', rowspan : 2}
                      ], secondRow
                  ];

                  // 渲染table
                  layui.use(['table'], function (table) {
                      table.render({
                          elem: '#group',
                          height: 600,
                          data: grades,
                          page: true,
                          cols: cols
                      });
                  });
              }, "json");

          }, "json");
      })
  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="javascript:void(0);">首页</a>
        <a href="javascript:void(0);">作业管理</a>
        <a>
          <cite>查看成绩</cite>
        </a>
      </span>
  <a id="refresh" class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i>
  </a>
</div>

<div class="x-body">
  <button class="layui-btn"  onclick="updateGrade()" lay-filter="filter">更新成绩</button>
  <table id="group"></table>
  <%--<div id="page"  align="center"></div>--%>
</div>

</body>
</html>