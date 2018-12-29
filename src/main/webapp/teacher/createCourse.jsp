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
          $(".layui-form-label").css("width", "150px");

          layui.use(['laydate', 'form'], function (laydate, form) {
              laydate.render({
                  elem: '#date',
                  min: 0
              });

              form.verify({
                  ro_num: [/^(\d+){1,2}$/, '范围：0 ~ 99'],
                  num: [/^\d+$/,  '输入只能是正数'],
                  groupConf: function (value) {
                      let max = $('[name=co_gr_max]').val();
                      let min = $('[name=co_gr_min]').val();
                      console.log(parseInt(max));
                      console.log(parseInt(min));
                      if(parseInt(max) < parseInt(min)){
                          return '最大人数 不能小于 最小人数';
                      }
                  },
                  groupPrefix: [/^\d{7}$/,  '输入必须是7位数字'],
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
        <a href="javascript:void(0);">首页</a>
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
              <input type="text" name="co_name" lay-verify="required" maxlength="20" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">开课时间</label>
            <div class="layui-input-inline">
              <input type="text" name="co_date" class="layui-input" id="date" autocomplete="off">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">课程描述</label>
            <div class="layui-input-inline">
              <textarea name="co_describe" required lay-verify="required" class="layui-textarea" maxlength="100" > </textarea>
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">点名次数</label>
            <div class="layui-input-inline">
              <input type="text" name="co_ro_num" lay-verify="ro_num" maxlength="2" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <label class="layui-form-label">平时作业所占比例</label>
            <div class="layui-input-inline">
              <input type="text" name="co_peacetimeProportion" lay-verify="num" maxlength="2" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">%</div>
          </div>

          <div class="layui-form-item">
            <label for="co_gr_min" class="layui-form-label">小组最少人数</label>
            <div class="layui-input-inline">
              <input type="text" id="co_gr_min" name="co_gr_min" lay-verify="num|groupConf" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item">
            <label for="co_gr_max" class="layui-form-label">小组最大人数</label>
            <div class="layui-input-inline">
              <input type="text" id="co_gr_max" name="co_gr_max" lay-verify="num|groupConf" autocomplete="off" class="layui-input">
            </div>
          </div>


          <div class="layui-form-item">
            <label for="co_gr_prefix" class="layui-form-label">小组编号前缀</label>
            <div class="layui-input-inline">
              <input type="text" id="co_gr_prefix" name="co_gr_prefix" lay-verify="groupPrefix"
                     autocomplete="off" class="layui-input" maxlength="7">
            </div>
            <div class="layui-form-mid layui-word-aux">
              <span class="x-red">*</span>小组编号共10位，请输入该课程小组的7位前缀
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
