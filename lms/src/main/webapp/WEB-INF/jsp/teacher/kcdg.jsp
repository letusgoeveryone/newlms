<%
    //将项目的根取出来，页面中不再使用相对路径
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
    </head>
    <body>  
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

        <script type="text/plain" id="CourseDaGangEditor" style="height:100px;">
            <p>在此处编辑课程大纲</p>
        </script>
        

        <br>
        <button   class="btn btn-default " onclick="getContentDG()">预览</button>
        <button   class="btn btn-primary" onclick="QXDG()">撤销</button>
        <button id="DG" class="btn btn-success" onclick="updateDG()">提交</button>
        <button class="btn btn-info" onclick="lookcourseDG()">查看</button>
        <script type="text/javascript">

            var ue = UE.getEditor('CourseDaGangEditor');
            function getContentDG() {
                var arr = [];
                arr.push(UE.getEditor('CourseDaGangEditor').getContent());
                var value = UE.getEditor('CourseDaGangEditor').getContent();
                UE.getEditor("CourseDaGangEditor").setContent(value);
                document.getElementById("DGText").innerHTML = value;
            }
            function ksscdg() {
                var term =${term};
                var coursename = "${courseName}";
                $('#dgmultiple_file_upload').uploadify("settings", "formData", {'term': term, 'coursename': coursename});
                $('#dgmultiple_file_upload').uploadify('upload', '*');
            }
            $(function () {
                $("#dgmultiple_file_upload").uploadify({
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
                        if (data !== "0") {
                            alert("你不是课程负责人，不能在此编辑课程大纲!");
                        } else {
                            if (window.confirm('你确定要更新课程大纲吗？')) {
                                var arr = [];
                                arr.push(UE.getEditor('CourseDaGangEditor').getContent());
                                addcourseoutlino(arr);
                                return true;
                            }
                        }
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

            function dgxz(path) {
                window.location.href = "<%=path%>/teacher/downloadDG?temp=" + path;
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
                alert(url);
                document.getElementById("kcdgurl").src = url;
            }
        </script>
    </body>
</html>
