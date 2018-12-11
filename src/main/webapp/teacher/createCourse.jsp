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
          layui.use(['laydate', 'form'], function (laydate, form) {
              laydate.render({
                  elem: '#date',
                  min: 0
              });

              form.verify({
                  ro_num: [/^(\d+){1,2}$/, '范围：0 ~ 99']
              });

              form.on('submit(add)', function(data){
                  console.log(data.field);
                  $.post("${pageContext.request.contextPath}/teacher_createCourse.action", data.field, function (data) {
                      if(data === "success"){
                          layer.alert("创建成功", {icon: 6}, function () {
                              window.parent.location.href = "/teacher/index.jsp";
                          });
                      }else{
                          layer.msg("创建失败", {icon: 5, time: 1000});
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
        <a>
          <cite>创建课程</cite></a>
      </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>

<div class="x-body">
  <fieldset class="layui-elem-field">
    <legend>创建课程</legend>
    <div class="layui-field-box">
      <div style="position: relative; left:30%;">
        <form class="layui-form layui-form-pane" action=""
              target="_self" method="post">
          <div class="layui-form-item">
            <label class="layui-form-label">课程名</label>
            <div class="layui-input-inline">
              <input type="text" name="co_name" lay-verify="required" placeholder="请输入课程名"
                     maxlength="20" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">开课时间</label>
            <div class="layui-input-inline">
              <input type="text" name="co_date" class="layui-input" id="date">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">课程描述</label>
            <div class="layui-input-inline">
              <textarea name="co_describe" required lay-verify="required" placeholder="请输入课程描述"
                        class="layui-textarea" maxlength="100" > </textarea>
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">点名次数</label>
            <div class="layui-input-inline">
              <input type="text" name="co_ro_num" lay-verify="ro_num" placeholder="请输入点名次数"
                     maxlength="2" autocomplete="off" class="layui-input">
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
