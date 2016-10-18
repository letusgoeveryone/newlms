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
        <title>『学生』| 教务系统</title>

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
    <body class="page-brand container-full tab-content" id="lms_stu">
        
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
                <li class="dropdown">
                    <a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown" >
                        <span class="access-hide">Avatar</span>
                        <span class="avatar avatar-sm"><img alt="avatar" src="<%=path%>/images/avatar.svg" id="uavatar-small"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li class="">
                            <a class="waves-attach waves-effect" href="<%=path%>/logout">
                                <span class="icon mg-sm-right">exit_to_app</span> 登出
                            </a>
                        </li>
                        <!--                        <li>
                                                    <a class="padding-right-lg waves-attach waves-effect" href="javascript:void(0)"><span class="icon mg-sm-right">account_box</span>帮助</a>
                                                </li>
                                                <li>
                                                    <a class="padding-right-lg waves-attach waves-effect" href="javascript:void(0)"><span class="icon mg-sm-right">add_to_photos</span>报告BUG</a>
                                                </li>-->
                    </ul>
                </li>
            </ul>
        </header>
                
        <!--学生区 主区-->
        <div id='lms_main' class="tab-pane fade in active sample-height">

            <div class="container">
                <div class="row">
                    <div class="pd-content-htop"></div>

                    <!--个人面板-->
                    <div class="col-sm-4" id="upanel">
                        <div class="card">
                            <div class="vcard">

                                <div class="vcard-avatar-wrapper">
                                    <a alt="Change your avatar" class="vcard-avatar">
                                        <img alt="" class=" img-rounded" src="<%=path%>/images/avatar.svg" height="230" width="230" id="uavatar">
                                    </a>
                                </div>

                                <div class="vcard-names">
                                    <p class="vcard-fullname" >{{name}}</p>
                                    <p class="vcard-id" >ID: {{sn}} ( {{grade}}级 )</p>
                                </div>

                                <ul class="vcard-details">
                                    <li alt="Home location" class="vcard-detail" title="China">
                                        <span class="icon">person_outline</span> {{college}}
                                    </li>
                                    <li alt="QQ" class="vcard-detail">
                                        <span class="icon">chat_bubble_outline</span> <b>扣扣:</b> {{qq}}
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </div>
                    <!--个人面板 END-->

                    <!-- 导航面板 -->
                    <div class="col-sm-8"> 
                        <div class="card">

                            <aside class="card-side pull-left">
                                <sec:authorize access="hasRole('ROLE_STUDENT')">
                                    <a  href="#" class='fbtn fbtn-lg  btn-golden'>
                                        S<span class="fbtn-text fbtn-text-left">我的角色：学生</span>
                                    </a>
                                </sec:authorize>
                            </aside>
                            <div class="card-main">
                                <div class="card-inner">
                                    <section class="card-heading">导航面板</section>
                                    <section>
                                        <a class='btn btn-aqua mg-rt-3x' onclick="initCourse()">
                                            【我的课程】
                                        </a>
                                        <a data-toggle="tab" href="#ucontent" id="anchor-mcourse" class='hidden' title="【课程锚点】">
                                            
                                        </a>
                                        <a href="#uinfo-wrap" data-lightbox-height="700" data-lightbox-width="1000" class='btn btn-aqua stage-card'>
                                            【个人中心】
                                        </a>
                                        <a href="student/courses" class='btn btn-aqua'>
                                            【选课中心】
                                        </a>
                                    </section>
                                </div>
                                <div class="card-action">
                                    <div class="card-action-btn" style="margin:6px 16px;">
                                        <a href="#uinfo-wrap" data-lightbox-height="700" data-lightbox-width="1000" class="btn btn-flat stage-card lms-c-text-light waves-attach pull-right" style="text-align: right;"> 查看 / 修改 个人信息<span class="icon margin-left-sm">open_in_new</span> </a>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>      
                    <!-- 导航面板 END--> 
                    
                    <!--我的课程-->
                    <div class="col-sm-8">
                        
                    </div>
                    <!--我的课程 END-->
                    
                </div>
            </div>
            <!--学生区 主区 END-->
        </div>
        <!--学生区 END-->
        

        <!--学生 课程区-->
        <div  id="ucontent" class="row tab-pane fade " style="min-height: 1000px;">          
            <div class="bg-content"></div>
            <div class="pd-content-htop"></div>
                    
            <jsp:include page="Ucourses.jsp" />

        </div>
        <!--学生 课程区 END-->


        <footer class="ui-footer" id="tree-footer">
            <div class="container">
                <p >
                    <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
                </p>
            </div>
        </footer>
        
        <!--Uinfo-->
        <jsp:include page="Uinfo.jsp" />
        
        <!--scrollUp-->
        <div class="fbtn-container" id="scrollUp">
            <div class="fbtn-inner">
                <a class="fbtn fbtn-brand waves-attach waves-circle">
                    <span class="fbtn-text fbtn-text-left">返回顶部</span>
                    <span class="fbtn-ori icon">keyboard_arrow_up</span>
                </a>
            </div>
        </div>
        
        <!--附件-->
        <div class="modal fade" id="modal-uploadify" role="dialog">
            <div class="modal-dialog modal-xs">
                <div class="modal-content">
                    <div class="modal-heading">
                        <h4>我的附件</h4>
                    </div>
                    <div class="modal-inner">
                        <h5>文件上传</h5>
                        <hr>
                        <input type="file" name="uploadify" id="uploadify" />
                        <a class="btn btn-flat btn-green" id="uploadify-o"><span class="icon">file_upload</span></a>
                        <a class="btn btn-flat btn-default" id="uploadify-s" ><span class="icon">pause</span></a>
                        <a class="btn btn-flat text-grey" id="uploadify-c" ><span class="icon">stop</span></a>

                        <hr>
                        <h5>已传文件</h5>
                        <div id="uploaded-area" class="table-responsive">

                        </div>
                        <hr>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>

        <!--单向信息传递 snackbar-->
        <div id="snackbar"></div>
        
        <!-- js -->
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script><script>NProgress.set(0.7);</script>
        <script src="<%=path%>/js/api.student.js" type="text/javascript"></script>
        <script src="<%=path%>/js/api.file.js" type="text/javascript"></script>
        <script src="<%=path%>/js/tinymce/tinymce.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.fs.core.js" type="text/javascript"></script>
        <script src="<%=path%>/js/formstone/js/transition.js" type="text/javascript"></script>
        <script src="<%=path%>/js/jquery.fs.boxer.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
        <link href="<%=path%>/uploadify/uploadify.css" rel="stylesheet" type="text/css"/>
        <script src="<%=path%>/uploadify/jquery.uploadify.js" type="text/javascript"></script>
        <!--<script src="http://open.iciba.com/huaci/huaci.js"></script>-->
        <script>
            NProgress.set(0.9);
            
            var PATH = '<%=path%>';

           /* ==================================================================
            * 作业 监听器
            * ================================================================== */
            
            var hidIsSubmit = true;
            var attIsChange = false;
            var cntIsChange = false;
            
            // 编辑器 监视提醒
            function isSafeLeaving(){
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
            };
            
            // 编辑器内容 监听
            $('#editor-backspace').click(function(){
                if(isSafeLeaving()){
                     $('[href="#tab-homework"]').click();
                }   
            });
            
            // 附件上传 初始化
            StudentAPI.ThisHomework.uploadify.configure = function () {
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
                    'fileTypeExts': '*.docx;*.doc;*.xls;*.xlsx;*.ppt;*.pptx;*.zip;*.rar;*.7z;*.txt;*.odt;*.odg;*.ods;*.odp', //指定文件格式
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
                        updateUploadedContent();
                        attIsChange = true;
                        console.log('new attachment(s) has been uploaded successfully !');
                    }

                });
            };
            
            // 附件事件 监听
            $('#uploadify-o').click(function() {
                $('#uploadify').uploadify("settings", "formData", {
                    'scid': ThisCourse.cid,
                    'homeworkid': ThisHomework.hid
                });
                $('#uploadify').uploadify('upload', '*');
                console.log('#btn-upload-' + ThisHomework.hid);
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
                if ((hid !== ThisHomework.hid) || (isDone)){
                    updateHomeworkContent(hid);
                }
                $('anchor-heditor').click();
                
                NProgress.done();
            });
            
            // 作业提交 监听
            $('#submit-homework').click(function(){
                NProgress.start();
                if(submitHomework(ThisHomework.hid)){
                    hidIsSubmit = true;
                    cntIsChange = false;
                    attIsChange = false;
                };
                NProgress.done();
            });
            
            // 个人面板 点击事件监听器
            $("#upanel a[href^='#tab']").click(function(){
    
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
                $('.stage-card').lightbox();
                console.log("rebind boxer() function in elements '.stage-card'");
            }
            
            $('[id^="cid-"]').click(function(){
                setTimeout(bindBoxer, 1200);
            });
            
            $('.stage-card').lightbox();
            
           /* ==================================================================
            * 页面 监听器
            * ================================================================== */
            var load = $('.lms-loading');
                load.fadeOut();
                load.removeClass('lms-loading');
                load.fadeIn("slow");
            
            window.onbeforeunload = function() {};
            
        </script>
        <script>
            //配置相关参数
            FileManageAPI.configure({
                cid:'cid-resource-content', 
                nid:'cid-resource-nav', 
                hid:'cid-resource-home', 
                pid:'cid-resource-npd', 
                sid:'cid-resource-search',
                getOM:StudentAPI.FileManage.getOM,
                
                getPlayPath:StudentAPI.ThisCourse.getPlayPath,
                getPreviewPath:StudentAPI.ThisCourse.getPreviewPath,
                getDownloadPath:StudentAPI.ThisCourse.getDownloadPath
            });
            
            // 配置数据绑定的元素对象 id
            StudentAPI.configure({
                ci:'cid-content-intro',
                co:'cid-content-outline',
                n:'course-list',
                hi:'cid-homework-doing',
                ho:'cid-homework-done',
                hx:'cid-homework-miss',
                setCresourceDS: FileManageAPI.TOC.set,
                structureCresourceBrowser: FileManageAPI.BrowseDB.set
            });
            
           /* ==================================================================
            * 页面初始化
            * ================================================================== */
            init();
            
            UavatarSrc = PATH + '/images/avatar/' + getAvatarId(StudentAPI.avatar) + '.svg';
            setAvatar(UavatarSrc);
                
            NProgress.done(true);
        </script>
    </body>
</html>