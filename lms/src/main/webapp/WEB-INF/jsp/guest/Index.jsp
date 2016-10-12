<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String sessionid = session.getId();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>河大学软院教务系统</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css" />
        <script src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/vue.js"></script>
        <!-- <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet"> -->
        <style media="screen">
            html, body {
                height: 100%;
                width: 100%;
                overflow:hidden;
                color:#FFF;
            }
            #course-nav{
                border-right: 1px solid rgba(177, 175, 175, 0.72);
                background-color:#489887;
                padding: 0;
            }
            #fix-001{
                margin: 1em;
                font-size: 16px;
                padding-top: 20px;
                border-bottom: 1px solid whitesmoke;
                padding-bottom: 15px;
                font-weight: 700;
                min-width:200px;
            }
            #course-list{
            }
            #course-list li{
                list-style: none;
            }
            #course-list li:hover{
                background-color: #2D685B;
            }
            #course-list li a{
                display:block;
                color:#FFF;
                font-size: 12px;
                text-align: left;
                padding: 1em 15px;
                line-height: 2em;
                min-height: 4em;
            }
            #course-content{
                position: relative;
                overflow-y: scroll;
            }
            #course-content .tab-pane{
                color: #212121;
                padding: 15px;
            }
            #tab-course-list {
                box-shadow: none;
                margin: 0 auto;
                padding: 0;
            }

            #tab-course-list .nav> li> a::after {
                border: none !important;
                height: 100%;
            }

            #tab-course-list .tab-nav-indicator {
                display: none;
            }

            #tab-course-list>ul {}

            #tab-course-list .active{
                background: rgba(0,0,0,.1);
            }

            #tab-course-list .btn::after {
                background-color: transparent;
                box-shadow: none;
            }
            #tab-course-list .nav> li> a:hover::after {
                opacity: 1;
            }
            
            #f_reg_btn_grp{
                position: absolute;
                left: 0;
                right: 0;
                bottom: 0;
            }
            #f_reg_btn_grp>div{
                width: 50%;
                float: left;
                margin: 0;
            }
            #f_reg_btn_grp>div>a{
                display: block;
                text-align: center;
                background-color: whitesmoke;
                padding: 1em;
                border-radius:0;
                color:#2D685B;
            }
            #f_reg_btn_grp>div>a:hover{
                background-color: #59a999;
                transition: all 0.3s;
                color:#fff;
            }
            .card {
                box-shadow: 0 -1px 0 RGBA(72, 152, 135, 0.09),0 0 2px rgba(39, 39, 39, 0.5),0 2px 4px rgba(0, 0, 0, 0.75);
                padding-bottom:20px;
            }
        </style>
    </head>


    <body id="lms-guest" class="height-control stage-image" style="background-image:url(<%=path%>/images/bg-for-role.jpg)">

        <header>
            
        </header>
        <div id="lms_guest_cview" class="container height-control">
            <div class="row height-control width-control card">
                <nav class="col-md-3  stage-image" id="course-nav" >
                     <!--data-toggle="collapse" data-target="#course-list" collapse in-->
                    <div class="page-header">
                        <div class="center-block" id="fix-001">课程列表<span class="pull-right"> = </span></div>
                    </div>
                     <nav class="tab-nav no-margin" id="tab-course-list">
                         <ul  id="course-list" class="nav course-list">
                             {{{courseliset}}}
                         </ul>
                     </nav>
                    <div id="f_reg_btn_grp" class="btn-group-justified">
                        <div><a href="<%=path%>/reg/role" class="btn btn-flat  waves-attach waves-light waves-effect">注册</a> </div>
                        <div><a href="<%=path%>/login" class="btn btn-flat waves-attach waves-light waves-effect">登录</a> </div>
                    </div>
                </nav>
                <div class="col-md-9 sample-height tab-content" id="course-content">
                    <nav class="tab-nav tab-nav-brand no-margin" style="top:23.5px;">
                        <ul class="nav nav-list">
                            <li class="active">
                                <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#c-introduction">
                                    <span class="text-grey">课程简介</span>
                                </a>
                            </li>
                            <li>
                                <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#c-syllabus">
                                    <span class="text-grey">课程大纲</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                    <div class="box-small"></div>
                    <div class="tab-pane fade in active" id="c-introduction"> 
                        {{{syllabus}}}
                    </div>
                    <div class="tab-pane fade" id="c-syllabus"> 
                        {{{introduction}}}
                    </div>
                </div>

            </div>
        </div>
        <!--  主页 结束--> 
        
        <!--单向信息传递 snackbar-->
        <div id="snackbar"></div>
        
        <!--  主页页尾 开始 -0->
        <footer class="ui-footer" id="tree-footer">
            <div class="container">
                <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
            </div>
        </footer>
        <!--  主页页尾 结束 --> 
        <!-- 背景 顶部 --> 
        
        <!--js-->
        <script src="<%=path%>/js/api.guest.js" type="text/javascript"></script>
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script>
            var ThisCourse = GuestAPI.ThisCourse;
            
            // 绑定 课程详情对象
            var CourseContent = new Vue({
                el: '#course-content',
                data: {
                    introduction: '',
                    syllabus: ''
                }
            });
            
            // 绑定 课程导航对象
            var CourseNav = new Vue({
                el: '#course-list',
                data: {
                    courseliset: ''
                }
            });
            
            // 初始化页面
            function initPage(){
                GuestAPI.setDS.CourseListDS();
                if(GuestAPI.CourseListDS[0] !== undefined){
                    
                    // 初始化 课程列表
                    CourseNav.$data.courseliset = GuestAPI.analyzeDS.CourseList.getListHS();
                    
                    /**
                     * 获得已选课程的第一个,加以初始化
                     */
                    var cid = GuestAPI.CourseListDS[0].cid;
                    GuestAPI.setDS.CidIsCourse(cid);
                    ThisCourse.cid = cid; 
                    CourseContent.$data.introduction = ThisCourse.obj.introduction;
                    CourseContent.$data.syllabus = ThisCourse.obj.syllabus;
                }else{
                    CourseNav.$data.courseliset = '<li><a>暂无课程</a></li>';
                    CourseContent.$data.introduction = GuestAPI.DemonCourse.obj.introduction;
                    CourseContent.$data.syllabus = GuestAPI.DemonCourse.obj.syllabus;
                }
            }
            
            // 更新 课程详情
            function updataCourseArea(cid){
                    if(GuestAPI.setDS.CidIsCourse(cid)){
                        ThisCourse.cid = cid; 
                        CourseContent.$data.introduction = ThisCourse.obj.introduction;
                        CourseContent.$data.syllabus = ThisCourse.obj.syllabus;
                    }else{
                        CourseContent.$data.introduction = GuestAPI.DemonCourse.obj.introduction;
                        CourseContent.$data.syllabus = GuestAPI.DemonCourse.obj.syllabus;
                    }
            }
            
            function reinitIframe(){
                var iframes = document.getElementsByClassName('iframe-auto-adapt');

                for(var i=0; i<iframes.length; i++){
                    var iframe = iframes[i];
                    try{
                        var bHeight = iframe.contentWindow.document.body.scrollHeight;
                        var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                        //var height = Math.max(bHeight, dHeight);
                        var height = bHeight;

                        iframe.height = height;
                        console.log('b: '+ bHeight);
                        console.log('d: '+ dHeight);

                    }catch (ex){}
                }
            }   
        
            //window.setInterval(reinitIframe, 200);
            
            // 初始化页面 !
            initPage();
        </script>
    </body>
</html>
