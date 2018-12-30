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
              let grade = $('[name=score_' + id + ']').val();
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
      function submitCorrection(id) {
          layui.use(['layer'], function (layer) {
              let correction = $('[name=correction_' + id + ']').val();
              let params = {
                  "id": id,
                  "correction": correction
              };
              let url = "${ pageContext.request.contextPath }/teacher_modifyCorrection.action";
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

              let assignment = document.createElement("td");
              assignment.innerText = homeworks[i].assignment;
              tr.appendChild(assignment);

              let groupId = document.createElement("td");
              groupId.innerText = homeworks[i].group_id;
              tr.appendChild(groupId);

              let name = document.createElement("td");
              name.innerHTML = '<a class="x-a" href="${ pageContext.request.contextPath }/teacher_getHomework.action?id=' + homeworks[i].id + '">' + homeworks[i].ho_name + '</a>';
              tr.appendChild(name);

              let submitTime = document.createElement("td");
              submitTime.innerText = homeworks[i].ho_time;
              tr.appendChild(submitTime);

              let submitUser = document.createElement("td");
              submitUser.innerText = homeworks[i].submit_user;
              tr.appendChild(submitUser);

              let score = document.createElement("td");
              score.innerHTML = '<div><input name="score_' + homeworks[i].id + '" type="number" min="0" max="100" step="0.5" value="' + homeworks[i].grade + '"> <a href="javascript:void(0);" onclick=score("' + homeworks[i].id + '")>提交</a>  </div>';
              tr.appendChild(score);

              let correction = document.createElement("td");
              correction.innerHTML = '<div><input name="correction_' + homeworks[i].id + '"  value="' + homeworks[i].correction + '"> <a href="javascript:void(0);" onclick=submitCorrection("' + homeworks[i].id + '")>提交</a>  </div>';
              tr.appendChild(correction);

              let opinion = document.createElement("td");
              opinion.innerText = homeworks[i].opinion;
              tr.appendChild(opinion);

              document.getElementById("homeworkTable").appendChild(tr);
          }
      }

      // 用于排序
      function compare(property){
          return function (obj1, obj2) {
              var val1 = obj1[property];
              var val2 = obj2[property];
              if (val1 < val2 ) { //正序
                  return 1;
              } else if (val1 > val2 ) {
                  return -1;
              } else {
                  return 0;
              }
          }
      }

      function renderTable(data){
          homeworks = [];
          $.each(data, function (i, o) {
              var homework = {};
              homework.id = o.id;
              homework.ho_name = o.ho_name;
              homework.time_stamp = o.ho_time;
              homework.ho_time = formatDateYMDhms(new Date(o.ho_time));
              homework.grade = o.grade;
              homework.submit_user = o.submit_user.name;
              homework.group_id = o.group.gr_id;
              homework.correction = o.correction;
              homework.opinion = o.opinion;
              homework.assignment = o.assignment.as_name;
              homeworks.push(homework);
          });

          // 根据time_stamp排序
          homeworks.sort(compare("time_stamp"));

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
      }

      $(function () {
          // 加载作业列表
          let courseId = window.sessionStorage.getItem("co_id");
          let params = {
              "co_id": courseId
          };
          let url = "${ pageContext.request.contextPath }/teacher/teacher_getHomeworks.action";

          // 首次 加载所有homework
          $.post(url, params, function (data) {
              renderTable(data);
          }, "json");

          // 获取小组列表
          $.post("${ pageContext.request.contextPath }/teacher/teacher_getGroups.action", params, function (data) {
              $.each(data, function (i, o) {
                  $("[name=group]").append("<option value='" + o.gr_id + "'>" + o.gr_id + "</option>");
              })
          }, "json");

          // 获取作业列表
          $.post("${ pageContext.request.contextPath }/teacher/teacher_getAssignments.action", params, function (data) {
              $.each(data, function (i, o) {
                  $("[name=assignment]").append("<option value='" + o.as_id + "'>" + o.as_name + "</option>");
              })
          }, "json");

          layui.use(['laydate', 'form', 'layer'], function(laydate, form, layer){
              //执行一个laydate实例
              laydate.render({
                  elem: '#start' //指定元素
                  ,type: 'datetime'
              });

              //执行一个laydate实例
              laydate.render({
                  elem: '#end' //指定元素
                  ,type: 'datetime'
              });

              form.on('submit(filter)', function(data){
                  data.field.co_id = courseId;
                  console.log(data.field);
                  if(data.field.start && data.field.end && data.field.start > data.field.end){
                      layer.msg('日期选择有误!', {icon: 5, time: 1000});
                      return false;
                  }

                  $.post("${ pageContext.request.contextPath }/teacher/teacher_filterHomeworks.action", data.field, function (data) {
                      console.log(data);
                      renderTable(data);
                  }, "json");
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
  <div class="layui-row">
    <form class="layui-form layui-col-md12 x-so">
      <table>
        <tbody>
          <tr>
            <td>
              <span>from</span>
              <input class="layui-input" placeholder="开始日" name="start" id="start" autocomplete="off">
            </td>
            <td>
              <span>to</span>
              <input class="layui-input" placeholder="截止日" name="end" id="end" autocomplete="off">
            </td>
            <td>
              <select name="group">
                <option value="">请选择小组</option>
              </select>
            </td>
            <td>
              <select name="assignment">
                <option value="">请选择作业</option>
              </select>
            </td>
            <td>
              <button class="layui-btn"  lay-submit="" lay-filter="filter"><i class="layui-icon">&#xe615;</i></button>
            </td>
          </tr>
        </tbody>
      </table>
    </form>
  </div>

  <table class="layui-table">
    <thead>
    <tr>
      <th>作业</th>
      <th>小组编号</th>
      <th>名称</th>
      <th>提交时间</th>
      <th>提交人</th>
      <th>成绩</th>
      <th>批改说明</th>
      <th>学生意见</th>
    </tr>
    </thead>

    <tbody id="homeworkTable"></tbody>
  </table>
  <div id="page" align="center"></div>
</div>
</body>
</html>
