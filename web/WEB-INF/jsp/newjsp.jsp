<%-- 
    Document   : newjsp
    Created on : 2015-11-12, 17:01:27
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
        <title>JSP Page</title>
        <script src="<%=path%>/js/jquery-1.7.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/jquery.easyui.min.js"></script>
        <script type="text/javascript">
            var temp =0;
            function textJson3() {
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
            
            

            $('#pp').pagination({
            total:articleJSONArr.length, //总的记录数
                    pageSize:10, //每页显示的大小。
                    pageList: [10, 20, 50, 100], //选择每页显示的记录数的下拉框的值。
                    onSelectPage: function (pageNumber, pageSize) {//选择相应的页码时刷新显示内容列表。
                        //把请求的内容放入panel中。

                        var html = "";
                        articleJSONArr.length / pageSize; //页数。
                        //i 开始的记录数
                        for (var i = (pageNumber - 1) * pageSize; i < (pageNumber * pageSize > articleJSONArr.length ? articleJSONArr.length : pageNumber * pageSize); i++) //遍历json; 
                        {

                            html += "<li class='cursor-fix'><span>" + articleJSONArr[i]["数据库入库时间"] + "</span><a id='href" + i + "' href='#' title='" + articleJSONArr[i]['文章标题'] + "' onclick='gotoMessage(this)'>" + articleJSONArr[i]['文章标题'] + "</a>";
                            html += " <form id='form" + i + "' method='post' target='_blank' action='article.jsp?index=" + i + "'>";
                            html += " <input type='hidden' id='content" + i + "' name='content' value='" + articleJSONArr[i]["文章内容"] + "' />";
                            html += " <input type='hidden' id='title" + i + "' name='title' value='" + articleJSONArr[i]["文章标题"] + "' />";
                            html += "  </form></li>";
                        }
                        $("#pagecontent").html(html);
                        //$("#frArticleDiv").prepend(html);
                        //$('#content').panel('refresh', 'show_content.php?page='+pageNumber);
                    }

        </script>
    </head>
    <body>
        <div id="pp" style="border:1px solid #ddd;">  </div>
        <table class="table table-striped table-bordered table-condensed" border=4 width=800 align=center>
            <tr><th>工号</th><th>姓名</th><th>身份证号</th><th>操作</th></tr>
        </table> 

        <input type="button" onclick="textJson3()" value="设置教师信息" /> 
    </body>
</html>
