<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    String df = (String) request.getAttribute("differrent");
%>
<%-- 
    Document   : peosonManage
    Created on : 2016-3-12, 16:49:28
    Author     : Administrator
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>peosonManage</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css"/>

        <!--JS-->
        <script  src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/base.min.js" ></script>
        <script src="<%=path%>/js/project.min.js" ></script>

    </head>
    <body class="container-full">  

        <div class="row-fluid">
            <div class="col-md-10">
                <table id="table-style" data-url="teacher" data-search ="true"  data-striped = "true" data-pagination ="true" data-toggle="table" class="table table-bordered table-responsive">
                    <thead>
                        <tr>
                            <th data-field="sn" data-width ="100" data-align ="center" data-sortable="true" >学号/工号</th>
                            <th data-field="name" data-width ="100" data-align ="center" data-sortable="true">姓名</th>
                            <th data-field="idCard" data-width ="100" data-align ="center" data-sortable="true">身份证号</th>
                            <th data-field="sex" data-width ="55" data-align ="center" data-sortable="true">性别</th>
                            <th data-field="position" data-width ="55" data-align ="center" data-sortable="true">职位</th>
                            <th data-field="tel" data-width ="100" data-align ="center" data-sortable="true">手机号</th>
                            <th data-field="qq" data-width ="100" data-align ="center" data-sortable="true">QQ</th>
                            <th data-field="control" data-width ="100" data-align ="center" data-sortable="true">操作</th>
                        </tr>

                    </thead>
                </table>
            </div>

            <div class="col-md-2">
                <from class="form-inline" role="form">
                    <div class="form-group">
                        <input type="text" id="searchtext" class="form-control" style="width: 180px" placeholder="请输入查询信息"></input>
                    </div>
                    <div class="form-group">
                        <button id="search" type="submit" class="btn btn-default btn-block">查询</button>
                    </div>

                </from>
                <div>
                    <a href="#" id="power" class="btn btn-default pull-left" >权限管理</a>
                    <a href="#" id="pwd" class="btn btn-default pull-right" >密码重置</a>
                </div>
            </div>
        </div>

        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title" id="myModalLabel">编辑老师的权限与角色</h4>
                    </div>
                    <div class="modal-body" style="width: 100%">


                        <div class="container" style="width:300px">
                            <input type="hidden" id="teasn">
                            <span id="managerolespan">

                            </span>
                            <a class="btn btn-primary" onclick="saverole()">保存更改</a>

                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
                    </div>
                </div>
            </div>
        </div>

        <script>
            var flag = 0;

            function manage(teacherId, temp) {

                $("#teasn").val(teacherId);
                var jssz = new Array();
                var jssz = [];
                jssz[0] = teacherId;
                
                if (temp === 0) {

                    document.getElementById("myModalLabel").innerHTML = "编辑老师的权限与角色";
                    $('#myModal').modal('show');
                    $.ajax({
                        type: "post",
                        url: "rolecheck",
                        data: {sn: teacherId, temp: temp},
                        success: function (data) {
                            document.getElementById("managerolespan").innerHTML = data;
                        },
                        error: function () {
                            alert("出错！");
                        }
                    });
                } else {
                    $.ajax({
                        type: "post",
                        url: "czmm",
                        data: {sn: teacherId},
                        success: function (data) {

                            if (data == 0) {
                                alert("重置成功")
                            }
                            ;
                        },
                        error: function () {
                            alert("出错！");
                        }
                    });
                }
            }
            
            function saverole(teacherId) {
                var sum = 0;
                $(":checkbox[name='rolevelue']:checked").each(function () {
                    sum = sum + parseInt(this.value);
                });
                $.ajax({
                    type: "post",
                    url: "roleset",
                    data: {sn: $("#teasn").val(), rolesum: sum},
                    success: function (data) {
                        if (data == "ok") {
                            alert("保存成功！");
                            $('#myModal').modal('hide');
                        }

                    },
                    error: function () {
                        alert("出错！");
                    }
                });
            }

            $('#search').click(function () {
                var text = document.getElementById('searchtext').value;
                text = 'search?text=' + text + "&flag=" + flag;
                $('#table-style').bootstrapTable('destroy')
                        .bootstrapTable({
                            classes: 'table table-hover',
                            striped: true,
                            url: text
                        });

            });

            $('#power').click(function () {
                flag = 0;
                $('#table-style').bootstrapTable('destroy')
                        .bootstrapTable({
                            classes: 'table table-hover',
                            striped: true,
                            url: 'teacher?a=777&b=666'
                        });
            });
            
            $('#pwd').click(function () {
                flag = 1;
                $('#table-style').bootstrapTable('destroy')
                        .bootstrapTable({
                            classes: 'table table-hover',
                            striped: true,
                            url: 'all'
                        });

            });
        </script>

    </body>
</html>
