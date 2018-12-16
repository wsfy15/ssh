<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <base href="${pageContext.request.contextPath}/teacher/">
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
          var co_id = window.sessionStorage.getItem("co_id");
          $("#co_id").val(co_id);

          layui.use(['laydate', 'form'], function (laydate, form) {
              laydate.render({
                  elem: '#date',
                  min: 0,
                  type: 'datetime'
              });

              form.verify({
                  num: [/^\d+$/,  '输入只能是正数'],
              });

              form.on('submit(add)', function(data){
                  console.log(data.field);
                  // let str = data.field.as_ddl;
                  // str = str.replace(/-/g, "/");
                  // let date = new Date(str);
                  // data.field.as_ddl = Date.parse(date);
                  $.post("${pageContext.request.contextPath}/teacher_createAssignment.action", data.field, function (data) {
                      if(data === "success"){
                          layer.alert("设置成功", {icon: 6});
                      // , function () {window.parent.location.href = "/teacher/index.jsp";}
                      }else{
                          layer.msg("设置失败", {icon: 5, time: 1000});
                      }
                  })
                  return false;
              });
          });
      })

  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">作业管理</a>
        <a>
          <cite>设置作业</cite>
        </a>
      </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>

<div class="x-body">
  <fieldset class="layui-elem-field">
    <legend>设置作业</legend>
    <div class="layui-field-box">
      <div style="position: relative; left:30%;">
        <form class="layui-form layui-form-pane" action=""
              target="_self" method="post">

          <div hidden>
            <input type="text" name="co_id" class="layui-input" id="co_id" autocomplete="off">
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">作业名称</label>
            <div class="layui-input-inline">
              <input type="text" name="as_name" lay-verify="required" maxlength="20" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">基本描述</label>
            <div class="layui-input-inline">
              <textarea name="as_describe" required lay-verify="required" class="layui-textarea" maxlength="100" > </textarea>
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">提交时间</label>
            <div class="layui-input-inline">
              <input type="text" name="ddl" class="layui-input" id="date" autocomplete="off">
            </div>
          </div>

          <div class="layui-form-item">
            <label for="co_gr_prefix" class="layui-form-label">作业权重</label>
            <div class="layui-input-inline">
              <input type="text" id="co_gr_prefix" name="as_weight" lay-verify="num"
                     autocomplete="off" class="layui-input" maxlength="2">
            </div>
          </div>

          <div class="layui-form-item">
            <div class="layui-input-block">
              <button class="layui-btn" lay-submit lay-filter="add">立即提交</button>
              <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
          </div>

        </form>
      </div>
    </div>
  </fieldset>
</div>

</body>
</html>
