
<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    String sessionid = session.getId();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            #DGword li{
                padding: 1em;
                background-color: whitesmoke;
                width: 100%;
                display: block;
            }
            #DGword li>a{
                color:#212121;
                display: inline-block;
                padding: 0 1em;
                float: right;
            }
            #DGword li>a:hover{cursor: pointer;color: #00438a;}
            #DGword li a:first-child{
                float: left;
                color: #00438a;
            }
            .uploadify-button{
                border-radius: 0;
                width: 100% !important;
                display: block;
                padding: 5em 0;
                line-height: 1em;
                background-color: whitesmoke;
                background-image: none;
                border: 3px dotted #888888;
                color: #212121;
                position: relative;
                height: auto !important;
            }
            .uploadify:hover .uploadify-button{
                border-radius: 0;
                background-color: whitesmoke;
                background-image: none;
            }
            #dgmultiple_file_upload{
                height: auto !important;
                width: 100% !important;
            }
            #dgmultiple_file_upload>object{
                width: 100%;
                height: 100%;
                left: 0;
                /*position: relative !important;*/
            }
            #multiple_file_upload{

                height: auto !important;
                width: 100% !important;
            }
            #multiple_file_upload>object{
                width: 100%;
                height: 100%;
                left: 0;
                /*position: relative !important;*/
            }
            .edui-container,
            .edui-container>div,
            #myCourseDaGangEditor{
                width: 100% !important;
            }
            .uploadify-queue-item {
                max-width: 100%;
            }
            #documentViewer{
                border: 1px solid whitesmoke;
            }
        </style>
        <script>
//            $(".uploadify-button").mouseover(function(){
//                $("#dgmultiple_file_upload>object").mouseover();
//            });
//            $(".uploadify-button").mouseout(function(){
//                $("#dgmultiple_file_upload>object").mouseout();
//            })
        </script>
    </head>
    <body>  
        <!--<h3 style="text-align: center;color: blue" id="kcdg_kcm" ></h3><br>-->
        <div><div id="DGText" style="border:0px solid #CCC;"></div></div>
        
        <div id="DGword"></div>  
        <div id="dgxsid" style="display: none"> 
            <iframe id="kcdgurl" frameborder="0" scrolling="no" height="700px" width="100%" name="content" ></iframe>
        </div>
        
        <div id="dgscid">
            <input type="file" name="uploadify" id="dgmultiple_file_upload" />
            <a class="btn btn-primary btn-uploadify" onclick="ksscdg()">开始上传</a>
            <a class="btn btn-primary" href="javascript:$('#dgmultiple_file_upload').uploadify('cancel','*')">取消上传</a>
            <a class="btn btn-primary" href="javascript:$('#dgmultiple_file_upload').uploadify('stop','*')" hidden=true id="stopUpload">停止上传</a>
        </div><br>
        
        <script type="text/plain" id="myCourseDaGangEditor" style="width: 100%;min-height:50px;">
            <p>在此处编辑课程大纲</p>
        </script>
        
        <br>
        <button  class="button button-raised button-royal" onclick="getContentDG()">预览</button>
        <button  class="button button-raised button-royal" onclick="QXDG()">撤销</button>
        <button id="DG" class="button button-raised button-royal" onclick="updateDG()">提交</button>
        <button class="button button-raised button-royal" onclick="lookcourseDG()">查看</button>
        <script type="text/javascript">

            var ue = UM.getEditor('myCourseDaGangEditor');
            function getContentDG() {
                var arr = [];
                arr.push(UM.getEditor('myCourseDaGangEditor').getContent());
                var value = UM.getEditor('myCourseDaGangEditor').getContent();
                UM.getEditor("myCourseDaGangEditor").setContent(value);
                document.getElementById("DGText").innerHTML = value;
            }
            function ksscdg() {
                var term =${term};
                var coursename = "${courseName}";
                $('#dgmultiple_file_upload').uploadify("settings", "formData", {'term': term, 'coursename': coursename});
                $('#dgmultiple_file_upload').uploadify('upload', '*');
            }
            $(function () {
        $("#dgmultiple_file_upload").uploadify        ({
                    'uploader': '<%=path%>/teacher/dgupload100.do;jsessionid=<%=sessionid%>?Func=uploadwallpaper2Dfs',
                    'width': 120,
                    'buttonText': '选择文件',
                    'buttonCursor': 'hand',
                    'auto': false,
                    'multi': false,
            'method': 'post        ',
            'swf': '<%=path%>/uploadify/uploadify.swf        ',
                    'cancelImg': '<%=path%>/uploadify/uploadify-cancel.png',
                    'fileTypeExts': '**.docx;*.doc;*.xls;*.xlsx;*.ppt ',
                    'fileSizeLimit': '200MB',
                    'fileObjName': 'myFile',
                    'progressData': 'speed',
                    'preventCaching': true,
                    'timeoutuploadLimit': 1,
                    'removeCompleted': true,
                    'removeTimeout': 1,
                    'requeueErrors': true,
                    'successTimeout': 30,
                    'uploadLimit': 1,
                    'onUploadStart': function (file) {
                        $("#stopUpload").removeAttr("hidden");
                    },
                    'onUploadSuccess': function (file, data, response) {
                        alert(file.name + " upload success !");
                        lookcourseDGword();
                        $("#stopUpload").attr("hidden", true);
                    }

                });
            });


            function gbdgyl() {//关闭预览
                $("#dgxsid").hide();
            }
            function updateDG() {
                $.ajax({
                    type: "post",
                    data: {courseid:${courseid}, term:${term}},
                    url: "<%=path%>/teacher/lookisCourseMaster",
                    success: function (data) {
        //                         if(data==="0"){
        //                            alert("你不是课程负责人，不能在此编辑课程大纲!");
        //                         }else{
                        if (window.confirm('你确定要更新课程大纲吗？')) {
                            var arr = [];
                            arr.push(UM.getEditor('myCourseDaGangEditor').getContent());
                            addcourseoutlino(arr);
                            return true;
                        }
        //                         }
                    },
                    error: function () {
                        CourseMaster();
                    }
                });

            }

            //更新课程大纲
            function addcourseoutlino(arr) {
                var arrinfor;
                arrinfor = arr + "";
                $.ajax({
                    type: "post",
            url: "<%=path%>/teacher/addcourseoutline",
            data: {arrinfor: arrinfor, courseid:${courseid}, term:${term}},
                    success: function (data) {
                        if (data === "1") {
                            alert("更新成功!");
                            lookcourseDG();
                        }
                    },
                    error: function () {
                        alert("出错了，未知原因！");
                    }
                });

            }

            //返回课程大纲
            function lookcourseDG() {
                lookcourseDGword();
                $.ajax({
                    type: "post",
            url: "<%=path%>/teacher/lookcourseDG",
            data: {courseid:${courseid}, term:${term}},
                    success: function (data) {
                        if (data === "null") {
                            document.getElementById("DGText").innerHTML = "课程大纲暂未更新，等待课程负责人添加";
                        } else {
                            document.getElementById("DGText").innerHTML = data[0];
                        }
                    },
                    error: function () {
                        lookcourseDG();
                    }
                });
            }

            function QXDG() {
                document.getElementById("DGText").innerHTML = "";
                lookcourseDG();
            }

            function lookcourseDGword() {
                var coursename = "${courseName}";
                var term = ${term};
                $.ajax({
                    type: "post",
            url: "<%=path%>/teacher/lookDGwork?term=" + term + '&coursename=' + coursename,
                    success: function (data) {
                        document.getElementById("DGword").innerHTML = data[0];
                        if (data[1] === "0") {
                            $("#dgscid").show();
                        } else {
                            $("#dgscid").hide();
                        }
                    },
                    error: function () {
                        alert("出错了，未知原因！");
                    }
                });
            }
            //删除附件
            function scfj() {
                var term = parent.document.getElementById("sz_xq").value;
                node = parent.$('#tt').tree('getSelected');
                var coursename = node.text;
        //            alert(coursename);
                if (window.confirm('你确定要删除课程大纲吗？')) {
                    $.ajax({
                        type: "post",
                        url: "<%=path%>/teacher/scDGwork?term=" + term + '&coursename=' + coursename,
                        success: function (data) {
                            if (data[0] !== "0") {
                                alert("删除成功!");
                                document.getElementById("DGword").innerHTML = data[0];
                                $("#dgscid").show();
                                $("#dgxsid").hide();
                            }
                        },
                        error: function () {
                            alert("出错了，未知原因！");
                        }
                    });
                    return true;
                }
            }

            function dgyl(url) {
                $("#dgxsid").show();
                url = "http://localhost:8080/lms/getswf?uri=" + url;
                document.getElementById("kcdgurl").src = url;
            }
        </script>
    </body>
</html>
