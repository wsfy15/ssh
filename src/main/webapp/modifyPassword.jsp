<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="UTF-8">
  <title>修改密码</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport"
        content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
  <link rel="stylesheet" href="./css/font.css">
  <link rel="stylesheet" href="./css/xadmin.css">
  <script type="text/javascript" src="./lib/jquery-3.3.1.min.js"></script>
  <script src="./lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="./lib/xadmin.js"></script>
  <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>

<body>
<div class="x-body">
  <fieldset class="layui-elem-field">
    <legend>修改密码</legend>
    <form class="layui-form" action="">
      <div style="position: relative; left:30%; top:30%;">
        <div class="layui-form-item">
          <label for="L_pass" class="layui-form-label">
            <span class="x-red">*</span>原密码
          </label>
          <div class="layui-input-inline">
            <input type="password" name="password" required autocomplete="off" class="layui-input">
          </div>
        </div>

        <div class="layui-form-item">
          <label for="L_pass" class="layui-form-label">
            <span class="x-red">*</span>新密码
          </label>
          <div class="layui-input-inline">
            <input type="password" id="L_pass" name="newPassword" required lay-verify="notRepeat"
                   autocomplete="off" class="layui-input">
          </div>
          <div class="layui-form-mid layui-word-aux">
           不能与默认密码（ID）相同
          </div>
        </div>

        <div class="layui-form-item">
          <label for="L_repass" class="layui-form-label">
            <span class="x-red">*</span>确认新密码
          </label>
          <div class="layui-input-inline">
            <input type="password" id="L_repass" name="repass" required lay-verify="repass"
                   autocomplete="off" class="layui-input">
          </div>
        </div>

        <div class="layui-form-item">
          <label for="L_repass" class="layui-form-label">
          </label>
          <button class="layui-btn" lay-filter="add" lay-submit>
            修改
          </button>
        </div>
      </div>
    </form>
  </fieldset>
</div>

<script>
    layui.use(['form', 'layer'], function (form, layer) {
        $ = layui.jquery;

        //自定义验证规则
        form.verify({
            // nikename: function (value) {
            //     if (value.length < 5) {
            //         return '昵称至少得5个字符啊';
            //     }
            // },
            //  pass: [/(.+){6,12}$/, '密码必须6到12位'],
            notRepeat: function(value){
                if ($('#L_pass').val() === '<s:property value="user.id"/>'){
                    return '密码不能与ID相同';
                }
            },
            repass: function (value) {
                if ($('#L_pass').val() != $('#L_repass').val()) {
                    return '两次密码不一致';
                }
            }
        });

        //监听提交
        form.on('submit(add)', function (data) {
            let url = "${pageContext.request.contextPath}/user_modifyPassword.action";
            let params = {
              "id": '${user.id}',
              "password": $('[name=password]').val(),
              "newPassword":  $('[name=newPassword]').val()
            };

            $.post(url, params, function (data) {
                if("success" === data){
                    layer.msg("修改成功");
                    let from = window.sessionStorage.getItem("fromIndex");
                    window.sessionStorage.setItem("fromIndex", '0');
                    if(from == '1'){
                        window.location.href = "/index.jsp";
                    } else{
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        self.parent.location.href = "/index.jsp";
                        parent.layer.close(index);
                    }
                    layer.msg("修改成功");
                }else{
                    layer.msg("原密码错误");
                }
            })
            return false;
        });

    });
</script>

</body>
</html>