<%@ page import="entity.User" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <base href="${pageContext.request.contextPath}/admin/">
  <meta charset="UTF-8">
  <title>学生作业系统</title>
  <meta name="renderer" content="webkit|ie-comp|ie-stand">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport"
        content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
  <meta http-equiv="Cache-Control" content="no-siteapp"/>

  <link rel="stylesheet" href="../css/font.css">
  <link rel="stylesheet" href="../css/xadmin.css">
  <script type="text/javascript" src="../lib/jquery-3.3.1.min.js"></script>
  <script src="../lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="../lib/xadmin.js"></script>
  <script>
      var users;

      /**
       *
       * @param curPage 当前第几页
       * @param limit 每页最多多少条数据
       */
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
              let id = document.createElement("td");
              id.innerText = users[i].id;
              tr.appendChild(id);

              let name = document.createElement("td");
              name.innerText = users[i].name;
              tr.appendChild(name);

              document.getElementById("userTable").appendChild(tr);
          }

      }

      $(function () {
          users = new Array();
          var list = $('#jsonArraySpan').text();
          var json = JSON.parse(list);
          $.each(json, function (i, o) {
              var user = {};
              user.id = o.id;
              user.name = o.name;
              users.push(user);
          });

          layui.use(['laypage'], function (laypage) {
              //分页
              laypage.render({
                  elem: 'pageDemo' //分页容器的id
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
      })
  </script>
</head>

<body>
<div class="x-body">
  <fieldset class="layui-elem-field">
    <legend>添加成功的名单</legend>
    <div class="layui-text" align="center">
      不符合规范的数据不会被被添加
    </div>
    <div class="layui-field-box" align="center">
      <table class="layui-table">
        <colgroup>
          <col width="150">
          <col width="200">
          <col>
        </colgroup>
        <thead>
        <tr>
          <th>ID</th>
          <th>姓名</th>
        </tr>
        </thead>
        <tbody id="userTable"></tbody>
      </table>
      <div id="pageDemo"></div>
      <input type="button" class="layui-btn" name="Submit" onclick="self.location=document.referrer;" value="返回上一页">
    </div>
  </fieldset>

  <span id="jsonArraySpan" style="display: none;">${newUser}</span>
</div>
</body>
</html>
