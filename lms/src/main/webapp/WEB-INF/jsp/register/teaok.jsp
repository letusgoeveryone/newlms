<%-- 
    Document   : ok
    Created on : 2014-7-30, 16:56:29
    Author     : wht
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/cupertino/easyui.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/lms.css"/>
        <link href="<%=path%>/css/jquery-ui.min.css" rel="stylesheet">

        <script  src="<%=path%>/js/easyui/jquery.min.js"></script>
        <script  src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
    </head>
    <body>
        <script>
            $(function() {

                $.messager.alert('提示', '您的信息已被系统接收，但您需在8天内（含）加入某个学习班级，并联系课程老师，获得批准方可正式使用本系统，若8天后未被批准，则您的注册信息会被系统自动删除！',
                        'info', function() {
                            location.href = "<%=path%>/index";
                        });
                //alert("ok");
//                $.messager.show({
//                    title: '提示',
//                    msg: '您已注册成功，您需获得批准方可正式使用本系统！',
//                    timeout: 3000,
//                    showType: 'slide',
//                    style: {
//                        right: '',
////                                top: document.body.scrollTop + document.documentElement.scrollTop,
//                        bottom: ''
//                    }
//                });
//                location.href = "../index.jsp";
            })

        </script>
    </body>
</html>
