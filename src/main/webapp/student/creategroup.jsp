<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <%--这篇jsp的jquery版本有两个记住使用不同的来区分--%>



    <meta charset="UTF-8">
    <%--下面是一个chosen的库的CSS--%>
        <link rel="stylesheet" href="../css/style1.css">
        <link rel="stylesheet" href="../css/prism.css">
        <link rel="stylesheet" href="../css/chosen.css">
        <link rel="stylesheet" href="../css/chosen.min.css">
        <script src="../lib/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="../lib/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="../js/chosen.jquery.js" type="text/javascript"></script>

    <title>创建小组</title>
    <script>
        var count=0;
        var courseid=window.sessionStorage.getItem("courseid");

        //console.log(courseid);
        var allcourse=window.sessionStorage.getItem("allcourse");
        var obj=JSON.parse(allcourse);
        // console.log("id:"+obj[0].co_id);
        var course;
        var prefix;
        $.each(obj,function (i,v) {
            if(v.co_id==courseid){
                course=v;
                console.log("课程"+v.co_id);
                var pyear=v.co_gr_preyear.toString();
                var pclass;
                if(v.co_gr_preclass<10){
                    pclass="0"+v.co_gr_preclass;
                }else{
                    pclass=v.co_gr_preclass;
                }

                prefix=pyear+pclass;
                console.log("prefix:"+prefix);
            }
        });
        //添加一行input用来填写学生
        function addrow() {
            if(count>course.co_gr_max){
                alert("已经达到最大添加个数");
            }else{
                document.createElement()
            }

        }
    </script>
</head>
<body>
        <table border="1">
            <tr>
                <th >课程id</th>
                <th >课名</th>
                <th >课程简介</th>
                <th >点名次数</th>
                <th >课程日期</th>
                <th >前缀</th>
                <th >小组最小人数</th>
                <th >小组最大人数</th>
            </tr>
            <tr>
                <td id="courseid">123</td>
                <td id="coursename">123</td>
                <td id="coursedesicribe">123</td>
                <td id="rollnum">123</td>
                <td id="date">123</td>
                <td id="prefix">123</td>
                <td id="min">123</td>
                <td id="max">123</td>
            </tr>
        </table>

        <form>
            <select data-placeholder='请选择小组同学' name='depart-" + pid + "-" + id + "' class='chosen-select' multiple style='width:250px;' tabindex='4'id="select1">
            <option></option>
        </select>
        </form>
        <script>

        </script>

<%--对select的设置以及加入学生的表单--%>
        <script >
            $(function() {
                $("#courseid").html(course.co_id) ;
                $("#coursename").html (course.co_name) ;
                $("#coursedesicribe").html ( course.co_describe);
                $("#rollnum").html(course.co_ro_num)  ;
                $("#date").html(course.co_date)  ;
                $("#prefix").html(prefix) ;
                $("#min").html( course.co_gr_min);
                $("#max").html(course.co_gr_max)  ;
            });
            $(function() {

                var config = {
                    '.chosen-select': {},
                    '.chosen-select-deselect': {allow_single_deselect: true},
                    '.chosen-select-no-single': {disable_search_threshold: 10},
                    '.chosen-select-no-results': {no_results_text: 'Oops, nothing found!'},
                    '.chosen-select-width': {width: "95%"}
                }
                for (var selector in config) {
                    $(selector).chosen(config[selector]);
                }
                //动态加载数据
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contentType}/student/student_getclassmate.action",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $("#select1").html('');
                        $.each(data, function (idx, obj) {
                            $("#select1").append('<option value="' + obj.name + '">' + obj.name + '</option>');
                        });
                        $("#select1").trigger("liszt:updated");
                        $("#select1").chosen({ width: "95%" });
                    },
                    error: function (data) {
                        console.log(data);
                    }
                });

            });
        </script>
</body>
</html>