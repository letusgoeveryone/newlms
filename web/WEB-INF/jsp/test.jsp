<%-- 
    Document   : test
    Created on : 2015-11-22, 19:35:47
    Author     : Administrator
--%>
<%
//  将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="<%=path%>/js/jquery-1.7.min.js"></script>
        <script src="<%=path%>/js/jquery.js"></script>
        <script type="text/javascript">
            var sy = 0;
            var ty = 11111111111111111110;
            function doPage(temp) {
                var tempgo = document.getElementById('va').value;
                if (tempgo !== '') {
                    temp = tempgo;
                    document.getElementById('va').value = "";//如果input框不是空，自动清空
                }
                if (temp === 200000) {
                    temp = sy + 1;
                    if (ty + 1 === temp) {
                        alert("已经到达最后一页");
                        return 0;
                    }
                }
                if (temp === 300000) {
                    temp = sy - 1;
                    if (temp < 1) {
                        alert("已经到达第一页");
                        return 0;
                    }
                }
                var j = 6;
                $('#d3').show();
                $('#d4').hide();
                var item;
                $.ajax({
                    type: 'get',
                    url: 'fhjsxx?pc=' + temp,
                    contentType: 'application/json;charset=utf-8',
                    date: 'teacherName=刘并需&teacherIdcard=4545454',
                    beforeSend: function () {
                        $("#jzz").html('加载中...');
                    },
                    success: function (date) {
                        sy = date[0].pc;//第几页复给sy1
                        ty = date[0].tp;//总页码复给ty1
                        var temp1 = "";
                        $.each(date[0].beanList, function (i, item) {
                            temp1 += "<tr><td>" + '<input type="checkbox" name="jihe" id="js" value ="' + item.teacherId +'">' + "</td><td>" + item.teacherId + "</td><td>" + item.teacherSn + "</td><td>" + item.teacherName + "</td><td>"
                                    + item.teacherCollege + "</td><td>" + item.teacherPosition + "</td><td>" + item.teacherTel + "</td><td>" +
                                    item.teacherIdcard + "</td><td>" + '<a href="#" onclick="pz(' + item.teacherId + ')">批准</a>' + '<a href="#" onclick="sc(' + item.teacherId + ')">删除</a>' + "</td></tr><hr/>";
                        });
                        $("#t1").html(temp1);
                        spanPageNum.innerHTML = date[0].pc;
                        spanTotalPage.innerHTML = date[0].tp;
                        $("#jzz").html('');
                    }

                });
            }



            function pz(teacherId) {
                $.ajax({
                    type: "get",
                    url: "pz",
                    data: 'teacherId=' + teacherId,
                    success: function (data) {
                        alert("批准成功！");
                    }
                });
                doPage(1);//批准删除后显示第一页
            }
            //删除教师
            function sc(teacherId) {
                $.ajax({
                    type: "get", //提交方式
                    url: "sc", //提交的页面，方法名
                    data: 'teacherId=' + teacherId, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("删除成功");
                    }

                });
                doPage(1);//批准删除后显示第一页
            }

            //学生信息
            var sy1 = 0;//第几页复给sy1
            var ty1 = 11111111111111111110;
            function xsxx(temp) {
                var tempgo = document.getElementById('va1').value;//如果input框不是空，自动清空
                if (tempgo !== '') {
                    temp = tempgo;
                    document.getElementById('va1').value = "";
                }
                $('#d3').hide();
                $('#d4').show();
                if (temp === 200000) {
                    temp = sy1 + 1;
                    if (ty1 + 1 === temp) {
                        alert("已经到达最后一页");
                        return 0;
                    }
                }
                if (temp === 300000) {
                    temp = sy1 - 1;
                    if (temp < 1) {
                        alert("已经到达第一页");
                        return 0;
                    }
                }
                $.ajax({
                    type: 'get',
                    url: 'fhstume?pc=' + temp,
                    contentType: 'application/json;charset=utf-8',
                    date: 'teacherName=刘并需&teacherIdcard=4545454',
                    beforeSend: function () {
                        $("#jzzxs").html('加载中...');
                    },
                    success: function (date) {
//                        alert(date[0].pc); //第几页
//                        alert(date[0].tp); //总共几页
//                        alert(date[0].tr); //数据库总得信息
//                        alert(date[0].ps); //一页显示几个
//                        alert(date[0].beanList[0].teacherCollege);
                        sy1 = date[0].pc;//第几页复给sy1
                        ty1 = date[0].tp;//总页码复给ty1
                        var temp1 = "";
                        $.each(date[0].beanList, function (i, item) {
                            temp1 += "<tr><td>" + item.studentId + "</td><td>" + item.studentSn + "</td><td>" + item.studentName + "</td><td>"
                                    + item.studentCollege + "</td><td>" + item.studentGrade + "</td><td>" + item.studentTel + "</td><td>" +
                                    item.studentIdcard + "</td><td>" + '<a href="#" onclick="pzxs(' + item.studentId + ')">批准</a>' + '<a href="#" onclick="scxs(' + item.studentId + ')">删除</a>' + "</td></tr><hr/>";
                        });
                        $("#t2").html(temp1);
                        spanPageNum1.innerHTML = date[0].pc;
                        spanTotalPage1.innerHTML = date[0].tp;
                        $("#jzzxs").html('');
                    }

                });
            }
            function pzxs(studentId) {
                $.ajax({
                    type: "get", //提交方式
                    url: "pzstu", //提交的页面，方法名
                    data: 'studentId=' + studentId, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("批准成功");
                    }
                });
                xsxx(1);//批准删除后显示
            }
            function scxs(studentId) {
                $.ajax({
                    type: "get", //提交方式
                    url: "scstu", //提交的页面，方法名
                    data: 'studentId=' + studentId, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("删除成功");
                    }
                });
                xsxx(1);//批准删除后显示
            }
            //批量删除临时教师
            function plscjsxx() {
                var jssz = new Array();
                var arr = document.getElementsByTagName('input');
//                var jssz = [];
                var i = 0;
                for (var n = 0; n < arr.length; n++) {
                    if (arr[n].type === 'checkbox' && arr[n].checked === true) {
                        jssz[i++] = arr[n].value;
                    }
                }
                $.ajax({
                    type: "post", //提交方式
                    url: "pzscjs", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("批准成功");
                    }
                });
                doPage(1);
            }
            //测试frame
            function changeUrl(vPageName) {
                document.getElementById('fr').style.display = "";
                var vIfr = document.getElementById("ifrObj");
                vIfr.src = vPageName;
            }
        </script>
    </head>
    <body>
        <div style="width:100px; height:auto; float:left; display:inline ; border:1px ;background:#F00; color:#FFF" id="d1" ><a  onclick="doPage(1)">设置教师信息</a> </div>
        <div style="width:100px; height:auto; float:left; display:inline;; border:1px ;background:#F00; color:#FFF" id="d2"><a onclick="xsxx(1)">设置学生信息</a></div><br>
        <!--教师div-->
        <div style="width:810px; height:500px;text-align: center;  display: none;" id="d3"  >      
            <table   border=1  width=800 align=center>
                <tr> <th>全选</th><th style="display: none">id</th>  <th>工号</th><th>姓名</th><th>学院</th><th>职称</th><th>手机号</th><th>身份证号</th><th>操作</th></tr>    
            </table>         
            <table id="t1"  border=4 width=800 align=center>  
            </table>
            第 <span id="spanPageNum" > </span>页/共<span id="spanTotalPage"> </span> 页 
            <span id="spanFirst"><input type="button" onclick="doPage(300000)" value="上一页" /> </span> 
            <span id="spanPre"><input type="button" onclick="doPage(200000)" value="下一页" /></span> 
            <span id="go"><input type="button" onclick="doPage()" value="go" /><input type="text" id="va"/></span> <br/>
            <a href="#" onclick="plscjsxx()">批量批准选中信息<a/>
            <br/>
            <p id="jzz"  style="color: #000000"></p>
        </div>
        <!--学生div-->
        <div style="width:810px; height:330px;text-align: center;  display: none;" id ="d4"  >      
            <table   border=4  width=800 align=center>
                <tr> <th>id</th>  <th>学号</th><th>姓名</th><th>学院</th><th>年级</th><th>手机号</th><th>身份证号</th><th>操作</th></tr>    
            </table>         
            <table id="t2"  border=4 width=800 align=center>  
            </table>
            第 <span id="spanPageNum1" > </span>页/共<span id="spanTotalPage1"> </span> 页 
            <span id="spanFirst"><input type="button" onclick="xsxx(300000)" value="上一页" /> </span> 
            <span id="spanPre"><input type="button" onclick="xsxx(200000)" value="下一页" /></span> 
            <span id="go"><input type="button" onclick="xsxx()" value="go" /><input type="text" id="va1"/></span> <br/>
            <p id="jzzxs" style="color:#000000"></p>
        </div>

        <a href="daochuxuesheng">导出测试</a>
        <div  id="fr" style="display: none;text-align: center;border: 2px #000;width: 800px ;height: 500px;padding-left: 15%">
            <iframe id="ifrObj" frameborder="1" width="800px" height="500px" scrolling="no" ></iframe></div>

        <a href="javascript:changeUrl('newjsp')">frame</a>


    </body>
</html>
