<%-- 
    Document   : resetpw
    Created on : 2016-2-26, 11:35:18
    Author     : 刘昱
--%>
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
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
    <script src="<%=path%>/js/jquery.js"></script>
    <script src="<%=path%>/js/bootstrap.js"></script>
    <script  src="<%=path%>/js/md5.js"></script>


     <script>
        $(function () { 
             $("#subclick").click(function(){   
               
                if($("#pw1").val()==""){
                        $("#submas")[0].innerHTML="原密码不能为空！";
                        return false;
                }
                if($("#pw2").val()!=$("#pw3").val()){
                        $("#submas")[0].innerHTML="两次输入的新密码不一致！";
                        $("#pw3").val("");
                        return false;
                }
                
                var  r=/^[a-z A-Z 0-9 _]{6,18}$/;
                var flag=r.test($("#pw2").val());
                if(!flag){
                   $("#submas")[0].innerHTML="新密码不符合要求（6到18位），是不是太简单了?";
                   return false;
                }

                $.post("<%=path%>/student/resetpw_p", { pw: hex_md5($("#pw1").val()), repw:hex_md5($("#pw2").val()) },
                function(data){
                    if(data=="1"){$("#submas")[0].innerHTML="您输入的原密码不正确。";$("#pw1").val("");};
                    if(data=="2"){$("#submas")[0].innerHTML="新密码与原密码一致。";$("#pw2").val("");$("#pw2").val("");};
                    if(data=="3"){alert("ok,您的密码已经修改成功，您需要重新登录。");
                    window.parent.frames.location.href="../logout" //使外部框架跳到登出 让用户重新登录
                    };
                 });	       
            });
               
           $("#pw3").blur(function(){
              if($("#pw2").val()!=$("#pw3").val()){
                     $("#submas")[0].innerHTML="两次输入的新密码不一致！";
              }else{
                    $("#submas")[0].innerHTML="";
              }
         });
                    });
     </script>
     <style type="text/css">
		.sidebar{width:15%;float:left;font-size: 100%;text-align:right;height:170px;line-height:45px}
                .main_content{width:79%;height: 170px;float:right;clear:right;line-height:12px}
                .button_sub{clear:right;text-align: center}
	</style>

    </head>  
<body>
     <div style="hight:900px;width:550px;margin:0 auto;margin-top: 130px">
    <div class="sidebar">
        旧密码：<br>
        新密码：<br>
        请确认：<br>
    </div>
     <div class="main_content">
        <input type="password"  class="form-control" value="" class="span3" id="pw1"/><br>
        <input type="password" class="form-control"  value="" class="span3" id="pw2"/><br>
        <input type="password"  class="form-control" value="" class="span3" id="pw3"/><br>
        <span  id="submas" style="text-align: center"> </span>
    </div>
    <div class="button_sub">
        <button class="btn btn-default" type="button" id="subclick"> 保存密码 </button>
        <button class="btn btn-default" type="button" onclick="location.href='<%=path%>/student/personal_Inf'"> 返回个人信息 </button>
    </div>
 </div>
</body>
</html>
