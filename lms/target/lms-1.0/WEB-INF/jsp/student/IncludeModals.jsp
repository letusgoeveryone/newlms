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
</sec:authorize>