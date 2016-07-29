<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<sec:authorize access="hasRole('ROLE_STUDENT') or hasRole('ROLE_ADMIN')">
    <style>
        #tab-personalInfo>form,
        #tab-password>form{
            width: 500px;
            margin: auto;
        }
        .fix-tab-plugin>a,
        .fix-tab-plugin>a:hover,
        .fix-tab-plugin>a:focus{
            background-color: whitesmoke !important;
        }
        
    </style>
    <nav class="menu menu-left" id="menu-settings">
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


                                <div class="btn btn-block  btn-card btn-card-darken">
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
                            2
                        </div>
                        <!--可选课程-->
                        <div id="tab-course-selectable" class="tab-pane fade">
                            2
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
    </nav>

</sec:authorize>
