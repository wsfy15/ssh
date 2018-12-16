<%@ page import="entity.User" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>修改信息</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />

  <link rel="stylesheet" href="../css/font.css">
  <link rel="stylesheet" href="../css/xadmin.css">
  <script type="text/javascript" src="../lib/jquery-3.3.1.min.js"></script>
  <script src="../lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="../lib/xadmin.js"></script>
  <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->

  <script>
    var url = "${ pageContext.request.contextPath }/teacher_modifyAssignment.action";
      $(function () {
          var as_id = window.localStorage.getItem("id");
          var describe = window.localStorage.getItem("describe");
          $("#describe").val(describe);
          $("#as_id").val(as_id);

          layui.use(['laydate', 'form', 'layer'], function (laydate, form, layer) {
              laydate.render({
                  elem: '#date',
                  min: 0,
                  type: 'datetime'
              });

              form.verify({
                  num: [/^\d*$/,  '输入只能是正数']
              });

              form.on('submit(modify)', function (data) {
                  $.post(url, data.field, function (data) {
                      if(data === "success"){
                          layer.alert("修改成功", {icon: 6},function () {
                              // 获得frame索引
                              var index = parent.layer.getFrameIndex(window.name);
                              //关闭当前frame
                              self.parent.location.reload();
                              parent.layer.close(index);
                          });
                      } else{
                          layer.alert("修改失败", {icon: 5});
                      }
                  });
                  return false;
              });
          });
      })
  </script>
</head>

<body>
<div class="x-body" >
  <form class="layui-form" style="left:15%;position: relative;">
    <div style="display: none;">
      <input id="as_id" name="as_id">
    </div>

    <div class="layui-form-item">
      <label for="name" class="layui-form-label">提交时间</label>
      <div class="layui-input-inline">
        <input type="text" name="ddl" class="layui-input" id="date" autocomplete="off">
      </div>
    </div>

    <div class="layui-form-item">
      <label for="id" class="layui-form-label">权重</label>
      <div class="layui-input-inline">
        <input type="text" id="weight" name="weight" class="layui-input" lay-verify="num">
      </div>
    </div>

    <div class="layui-form-item" id="classDiv">
      <label for="class" class="layui-form-label">基本描述</label>
      <div class="layui-input-inline">
        <textarea id="describe" name="as_describe"  class="layui-textarea" maxlength="100" > </textarea>
      </div>
    </div>

    <div class="layui-form-item">
      <label for="describe" class="layui-form-label"></label>
      <button class="layui-btn" lay-filter="modify" lay-submit>修改</button>
    </div>
  </form>
</div>

</body>
</html>