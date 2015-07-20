<%-- 
    Document   : index-main
    Created on : 2015-7-20, 8:49:54
    Author     : llgt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head lang="zh-CN">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>主页</title>

        <link rel="stylesheet" href="css/prettify-themes/hemisu-light.css">
        <link rel="stylesheet" href="css/bootstrap.css">

        <link rel="stylesheet" href="css/main.css">

        <style>
        </style>

        <!-- BOOTSTRAP FRAMEWORK -->
    </head>
    <body onload="prettyPrint()">
        <header class="container">

            <head class="head">
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
        </head>
    </header>


    <div class="container">
        <ol class="breadcrumb">
            <li><a href="">时间</a></li>
            <li><a href="">2015</a></li>
            <li class="active">第二学年</li>
            <div class="pull-right">
                <span class="label label-default">默认标签</span>
                <span class="label label-primary">主要标签</span>
                <span class="label label-success">成功标签</span>
                <span class="label label-info">信息标签</span>
                <span class="label label-warning">警告标签</span>
                <span class="label label-danger">危险标签</span>
            </div>
        </ol>
        <!-- 一些美丽的句子 和 标语 -->
    </div>
    <div class="container">
        <h1 class="">河大<small>软件University</small></h1>
        <div class="page-header pull-right">
            <h1>-- 邱
                <small>林斐</small>
            </h1>
        </div>
        <p>
            <br/> 我很幸运成为你偶遇的分享者
            <br/> 每一次见面，你从不吝惜把你内心丰溢的生息倾注于我的杯
            <br/> 我的固执不是因为对你任何一桩现实的责难，而是对自己个我生命忠贞不二的守信
            <br/> 你甚美丽，你一向甚我美丽
        </p>
    </div>
    <div class="container">
        <div>
            <div>
                <dl class="dl-horizontal pull-right" contenteditable="true">
                    <dt>河南大学</dt>
                    <dd>源于1912 ;
                        <br>
                    </dd>
                    <dt>河南大学软件学院</dt>
                    <dd>源于你的加入 !
                        <br>
                    </dd>
                </dl>
            </div>
        </div>
    </div>
    <!-- 专业块 -->
    <div class="container">
        <div class="jumbotron">
            <h1>你好！<small>Aloha ~</small></h1>
            <!-- <p><a class="btn btn-primary btn-lg" role="button">
学习更多</a>
</p> -->
            <div class="row">
                <div class="col-sm-6 col-md-3">
                    <div class="thumbnail">
                        <img src="images/henu-minglun.jpg" alt="软工">
                    </div>
                    <div class="caption">
                        <h3>软工</h3>
                        <p>
                            <a href="#" class="btn btn-primary" role="button">
                                进入
                            </a>
                            <a href="#" class="btn btn-default" role="button">
                                访问
                            </a>
                        </p>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="thumbnail">
                        <img src="images/henu-minglun.jpg" alt="网工">
                    </div>
                    <div class="caption">
                        <h3>网工</h3>
                        <p>
                            <a href="#" class="btn btn-primary" role="button">
                                进入
                            </a>
                            <a href="#" class="btn btn-default" role="button">
                                访问
                            </a>
                        </p>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="thumbnail">
                        <img src="images/henu-minglun.jpg" alt="计科">
                    </div>
                    <div class="caption">
                        <h3>计科</h3>
                        <p>
                            <a href="#" class="btn btn-primary" role="button">
                                进入
                            </a>
                            <a href="#" class="btn btn-default" role="button">
                                访问
                            </a>
                        </p>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="thumbnail">
                        <img src="images/henu-minglun.jpg" alt="数媒">
                    </div>
                    <div class="caption">
                        <h3>数媒</h3>
                        <p>
                            <a href="#" class="btn btn-primary" role="button">
                                进入
                            </a>
                            <a href="#" class="btn btn-default" role="button">
                                访问
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 
页面标题（Page Header）是个不错的功能，它会在网页标题四周添加适当的间距。
当一个网页中有多个标题且每个标题之间需要添加一定的间距时，页面标题这个功能就显得特别有用。
如需使用页面标题（Page Header），请把您的标题放置在带有 class .page-header 的 <div> 中：
    -->

    <!-- 关于我们 和 代码模块 -->
    <div class="container min-height">
        <div class="row">
            <div class="col-md-5">
                <ul id="myTab" class="nav nav-tabs">
                    <li class="disabled"><a>导航</a></li>
                    <li class="active">
                        <a href="#home" data-toggle="tab">
                            关于我们
                        </a>
                    </li>
                    <li><a href="#qianT" data-toggle="tab">前台</a></li>
                    <li><a href="#houT" data-toggle="tab">后台</a></li>
                    <li><a href="#tech" data-toggle="tab">技术</a></li>
                    <!-- <li class="dropdown">
  <a href="#" id="myTabDrop1" class="dropdown-toggle" 
     data-toggle="dropdown">技术 
     <b class="caret"></b>
  </a>
  <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
     <li><a href="#basic" tabindex="-1" data-toggle="tab">Html Css Js</a></li>
     <li><a href="#plugin" tabindex="-1" data-toggle="tab">Bootstrap jquery</a></li>
  </ul>
</li> -->
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade in active" id="home">
                        <p>We are student !</p>
                    </div>
                    <div class="tab-pane fade" id="qianT">
                        <p>:)</p>
                    </div>
                    <div class="tab-pane fade" id="houT">
                        <p>:D</p>
                    </div>
                    <div class="tab-pane fade" id="tech">
                        <p>:0</p>
                    </div>
                    <!-- <div class="tab-pane fade" id="plugin">
  <p>;D
  </p>
</div> -->
                </div>
            </div>
            <div class="col-md-7">
                <h3>Hello world !</h3>
                <pre class="prettyprint lang-c"><!--add 'linenums' class will offer a line number --># include &lt;stdio.h&gt;<br/>int main(void){<br/>	printf("hello world !");<br/>	return 0;<br/>}</pre>
                <ul class="pagination">
                    <li><a href="#">&laquo;</a></li>
                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#">&raquo;</a></li>
                </ul>
            </div>
        </div>
    </div>
    <footer class="container">
        <div class="row">

            <div class="col-md-4">
                <img src="images/footer-logo.png" class="img-footer">
            </div>
            <div class="col-md-8" title="© 2015 河南大学">
                <address>
                    <ul>
                        <li><br/></li>
                        <li><br/></li>
                        <li> <strong>Copyright © 2015 ● 河南大学软件学院</strong></li>
                        <li>开封市 金明区金明大道</li>
                        <li><span title="Phone">联系方式:</span> (123) XXX-XXXX</li>
                        <li ></li>
                        <li><strong>Feedback</strong></li>
                        <li><a href="mailto:#">mailto@somedomain.com</a></li>
                    </ul>
                </address>
            </div>
            <!--
<div class="col-md-4">
</div>
            -->
        </div>
        <div class="row">

        </div>
    </footer>

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/prettify.js"></script>
</body>

</html>
