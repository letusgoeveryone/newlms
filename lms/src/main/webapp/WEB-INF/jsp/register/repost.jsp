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
                <title>不好意思，信息对比出现问题。</title>
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
                                                <h2>不好意思，信息对比出现问题。</h2>
                                                <h5>您是否在注册时输入了有误的数据？<br />
                                                如果您刚才填写的资料是虚假的，建议您<a href="<%=path%>/reg/student_teacher">重新注册</a><br />
                                                如果您刚才填写的数据是真实的，那么有可能是您更改过数字校园的密码。<br />
                                                数字校园即为您在图书馆蹭WIFi，或者在寝室用校园网拨号的密码。<br />
                                                请输入您更改后的密码：
                                                <input type="password" placeholder="更改后的密码" id="pwd" class="form-control" size="70"  style="width:180px;">
                                                请输入验证码：<img id="ccdImage" style="border:0" title="看不清楚请单击图片" onclick="reload()" >
                                                <input type="text" placeholder="验证码" id="ccd" class="form-control" size="70" style="width:180px;">
                                                <button id="yanzheng">点这里继续Next＞＞</button>
                                                </h5>
                                                
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
             function reload() {
            $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random()); //随机生成验证码
        }
            window.onload=function(){
                $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random()); //随机生成验证码
            $("#yanzheng").click(function(){ 
                $.post("<%=path%>/reg//tmp_attestation_repost", { sn: ${sn},pwd :$("#pwd").val(),ccd :$("#ccd").val()},
                  function(data){
                    if(data=="认证成功"){
                        alert("您已认证成功！账号已能正常登录！");
                        location.href="<%=path%>";
                    }else{
                        alert("出错了。错误信息：\n"+data);
                         reload();
                    }
                  });
                        });
                    };
</script>
            </body>
            </html>
