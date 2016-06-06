
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <h3 style="text-align: center;color: blue" id="kcdg_kcjs" ></h3><br>
   
    <div style="border:0px solid #CCC;"><span  id = "hfText"></span></div>
    <script type="text/plain" id="myEditor" style="width: 800px;height:50px;">
    <p>在此处编辑课程介绍</p>
    </script>
    <br>
    <button  class="button button-raised button-royal" onclick="getContent()">预览</button>
    <button  class="button button-raised button-royal" onclick="QXJS()">撤销</button>
    <button id="tj" class="button button-raised button-royal" onclick="update()">提交</button>
    <button class="button button-raised button-royal" onclick="lookcourseJS()">查看</button>
<script type="text/javascript">
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
        
        
        function update(){
            $.ajax({
               type:"post",
               data:{courseid:${courseid},term:${term}},
               url:"lookisCourseMaster",
               success: function (data) {
//                         if(data==="0"){
//                            alert("你不是课程负责人，不能在此编辑课程大纲!");
//                         }else{
                             if(window.confirm('你确定要更新课程介绍吗？')){  
                                var arr = [];     
                                arr.push(UM.getEditor('myEditor').getContent());
                                addcourseinfo(arr);
                                return true;
                             }
//                         }
                    },
                    error: function () {
                        CourseMaster();
                    }
           });    
        }
        
        //更新课程介绍
        function addcourseinfo(arr){
             var arrinfor; 
             arrinfor = arr+"";
             $.ajax({
                    type: "post",
                    url: "addcourseinfo", 
                    data: {arrinfor: arrinfor,courseid:${courseid},term:${term}}, 
                    success: function (data) {
                      if(data==="1"){
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
        function lookcourseJS(){
            $.ajax({
                    type: "post",
                    url: "lookcourseline", 
                    data: {courseid:${courseid},term:${term}}, 
                    success: function (data) {
                        if(data[0] ==="null"){
                             document.getElementById("hfText").innerHTML="课程介绍暂未更新，等待课程负责人添加";  
                        }else{
                            document.getElementById("hfText").innerHTML=data[0];  
                        }       
                    },
                    error: function () {
                        lookcourseJS();
                    }
                });
        }
        
        function QXJS(){
            document.getElementById("hfText").innerHTML=""; 
            lookcourseJS();
        }
          
       
 </script>