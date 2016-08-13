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
        <link href="<%=path%>/table/dist/bootstrap-table.min.css" rel="stylesheet" type="text/css"/>

        <!--JS-->
        <script  src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/base.min.js" ></script>
        <script src="<%=path%>/js/project.min.js" ></script>
        <script src="<%=path%>/table/dist/bootstrap-table.min.js" type="text/javascript"></script>
        <script src="<%=path%>/table/dist/bootstrap-table-locale-all.min.js" type="text/javascript"></script>

    </head>
    <body class="container-full" style="padding-bottom: 100px;">  

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
                    <tbody>
                        
                    </tbody>
                </table>
            </div>

            <div class="col-md-2">
                <div class="box-small">
                    <a style="border-radius: 50%; height: 100px; width: 100px; line-height: 100px; padding: 0px; top: -50px;" 
                       href="#" id="managePower" class="fbtn fbtn-brand-accent pull-left">权限管理</a>
                    <a style="height: 150px; width: 150px; border-radius: 50%; line-height: 150px; padding: 0px; top: -25px; left: 5px;" 
                       href="#" id="resetPassword" class="fbtn fbtn-brand pull-right">密码重置</a>
                </div>
            </div>
        </div>
        <div class="space-block"></div>

        <div class="modal fade in" id="modal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-heading">
                        <a class="modal-close" data-dismiss="modal">×</a>
                        <h2 class="modal-title"  id="modalLabel">编辑老师的权限与角色</h2>
                    </div>
                    <div class="modal-inner">
                        <input type="hidden" id="teacherSn">
                        <span id="managerolespan"></span>
                    </div>
                    <div class="modal-footer">
                        <p class="text-right"><button class="btn btn-flat btn-brand waves-attach waves-effect" data-dismiss="modal" type="button">关闭</button><button class="btn btn-flat btn-brand" type="button" onclick="saverole()">保存更改</button></p>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            var flag = 0;

            function manage(teacherId, temp) {

                $("#teacherSn").val(teacherId);
                
                if (temp === 0) {

                    document.getElementById("modalLabel").innerHTML = "编辑老师的权限与角色";
                    $('#modal').modal('show');
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
                    data: {sn: $("#teacherSn").val(), rolesum: sum},
                    success: function (data) {
                        if (data == "ok") {
                            alert("保存成功！");
                            $('#modal').modal('hide');
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

            $('#managePower').click(function () {
                flag = 0;
                $('#table-style').bootstrapTable('destroy')
                        .bootstrapTable({
                            classes: 'table table-hover',
                            striped: true,
                            url: 'teacher?a=777&b=666'
                        });
            });
            
            $('#resetPassword').click(function () {
                flag = 1;
                $('#table-style').bootstrapTable('destroy')
                        .bootstrapTable({
                            classes: 'table table-hover',
                            striped: true,
                            url: 'all'
                        });

            });
            $(".dropdown-menu").removeAttr("role");
        </script>

    </body>
</html>
