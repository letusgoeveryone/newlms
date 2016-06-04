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
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/buttons.css">
<!--        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>-->
        <script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/bootstrap-table.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap-table.css">
        <script  src="<%=path%>/js/md5.js"></script>
<!--        <link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/icon.css">-->
        <script type="text/javascript" src="<%=path%>/easyui/jquery.min.js"></script>
        <script type="text/javascript" src="<%=path%>/easyui/jquery.easyui.min.js"></script>
    </head>
    <body style="background-color:rgba(0,0,0,0);" >
        <h2 class="text-primary" style="color: white">个人资料</h2>
 
        
             

        <form class="form-horizontal" role="form">
            <div class="form-group">
                <div class='col-sm-2'></div>
                <label for="inputEmail3" class="col-sm-2 control-label">工号:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="sn" placeholder="正在读取..." value="${sn}" disabled>
                </div>
                <div class="col-sm-7"></div>
            </div>
            <div class="form-group">
                <div class='col-sm-2'></div>
                <label for="inputEmail3" class="col-sm-2 control-label">姓名:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="name"  placeholder="正在读取..." value="${name}">
                </div>
                <div class="col-sm-7"></div>
            </div>
            <div class="form-group">
                <div class='col-sm-2'></div>
                <label for="inputEmail3" class="col-sm-2 control-label">身份证号:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="idCard"  placeholder="正在读取..." value="${idCard}">
                </div>
                <div class="col-sm-7"></div>
            </div>
            <div class="form-group">
                <div class='col-sm-2'></div>
                <label for="inputEmail3" class="col-sm-2 control-label">QQ:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id ="qq" placeholder="正在读取..." value="${qq}">
                </div>
                <div class="col-sm-7"></div>
            </div>
            <div class="form-group">
                <div class='col-sm-2'></div>
                <label for="inputEmail3" class="col-sm-2 control-label">电话:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="tel" placeholder="正在读取..." value="${tel}">
                </div>
                <div class="col-sm-7"></div>
            </div>
            <div class="form-group">
                <div class='col-sm-2'></div>
                <label for="inputEmail3" class="col-sm-2 control-label">院系:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="tel" placeholder="正在读取..." value="${college}">
                </div>
                <div class="col-sm-7"></div>
            </div>
            <div class="form-group">
                <div class='col-sm-2'></div>
                <label for="inputEmail3" class="col-sm-2 control-label">　职称:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="tel" placeholder="正在读取..." value="${zc}" disabled>
                </div>
                <div class="col-sm-7"></div>
            </div>
            <div class="form-group" style="padding-left: 45%">
                   
                <div class="col-sm-5">
                    <button class="btn btn-default" id ="update" type="button">保存修改</button>
                    <button class="btn btn-default" data-toggle="modal" data-target="#mymodal"  type="button">修改密码</button>
                </div>
            </div>
        </form>
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
                                <label for="inputEmail3" class="col-sm-2 control-label" >旧密码</label>
                                <div class="col-sm-3">
                                    <input type="password" class="form-control" style="width: 200px" id="inputPassword1" placeholder="请输入您的旧密码">
                                </div>
                                <div class="col-sm-7"></div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-2 control-label" >新密码</label>
                                <div class="col-sm-3">
                                    <input type="password" class="form-control" style="width: 200px"  id="inputPassword2" placeholder="请输入您的新密码">
                                </div>
                                <div class="col-sm-7"></div>
                            </div>
                                <div class="form-group">
                                <label for="inputEmail3" class="col-sm-2 control-label">确认密码</label>
                                <div class="col-sm-3">
                                    <input type="password" class="form-control"  style="width: 200px" id="inputPassword3" placeholder="确认您的新密码">
                                </div>
                                <div class="col-sm-7"></div>
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

                $.post("<%=path%>/teacher/resetpw_p", { pw: hex_md5($("#inputPassword1").val()), repw:hex_md5($("#inputPassword2").val()) },
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
                        url:'<%=path%>/teacher/updatetea', 
                        data:{idCard:$("#idCard").val(), name:$("#name").val(), qq:$("#qq").val(), tel:$("#tel").val() },
                        success:function(data){
                            if(data==="0"){alert("个人资料更新成功!");}
                         }
                     });          
                 });
        </script>
        
    
    </body>
</html>
