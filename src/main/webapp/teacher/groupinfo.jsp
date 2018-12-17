<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>小组列表</title>
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
      var groups;
      var courseId = window.sessionStorage.getItem("co_id");

      $(function () {
          // 加载小组名单
          let courseId = window.sessionStorage.getItem("co_id");
          console.log(courseId);
          let params = {
              "co_id": courseId
          };

          let url = "${ pageContext.request.contextPath }/teacher/teacher_getGroup.action";
          $.post(url, params, function (data) {
              groups = [];
              $.each(data, function (i, o) {
                  var group = {};
                  group.gr_id = o.gr_id;
                  group.gr_email = o.gr_email;
                  group.gr_qq = o.gr_qq;
                  group.gr_phone = o.gr_phone;
                  group.groupMembers = o.groupMembers;
                  for(let i = 0, j = 0; i < group.groupMembers.length; i++, j++){
                      if(group.groupMembers[i].student.id === group.gr_id){
                          group.gr_cheif = group.groupMembers[i].student.name;
                          j--;
                      } else{
                          let fieldName = "member" + j;
                          group.fieldName = group.groupMembers[i].student.name;
                      }
                  }
                  groups.push(group);
              });

              let count = data[0].course.co_gr_max - 1;
              console.log("count: " + count);
              var cols = [
                  {field: 'gr_id', title: '小组ID', sort: true, fixed: 'left'},
                  {field: 'gr_phone', title: '联系电话'},
                  {field: 'gr_qq', title: 'QQ'},
                  {field: 'gr_email', title: '邮箱'},
                  {field: 'leader', title: '组长'}
              ];
              for(let i = 0; i < count; i++){
                  cols.push({field: 'member' + i, title: '组员' + i})
              }

              layui.use(['table'], function (table) {
                  table.render({
                      elem: '#group',
                      height: 600,
                      data: group,
                      page: true,
                      cols: [cols]
                  });
              });

          }, "json");
      })
  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">学生管理</a>
        <a>
          <cite>查看小组</cite>
        </a>
      </span>
  <a id="refresh" class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i>
  </a>
</div>

<div class="x-body">
  <table id="group"></table>
  <%--<div id="page"  align="center"></div>--%>
</div>

</body>
</html>