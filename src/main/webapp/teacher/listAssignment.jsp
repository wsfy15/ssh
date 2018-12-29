<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>作业列表</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport"
        content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>

  <link rel="stylesheet" href="../css/font.css">
  <link rel="stylesheet" href="../css/xadmin.css">
  <script type="text/javascript" src="../lib/jquery-3.3.1.min.js"></script>
  <script src="../lib/layui/layui.js" charset="utf-8"></script>
  <script charset="utf-8" src="../js/utils.js"></script>
  <script charset="utf-8" src="../lib/xadmin.js"></script>

  <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->

  <script>
      var assignments;
      var courseId = window.sessionStorage.getItem("co_id");
      var modifyNode;
      var modifyUrl = "${ pageContext.request.contextPath }/teacher/modifyAssignment.jsp";

      function modify(id) {
          window.localStorage.setItem("id", id);
          assignments.forEach(function (e) {
              if(e.as_id === id){
                  window.localStorage.setItem("describe", e.as_describe);
              }
          });

          layer.open({
              type: 2,
              area: ['650px', '500px'],
              fix: false, //不固定
              maxmin: true,
              shadeClose: true,
              shade: 0.4,
              title: "修改作业",
              content: modifyUrl
          });
      }

      function toPage(curPage, limit) {
          // 先清除数据，再添加
          $("#assignmentTable").empty();

          let start = (curPage - 1) * limit;
          let end = start + limit;
          if (start >= assignments.length) {
              return;
          }
          if (end > assignments.length) {
              end = assignments.length;
          }
          for (let i = start; i < end; i++) {
              let tr = document.createElement("tr");

              let name = document.createElement("td");
              name.innerText = assignments[i].as_name;
              tr.appendChild(name);

              let describe = document.createElement("td");
              describe.innerText = assignments[i].as_describe;
              tr.appendChild(describe);

              let ddl = document.createElement("td");
              ddl.innerText = assignments[i].as_ddl;
              tr.appendChild(ddl);

              let assignTime = document.createElement("td");
              assignTime.innerText = assignments[i].as_assigntime;
              tr.appendChild(assignTime);

              let weight = document.createElement("td");
              weight.innerText = assignments[i].as_weight;
              tr.appendChild(weight);

              let manage = document.createElement("td");
              let modifyClone = modifyNode.cloneNode(true);
              modifyClone.setAttribute("onclick", "modify('" + assignments[i].as_id + "')");
              manage.appendChild(modifyClone);
              tr.appendChild(manage);

              document.getElementById("assignmentTable").appendChild(tr);
          }
      }

      $(function () {
          let params = {
              "co_id": courseId
          };
          let url = "${ pageContext.request.contextPath }/teacher/teacher_getAssignment.action";
          $.post(url, params, function (data) {
              console.log(data);
              assignments = [];
              $.each(data, function (i, o) {
                  var assignment = {};
                  assignment.as_id = o.as_id;
                  assignment.as_name = o.as_name;
                  assignment.as_describe = o.as_describe;
                  assignment.as_assigntime = formatDateYMDhms(new Date(o.as_assigntime));
                  assignment.as_ddl = formatDateYMDhms(new Date(o.as_ddl));
                  assignment.as_weight = o.as_weight;
                  assignments.push(assignment);
              });
              $("#count").text("共有数据：" + assignments.length + "条");

              layui.use(['laypage'], function (laypage) {
                  //分页
                  laypage.render({
                      elem: 'page' //分页容器的id
                      , count: assignments.length //总页数
                      , limit: 10
                      // , limits: [5, 10, 15]
                      , skin: '#1E9FFF' //自定义选中色值
                      , skip: true //开启跳页
                      , jump: function (obj, first) {
                          // if (!first) {
                          toPage(obj.curr, obj.limit);
                          // }
                      }
                  });
              });
          }, "json");

          modifyNode = document.getElementById("modify");
      })
  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="javascript:void(0);">首页</a>
        <a href="javascript:void(0);">作业管理</a>
        <a>
          <cite>查看作业</cite>
        </a>
      </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
  <table class="layui-table">
    <thead>
    <tr>
      <th>名称</th>
      <th>基本描述</th>
      <th>提交时间</th>
      <th>发布时间</th>
      <th>权重</th>
      <th>操作</th>
    </thead>
    <tbody id="assignmentTable"></tbody>
  </table>
  <div id="page" align="center"></div>
</div>

<div id="nodes" style="display: none;">
  <a id="modify" title="修改" href="javascript:;">
    <i class="layui-icon">&#xe642;</i>
  </a>
</div>

</body>
</html>