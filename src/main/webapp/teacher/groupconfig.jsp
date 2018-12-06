<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>课程</title>
    <script src="lib/jquery-3.3.1.min.js">
    </script>
</head>
<body>

<table border="1" width="100%">
    <thead>
    <tr>
        <th rowspan="2">课程id</th>
        <th rowspan="2">课名</th>
        <th rowspan="2">课程简介</th>
        <th colspan="2">前缀</th>
        <th rowspan="2">小组最小人数</th>
        <th rowspan="2">小组最大人数</th>
        <th rowspan="2">设置</th>
    </tr>
    <tr>
        <th>year</th>
        <th>class</th>
    </tr>
    <s:iterator value= "courseList" var="course">
        <tr>
            <th id="cid" > <s:property value="#course.co_id" /> </th>
            <th id="cname"> <s:property value="#course.co_name" /> </th>
            <th id="cintro"> <s:property value="#course.co_describe" /> </th>
            <th id="cpreyear"> <s:property value="#course.co_gr_preyear " /> </th>
            <th id="cpreclass"> <s:property value="#course.co_gr_preclass " /> </th>
            <th id="cgroupmin"><s:property value="#course.co_gr_min " /></th>
            <th id="cgroupmax"><s:property value="#course.co_gr_max " /></th>
            <th id="cconfig"><input type="button" id="configbutton" value="设置" onclick="editData(this)"></th>
        </tr>
    </s:iterator>
    </thead>
</table>
    <script type="text/javascript">

        function cancel(t) {

                location.reload();
        }
        function save(t) {
            var td=t.parentNode.parentNode.getElementsByTagName("th");
            var value0=td[0].innerHTML;
            var value1=td[1].innerHTML;
            var value2=td[2].innerHTML;
            var value3=td[3].getElementsByTagName("input")[0].value;
            var value4=td[4].getElementsByTagName("input")[0].value;
            var value5=td[5].getElementsByTagName("input")[0].value;
            var value6=td[6].getElementsByTagName("input")[0].value;
            if(value5>value6){
                alert("小组最小值必须小于等于最大值!");
                location.reload();
            }
            else{
                // var jsonobj={
                //     "id":value0,"name":value1,
                //     "intro":value2,"preyear":value3,"preclass":value4,"groupmin":value5,
                //     "groupmax":value6};
                //  alert(jsonobj.id);
                //  alert(jsonobj.preclass);
               $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/teacher_data.action",
                    data: {
                           "course1.course.co_id":value0,
                        "course1.course.co_name":value0,
                        "course1.co_describe":value0,
                        "course1.co_gr_preyear":value0,
                        "course1.co_gr_preclass":value0,
                        "course1.co_gr_min":value0,
                        "course1.co_gr_max":value0
                    },
                    success: function(result){

                        alert (result);
                    }
                });
               alert("123");
            }


        }
        function editData(t) {
            var td = t.parentNode.parentNode.getElementsByTagName("th");
            var obj = document.createElement("input");
            obj.setAttribute("size", '4');
            obj.setAttribute("type", 'number');
            obj.setAttribute("min", '2008');
            obj.setAttribute("max", '2058');
            obj.setAttribute("value", '+td[3].innerText+');
            td[3].appendChild(obj);
            obj = document.createElement("input");
            obj.setAttribute("size", '2');
            obj.setAttribute("type", 'number');
            obj.setAttribute("min", '0');
            obj.setAttribute("max", '99');
            obj.setAttribute("value", '+td[4].innerText+');
            td[4].appendChild(obj);
            obj = document.createElement("input");
            obj.setAttribute("size", '1');
            obj.setAttribute("type", 'number');
            obj.setAttribute("min", '1');
            obj.setAttribute("max", '9');
            obj.setAttribute("value", '+td[5].innerText+');
            td[5].appendChild(obj);
            obj = document.createElement("input");
            obj.setAttribute("size", '1');
            obj.setAttribute("type", 'number');
            obj.setAttribute("min", '1');
            obj.setAttribute("max", '9');
            obj.setAttribute("value", '+td[6].innerText+');
            td[6].appendChild(obj);
            // td[3].append("<input size='4'type='number'min='2008' max='2058' value='"+td[3].innerText+"'/>");
            // td[3].innerHTML="<input size='4'type='number'min='2008' max='2058' value='"+td[3].innerText+"'/>";
            // td[4].innerHTML="<input size='2'type='number'min='0' max='99' value='"+td[4].innerText+"'/>";
            // td[5].innerHTML="<input size='1'type='number'min='1' max='9' value='"+td[5].innerText+"'/>";
            // td[6].innerHTML="<input size='1'type='number'min='1' max='9'value='"+td[6].innerText+"'/>";
            td[7].innerHTML="<input type='button' id='save' value='保存' onclick='save(this)' ><input type='button' id='save' value='取消' onclick='cancel(this)' >"
            // alert(td[1].innerHTML);
        }
    </script>
</body>
</html>
