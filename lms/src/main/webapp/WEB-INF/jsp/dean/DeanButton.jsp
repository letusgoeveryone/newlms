<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%-- 
    Document   : deanButton
    Created on : 2016-3-21, 15:14:01
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<div class="bg-content"></div>
<div class="container " style="position:relative;">
    <nav id="lms_admin_dnav">
        <div>
            <a href="#lms_main" class="btn lms-c-text-light waves-attach waves-light waves-effect pull-left" data-toggle="tab">
                <span> 返回 </span> 
            </a>
        </div>
    </nav>

    <div class="row width-control stage-box" id="lms_admin_dbtn">
        <div class="col-md-5 card">
            <aside class="card-side card-side-img pull-right">
                <img alt="alt text" src="<%=path%>/images/dean_end.bmp" class="img-right">
            </aside>
            <div class="card-main">
                <div class="card-inner">
                    <p class="card-heading">Great End !</p>
                    <p class="margin-bottom-lg">
                        确定这学期结束了么(⊙o⊙)？
                    </p>
                </div>
                <div class="card-action">
                    <div class="card-action-btn pull-left">
                        <button class="btn btn-flat waves-attach waves-effect" data-toggle="modal" data-target="#modalEndTerm"  >CLICK TO CONTINUE</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-5 col-md-offset-2 card">
            <aside class="card-side card-side-img pull-left">
                <img alt="alt text" src="<%=path%>/images/dean_start.bmp"  class="img-left">
            </aside>
            <div class="card-main">
                <div class="card-inner">
                    <p class="card-heading">Good start !</p>
                    <p class="margin-bottom-lg">
                        确定要开始新的学期了么\(≧▽≦)/
                    </p>
                </div>
                <div class="card-action">
                    <div class="card-action-btn pull-left">
                        <button class="btn btn-flat waves-attach waves-effect" data-toggle="modal" data-target="#modalStartTerm"  >CLICK TO CONTINUE</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="modal fade" id="modalEndTerm" role="dialog" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-heading">
                    <a class="modal-close" data-dismiss="modal">×</a>
                    <h2 class="modal-title">:-)</h2>
                </div>
                <div class="modal-inner">
                    <p class = "test-center h4">您确定要结束本学期了么？<span class="small">做最后一次确认吧</span></p>
                </div>
                <div class="modal-footer">
                    <p class="text-right"><button class="btn btn-flat btn-brand waves-attach waves-effect" data-dismiss="modal" type="button">Close</button><button class="btn btn-flat btn-brand waves-attach waves-effect" data-dismiss="modal" type="button" id ="end">OK</button></p>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalStartTerm" role="dialog" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-heading">
                    <a class="modal-close" data-dismiss="modal">×</a>
                    <h2 class="modal-title">:-)</h2>
                </div>
                <div class="modal-inner">
                    <p class = "test-center h4">您确定要开始新的学期了么？<span class="small">做最后一次确认吧</span></p>
                </div>
                <div class="modal-footer">
                    <p class="text-right"><button class="btn btn-flat  btn-brand waves-attach waves-effect" data-dismiss="modal" type="button">Close</button><button class="btn btn-flat btn-brand waves-attach waves-effect" data-dismiss="modal" type="button" id ="begin">OK</button></p>
                </div>
            </div>
        </div>
    </div>


    <script>
        $(function(){


        $("#begin").click(function(){
            $.post("<%=path%>/dean/start",
            function(data){

               if(data === "1"){alert("新学期开始成功")};
                if(data ==="0"){alert("新学期开始失败")};
                })
        });
         $("#end").click(function(){

            $.post("<%=path%>/dean/end",
            function(data){
                if(data=="1"){alert("旧学期结束成功")};
                if(data=="0"){alert("旧学期结束失败")};
                }
             );
        });
        });
    </script>
</div>
