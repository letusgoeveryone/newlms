<%-- 
    Document   : stu_course
    Created on : 2016-2-27, 11:15:12
    Author     : 刘昱
--%>
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
<script type="text/javascript">

    $(function () {
        switch (window.location.hash) {
            case '#zy':
                //alert(66); 
                $('#tabs-974895 a[href="#panel-86365"]').tab('show');
//                $('#panel-236368').tab('hide');
//                $('#panel-86365').tab('show');
                break;
        }


        $('#tt1').tree({
            onClick: function (node) {
                var node2 = $('#tt1').tree('getParent', node.target);
                var dir = "";
                if (node2 === null) {
                    dir = "/" + node.id + "/";
                } else {
                    var node1 = $('#tt1').tree('getParent', node2.target);
                    if (node1 === null) {
                        dir = "/" + node2.id + "/" + node.id + "/";
                    } else {
                        dir = "/" + node1.id + "/" + node2.id + "/" + node.id + "/";
                    }
                }
                $.post("<%=path%>/student/courdir", {scid:${scid}, dir: dir},
                        function (data) {
                            document.getElementById("hfText").innerHTML = data;
                            document.getElementById("swfplayer").src = "about:blank";
                        });
            }
        });
    });
    //<a class="btn btn-primary btn-large" href="quitcourse?scid=${scid}">我知道了，我要继续删除»</a>


    function setheight(a) {
        if (a == 1) {
            document.getElementById("swfplayer").src = "about:blank";
        }
        // parent.iFrameHeight();
    }
    ;

</script>

<div class="tabbable" id="tabs-974895">
    <ul class="nav nav-tabs settabs">
        <li class="active"><a href="#panel-236368" data-toggle="tab" onclick="setheight(1)">课程介绍</a></li>
        <li><a href="#panel-86366" data-toggle="tab" onclick="setheight(1)">课程大纲</a></li>
        <li><a href="#panel-86367" data-toggle="tab" onclick="setheight(2)">课程内容</a></li>
        <li><a href="#panel-86365" data-toggle="tab" onclick="setheight(1)">作业区</a></li>
        <li style="float:right"><a href="#panel-86369" data-toggle="tab" onclick="setheight(1)">退出该课程</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="panel-236368">
            ${syllabusspan}

        </div>
        <div class="tab-pane" id="panel-86366">
            <span  id = "hfText2"><br>${Coursesb}</span>
            <div> ${CourseDescription}</div>
        </div> 
        <div class="tab-pane" id="panel-86365">

            <table class="table">
                <thead>
                    <tr><th>序号</th><th>作业名称</th><th>作业状态</th><th>截止时间</th><th>操作</th></tr>
                </thead>
                <tbody>

                    ${homework}
                </tbody>
            </table>


        </div>        
        <div class="tab-pane" id="panel-86367">

            <div style="width: 20%;float: left;">
                <ul id="tt1"  class="easyui-tree" data-options="
                    url:'kcgs?scid='+${scid},
                    method: 'get',
                    animate: true ">        
                </ul></div>  
            <div style="width: 78%;float: right;">
                <span  id = "hfText"></span>
                <iframe src="" id="swfplayer" frameborder="0" scrolling="no" marginheight="0" height="450px" width="600px" name="swfplayer"></iframe>
            </div>                         

        </div>
        <div class="tab-pane" id="panel-86369">
            <div class="hero-unit">
                <h1 style="font-color:red;">
                    请慎重操作！
                </h1>
                <p style="font-color:red;">
                    退出该课程意味着您的所有作业及其他与该课程相关的内容均会被删除。
                </p>
                <p>

                    <a class="btn btn-primary btn-large" onclick="quitcourse()">我知道了，我要继续删除»</a>
                </p>
            </div>
        </div>
    </div>
</div>
