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
        <title>我的主页-教师页面</title>
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
                        dHeight = iframe.contentWindow.document.documentElement.offsetHeight + 2;
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
                        url: 'teacher/courselist?xueqi=' + $("#sz_xq").val(),
                        onClick: function (node) {
                            lookTree(node);
                        }
                    });
                });
                $('#tt').tree({
                    url: 'teacher/courselist?xueqi=' + $("#sz_xq").val(),
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
                    url: 'teacher/mystudent?classid=' + b + '&course_id=' + c + '&term=' + term,
                    loadMsg: '数据加载中请稍后……'
                });
            }

        </script>
    </head>
    <body class="page-default">

        <div class="content">

            <div class="content-header ui-content-header">
                <div class="container-fluid left-padding">
                    <div class="row">
                        <div class="col-lg-6 col-md-8 ">
                            <h1 class="content-heading">个人中心</h1>
                            <div class="space-block"></div>
                        </div>
                    </div>
                </div>
            </div>

            <header class="header header-transparent header-waterfall ui-header navbar-wrapper" id="tree-header">
                <div class="container-fluid side-padding">
                    <div class="row" >
                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <a class="header-logo" href="admin">教务系统</a>
                        </sec:authorize>
                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <a class="header-text" href="admin">管理员页面</a>
                        </sec:authorize>
                        <sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                            <a class="header-text" href="dean">院长页面</a>
                        </sec:authorize>
                        <sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
                            <a class="header-text" href="acdemic">  教务员页面</a>
                        </sec:authorize>

                        <nav class="tab-nav tab-nav-gold pull-right hidden-xx ui-tab" id="zdytab">
                            <ul class="nav nav-list">
                                <li  class="active"><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_teach_tnav_pInfo"><span class="text-white">个人资料</span></a></li>
                                <li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_teach_tnav_class"><span class="text-white">课程定制</span></a></li>
                                <li><a class="waves-attach waves-light waves-effect"  href="<%=path%>/logout"><span class="text-white">退出系统</span></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </header> 

            <div class="container  tab-content" >
                <div class="row tab-pane fade active in" id="lms_teach_tnav_pInfo">       
                    <div class="col-md-12">
                        <iframe src="<%=path%>/teacher/teapnda" iframepage" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="pInfocontent"></iframe>

                    </div>
                </div>

                <div class="row tab-pane fade" id="lms_teach_tnav_class">       
                    <!--1/3 功能控制区-->
                    <div class="col-md-3 lms-control-list" style="border-right: whitesmoke solid 1px;">
                        <h4>我的开课课程</h4>
                        学期:<select id="sz_xq" class="test"></select><br><br><br>
                        <ul id="tt" class="easyui-tree" data-options="method:'get',animate:true"></ul>
                    </div>
                    <!--2/3 功能展示区-->
                    <div class="col-md-9" style="min-height: 500px">

                        <div id="mystudent" style="display: none">
                            <jsp:include page="mystudent.jsp"  />
                        </div>

                        <div class="container-fluid" style="display: none;" id="mycourse">
                            <br><br><br>
                            <iframe  iframepage" id="addcouocontent" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="addcouocontent"   onload=" startInit('addcouocontent', 500);"></iframe>

                        </div>
                    </div>
                </div>
            </div>
            <div id="pwin"></div>
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
