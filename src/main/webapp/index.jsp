<%@ page contentType="text/html;charset=UTF-8"%>
<html>
    <head>
        <title>登录</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Language" content="ch-cn">
        <link href="css/Style.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="js/md5.js"></script>
        <script >
            function checkInput() {
                // set password
                $("#password1").val(hex_md5($("#password1").val()));

                return true;
            }
        </script>
    </head>

    <body>
        <!-- Form 用来提取用户填入并提交的信息-->
        <form method="post" name="frmLogin" action="${pageContext.request.contextPath}/user_login.action" onsubmit="return checkInput()">
            <div class='gcs-login'>
                <div class="gcs-login-panel">
                    <div class="login-title">
                        <h2>用户登陆</h2>
                    </div>
                    <div class="gcs-login-container">
                        <input type="text" class="input" name="id" placeholder="请输入用户名" />
                    </div>
                    <div class="gcs-login-container">
                        <input type="password" id="password1" class="input" name="password" placeholder="请输入密码"/>
                    </div>
                    <br />
                    <br />
                    <div class="gcs-login-container">
                        <input type="submit" value="立即登录" class="btn-login" />
                    </div>

                    <div class="gcs-login-container">
                        <input type="reset"  value="重置" class="btn-login">
                    </div>

                </div>
            </div>
        </form>

    </body>
</html>