<%-- 
    Document   : console_dean
    Created on : 2016-4-25, 12:00:28
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
        <title>管理员</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" />
        <link href="<%=path%>/css/uploadify.css" rel="stylesheet"  />
        <link href="<%=path%>/css/umeditor.min.css"  rel="stylesheet">
        
        <script src="<%=path%>/js/jquery.min.js"></script>



        <style>
            .content-header{
                background-color: #3F51B5 !important;
                padding-top: 24px;
                padding-bottom:  24px;
            }
            .content-header h1{
                font-size: 36px;
                color: #000;
            }
            #lms_admin header{
                background-color: #333;
            }
            #lms_admin .btn{
                min-width: 100px;
            }
            #lms_admin .card-side .btn-golden{
                display: block;
                max-width: 150px;
                margin-top: 15px;
            }
            #lms_admin .tab-content{
                min-height: 1000px;
            }
            #lms_admin_tnav_pInfo{
                padding-top: 120px;
            }
            /******************************************************************/
            #lms_admin_t,
            #lms_admin_d{
                margin: 0;
                padding: 200px 0;
            }
            #lms_admin_t .bg-content,
            #lms_admin_d .bg-content{
                position: absolute;
                background-color: #333;
                top: 0;
                left: 0;
                right: 0;
                height: 450px;
            }
            #lms_admin_tnav,
            #lms_admin_dnav{
                position: absolute;
                top: -55px;
                width: 100%;
                padding: 0;
                left: 0;
            }
            #lms_admin_tnav div,
            .lms-control-list div{
                display: inline-block;
            }
            #lms_admin_tnav select{
                height: 36px;
            }
            .dropdown.open .dropdown-menu {
                opacity: 1;
                -webkit-transform: scale(1,1);
                transform: scale(1,1);
                width: 600px;
                left: -496px;
            }
            .dropdown>ul{
                position: absolute;
                left: 0;
            }
            .tree-node{
                z-index: 1000;
                position: relative;
            }
            .dropdown>ul>li>ul{
                padding-left: 100px;
                position: relative;
                top:-20px;
                color: #888;
            }
            .dropdown>ul>li:hover{
                cursor: pointer;
            }
            .dropdown>ul>li>ul>li:hover{
                cursor: pointer;
            }
            .text-golden{
                color:goldenrod ;
            }
            .text-golden:hover{
                color:gold ;
            }
            /******************************************************************/
            .img-left{
                position: relative;
                left: -65%;
            }
            .img-right{
                position: relative;
                right:  0;
            }
            #lms_admin_d{
                padding-top: 210px;
            }
            #lms_admin_dbtn .img-left,
            #lms_admin_dbtn .img-right{
                height: 120px;
                min-height: 100%;
            }
            #lms_admin_d .modal-content{
                width: 520px;
                margin: auto;
                margin-top: 210px;
            }
            #lms_admin_d .btn-brand{
                background-color: transparent;
            }
            .small {
                color: grey;
                font-size: 0.8em;
            }
        </style>
    </head>
    <body class="page-default tab-content" id='lms_admin'>
        
        <!--管理员 主区-->
        <div id='lms_admin_main' class="tab-pane fade in active">

            <!--            
            <div class="content-header ui-content-header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12 ">
                            <h1 class="content-heading">管理员</h1>
                            <div class="space-block"></div>
                        </div>
                    </div>
                </div>
            </div>
            -->

            <header class="header " id="tree-header">
                <nav class="tab-nav tab-nav-gold hidden-xx ui-tab">
                    <ul class="nav nav-list">
                        <li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_admin_tnav_class"><span class="text-white">信息管理</span></a></li>
                        <li  class="active"><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_admin_tnav_pInfo"><span class="text-white">个人面板</span></a></li>
                        <li class="" style="position:absolute;right: 0;"><a class="waves-attach waves-light waves-effect"  href="<%=path%>/logout"><span class="text-white">退出系统<span class="icon margin-left-sm">exit_to_app</span></span></a></li>
                    </ul>
                </nav>
            </header>

            <div class="container tab-content">
                <div class="row tab-pane fade in active" id="lms_admin_tnav_pInfo">
                    
                    <!-- 角色转换 -->
                    <div class="col-md-12"> 
                        <div class="card">
                            
                            <aside class="card-side pull-left">
                                    <sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                                        <a  href="#" class='fbtn fbtn-lg  btn-golden'>
                                        D<span class="fbtn-text fbtn-text-left">我的角色：院长</span>
                                        </a>
                                    </sec:authorize>
                            </aside>
                            <div class="card-main">
                                <div class="card-inner">
                                    <section class="card-heading">角色转换【院长】到</section>
                                    <section>
                                        <sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                                            <a  data-toggle="tab" href="#lms_admin_d" class='btn btn-brand  waves-attach  waves-light waves-effect' style="margin:auto;">
                                               【A 管理员】
                                            </a>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                                            <a  data-toggle="tab" href="#lms_admin_a" class='btn btn-brand waves-attach  waves-light waves-effect' >
                                               【A 教务员】
                                            </a>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                                            <a  data-toggle="tab" href="#lms_admin_t" class='btn btn-brand waves-attach  waves-light waves-effect' style="margin:auto;">
                                               【T 教职】
                                            </a>
                                        </sec:authorize>
                                    </section>
                                </div>
                                <div class="card-action">
                                    <div class="card-action-btn" style="margin:6px 16px;">
                                        <a href="http:<%=path%>/../acdemic/teapnda" class="btn btn-flat lms-c-text-light stage-card waves-attach pull-right" style="text-align: right;"> 查看 / 修改 个人信息<span class="icon margin-left-sm">open_in_new</span> </a>
                                    </div>
                                </div>
                            </div>
                                    
                        </div>
                    </div>      
                    <!-- 角色转换 END-->                
                </div>

                <div class="row tab-pane fade " id="lms_admin_tnav_class" style="min-height: 500px;">             
                    <!--管理员 功能区-->
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tab-nav tab-nav-brand hidden-xx ui-tab " id="tabs-606390" >
                                    <ul class="nav nav-list">
                                        <li class="active">
                                            <a href="#panel-ServerInformation" data-toggle="tab" >服务器信息</a>
                                        </li>
                                        <li>
                                            <a href="#panel-UserSituation" data-toggle="tab">用户统计</a>
                                        </li>
                                        <li>
                                            <a href="#panel-personManage" data-toggle="tab" >用户管理</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-12 tab-content" style="padding-bottom:60px;">
                                
                                <div class="tab-pane fade in" id="panel-personManage">
                                    <iframe  src="<%=path%>/admin/PersonManage" id="iframepage" frameborder="0" scrolling="yes" marginheight="0" height="1800px" width="100%" name="用户管理"></iframe>
                                </div>
                                <div class="tab-pane fade in" id="panel-UserSituation">
                                    <iframe  src="<%=path%>/admin/UserSituation" id="iframepage" frameborder="0" scrolling="yes" marginheight="0" height="1800px" width="100%" name="用户统计"></iframe>
                                </div>
                                <div class="tab-pane fade in active" id="panel-ServerInformation">
                                    <iframe  src="<%=path%>/admin/ServerInformation" id="iframepage" frameborder="0" scrolling="yes" marginheight="0" height="3000px" width="100%" name="服务器信息"></iframe>                                    
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

            

        </div>
        <!--管理员 主区 END-->
        
        <!--管理员 副区 院长区-->
        <div id="lms_admin_d"  class="tab-pane fade in">
            <div class="bg-content"></div>
            <div class="container " style="position:relative;">
                <nav id="lms_admin_dnav">
                    <div>
                        <a href="#lms_admin_main"class="btn lms-c-text-light waves-attach waves-light waves-effect pull-left" data-toggle="tab">
                            <span> 返回 </span> 
                        </a>
                    </div>
                </nav>

                <div class="row width-control stage-box" id="lms_admin_dbtn">
                    <div class="col-md-5 card">
                        <aside class="card-side card-side-img pull-right">
                            <img alt="alt text" src="<%=path%>/images/dean_end.bmp" class="img-right">
                        </aside>
                        <div class="card-main">
                            <div class="card-inner">
                                <p class="card-heading">Great End !</p>
                                <p class="margin-bottom-lg">
                                    确定这学期结束了么(⊙o⊙)？
                                </p>
                            </div>
                            <div class="card-action">
                                <div class="card-action-btn pull-left">
                                <button class="btn btn-flat waves-attach waves-effect" data-toggle="modal" data-target="#modalEndTerm"  >CLICK TO CONTINUE</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5 col-md-offset-2 card">
                        <aside class="card-side card-side-img pull-left">
                            <img alt="alt text" src="<%=path%>/images/dean_start.bmp"  class="img-left">
                        </aside>
                        <div class="card-main">
                            <div class="card-inner">
                                <p class="card-heading">Good start !</p>
                                <p class="margin-bottom-lg">
                                    确定要开始新的学期了么\(≧▽≦)/
                                </p>
                            </div>
                            <div class="card-action">
                                <div class="card-action-btn pull-left">
                                <button class="btn btn-flat waves-attach waves-effect" data-toggle="modal" data-target="#modalStartTerm"  >CLICK TO CONTINUE</button>
                                </div>
                            </div>
                        </div>
                    </div>
                        
                </div>

                <div class="modal fade" id="modalEndTerm" role="dialog" >
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-heading">
                                <a class="modal-close" data-dismiss="modal">×</a>
                                <h2 class="modal-title">:-)</h2>
                            </div>
                            <div class="modal-inner">
                                <p class = "test-center h4">您确定要结束本学期了么？<span class="small">做最后一次确认吧</span></p>
                            </div>
                            <div class="modal-footer">
                                <p class="text-right"><button class="btn btn-flat btn-brand waves-attach waves-effect" data-dismiss="modal" type="button">Close</button><button class="btn btn-flat btn-brand waves-attach waves-effect" data-dismiss="modal" type="button" id ="end">OK</button></p>
                            </div>
                        </div>
                    </div>
                </div>
                                
                <div class="modal fade" id="modalStartTerm" role="dialog" >
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-heading">
                                <a class="modal-close" data-dismiss="modal">×</a>
                                <h2 class="modal-title">:-)</h2>
                            </div>
                            <div class="modal-inner">
                                <p class = "test-center h4">您确定要开始新的学期了么？<span class="small">做最后一次确认吧</span></p>
                            </div>
                            <div class="modal-footer">
                                <p class="text-right"><button class="btn btn-flat  btn-brand waves-attach waves-effect" data-dismiss="modal" type="button">Close</button><button class="btn btn-flat btn-brand waves-attach waves-effect" data-dismiss="modal" type="button" id ="begin">OK</button></p>
                            </div>
                        </div>
                    </div>
                </div>
                                

                <script>
                    $(function(){


                    $("#begin").click(function(){
                        $.post("<%=path%>/dean/start",
                        function(data){

                           if(data === "1"){alert("新学期开始成功")};
                            if(data ==="0"){alert("新学期开始失败")};
                            })
                    });
                     $("#end").click(function(){

                        $.post("<%=path%>/dean/end",
                        function(data){
                            if(data=="1"){alert("旧学期结束成功")};
                            if(data=="0"){alert("旧学期结束失败")};
                            }
                         );
                    });
                    });
                </script>
            </div>
        </div>
        <!--管理员 副区 院长区 END-->
        
        <!--管理员 副区 教务区 -->
        <div id="lms_admin_a"  class="tab-pane fade in">
            <!--功能列表-->
            <nav class="lms-admin-sidebar">
            <ul class="nav nav-tabs">
                <a href="#lms_admin_main" data-toggle="tab" class="btn btn-flat" style="
                   left: 0px;
                   right: 0px;
                   top: 0px;
                   position: relative;
                   color: rgb(255, 255, 255);
                   background-color: rgb(81, 81, 77);
                   border-radius: 0px;
                   ">
                    <span><span class="icon margin-left-sm">arrow_back</span>  返回</span> 
                </a>
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
                
                <hr />
                <li>
                    <a href="#panel-TeacherManage" data-toggle="tab" onclick="newzsjs()">教师信息管理</a>
                </li>
                <li>
                    <a href="#panel-StudentManage" data-toggle="tab" onclick="newzsxs()">学生信息管理</a>
                </li>
                
                <hr />
                <li>
                    <a href="#panel-tmpTeacherManage" data-toggle="tab" onclick="newlsjs()">教师信息管理【临时】</a>
                </li>
                <li>
                    <a href="#panel-tmpStudentManage" data-toggle="tab" onclick="newlsxs()">学生信息管理【临时】</a>
                </li>
            </ul>
            </nav>

            <!--功能区-->
            <div class="tab-content lms-admin-content">
                <div class="tab-pane fade in active" id="panel-tmpStudentManage">
                    <jsp:include page="../acdemic/szxsxx.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-StudentManage">
                    <jsp:include page="../acdemic/zs_stu.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-tmpTeacherManage">
                    <jsp:include page="../acdemic/szlsjsxx.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-TeacherManage">
                    <jsp:include page="../acdemic/zs_js.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-gradeInfoManage">
                    <jsp:include page="../acdemic/ckbjxx.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-courseInfoManage">
                    <jsp:include page="../acdemic/course.jsp"  />
                </div>
                <div class="tab-pane fade in " id="panel-courseTableManage">
                    <jsp:include page="../acdemic/set_all.jsp"  />
                </div>
            </div>
        </div>
        <!--管理员 副区 教务区 END-->
        
        <!--管理员 副区 教职区 -->
        <div id="lms_admin_t"  class="tab-pane fade in">

            <div class="bg-content"></div>
            <div class="container card" style="position:relative;">
                <nav id="lms_admin_tnav">
                    <div>
                        <a href="#lms_admin_main"class="btn lms-c-text-light waves-attach waves-light waves-effect pull-left" data-toggle="tab">
                            <span> 返回 </span> 
                        </a>
                    </div>
                    <div class="lms-control-list pull-right">

                        <select id="sz_xq" class="test btn text-golden"></select>
                        <div class="dropdown-wrap">
                            <div class="dropdown dropdown-inline">
                                <a class="btn dropdown-toggle-btn text-golden" data-toggle="dropdown"> 课程和班级 </a>
                                <ul id="tt" class="easyui-tree dropdown-menu nav" data-options="method:'get',animate:true">
                                    
                                </ul>
                            </div>
                        </div>
                        
                    </div>
                </nav>
                
                <div class="row width-control" id="lms_admin_tnav_class">
                    <div class="col-md-12" style="min-height: 500px">

                        <div id="mystudent" style="display: none">
                            <jsp:include page="../teacher/mystudent.jsp"/>
                        </div>

                        <div class="container-fluid" style="display: none;" id="mycourse">
                            <iframe id="addcouocontent" class="stage-box" frameborder="0" scrolling="no" marginheight="0"  width="100%" name="addcouocontent"   onload ="startInit('addcouocontent', 500);"></iframe>
                        </div>
                    </div>
                </div>
                <div id="pwin"></div>
            </div>    
        </div>
        <script>
        //学期下拉框
            function kcdz() {
                $.ajax({
                    type: "get",
                    url: "<%=path%>/fhxq",
                    async: false, //设置ajax同步加载
                    success: function (data) {
                        document.getElementById("sz_xq").options.length = 0;
                        for (var i = 1; i < data.length; i++) {
                            document.getElementById("sz_xq").options.add(new Option(data[i], data[i]));
                        }
                    },
                    error: function () {
                        kcdz();
                    }
                });
            }

            $(function () {
                kcdz();//学期下拉框function
                $('.test').change(function () {
                    $("#mystudent").hide();
                    $("#mycourse").hide();
                    $('#tt').tree({
                        url: '../teacher/courselist?xueqi=' + $("#sz_xq").val(),
                        onClick: function (node) {
                            lookTree(node);
                        }
                    });
                });
                $('#tt').tree({
                    url: '../teacher/courselist?xueqi=' + $("#sz_xq").val(),
                    onClick: function (node) {
                        lookTree(node);
                    }
                });
            });

            function  lookTree(node) {
                var a = node.children + "1";
                var b = "undefined1";
                if (a === b) {//班级学生信息管理
                    $("#mystudent").show();
                    $("#mycourse").hide();
                    var b = $("#tt").tree("getParent", node.target); //父节点
                    mystudent(node.text, node.id, b.id, $("#sz_xq").val());
                } else {//课程设置
                    $("#mycourse").show();
                    $("#mystudent").hide();
                    var term = $("#sz_xq").val();
                    var courseName = node.text;
                    var courseid = node.id;
                    var b = "<%=path%>/teacher/alljsp?term=" + term + "&courseid=" + courseid + "&courseName=" + courseName;
                    $("#addcouocontent", parent.document.body).attr("src", b);
                }
            }

            function mystudent(a, b, c, term) {
                $('#dg_zs_stu').datagrid({
                    title: " " + a,
                    url: '../teacher/mystudent?classid=' + b + '&course_id=' + c + '&term=' + term,
                    loadMsg: '数据加载中请稍后……'
                });
            }
        </script>
        <!--管理员 副区 教职区 END-->    
        
        <!--返回顶部-->
        <div class="fbtn-container" id="scrollUp">
            <div class="fbtn-inner">
                <a class="fbtn fbtn-lg fbtn-brand waves-attach waves-circle waves-light waves-effect" >T<span class="fbtn-text fbtn-text-left">返回顶部</span></a>
            </div>
        </div>


        
    <!-- js -->
    <script src="<%=path%>/js/jquery.fs.boxer.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
    <script>
        var Stickup=1;
        var Masonry= 0;
        $('.stage-card').boxer();
    </script>
    <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery.scrollUp.min.js" type="text/javascript"></script>

    <!--easyui-->
    <script src="<%=path%>/js/jquery.easyui.min.js"></script>
    <link rel="stylesheet"  href="<%=path%>/css/easyuicss/easyui.css">
    <link rel="stylesheet"  href="<%=path%>/css/easyuicss/icon.css">
    <link rel="stylesheet"  href="<%=path%>/css/easyuicss/images/tree_icons.png">
    
    <!--uploadify-->
    <script src="<%=path%>/js/jquery.uploadify.min.js"></script>

    <!--umeditor-->
    <script charset="utf-8" src="<%=path%>/js/umeditor.config.js"></script>
    <script charset="utf-8" src="<%=path%>/js/umeditor.min.js"></script>
    <script src="<%=path%>/js/zh-cn.js"></script>

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
           startInit('iframepage', 430);
    //            var ifm= document.getElementById("iframepage");   
    //          isFireFox = browserVersion.indexOf("FIREFOX") > -1 ? true : false;
            isChrome = browserVersion.indexOf("CHROME") > -1 ? true : false;
            isSafari = browserVersion.indexOf("SAFARI") > -1 ? true : false;
            if (!!window.ActiveXObject || "ActiveXObject" in window)
                isIE = true;
            window.setInterval("reinitIframe('" + iframeId + "'," + minHeight + ")", 100);
        }

        function iFrameHeight() {
               var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument;   
    //            if(ifm != null && subWeb != null) {
    //               ifm.height = subWeb.body.scrollHeight;
    //              // ifm.width = subWeb.body.scrollWidth;
    //            }   
        }
    

    </script>      
    </body>  
</html>
