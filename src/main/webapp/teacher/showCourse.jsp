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
  <script charset="utf-8" src="../js/utils.js"></script>
  <script charset="utf-8" src="../lib/xadmin.js"></script>

  <script>
      $(function () {
          let courseId = window.sessionStorage.getItem("co_id");
          let params = {
              "co_id": courseId
          };
          let url = "${ pageContext.request.contextPath }/teacher/teacher_getCourseDetail.action";
          $.post(url, params, function (data) {
              console.log(data);
              let date = formatDateYMD(new Date(data.co_date));

              $('[name=co_name]').val(data.co_name);
              $('[name=co_describe]').val(data.co_describe);
              $('[name=co_date]').val(date);
              $('[name=co_ro_num]').val(data.co_ro_num);
              $('[name=co_gr_max]').val(data.co_gr_max);
              $('[name=co_gr_min]').val(data.co_gr_min);
              $('[name=co_gr_prefix]').val(data.co_gr_prefix);
          }, "json");
      });

  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a>
          <cite>课程信息</cite></a>
      </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>

<div class="x-body">
  <fieldset class="layui-elem-field">
    <legend>课程信息</legend>
    <div class="layui-field-box">
      <div style="position: relative; left:30%;">
        <form class="layui-form layui-form-pane" action="" target="_self" method="post">
          <div class="layui-form-item">
            <label class="layui-form-label">课程名</label>
            <div class="layui-input-inline">
              <input type="text" name="co_name"   disabled class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">开课时间</label>
            <div class="layui-input-inline">
              <input type="text" name="co_date"  class="layui-input" disabled>
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">课程描述</label>
            <div class="layui-input-inline">
              <input type="text" name="co_describe"   class="layui-input" disabled>
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">点名次数</label>
            <div class="layui-input-inline">
              <input type="text" name="co_ro_num" class="layui-input" disabled>
            </div>
          </div>

        </form>
      </div>
    </div>
  </fieldset>

  <fieldset class="layui-elem-field">
    <legend>小组配置</legend>
    <div class="layui-field-box">
      <div style="position: relative; left:30%;">
        <form class="layui-form layui-form-pane" action="" target="_self" method="post">
          <div class="layui-form-item">
            <label class="layui-form-label">最少人数</label>
            <div class="layui-input-inline">
              <input type="text" name="co_gr_min" class="layui-input" disabled>
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">最大人数</label>
            <div class="layui-input-inline">
              <input type="text" name="co_gr_max" class="layui-input" disabled>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">编号前缀</label>
            <div class="layui-input-inline">
              <input type="text" name="co_gr_prefix" class="layui-input" disabled>
            </div>
          </div>

        </form>
      </div>
    </div>
  </fieldset>
</div>

</body>
</html>
