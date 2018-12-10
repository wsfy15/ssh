<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>登录-学生作业系统</title>
  <meta name="renderer" content="webkit|ie-comp|ie-stand">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport"
        content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
  <meta http-equiv="Cache-Control" content="no-siteapp"/>

  <link rel="stylesheet" href="./css/font.css">
  <link rel="stylesheet" href="./css/xadmin.css">
  <script type="text/javascript" src="./lib/jquery-3.3.1.min.js"></script>
  <script src="./lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="./lib/xadmin.js"></script>
  <script type="text/javascript" src="./js/md5.js"></script>
  <script>
      $(function () {
          let id = '${user.id}';
          if (id.trim().length == 10) {
              let password = '${user.password}';
              if (hex_md5(id) == password) {
                  window.sessionStorage.setItem("fromIndex", '1');
                  window.location.href = "/modifyPassword.jsp";
              } else if (id.indexOf("1000") === 0) {
                  window.location.href = "/admin/index.jsp";
              } else if (id.indexOf("1010") === 0) {
                  window.location.href = "/teacher/index.jsp";
              } else {
                  window.location.href = "/student/index.jsp";
              }
          }
      })

      var url = '${pageContext.request.contextPath}/user_login.action';

      function login() {
          if ($("input[name='password']").val() == '' || $("input[name='id']").val() == '') {
              alert("用户名或密码不能为空");
              return false;
          }
          // console.log(hex_md5($("[name=password]").val()));
          // set password
          // $("[name=password]").val(hex_md5($("[name=password]").val()));
          var id = $("input[name='id']").val();
          var password = $("input[name='password']").val();
          var params = {
              "id": id,
              "password": password
          };

          $.post(url, params, function (data) {
              if (data === "success") {
                  if (id.indexOf("1000") === 0) {
                      window.location.href = "/admin/index.jsp";
                  } else if (id.indexOf("1010") === 0) {
                      window.location.href = "/teacher/index.jsp";
                  } else {
                      window.location.href = "/student/index.jsp";
                  }
              } else if (data === "firstLogin") {
                  window.sessionStorage.setItem("fromIndex", '1');
                  window.location.href = "/modifyPassword.jsp";
              } else {
                  layer.msg('ID或密码错误', {icon: 5, time: 1000});
              }
          });
          return false;
      }
  </script>

</head>
<body class="login-bg">
<div class="login layui-anim layui-anim-up">
  <div class="message">学生作业系统-登录</div>
  <div id="darkbannerwrap"></div>

  <form class="layui-form" action="" onsubmit="return login()" method="post">
    <input name="id" placeholder="用户名" type="text" lay-verify="required" class="layui-input">
    <hr class="hr15">
    <input name="password" placeholder="密码" type="password" lay-verify="required" class="layui-input">
    <hr class="hr15">
    <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
    <hr class="hr20">
    <button type="reset" style="width:100%;" class="layui-btn layui-btn-primary">重置</button>
    <hr class="hr20">
  </form>
</div>
</body>
</html>