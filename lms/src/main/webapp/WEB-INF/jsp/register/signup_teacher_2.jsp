<%@ page language="java"  pageEncoding="gbk"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%
    response.setContentType("text/html;charset=utf-8");
    request.setCharacterEncoding("utf-8");
%>
<%
    session.setAttribute("identity", "teacher");
    String sno = request.getParameter("sno");
    session.setAttribute("sno", sno);
    String name = request.getParameter("name");    //传递姓名的参数值
    session.setAttribute("name", name);
    String pwd = request.getParameter("pwd");    //传递密码的参数值
    session.setAttribute("pwd", pwd);
    String idcard = request.getParameter("idcard");  //传递身份证号的参数值
    session.setAttribute("idcard", idcard);
    String sex = request.getParameter("sex");    //传递性别的参数值
    session.setAttribute("sex", sex);
    String birthday = request.getParameter("birthday");
    session.setAttribute("birthday", birthday);
    String mobile = request.getParameter("mobile");//传递手机号的参数值
    session.setAttribute("mobile", mobile);
    String qq = request.getParameter("qq");//传递qq的参数值
    session.setAttribute("qq", qq);
    String email = request.getParameter("email");    //传递email的参数值
    session.setAttribute("email", email);
    String college = request.getParameter("college");    //传递学院的参数值
    session.setAttribute("college", college);
    String department = request.getParameter("department");  //传递系别的参数值
    session.setAttribute("department", department);
    System.out.println("department is "+department);
    String position = request.getParameter("position");  //传递职称的参数值
    session.setAttribute("position", position);
    System.out.println("position is "+position);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>确认信息</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="../js/easyui/themes/cupertino/easyui.css"/>
        <link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css"/>
        <link rel="stylesheet" type="text/css" href="../css/lms.css"/>
        <link href="../css/jquery-ui.min.css" rel="stylesheet">

        <script  src="../js/easyui/jquery.min.js"></script>
        <script  src="../js/easyui/jquery.easyui.min.js"></script>
        <style>
            body{
                font: 62.5% "Trebuchet MS", sans-serif;
                margin: 50px;
            }
            .flag{
                color: #ff0000;
            }
            .title{
                text-align: right;
                width: 40%;
            }
            .data{
                text-align: left;
            }
        </style>
    </head>

    <body class="easyui-layout">
        <div id="header" data-options="region:'north'" ></div>
        <div id="footer" data-options="region:'south' " >
            <%@ include file="../footer.jsp" %>
        </div><div  id="body" data-options="region:'center'" style="padding:4%" >
            <form class="cmxform"  id="signupForm" name="signupForm" method="post" action="">
                <fieldset class="ui-widget ui-widget-content ui-corner-all">
                    <legend class="ui-widget ui-widget-header ui-corner-all flag">请再次填写重要信息</legend>
                    <table style="width:100%">
                        <tr>
                            <td class="title"> 工号：</td>
                            <td class="data"><input id="sno" name="sno" class="ui-widget-content" type="number" required><span class="flag">*</span>
                                <input type = "hidden" id='hsno' name="hsno" value="<%=sno%>">
                                <input type = "hidden" id='hidentity' name="hidentity" value="teacher"></td>
                        </tr>
                        <tr>
                            <td class="title">姓名： </td>
                            <td class="data"><input id="name" name="name" class="ui-widget-content" type="text" required ><span class="flag">*</span>
                                <input type = "hidden" id='hname' name="hname" value="<%=name%>"></td>
                        </tr>
                        <tr>
                            <td class="title">身份证号： </td>
                            <td class="data"><input id="idcard" name="idcard" class="ui-widget-content" type="text"  required ><span class="flag">*</span>
                                <input type = "hidden" id='hidcard' name="hidcard" value="<%=idcard%>"></td>
                        </tr>
                        <tr>
                            <td class="title"> 密码：</td>
                            <td class="data"><input id="pwd" name="pwd" class="ui-widget-content" type="password"  required ><span class="flag">*</span>
                                <input type = "hidden" id='hpwd' name="hpwd" value="<%=pwd%>"></td>
                        </tr>
                    </table>           
                </fieldset>
                <fieldset class="ui-widget ui-widget-content ui-corner-all">
                    <legend class="ui-widget ui-widget-header ui-corner-all flag">请输入验证码</legend>
                    <table style="width:100%">
                        <tr>
                            <td class="title">验证码：</td>
                            <td class="content"><input id="ccd" name="ccd" class="ui-widget-content" type="text" maxlength=4   title="验证码不区分大小写，看不清楚请单击图片">
                                <img id="ccdImage" border=0 src="image_code.jsp?dt="+<%=Math.random()%> title="看不清楚请单击图片">
                        </tr>
                    </table>
                </fieldset>
                <fieldset class="ui-widget ui-widget-content ui-corner-all">
                    <table style="width:100%">
                        <tr>
                            <td style="text-align:center" ><input type=button value="上一步" onclick="window.location.href = 'signup.jsp'"> &nbsp;&nbsp;
                                <input id='sign_next_2' type="button" value="下一步" >&nbsp;&nbsp;
                                <input type="reset" value="重置" >&nbsp;&nbsp;
                                <input type=button value="取消" onclick="window.location.href = '<%=basePath%>' + 'index.jsp'"></td>
                        </tr>
                    </table>
                </fieldset>
            </form>
        </div>

        <script src='../js/signup_check.js'>
        </script>
    </body>
</html>


