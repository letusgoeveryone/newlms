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
                <meta name="keywords" content="河南大学,教务系统,登陆界面" />
                <meta name="description" content="河南大学教务系统登陆界面" />
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
                <div class="container-fuild scroll-y hidden-x" style="height: inherit;padding: 0;">

                    <div class="row">

                        <div class="col-md-4"></div>
                        <div class="col-md-4" id="form-frame">

                            <div style="padding:10vh 2em 2em;"></div>
                            <div class="row card" id="lms_login_wrap">
                                <div id="login-form" class="height-control">

                                    <div id="login_content" class="tab-content ">

                                        <!--登陆 TAB 页-->
                                        <div class="tab-pane fade in active" id="login">
                                            <form class="form-horizontal" role="form" action="index.html" method="post">

                                                <!--学号/工号-->
                                                <div class="form-group form-group-label">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <label class="floating-label" for="id">ID号</label>
                                                            <input type="text" class="form-control" id="id" name="id" placeholder="请输入学生证号/教职工号">
                                                        </div>
                                                    </div>
                                                    <span id="idMsg" class="text-error"></span>
                                                </div>

                                                <!--密码-->
                                                <div class="form-group form-group-label">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <label class="floating-label" for="pw">密码</label>
                                                            <input type="password" class="form-control" id="pw" name="pw" placeholder="请输入密码">
                                                        </div>
                                                    </div>
                                                    <span id="pwMsg" class="text-error"></span>
                                                </div>

                                                <!--验证码-->
                                                <div class="form-group form-group-label">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <label class="floating-label" for="ccd">验证码：</label>
                                                            <input type="text" class="form-control" id="ccd" name="ccd" placeholder="请输入右侧的验证码" onkeydown="keyListener(event)">
                                                            <span class="ccd-image" >
                                                                <img id="ccdImage" title="看不清楚请单击图片" onclick="updateCcdImage()" >
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <span id="ccdMsg" class="text-error"></span>
                                                </div>

                                                <!--                                            
                                                <div class="form-group">
                                                    <div class="checkbox">
                                                        <label class="pull-left "><input type="checkbox"  />请记住我</label>
                                                        <label class="pull-right" ><a class="btn-forget" href="#">【忘记密码】</a></label>
                                                    </div>
                                                </div>
                                                -->

                                                <span id="loginMsg"  class="text-error"></span>
                                                <br>

                                                <div class="form-group">
                                                    <div type="submit" class="btn-brand btn-card btn-success btn-block" onclick="login()">登录</div>
                                                </div>
                                                <br>

                                                <div class="form-group">
                                                    <div class="">
                                                        <a href="#account" data-toggle="tab" class="btn-link text-grey pull-left">没有帐号？注册一个</a> 
                                                        <a href="<%=path%>/guest" class="btn-link text-grey pull-right">进入游客区</a>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                        <!--注册 TAB 页-->
                                        <div class="tab-pane fade " id="account">
                                            <form class="form-horizontal">

                                                <div class="form-group">
                                                    <div type="submit" class="btn-brand btn-card btn-success btn-block" onclick="window.location.href = '<%=path%>/reg/teacher'">我是老师 </div>
                                                </div>
                                                <div class="form-group">
                                                    <div type="submit" class="btn-brand btn-card btn-success btn-block" onclick="window.location.href = '<%=path%>/reg/student'">我是学生 </div>
                                                </div>

                                                <div class="form-group">
                                                    <a href="#login" data-toggle="tab" class="btn btn-flat pull-right">返回登录 </a>
                                                </div>
                                            </form>
                                        </div>

                                    </div>  
                                    <div class="space-block"></div>
                                    
                                </div>
                            </div>
                            <div style="padding:10vh 2em 2em;"></div>
                        </div>
                        <div class="col-md-4"></div>
                    </div>

                    <footer class="row box-small text-right" id="lms-login-footer">
                        Copyright © 2015 河南大学软件学院 · 【教学系统】
                    </footer>
                </div>
                                                    
                <!--js-->                                    
                <script src="<%=path%>/js/jquery.min.js"></script>
                <script src="<%=path%>/js/base.min.js"></script>
                <script src="<%=path%>/js/project.min.js"></script>
                <script src="<%=path%>/js/md5.js"></script>

                <script>
                    
                    $(document).ready(function() {
                        if(top.location!==self.location){
                            top.location = self.location;
                        }
                        var treeFrame = $(window).height();
                        var treeHeader = $("#lms-login-footer").height();
                        var treeBlank = $("#login-form").height();
                        var treeContent = treeFrame - treeHeader;
                        var treePosition = treeFrame - treeBlank;
                        
                        $("#login-form").css({
                            'marginTop': 0.05 * treePosition
                        });
                        $("#account").css({
                            'marginTop': 0.1 * treePosition,
                            'marginBottom': 0.1 * treePosition
                        });
                    });
                    
                    $(window).resize(function() {
                        var treeFrame = $(window).height();
                        var treeHeader = $("#lms-login-footer").height();
                        var treeBlank = $("#login-form").height();
                        var treeContent = treeFrame - treeHeader;
                        var treePosition = treeFrame - treeBlank;
                        
                        $("#login-form").css({
                            'marginTop': 0.05 * treePosition
                        });
                        $("#account").css({
                            'marginTop': 0.5 * treePosition
                        });
                    });
                    
                    function getRootPath() {
                        return '<%=path%>';
                    };
                    
                    function isInfoNull(){
                        var status = false;
                        
                        if($('#id').val() !== ''){ status = true;}
                        if($('#pw').val() !== ''){ status = true;}
                        
                        return true;
                    }
                    
                    //验证码框响应回车键提交登录
                    function keyListener(e) {
                        var keynum;
                        var status = false;
                        
                        if (window.event){ keynum = e.keyCode; } else if (e.which){  keynum = e.which; }
                        if (keynum === 13) {
                            
                            if(isInfoNull()&&verifyText('ccd', 'ccdMsg')){
                                status = true;
                            }else
                                status = false;

                            if(status === true){
                                $("#loginMsg").html("正在登录...请稍后...");
                                $.post(

                                    "<%=path%>/logincheck", {
                                        username: $("#id").val(),
                                        password: hex_md5($("#pw").val()),
                                        ccd: $("#ccd").val()
                                    },

                                    function(data) {
                                        if (data === "LoginError") {
                                            $("#loginMsg").html("输入的账户错误，请重试...");
                                            $("#pw").val("");
                                            updateCcdImage();
                                        };
                                        if (data === "Loginok") {
                                            $("#loginMsg").html("登录成功!");
                                            window.location.href = "<%=path%>/loginsuccess";
                                        };
                                    }
                                );
                            }
                        }
                    };
                    
                    function login() {
                        var status = false;
                        
                        if(isInfoNull()&&verifyText('ccd', 'ccdMsg')){
                            status = true;
                        }else
                            status = false;
                        
                        if(status === true){
                            $("#loginMsg").html("正在登录...请稍后...");
                            $.post(
                                    
                                "<%=path%>/logincheck", {
                                    username: $("#id").val(),
                                    password: hex_md5($("#pw").val()),
                                    ccd: $("#ccd").val()
                                },
                                        
                                function(data) {
                                    if (data === "LoginError") {
                                        $("#loginMsg").html("输入的账户错误，请重试...");
                                        $("#pw").val("");
                                        updateCcdImage();
                                    };
                                    if (data === "Loginok") {
                                        $("#loginMsg").html("登录成功!");
                                        window.location.href = "<%=path%>/loginsuccess";
                                    };
                                }
                            );
                        }
                        
                    };
                    
                </script>
                <script src="<%=path%>/js/api.common.js"></script>
                <script>
                    updateCcdImage();
                </script>
            </body>

            </html>
