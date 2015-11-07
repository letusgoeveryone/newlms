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
        function textJson(){
           $.ajax({
              type:'post',
              url:'json_test88',
              contentType :'application/json;charset=utf-8',
              date:'{"teacherName":"仙人是","teacherIdcard":411121199604284025}',
              success:function(date){
                  
                  alert(date);
              }
           });
        }
        
     function textJson1(){
           $.ajax({
              type:'get',
              url:'json_test89',            
              date:'teacherName=刘并需&teacherIdcard=4545454',
              success:function(date){
                  
                  alert(date[0].teacherName);
              }
           });
        }
        </script>
    </head>
    <body>
        <input type="button" onclick="textJson()" value="requestJson" /> 
        <input type="button" onclick="textJson1()" value="responseJson" />  
    </body>
</html>
