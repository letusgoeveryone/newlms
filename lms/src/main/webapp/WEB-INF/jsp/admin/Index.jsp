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
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        
        <script src="<%=path%>/js/jquery.min.js"></script>
    </head>
    <body class="page-default tab-content" id='lms_admin'>


        <header class="header header-brand header-waterfall ui-header">
            
            <ul class="nav nav-list pull-left">
                <li>
                    <a href="<%=path%>/admin">
                        <span class="icon icon-lg">home</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | 管理员页面</span>
            
            <ul class="nav nav-list pull-right">
                
                <li class="dropdown">
                    <a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown" >
                        <span class="access-hide">Avatar</span>
                        <span class="avatar avatar-sm"><img alt="avatar" src="<%=path%>/images/avatar.jpg"></span>
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
                                
        <!--管理员 主区-->
        <div id='lms_main' class="container tab-pane fade in active sample-height">
            
            <div class="row">
                <div class="pd-content-htop"></div>

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
                                <section class="card-heading">管理员视角</section>
                                <section>
                            <!--        <sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                                        <a href="<%=path%>/dean" class='btn btn-aqua'>
                                            【D 院长】
                                        </a>
                                    </sec:authorize>-->
                                    <sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                                        <a href="<%=path%>/acdemic" class='btn btn-aqua' >
                                            【A 教务员】
                                        </a>
                                    </sec:authorize>
                            <!--          <sec:authorize access="hasRole('ROLE_ADMIN')">
                                        <a href="<%=path%>/teacher" class='btn btn-aqua'>
                                            【T 教职】
                                        </a>
                                    </sec:authorize>-->
                                    <a data-toggle="tab" href="#uconsole" class='btn btn-aqua mg-lt-3x'>
                                        <span class="text-white">控制台</span>
                                    </a>
                                </section>
                            </div>
                            <div class="card-action">
                                <div class="card-action-btn" style="margin:6px 16px;">
                                    <a href="admin/pinfo" class="btn btn-flat lms-c-text-light stage-card waves-attach pull-right" style="text-align: right;"> 查看 / 修改 个人信息<span class="icon margin-left-sm">open_in_new</span> </a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>      
                <!-- 角色转换 END-->

            </div>
        </div>
        <!--管理员 主区 END-->  
        

        <div class="container tab-pane fade " id="uconsole">


            <div class="row" style="min-height: 500px;margin-bottom: 100px;">             
                <!--管理员 功能区-->
                <div class="bg-content" style="top:56px;bottom: 30px;background-color: #445;"></div>
                <div class="container card" style="margin-top: 120px;margin-bottom: 30px;position: relative;">
                    <div class="width-control">
                        <div class="col-md-12">
                            <div class="tab-nav tab-nav-brand hidden-xx ui-tab" >
                                <ul class="nav nav-list">
                                    <li class="active">
                                        <a href="#panel-ServerInformation" data-toggle="tab" >服务器信息</a>
                                    </li>
                                    <li>
                                        <a href="#panel-FunctionManage" data-toggle="tab" >系统设置</a>
                                    </li>
                                    <li>
                                        <a href="#panel-UserSituation" data-toggle="tab">用户统计</a>
                                    </li>
                                    <li>
                                        <a href="#panel-PersonManage" data-toggle="tab" >用户管理</a>
                                    </li>
                                </ul>
                            </div>

                            <a class="btn btn-flat" data-toggle="tab" href="#lms_main" style="
                                   position: absolute;
                                   margin: 15px 3px;
                                   top: 0px;
                                   right: 15px;
                               ">
                                <span class="icon">arrow_back</span> 
                            </a>
                        </div>
                        <div class="col-md-12 tab-content" style="padding-bottom:60px;">

                            <div class="tab-pane fade in" id="panel-PersonManage">
                                <iframe  src="<%=path%>/admin/PersonManage" id="PersonManage" frameborder="0" scrolling="yes" marginheight="0" height="1800px" width="100%" name="用户管理"></iframe>
                            </div>
                            <div class="tab-pane fade in" id="panel-FunctionManage">
                                <iframe  src="<%=path%>/admin/FunctionManage" id="UserSituation" frameborder="0" scrolling="yes" marginheight="0" height="1800px" width="100%" name="系统设置"></iframe>
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
        
        <!--返回顶部-->
        <div class="fbtn-container" id="scrollUp">
            <div class="fbtn-inner">
                <a class="fbtn fbtn-lg fbtn-brand waves-attach waves-circle waves-light waves-effect" ><span class="fbtn-ori icon">keyboard_arrow_up</span><span class="fbtn-text fbtn-text-left">返回顶部</span></a>
            </div>
        </div>
        
        <!-- js -->
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.fs.core.js" type="text/javascript"></script>
        <script src="<%=path%>/js/formstone/js/transition.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.fs.boxer.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/configure.js"></script>

        <script>
            $('.stage-card').lightbox();
        </script>

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
