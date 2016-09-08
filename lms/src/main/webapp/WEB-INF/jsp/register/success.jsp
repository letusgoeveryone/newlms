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
 
                    #form-frame {
                        padding: 1em 2em;
                    }
 
                    #lms_login_wrap {
                        min-width: 550px;
                        max-width: 600px;
                        margin:0 auto;
                    }
 
                    .floating-label {
                        color: #FFF;
                    }
 
                    .form-control {
                        border-bottom: 1px solid #FFF;
                    }
                </style>
            </head>

            <body class="stage-image" style="background-image:url(<%=path%>/images/bg-for-role.jpg)" id="lms_login">
                <div class="container-fuild" style="height: inherit;padding: 0;">

                    <div class="row">

                        <div class="col-md-4"></div>
                        <div class="col-md-4" id="form-frame">

                            <div style="padding:2.5em 2.5em 2.5em;">
                                <!--<img src="images/logo-white.png" class="" alt="" style="margin:auto;display: block;" />-->
                            </div>

                            <div class="row card" id="lms_login_wrap">
                                <div id="login-form" class="height-control"  style="width:550px; ">

                                    
                                        <!-- Only required for left/right tabs -->
                                      

                                           
                                                   <div style="width:450px;margin-left:-50px; ">
                                                <h2>恭喜，您已注册成功。</h2>
                                                <h5>您的信息已被系统接收，但是您暂时还不能用此账号登录系统。<br />
                                                    如果您是学生，请联系任意一位老师，让他（她）帮您确认。<br />
                                                    如果您是老师，请联系教务员或院长，让他（她）帮您确认。<br />
                                                    确认之后方可正式使用本系统。<br />
                                                    您需在8天内得到上级的确认，若8天后未确认，则您的注册信息会被系统自动删除！<br /></h5>
                                                <br />
                                                <h5>您现在可以<a href="<%=path%>">回到主页</a>或<a href="<%=path%>/guest">以游客身份登录</a></h5>
                                              
                                     </div>
                                         
                                        
                                 
                                    <div class="space-block"></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4"></div>
                    </div>

                    <footer class="row box-small text-right" id="lms-login-footer">
                        Copyright © 2015 河南大学软件学院 · 【教学系统】
                    </footer>
                </div>

                <script src="<%=path%>/js/jquery.min.js"></script>
                <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
                <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
                <script src="<%=path%>/js/md5.js"></script>

                <script type="text/javascript">
                    $(document).ready(function() {
                        if(top.location!=self.location){
                            top.location = self.location;
                        }
                        var treeFrame = $(window).height();
                        var treeHeader = $("#lms-login-footer").height();
                        var treeBlank = $("#login-form").height();
                        var treeContent = treeFrame - treeHeader;
                        var treePosition = treeFrame - treeBlank;
                        //685*535
                        $("#login-form").css({
                            'marginTop': 0.05 * treePosition
                        });
                        $("#account").css({
                            'marginTop': 0.1 * treePosition,
                            'marginBottom': 0.1 * treePosition
                        });
                        $("#lms_login_banner").carousel('cycle');
                    });
                    $(window).resize(function() {
                        var treeFrame = $(window).height();
                        var treeHeader = $("#lms-login-footer").height();
                        var treeBlank = $("#login-form").height();
                        var treeContent = treeFrame - treeHeader;
                        var treePosition = treeFrame - treeBlank;
                        //685*535
                        $("#login-form").css({
                            'marginTop': 0.05 * treePosition
                        });
                        $("#account").css({
                            'marginTop': 0.5 * treePosition
                        });
                    });
                </script>
                <script>
                    $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random()); //随机生成验证码
                    $("#checkcodeText").val("");
                    //alert("2016-08-27缩减了权限分类，相应的，需要更新教师库权限值，请在点击登录按钮旁边【更新教师权限】，\n由于是更改数据库，只用执行一次即可，不必登录（或启动项目）每次都执行\n下次上传git会删除这个提示~");
                    function reload() {
                        $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random()); //随机生成验证码
                        $("#checkcodeText").val("");
                    }

                    //提交注册
                    function postsubmit() {
                        $("#yz")[0].innerHTML = "正在检查...请稍后...";
                        if ($.trim($("#firstname").val()) == "") {
                            $("#yz")[0].innerHTML = "学号/工号不能为空";
                            return false;
                        }
//                        if ($.trim($("#password").val()) == "") {
//                            $("#yz")[0].innerHTML = "密码不能为空";
//                            return false;
//                        }
                        if ($.trim($("#checkcodeText").val()) == "") {
                            $("#yz")[0].innerHTML = "验证码不能为空";
                            return false;
                        }
                        $("#yz")[0].innerHTML = "正在登录...请稍后...";
                        $.post("<%=path%>/logincheck", {
                                username: $("#firstname").val(),
                                password: hex_md5($("#password").val()),
                                ccd: $("#checkcodeText").val()
                            },
                            function(data) {
                                if (data == "CheckCodeError") {
                                    $("#yz")[0].innerHTML = "验证码错误，请重试。";
                                    reload();
                                };
                                if (data == "LoginError") {
                                    $("#yz")[0].innerHTML = "输入的账户错误，请重试。";
                                    reload();
                                    $("#password").val("")
                                };
                                if (data == "Loginok") {
                                    window.location.href = "<%=path%>/loginsuccess"
                                };
                            });
                        return false;
                    }
                    //验证码框响应回车键提交登录
                    function post2(e) {
                        var keynum;
                        if (window.event) // IE 
                        {
                            keynum = e.keyCode;
                        } else if (e.which) // Netscape/Firefox/Opera 
                        {
                            keynum = e.which;
                        }
                        if (keynum == 13) {
                            postsubmit();
                        }
                    }
                </script>
            </body>

            </html>
