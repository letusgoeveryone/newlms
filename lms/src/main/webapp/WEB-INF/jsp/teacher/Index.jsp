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
        <title>『教师』| 教务系统</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" />
        <link href="<%=path%>/css/uploadify.css" rel="stylesheet"  />
        <link href="<%=path%>/ueditor/themes/default/css/umeditor.min.css" rel="stylesheet">
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <style>
            .col-md-9{
                padding-bottom: 5em;
                border-left: 1px solid whitesmoke;
                min-height: 500px;
            }
            .sample-height{
                min-height: 1000px;
                margin-bottom: 10em;
            }
        </style>
        <script src="<%=path%>/js/jquery.min.js"></script>
        
        
    </head>
    <body class="page-default tab-content" id='lms_teach'>
        
        <header class="header header-brand header-waterfall ui-header">

            <ul class="nav nav-list pull-left">
                <li>
                    <a href="<%=path%>/login">
                        <span class="icon icon-lg">home</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | 教师页面</span>

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

        <!--教师区 主区-->
        <div id='lms_main' class="container tab-pane fade in active sample-height">

            <div class="row">
                <div class="pd-content-htop"></div>

                <!-- 角色转换 -->
                <div class="col-md-12"> 
                    <div class="card">

                        <aside class="card-side pull-left">
                            <sec:authorize access="hasRole('ROLE_TEACHER') or hasRole('ROLE_DEAN')">
                                <a  href="#" class='fbtn fbtn-lg  btn-golden'>
                                    D<span class="fbtn-text fbtn-text-left">我的角色：教师</span>
                                </a>
                            </sec:authorize>
                        </aside>
                        <div class="card-main">
                            <div class="card-inner">
                                <section class="card-heading">导航面板</section>
                                <section>
                                    <sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                                        <a href="<%=path%>/login" class='btn btn-aqua'>
                                            返回
                                        </a>
                                    </sec:authorize>
                                    <a data-toggle="tab" href="#panel-CouCenter" class='btn btn-aqua mg-rt-3x'>
                                        【学期课程】
                                    </a>
                                    <a data-toggle="tab" href="#panel-RequstManage" href="<%=path%>/teacher" class='btn btn-aqua'>
                                        【注册管理】
                                    </a>
                                </section>
                            </div>
                            <div class="card-action">
                                <div class="card-action-btn" style="margin:6px 16px;">
                                    <a href="teacher/pinfo" class="btn btn-flat lms-c-text-light stage-card waves-attach pull-right" style="text-align: right;"> 查看 / 修改 个人信息<span class="icon margin-left-sm">open_in_new</span> </a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>      
                <!-- 角色转换 END-->                
            </div>

        </div>
        <!--教师区 主区 END-->
        
        <!--教师 主区 课程中心 -->
        <div id="panel-CouCenter" class="container tab-pane fade sample-height">
            <div class="pd-content-htop"></div>
            
            <div class="row card">
                <div class="card-main" >
                    <div class="card-header">
                        <div class="padding-1em" style="width: 100%;padding: 1em;height: 3em;line-height: 1em;font-size: 2em;">
                            学期课程
                        </div>
                        <a class="fbtn btn-golden btn-up" data-toggle="tab" href="#lms_main">
                            <span class="icon">arrow_back</span> 
                        </a>
                    </div>
                    <div class="card-inner row">
                        <div class="col-md-3" style="min-height:300px;">
                            <!--<ul id="card_btn_courseList"></ul>-->
                            <form class="form-group form-group-brand">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select class="form-control form-control-static test" name="xq" id="sz_xq"></select>
                                    </div>
                                </div>
                            </form>
                            
                            <ul id="tt" class="easyui-tree" data-options="method:'get',animate:true"></ul>
                        </div>
                        <div class="col-md-9" >
                            
                            <!--学生-->
                            <div id="mystudent" style="display: none">
                                <jsp:include page="mystudent.jsp"  />
                            </div>
                            
                            <!--课程-->
                            <div style="display: none;" id="mycourse">
                                <iframe  iframepage id="addcouocontent" frameborder="0" scrolling="no" marginheight="0" height="1000px" width="100%" name="addcouocontent"></iframe>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <!--教师 主区 课程中心 END -->

        
        <!--教师 副区 注册管理 -->
        <div id="panel-RequstManage"  class="container tab-pane fade sample-height">
            <div class="pd-content-htop"></div>
            
            <div class="row card">
                <div class="card-main" >
                    <div class="card-header">
                        <div class="padding-1em" style="width: 100%;padding: 1em;height: 3em;line-height: 1em;font-size: 2em;">
                            注册管理
                        </div>
                        <a class="fbtn btn-golden btn-up" data-toggle="tab" href="#lms_main">
                            <span class="icon">arrow_back</span> 
                        </a>
                    </div>
                    <div class="card-inner row">
                        
                        <jsp:include page="tempstu.jsp"  />
                        
                    </div>
                </div>
            </div>
        </div>
            <%--<jsp:include page="mystudent.jsp"/>--%>
        </div>
        <!--教师 副区 注册管理 END-->  

        
        <footer class="ui-footer" id="tree-footer">
            <div class="container">
                <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
            </div>
        </footer>

        
        <!--返回顶部-->
        <div class="fbtn-container">

            <div class="fbtn-inner" id="scrollUp">
                <a class="fbtn fbtn-lg fbtn-trans waves-attach waves-circle waves-light waves-effect" ><span class="fbtn-ori icon">keyboard_arrow_up</span><span class="fbtn-text fbtn-text-left">返回顶部</span></a>
            </div>
            <div class="fbtn-inner">
                <a class="fbtn fbtn-lg btn-gold waves-attach waves-circle waves-light" data-toggle="dropdown"><span class="fbtn-ori icon">apps</span><span class="fbtn-sub icon">close</span></a>
                <div class="fbtn-dropup">
                    <a class="fbtn fbtn-brand waves-attach waves-circle stage-card" href="teacher/pinfo"><span class="fbtn-text fbtn-text-left">点击查看/修改个人信息</span><span class="icon">account_circle</span></a>
                    <a class="fbtn fbtn-red waves-attach waves-circle waves-light" href="<%=path%>/us"><span class="fbtn-text fbtn-text-left">关于我们</span><span class="icon">all_inclusive</span></a>
                    <a class="fbtn fbtn-trans waves-attach waves-circle" href="#" ><span class="fbtn-text fbtn-text-left">加入我们</span><span class="icon">add</span></a>
                </div>
            </div>
        </div>

        <script>
            
            function sbysn(){
                var min_sn = $("#min_sn").val();
                var max_sn = $("#max_sn").val();
                $('#dg_stu').datagrid({
                    url: 'searchbysn?min=' + min_sn + "&max=" + max_sn,
                    loadMsg: '加载中请稍后……'
                }); 
            }
            
        //学期下拉框
            function kcdz() {
                $.ajax({
                    type: "get",
                    url: "<%=path%>/fhxq",
                    async: false, //设置ajax同步加载
                    success: function (data) {
                        document.getElementById("sz_xq").options.length = 0;
                        for (var i = 0; i < data.length; i++) {
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
                        url: '<%=path%>/courselist?xueqi=' + $("#sz_xq").val(),
                        onClick: function (node) {
                            lookTree(node);
                        }
                    });
                });
                $('#tt').tree({
                    url: '<%=path%>/courselist?xueqi=' + $("#sz_xq").val(),
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
                    var b = "<%=path%>/teacher/mycourse?term=" + term + "&courseid=" + courseid + "&courseName=" + courseName;
                    $("#addcouocontent", parent.document.body).attr("src", b);
                }
            }

            function mystudent(a, b, c, term) {
                $('#dg_zs_stu').datagrid({
                    title: " " + a,
                    url: '<%=path%>/teacher/mystudent?classid=' + b + '&course_id=' + c + '&term=' + term,
                    loadMsg: '数据加载中请稍后……'
                });
            }
        </script>
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

        <!--easyui-->
        <script src="<%=path%>/js/jquery.easyui/jquery.easyui.min.js"></script>
        <link rel="stylesheet"  href="<%=path%>/js/jquery.easyui/themes/bootstrap/easyui.css">
        <link rel="stylesheet"  href="<%=path%>/js/jquery.easyui/themes/icon.css">
 
        <!--uploadify-->
        <script src="<%=path%>/uploadify/jquery.uploadify.min.js"></script>
        <!--umeditor-->
        <script charset="utf-8" src="<%=path%>/ueditor/umeditor.config.js"></script>
        <script charset="utf-8" src="<%=path%>/ueditor/umeditor.min.js"></script>
        <script src="<%=path%>/js/zh-cn.js"></script>
        
        <script type="text/javascript">
        var browserVersion = window.navigator.userAgent.toUpperCase();
        var isOpera = false, isFireFox = false, isChrome = false, isSafari = false, isIE = false;
        var maxHeight = 0;
//        function reinitIframe(iframeId, minHeight) {
//            try {
//                var iframe = document.getElementById(iframeId);
//                var bHeight = 0;
//                if (isChrome === false && isSafari === false)
//                    bHeight = iframe.contentWindow.document.body.scrollHeight;
//                var dHeight = 0;
//                if (isFireFox === true)
//                    dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
//                else if (isIE === false && isOpera === false)
//                    dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
//                else if (isIE === true && !-[1, ] === false) {
//                } //ie9+
//                else
//                    bHeight += 3;
//                var height = Math.max(bHeight, dHeight);
//                if (height < minHeight){
//                    height = minHeight;
//                }
//                    
//                iframe.style.minHeight = height + "px";
//            } catch (ex) {
//            }
//        }
//        function startInit(iframeId, maxHeight) {
//            isOpera = browserVersion.indexOf("OPERA") > -1 ? true : false;
//            isFireFox = browserVersion.indexOf("FIREFOX") > -1 ? true : false;
//            isChrome = browserVersion.indexOf("CHROME") > -1 ? true : false;
//            isSafari = browserVersion.indexOf("SAFARI") > -1 ? true : false;
//            if (!!window.ActiveXObject || "ActiveXObject" in window)
//                isIE = true;
//            window.setInterval("reinitIframe('" + iframeId + "'," + maxHeight + ")", 100);
//        }
//
//        function iFrameHeight() {
//                //var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument;   
//                //if(ifm != null && subWeb != null) {
//                //   ifm.height = subWeb.body.scrollHeight;
//                //   ifm.width = subWeb.body.scrollWidth;
//                //}   
//        }   
    </script>      
    </body>  
</html>
