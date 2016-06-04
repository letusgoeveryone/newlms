<%-- 
    Document   : personal_Inf
    Created on : 2016-2-25, 19:29:38
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
    <link rel="stylesheet" href="<%=path%>/css/buttons.css">
<!--    <link rel="stylesheet" href="<%=path%>/css/navbar.css">-->
    <script src="<%=path%>/js/jquery.js"></script>
    <script src="<%=path%>/js/bootstrap.js"></script>
    <script src="<%=path%>/js/ie-emulation-modes-warning.js"></script><style type="text/css"></style>
     <script src="<%=path%>/js/ie10-viewport-bug-workaround.js"></script>

     <script>
          $(function () {
                        $.ajax({
                            type: "get", //提交方式
                            url: "../reg/hq_xy", //提交的页面，方法名
                            success: function (data) {
                                $("#szxy").empty();
                                for (var i = 0; i < data.length; i++) {
                                     $("#szxy").append("<option value='"+data[i]+"'>"+data[i]+"</option>");  
                                };  
                                 $("#szxy option[value="+${StudentCollege2}+"]").attr("selected", "true"); 
                                 
                            },
                            error: function () {
                                alert("error!！");
                            }
                        });
                         $.ajax({
                              type: "get", //提交方式
                              url: "../reg/fhnj", //提交的页面，方法名
                              success: function (data) {
                                  $("#fhnj").empty();
                                  for (var i = 0; i < data.length; i++) {
                                      $("#fhnj").append("<option value='"+data[i]+"'>"+data[i]+"</option>");  
                                  };
                                  $("#fhnj option[value='"+${StudentGrade}+"']").attr("selected","true"); 
                                  
                              },
                              error: function () {
                                  alert("error!！");
                              }
                          });
                   $("body input").blur(function(){
                    checkinf()
                    }); 
                   $("body select").blur(function(){
                    checkinf()
                    });
                    });
                   
            function saveinf() { 
               var result= checkinf();
               if(result==true){
                $.post("<%=path%>/student/resetinf_p", { name: $.trim($("#input2").val()), idcard:$.trim($("#input3").val()),
                    grade:$.trim($("#fhnj").val()),college: $.trim($("#szxy").val()),sex:$.trim($("#input4").val()),telnum:$.trim($("#input5").val()),qqnum:$.trim($("#input6").val())},
                    function(data){
                    if(data=="1"){alert("用户信息已修改！");window.location.reload()};
                 });	     
               }
           }
            function checkinf() { 
             $("#submas")[0].innerHTML="";
            if($.trim($("#input2").val())==""){$("#submas")[0].innerHTML="姓名不能为空";return false;}
            if($.trim($("#input3").val())==""){$("#submas")[0].innerHTML="身份证号码不能为空";return false;}
            if($.trim($("#fhnj").val())=="请选择" || $.trim($("#fhnj").val())==""){$("#submas")[0].innerHTML="年级选择不正确";return false;}
            if($.trim($("#szxy").val())=="请选择" || $.trim($("#szxy").val())==""){$("#submas")[0].innerHTML="学院选择不正确";return false;}
            if($.trim($("#input4").val())==""){$("#submas")[0].innerHTML="性别不能为空";return false;}
            if($.trim($("#input4").val())!="男" && $.trim($("#input4").val())!="女"){$("#submas")[0].innerHTML="性别填写错误";return false;}
            if($.trim($("#input5").val())==""){$("#submas")[0].innerHTML="手机号不能为空";return false;}
            if($.trim($("#input6").val())==""){$("#submas")[0].innerHTML="QQ号不能为空";return false;}
            var  r=/(^\d{15}$)|(^\d{17}([0-9]|X)$)/g;
            var flag=r.test($.trim($("#input3").val()));
            if(!flag){$("#submas")[0].innerHTML="身份证号码不符合要求";return false;}
            r=/^1\d{10}$/g;
            flag=r.test($.trim($("#input5").val()));
            if(!flag){$("#submas")[0].innerHTML="手机号不符合要求";return false;}
            r= /^[0-9]{6,12}$/;
            flag=r.test($.trim($("#input6").val()));
            if(!flag){$("#submas")[0].innerHTML="QQ号不符合要求";return false;}
            return true;
           }
           
     </script>
     <style type="text/css">
		body{	}
		.sidebar{width:15%;float:left;font-size: 100%;text-align:right;height:200px;line-height:45px}
                .main_content{width:79%;height: 350px;float:right;clear:right;line-height:12px}
                .button_sub{clear:right;text-align: center}
	</style>

    </head>  
<body>
        <div style="hight:870px;width:550px;margin:0 auto;margin-top: 20px">

    <div class="sidebar">
学号：<br>
姓名：<br>
身份证号：<br>
年级：<br>
学院：<br>
性别：<br>
手机号：<br>
QQ：<br>
</div>
<div class="main_content">
<input type="text" class="form-control" value="${StudentId}" class="span3" id="input1" disabled/><br>
<input type="text" class="form-control"  value="${StudentName}" class="span3"  id="input2"/><br>
<input type="text" class="form-control"  value="${StudentIdcard}" class="span3"  id="input3"/><br>
<select  class="form-control"  value="${StudentGrade}" id="fhnj" style="">
</select><br>
<select  class="form-control"  value="${StudentCollege}"  id="szxy" style="">
</select><br>
<input type="text"  class="form-control" value="${StudentSex}" class="span3"  id="input4"/><br>
<input type="text"  class="form-control" value="${StudentTel}" class="span3"  id="input5"/><br>
<input type="text"  class="form-control" value="${StudentQq}" class="span3"  id="input6"/><br>
</div>
<div class="button_sub">  
    <p><br>   <span  id="submas" style="text-align: center"> </span></p>
  
   
    <button class="btn btn-default"  type="button" onclick="saveinf()"> 保存修改 </button>
    <button class="btn btn-default"  type="button" onclick="location.href='<%=path%>/student/resetpw'"> 修改密码 </button>
 </div>

  </div>
</body>
</html>
