<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String sessionid = session.getId();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>河大学软院教务系统</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css" />
        <!-- <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet"> -->
        <style media="screen">
            html, body {
                height: 100%;
                width: 100%;
                overflow:hidden;
                color:#FFF;
                padding:0 15px;
            }
            #course-nav{
                border-right: 1px solid whitesmoke;
                /*background-image: url(<%=path%>/images/banner-1.jpg);*/
                background-color:#489887;
            }
            #fix-001{
                margin: 1em;
                font-size: 16px;
                padding-top: 20px;
                border-bottom: 1px solid whitesmoke;
                padding-bottom: 15px;
                font-weight: 700;
                min-width:200px;
            }
            #course-list{
                padding:15px;
                display:block;
            }
            #course-list li{
                padding:0em 30px;
                margin:auto -31px;
            }
            #course-list li:hover{
                background-color: #2D685B;
            }
            #course-list li a{
                display:block;
                padding: 0.5em .5em;
                color:#FFF;
                font-size: 12px;
            }
            #course-content{
                margin-left: -25px;
                position: relative;
                right: -43.9px;
            }
            #f_reg_btn_grp{
                position: absolute;
                left: 0;
                right: 0;
                bottom: 0;
            }
            #f_reg_btn_grp>div{
                width: 50%;
                float: left;
                margin: 0;
            }
            #f_reg_btn_grp>div>a{
                display: block;
                text-align: center;
                background-color: whitesmoke;
                padding: 1em;
                border-radius:0;
                color:#2D685B;
            }
            #f_reg_btn_grp>div>a:hover{
                background-color: #59a999;
                transition: all 0.3s;
                color:#fff;
            }
            .card {
                box-shadow: 0 -1px 0 #489887,0 0 2px rgba(39, 39, 39, 0.1),0 2px 4px rgba(0,0,0,.24);
                padding-bottom:20px;
            }
        </style>
    </head>


    <body id="lms-guest" class="height-control stage-image" style="background-image:url(<%=path%>/images/bg-for-role.jpg)">

        <header>
            
        </header>
        <div id="lms_guest_cview" class="container height-control">
            <div class="row height-control width-control card">
                <nav class="col-md-3  stage-image" id="course-nav" >
                     <!--data-toggle="collapse" data-target="#course-list" collapse in-->
                    <div class="page-header">
                        <div class="center-block" id="fix-001">课程列表<span class="pull-right"> = </span></div>
                    </div>
                    <ul  id="course-list" class="course-list ">
                        ${Courselist}
                    </ul>
                    <div id="f_reg_btn_grp" class="btn-group-justified">
                        <div><a href="<%=path%>/reg/student_teacher" class="btn btn-flat  waves-attach waves-light waves-effect">注册</a> </div>
                        <div><a href="<%=path%>/login" class="btn btn-flat waves-attach waves-light waves-effect">登录</a> </div>
                    </div>
                </nav>
                <div class="col-md-9 width-control " id="course-content">
                    <iframe src="${firstpage}" id="iframepage" frameborder="0" scrolling="yes" marginheight="0"  height="100%" width="100%" name="content"></iframe>
                </div>

            </div>
        </div>
        <!--  主页 结束--> 
        <!--  主页页尾 开始 -0->
        <footer class="ui-footer" id="tree-footer">
            <div class="container">
                <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
            </div>
        </footer>
        <!--  主页页尾 结束 --> 
        <!-- 背景 顶部 --> 
        <script src="<%=path%>/js/jquery.min.js"></script> 
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
    </body>
</html>
