<%-- 
    Document   : TeacherConsoleInterface
    Created on : 2016-5-26, 15:13:35
    Author     : dots
--%>
<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_ADMIN') or hasRole('ROLE_DEAN')">
    <div class="bg-content"></div>
    <div class="container card" style="position:relative;">
        <nav id="lms_admin_tnav">
            <div>
                <a href="#lms_main"class="btn lms-c-text-light waves-attach waves-light waves-effect pull-left" data-toggle="tab">
                    <span> 返回 </span> 
                </a>
            </div>
            <div class="lms-control-list pull-right">

                <select id="sz_xq" class="test btn text-golden"></select>
                <div class="dropdown-wrap">
                    <div class="dropdown dropdown-inline">
                        <a class="btn dropdown-toggle-btn text-golden" data-toggle="dropdown"> 课程和班级 </a>
                        <ul id="tt" class="easyui-tree dropdown-menu nav" data-options="method:'get',animate:true">

                        </ul>
                    </div>
                </div>

            </div>
        </nav>

        <div class="row width-control" id="lms_admin_tnav_class">
            <div class="col-md-12" style="min-height: 500px">

                <div id="mystudent" hidden>
                    <jsp:include page="../teacher/mystudent.jsp"/>
                </div>

                <div id="mycourse" hidden>
                    <jsp:include page="../teacher/mycourse.jsp"/>
                </div>
            </div>
        </div>
        <div id="pwin"></div>
    </div>
                
    <script>
    //学期下拉框
        function kcdz() {
            $.ajax({
                type: "get",
                url: "<%=path%>/fhxq",
                async: false, //设置ajax同步加载
                success: function (data) {
                    document.getElementById("sz_xq").options.length = 0;
                    for (var i = 1; i < data.length; i++) {
                        document.getElementById("sz_xq").options.add(new Option(data[i], data[i]));
                    }
                },
                error: function () {
                    kcdz();
                }
            });
        }

        $(function () {
            kcdz();//学期下拉框function
            $('.test').change(function () {
                $("#mystudent").hide();
                $("#mycourse").hide();
                $('#tt').tree({
                    url: '<%=path%>/teacher/courselist?xueqi=' + $("#sz_xq").val(),
                    onClick: function (node) {
                        lookTree(node);
                    }
                });
            });
            $('#tt').tree({
                url: '/lms/teacher/courselist?xueqi=' + $("#sz_xq").val(),
                onClick: function (node) {
                    lookTree(node);
                }
            });
        });

        function  lookTree(node) {
            var a = node.children + "1";
            var b = "undefined1";
            if (a === b) {//班级学生信息管理
                $("#mystudent").show();
                $("#mycourse").hide();
                var b = $("#tt").tree("getParent", node.target); //父节点
                mystudent(node.text, node.id, b.id, $("#sz_xq").val());
            } else {//课程设置
                $("#mycourse").show();
                $("#mystudent").hide();
                var term = $("#sz_xq").val();
                var courseName = node.text;
                var courseid = node.id;
                var b = "<%=path%>/teacher/alljsp?term=" + term + "&courseid=" + courseid + "&courseName=" + courseName;
                $("#addcouocontent", parent.document.body).attr("src", b);
            }
        }

        function mystudent(a, b, c, term) {
            $('#dg_zs_stu').datagrid({
                title: " " + a,
                url: '<%=path%>/teacher/mystudent?classid=' + b + '&course_id=' + c + '&term=' + term,
                loadMsg: '数据加载中请稍后……'
            });
        }
    </script>
</sec:authorize>
