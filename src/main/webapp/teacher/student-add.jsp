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

          var courseId = window.sessionStorage.getItem("co_id");
          $('[name=co_id]').val(courseId);

          layui.use('form', function (form) {
              form.verify({
                  id: [/(\d+){10}$/, '学号必须为10位数字']
              });

              form.on('submit(addByExcel)', function (data) {
                  var fileName = $('#upload').val();
                  if(fileName === ''){
                      layer.msg("没有选择文件", {icon: 5, time:1000});
                      return false;
                  }

                  var form = new FormData(document.getElementById("uploadFile"));
                  $.ajax({
                      url: "${pageContext.request.contextPath}/teacher_addByExcel.action",
                      type: "post",
                      data: form,
                      processData: false,
                      contentType: false,
                      success: function(data){
                          console.log(data);
                          if (data === "success") {
                              layer.alert("全部添加成功", {icon: 6});
                          } else if (data === "partial") {
                              layer.alert("部分添加成功，详情见学生名单", {icon: 5});
                          } else {
                              layer.alert("全部添加失败", {icon: 5});
                          }
                      },
                      error: function(e){
                          alert("上传失败！");
                      }
                  });

                  return false;
              });

              form.on('submit(add)', function (data) {
                  $.post("${pageContext.request.contextPath}/teacher_add.action", data.field, function (data) {
                      if (data === "success") {
                          layer.alert("添加成功", {icon: 6});
                      } else {
                          layer.alert("添加失败", {icon: 5});
                      }
                  })
                  return false;
              });
          })
      })

  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="javascript:void(0);">首页</a>
        <a href="javascript:void(0);">学生管理</a>
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
      <form id="uploadFile" action="" target="_self" method="post" enctype="multipart/form-data">
        <div class="layui-form-item">
          <table class="layui-table" lay-skin="line">
            <tbody>
            <tr>
              <td>
                <a class="x-a" href="javascript:;">
                  excel文件格式：每位学生一行，必须有学号，不需要表头
                </a>
              </td>
              <td>
                <button class="layui-btn" type="button" id="pseudo_upload">
                  <i class="layui-icon">&#xe67c;</i>上传文件
                </button>
                <div hidden>
                  <input class="layui-btn" name="upload" id="upload" type="file">
                  <input type="text" name="co_id"/>
                </div>
              </td>
              <td>
                <span id="fileName"></span>
              </td>
              <td>
                <button class="layui-btn layui-btn-normal" lay-filter="addByExcel" lay-submit>提交</button>
              </td>
            </tr>
            </tbody>
          </table>
        </div>

        <%--<div class="layui-form-item" hidden>--%>
          <%--<input type="text" name="co_id"/>--%>
        <%--</div>--%>
      </form>
    </div>
  </fieldset>

  <fieldset class="layui-elem-field">
    <legend>手动添加</legend>
    <div class="layui-field-box">
      <div style="position: relative; left:30%;">
        <form class="layui-form layui-form-pane" action="" target="_self" method="post">

          <div class="layui-form-item">
            <label class="layui-form-label">学号</label>
            <div class="layui-input-inline">
              <input type="text" name="student_id" lay-verify="required|id" placeholder="请输入学号"
                     maxlength="10" autocomplete="off" class="layui-input">
            </div>
          </div>

          <div class="layui-form-item" hidden>
            <input type="text" name="co_id"/>
          </div>

          <div class="layui-form-item">
            <div class="layui-input-block">
              <button class="layui-btn" lay-filter="add" lay-submit>添加</button>
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
