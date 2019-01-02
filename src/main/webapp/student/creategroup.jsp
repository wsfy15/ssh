<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>创建小组</title>
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

        var groupcount=1;//已加入的人数
        var gourpconfigcountmax=0;//设置的人数
        var tabledata;//表格中的数据
        var courseid=window.sessionStorage.getItem("courseid");
        var myid=window.sessionStorage.getItem("usid");
        var myusrname=window.sessionStorage.getItem("usname");
        console.log(myid+myusrname);

    </script>

</head>
<body>
 <%--显示当前的课--%>
        <div class="showcoursetable">
            <p>课程id：<input style="outline:none" type="text" id="cid"/></p><br>
            <p>课程name：<input style="outline:none" type="text" id="cname"/></p><br>
            <p>课程prefix：<input style="outline:none" type="text" id="cprefix"/></p><br>
            <p>小组min：<input style="outline:none" type="text" id="cmin"/></p><br>
            <p>课程max：<input style="outline:none" type="text" id="cmax"/></p><br>
        </div>

<%--添加小组成员--%>
        <div class="demoTable">
            <div class="layui-inline">
                搜索组员：<input class="layui-input" name="keyword" id="search" autocomplete="off">
                <select id="select1"></select>
                <input type="button" id="buttonchoose" value="确认"></input>
            </div>
        </div>

        <table id="demo"lay-filter="useruv"></table>


            <input type="text" id="phone" name="phone" lay-filter="formDemo" required lay-verify="required" placeholder="小组联系方式" autocomplete="off" class="layui-input">
            <input type="text" id="qq" name="qq" lay-filter="formDemo" required lay-verify="required" placeholder="qq号码" autocomplete="off" class="layui-input">
            <input type="text" id="mail" name="mail" lay-filter="formDemo" required lay-verify="required" placeholder="email" autocomplete="off" class="layui-input">
            <input type="hidden" id="getgroupmember" value=$(tabledata) name="groupmember" lay-filter="formDemo" required lay-verify="required"  autocomplete="off" class="layui-input">
            <button class="layui-btn" lay-submit lay-filter="formDemo" id="button1">立即提交</button>


        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
        </script>
<script>


    <%--课程显示--%>
    <%--获取数据index中上传--%>
    var allcourse=window.sessionStorage.getItem("allcourse");
    var obj=JSON.parse(allcourse);
    console.log("id:"+obj[0].co_id);
        $(function(){


            $("#cid").val(obj[0].co_id);
            $("#cname").val(obj[0].co_name);
            $("#cprefix").val(obj[0].co_gr_prefix);
            $("#cmin").val(obj[0].co_gr_min);
            $("#cmax").val(obj[0].co_gr_max);
            gourpconfigcountmax= parseInt(obj[0].co_gr_max);
        })




    <%--表格的设置--%>
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form1=layui.form;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 150
            ,data:[{"id":myid,"name":myusrname}]
            ,id:'demo'
            ,cols: [[ //表头
                {field: 'id', title: '成员学号', width:100, sort: false, fixed: 'left'},
                {field: 'name', title: '成员姓名', width:100, sort: false, fixed: 'left'},
                {field: 'right', title: '操作', width:177,toolbar:"#barDemo"}
            ]]
        });
        //监听表单数据
        form1.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return false;
        });
        // 监听table中的数据
        table.on('tool(useruv)', function(obj){
            var data = obj.data;
            if(obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    if(data.id==myid){
                        layer.alert("不可以删除");
                    }
                    else{
                        groupcount--;//小组人数减一
                        obj.del();
                        layer.close(index);
                        var table = layui.table;
                        tabledata=  table.cache["demo"];
                        console.log("-"+tabledata);
                    }
                });
            }
        });
    });
    <%--模糊查询将学生加载到 select--%>
    var timeoutId = 0;
    $('#search').off('keyup').on('keyup', function () {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(function () {
            var inp= $("#search").val();//获取输入的值
            $.ajax({
                type:"POST",
                url:"${ pageContext.request.contextPath }/student/student_searchMember.action",
                data: {"name":inp,"courseId":courseid},
                dataType:"json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success:function (data) {
                    console.log(data)
                    var i=0;
                    var k="opp";
                    $("#select1").empty();
                    var id1;
                    $.each(data,function(i,v){
                       $.each(v,function (a,b) {

                           if(a=="id"){
                               id1=b;
                               console.log(id1);
                           }
                           if(a=="name"){
                               // console.log("行数"+$("#demo").count());
                               // if(count1)
                               var str=k+i;
                               $("#select1").append("<option value='"+id1+"'id='"+str+"'>"+b+"</option>");//新增
                           }
                       })
                        i++;
                    });
                }
            });
        }, 1000);
    });

// 选择学生然后将学生添加到table中
$("#buttonchoose").click(function(){
    var table = layui.table;
    var oldData =  table.cache["demo"];
    var vall=$("#select1").find("option:selected").text();
    var val2=$("#select1").find("option:selected").val();
    var data1={"id":val2,"name":vall};
    layer.confirm('确定加入该成员吗?', function (index) {
        var flag=0
        $.each(oldData,function (i,j) {
          if(j.id==data1.id){
            flag=1;
          }
        });
        if(flag==1){
            layer,alert("已经添加过这个学生啦");
        }else{
            console.log("groupconfigcountmax"+gourpconfigcountmax);
            if(groupcount<gourpconfigcountmax){
                oldData.push(data1);
                table.reload('demo',{
                    data : oldData
                });
                groupcount++;
                tabledata=  table.cache["demo"];
                console.log("+"+tabledata);
            }else{
                layer.alert("已超过教师设置的最大组员数");
            }

        }
        layer.close(index);
    });
});

   $("#button1").click(function () {
       var phone=$("#phone").val();
       var qq=$("#qq").val();
       var email=$("#mail").val();
       console.log(phone);
       var ajson = [];
       $.each(tabledata,function (a,b) {
           var row1={};
           $.each(b,function (m,n) {
              if(m=="id"){
                row1.id=n;
              }
              if(m=="name"){
                  row1.name=n;
              }
           })
           ajson.push(row1);
       });
       var row2={};
       row2.phone=phone;
       row2.qq=qq;
       row2.courseid=obj[0].co_id;
       row2.mail=email;
       row2.courseid=courseid
       ajson.push(row2);
       var jsonStr = JSON.stringify(ajson);
       //console.log(jsonStr);
       $.ajax({
           type:"POST",
           url:"${ pageContext.request.contextPath }/student_uploadGroup.action",
           data:{"data":jsonStr},
           dataType:"json",
           contentType: "application/x-www-form-urlencoded; charset=utf-8",
           success:function (data) {
                alert(data.toString());
           }


       });
   });

</script>

</body>
</html>