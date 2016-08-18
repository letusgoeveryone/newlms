<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String sessionid = session.getId();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">

    <head>
        <meta charset="UTF-8">
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>教务系统 |　学生</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/lib/uploadify/uploadify.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <script src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/vue.js"></script>
        <script src="<%=path%>/js/md5.js" type="text/javascript"></script>
        <style>
            
        </style>
    </head>
    <body class="page-brand container-full" id="lms_stu">

        <!--aside -->
        <aside id="ubox" class="menu menu-right nav-drawer nav-drawer-md" >
            <div class="menu-scroll">
                <div class="menu-content">
                    <div class="menu-logo" href="javascript:void(0)">个人面板</div>
                    <div class="vcard">

                        <div class="vcard-avatar-wrapper">
                            <a href="/account" alt="Change your avatar" class="vcard-avatar">
                                <img alt="" class=" img-rounded" src="<%=path%>/images/avatar.jpg" height="230" width="230">
                            </a>
                        </div>
                        
                        <div class="vcard-names">
                            <p class="vcard-fullname" >{{name}}</p>
                            <p class="vcard-id" >ID: {{sn}} ( {{grade}}级 )</p>
                        </div>

                        <div class="user-profile-edit">
                            <a data-toggle="tab" href="#tab-personalInfo">编辑个人信息 <span class="icon">edit</span></a>

                        </div>

                        <ul class="vcard-details">
                            <li alt="Home location" class="vcard-detail" title="China">
                                <span class="icon">person_outline</span> {{college}}
                            </li>
                            <li alt="Email" class="vcard-detail">
                                <span class="icon">chat_bubble_outline</span> <b>扣扣:</b> {{qq}}
                            </li>
                            <li alt="Member since" class="vcard-detail ">
                                <span class="icon">exit_to_app</span>
                                <a class="" href="<%=path%>/logout"> 注销</a>
                            </li>
                        </ul>

                        <!--个人状态 O-->
                        <div class="vcard-stats">
                            <!--<h3 class="vcard-stat-heading">个人状态</h3>-->
<!--                            <a class="vcard-stat" href="javascript:void(0)">
                                <strong class="vcard-stat-count">63</strong>
                                <span class="text-muted">未完成作业</span>
                            </a>-->
                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-selected">
                                <strong class="vcard-stat-count">{{numOCourse}}</strong>
                                <span class="text-muted">已选课程</span>
                            </a>
                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-selectable">
                                <strong class="vcard-stat-count">{{numXCourse}}</strong>
                                <span class="text-muted">可选课程</span>
                            </a>
<!--                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-permit">
                                <strong class="vcard-stat-count">10</strong>
                                <span class="text-muted">已批准课程</span>
                            </a>-->
                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-notpermit">
                                <strong class="vcard-stat-count">{{numICourse}}</strong>
                                <span class="text-muted">待批准课程</span>
                            </a>
                        </div>
                        <!--个人状态 X-->

                    </div>
                </div>
            </div>
        </aside>

        <!--header-->
        <header class="header header-brand header-waterfall ui-header">
            <ul class="nav nav-list pull-left">
                <li>
                    <a href="javascript:void(0)">
                        <span class="icon icon-lg">home</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | 学生页面</span>
            <ul class="nav nav-list pull-right">
                <li>
                    <a data-toggle="menu" href="#usettings" id="anchor-menu" onclick="toggleUserSettings()">
                        <span class="icon icon-lg">settings</span>
                    </a>
                </li>
            </ul>
        </header>

        <!--content-->
        <div class="content clearfix clear" id="ucontent" style="min-height:2000px">
            <div class=" space-block"></div>
            <jsp:include page="../student/IncludeContent.jsp" />
        </div>
        
        <!--footer-->
        <footer class="ui-footer footer">
            <div class="container">
                <p>河南大学</p>
            </div>
        </footer>
    
        <div class="menu menu-left" id="usettings">
            <jsp:include page="../student/IncludeSetting.jsp" />
        </div>
    
        <div>
            <jsp:include page="../student/IncludeWidgets.jsp" />
        </div>
        
        <!--scrollUp-->
        <div class="fbtn-container" id="scrollUp" hidden>
            <div class="fbtn-inner">
                <a class="fbtn fbtn-brand waves-attach waves-circle">
                    <span class="fbtn-text fbtn-text-left">返回顶部</span>
                    <span class="fbtn-ori icon">keyboard_arrow_up</span>
                </a>
            </div>
        </div>



        <!-- js -->
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/lib/uploadify/jquery.uploadify.js" type="text/javascript"></script>
        <script src="<%=path%>/js/api.json.student.js" type="text/javascript"></script>
        <script src="<%=path%>/js/tinymce/tinymce.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
        <!--<script src="http://open.iciba.com/huaci/huaci.js"></script>-->
        <script>
            $(function () {
                $("#uploadify").uploadify({
                    'uploader': '<%=path%>/student/zyupload100.do;jsessionid=<%=sessionid%>?Func=uploadwallpaper2Dfs', //************ action **************
                    'height': 30,
                    'width': 120,
                    'buttonText': '选择文件',
                    'buttonCursor': 'hand',
                    'auto': false,
                    'multi': true,
                    'method': 'post       ',
                    'swf': '<%=path%>/lib/uploadify/uploadify.swf       ',
                    'cancelImg': '<%=path%>/lib/uploadify/uploadify-cancel.png',
                    'fileTypeExts': '*.docx;*.doc;*.xls;*.xlsx;*.ppt;*.pptx;*.zip;*.rar;*.7z;*.txt;', //指定文件格式
                    'fileSizeLimit': '50MB',
                    'fileObjName': 'myFile',
                    'progressData': 'speed',
                    'preventCaching': true,
                    'timeoutuploadLimit': 1,
                    'removeCompleted': true,
                    'removeTimeout': 1,
                    'requeueErrors': true,
                    'successTimeout': 30,
                    'uploadLimit': 5,
                    'onUploadStart': function () {
                        
                    },
                    'onUploadSuccess': function () {
                        refreshUploadedArea();
                    }

                });
            });
    </script>
    </body>
</html>