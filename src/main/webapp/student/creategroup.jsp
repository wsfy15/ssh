<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <%--这篇jsp的jquery版本有两个记住使用不同的来区分--%>



    <meta charset="UTF-8">
        <script src="../lib/jquery-3.3.1.min.js" type="text/javascript"></script>
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
            <input type="text" id="search" >
        <form action="">
            <select id="select1">
            </select>
        </form>
<script>

    var timeoutId = 0;
    $('#search').off('keyup').on('keyup', function () {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(function () {
            var inp= $("#search").val();//获取输入的值
            $.ajax({
                type:"POST",
                url:"${ pageContext.request.contextPath }/student_searchmember.action",
                data: {"name":inp},
                dataType:"json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success:function (data) {
                    $.each(data,function(i,v){
                        $.each(v,function (key,val) {
                            var opp = new Option(val.studentname,v.studentname);
                            $("#select1").add(opp);
                        });

                    });
                }
            });
        }, 1000);
    });


</script>

</body>
</html>