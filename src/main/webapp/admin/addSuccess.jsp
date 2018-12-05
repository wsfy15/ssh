<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>

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
</head>
<body>
<div class="x-body">
  <fieldset class="layui-elem-field">
    <legend>添加成功</legend>
    <div class="layui-field-box">
      <table class="layui-table">
        <colgroup>
          <col width="150">
          <col width="200">
          <col>
        </colgroup>
        <thead>
        <tr>
          <th>ID</th>
          <th>姓名</th>
        </tr>
        </thead>
        <tbody>
        <s:iterator value="newUser" var="user">
          <tr>
            <td><s:property value="#user.id"/></td>
            <td><s:property value="#user.name"/></td>
          </tr>
        </s:iterator>
        </tbody>
      </table>
    </div>
  </fieldset>
</div>
</body>
</html>
