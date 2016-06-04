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
<html lang="zh-cn">
    <head>
        <meta charset="UTF-8">
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>我的主页</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
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
        </style>
    </head>
    <body class="page-default tab-content">
        <section id="lms_main" class="tab-pane fade in active stage-image bg-top"
                     style="background-image:url(<%=path%>/images/bg_for_timeLine.jpg);min-height:2000px;">
            <header class="header " id="tree-header">
                <nav class="tab-nav tab-nav-gold hidden-xx ui-tab">
                    <ul class="nav nav-list">
                        <li  class="active"><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_pInfo"><span class="text-white">个人主页</span></a></li>
                        <li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_tLine"><span class="text-white">时光轴</span></a></li>
                        <li class="" style="position:absolute;right: 0;"><a class="waves-attach waves-light waves-effect"  href="<%=path%>/logout"><span class="text-white">退出系统<span class="icon margin-left-sm">exit_to_app</span></span></a></li>
                    </ul>
                </nav>
            </header>

            <section class="tab-content" >
                <div id="lms_stu_tnav_pInfo" class="container tab-pane fade in active">
                    <div class="row card" style="margin-top:120px;">
                        <aside class="card-side pull-left">
                            <span class="card-heading" style="padding-top:22.5px;"><i class="icon">info_outline</i></span>
                        </aside>
                        <div class="card-main">
                            <div class="card-inner row">
                                <div class="col-md-3">
                                    <div class="card-heading">我的课程</div>
                                    <ul id="card_btn_courseList">${stucou}</ul>
                                </div>
                                <div class="col-md-9">
                                    <jsp:include page="Course.jsp"  />
                                </div>
                            </div>
                            <div class="card-action">

                                <ul class="nav nav-list margin-no pull-right">
                                    <li class="dropdown">
                                        <a class="dropdown-toggle text-black waves-attach waves-effect" data-toggle="dropdown"><span class="icon">keyboard_arrow_down</span></a>
                                        <ul class="dropdown-menu dropdown-menu-right">
                                            <li>
                                                <a class="waves-attach waves-effect" href="javascript:void(0)"><span class="icon margin-right-sm">filter_1</span>&nbsp;未批准课程</a>
                                            </li>
                                            <li>
                                                <a class="waves-attach waves-effect" href="javascript:void(0)"><span class="icon margin-right-sm">filter_2</span>&nbsp;加入课程</a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                            
                    <div class="tab-content">
                        <div></div>
                        <div></div>
                        <div>
                            
                        </div>
                    </div>
                </div>
                <div id="lms_stu_tnav_tLine" class="tab-pane fade in active" >

                </div>
            </section>

            <footer class="ui-footer" id="tree-footer">
                <div class="container">
                    <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong
                </div>
            </footer>
        </section>
                
        <section id="lms_stu_homework" class="tab-pane fade">
            
            <jsp:include page="Homework.jsp"  />
            
        </section>

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
            var Stickup=0;
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
