<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>

<setting class="menu menu-left" id="menu-settings">
    <div class="menu-scroll">
        <div class="menu-top">
            <!--<div class="menu-top-img"><img alt="" src=""></div>-->
            <div class="menu-top-info">
                <a class="menu-top-user" href="#"><span class="avatar avatar-inline margin-right">L</span>设置中心</a>
            </div>
            <!--<div class="menu-top-info-sub"><small></small></div>-->
        </div>
        <div class="menu-content container-fluid">

            <div class="row">
                <nav class="col-md-3 fix-menu-nav">
                    <ul class="nav ">
                        <li>
                            <a class="waves-attach waves-effect" href="#">
                                <span class="icon mg-sm-right">info</span>个人信息
                            </a>
                            <ul id="collapse-profile-settings">
                                <li>
                                    <a class="waves-attach waves-effect" data-toggle="tab" href="#tab-personalInfo">基础资料</a>
                                </li>
                                <li>
                                    <a class="waves-attach waves-effect" data-toggle="tab" href="#tab-password">密码设置</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a class="waves-attach waves-effect" href="#">
                                <span class="icon mg-sm-right">class</span>课程管理
                            </a>
                            <ul id="collapse-course-settings">
                                <li>
                                    <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-course-selected">
                                        已选课程
                                    </a>
                                </li>
                                <li>
                                    <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-course-selectable">
                                        可选课程
                                    </a>
                                </li>
                                <li>
                                    <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-course-permit">
                                        已批准课程
                                    </a>
                                </li>
                                <li>
                                    <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-course-notpermit">
                                        未批准课程
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <span class="fix-tab-plugin">
                                <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-plugin">
                                    <span class="icon mg-sm-right">view_quilt</span> 插件管理
                                </a>
                            </span>
                        </li>
                        <li>
                            <a class="waves-attach waves-light waves-effect" href="<%=path%>/logout">
                                <span class="icon mg-sm-right">exit_to_app</span> 注销
                            </a>
                        </li>
                    </ul>
                </nav>

                <div class='col-md-9' class="tab-content">
                    <!--基础资料-->
                    <div id="tab-personalInfo" class="tab-pane fade in active">
                        <form>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="sn"> 学号 </label>
                                <input class="form-control" id="sn" type="text" value="{{sn}}" disabled="">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="name"> 姓名 </label>
                                <input class="form-control" id="name" type="text" value="{{name}}">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="ID"> 身份证 </label>
                                <input class="form-control" id="ID" type="text" value="{{ID}}">
                            </div>
                            <div class="form-group form-group-label">

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="man">
                                        <input class="access-hide" id="man" name="sex" type="radio">男生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="weman">
                                        <input class="access-hide" id="weman" name="sex" type="radio">女生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="college"> 学院 </label>
                                <input class="form-control" id="college" type="text" value="{{college}}">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="grade"> 年级 </label>
                                <input class="form-control" id="grade" type="text" value="{{grade}}">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="tel"> 联系方式 </label>
                                <input class="form-control" id="tel" type="text" value="{{tel}}">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="qq"> QQ </label>
                                <input class="form-control" id="qq" type="text" value="{{qq}}">
                            </div>


                            <div class="btn btn-block  btn-card btn-card-darken" onclick="updataPersonalInfo()">
                                确认
                            </div>
                        </form>
                    </div>
                    <!--密码设置-->
                    <div id="tab-password" class="tab-pane fade">
                        <form>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="oldPassword"> 原始密码 </label>
                                <input class="form-control" id="grade" type="password">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="tel"> 新密码 </label>
                                <input class="form-control" id="newPassword" type="password" >
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="qq"> 确认密码  </label>
                                <input class="form-control" id="newPasswordConfirm" type="password">
                            </div>

                            <div class="btn btn-block btn-card btn-card-darken">
                                确认
                            </div>
                        </form>
                    </div>
                    <!--已选课程-->
                    <div id="tab-course-selected" class="tab-pane fade">

                    </div>
                    <!--可选课程-->
                    <div id="tab-course-selectable" class="tab-pane fade">
                        <div id="course-selectable-tree" class="col-md-3">

                        </div>
                        <div id="course-selectable-content" class="col-md-9 table-responsive">
                             {{tableData}}
                        </div>
                    </div>
                    <!--已批准课程-->
                    <div id="tab-course-permit" class="tab-pane fade">
                        2
                    </div>
                    <!--未批准课程-->
                    <div id="tab-course-notpermit" class="tab-pane fade">
                        2
                    </div>

                    <!--插件管理-->
                    <div id="tab-plugin" class="tab-pane fade">
                        <div id="Jihuajiyi" style=";width: 100%;border: none;color: #f6f6f6;"></div> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</setting>
<html lang="zh-cn">
    <head>
        <meta charset="UTF-8">
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>我的主页</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/animate.css"  rel="stylesheet">
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" />
        <link href="<%=path%>/css/uploadify.css" rel="stylesheet"  />
        <link href="<%=path%>/css/umeditor.min.css"  rel="stylesheet">

        <script src="<%=path%>/js/jquery.min.js"></script>

        <style>
            #card_btn_courseList{margin: 0;padding:1em 0;}
            #card_btn_courseList li{
                display: block;
            }
            #card_btn_courseList li a{
                text-align: center;
                padding:0.5em 1em;
                display: block;
                min-width: 100px;
                color: #3c763d;
                background-color: rgba(200,200,200,0.2);
            }
            #lms_stu_tnav_pInfo{
                padding-top: 5em;
                padding-bottom:100%;
            }
            #lms_stu_tnav_pInfo .card{
                margin-top: 0 !important;
                margin-bottom: 0 !important;
                /*min-height: 700px;
                background-color: rgba(255,255,255,0.8);*/
            }
        </style>
    </head>
    <body class="page-default tab-content" id="lms_stu">
        
        <!--Page-学生主页 o-->
        <section id="lms_main" class="tab-pane fade in active stage-image bg-center"
                     style="background-image:url(<%=path%>/images/bg-for-tl.jpg);min-height:1500px;">
            <!--导航栏 o-->
            <header class="header header-waterfall ui-header" id="tree-header">
                <nav class="tab-nav ui-tab">
                    <ul class="header-nav nav nav-list">
                        
                        <li class="nav-brand"><a>教务系统</a></li>
                        <li  class="active"><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_pInfo"><span class="text-white">我的课程</span></a></li>
                        <span class="divider"></span>
                        <li  class="">
                            <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_pHomework">
                                <span class="text-white">作业</span></a>
                        </li>
                        <!--<li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_tLine"><span class="text-white">时光轴</span></a></li>-->
                        
                        <!--个人信息 下拉菜单 o-->
                        <li class="dropdown fix-dd-usr" style="position:absolute;right: 0;"><a class="dropdown-toggle" data-toggle="dropdown"><span class="avatar ">L</span></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="waves-attach waves-light waves-effect stage-card" href="http:<%=path%>/student/personal_Inf">
                                        <span class="icon mg-sm-right">account_circle</span> 查看/修改 个人信息
                                    </a>
                                </li>
                                <li>
                                    <a class="waves-attach waves-light waves-effect" href="<%=path%>/logout">
                                        <span class="icon mg-sm-right">exit_to_app</span> 注销
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!--个人信息 下拉菜单 x-->
                    </ul>
                </nav>
            </header>
            <!--导航栏 x-->  
            
            <!--主体 o-->
            <section class="tab-content container"><div class="space-block"></div>
                
                <!--我的课程 o-->
                <div id="lms_stu_tnav_pInfo" class="tab-content tab-pane fade in active">
                    
                    <section id="panel-MyCourse" class="row card tab-pane fade in active">
                        <div class="card" >
                            <aside class="card-side pull-left">
                                <span class="card-heading" >
                                    <a class="fbtn btn-brand waves-attach waves-circle waves-light waves-effect" 
                                       href="#panel-ChooseCourse" data-toggle="tab" ><span class="icon">add</span>
                                        <span class="fbtn-text fbtn-text-left">加入课程</span>
                                    </a>
                                </span>
                            </aside>
                            <div class="card-main">
                                <div class="card-header">
                                    <div class="padding-1em" style="width: 100%;padding: 1em;height: 3em;line-height: 1em;font-size: 2em;">
                                        课程
                                    </div>
                                </div>
                                <div class="card-inner row">
                                    <div class="col-md-3 divider-right" style="min-height:300px;">
                                        
                                    </div>
                                    <div class="col-md-9" >
                                        <iframe src="" id="couiframepage" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="coucontent" onload=" startInit('couiframepage', 500);"></iframe> </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section id="panel-ChooseCourse" class="row card tab-pane fade">

                        <div class="card">
                            <aside class="card-side pull-left">
                                <span class="card-heading" >
                                    <a class="fbtn btn-brand waves-attach waves-circle waves-light waves-effect" 
                                       href="#panel-MyCourse" data-toggle="tab" ><span class="icon">arrow_back</span>
                                        <span class="fbtn-text fbtn-text-left">返回</span>
                                    </a>
                                </span>
                            </aside>
                            <div class="card-main">
                                <nav class="tab-nav tab-nav-gold hidden-xx ui-tab">
                                    <ul class="nav nav-list">
                                        <li class="active"><a href="#panel-ChooseCouseList" data-toggle="tab">选课列表</a></li>
                                        <li><a href="#panel-ChooseCouseStatus" data-toggle="tab">选课状态</a></li>
                                    </ul>
                                </nav>
                                <div class="card-inner row  tab-content">
                                    <div class="tab-pane fade in active" id="panel-ChooseCouseList">
                                        <div class="col-md-3 divider-right" style="min-height:300px;">
                                            <span id="span2" >
                                                <ol type="1" class="" >${noreadycou}</ol>
                                            </span>
                                        </div>
                                        <div class="col-md-9"><iframe src="" id="noreadycoucontent" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="noreadycoucontent" onload=" startInit('noreadycoucontent', 500);"></iframe> 
                                    </div>
                                    </div>
                                    <div class="col-md-12 tab-pane fade in" id="panel-ChooseCouseStatus">
                                        <%--<jsp:include page="CourseState.jsp"  />--%>

                                        <iframe src="<%=path%>/student/stu_addcourse" id="addcouocontent" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="addcouocontent" onload=" startInit('addcouocontent', 500);"></iframe>
                                    </div>
                                </div>
                                
                                <div class="card-action">
<!--                                    
                                    <ul class="nav nav-list margin-no pull-right">
                                        <li class="dropdown">
                                            <a class="dropdown-toggle text-black waves-attach waves-effect" data-toggle="dropdown"><span class="icon">keyboard_arrow_down</span></a>
                                            <ul class="dropdown-menu dropdown-menu-right">
                                                <li>
                                                    <a class="waves-attach waves-effect" href="javascript:void(0)"><span class="icon margin-right-sm">filter_1</span>&nbsp;</a>
                                                </li>
                                                <li>
                                                    <a class="waves-attach waves-effect" href="javascript:void(0)"><span class="icon margin-right-sm">filter_2</span>&nbsp;</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
-->
                                </div>    
                            </div>
                        </div>
                    </section>
                                                               
                </div>     
                <!--我的课程 x-->
                
                <!--我的作业 o-->
                <div id="lms_stu_tnav_pHomework" class="tab-pane fade" ></div>
                <!--我的作业 x-->
                
            </section>
            <!--主体 x-->  
            
            <!--页脚 o-->
            <footer class="ui-footer" id="tree-footer">
                <div class="container">
                    <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
                </div>
            </footer>
            <!--页脚 x-->
        </section>
        <!--Page-学生主页 x-->

        <!--底部按钮 o-->
        <div class="fbtn-container">

            <!--中心盒子 触发器-->
            <div id="btn-centerbox"  class="fbtn-inner">
                <div id="android-logo">
                    <div id="android-logo-wrap">
                        <div id="logo-head">
                            <div class="horn" style="left:8px;transform:rotate(-35deg)"></div>
                            <div class="horn" style="right:8px;transform:rotate(35deg)"></div>
                            <div class="eyes" style="left:8px;"></div>
                            <div class="eyes" style="right:8px;"></div>
                        </div>
                        <div id="logo-body">
                            <div class="arms"></div>

                            <div>
                                <span class="fbtn-ori icon">apps </span>
                            </div>

                            <div class="arms"></div>
                        </div>
                        <div id="logo-legs">
                            <div class="leg" id="for-wave"></div>
                            <div class="leg" id="for-meng"></div>
                        </div>
                    </div>

                </div>
            </div>
            
            <!--盒子中心-->
            <div id="for-centerbox" hidden="" >
                <nav class="tab-nav ui-tab">
                    <ul class="nav nav-list">
                        <li  class="active">
                            <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#panel-newsbox">
                                <span class="text-white">消息盒子</span>
                            </a>
                        </li>
                        <li  class="">
                            <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#panel-plugin">
                                <span class="text-white">插件中心</span>
                            </a>
                        </li>
                        <li  class="">
                            <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#panel-personalInfo">
                                <span class="text-white">个人信息</span>
                            </a>
                        </li>
                        <li  class="waves-attach waves-light waves-effect" id="btn-centerbox-x" style="position: absolute;right: 0;">
                            <span class="icon">close</span>
                        </li>
                    </ul>
                </nav>

                <div class="tab-content">
                    <div class="tab-pane fade" id="panel-newsbox">
                    </div>
                    <div class="tab-pane fade" id="panel-plugin">
                        <div id="Jihuajiyi" style=";width: 100%;border: none;background-color: #4d5e6b;color: #f6f6f6;"></div> 
                    </div>
                    <div class="tab-pane fade" id="panel-personalInfo">
                    </div>
                </div>
            </div>

            <!--ScrollUp 触发器-->
            <div id="scrollUp" class="fbtn-inner btn-scrollup">
                <span class="fbtn-ori icon">keyboard_arrow_up</span>
            </div>
        </div>
        <!--底部按钮 x-->
        
        <!-- js -->
        <script src="<%=path%>/js/api.json.student.js" type="text/javascript"></script>
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/vue.js" type="text/javascript"></script>
        <script>
            var Stickup=0;
        </script>
        <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
        <script src="http://open.iciba.com/huaci/huaci.js" ></script> 
        <!--easyui-->
        <script src="<%=path%>/js/jquery.easyui.min.js"></script>
        <link rel="stylesheet"  href="<%=path%>/css/easyuicss/easyui.css">
        <link rel="stylesheet"  href="<%=path%>/css/easyuicss/icon.css">

        <!--uploadify-->
        <script src="<%=path%>/uploadify/jquery.uploadify.min.js"></script>

        <!--umeditor-->
        <script charset="utf-8" src="<%=path%>/ueditor/umeditor.config.js"></script>
        <script charset="utf-8" src="<%=path%>/ueditor/umeditor.min.js"></script>
        <script src="<%=path%>/js/zh-cn.js"></script>
        <script type="text/javascript">
            var browserVersion = window.navigator.userAgent.toUpperCase();
            var isOpera = false, isFireFox = false, isChrome = false, isSafari = false, isIE = false;
            function reinitIframe(iframeId, minHeight) {
                try {
                    var iframe = document.getElementById(iframeId);
                    var bHeight = 0;
                    if (isChrome === false && isSafari === false)
                        bHeight = iframe.contentWindow.document.body.scrollHeight;
                    var dHeight = 0;
                    if (isFireFox === true)
                        dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                    else if (isIE === false && isOpera === false)
                        dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                    else if (isIE === true && !-[1] === false) {
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
            function refleshspan() {   
               $.ajax({
                   type: "GET", 
                   url: "<%=path%>/student/refleshspan", 
                   success: function (data) {
                       $("#span1")[0].innerHTML=data[0];
                       $("#span2")[0].innerHTML=data[1];
                   },
                    error:function(){
                        alert("出错！");
                       }
                    });
            }
            
        </script> 
    </body>
</html>

/**
* HTML片段: 存储已选课程列表 
* @type String
*/
var OCourseListHS = "";
/**
* HTML片段: 存储待选课程表格 
* @type String
*/
var XCourseTableHS = '';