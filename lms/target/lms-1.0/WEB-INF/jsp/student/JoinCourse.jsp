<%-- 
    Document   : stu_addcourse
    Created on : 2016-2-27, 16:11:12
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

<script  src="<%=path%>/js/md5.js"></script>
<script>
    $(function () {
        $("#subcor").hide(0);
        $('#tree').treeview({
            data: ${Course},
            onNodeSelected: function (event, node) {

                var p1 = $('#tree').treeview('getParent', $('#tree').treeview('getParent', node)).text;
                var p2 = $('#tree').treeview('getParent', node).text;
                if (p2.length == 1 || p1.length == 1) {
                    //('#tree').treeview('expandNode', [ node, { levels:1, silent:true }]);
                    $("#submas")[0].innerHTML = "";
                    $("#submas2")[0].innerHTML = "";
                    $("#submas3")[0].innerHTML = "";
                    $("#cidinput").val("-1");
                    $("#subcor").hide(0);
                    return flase;
                }
                $("#submas")[0].innerHTML = p1 + ">>" + p2 + ">>" + node.text;
                $("#cidinput").val(node.coid);
                $("#subcor").show(200);
                $("#submas2")[0].innerHTML = "";
                $("#submas3")[0].innerHTML = "";
                $.post("<%=path%>/student/getkcjs", {cid: $("#cidinput").val()},
                function (data) {
                    $("#submas2")[0].innerHTML = data[1];
                    $("#submas3")[0].innerHTML = data[0];

                });


            },
            onNodeExpanded: function (event, node) {

                var p1 = $('#tree').treeview('getParent', $('#tree').treeview('getParent', node)).text;
                var p2 = $('#tree').treeview('getParent', node).text;
                if (p2.length == 1 || p1.length == 1) {
                    $("#submas")[0].innerHTML = "";
                    $("#submas2")[0].innerHTML = "";
                    $("#submas3")[0].innerHTML = "";
                    $("#cidinput").val("-1");
                    $("#subcor").hide(0);
                }
            }
        });

        $("#subcor").click(function () {
            $.post("<%=path%>/student/subcourse", {cid: $("#cidinput").val()},
            function (data) {
                if (data == "0") {
                    alert("\n\n出错了，可能的原因：重复选课（如果您已经提交申请 请等待老师的确认）\n或者提交的数据有误，请尝试重新登录后再试。\n\n")
                }
                ;
                if (data == "1") {
                    alert("\n\nok,您的选课信息已被系统接收，等待任课老师确认。\n\n");
                    window.parent.refleshspan();
                }
                ;
            });
        });

    });
</script>

<div style="width:23%;float: left;">
    <div id="tree"></div>     
</div>
<div style="width:76%;float: right;">
    <div class="tabbable" id="tabs-974895 setwidth">
        <ul class="nav nav-tabs settabs">
            <li class="active"><a href="#panel-236368" data-toggle="tab">课程说明</a></li>
            <li><a href="#panel-86366" data-toggle="tab" onclick="setheight()">课程大纲</a></li>

        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="panel-236368">
                <p><label  id="submas"> </label>  </p>
                <p><a class="btn btn-primary btn-large" id="subcor">提交选课申请»</a></p>
                <p><label  id="submas2"> </label> </p>



                <input type="hidden" id="cidinput" value="-1">
                </p>
            </div>
            <div class="tab-pane" id="panel-86366">
                <label  id="submas3"> </label>
            </div>

        </div>
    </div>
</div>
