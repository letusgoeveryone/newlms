<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    String sessionid = session.getId();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
  <link rel="stylesheet" type="text/css" href="<%=path%>/css/buttons.css">
    <style>
        #hfText{
            padding:2em 1em;
            background: whitesmoke;
            margin: 2em 0;
        }
        #hfText p{
            padding: 0 2em;
        }
        
    </style>
    <div><div id="hfText" style="border:0px solid #CCC;"></div></div>
    <script type="text/plain" id="myEditor" style="width: 100%;min-height:100px;">
    <p>在此处编辑课程介绍</p>
    </script>
    <br>
    <button  class="btn btn-default " onclick="getContent()">预览</button>
    <button  class="btn btn-primary " onclick="QXJS()">撤销</button>
    <button id="tj"  class="btn btn-success" onclick="update()">提交</button>
    <button class="btn btn-info" onclick="lookcourseJS()">查看</button>
<script type="text/javascript">
    function update(){
            $.ajax({
               type:"post",
               data:{courseid:${courseid},term:${term}},
               url:"lookisCourseMaster",
               success: function (data) {
                         if(data==="0"){
                            alert("你不是课程负责人，不能在此编辑课程大纲!");
                         }else{
                             if(window.confirm('你确定要更新课程介绍吗？')){  
                                var arr = [];     
                                arr.push(UM.getEditor('myEditor').getContent());
                                addcourseinfo(arr);
                             return true;
                          }
                         }
                },
                error: function () {
                    CourseMaster();
                }
            });
        }

        //更新课程介绍
        function addcourseinfo(arr) {
            var arrinfor;
            arrinfor = arr + "";
            $.ajax({
                type: "post",
                url: "addcourseinfo",
                data: {arrinfor: arrinfor, courseid:${courseid}, term:${term}},
                success: function (data) {
                    if (data === "1") {
                        alert("更新成功!");
                        lookcourseJS();
                    }
                },
                error: function () {
                    alert("出错了，未知原因！");
                }
            });

        }
        //返回课程介绍
        function lookcourseJS() {
            $.ajax({
                type: "post",
                url: "lookcourseline",
                data: {courseid:${courseid}, term:${term}},
                success: function (data) {
                    if (data[0] === "null") {
                        document.getElementById("hfText").innerHTML = "课程介绍暂未更新，等待课程负责人添加";
                    } else {
                        document.getElementById("hfText").innerHTML = data[0];
                    }
                },
                error: function () {
                    lookcourseJS();
                }
            });
        }

        function QXJS() {
            document.getElementById("hfText").innerHTML = "";
            lookcourseJS();
        }
         $(function(){
             lookcourseJS();
         });

         var ue = UM.getEditor('myEditor');
        function getContent(){
         var arr = [];     
         arr.push(UM.getEditor('myEditor').getContent());
         var value = UM.getEditor('myEditor').getContent();
         UM.getEditor("myEditor").setContent(value);
         document.getElementById("hfText").innerHTML=value;
        }
        
        
        
          
       
 </script>