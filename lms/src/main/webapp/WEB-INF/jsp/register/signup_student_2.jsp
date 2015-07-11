<%@page import="cn.edu.henu.rjxy.lms.DAO.CollegeDAO"%>
<%@page import="cn.edu.henu.rjxy.lms.bean.College"%>
<%@page import="cn.edu.henu.rjxy.lms.DAO.GradeDAO"%>
<%@page import="cn.edu.henu.rjxy.lms.bean.Grade"%>
<%@page import="cn.edu.henu.rjxy.lms.DAO.DepartDAO"%>
<%@page import="cn.edu.henu.rjxy.lms.bean.Depart"%>
<%@page import="cn.edu.henu.rjxy.lms.DAO.ClassesDAO"%>
<%@page import="cn.edu.henu.rjxy.lms.bean.Classes"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";

    response.setContentType("text/html;charset=utf-8");
    request.setCharacterEncoding("utf-8");

    String databaseSchema = "lms";

    System.out.print("ss1");
    GradeDAO gd = GradeDAO.getGradeDAO();
    List<Grade> gdresult = gd.getList(databaseSchema);

    CollegeDAO cd = CollegeDAO.getCollegeDAO();
    //System.out.println("before");
    List<College> cdresult = cd.getList(databaseSchema);
    //System.out.println("end");

//    ClassesDAO classDAO = ClassesDAO.getClassesDAO();
//    List<Classes> crs = classDAO.getList(databaseSchema);
    //cdresult.remove(0);
%>
<%
    
    System.out.println("in signup_2");
    session.setAttribute("identity", "student");
    String sno = request.getParameter("sno");
    System.out.println("student sn ="+sno);
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
    String grade = request.getParameter("grade"); //传递年级的参数值
    session.setAttribute("grade", grade);
    session.setAttribute("dbs","lms");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>注册</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" type="text/css" href="../js/easyui/themes/cupertino/easyui.css"/>
        <link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css"/>
        <link rel="stylesheet" type="text/css" href="..css/lms.css"/>
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
                width: 45%;
            }
            .data{
                text-align: left;
            }
        </style>



    </head>



    <body>
        <div>
            <form class="cmxform"  id="signupForm2" name="signupForm" method="post" action='signup_student_3.jsp'>
                <fieldset class="ui-widget ui-widget-content ui-corner-all">
                    <legend class="ui-widget ui-widget-header ui-corner-all flag" style="text-align:center">请正确填写您在哪个院、专业、年级、班级学习，*部分为必填项</legend>
                    <table style="width:100%">
                        <tr>
                            <td class="title">年级：</td>
                            <td class="data"><select id="grade" name="grade" class="ui-widget-content">

                                    <%                                        for (Grade it : gdresult) {
                                    %>                        
                                    <option value=<%= it.getId()%>> <%=  it.getGrade()%></option>
                                    <%
                                        }
                                    %>
                                </select></td>
                        </tr>
                        <tr>
                            <td class="title" >
                                <label for="college">&nbsp;&nbsp;院：</label>
                            </td>
                            <td class="data">
                                <select id="college" name="college"   class="ui-widget-content">
                                    

                                    <%
                                        for (College it : cdresult) {
                                    %>                        
                                    <option value=<%= it.getCollegeId()%>> <%=  it.getCollegeName()%></option>
                                    <%
                                        }
                                    %>

                                </select><span class="flag">*</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label for="department">&nbsp;&nbsp;专业：</label>
                            </td>
                            <td class="data">
                                <select id="department" name="department" class="ui-widget-content">
                                    <option value="0"  selected> 请选择专业 </option>

                                </select><span class="flag">*</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label for="class">&nbsp;&nbsp;班：</label>
                            </td>
                            <td class="data">
                                <select id="class" name="class" class="ui-widget-content">
                                    <option value="0"  selected> 请选择班 </option>
                                </select><span class="flag">*</span>
                            </td>
                        </tr>

                        
                    </table>

                                    <p style="text-align:center">
                                        <input type=button value="上一步" onclick="window.location.href = 'javascript:history.go(-1)'"> &nbsp;&nbsp;
                        <input id='student_sign_next_2' type="button" value="下一步" >&nbsp;&nbsp;
                        <input type="reset" value="重置" >&nbsp;&nbsp;
                        <input type=button value="取消" onclick="window.location.href = '<%=basePath%>' + 'index.jsp'">
                    </p>
                </fieldset>
            </form>
        </div>
        <script src='../js/signup_check.js'></script>
        <script>
            $(function(){
               $("#college option:first").remove();
               $("#college").prepend("<option value='0'  selected> 请选择学院 </option>");
            });
        </script>
    </body>
</html>
