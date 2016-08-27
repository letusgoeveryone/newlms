<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>

    <!--页脚 o-->
    <footer class="ui-footer" id="tree-footer">
        <div class="container">
            <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
        </div>
    </footer>
    <!--页脚 x-->

