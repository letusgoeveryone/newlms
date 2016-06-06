<%-- 
    Document   : console_dean
    Created on : 2016-4-25, 12:00:28
    Author     : Name : liubingxu Email : 2727826327qq.com
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
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
    <title>我的主页-教务员页面</title>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
        <script type="text/javascript" src="<%=path%>/easyui/jquery.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/easyui/jquery.easyui.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/easyui/demo/demo.css">
  
    <!-- css -->
    <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css"/>
     <!-- js -->
    <script src="<%=path%>/js/jquery.scrollUp.min.js"></script>
    <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
       
      
    <script language="javascript" type="text/javascript">
       
    </script>
</head>
<body class="page-default">
    
    <div class="content">
        
        <div class="content-header ui-content-header">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-8 ">
                        <h1 class="content-heading">个人中心</h1>
                        <div class="space-block"></div>
                    </div>
                </div>
            </div>
        </div>
        
<header class="header header-transparent header-waterfall ui-header navbar-wrapper" id="tree-header">
    <div class="container">
        <div class="row" >
             <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <a class="header-logo " href="admin">管理员页面</a>
             </sec:authorize>
             <sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                    <a class="header-logo " href="dean">院长页面</a>
             </sec:authorize>
             <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <a class="header-logo " href="teacherIndex">教师页面</a>
             </sec:authorize>
            <nav class="tab-nav tab-nav-gold pull-right hidden-xx ui-tab" id="zdytab">
                <ul class="nav nav-list">
                    <li  class="active"><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#ui_tab_example_pInfo"><span class="text-white">个人资料</span></a></li>
                    <li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#ui_tab_example_class"><span class="text-white">信息管理</span></a></li>
                    <li><a class="waves-attach waves-light waves-effect"  href="<%=path%>/logout"><span class="text-white">退出系统</span></a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>
        
<div class="tab-content" style="padding-left: 100px">
    <div class="row tab-pane fade active in" id="ui_tab_example_pInfo">       
        <div class="col-md-12"> 
             <iframe src="<%=path%>/acdemic/teapnda" iframepage" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="pInfocontent"></iframe>
        </div>
    </div>

    <div class="row tab-pane fade" id="ui_tab_example_class" style="min-height: 500px;">                                                     
               
        
        
                    <div class="container-fluid">
                        <div class="row-fluid">
                                <div class="span12">
                                        <div class="tabbable tabs-left" id="tabs-606390">
                                                <ul class="nav nav-tabs">
                                                        <li class="active">
                                                            <a href="#panel-654307" data-toggle="tab" onclick="newlsxs()">临时学生信息管理</a>
                                                        </li>
                                                        <li>
                                                            <a href="#panel-298358" data-toggle="tab" onclick="newzsxs()">正式学生信息管理</a>
                                                        </li>
                                                         <li>
                                                             <a href="#panel-298359" data-toggle="tab" onclick="newlsjs()">临时教师信息管理</a>
                                                        </li>
                                                        <li>
                                                            <a href="#panel-298360" data-toggle="tab" onclick="newzsjs()">正式教师信息管理</a>
                                                        </li>
                                                        <li>
                                                            <a href="#panel-298361" data-toggle="tab" onclick="newbjxx()">班级信息管理</a>
                                                        </li>
                                                        <li>
                                                            <a href="#panel-298362" data-toggle="tab" onclick="newkcxx()">课程信息管理</a>
                                                        </li>
                                                        <li>
                                                            <a href="#panel-298363" data-toggle="tab" onclick="newkcbxx()">课程表管理</a>
                                                        </li>
                                                </ul>
                                                <div class="tab-content">
                                                        <div class="tab-pane active" id="panel-654307">
                                                                <p>
                                                                       <jsp:include page="szxsxx.jsp"  />
                                                                </p>
                                                        </div>
                                                        <div class="tab-pane" id="panel-298358">
                                                                <p>
                                                                        <jsp:include page="zs_stu.jsp"  />
                                                                </p>
                                                        </div>
                                                         <div class="tab-pane" id="panel-298359">
                                                                <p>
                                                                        <jsp:include page="szlsjsxx.jsp"  />
                                                                </p>
                                                        </div>
                                                         <div class="tab-pane" id="panel-298360">
                                                                <p>
                                                                        <jsp:include page="zs_js.jsp"  />
                                                                </p>
                                                        </div>
                                                         <div class="tab-pane" id="panel-298361">
                                                                <p>
                                                                        <jsp:include page="ckbjxx.jsp"  />
                                                                </p>
                                                        </div>
                                                         <div class="tab-pane" id="panel-298362">
                                                                <p>
                                                                        <jsp:include page="course.jsp"  />
                                                                </p>
                                                        </div>
                                                        <div class="tab-pane" id="panel-298363">
                                                                <p>
                                                                        <jsp:include page="set_all.jsp"  />
                                                                </p>
                                                        </div>
                                                </div>
                                        </div>
                                </div>
                        </div>
                </div>
        

    </div>
</div>

    
    <footer class="ui-footer" id="tree-footer">
        <div class="container">
            <p >
                <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
            </p>
        </div>
    </footer>

    <div class="fbtn-container" id="scrollUp">
        <div class="fbtn-inner">
            <a class="fbtn fbtn-lg fbtn-brand waves-attach waves-circle waves-light waves-effect" >T<span class="fbtn-text fbtn-text-left">返回顶部</span></a>
        </div>
    </div>
        
   
</body>
</html>
