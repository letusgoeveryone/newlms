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

                                <label for="inputEmail3" class="col-md-6 control-label">工号:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="sn" placeholder="正在读取..." value="${sn}" disabled>
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">姓名:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="name"  placeholder="正在读取..." value="${name}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">身份证号:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="idCard"  placeholder="正在读取..." value="${idCard}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">QQ:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id ="qq" placeholder="正在读取..." value="${qq}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">电话:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="tel" placeholder="正在读取..." value="${tel}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">院系:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="tel" placeholder="正在读取..." value="${college}">
                                </div>

                            </div>
                            <div class="form-group">

                                <label for="inputEmail3" class="col-md-6 control-label">职称:</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" id="tel" placeholder="正在读取..." value="${zc}" disabled>
                                </div>

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
                                    <input type="password" class="form-control" id="inputPassword1" placeholder="请输入您的旧密码">
                                </div>
                                 
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-6 control-label">新密码</label>
                                <div class="col-md-6">
                                    <input type="password" class="form-control" id="inputPassword2" placeholder="请输入您的新密码">
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
            //修改密码
            $(".saves").click(function(){
                
                if($("#inputPassword1").val() == ""){
                $("#submas")[0].innerHTML="原密码不能为空！";
                        return false;
                }
                if($("#inputPassword2").val() !== $("#inputPassword3").val()){
                        $("#submas")[0].innerHTML="两次输入的新密码不一致！";
                        alert($("#inputPassword2").val()+"|"+$("#inputPassword3").val())
                        $("#inputPassword3").val("");
                        return false;
                }
                
                var  r=/^[a-z A-Z 0-9 _]{6,18}$/;
                var flag=r.test($("#inputPassword2").val());
                if(!flag){
                   $("#submas")[0].innerHTML="新密码不符合要求（6到18位），是不是太简单了?";
                   return false;
                }

                $.post("<%=path%>/acdemic/resetpw_p", { pw: hex_md5($("#inputPassword1").val()), repw:hex_md5($("#inputPassword2").val()) },
                function(data){
                    if(data=="1"){$("#submas")[0].innerHTML="您输入的原密码不正确。";$("#inputPassword1").val("");};
                    if(data=="2"){$("#submas")[0].innerHTML="新密码与原密码一致。";$("#inputPassword2").val("");$("#inputPassword2").val("");$("#inputPassword3").val("");};
                    if(data=="3"){alert("ok,您的密码已经修改成功，您需要重新登录。");
                    window.parent.frames.location.href="../logout" //使外部框架跳到登出 让用户重新登录
                    };
                 }); 
                 
            })
            
             //修改个人信息
                 $("#update").click(function(){
                      $.ajax({
                        type:"post",
                        url:'<%=path%>/acdemic/updatetea', 
                        data:{idCard:$("#idCard").val(), name:$("#name").val(), qq:$("#qq").val(), tel:$("#tel").val() },
                        success:function(data){
                            if(data==="0"){alert("个人资料更新成功!");}
                         }
                     });          
                 });
        </script>
        
    
    </body>
</html>
