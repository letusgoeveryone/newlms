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
        .menu-top{
            margin-bottom: 86px;
        }
        .menu-top-info{
            padding: 0;
            height: 56px;
            line-height: 56px;
            position: absolute;
            width: 100%;
            background-color: indianred;
            padding-left: 15px;
            box-shadow: 0 0 2px #000;
            font-size: 18px;
        }
    </style>
    
    <div class="menu-scroll">
                
        <div class="menu-top">
            <div class="menu-top-info">
                <span class="icon icon-lg  mg-sm-right">menu</span>设置中心</a>
            </div>
        </div>
        
        <div class="menu-content container-fluid">

            <div class="row">
                <nav class="col-md-3 fix-menu-nav">
                    <ul class="nav" id="anchor-vstatus">
                        <li class="sn-l">
                            <a class="sn-a" href="javascript:void(0)">
                                <span class="icon mg-sm-right">info</span>个人信息
                            </a>
                        </li>
                        <li class="sn-lu active">
                            <a class="waves-attach waves-effect" data-toggle="tab" href="#tab-personalInfo">基础资料</a>
                        </li>
                        <li class="sn-lu">
                            <a class="waves-attach waves-effect" data-toggle="tab" href="#tab-password">密码设置</a>
                        </li>
                        <li class="sn-l">
                            <a class="sn-a" href="javascript:void(0)">
                                <span class="icon mg-sm-right">class</span>课程管理
                            </a>
                        </li>
                        <li class="sn-lu">
                            <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-course-selected">
                                已选课程
                            </a>
                        </li>
                        <li class="sn-lu">
                            <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-course-selectable">
                                可选课程
                            </a>
                        </li>
                        <!--                        
                        <li class="sn-lu">
                            <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-course-permit">
                                已批准课程
                            </a>
                        </li>
                        -->
                        <li class="sn-lu">
                            <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-course-notpermit">
                                待批准课程
                            </a>
                        </li>
                        <li class="sn-l">
                            <a class="sn-a" href="javascript:void(0)">
                                <span class="icon mg-sm-right">view_quilt</span>其它
                            </a>
                        </li>
                        <li class="sn-lu">
                            <a class="waves-attach waves-effect" data-toggle="tab"  href="#tab-plugin">
                                插件管理
                            </a>
                        </li>
                        <li class="sn-l">
                            <a class="waves-attach waves-effect sn-a cursor-pointer" href="<%=path%>/logout">
                                <span class="icon mg-sm-right">exit_to_app</span> 注销
                            </a>
                        </li>
                    </ul>
                </nav>

                <div class='col-md-9 tab-content'>
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

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="boy">
                                        <input class="access-hide" id="boy" name="sex" type="radio">男生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="girl">
                                        <input class="access-hide" id="girl" name="sex" type="radio">女生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="college"> 学院 </label>
                                <select class="form-control" id="college" value="">
                                    <option value="{{college}}"> {{college}} </option>
                                    {{{schoolCollegeList}}}
                                </select>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="grade"> 年级 </label>
                                <select class="form-control" id="grade" value="">
                                    <option value="{{grade}}"> {{grade}} </option>
                                    {{{schoolYearsList}}}
                                </select>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="tel"> 联系方式 </label>
                                <input class="form-control" id="tel" type="text" value="{{tel}}">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="qq"> QQ </label>
                                <input class="form-control" id="qq" type="text" value="{{qq}}">
                            </div>


                            <div class="btn btn-block  btn-card btn-card-darken" onclick="updataPersonalInfo()">
                                确认
                            </div>
                        </form>
                    </div>
                    <!--密码设置-->
                    <div id="tab-password" class="tab-pane fade">
                        <form>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="oldPassword"> 原始密码 </label>
                                <input class="form-control" id="oldPassword" type="password">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="newPassword"> 新密码 </label>
                                <input class="form-control" id="newPassword" type="password" >
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="newPasswordConfirm"> 确认密码  </label>
                                <input class="form-control" id="newPasswordConfirm" type="password">
                            </div>

                            <div class="btn btn-block btn-card btn-card-darken" onclick="updataPassword()">
                                确认
                            </div>
                        </form>
                    </div>
                    <!--已选课程-->
                    <div id="tab-course-selected" class="tab-pane fade">
                        {{{OCourseTableHF}}}
                    </div>
                    <!--可选课程-->
                    <div id="tab-course-selectable" class="tab-pane fade">
                        {{{XCourseTableHF}}}
                    </div>
                    <!--已批准课程-->
                    <div id="tab-course-permit" class="tab-pane fade">
                        2
                    </div>
                    <!--未批准课程-->
                    <div id="tab-course-notpermit" class="tab-pane fade">
                        {{{ICourseTableHF}}}
                    </div>

                    <!--插件管理-->
                    <div id="tab-plugin" class="tab-pane fade">
                        <div id="Jihuajiyi" style=";width: 100%;border: none;color: #f6f6f6;"></div> 
                    </div>
                </div>
            </div>
        </div>
    </div>

</sec:authorize>
