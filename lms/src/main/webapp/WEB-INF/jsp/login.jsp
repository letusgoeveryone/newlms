<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
                <title>登录</title>
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
                        min-width: 320px;
                        max-width: 390px;
                        margin: auto;
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

                            <div style="padding:3.5em 2.5em 1.5em;">
                                <!--<img src="images/logo-white.png" class="" alt="" style="margin:auto;display: block;" />-->
                            </div>

                            <div class="row card" id="lms_login_wrap">
                                <div id="login-form" class="height-control">

                                    <div class="tabbable tabs-right">
                                        <!-- Only required for left/right tabs -->
                                        <div id="login_content" class="tab-content ">

                                            <div class="tab-pane fade in active" id="login">
                                                <form class="form-horizontal" role="form" action="index.html" method="post">

                                                    <div class="form-group form-group-label">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <label class="floating-label" for="IDNum">ID号</label>
                                                                <input type="text" class="form-control" id="firstname" name="IDNum" placeholder="请输入学生证号或教职工号"></div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group form-group-label">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <label class="floating-label" for="Password">密码</label>
                                                                <input type="password" class="form-control" id="password" name="Password" placeholder="请输入密码">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group form-group-label">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <label class="floating-label" for="ccd">验证码：</label>

                                                                <input type="text" class="form-control" id="checkcodeText" name="ccd" placeholder="请输入右侧的验证码" onkeydown="post2(event)">
                                                            </div>
                                                        </div><span class="pull-right" style="position: relative;bottom: 25px; z-index: 1000; cursor:pointer;"><img id="ccdImage" style="border:0;" title="看不清楚请单击图片" onclick="reload()" ></span>
                                                    </div>

                                                    <br>
                                                    <span id="yz" class="text-danger">${requestScope.Error}</span>
                                                    <!--                                            <div class="form-group">
                                                <div class="checkbox">
                                                    <label class="pull-left "><input type="checkbox"  />请记住我</label>
                                                    <label class="pull-right" ><a class="btn-forget" href="#">【忘记密码】</a></label>
                                                </div>
                                            </div>-->
                                                    <br>
                                                    <div class="form-group">
                                                        <div type="submit" class="btn-brand btn-card btn-success btn-block" onclick="postsubmit()">登录</div>
                                                    </div>
                                                    <br>
                                                    <div class="form-group">
                                                        <div class=""><a href="#account" data-toggle="tab" class="btn-link text-grey pull-left">没有帐号？注册一个</a> <a href="<%=path%>/reg/guest" class="btn-link text-grey pull-right">进入游客区</a></div>

                                                    </div>
                                                </form>
                                            </div>
                                            <div class="tab-pane fade " id="account">
                                                <form class="form-horizontal" role="form" action="index.html" method="post">

                                                    <div class="form-group">
                                                        <div type="submit" class="btn-brand btn-card btn-success btn-block" onclick="window.location.href = '<%=path%>/reg/teacher_register'">我是老师 </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div type="submit" class="btn-brand btn-card btn-success btn-block" onclick="window.location.href = '<%=path%>/reg/student_register'">我是学生 </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <a href="#login" data-toggle="tab" class="btn btn-flat pull-right">返回登录 </a>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="stage-box"></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4"></div>
                    </div>

                    <footer class="row box-small text-right" id="lms-login-footer">
                        Copyright © 2015 河南大学软件学院 · 【教学系统】
                    </footer>
                </div>
                <!--        <div id="lms_login_bg_f">
            <canvas id="lms_login_cnv"></canvas>
            <img src="<%=path%>/images/bg-star.jpg" id="lms_login_bg"/>
        </div>-->
                <script src="<%=path%>/js/jquery.min.js"></script>
                <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
                <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
                <script src="<%=path%>/js/md5.js"></script>

                <script type="text/javascript">
                    $(document).ready(function() {

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
                        if ($.trim($("#password").val()) == "") {
                            $("#yz")[0].innerHTML = "密码不能为空";
                            return false;
                        }
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
