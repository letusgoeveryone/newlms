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
        <title>『关于我们』| 教务系统</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.css" k rel="stylesheet" />
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="css/lms.css" rel="stylesheet" />

        <style>

            #tree-us {
                min-height: 1000px;
            }

            #tree-us>div>article,
            #tree-us>div>div {    
                padding: 10px;
                margin: 0 15px 0 0 !important;
            }

            #tree-us>.bg-content {
                margin-top: 3em;
            }
            
            .nav > li > a:hover, .nav > li > a:focus {
                text-decoration: none;
                background-color: transparent;
            }
            .lms-us-vcard{
                width: 960px;
                margin:0 auto 2em;
                box-shadow: 0 0px 1px rgba(0, 0, 0, 0.4) !important;
            }
            .text-lightgreen{
                color: rgba(21, 87, 57, 0.78);
            }
            .lms-us-vcard>div{
                padding: 0 2.5em 2em !important;
            }
            .lms-us-vstatus{
                margin: 1em 0;
            }
            .lms-uv-detail{
                padding: 0 1em;
            }
            .lms-us-team{
                padding-left: 1em;
            }
            .lms-us-team>h1{
                color: rgba(0,0,0,.38);
            }
            .small-bottom{
                margin-left: 1em;
                font-size: 18px;
                font-weight: bolder;
                color: rgba(0,0,0,.2);
            }
            .lms-us-leader{
                font-weight: bolder;
                font-size: larger;
                margin: 2em auto .1em;
                color: rgba(243, 243, 243, 0.75);
            }
            .lms-us-members{
                color: rgba(253, 253, 253, 0.65);
            }
        </style>


    </head>

    <body id="tree-frame" class="height-control">

        <header class="header header-brand header-waterfall ui-header" id="tree-header">
            <ul class="nav nav-list pull-left">
                <li>
                    <a href="<%=path%>/login" class="waves-attach waves-effect">
                        <span class="icon icon-lg">arrow_back</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | <span id="settings-head">&nbsp;关于我们</span></span>

        </header> 

        <div id="tree-us" class="stage-image stage-box height-control" style="background-image:url(images/bg-for-role.jpg)">
            <div class="lms-us-vcard row bg-content card">
                
                <div class="col-md-4 card-inner divider-right">
                    <h2 class="page-header text-lightgreen">Contact</h2>
                    
                    <div>
                        <div class="lms-us-vstatus"><span class="icon">location_on</span><span class="lms-uv-detail">中国 河南 开封 金明大道</span></div> 
                        <div class="lms-us-vstatus"><span class="icon">chat_bubble_outline</span><span class="lms-uv-detail">0371-1234567</span></div> 
                        <div class="lms-us-vstatus"><span class="icon">email</span><span class="lms-uv-detail">helloworld@139.com</span></div> 
                        <div class="lms-us-vstatus"><span class="icon">link</span><span class="lms-uv-detail">software.henu.edu.cn</span></div>  
                    </div>
                    
                </div>
                
                <!-- 一些美丽的句子 和 标语 -->
                <article class="col-md-8 card-inner" style="background-color: rgba(21, 87, 57, 0.78);margin: 0px;">
                    <div class="lms-us-team">
                        <h1 >开发团队<span class="small-bottom">Development Team</span></h1>

                        
                        <p class="lms-us-leader">架构设计 王洪涛</p>
                        <p class="lms-us-members">开发人员：刘炳旭，刘煜，李汶龙，王鸿运，侯鋆，常成蕾 等 ……</p>
                        <p></p>
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
