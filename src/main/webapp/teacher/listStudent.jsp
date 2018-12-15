<%@ page import="entity.User" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>学生列表</title>
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
      var users;
      var deleteNode;
      var checkboxNode;
      var courseId = window.sessionStorage.getItem("co_id");
      var delUrl = "${ pageContext.request.contextPath }/teacher_deleteStudent.action";

      function toPage(curPage, limit) {
          // 先清除数据，再添加
          $("#userTable").empty();

          let start = (curPage - 1) * limit;
          let end = start + limit;
          if (start >= users.length) {
              return;
          }
          if (end > users.length) {
              end = users.length;
          }
          for (let i = start; i < end; i++) {
              let tr = document.createElement("tr");
              tr.setAttribute("name", users[i].id)

              let checkbox = document.createElement("td");
              let checkboxIcon = checkboxNode.cloneNode(true);
              checkboxIcon.setAttribute("id", users[i].id);
              checkboxIcon.className += " layui-form-checkbox";
              // checkboxIcon.classList.add("layui-form-checkbox");;
              checkboxIcon.setAttribute("data-id", users[i].id);
              checkbox.appendChild(checkboxIcon);
              tr.appendChild(checkbox);

              let id = document.createElement("td");
              id.innerText = users[i].id;
              tr.appendChild(id);

              let name = document.createElement("td");
              name.innerText = users[i].name;
              tr.appendChild(name);

              let classNo = document.createElement("td");
              classNo.innerText = users[i].classNo;
              tr.appendChild(classNo);

              let manage = document.createElement("td");
              let deleteClone = deleteNode.cloneNode(true);
              deleteClone.setAttribute("onclick", "user_del(this,'" + users[i].id + "')")
              manage.appendChild(deleteClone);

              tr.appendChild(manage);

              document.getElementById("userTable").appendChild(tr);
          }
      }

      /* 删除单个学生 */
      function user_del(obj, id) {
          var ids = [];
          ids[0] = id;

          var params = {
              "ids": ids,
              "co_id": courseId
          };

          layer.confirm('确认要将该学生从该课程删除吗？', function (index) {
              // $.param(params, true)  序列化，发送一串字符串，而不是json对象
              $.post(delUrl, $.param(params, true), function (data) {
                  if(data === "success"){
                      $(obj).parents("tr").remove();
                      layer.msg('已删除!', {icon: 1, time: 1000});
                      document.getElementById("refresh").click();
                  }
                  else{
                      layer.msg('删除失败!', {icon: 5, time: 1000});
                  }
              })
          });
      }

      /*  删除选中的所有学生 */
      function delAll(argument) {
          var data = tableCheck.getData();
          var params = {
              "ids": data,
              "co_id": courseId
          };

          layer.confirm('确认要将选定的学生从该课程删除吗？', function (index) {
              // $.param(params, true)  序列化，发送一串字符串，而不是json对象
              $.post(delUrl, $.param(params, true), function (data) {
                  if(data === "success"){
                      $(".layui-form-checked").not('.header').parents('tr').remove();
                      layer.msg('已删除!', {icon: 1, time: 1000});
                      document.getElementById("refresh").click();
                      // $('#refresh').click();   // 使用jquery模拟点击，只会触发事件，不会跳转
                  }
                  else{
                      layer.msg('删除失败!', {icon: 5, time: 1000});
                  }
              })
          });
      }

      function clickCheckbox(node){
          if($(node).hasClass('layui-form-checked')){
              $(node).removeClass('layui-form-checked');
          }else{
              $(node).addClass('layui-form-checked');
          }
          return false;
      }


      $(function () {
          // 加载学生名单
          let courseId = window.sessionStorage.getItem("co_id");
          console.log(courseId);
          let params = {
              "co_id": courseId
          };
          let url = "${ pageContext.request.contextPath }/teacher/teacher_getStudent.action";
          $.post(url, params, function (data) {
              users = new Array();
              $.each(data, function (i, o) {
                  var user = {};
                  user.id = o.id;
                  user.name = o.name;
                  user.classNo = o.classNo;
                  users.push(user);
              });
              $("#count").text("共有数据：" + users.length + "条");

              layui.use(['laypage'], function (laypage) {
                  //分页
                  laypage.render({
                      elem: 'page' //分页容器的id
                      , count: users.length //总页数
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

          deleteNode = document.getElementById("delete");
          checkboxNode = document.getElementById("checkbox");

      })
  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">学生管理</a>
        <a>
          <cite>查看学生</cite>
        </a>
      </span>
  <a id="refresh" class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i>
  </a>
</div>

<div class="x-body">
  <xblock>
    <button class="layui-btn layui-btn-danger" onclick="delAll()">
      <i class="layui-icon"></i>批量删除
    </button>
    <span id="count" class="x-right" style="line-height:40px"></span>
  </xblock>

  <table class="layui-table">
    <thead>
      <tr>
        <th>
          <div class="layui-unselect header layui-form-checkbox" lay-skin="primary">
            <i class="layui-icon">&#xe605;</i>
          </div>
        </th>
        <th>ID</th>
        <th>姓名</th>
        <th>班级</th>
        <th>操作</th>
      </tr>
    </thead>

    <tbody id="userTable"></tbody>
  </table>
  <div id="page"  align="center"></div>
</div>


<div id="nodes" style="display: none;">
  <div id="checkbox" class="layui-unselect" onclick="clickCheckbox(this)" lay-skin="primary" data-id='2'>
    <i class="layui-icon">&#xe605;</i>
  </div>

  <a id="delete" title="删除" href="javascript:;">
    <i class="layui-icon">&#xe640;</i>
  </a>
</div>

</body>
</html>