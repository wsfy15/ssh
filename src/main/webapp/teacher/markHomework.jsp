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
  <script charset="utf-8" src="../js/utils.js"></script>

  <script>
      var homeworks;
      var courseId = window.sessionStorage.getItem("co_id");

      function score(id) {
          layui.use(['layer'], function (layer) {
              let grade = $('#' + id).val();
              grade = parseFloat(grade);
              console.log(typeof grade);
              if (grade > 100 || grade < 0) {
                  layer.alert("评分有效范围为[0, 100]", {icon: 6});
                  return;
              }

              let params = {
                  "id": id,
                  "grade": grade
              };
              let url = "${ pageContext.request.contextPath }/teacher_modifyGrade.action";
              $.post(url, params, function (data) {
                  if (data === "success") {
                      layer.msg('修改成功', {icon: 1, time: 1000});
                  } else {
                      layer.msg("修改失败", {icon: 5, time: 1000});
                  }


              });
          });
      }

      function toPage(curPage, limit) {
          // 先清除数据，再添加
          $("#homeworkTable").empty();

          let start = (curPage - 1) * limit;
          let end = start + limit;
          if (start >= homeworks.length) {
              return;
          }
          if (end > homeworks.length) {
              end = homeworks.length;
          }
          for (let i = start; i < end; i++) {
              let tr = document.createElement("tr");
              tr.setAttribute("name", homeworks[i].id)

              let name = document.createElement("td");
              name.innerText = homeworks[i].ho_name;
              tr.appendChild(name);

              let submitTime = document.createElement("td");
              submitTime.innerText = homeworks[i].ho_time;
              tr.appendChild(submitTime);

              let download = document.createElement("td");
              // download.innerHTML = '<a href="javascript:void(0);" onclick=download(this)> 下载</a>';
              download.innerHTML = '<a href="${ pageContext.request.contextPath }/teacher_getHomework.action?id=' + homeworks[i].id + '"> 下载</a>';
              tr.appendChild(download);

              let score = document.createElement("td");
              score.innerHTML = '<div><input id="' + homeworks[i].id + '" type="number" min="0" max="100" step="0.5" value="' + homeworks[i].grade + '"> <a href="javascript:void(0);" onclick=score("' + homeworks[i].id + '")>提交</a>  </div>';
              tr.appendChild(score);

              document.getElementById("homeworkTable").appendChild(tr);
          }
      }

      $(function () {
          // 加载作业列表
          let courseId = window.sessionStorage.getItem("co_id");
          let params = {
              "co_id": courseId
          };
          let url = "${ pageContext.request.contextPath }/teacher/teacher_getHomeworks.action";
          $.post(url, params, function (data) {
              console.log(data);
              homeworks = [];
              $.each(data, function (i, o) {
                  var homework = {};
                  homework.id = o.id;
                  homework.ho_name = o.ho_name;
                  homework.ho_time = formatDateYMDhms(new Date(o.ho_time));
                  homework.grade = o.grade;
                  homeworks.push(homework);
              });

              layui.use(['laypage'], function (laypage) {
                  //分页
                  laypage.render({
                      elem: 'page' //分页容器的id
                      , count: homeworks.length //总页数
                      , limit: 10
                      // , limits: [5, 10, 15]
                      , skin: '#1E9FFF' //自定义选中色值
                      , skip: true //开启跳页
                      , jump: function (obj, first) {
                          // if (!first) {
                          toPage(obj.curr, obj.limit);
                          // }
                      }
                  });
              });
          }, "json");
      })
  </script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="javascript:void(0);">首页</a>
        <a href="javascript:void(0);">作业管理</a>
        <a>
          <cite>检查作业</cite>
        </a>
      </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>

<div class="x-body">
  <table class="layui-table">
    <thead>
    <tr>
      <th>名称</th>
      <th>提交时间</th>
      <th>查看</th>
      <th>评分</th>
    </tr>
    </thead>

    <tbody id="homeworkTable"></tbody>
  </table>
  <div id="page" align="center"></div>
</div>
</body>
</html>
