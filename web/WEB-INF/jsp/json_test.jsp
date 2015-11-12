<%-- 
    Document   : json_test
    Created on : 2015-11-5, 13:27:28
    Author     : Name : liubingxu Email : 2727826327qq.com
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSON test</title>
        <script src="<%=path%>/js/jquery-1.7.min.js"></script>
        <script type="text/javascript">
            function textJson() {
                $.ajax({
                    type: 'post',
                    url: 'json_test88',
                    contentType: 'application/json;charset=utf-8',
                    date: '{"teacherName":"仙人是","teacherIdcard":411121199604284025}',
                    success: function (date) {

                        alert(date);
                    }
                });
            }
            var temp = 0;
            function textJson2() {
                $.ajax({
                    type: 'get',
                    url: 'json_test89',
                    date: 'teacherName=刘并需&teacherIdcard=4545454',
                    success: function (date) {
                        var len = date.length;//得到的json数组长度                                                                                     
                        if (len > 0) {
                            temp = Math.ceil(len / 2);//要分页的数目  一页显示2个 
                            spanTotalPage.innerHTML = temp;//要分页的数目
                          //  alert(temp);//要分页的数目


                            var item;
                            $.each(date, function (i, item) {
//                                alert(i);
                                while (i + 1 >= 3) {
                                    return;
                                }
                                // alert(item.teacherName);
                                item = "<tr><td>" + item.teacherSn + "</td><td>" + item.teacherName + "</td><td>" + item.teacherIdcard + "</td><td>操作</td></tr>";
                                $('.table').append(item);
                            });
                        } else {
                            item = item = "<tr><td> 数据为空 </td></tr>";  //如果数据库无信息，显示暂无教师注册
                            $('.table').append(item);
                        }

                    }
                });
            }
            function textJson3() {
                alert(12);
                $.ajax({
                    type: 'get',
                    url: 'json_test90',
                    date: 'studentName=刘并需&studentIdcard=4545454',
                    success: function (date) {
                        var len = date.length; //得到的json数组长度   


                        alert(1);
                    }
                });
            }


//test


        </script>
    </head>
    <body>
        <input type="button" onclick="textJson()" value="设置教师班级" /> 
        <input type="button" onclick="textJson2()" value="设置教师信息" /> 
        <input type="button" onclick="textJson3()" value="设置学生信息" /> 

        <!--test-->
        <div  style="width: 1000px;height: 400px;border: 5px #0065cc double; margin-left: 20%"  align=center>
            <table class="table table-striped table-bordered table-condensed" border=4 width=800 align=center>
                <tr><th>工号</th><th>姓名</th><th>身份证号</th><th>操作</th></tr>
            </table> 
            <span id="spanFirst"><input type="button" onclick="#textJson3()" value="第一页" /> </span> 
            <span id="spanPre"><input type="button" onclick="#textJson3()" value="上一页" /></span> 
            <span id="spanNext"> <input type="button" onclick="textJson2()" value="下一页" /> </span> 
            <span id="spanLast"><input type="button" onclick="#textJson3()" value="最后一页" /> </span> 
            第<span id="spanPageNum"></span>页/共<span id="spanTotalPage"></span>页



            <br/>
            <input type="button" onclick="#textJson3()" value="保存结果" /> 
            <input type="button" onclick="#textJson3()" value="撤销未保存" /> 
        </div>




    </body>
</html>
