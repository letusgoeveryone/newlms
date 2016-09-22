<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="utf-8">
                <title>注册成功</title>
                <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css" />
                <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css" />
                <link rel="stylesheet" type="text/css" href="<%=path%>/css/lms.css" />

                <style media="screen">
                    html,
                    body {
                        height: 100%;
                        transition: all 3s;
                    }
                    body {
                        overflow-y: scroll;
                    }
                </style>
                
                
            </head>
            
         
            <body class="stage-image" style="background-image:url(<%=path%>/images/bg-for-role.jpg)" id="lms_login">
            <div class="row">    
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <div style="height:100px;width: 80%;"></div>
                    <div class="row card" style="width: 680px;margin:0 auto;">
                        <div  style="height:480px;width: 600px;margin:0 auto;">
                            <br />
                                                 <h2>恭喜，您已注册成功。</h2>
                                                <h5><span style="color:red">注意：您的信息已被系统接收，但是您暂时还不能用此账号登录系统。</span><br />
                                                    如果您是学生，请联系任意一位老师，让他（她）帮您确认。<br />
                                                    如果您是老师，请联系教务员或院长，让他（她）帮您确认。<br />
                                                    确认之后方可正式使用本系统。<br />
                                                    您需在8天内得到上级的确认，若8天后未确认，则您的注册信息会被系统自动删除！<br /></h5>
                                                <h5>您现在可以<a href="<%=path%>">回到主页</a>或<a href="<%=path%>/guest">以游客身份登录</a></h5>
                                                
                                                ${acthtml}
<!--<h5>好消息：您现在可以自助完成信息确认：<a class="btn btn-default" id="yanzheng">点这里开始Next＞＞</a>（这个认证操作会自动尝试登录一次您的数字校园，我们承诺对您的数据严格保密，请知悉。）</h5>-->
                            <br /><br />
                             </div>
                             
                    </div>
                </div>
                <div class="col-md-2"></div>
            </div>
                    <footer class="row box-small text-right" id="lms-login-footer">
                        Copyright © 2015 河南大学软件学院 · 【教学系统】
                    </footer>
                <script src="<%=path%>/js/jquery.min.js"></script>
                <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
                <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
                <script src="<%=path%>/js/md5.js"></script>
                   <script>
            window.onload=function(){
            $("#yanzheng").click(function(){ 
                $.get("<%=path%>${actjs}", { sn: ${sn}},
                  function(data){
                    if(data=="认证成功"){
                        alert("您已认证成功！账号已能正常登录！");
                        location.href="<%=path%>";
                    }else{
                        location.href="<%=path%>/reg/repost?sn=${sn}";
                    }
                  });
                        });
                    };
</script>
            </body>
            </html>
