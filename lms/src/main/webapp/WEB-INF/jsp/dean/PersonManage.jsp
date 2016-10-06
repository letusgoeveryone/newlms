<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PersonManage</title>
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
    <body>
        <div class="container">
            <h1>设置教务员页面 ~~</h1>
        </div>
         
        <table id="myacdemictable" data-toggle="table" data-url="" data-height=""data-width="80%"
		data-click-to-select="true" data-method="get"
		data-query-params="queryParams" data-toolbar="#toolbar"
		data-pagination="true" data-search="true" data-show-refresh="true"
		data-show-toggle="true" data-show-columns="true" data-page-size="5">
	</table>

   
        <script>
            
                 $('#myacdemictable').bootstrapTable({
                    url: 'teachermessage',
                    columns: [
                        {
                         field: 'teacherName',
                         title: '姓名'
                       }, {
                         field: 'teacherSn',
                         title: '工号'
                       }, {
                         field: 'teacherTel',
                         title: '手机号'
                       },{
                         field: 'teacherPosition',
                         title: '职称'
                       },{
                         field: 'teacherRoleValue',
                         title: '角色',
                         align: 'center',
                                  formatter:function(value,row,index){  
                                  var teacherRoleValue;
                                  if(row.teacherRoleValue===2){
                                  teacherRoleValue ='是教务员';  
                                  }else{
                                  teacherRoleValue= '不是教务员';  
                                  }
                                    return teacherRoleValue;  
                                 } 
                       },{
                                    title: '操作',
                                    field: 'temp',
                                    align: 'center',
                                    formatter:function(value,row,index){  
                                    var temp;
                                    if(row.teacherRoleValue===2){
                                    temp = '<a href="#" mce_href="#" onclick="szacdemic(\''+ row.teacherId +'\')">取消教务员</a> ';  
                                    }else{
                                    temp= '<a href="#" mce_href="#" onclick="pzacdemic(\''+ row.teacherId + '\')">设置教务员</a> ';  
                                    }
                                      return temp;  
                                   } 
                                }
                      ]
                });
       
       
       function szacdemic(id){
            $.post("acedmicqx?id="+id,function(data,status){
                   $('#myacdemictable').bootstrapTable('refresh');
              });
       }
       function pzacdemic(id){
            $.post("acedmicqxpz?id="+id,function(data,status){
                   $('#myacdemictable').bootstrapTable('refresh');
              });
          
       }
           
        </script>
    </body>
</html>