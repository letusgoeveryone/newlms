<%--
    Document   : index-calendar
    Created on : 2015-7-21, 20:47:44
    Author     : llgt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>日历</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/calendar.css">
        <link href="css/fullcalendar.css" rel="stylesheet">
        <link href="css/fullcalendar.print.css" rel="stylesheet" media="print" />

        <!-- BOOTSTRAP FRAME -->
    </head>
    <body>
        <header class="container">


            <blockquote class="pull-right" contenteditable="true">
                <p><strong>Henu University&nbsp;</strong> 是一所开放的,与时俱进的综合性大学.</p>
                <small class="pull-right">关键词 <cite title="Source Title">时代</cite></small>
            </blockquote>

            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-tabs navbar-nav col-md-6">
                        <li class="active"><a href="#">首页</a></li>
                        <li><a href="#">代码</a></li>
                        <li><a href="#">求学</a></li>

                    </ul>
                    <ul class="nav nav-tabs navbar-nav col-md-6">
                        <li class="pull-right dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                消息&nbsp; <span class="badge pull-right">2</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="#">班级公告&nbsp; <span class="badge">2</span></a></li>
                                <!--<li><a href="#"></a></li>
                    <li><a href="#"></a></li>
                    <li class="divider"></li>
                    <li><a href="#">demo</a></li> -->
                                <li class="divider"></li>
                                <li><a href="#">作业提醒&nbsp; <span class="badge">0</span></a></li>
                            </ul>
                        </li>
                        <li class="pull-right" title="Userinfo"><a>管理员</a></li>
                        <li class="pull-right" title="Username"><a href="">LongYeh</a></li>
                    </ul>
                </div>
            </div>

        </header>
        <div class="container">
            <ol class="breadcrumb pull-left">
                <li id="calendar-smt" class="linkcolor">时间</li>
                <li class="linkcolor">2015</li>
                <li class="active">第二学年</li>
        </div>
        <div class="container">
            <!-- <div class="row">
                <div class="col-md-12 page-header">
                        <h2 class=" pull-left">概览<small>日历</small></h2>
                </div>
            </div> -->
            <h2 class=" pull-left">概览<small>日历</small></h2>

            <div style='clear:both'></div>
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-10"> <!--  id='wrap'  ? -->
                    <div id='calendar'></div>
                </div>
            </div>
        </div>

        <footer class="container">
            <div class="row">
                <div class="col-md-12  main">
                    <h5 class="page-header"><span class="text-muted"><strong>Copyright © 2015 ● 河南大学软件学院</strong></span>
                    </h5>
                    <div class="row placeholders">

                        <div class="col-md-4 placeholder">
                            <h4>地址</h4>
                            <span class="text-muted">开封市 金明区金明大道</span>
                        </div>

                        <div class="col-md-4 placeholder">
                            <h4>关于我们</h4>
                            <span class="text-muted">我们的主页:</span>
                            <span class="text-muted"> <a href="#">LongYeh</a></span>
                        </div>

                        <div class="col-md-4 placeholder">
                            <h4>Feedback</h4><span class="text-muted">
                            Email:<a href="mailto:llgtgx1@hotmail.com">llgtgx1@hotmail.com</a></span> <br/>
                            <span class="text-muted">帮助: <a href="#">帮助文档</a></span>
                        </div>

                    </div>
                </div>

            </div>
            <h1 class="page-header"></h1>
        </footer>

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src='js/moment.min.js'></script>
        <script src='js/jquery-ui.custom.min.js'></script>
        <script src='js/fullcalendar.min.js'></script>
        <script src='js/zh-cn.js'></script>
        <script>

                $(document).ready(function() {


                        /* initialize the external events
                        -----------------------------------------------------------------*/

                        $('#external-events .fc-event').each(function() {

                                // store data so the calendar knows to render an event upon drop
                                $(this).data('event', {
                                        title: $.trim($(this).text()), // use the element's text as the event title
                                        stick: true // maintain when user navigates (see docs on the renderEvent method)
                                });

                                // make the event draggable using jQuery UI
                                $(this).draggable({
                                    zIndex: 999,
                                    revert: true, // will cause the event to go back to its
                                    revertDuration: 0  //  original position after the drag
                                });

                        });


                        /* initialize the calendar
                         -----------------------------------------------------------------*/

                        $('#calendar').fullCalendar({
                            header: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'month,agendaWeek,agendaDay'
                            },
                            editable: true,
                            droppable: true, // this allows things to be dropped onto the calendar
                            drop: function () {
                                // is the "remove after drop" checkbox checked?
                                if ($('#drop-remove').is(':checked')) {
                                    // if so, remove the element from the "Draggable Events" list
                                    $(this).remove();
                                }
                            }
                        });

                });

        </script>
    </body>
</html>
