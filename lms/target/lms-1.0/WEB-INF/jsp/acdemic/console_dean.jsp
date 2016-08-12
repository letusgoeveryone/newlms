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
        <title>教务系统 | 校务员</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" />
        
        <script src="<%=path%>/js/jquery.min.js"></script>
          
    </head>
    <body class="page-default tab-content" id='lms_acdemic'>
      
        <!--管理员 副区 教务区 -->
        <div id="lms_main"  class="tab-pane fade in active">
            
            <!--功能列表-->
            <nav class="lms-admin-sidebar">
            <ul class="nav nav-tabs">
                <div style="
                   color: #fff;
                   background-color: #444;
                   border-radius: 0px;
                   text-align: left;
                   width: 100%;
                   padding: 1em;
                   font-size: 1.2em;
                   ">
                   校务员（控制台）
                </div>
                <div class="stage-box"></div>
                
                
                <li class="active">
                    <a href="#panel-gradeInfoManage" data-toggle="tab" onclick="newbjxx()">班级信息管理</a>
                </li>
                <li>
                    <a href="#panel-courseInfoManage" data-toggle="tab" onclick="newkcxx()">课程信息管理</a>
                </li>
                <li>
                    <a href="#panel-courseTableManage" data-toggle="tab" onclick="newkcbxx()">课程表管理</a>
                </li>
                <hr>
                <li>
                    <a href="#panel-TeacherManage" data-toggle="tab" onclick="newzsjs()">教师信息管理</a>
                </li>
                <li>
                    <a href="#panel-StudentManage" data-toggle="tab" onclick="newzsxs()">学生信息管理</a>
                </li>
                <hr>
                <li>
                    <a href="#panel-tmpTeacherManage" data-toggle="tab" onclick="newlsjs()">教师信息管理【临时】</a>
                </li>
                <li>
                    <a href="#panel-tmpStudentManage" data-toggle="tab" onclick="newlsxs()">学生信息管理【临时】</a>
                </li>
                <hr>
                <li>
                    <a class="waves-attach waves-light waves-effect"  href="<%=path%>/logout">退出系统<span class="icon icon-fixHans margin-left-sm">exit_to_app</span></a>
                </li>
            </ul>
            </nav>

            <!--功能区-->
            <div class="tab-content lms-admin-content">
                
                <div class="tab-pane fade in active" id="panel-tmpStudentManage">
                    <jsp:include page="szxsxx.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-StudentManage">
                    <jsp:include page="zs_stu.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-tmpTeacherManage">
                    <jsp:include page="szlsjsxx.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-TeacherManage">
                    <jsp:include page="zs_js.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-gradeInfoManage">
                    <jsp:include page="ckbjxx.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-courseInfoManage">
                    <jsp:include page="course.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-courseTableManage">
                    <jsp:include page="set_all.jsp"  />
                </div>
                
            </div>
            
        </div>
        <!--管理员 副区 教务区 END-->  
        
        <!--返回顶部-->
        <div class="fbtn-container">

            <div class="fbtn-inner" id="scrollUp">
                <a class="fbtn fbtn-lg fbtn-trans waves-attach waves-circle waves-light waves-effect" ><span class="fbtn-ori icon">keyboard_arrow_up</span><span class="fbtn-text fbtn-text-left">返回顶部</span></a>
            </div>
            <div class="fbtn-inner">
                <a class="fbtn fbtn-lg btn-gold waves-attach waves-circle waves-light" data-toggle="dropdown"><span class="fbtn-ori icon">apps</span><span class="fbtn-sub icon">close</span></a>
                <div class="fbtn-dropup">
                    <a class="fbtn fbtn-brand waves-attach waves-circle stage-card" href="http:<%=path%>/student/teapnda"><span class="fbtn-text fbtn-text-left">点击查看/修改个人信息</span><span class="icon">account_circle</span></a>
                    <a class="fbtn fbtn-red waves-attach waves-circle waves-light" href="<%=path%>/us" target="_blank"><span class="fbtn-text fbtn-text-left">关于我们</span><span class="icon">all_inclusive</span></a>
                    <a class="fbtn fbtn-trans waves-attach waves-circle" href="#" ><span class="fbtn-text fbtn-text-left">关于系统</span><span class="icon">information</span></a>
                </div>
            </div>
        </div>
        
    <!-- js -->
    <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
    <script>
        var Stickup= 0;
    </script>
    <script src="<%=path%>/js/configure.js" type="text/javascript"></script>

    <!--easyui-->
    <script src="<%=path%>/js/jquery.easyui.min.js"></script>
    <link rel="stylesheet"  href="<%=path%>/css/easyuicss/easyui.css">
    <link rel="stylesheet"  href="<%=path%>/css/easyuicss/icon.css">
    <link rel="image/png"  href="<%=path%>/css/easyuicss/images/tree_icons.png">
    
    <!--uploadify-->
    <script src="<%=path%>/js/jquery.uploadify.min.js"></script>


        <script type="text/javascript">
        var browserVersion = window.navigator.userAgent.toUpperCase();
        var isOpera = false, isFireFox = false, isChrome = false, isSafari = false, isIE = false;
        function reinitIframe(iframeId, minHeight) {
            try {
                var iframe = document.getElementById(iframeId);
                var bHeight = 0;
                if (isChrome == false && isSafari == false)
                    bHeight = iframe.contentWindow.document.body.scrollHeight;
                var dHeight = 0;
                if (isFireFox == true)
                    dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                else if (isIE == false && isOpera == false)
                    dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                else if (isIE == true && !-[1, ] == false) {
                } //ie9+
                else
                    bHeight += 3;
                var height = Math.max(bHeight, dHeight);
                if (height < minHeight)
                    height = minHeight;
                iframe.style.height = height + "px";
            } catch (ex) {
            }
        }
        function startInit(iframeId, minHeight) {
            isOpera = browserVersion.indexOf("OPERA") > -1 ? true : false;
            isFireFox = browserVersion.indexOf("FIREFOX") > -1 ? true : false;
            isChrome = browserVersion.indexOf("CHROME") > -1 ? true : false;
            isSafari = browserVersion.indexOf("SAFARI") > -1 ? true : false;
            if (!!window.ActiveXObject || "ActiveXObject" in window)
                isIE = true;
            window.setInterval("reinitIframe('" + iframeId + "'," + minHeight + ")", 100);
        }

        function iFrameHeight() {
                //var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument;   
                //if(ifm != null && subWeb != null) {
                //   ifm.height = subWeb.body.scrollHeight;
                //   ifm.width = subWeb.body.scrollWidth;
                //}   
        }   
    </script>      
    </body>  
</html>
