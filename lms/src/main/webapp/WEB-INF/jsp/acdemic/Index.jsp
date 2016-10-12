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
<html lang="zh-cn">
    <head>
        <meta charset="UTF-8">
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>『教务员』| 教务系统</title>

        <link href="<%=path%>/css/nprogress.css" rel="stylesheet" />
        <script src="<%=path%>/js/nprogress.js"  ></script><script>NProgress.start();</script>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <style>
            
            .l-btn{
                border-radius: 0px !important;
            }
            
            .lms-admin-return{
                color: #fff;
                background-color: #444;
                border-radius: 0px;
                text-align: left;
                width: 100%;
                padding: 1em 2.5em;
                font-size: 1.2em;
                display: block;
            }
            
            .textbox{
                border-radius: 0px;
            }
            
            #scrollUp {
                position: absolute;
                left: -150px;
                bottom: 0;
            }
            
        </style>
        <script>NProgress.set(0.1);</script>   
        <script src="<%=path%>/js/jquery.min.js"></script> 
        <link rel="stylesheet"  href="<%=path%>/js/jquery.easyui/themes/bootstrap/easyui.css">
        <link rel="stylesheet"  href="<%=path%>/js/jquery.easyui/themes/icon.css">
        <script>NProgress.set(0.3);</script>   
          
    </head>
    <body class="page-default tab-content" id='lms_acdemic'>

        <header class="header header-brand header-waterfall ui-header">

            <ul class="nav nav-list pull-left">
                <li>
                    <a href="<%=path%>/login">
                        <span class="icon icon-lg">home</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | 校务员页面</span>

            <ul class="nav nav-list pull-right">

                <li class="dropdown">
                    <a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown" >
                        <span class="access-hide">Avatar</span>
                        <span class="avatar avatar-sm"><img alt="avatar" src="<%=path%>/images/${avatar}.svg"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li class="">
                            <a class="waves-attach waves-effect" href="<%=path%>/logout">
                                <span class="icon mg-sm-right">exit_to_app</span> 登出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>                  
        </header>
        
        <!--教务员 主区 -->
        <div id="lms_main"  class="tab-pane fade in active">
            
            <!--功能列表-->
            <nav class="lms-admin-sidebar">
            <ul class="nav nav-tabs">
                
                <sec:authorize access="hasRole('ROLE_TEACHER') or hasRole('ROLE_DEAN')">
                    <a href="login" class="lms-admin-return">
                        返回
                    </a>
                </sec:authorize>
                
                <hr>
                <li class="active">
                    <a href="#panel-gradeInfoManage" data-toggle="tab">班级信息管理</a>
                </li>
                <li>
                    <a href="#panel-courseInfoManage" data-toggle="tab" >课程信息管理</a>
                </li>
                <li>
                    <a href="#panel-courseTableManage" data-toggle="tab" >课程表管理</a>
                </li>
                <hr>
                <li>
                    <a href="#panel-TeacherManage" data-toggle="tab" >教师信息管理</a>
                </li>
                <li>
                    <a href="#panel-StudentManage" data-toggle="tab" >学生信息管理</a>
                </li>
                <hr>
                <li>
                    <a href="#panel-tmpTeacherManage" data-toggle="tab" >教师信息管理【临时】</a>
                </li>
                <li>
                    <a href="#panel-tmpStudentManage" data-toggle="tab" >学生信息管理【临时】</a>
                </li>
                <hr>
                
            </ul>
            </nav>

            <!--功能区-->
            <div class="tab-content lms-admin-content">
                
                <div class="tab-pane fade" id="panel-tmpStudentManage">
                    <jsp:include page="szxsxx.jsp"  />
                </div>
                <div class="tab-pane fade" id="panel-StudentManage">
                    <jsp:include page="zs_stu.jsp"  />
                </div>
                <div class="tab-pane fade" id="panel-tmpTeacherManage">
                    <jsp:include page="szlsjsxx.jsp"  />
                </div>
                <div class="tab-pane fade" id="panel-TeacherManage">
                    <jsp:include page="zs_js.jsp"  />
                </div>
                <div class="tab-pane fade in active" id="panel-gradeInfoManage">
                    <jsp:include page="ckbjxx.jsp"  />
                </div>
                <div class="tab-pane fade" id="panel-courseInfoManage">
                    <jsp:include page="course.jsp"  />
                </div>
                <div class="tab-pane fade" id="panel-courseTableManage">
                    <jsp:include page="set_all.jsp"  />
                </div>
                
            </div>
            
        </div>
        <!--教务员 主区 END-->  
        
        <!--返回顶部-->
        <div class="fbtn-container">

            <div class="fbtn-inner" id="scrollUp">
                <a class="fbtn fbtn-lg fbtn-trans waves-attach waves-circle waves-light waves-effect" ><span class="fbtn-ori icon">keyboard_arrow_up</span><span class="fbtn-text fbtn-text-left">返回顶部</span></a>
            </div>
            <div class="fbtn-inner">
                <a class="fbtn fbtn-lg btn-gold waves-attach waves-circle waves-light" data-toggle="dropdown"><span class="fbtn-ori icon">apps</span><span class="fbtn-sub icon">close</span></a>
                <div class="fbtn-dropup">
                    <a class="fbtn fbtn-brand waves-attach waves-circle stage-card" href="acdemic/pinfo"><span class="fbtn-text fbtn-text-left">点击查看/修改个人信息</span><span class="icon">account_circle</span></a>
                    <a class="fbtn fbtn-red waves-attach waves-circle waves-light" href="<%=path%>/us" target="_blank"><span class="fbtn-text fbtn-text-left">关于我们</span><span class="icon">all_inclusive</span></a>
                    <a class="fbtn fbtn-trans waves-attach waves-circle" href="#" ><span class="fbtn-text fbtn-text-left">关于系统</span><span class="icon">information</span></a>
                </div>
            </div>
        </div>
        <script>NProgress.set(0.7);</script>   
        
        <!-- js -->
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.fs.core.js" type="text/javascript"></script>
        <script src="<%=path%>/js/formstone/js/transition.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.fs.boxer.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/configure.js"></script>
        <script>NProgress.set(0.8);</script>   


        <!--easyui-->
        <script src="<%=path%>/js/jquery.easyui/jquery.easyui.min.js"></script>
        <script src="<%=path%>/js/jquery.easyui/plugins/jquery.datagrid.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.easyui/src/jquery.resizable.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.easyui/src/jquery.linkbutton.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.easyui/plugins/jquery.panel.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.easyui/plugins/jquery.pagination.js" type="text/javascript"></script>
        <script>NProgress.set(0.9);</script>   
        
        <!--uploadify-->
        <script src="<%=path%>/js/jquery.uploadify.min.js"></script>

        <script>
            $('.stage-card').lightbox();
        </script>
        <script>
            newbjxx();
            $('[href="#panel-gradeInfoManage"]').click(function(){
                setTimeout(newbjxx,500);
            });
            $('[href="#panel-courseInfoManage"]').click(function(){
                setTimeout(newkcxx,500);
            });
            $('[href="#panel-courseTableManage"]').click(function(){
                setTimeout(newkcbxx,500);
            });

            $('[href="#panel-tmpTeacherManage"]').click(function(){
                setTimeout(newlsjs,500);
            });
            $('[href="#panel-tmpStudentManage"]').click(function(){
                setTimeout(newlsxs,500);
            });
            $('[href="#panel-TeacherManage"]').click(function(){
                setTimeout(newzsjs,500);
            });
            $('[href="#panel-StudentManage"]').click(function(){
                setTimeout(newzsxs,500);
            });
        </script>
        <script>NProgress.done();</script>       
    </body>  
</html>
