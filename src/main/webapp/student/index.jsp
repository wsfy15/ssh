<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags" %>

<html lang="en">
<head>
  <base href="${pageContext.request.contextPath}/student/">
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
      var username="${user.name}";
      console.log("username"+username);
      window.sessionStorage.setItem("usname",username);
      $(function () {
          // 加载该学生的课，显示在左侧选择框中
          var k=document.getElementById("courseselect");
          //ajax获取数据
          $.ajax({
              type:"POST",
              url:"${ pageContext.request.contextPath }/student_courseList.action",
              dataType:"json",
              contentType: "application/x-www-form-urlencoded; charset=utf-8",
              success:function (data) {
                  var allcourse=JSON.stringify(data);
                  console.log("allcourse"+allcourse);
                  window.sessionStorage.setItem("allcourse",allcourse);
                  $.each(data,function(i,v){
                      console.log("v:"+v.co_name);
                      var opp = new Option(v.co_name,v.co_id);
                      k.add(opp);
                  });

              }

          });
          // var z;
          // z.setAttribute("")
          // k.append();
      })

      function onClassChange(name){
          if(name != "请选择课程"){
              // 显示该课的信息
              window.sessionStorage.setItem('courseid',name);
          }

      }
  </script>
</head>

<body>
<!-- 顶部开始 -->
<div class="container">
  <div class="logo"><a href="./index.jsp">学生作业系统</a></div>
  <div class="left_open">
    <i title="展开左侧栏" class="iconfont">&#xe699;</i>
  </div>

  <ul class="layui-nav right" lay-filter="">
    <li class="layui-nav-item">
      <a href="javascript:;"> ${user.name} </a>
      <dl class="layui-nav-child"> <!-- 二级菜单 -->
        <dd><a onclick="x_admin_show('个人信息','')">个人信息</a></dd>
        <dd><a onclick="x_admin_show('更改密码','/modifyPassword.jsp', 800, 400)">修改密码</a></dd>
        <dd><a href="${pageContext.request.contextPath}/logout.jsp">切换帐号</a></dd>
      </dl>
    </li>
  </ul>

</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
  <div class="layui-form-item">
    <div class="layui-input-inline" style="transform: translateX(10px);">
      <select id="courseselect" onchange="onClassChange(this.options[this.options.selectedIndex].value)">
        <option value="">请选择课程</option>
      </select>
    </div>
  </div>

  <div id="side-nav">
    <ul id="nav">
      <li hidden>
        <a href="javascript:;">
          <i class="iconfont">&#xe723;</i>
          <cite>HIDDEN</cite>
          <i class="iconfont nav_right">&#xe697;</i>
        </a>
        <ul class="sub-menu">
          <li>
            <a id="courseInfo" _href="${ pageContext.request.contextPath }/student_.action">
              <i class="iconfont">&#xe6a7;</i>
              <cite>课程信息</cite>
            </a>
          </li >
        </ul>
      </li>

      <li>
        <a href="javascript:;">
          <i class="iconfont">&#xe723;</i>
          <cite>作业</cite>
          <i class="iconfont nav_right">&#xe697;</i>
        </a>
        <ul class="sub-menu">
          <li>
            <a _href="${ pageContext.request.contextPath }/student/uploadassign.jsp">
              <i class="iconfont">&#xe6a7;</i>
              <cite>作业信息</cite>
              <%-- 在作业信息中进行提交 --%>
            </a>
          </li>
          <li>
            <a _href="${ pageContext.request.contextPath }/student/creategroup.jsp">
              <i class="iconfont">&#xe6a7;</i>
              <cite>创建小组</cite>
            </a>
          </li>
          <li>
            <a _href="${ pageContext.request.contextPath }/student_.action">
              <i class="iconfont">&#xe6a7;</i>
              <cite>成绩查看</cite>
              <%-- 包括每一次作业的成绩 --%>
            </a>
          </li>
        </ul>
      </li>
      <li>
        <a href="javascript:;">
          <i class="iconfont">&#xe723;</i>
          <cite>小组管理</cite>
          <i class="iconfont nav_right">&#xe697;</i>
        </a>
        <ul class="sub-menu">
          <li>
            <a _href="${ pageContext.request.contextPath }/student_getAllCourse.action">
              <i class="iconfont">&#xe6a7;</i>
              <cite>创建小组(todo)</cite>
            </a>
          </li>
        </ul>
      </li>

    </ul>
  </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
  <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
    <ul class="layui-tab-title">
      <li class="home"><i class="layui-icon">&#xe68e;</i>我的桌面</li>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
        <iframe src='./welcome.html' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
      </div>
    </div>
  </div>
</div>
<div class="page-content-bg"></div>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->

<!-- 底部开始
<div class="footer">
    <div class="copyright">Copyright ©2017 x-admin v2.3 All Rights Reserved</div>
</div>
 底部结束 -->
</body>
</html>