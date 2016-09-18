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

        <link href="<%=path%>/css/nprogress.css" rel="stylesheet" />
        <script src="<%=path%>/js/nprogress.js"  ></script><script>NProgress.start();</script>
        
        <!-- css -->

        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <script src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/vue.js"></script>
        <script src="<%=path%>/js/md5.js" type="text/javascript"></script><script>NProgress.set(0.4);</script>
        
    </head>
    <body class="page-brand container-full" id="lms_stu">
        
        <!--aside -->
        <aside id="upanel" class="menu menu-right nav-drawer nav-drawer-md" >
            <div class="menu-scroll">
                <div class="menu-content">
                    <div class="menu-logo" href="javascript:void(0)">个人面板 
                    </div>
                    <div class="vcard lms-loading">

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
                            <a data-toggle="tab" href="#tab-personalInfo">编辑个人名片 <span class="icon">edit</span></a>

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
<!--                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-permit">
                                <strong class="vcard-stat-count">10</strong>
                                <span class="text-muted">已批准课程</span>
                            </a>-->
                            <!--tab-news-->
                            <a class="vcard-stat" data-toggle="tab"  href="#">
                                <strong class="vcard-stat-count">{{numICourse}}</strong>
                                <span class="text-muted">消息盒子</span>
                            </a>
                            <a class="vcard-stat" data-toggle="tab"  href="#tab-personalInfo">
                                <strong class="vcard-stat-count icon">person</strong>
                                <span class="text-muted">个人中心</span>
                            </a>
                            <a class="vcard-stat" href="student/courses">
                                <strong class="vcard-stat-count icon">open_in_new</strong>
                                <span class="text-muted">选课系统</span>
                            </a>
                        </div>
                        <div>
                            
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
                    <a href="<%=path%>/student">
                        <span class="icon icon-lg">home</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | 学生页面</span>
            <ul class="nav nav-list pull-right">
                <li>
                    <a id="for-ubox" onclick="toggleUserSettings()">
                        <span class="icon icon-lg">menu</span>
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
        
        <!--widgets-->
        <jsp:include page="../student/IncludeWidgets.jsp" />
        
        <!--scrollUp-->
        <div class="fbtn-container" id="scrollUp">
            <div class="fbtn-inner">
                <a class="fbtn fbtn-brand waves-attach waves-circle">
                    <span class="fbtn-text fbtn-text-left">返回顶部</span>
                    <span class="fbtn-ori icon">keyboard_arrow_up</span>
                </a>
            </div>
        </div>
        
        <!-- js -->
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script><script>NProgress.set(0.7);</script>
        <script src="<%=path%>/js/api.json.student.js" type="text/javascript"></script>
        <script src="<%=path%>/js/tinymce/tinymce.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
        <link href="<%=path%>/uploadify/uploadify.css" rel="stylesheet" type="text/css"/>
        <script src="<%=path%>/uploadify/jquery.uploadify.js" type="text/javascript"></script>
        <!--<script src="http://open.iciba.com/huaci/huaci.js"></script>-->
        <script>
            
           /* ==================================================================
            * 页面初始化
            * ================================================================== */
            initPage();NProgress.set(0.9);


           /* ==================================================================
            * 作业 监听器
            * ================================================================== */
            
            var hidIsSubmit = true;
            var attIsChange = false;
            var cntIsChange = false;
            
            // 编辑器 初始化
            tinymce.init({
                mode : "exact",
                selector: '#lms-editor',
                fixed_toolbar_container: 'body',
                theme: 'inlite',
                language: 'zh_CN',
                inline: true,
                plugins: [
                    'advlist autolink autosave code link image lists charmap codesample hr anchor',
                    'searchreplace visualchars insertdatetime media nonbreaking fullscreen',
                    'table contextmenu directionality emoticons template paste preview textcolor textpattern visualblocks'
                ],
                insert_toolbar: 'h1 h2 h3 hr bullist numlist outdent indent  blockquote quickimage codesample insertdatetime template | removeformat',
                selection_toolbar: 'bold italic underline subscript superscript textcolor forecolor backcolor strikethrough | alignleft aligncenter alignright alignjustify  outdent indent | link h1 h2 h3 blockquote codesample media | removeformat | ',
                contextmenu: 'image media codesample | charmap | link anchor | inserttable | cell row column deletetable | visualblocks preview',
                insertdatetime_formats: ["%H:%M:%S %Y-%m-%d", "%H:%M:%S", "%Y-%m-%d", "%I:%M:%S %p", "%D"],
                templates: [
                    {title: 'Some title 1', description: 'Some desc 1', content: 'My content'},
                    {title: 'Some title 2', description: 'Some desc 2', url: 'development.html'}
                ],
                textpattern_patterns: [
                    {start: '*', end: '*', format: 'italic'},
                    {start: '**', end: '**', format: 'bold'},
                    {start: '#', format: 'h1'},
                    {start: '##', format: 'h2'},
                    {start: '###', format: 'h3'},
                    {start: '####', format: 'h4'},
                    {start: '#####', format: 'h5'},
                    {start: '######', format: 'h6'},
                    {start: '>_ ', format: 'blockquote'},
                    {start: '1. ', cmd: 'InsertOrderedList'},
                    {start: '* ', cmd: 'InsertUnorderedList'},
                    {start: '- ', cmd: 'InsertUnorderedList'}
                ],
                media_live_embeds: true,
                init_instance_callback: function (editor) {
                    editor.on('Change', function (e) {
                        cntIsChange = true;
                        hidIsSubmit = false;
                        console.log('Editor contents was changed.');
                        console.log("有未提交内容 !");
                    });
                }

            });
            // 编辑器 监视提醒
            function isReadyLeaving(){
                if(!hidIsSubmit && attIsChange){
                    if(confirm("有未提交的附件, 依旧要离开么(离开后,附件列表有可能会置空)?")){
                        $('.mce-tinymce').css({'display':'none'});
                        return true;
                    } else return false;
                }else if(!hidIsSubmit && cntIsChange){
                    if(confirm("有未提交的内容, 依旧要离开么(离开后,编辑器内容可能会置空)?")){
                        $('.mce-tinymce').css({'display':'none'});
                        return true;
                    } else return false;
                }else return true;
            }
            // 编辑器内容 监听
            $('#editor-backspace').click(function(){
                if(isReadyLeaving()){
                     $('[href="#tab-homework"]').click();
                }   
            });
            // 附件上传 初始化
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
                    'swf': '<%=path%>/uploadify/uploadify.swf       ',
                    'cancelImg': '<%=path%>/uploadify/uploadify-cancel.png',
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
                        attIsChange = true;
                        console.log('new attachment(s) has been uploaded successfully !');
                    }

                });
            });
            // 附件事件 监听
            $('#uploadify-o').click(function() {
                $('#uploadify').uploadify("settings", "formData", {
                    'scid': ThisCourse[0].scid,
                    'homeworkid': ThisCourse[0].hid
                });
                $('#uploadify').uploadify('upload', '*');
                console.log('#btn-upload-' + ThisCourse[0].hid);
            });
            $('#uploadify-s').click(function() {
                $('#uploadify').uploadify('stop', '*');
            });
            $('#uploadify-c').click(function() {
                $('#uploadify').uploadify('cancel', '*');
            });
            
            // 作业ID 监听()
            $('a[data-hid]').click(function(){
                NProgress.start();
                var hid = $(this).attr('data-hid');
                var isDone = $(this).attr('data-status') === true ? true : false;
                
                if (isDone) hidIsSubmit = true;else hidIsSubmit = false;
                if ((hid !== ThisCourse[0].hid) || (isDone)){
                    refreshHomeworkArea(hid);
                }
                
                NProgress.done();
            });
            
            // 作业提交 监听
            $('#submit-homework').click(function(){
                NProgress.start();
                if(submitHomework(ThisCourse[0].hid)){
                    hidIsSubmit = true;
                    cntIsChange = false;
                    attIsChange = false;
                };
                NProgress.done();
            });
            
           /* ==================================================================
            * 个人面板 监听器
            * ================================================================== */
            
            // 个人信息 监听器
            $('a[href="#tab-personalInfo"]').click(function(){

                $('#submit-uinfo').attr("data-submit","uinfo");
                console.log($('#submit-uinfo').attr('data-submit'));
                $('.form-control').blur(function(){
                    if(CheckValidation()){
                        $('#submit-uinfo').removeClass('disabled');
                    }else{
                        $('#submit-uinfo').addClass('disabled');
                    };
                });

                $('#submit-uinfo').addClass('disabled');
            });
            // 个人密码 监听器
            $('a[href="#tab-password"]').click(function(){
                $("#oldPassword").val("");
                $("#newPassword").val("");
                $("#newPasswordConfirm").val("");
                $('#submit-uinfo').attr("data-submit","upassword");
                console.log($('#submit-uinfo').attr('data-submit'));
                $('.form-control').blur(function () {
                    if (checkPassword()) {
                        $('#submit-uinfo').removeClass('disabled');
                    }else{
                        $('#submit-uinfo').addClass('disabled');
                    };
                });

                $('#submit-uinfo').addClass('disabled');
            });

            // submit 按钮 监听器
            $('#submit-uinfo').click(function(){
                var status = $(this).hasClass('disabled') === true ? false : true ;
                var method = $(this).attr('data-submit');

                console.log(status + " | " + method);
                if (status && (method === "uinfo")) {
                    updataPersonalInfo();
                } else if(status && (method === "upassword")){
                    console.log(status + " | " + method);
                    updataPassword();
                }

            });
            
            // 个人面板 点击事件监听器
            $("#ubox a[href^='#tab']").click(function(){
    
                var selector = $(this).attr("href");
                console.log("selector is :" + selector);

                if(selector === '#tab-personalInfo'){
                    $('#usettings a[href="#uinfo"]').click();
                }else{
                    $('#usettings a[href="#ucourses"]').click();
                }

                $("#usettings").modal().show();
                $("#usettings a[href= '" + selector + "']").click();
            });
            function bindBoxer(){
                $('.stage-card').boxer();
                console.log("rebind boxer() function in elements '.stage-card'");
            }
            $('[href="#content-CourseResource"]').click(function(){
                setTimeout(bindBoxer, 1200);
            });
            $('[id^="cid-"]').click(function(){
                setTimeout(bindBoxer, 1200);
            });
            $('.stage-card').boxer();
            
           /* ==================================================================
            * 页面 监听器
            * ================================================================== */
            var load = $('.lms-loading');
            load.fadeOut();
            load.removeClass('lms-loading');
            load.fadeIn("slow");
            NProgress.done(true);
            
            window.onbeforeunload = function() {};
        </script>
    </body>
</html>