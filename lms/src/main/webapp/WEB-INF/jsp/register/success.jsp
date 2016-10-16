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
                    .card-wrap{
                        padding: 5vh 2em;
                    }
                    .card-wrap h2{
                        margin-top: 0;
                    }
                </style>
                
                
            </head>
            
         
            <body class="stage-image container-full" style="background-image:url(<%=path%>/images/bg-for-role.jpg)" id="lms_login">
                <div class="row row-scroll">    
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="pd-sapce-top"></div>
                        <div class="row card card-wrap">
                            <div class="card-main">
                                
                                <h2>注册成功 !</h2>
                                
                                <p>
                                    您的信息已被系统接收，但是您<span class="text-warning">暂时还不能用此账号登录系统</span>。<br />
                                    您需在8天内得到<b>上级</b>的确认，可正式使用本系统。若8天后未确认，则您的注册信息会被系统自动删除！<br />
                                    
                                </p>
                                
                                <ul class="text-golden">
                                    <li>如果您是学生，请联系任意一位老师，让他（她）帮您确认。</li>
                                    <li>如果您是老师，请联系教务员或院长，让他（她）帮您确认。</li>
                                </ul>
                                
                                您现在可以<a href="<%=path%>/">返回登录界面</a>或<a href="<%=path%>/guest">浏览游客页面</a>
                                
                                ${acthtml}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                                                
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
