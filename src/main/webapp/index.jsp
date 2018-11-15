<%@ page contentType="text/html;charset=UTF-8"%>
<html>
   <head>
         <title>登录</title>
         <meta http-equiv="content-type" content="text/html; charset=UTF-8">
         <meta http-equiv="Content-Language" content="ch-cn">
       </head>

   <body>
       <!-- Form 用来提取用户填入并提交的信息-->
       <form method="post" name="frmLogin" action="${pageContext.request.contextPath}/user_login.action">
           <h1 align="center">用户登录</h1><br>
           <div align="center">
                <label>用户名：
                    <input type="text" name="id" >
                </label>
                <label>密码：
                    <input type="password" name="password">
                </label>

             <input type="submit" > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="reset"  value="重置">
                <br>
           </div>
        </form>
    </body>
</html>
