<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<%-- 
    Document   : functionManage
    Created on : 2016-3-12, 15:12:24
    Author     : Administrator
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>functionManage</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet"/>

        <!--JS-->
        <script src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/base.min.js"></script>
        <script src="<%=path%>/js/project.min.js"></script>
 <style type="text/css">
    #switches_div1{
        width: 68px;
        height: 40px;
        border-radius: 19px;
        position: relative;
    }
    #switches_div2{
        width: 38px;
        height: 37px;
        border-radius: 20px;
        position: absolute;
        background: white;
        box-shadow: 0px 2px 2px rgba(0,0,0,0.4);
    }
    .switches_open1{
        background: rgba(0,184,0,0.8);
    }
    .switches_open2{
        top: 2px;
        right: 1px;
    }
    .switches_close1{
        background: rgba(255,255,255,0.4);
        border:3px solid rgba(0,0,0,0.15);
        border-left: transparent;
    }
    .switches_close2{
        left: 0px;
        top: 0px;
        border:2px solid rgba(0,0,0,0.1);
    }
</style>
<script>

window.onload=function(){
        
        var div2=document.getElementById("switches_div2");
        var div1=document.getElementById("switches_div1");
        div2.onclick=function(){
          div1.className=(div1.className=="switches_close1")?"switches_open1":"switches_close1";
          div2.className=(div2.className=="switches_close2")?"switches_open2":"switches_close2";
        }
        
        $("#saveconfigure").click(function(){ 
                 $.post("<%=path%>/admin/saveconfigure", { AllTerm : $("#AllTerm").val(),AllGrade : $("#AllGrade").val() ,AllCollege :$("#AllCollege").val() ,
                     CurrentTerm : $("#CurrentTerm").val() ,FileFolder : $("#FileFolder").val() ,Selfverification :div1.className=="switches_open1"},
                function(data){
                    if(data=="0"){
                        alert("设置已更新\n\n");
                    }else{
                        alert("设置更新失败\n\n");
                    };
                 });
            });
    };

</script>
    </head>
    <body class="container">
        <div class="row-fluid">
            <div class="span12">
                <br /><br />
                <div style="float:right;">
                    <br />
                <a href="#" class="btn btn-default" id="saveconfigure">　保存设置　</a> <a href="#" class="btn btn-default" onClick="location.replace('FunctionManage')">　放弃保存　</a>
                </div>
                <br /><br /><br />
        <table class="table table-bordered table-responsive" data-search ="true"  data-striped = "true" data-pagination ="true" data-toggle="table" >
            <thead>
                <tr>
                    <td>参数</td>
                    <td>参数值</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>所有学期</td>
                    <td><input type="text" style="width:700px;" class="form-control" value="${AllTerm}" id="AllTerm"></td>
                </tr>
                <tr>
                    <td>所有学年</td>
                    <td><input type="text" style="width:700px;" class="form-control" value="${AllGrade}" id="AllGrade"></td>
                </tr>    
                <tr>
                    <td>所有学院</td>
                    <td><textarea name="a" style="width:700px;height:130px;" class="form-control" id="AllCollege">${AllCollege}</textarea></td>
                </tr>   
                <tr>
                    <td>当前学期</td>
                    <td><input type="text" style="width:700px;" class="form-control" value="${CurrentTerm}" id="CurrentTerm"></td>
                </tr>  
                <tr>
                    <td>附件目录</td>
                    <td><input type="text" style="width:700px;" class="form-control" value="${FileFolder}" id="FileFolder"><br>注意：在这里配置好后还需要去手动同步配置tomcat的配置文件，设置虚拟目录。</td>
                </tr> 
            </tbody>
        </table>
        <table class="table table-bordered table-responsive" data-search ="true"  data-striped = "true" data-pagination ="true" data-toggle="table" >
            <thead>
                <tr>
                    <td>功能选择</td>
                    <td>　状态</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>注册完成自助验证<br>开启后，新用户注册后能自助在现在选课系统验证信息后直接从临时库进入正式库。</td>
                    <td>
                     <div id="switches_div1" class="switches_open1">
                        <div id="switches_div2" class="switches_open2"></div>
                    </div>
                    </td>
                </tr>
              
            </tbody>
        </table>
           修改完毕记得点右上角保存啊~     
            </div>
        </div>
    </body>
</html>
