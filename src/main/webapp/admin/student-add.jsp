<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
      $(function () {
          $('#pseudo_upload').click(function () {
              $('#upload').click();
          });

          $('#upload').on('change', function (e) {
              var name = e.currentTarget.files[0].name;
              $('#fileName').text(name);
          });
      })

  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">添加用户</a>
        <a>
          <cite>添加学生</cite></a>
      </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>

<div class="x-body">
  <fieldset class="layui-elem-field">
    <legend>上传文件</legend>
    <div class="layui-field-box">
      <form action="${pageContext.request.contextPath}/admin_addByExcel.action" target="_parent" method="post"
            enctype="multipart/form-data">
        <table class="layui-table" lay-skin="line">
          <tbody>
          <tr>
            <td>
              <a class="x-a" href="/" target="_blank">
                excel文件格式：每位学生一行，必须有姓名、班级，可以没有密码（则默认与生成的学号相同）
              </a>
            </td>
            <td>
              <button class="layui-btn" type="button" id="pseudo_upload">
                <i class="layui-icon">&#xe67c;</i>上传文件
              </button>
              <div hidden>
                <input class="layui-btn" name="upload" id="upload" type="file">
              </div>
            </td>
            <td>
              <span id="fileName"></span>
            </td>
            <td>
              <%--<button class="layui-btn" lay-submit >提交</button>--%>
              <input type="submit" class="layui-btn layui-btn-normal"/>
            </td>
          </tr>
          <tr hidden>
            <th>
              <p name="role">student</p>
            </th>
          </tr>
          </tbody>
        </table>
      </form>
    </div>
  </fieldset>

  <fieldset class="layui-elem-field">
    <legend>手动添加</legend>
    <div class="layui-field-box">
      <div style="position: relative; left:30%;">
        <form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/admin_add.action"
              target="_parent" method="post">

          <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-inline">
              <input type="text" name="name" lay-verify="required" placeholder="请输入姓名"
                     maxlength="20" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
              <input type="password" name="password" placeholder="请输入密码"
                     maxlength="30" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">班级</label>
            <div class="layui-input-inline">
              <input type="text" name="class" lay-verify="required|number" placeholder="请输入班级"
                     maxlength="10" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <div class="layui-input-block">
              <button class="layui-btn" lay-submit>立即提交</button>
              <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
          </div>

          <div class="layui-form-item" hidden>
            <p name="role">student</p>
          </div>

        </form>
      </div>
    </div>
  </fieldset>
</div>

</body>
</html>
