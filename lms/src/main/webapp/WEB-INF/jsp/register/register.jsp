<%-- 
    Document   : index
    Created on : 2014-7-31, 13:51:43
    Author     : wht
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>河南大学软件学院教务教学系统 注册</title>
        <!--<link href="../css/bootstrap.min.css" rel="stylesheet">-->
        <link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/cupertino/easyui.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/lms.css"/>

        <script  src="<%=path%>/js/easyui/jquery.min.js"></script>
        <script  src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
        <!--<script src="<%=path%>/js/bootstrap.min.js"></script>-->
        <%--<s:head theme="ajax"/>--%>

        <style>
            html,body{
                font: 62.5% "Trebuchet MS", sans-serif;
                margin: 50px;
                text-align:center;
            }
            #note {color: #ff0000;
                   text-align: center;}
            #chooserole {text-align:center}
            .center { margin: 0 auto; }
        </style>
    </head>
    <body class="easyui-layout">

        <div id="header" data-options="region:'north'" ></div>

        <div  id="body" data-options="region:'center'" style="padding:4%" >
            <div class="container" style="min-width: 580px;min-height:200px">
                <div id="title">
                    <p id="note">请选择您的身份注册 <br/></p>

                    <div id="chooserole">
                        <input type="radio" name="role" id="roleteacher" value="teacher"/><label for="roleteacher">教工</label>
                        <input type="radio" name="role" id="rolestudent" checked="checked" value="student"/><label for="rolestudent">学生</label>
                    </div>
                    <div style="margin-bottom:20px"></div>
                </div>
                <div id="registerInfo" class="center"></div>
            </div>
            <div >
                <div style="margin-bottom:20px"></div>
            </div>
            <div id="copyright">&copy; 河南大学软件学院 版权所有</div>
        </div>

        <script>
            function checkst() {
                var isCheckedStudent = $('input:radio[name="role"]:checked').val() === "student";
//                    var isChecked = $('input:radio[id="student"]').is(":checked");

                if (isCheckedStudent) {
//                    alert("student");
                    $("#registerInfo").load("<%=path%>/reg/register_Student_step");
//                         $("#registerInfo").load("s1.jsp");
                } else {
//                    alert("teacher");
//                        $("#registerInfo").load("../newjsp.jsp");
                    $("#registerInfo").load("<%=path%>/reg/register_Teacher_step");
                }

            }
            $(function () {
                //判断选中的是学生还是老师，然后调取不同的注册页面
                checkst();
                //当signupFrom中选项发生变化时，调取不同的页面
                $("#chooserole").change(checkst);
            });
        </script>
    </body>
</html>
