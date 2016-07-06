<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <title>关于我们</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
        <link rel="stylesheet" type="text/css" href="css/lms.css" />
        <style media="screen">
            #tree-frame .navbar{
                margin-bottom: 0;
                border-radius: 0;
            }
            #tree-us{
                min-height: 1000px;
            }
            #tree-us>div>article,
            #tree-us>div>div{
                padding: 10px;
                margin: 10px auto;
            }
            #tree-us >.bg-content {
                margin-top: 3em;
            }
        </style>
    </head>
    <body id="tree-frame" class="height-control">

        <header class="navbar navbar-inverse"  id="tree-header">
            <div class="navbar-header"><a class="navbar-brand" href="index">返回</a> </div>
            <ul class="nav navbar-nav navbar-right"><li ><a class="btn-forline active" style="margin-right: 1em;"> 我 ∞ 们 </a></li></ul>
        </header>

        <div id="tree-us" class="stage-image stage-box height-control" style="background-image:url(images/bg-for-role.jpg)"  >
            <div class="container bg-content">
                <div class="row">
                    <h1 class="page-header">我们<small>  &nbsp; :)</small></h1>
                    <div class=" col-md-12 breadcrumb">
                        -<div class="pull-right "><span class="label label-primary"> 平 静 </span> &nbsp; <span class="label label-warning"> 谦 逊 </span> &nbsp; <span class="label label-info"> 清 澈 </span> &nbsp; <span class="label label-danger"> 热 情 </span></div>
                    </div>
                </div>
                <!-- 一些美丽的句子 和 标语 -->
                <article class="row">
                    <div id="quto" >
                        <h2 class="page-header pull-right hidden-xm hidden-xs">-- 寄<small>语</small></h2>
                        <h2 class=" visible-xs visible-xm ">寄<small>语:</small> </h2>
                        <p>
                            <br/> 我很幸运成为你偶遇的分享者
                            <br/> 每一次见面，你从不吝惜把你内心丰溢的生息倾注于我的杯
                            <br/> 我的固执不是因为对你任何一桩现实的责难，而是对自己个我生命忠贞不二的守信
                            <br/> 你甚美丽，你一向甚我美丽
                        </p>
                    </div>
                    <div class="row hidden-xm hidden-xs">
                        <dl class="dl-horizontal pull-right" contenteditable="false">
                            <dt>河南大学</dt>
                            <dd>源于1912 ;<br /></dd>
                            <dt>河南大学软件学院</dt>
                            <dd>源于你的加入 !<br /></dd>
                        </dl>
                    </div>
                </article>
            </div>
        </div>
        <!--  主页页尾 开始 -->

        <footer class="ui-footer" id="tree-footer">
            <div class="container">
                <p style="text-align: center">
                    <strong class="">Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
                </p>
            </div>
        </footer>

        <!--  主页页尾 结束 -->

        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/configure.js"></script>
    </body>
</html>