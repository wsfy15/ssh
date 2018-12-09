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
    $(function () {
        var id = window.localStorage.getItem("id");
        $("#id").val(id);

        var name = window.localStorage.getItem("name");
        $("#name").val(name);

        if(id.indexOf("1000") === -1 && id.indexOf("1010") === -1){
            var classNo = window.localStorage.getItem("class");
            $("#class").val(classNo);
        }else{
            $("#classDiv").hide();
        }



    })
  </script>
</head>

<body>
<div class="x-body" >
  <form class="layui-form" style="left:30%;position: relative;">
    <div class="layui-form-item">
      <label for="id" class="layui-form-label">
        <span class="x-red">*</span>ID
      </label>
      <div class="layui-input-inline">
        <input type="text" id="id" name="id" disabled class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label for="name" class="layui-form-label">
        <span class="x-red">*</span>姓名
      </label>
      <div class="layui-input-inline">
        <input type="text" id="name" name="name" required lay-verify="required"
               autocomplete="off" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item" id="classDiv">
      <label for="class" class="layui-form-label">
        <span class="x-red">*</span>班级
      </label>
      <div class="layui-input-inline">
        <input type="text" id="class" name="class" required autocomplete="off" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label for="L_pass" class="layui-form-label">新密码</label>
      <div class="layui-input-inline">
        <input type="password" id="L_pass" name="password" lay-verify="pass"
               autocomplete="off" class="layui-input">
      </div>
      <div class="layui-form-mid layui-word-aux">
        可以不填写此项，则保持原密码
      </div>
    </div>
    <div class="layui-form-item">
      <label for="L_repass" class="layui-form-label">确认密码</label>
      <div class="layui-input-inline">
        <input type="password" id="L_repass" name="repass" lay-verify="repass"
               autocomplete="off" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label for="L_repass" class="layui-form-label"></label>
      <button class="layui-btn" lay-filter="add" lay-submit>修改</button>
    </div>
  </form>
</div>

<script>
    layui.use(['form','layer'], function(){
        $ = layui.jquery;
        var form = layui.form,layer = layui.layer;

        //自定义验证规则
        form.verify({
            pass: function(value){
              if($('#L_pass').val() === $("#id").val()){
                  return '密码不能设置为默认密码';
              }
            },
            repass: function(value){
                if($('#L_pass').val()!=$('#L_repass').val()){
                    return '两次密码不一致';
                }
            }
        });

        //监听提交
        form.on('submit(add)', function(data){
            $.post("${pageContext.request.contextPath}/admin_modify.action", data.field, function (data) {
                if(data === "success"){
                    layer.alert("修改成功", {icon: 6},function () {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        self.parent.location.reload();
                        parent.layer.close(index);
                    });
                }else{
                    layer.alert("修改失败", {icon: 5},function () {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);

                    });
                }

            })
            return false;
        });


    });
</script>

</body>
</html>