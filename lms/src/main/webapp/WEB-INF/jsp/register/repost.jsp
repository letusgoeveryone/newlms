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
        <title>注册</title>
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
                overflow: hidden !important;
            }
            .row-scroll{
                overflow-y: scroll;
                height: inherit;
            }
            .form_dash-border{
                border: 1px dashed rgb(222, 222, 222);
                padding: 1em;
                margin: 1em 0px;
            }
            .card-main{
                padding: 3em 4em 4em 3em;
            }
            .ul-mg-minus{
                margin-left: -15px;
            }
        </style>
    </head>

    <body class="stage-image container-full" style="background-image:url(<%=path%>/images/bg-for-role.jpg)" id="lms_login">
        <div class="row row-scroll">    
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="pd-sapce-top"></div>
                <div class="row card">
                    <div class="card-main">
                        <ul>
                            <h2 class="ul-mg-minus">信息验证出现问题 !</h2>
                            <h5>可能原因:</h5>
                            <li>注册信息存在虚假内容 <a href="<%=path%>/reg/role" title="点击,重新注册~~">&CircleDot;_&CircleDot; 请重新注册</a></li>
                            <li class="form_dash-border">
                                您更改过自己的<a class="text-wiki" data-toggle="modal" href="#wiki_digital-school"> 数字校园 </a>密码
                                <!-- 密码 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="pw">密码：</label>
                                            <input type="password" placeholder="更改后的密码" id="pwd" class="form-control" >

                                        </div>
                                    </div>
                                    <span id="passwFristMsg" class="text-error"></span>
                                </div>
                                <!-- 验证码 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="ccd">验证码：</label>

                                            <input id="ccd" name="ccd" class="form-control" type="text" maxlength="4"  
                                                   data-options="required:true,validType:'chk_code',missingMessage:'请输入验证码',tipPosition:'left' "
                                                   title="验证码区分不大小写，看不清楚请单击图片" >
                                            <span class="pull-right"  style="position: relative;bottom: 25px; z-index: 1000; cursor:pointer;"><img id="ccdImage" style="border:0" title="看不清楚请单击图片" onclick="updateCheckCode()" ></span>

                                        </div>
                                    </div>
                                    <span id="checkcodeMsg" class="text-error"></span>
                                </div>
                                
                                <button id="submit" class="btn btn-aqua">点击继续</button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
            <!--模态框-->

            <div class="modal fade" id="wiki_digital-school" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-heading">
                            数字校园
                        </div>
                        <div class="modal-inner">
                            <p class="h5">
                                数字校园即为您在图书馆蹭WIFi，或者在寝室用校园网拨号的密码。<br />
                            </p>
                        </div>
                        <div class="modal-footer">
                            <p class="text-right">
                                <a class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal">我知道了</a>
                            </p>
                        </div>
                    </div>
                </div>
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
            function updateCheckCode() {
                $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random()); //随机生成验证码
            }
            function getSn(SN){
                var sn = (SN===undefined ? '${sn}' : SN);
                return sn;
            }
            window.onload = function () {
                var sn = getSn(${sn});
                if(sn === ''){
                    alert("Unknow Error !");
                    window.location.href = "<%=path%>/logout";
                    return 0;
                }
                $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random()); //随机生成验证码
                $("#submit").click(function () {
                    $.post(
                            "<%=path%>/reg/tmp_attestation_repost", 
                            {
                                sn: getSn(),
                                pwd: $("#pwd").val(), 
                                ccd: $("#ccd").val()
                            },
                            function (data) {
                                if (data === "认证成功") {
                                    alert("Success！账号已能正常登录！");
                                    location.href = "<%=path%>";
                                } else {
                                    alert("Fail! 错误信息：\n" + data);
                                    updateCheckCode();
                                }
                            });
                });
            };
        </script>
    </body>
</html>
