<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/easyui.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/icon.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/demo.css">
        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/easyuijs/jquery.easyui.min.js"></script>
    </head>
    <body>
        <div style="margin:20px 0;"></div>
        <div class="easyui-layout" style="width:800px;height:600px;">
            <!--<div data-options="region:'north'" style="height:50px"></div>-->
            <!--<div data-options="region:'south',split:true" style="height:50px;"></div>-->
            <div data-options="region:'east',split:true" title="East" style="width:180px;">
                <ul class="easyui-tree" data-options="url:'tree_data1.json',method:'get',animate:true,dnd:true"></ul>
            </div>
            <div data-options="region:'west',split:true" title="West" style="width:100px;">
                <div class="easyui-accordion" data-options="fit:true,border:false">
                    <div title="Title1" style="padding:10px;">
                        content1
                    </div>
                    <div title="Title2" data-options="selected:true" style="padding:10px;">
                        content2
                    </div>
                    <div title="Title3" style="padding:10px">
                        content3
                    </div>
                </div>
            </div>
            <div data-options="region:'center',title:'课程',iconCls:'icon-ok'">
                <div class="easyui-tabs" data-options="fit:true,border:false,plain:true">
                    <div title="课程介绍" data-options="href:'_content.html'" style="padding:10px">


                    </div>
                    <div title="课程大纲" style="padding:5px">

                        <table class="easyui-datagrid"
                               data-options="url:'datagrid_data1.json',method:'get',singleSelect:true,fit:true,fitColumns:true">
                            <thead>
                                <tr>
                                    <th data-options="field:'itemid'" width="80">Item ID</th>
                                    <th data-options="field:'productid'" width="100">Product ID</th>
                                    <th data-options="field:'listprice',align:'right'" width="80">List Price</th>
                                    <th data-options="field:'unitcost',align:'right'" width="80">Unit Cost</th>
                                    <th data-options="field:'attr1'" width="150">Attribute</th>
                                    <th data-options="field:'status',align:'center'" width="50">Status</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div title="课程内容" style="padding:5px">课程内容</div>
                    <div title="课程介绍修改" style="padding:5px">你可以上传ｗord，flash,视频<br><br><br><br>
                        <div style="text-align: center">
                            <form  method="POST" enctype="multipart/form-data" action="course_submit" id="zl">
                                <input type="file"  name="file">  <br>
                                课程介绍描述:  <input type="text"  name="desc">
                                <!--<input type="submit" value="课程介绍上传" >-->
                                <input type="button" value="课程介绍上传" onclick="sc_zl()">
                            </form>

                            <input type="button" onclick="kecheng_jieshao_xiazai()" value="课程介绍下载">
                            <input type="button" onclick="kecheng_jieshao_shanchu()" value="课程介绍删除">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function sc_zl() {
                var formData = new FormData($("#zl")[0]);
                $.ajax({
                    url: 'course_submit',
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (returndata) {
                        alert(returndata);
                    },
                    error: function (returndata) {
                        alert("submit error!");
                    }
                });

            }

        </script>
    </body>
</html>