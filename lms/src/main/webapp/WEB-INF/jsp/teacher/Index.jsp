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
        <title>教师</title>

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
        <!-- js -->
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        
        <script src="<%=path%>/js/configure.js" type="text/javascript"></script>

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
        
    </head>
    <body class="page-default tab-content" id='lms_teach'>

        <section id="lms_main" class="tab-pane fade in active">
            
            <header class="header" id="tree-header">
                <nav class="tab-nav tab-nav-gold hidden-xx ui-tab">
                    <ul class="nav nav-list">
                        <li  class="active"><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_teach_CouCenter"><span class="text-white">课程中心</span></a></li>
                        <!--<li ><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_teach_RequstManage"><span class="text-white">学生管理</span></a></li>-->
                        <!--<li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_tLine"><span class="text-white">时光轴</span></a></li>-->
                        <li class="" style="position:absolute;right: 0;"><a class="waves-attach waves-light waves-effect"  href="<%=path%>/logout"><span class="text-white"> 退出系统<span class="icon icon-fixHans margin-left-sm">exit_to_app</span></span></a></li>
                    </ul>
                </nav>
            </header>

            <section class="tab-content container" >
                <div class=" space-block"></div>
                <div id="lms_teach_CouCenter" class="tab-content tab-pane fade in active">

                    <section id="panel-MyCourse" class="row tab-pane fade in active">
                        <div class="card sample-height">
                            <div class="card-main" >
                                <div class="card-header">
                                    <div class="padding-1em" style="width: 100%;padding: 1em;height: 3em;line-height: 1em;font-size: 2em;">
                                        学期课程
                                    </div>
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
                                        
                                        <!--学期:<select id="sz_xq" class="test "></select><br><br><br>-->
                                        <ul id="tt" class="easyui-tree" data-options="method:'get',animate:true"></ul>
                                    </div>
                                    <div class="col-md-9" >
                                        <div id="mystudent" style="display: none">
                                            <jsp:include page="mystudent.jsp"  />
                                        </div>
                                        <div style="display: none;" id="mycourse">
                                            <%--<jsp:include page="mycourse.jsp"/>--%>
                                            <iframe  iframepage id="addcouocontent" frameborder="0" scrolling="no" marginheight="0" height="1000px" width="100%" name="addcouocontent"></iframe>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section id="panel-HomeworkArea" class="row tab-pane fade in">

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
                                        <li class="active"><a href="#panel-HomeworkSetting" data-toggle="tab">布置作业</a></li>
                                        <li><a href="#panel-HomeworkStatus" data-toggle="tab">作业状态</a></li>
                                    </ul>
                                </nav>
                                <div class="card-inner row  tab-content">
                                    <div class="col-md-12 tab-pane fade in active" id="panel-HomeworkStatus">
                                        <%--<jsp:include page="HomeworkStatus.jsp"  />--%>
                                        
                                    </div>
                                    <div class="col-md-12 tab-pane fade in" id="panel-HomeworkSetting">
                                        <%--<jsp:include page="HomeworkSetting.jsp"  />--%>
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


                <!--教师 副区 学生管理 -->
<!--                <div id="lms_teach_RequstManage"  class="tab-pane fade in">

                    <%--<jsp:include page="mystudent.jsp"/>--%>

                </div>-->
                <!--教师 副区 学生管理 END-->  
            </section>

            <footer class="ui-footer" id="tree-footer">
                <div class="container">
                    <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
                </div>
            </footer>
        </section>

        <section id="lms_stu_homework" class="tab-pane fade">

            <%--<jsp:include page="Homework.jsp" />--%>

        </section>
          
        
        <!--返回顶部-->


        <div class="fbtn-container">

            <div class="fbtn-inner" id="scrollUp">
                <a class="fbtn fbtn-lg fbtn-trans waves-attach waves-circle waves-light waves-effect" ><span class="fbtn-ori icon">keyboard_arrow_up</span><span class="fbtn-text fbtn-text-left">返回顶部</span></a>
            </div>
            <div class="fbtn-inner">
                <a class="fbtn fbtn-lg btn-gold waves-attach waves-circle waves-light" data-toggle="dropdown"><span class="fbtn-ori icon">apps</span><span class="fbtn-sub icon">close</span></a>
                <div class="fbtn-dropup">
                    <a class="fbtn fbtn-brand waves-attach waves-circle stage-card" href="http:<%=path%>/teacher/teapnda"><span class="fbtn-text fbtn-text-left">点击查看/修改个人信息</span><span class="icon">account_circle</span></a>
                    <a class="fbtn fbtn-red waves-attach waves-circle waves-light" href="<%=path%>/us"><span class="fbtn-text fbtn-text-left">关于我们</span><span class="icon">all_inclusive</span></a>
                    <a class="fbtn fbtn-trans waves-attach waves-circle" href="#" ><span class="fbtn-text fbtn-text-left">加入我们</span><span class="icon">add</span></a>
                </div>
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
