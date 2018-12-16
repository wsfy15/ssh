<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>点名列表</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport"
        content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>

  <link rel="stylesheet" href="../css/font.css">
  <link rel="stylesheet" href="../css/xadmin.css">
  <script type="text/javascript" src="../lib/jquery-3.3.1.min.js"></script>
  <script src="../lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="../lib/xadmin.js"></script>
  <script type="text/javascript" src="../js/utils.js"></script>

  <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->

  <script>
      var users;
      var clickUsers = [];
      var checkboxNode;
      var courseId = window.sessionStorage.getItem("co_id");
      var rollcallUrl = "${ pageContext.request.contextPath }/teacher_rollcall.action";

      /*  删除选中的所有学生 */
      function rollcall(argument) {
          var data = tableCheck.getData();
          var params = {
              "ids": data,
              "co_id": courseId
          };

          layer.confirm('确认将这些学生设置为点名未到吗？', function (index) {
              // $.param(params, true)  序列化，发送一串字符串，而不是json对象
              $.post(rollcallUrl, $.param(params, true), function (data) {
                  if(data === "success"){
                      layer.msg('点名成功!', {icon: 1, time: 1000});
                      // document.getElementById("refresh").click();
                      // $('#refresh').click();   // 使用jquery模拟点击，只会触发事件，不会跳转
                  }
                  else{
                      layer.msg('点名失败 请重试！', {icon: 5, time: 1000});
                  }
              })
          });
      }

      function clickCheckbox(node){
          if($(node).hasClass('layui-form-checked')){
              $(node).removeClass('layui-form-checked');
          }else{
              $(node).addClass('layui-form-checked');
          }
          return false;
      }


      $(function () {
          checkboxNode = document.getElementById("checkbox");

          // 加载学生名单
          let courseId = window.sessionStorage.getItem("co_id");
          console.log(courseId);
          let params = {
              "co_id": courseId
          };
          let url = "${ pageContext.request.contextPath }/teacher/teacher_getStudent.action";
          $.post(url, params, function (data) {
              users = [];
              $.each(data, function (i, o) {
                  var user = {};
                  user.id = o.id;
                  user.name = o.name;
                  user.classNo = o.classNo;
                  users.push(user);
              });
              $("#count").text("共有数据：" + users.length + "条");

              // 显示学生名单
              for (let i = 0; i < users.length; i++) {
                  let tr = document.createElement("tr");
                  tr.setAttribute("name", users[i].id)

                  let checkbox = document.createElement("td");
                  let checkboxIcon = checkboxNode.cloneNode(true);
                  checkboxIcon.setAttribute("id", users[i].id);
                  checkboxIcon.className += " layui-form-checkbox";
                  checkboxIcon.setAttribute("data-id", users[i].id);
                  checkbox.appendChild(checkboxIcon);
                  tr.appendChild(checkbox);

                  let id = document.createElement("td");
                  id.innerText = users[i].id;
                  tr.appendChild(id);

                  let name = document.createElement("td");
                  name.innerText = users[i].name;
                  tr.appendChild(name);

                  let classNo = document.createElement("td");
                  classNo.innerText = users[i].classNo;
                  tr.appendChild(classNo);

                  document.getElementById("userTable").appendChild(tr);
              }

          }, "json");

          // 检查点名次数
          $.post("${ pageContext.request.contextPath }/teacher/teacher_getRollcallCount.action", params, function (data) {
              if(data === "fail"){
                  alert("加载点名次数失败");
              }else{
                  alert("已点名次数: " + data.complete + "\n共需点名: " + data.total + "次" + "\n点名方法：点击所有未到学生的方框，然后点击完成点名，就算点名一次");
                  if(parseInt(data.complete) === parseInt(data.total)){
                      alert("已完成本学期点名次数，无法点名");
                      $("#rollcallButton").prop('disabled', true);
                      $("#rollcallButton").attr('class', "layui-btn layui-btn-disabled");
                  }
              }
          }, "json");
      })
  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">学生管理</a>
        <a>
          <cite>点名</cite>
        </a>
      </span>
  <a id="refresh" class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i>
  </a>
</div>

<div class="x-body">
  <xblock>
    <button id="rollcallButton" class="layui-btn layui-btn-danger" onclick="rollcall()">
      <i class="iconfont">&#xe6ab; </i>完成点名
    </button>
    <span id="count" class="x-right" style="line-height:40px"></span>
  </xblock>

  <table class="layui-table">
    <thead>
      <tr>
        <th>
          <div class="layui-unselect header layui-form-checkbox" lay-skin="primary">
            <i class="layui-icon">&#xe605;</i>
          </div>
        </th>
        <th>ID</th>
        <th>姓名</th>
        <th>班级</th>
      </tr>
    </thead>

    <tbody id="userTable"></tbody>
  </table>

</div>


<div id="nodes" style="display: none;">
  <div id="checkbox" class="layui-unselect" onclick="clickCheckbox(this)" lay-skin="primary" data-id='2'>
    <i class="layui-icon">&#xe605;</i>
  </div>
</div>

</body>
</html>