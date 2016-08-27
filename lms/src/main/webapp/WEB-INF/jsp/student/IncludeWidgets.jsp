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
    <!--模态框 模板-->
    <!--
    <div class="modal fade fix-modal-align" id="modal-" role="dialog">
        <div class="modal-dialog  container">
            <div class="modal-content">
                <div class="modal-heading"></div>
                <div class="modal-inner"></div>
                <div class="modal-footer"></div>
            </div>
        </div>
    </div>
    -->
    <!--<a class="btn" id="anchor-modal"></a>-->
    <div class="modal fade" id="modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-heading"></div>
                <div class="modal-inner"></div>
                <div class="modal-footer"></div>
            </div>
        </div>
    </div>
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
    
<!--    <div style="display: flex; padding-right: 15px;" aria-hidden="true" class="modal modal-va-middle fade modal-va-middle-show in" id="ui_dialog_example_alert" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-xs">
            <div class="modal-content">
                <div class="modal-inner">
                    <p class="h5 margin-top-sm text-black-hint">Discard draft?</p>
                </div>
                <div class="modal-footer">
                    <p class="text-right"><a class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal">Cancel</a><a class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal">Discard</a></p>
                </div>
            </div>
        </div>
    </div>
    <div style="display: none;" aria-hidden="true" class="modal modal-va-middle fade" id="ui_dialog_example_alert_alt" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-xs">
            <div class="modal-content">
                <div class="modal-heading">
                    <p class="modal-title">Use location service?</p>
                </div>
                <div class="modal-inner">
                    <p class="h5 margin-top-sm text-black-hint">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                </div>
                <div class="modal-footer">
                    <p class="text-right"><a class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal">Disagree</a><a class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal">Agree</a></p>
                </div>
            </div>
        </div>
    </div>
    <div style="display: none;" aria-hidden="true" class="modal modal-va-middle fade" id="ui_dialog_example_simple" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-xs">
            <div class="modal-content">
                <div class="modal-heading">
                    <h2 class="modal-title">Set backup account</h2>
                </div>
                <ul class="nav">
                    <li>
                        <a class="margin-bottom-sm waves-attach waves-effect" data-dismiss="modal" href="javascript:void(0)">
                            <div class="avatar avatar-inline margin-left-sm margin-right-sm">
                                <img alt="alt text for username avatar" src="images/users/avatar-001.jpg">
                            </div>
                            <span class="margin-right-sm text-black">username</span>
                        </a>
                    </li>
                    <li>
                        <a class="margin-bottom-sm waves-attach waves-effect" data-dismiss="modal" href="javascript:void(0)">
                            <div class="avatar avatar-inline margin-left-sm margin-right-sm">
                                <img alt="alt text for another_account avatar" src="images/users/avatar-001.jpg">
                            </div>
                            <span class="margin-right-sm text-black">another_account</span>
                        </a>
                    </li>
                    <li>
                        <a class="margin-bottom-sm waves-attach waves-effect" data-dismiss="modal" href="javascript:void(0)">
                            <div class="avatar avatar-inline margin-left-sm margin-right-sm">
                                <span class="icon icon-lg text-black">add</span>
                            </div>
                            <span class="margin-right-sm text-black">add account</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    -->
</sec:authorize>