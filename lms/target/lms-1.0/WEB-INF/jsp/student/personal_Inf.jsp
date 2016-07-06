<%-- 
    Document   : teapnda
    Created on : 2016-4-25, 19:48:59
    Author     : Name : liubingxu Email : 2727826327qq.com
--%>
<%
//    将项目的根取出来，页面中不再使用相对路径
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
        <title>teapnda</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/images/tree_icons.png"> 
        <!--JS-->
        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/bootstrap.js" type="text/javascript"></script>
        <style>
            .form-control:focus, .picker__select--month:focus, .picker__select--year:focus {
                border-bottom-width: 1px;
            }
        </style>
    </head>
    <body class='container stage-box height-control' >
 
        <div class="card height-control">
            <div class="col-md-12" >
                <div class="card-main">
                    <div class="card-header">
                        个人信息
                        <div class="card-inner">  </div>
                    </div>
                    <div class="card-inner">

                        <form class="form-horizontal from-wrap-sm" role="form" >
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">学号:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="sn" placeholder="正在读取..." value="${StudentId}" disabled>
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">姓名:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="name"  placeholder="正在读取..." value="${StudentName}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">身份证号:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="idCard"  placeholder="正在读取..." value="${StudentIdcard}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">性别:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id ="sex" placeholder="正在读取..." value="${StudentSex}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">QQ:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id ="qq" placeholder="正在读取..." value="${StudentQq}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">电话:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="tel" placeholder="正在读取..." value="${StudentTel}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">院系:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="college" placeholder="正在读取..." value="${StudentCollege}" disabled>
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="grade" class="col-md-6 control-label">班级:</label>
                                <div class="col-md-6" >
                                    <select class="form-control"  value="${StudentGrade}" id="grade" name="grade"></select>
                                </div>

                            </div>
                                
                            <div class="form-group">

                                <label  id="MessageOfUpdateStuInfo" class="col-md-12"> </label>

                            </div>
                                
                        </form>
                    </div>
                    <div class="card-action">
                        <div class="card-action-btn">
                            <button class="btn btn-default" id ="update" type="button">保存修改</button>
                            <button class="btn btn-default" data-toggle="modal" data-target="#mymodal"  type="button">修改密码</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
             

        <div class="modal fade"  id="mymodal" >
            <div class="modal-dialog" >
                <div class="modal-content" >
                    <!-- 模态弹出窗内容 -->
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">修改密码</h4>
                    </div>
                    <div class="modal-body">

                        <form class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-6 control-label">旧密码</label>
                                <div class="col-md-6">
                                    <input type="password" class="form-control" id="OldPassword" placeholder="请输入您的旧密码">
                                </div>
                                 
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-6 control-label">新密码</label>
                                <div class="col-md-6">
                                    <input type="password" class="form-control" id="NewPasswordLast" placeholder="请输入您的新密码">
                                </div>
                                 
                            </div>
                                <div class="form-group">
                                <label for="inputEmail3" class="col-md-6 control-label">确认密码</label>
                                <div class="col-md-6">
                                    <input type="password" class="form-control" id="inputPassword3" placeholder="确认您的新密码">
                                </div>
                                 
                            </div>
                            <label  id="submas"> </label>
                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary saves">保存</button>
                    </div>

                </div>
            </div>
        </div>
                

        <script>
            $.ajax({
                type: "get", //提交方式
                url: "../reg/fhnj", //提交的页面，方法名
                success: function (data) {
                    $("#grade").empty();
                    for (var i = 0; i < data.length; i++) {
                        $("#grade").append("<option value='" + data[i] + "'>" + data[i] + "</option>");
                    }
                    ;
                    $("#grade option[value='" +${StudentGrade} + "']").attr("selected", "true");

                },
                error: function () {
                    alert("error!！");
                }
            });
            //修改密码
            $(".saves").click(function(){
                
                if($("#OldPassword").val() == ""){
                $("#submas")[0].innerHTML="原密码不能为空！";
                        return false;
                }
                if($("#NewPasswordLast").val() !== $("#inputPassword3").val()){
                        $("#submas")[0].innerHTML="两次输入的新密码不一致！";
                        alert($("#NewPasswordLast").val()+"|"+$("#inputPassword3").val())
                        $("#inputPassword3").val("");
                        return false;
                }
                
                var  r=/^[a-z A-Z 0-9 _]{6,18}$/;
                var flag=r.test($("#NewPasswordLast").val());
                if(!flag){
                   $("#submas")[0].innerHTML="新密码不符合要求（6到18位），是不是太简单了?";
                   return false;
                }

                $.post("<%=path%>/acdemic/resetpw_p", { pw: hex_md5($("#OldPassword").val()), repw:hex_md5($("#NewPasswordLast").val()) },
                function(data){
                    if(data=="1"){$("#submas")[0].innerHTML="您输入的原密码不正确。";$("#OldPassword").val("");};
                    if(data=="2"){$("#submas")[0].innerHTML="新密码与原密码一致。";$("#NewPasswordLast").val("");$("#NewPasswordLast").val("");$("#inputPassword3").val("");};
                    if(data=="3"){alert("ok,您的密码已经修改成功，您需要重新登录。");
                    window.parent.frames.location.href="../logout" //使外部框架跳到登出 让用户重新登录
                    };
                 }); 
                 
            })
            
             //修改个人信息
                 $("#update").click(function(){
                        var result = checkinf();
                        if (result === true) {
                            $.post("<%=path%>/student/resetinf_p", {name: $.trim($("#name").val()), idcard: $.trim($("#idCard").val()),
                                grade: $.trim($("#grade").val()), college: $.trim($("#college").val()), sex: $.trim($("#sex").val()), telnum: $.trim($("#tel").val()), qqnum: $.trim($("#qq").val())},
                            function (data) {
                                if (data == "1") {
                                    alert("用户信息已修改！");
                                    window.location.reload()
                                }
                                ;
                            });
                        }         
                 });
                 function checkinf() {
                    $("#submas")[0].innerHTML = "";
                    if ($.trim($("#name").val()) == "") {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "姓名不能为空";
                        return false;
                    }
                    if ($.trim($("#idCard").val()) == "") {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "身份证号码不能为空";
                        return false;
                    }
                    if ($.trim($("#college").val()) == "请选择" || $.trim($("#college").val()) == "") {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "年级选择不正确";
                        return false;
                    }
                    if ($.trim($("#grade").val()) == "请选择" || $.trim($("#grade").val()) == "") {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "学院选择不正确";
                        return false;
                    }
                    if ($.trim($("#sex").val()) == "") {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "性别不能为空";
                        return false;
                    }
                    if ($.trim($("#sex").val()) != "男" && $.trim($("#sex").val()) != "女") {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "性别填写错误";
                        return false;
                    }
                    if ($.trim($("#tel").val()) == "") {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "手机号不能为空";
                        return false;
                    }
                    if ($.trim($("#qq").val()) == "") {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "QQ号不能为空";
                        return false;
                    }
                    var r = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/g;
                    var flag = r.test($.trim($("#idCard").val()));
                    if (!flag) {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "身份证号码不符合要求";
                        return false;
                    }
                    r = /^1\d{10}$/g;
                    flag = r.test($.trim($("#tel").val()));
                    if (!flag) {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "手机号不符合要求";
                        return false;
                    }
                    r = /^[0-9]{6,12}$/;
                    flag = r.test($.trim($("#qq").val()));
                    if (!flag) {
                        $("#MessageOfUpdateStuInfo")[0].innerHTML = "QQ号不符合要求";
                        return false;
                    }
                    return true;
                }
        </script>
        
    
    </body>
</html>
