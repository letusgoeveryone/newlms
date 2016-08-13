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
        <title>『管理员』| 教务系统</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" />
        <link href="<%=path%>/css/uploadify.css" rel="stylesheet"  />
        
        <script src="<%=path%>/js/jquery.min.js"></script>
    </head>
    <body class="page-default tab-content" id='lms_admin'>
        
        <!--管理员 主区-->
        <div id='lms_main' class="tab-pane fade in active">
            
            <header class="header " id="tree-header">
                <nav class="tab-nav tab-nav-gold hidden-xx ui-tab">
                    <ul class="nav nav-list">
                        <li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_admin_tnav_sInfo"><span class="text-white">信息管理</span></a></li>
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
                                <sec:authorize access="hasRole('ROLE_ADMIN')">
                                    <a  href="#" class='fbtn fbtn-lg  btn-golden'>
                                        A<span class="fbtn-text fbtn-text-left">我的角色：管理员</span>
                                    </a>
                                </sec:authorize>
                            </aside>
                            <div class="card-main">
                                <div class="card-inner">
                                    <section class="card-heading">角色转换（管理员）到</section>
                                    <section>
                                        <sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                                            <a href="<%=path%>/dean" class='btn btn-aqua'>
                                               【D 院长】
                                            </a>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                                            <a href="<%=path%>/acdemic" class='btn btn-aqua' >
                                               【A 教务员】
                                            </a>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                                            <a href="<%=path%>/teacher" class='btn btn-aqua'>
                                               【T 教职】
                                            </a>
                                        </sec:authorize>
                                    </section>
                                </div>
                                <div class="card-action">
                                    <div class="card-action-btn" style="margin:6px 16px;">
                                        <a href="http:<%=path%>/admin/PersonalInfo" class="btn btn-flat lms-c-text-light stage-card waves-attach pull-right" style="text-align: right;"> 查看 / 修改 个人信息<span class="icon margin-left-sm">open_in_new</span> </a>
                                    </div>
                                </div>
                            </div>
                                    
                        </div>
                    </div>      
                    <!-- 角色转换 END-->
                    
                </div>

                <div class="row tab-pane fade " id="lms_admin_tnav_sInfo" style="min-height: 500px;margin-bottom: 100px;">             
                    <!--管理员 功能区-->
                    <div class="bg-content" style="top:56px;bottom: 30px;background-color: #445;"></div>
                    <div class="container card" style="margin-top: 120px;margin-bottom: 30px;position: relative;">
                        <div class="row width-control">
                            <div class="col-md-12">
                                <div class="tab-nav tab-nav-brand hidden-xx ui-tab" >
                                    <ul class="nav nav-list">
                                        <li class="active">
                                            <a href="#panel-ServerInformation" data-toggle="tab" >服务器信息</a>
                                        </li>
                                        <li>
                                            <a href="#panel-UserSituation" data-toggle="tab">用户统计</a>
                                        </li>
                                        <li>
                                            <a href="#panel-PersonManage" data-toggle="tab" >用户管理</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-12 tab-content" style="padding-bottom:60px;">
                                
                                <div class="tab-pane fade in" id="panel-PersonManage">
                                    <iframe  src="<%=path%>/admin/PersonManage" id="PersonManage" frameborder="0" scrolling="yes" marginheight="0" height="1800px" width="100%" name="用户管理"></iframe>
                                </div>
                                <div class="tab-pane fade in" id="panel-UserSituation">
                                    <iframe  src="<%=path%>/admin/UserSituation" id="UserSituation" frameborder="0" scrolling="yes" marginheight="0" height="1800px" width="100%" name="用户统计"></iframe>
                                </div>
                                <div class="tab-pane fade in active" id="panel-ServerInformation">
                                    <iframe  src="<%=path%>/admin/ServerInfo" id="ServerInfo" frameborder="0" scrolling="no" marginheight="0"  width="100%" name="服务器信息" onload ="startInit('ServerInfo', 500);"></iframe>                                    
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
        
        <!--返回顶部-->
        <div class="fbtn-container" id="scrollUp">
            <div class="fbtn-inner">
                <a class="fbtn fbtn-lg fbtn-brand waves-attach waves-circle waves-light waves-effect" >T<span class="fbtn-text fbtn-text-left">返回顶部</span></a>
            </div>
        </div>
        
    <!-- js -->
    <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/configure.js" type="text/javascript"></script>



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
