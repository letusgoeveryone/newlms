<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PersonalInfo</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css"/>
        <!--JS-->
        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/bootstrap.js" type="text/javascript"></script>
        <style>
            .form-control:focus, .picker__select--month:focus, .picker__select--year:focus {
                border-bottom-width: 1px;
            }
            .card-action-btn {
                margin: 1em 1em 1em 0;
            }
            .form-horizontal .control-label {
                text-align: left;
            }
        </style>
    </head>
    <body class='container stage-box height-control' >

        <div class="card height-control" style="padding: 1em 1em 1em 0px;">
            <div class="card-main" >
                <div class="container">

                    <div class="col-md-6" style="border-right: 1px dashed rgb(215, 215, 215);">
                        <div class="card-header">
                            个人信息
                        </div>
                        <form class="form-horizontal from-wrap-sm" role="form" >
                            <div class="form-group">

                                <label for="sn" class="col-sm-3  control-label">工号:</label>
                                <div class="col-sm-6 ">
                                    <input type="text" class="form-control" name="sn" id="sn" placeholder="正在读取..." value="${sn}" disabled>
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="name" class="col-sm-3  control-label">姓名:</label>
                                <div class="col-sm-6 ">
                                    <input type="text" class="form-control" id="name" name="name"  placeholder="正在读取..." value="${name}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="idCard" class="col-sm-3  control-label">身份证号:</label>
                                <div class="col-sm-6 ">
                                    <input type="text" class="form-control" id="idCard" name="idCard"  placeholder="正在读取..." value="${idCard}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="qq" class="col-sm-3  control-label">QQ:</label>
                                <div class="col-sm-6 ">
                                    <input type="text" class="form-control" id ="qq" name="qq" placeholder="正在读取..." value="${qq}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="tel" class="col-sm-3  control-label">电话:</label>
                                <div class="col-sm-6 ">
                                    <input type="text" class="form-control" id="tel" name="tel" placeholder="正在读取..." value="${tel}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="college" class="col-sm-3  control-label">院系:</label>
                                <div class="col-sm-6 ">
                                    <input type="text" class="form-control" id="college" name="college" placeholder="正在读取..." value="${college}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="zc" class="col-sm-3  control-label">职称:</label>
                                <div class="col-sm-6 ">
                                    <input type="text" class="form-control" id="zc" name="zc" placeholder="正在读取..." value="${zc}" disabled>
                                </div>

                            </div>
                            <div class="form-group">

                                <label class="col-sm-3  control-label"></label>
                                <div class="col-sm-6">
                                    <button class="btn btn-default form-control hidden" id ="update" type="button" >保存修改</button>
                                </div>

                            </div>
                        </form>

                        <div class="card-action">
                            <div class="card-action-btn">
                                <button class="btn btn-default" id ="update" type="button">保存修改</button>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-6">
                        <div class="card-header">
                            个人密码
                        </div>
                        <form class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="col-sm-3  control-label">原密码:</label>
                                <div class="col-sm-6 ">
                                    <input type="password" class="form-control" id="inputPassword1" placeholder="请输入您的旧密码">
                                </div>

                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label">新密码:</label>
                                <div class="col-sm-6 ">
                                    <input type="password" class="form-control" id="inputPassword2" placeholder="请输入您的新密码">
                                </div>

                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"></label>
                                <div class="col-sm-6 ">
                                    <input type="password" class="form-control" id="inputPassword3" placeholder="确认您的新密码">
                                </div>

                            </div>
                            <div class="form-group">

                                <label class="col-sm-3  control-label"></label>
                                <div class="col-sm-6 ">
                                    <button class="btn btn-default saves form-control hidden" id ="update" type="button" hidden="">保存修改</button>
                                    <label  id="submas"></label>
                                </div>

                            </div>

                        </form>

                        <div class="card-action">
                            <div class="card-action-btn">
                                <button class="btn btn-default saves" id ="update" type="button">保存修改</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            //修改密码
            $(".saves").click(function () {

                if ($("#inputPassword1").val() === "") {
                    $("#submas")[0].innerHTML = "原密码不能为空！";
                    return false;
                }
                if ($("#inputPassword2").val() !== $("#inputPassword3").val()) {
                    $("#submas")[0].innerHTML = "两次输入的新密码不一致！";
                    alert($("#inputPassword2").val() + "|" + $("#inputPassword3").val())
                    $("#inputPassword3").val("");
                    return false;
                }

                var r = /^[a-z A-Z 0-9 _]{6,18}$/;
                var flag = r.test($("#inputPassword2").val());
                if (!flag) {
                    $("#submas")[0].innerHTML = "新密码不符合要求（6到18位），是不是太简单了?";
                    return false;
                }

                $.post("<%=path%>/acdemic/resetpw_p", {pw: hex_md5($("#inputPassword1").val()), repw: hex_md5($("#inputPassword2").val())},
                        function (data) {
                            if (data == "1") {
                                $("#submas")[0].innerHTML = "您输入的原密码不正确。";
                                $("#inputPassword1").val("");
                            }
                            ;
                            if (data == "2") {
                                $("#submas")[0].innerHTML = "新密码与原密码一致。";
                                $("#inputPassword2").val("");
                                $("#inputPassword2").val("");
                                $("#inputPassword3").val("");
                            }
                            ;
                            if (data == "3") {
                                alert("ok,您的密码已经修改成功，您需要重新登录。");
                                window.parent.frames.location.href = "../logout" //使外部框架跳到登出 让用户重新登录
                            }
                            ;
                        });

            });

            //修改个人信息
            $("#update").click(function () {
                $.ajax({
                    type: "post",
                    url: '<%=path%>/acdemic/updatetea',
                    data: {idCard: $("#idCard").val(), name: $("#name").val(), qq: $("#qq").val(), tel: $("#tel").val()},
                    success: function (data) {
                        if (data === "0") {
                            alert("个人资料更新成功!");
                        }
                    }
                });
            });
        </script>


    </body>
</html>
