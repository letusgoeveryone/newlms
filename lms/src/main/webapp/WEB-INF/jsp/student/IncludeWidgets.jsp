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
    <!--模态框-->
    
    <div class="modal fade" id="modal-is" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-heading"></div>
                <div class="modal-inner"></div>
                <div class="modal-footer">
                    <p class="text-right">
                        <a class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" id="is-yes">Continue</a>
                        <a class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" id="is-no">No</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <!--消息盒子-->
    <div class="modal fade" id="ubox" role="dialog">
        <div class="modal-dialog" style="max-width: 960px;">
            <div class="modal-content tab-content" >
                
                <nav class="tab-nav tab-nav-brand no-margin" hidden="">
                    <ul class="nav nav-list nav-justified">
                        <li >
                            <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#">
                                <span class="text-grey"></span>
                            </a>
                        </li>
                        <li>
                            <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#">
                                <span class="text-grey"></span>
                            </a>
                        </li>
                    </ul>
                </nav>
                
                <div class="tab-pane fade row mg" id=""></div>
                
                
                
            </div>
        </div>
    </div>
                          
    <!--个人信息-->
    <div id="uinfo-wrap" style="display: none;">
    <div id="uinfo" >
        <div class="modal-dialog" style="max-width: 960px;">
            <div class="row" style="padding: 30px;">
                <div class="tab-content divider-right col-sm-5">
                    <!--基础资料-->
                    <div class="tab-pane fade in active" id="tab-personalInfo" >
                        <form>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="sn"> 学号 </label>
                                <input class="form-control" id="sn" type="text" value="{{sn}}" disabled="">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="name"> 姓名 </label>
                                <input class="form-control" id="name" type="text" value="{{name}}">
                                <div id="validMsg-name" hidden>请输入至少两个汉字</div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="ID"> 身份证 </label>
                                <input class="form-control" id="ID" type="text" value="{{ID}}">
                                <div id="validMsg-ID" hidden>您输入的身份证格式不正确</div>
                            </div>
                            <div class="form-group form-group-label">

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="boy">
                                        <input class="access-hide form-control" id="boy" name="sex" type="radio">男生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="girl">
                                        <input class="access-hide form-control" id="girl" name="sex" type="radio">女生
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
                                <div id="validMsg-tel" hidden>请输入正确的手机号</div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="qq"> QQ </label>
                                <input class="form-control" id="qq" type="text" value="{{qq}}">
                                <div id="validMsg-qq" hidden>请输入正确QQ号</div>
                            </div>
                        </form>
                    </div>
                    <!--密码设置-->
                    <div class="tab-pane fade" id="tab-password">
                        <form>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="oldPassword"> 原始密码 </label>
                                <input class="form-control" id="oldPassword" type="password">
                                <div id="validMsg-opw" hidden></div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="newPassword"> 新密码 </label>
                                <input class="form-control" id="newPassword" type="password" placeholder="密码最短为6位">
                                <div id="validMsg-npw" hidden></div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="newPasswordConfirm"> 确认密码  </label>
                                <input class="form-control" id="newPasswordConfirm" type="password">
                                <div id="validMsg-npwconfirm" hidden></div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-sm-7"  style="padding-left: 45px;" >
                    <div class="card">
                        <div class="uinfo-blur"></div>
                        <div class="card-main">
                            <div class="card-inner">
                                <img alt="" class="img-circle img-rounded img-pinfo" id="img-pinfo" src="<%=path%>/images/avatar.jpg" height="230" width="230">
                                <a class="btn btn-flat text-link">
                                    修改头像 <span class="icon icon-edit"></span>
                                </a>
                            </div>
                            <div class="card-action">
                                <div class="card-action-btn btn btn-block btn-flat btn-dashed disabled" id="submit-uinfo" data-submit="uinfo" >
                                    提交修改
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="card no-padding">
                        <div class="card-main">
                            <nav class="tab-nav tab-nav-brand no-margin">
                                <ul class="nav nav-list nav-justified">
                                    <li class="active">
                                        <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#tab-personalInfo">
                                            <span class="text-grey">个人信息</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#tab-password">
                                            <span class="text-grey">密码设置</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                    </div>
                </div>
            </div>
        </div>
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
    
</sec:authorize>