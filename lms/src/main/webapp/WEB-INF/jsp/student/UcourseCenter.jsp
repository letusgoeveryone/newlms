<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
        <meta charset="UTF-8">
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>教务系统 |　学生 ( 课程中心 )</title>

        <link href="<%=path%>/css/nprogress.css" rel="stylesheet" />
        <script src="<%=path%>/js/nprogress.js"  ></script>
        <script>NProgress.start();</script>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/jquery.fs.boxer.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <script src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/vue.js"></script>
    </head>
    <body id="lms_stu_cou">
        <!--header-->
        <header class="header header-brand header-waterfall ui-header">
            <ul class="nav nav-list pull-left">
                <li>
                    <a href="<%=path%>/student">
                        <span class="icon icon-lg">arrow_back</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | <span id="settings-head">&nbsp;课程中心</span></span>
            <ul class="nav nav-list pull-right">
                <li class="dropdown">
                    <a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown" >
                        <span class="access-hide">Avatar</span>
                        <span class="avatar avatar-sm"><img alt="alt text for John Smith avatar" src="<%=path%>/images/avatar/${avatar}.svg"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li class="">
                            <a class="waves-attach waves-effect" href="<%=path%>/logout">
                                <span class="icon mg-sm-right">exit_to_app</span> 登出
                            </a>
                        </li>

                        <!--                        
                        <li>
                            <a class="padding-right-lg waves-attach waves-effect" href="javascript:void(0)"><span class="icon mg-sm-right">account_box</span>帮助</a>
                        </li>
                        <li>
                            <a class="padding-right-lg waves-attach waves-effect" href="javascript:void(0)"><span class="icon mg-sm-right">add_to_photos</span>报告BUG</a>
                        </li>
                        -->
                        
                    </ul>
                </li>
            </ul>
        </header>                   
        <div class="container-fluid tab-content mg-hd-top">

            <div class="row tab-pane fade active in" id="lms_ci_area" > 
                <div class="lms-course-index">
                    <div class="container">

                        <!--table：Header-->
                        <div class="text-black bt pd-bm lms-ci-header">全部课程</div>

                        <!--table：nav：category：
                        <div class="lms-course-category">
                            <ul>
                                <li class="lms-cc-header"><a href="#">年级 [ Sample ] :</a></li>
                                <li class="lms-cc-item active"><a href="#"> 全部 </a></li>
                                <li class="lms-cc-item"><a href="#">13 级 </a></li>
                                <li class="lms-cc-item"><a href="#">14 级 </a></li>
                                <li class="lms-cc-item"><a href="#">15 级 </a></li>
                                <li class="lms-cc-item"><a href="#">16 级 </a></li>
                            </ul>

                        </div>1-->

                        <!--table：nav：category：2-->
                        <div class="lms-course-category">
                            <ul data-filter="status">
                                <li class="lms-cc-header"><a href="#">状态:</a></li>
                                <!--<li class="lms-cc-item"><a href="#" data-parm="all-status"> 全部 </a></li>-->
                                <li class="lms-cc-item"><a href="#" data-parm="ocourse">已选 </a></li>
                                <li class="lms-cc-item"><a href="#" data-parm="icourse">未批准 </a></li>
                                <li class="lms-cc-item active"><a href="#" data-parm="xcourse">未选 </a></li>
                            </ul>

                        </div>

                        <!--table：nav：category：
                        <div class="lms-course-category">
                            <ul>
                                <li class="lms-cc-header"><a href="#">性质 [ Sample ] :</a></li>
                                <li class="lms-cc-item active"><a href="#"> 全部 </a></li>
                                <li class="lms-cc-item"><a href="#">专业 必修</a></li>
                                <li class="lms-cc-item"><a href="#">公共 必修 </a></li>
                                <li class="lms-cc-item"><a href="#">专业 选修 </a></li>
                                <li class="lms-cc-item"><a href="#">公共 选修 </a></li>
                            </ul>

                        </div>3-->

                    </div>
                </div>

                <div id="view-model" class="">
                    <div class="view-model-gbtn container">
                        <div class="btn btn-flat active"><span class="icon">view_list</span>&nbsp;选课列表</div>
                        <!--<div class="btn btn-flat active"><span class="icon icon-lg">details</span>&nbsp;卡片</div>-->
                    </div>
                </div>
                
                <div class="lms-course-content col-md-12">
                    <div class="card-x" hidden="hidden"></div>
                    <div class=" " id="lms_card_bg" style="min-height: 2000px;">
                        <div class="container lms-course-card">

                            <div id="ucourses">{{{courseTableArea}}}</div>
                            
                            <div hidden="hidden">
                                <div class="card">
                                    <div class="card-main">
                                        <div class="card-img">
                                            <img src="<%=path%>/images/course.jpg" alt="" class="img-responsive" />
                                            <p class="card-img-heading"> C 语言 [ Sample ]</p>
                                        </div>
                                        <div class="card-inner"> 
                                            C 语言是一种通用的、面向过程式的计算机程序设计语言。1972 年，为了移植与开发 UNIX 操作系统，丹尼斯·里奇在贝尔电话实验室设计开发了 C 语言。<br>
                                            C 语言是一种广泛使用的计算机语言，它与 Java 编程语言一样普及，二者在现代软件程序员之间都得到广泛使用。
                                        </div>
                                        <div class="card-action"> 
                                            <br><a class="btn btn-flat btn-block">  查看详情</a>
                                        </div>

                                        <div class="card-more" hidden="hidden">
                                            <nav class="tab-nav hidden-xx">
                                                <ul class="nav nav-list">
                                                    <li class="active">
                                                        <a class="waves-attach waves-light" data-toggle="tab" href="#sample_id_1"><span class="text-white">课程简介</span></a>
                                                    </li>
                                                    <li>
                                                        <a class="waves-attach waves-light" data-toggle="tab" href="#sample_id_2"><span class="text-white">课程大纲</span></a>
                                                    </li>
                                                    <li>
                                                        <a class="waves-attach waves-light" data-toggle="tab" href="#sample_id_3"><span class="text-white">任课老师</span></a>
                                                    </li>
                                                </ul>
                                            </nav>
                                            <div class="container-fluid tab-content">
                                                <div class="row tab-pane fade active in" id="sample_id_1" > 
                                                    <h2 id="section-1">第一部分</h2>
                                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam eu sem tempor, varius quam at, luctus dui. Mauris magna metus, dapibus nec turpis vel, semper malesuada ante. Vestibulum id metus ac nisl bibendum scelerisque non non purus. Suspendisse varius nibh non aliquet sagittis. In tincidunt orci sit amet elementum vestibulum. Vivamus fermentum in arcu in aliquam. Quisque aliquam porta odio in fringilla. Vivamus nisl leo, blandit at bibendum eu, tristique eget risus. Integer aliquet quam ut elit suscipit, id interdum neque porttitor. Integer faucibus ligula.</p>
                                                    <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
                                                    <hr>
                                                    <h2 id="section-2">第二部分</h2>
                                                    <p>Nullam hendrerit justo non leo aliquet imperdiet. Etiam in sagittis lectus. Suspendisse ultrices placerat accumsan. Mauris quis dapibus orci. In dapibus velit blandit pharetra tincidunt. Quisque non sapien nec lacus condimentum facilisis ut iaculis enim. Sed viverra interdum bibendum. Donec ac sollicitudin dolor. Sed fringilla vitae lacus at rutrum. Phasellus congue vestibulum ligula sed consequat.</p>
                                                    <p>Vestibulum consectetur scelerisque lacus, ac fermentum lorem convallis sed. Nam odio tortor, dictum quis malesuada at, pellentesque vitae orci. Vivamus elementum, felis eu auctor lobortis, diam velit egestas lacus, quis fermentum metus ante quis urna. Sed at facilisis libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum bibendum blandit dolor. Nunc orci dolor, molestie nec nibh in, hendrerit tincidunt ante. Vivamus sem augue, hendrerit non sapien in, mollis ornare augue.</p>
                                                    <hr>
                                                    <h2 id="section-3">第三部分</h2>
                                                    <p>Integer pulvinar leo id risus pellentesque vestibulum. Sed diam libero, sodales eget sapien vel, porttitor bibendum enim. Donec sed nibh vitae lorem porttitor blandit in nec ante. Pellentesque vitae metus ipsum. Phasellus sed nunc ac sem malesuada condimentum. Etiam in aliquam lectus. Nam vel sapien diam. Donec pharetra id arcu eget blandit. Proin imperdiet mattis augue in porttitor. Quisque tempus enim id lobortis feugiat. Suspendisse tincidunt risus quis dolor fringilla blandit. Ut sed sapien at purus lacinia porttitor. Nullam iaculis, felis a pretium ornare, dolor nisl semper tortor, vel sagittis lacus est consequat eros. Sed id pretium nisl. Curabitur dolor nisl, laoreet vitae aliquam id, tincidunt sit amet mauris.</p>
                                                    <p>Phasellus vitae suscipit justo. Mauris pharetra feugiat ante id lacinia. Etiam faucibus mauris id tempor egestas. Duis luctus turpis at accumsan tincidunt. Phasellus risus risus, volutpat vel tellus ac, tincidunt fringilla massa. Etiam hendrerit dolor eget ante rutrum adipiscing. Cras interdum ipsum mattis, tempus mauris vel, semper ipsum. Duis sed dolor ut enim lobortis pellentesque ultricies ac ligula. Pellentesque convallis elit nisi, id vulputate ipsum ullamcorper ut. Cras ac pulvinar purus, ac viverra est. Suspendisse potenti. Integer pellentesque neque et elementum tempus. Curabitur bibendum in ligula ut rhoncus.</p>
                                                    <p>Quisque pharetra velit id velit iaculis pretium. Nullam a justo sed ligula porta semper eu quis enim. Pellentesque pellentesque, metus at facilisis hendrerit, lectus velit facilisis leo, quis volutpat turpis arcu quis enim. Nulla viverra lorem elementum interdum ultricies. Suspendisse accumsan quam nec ante mollis tempus. Morbi vel accumsan diam, eget convallis tellus. Suspendisse potenti.</p>
                                                    <hr>
                                                    <h2 id="section-4">第四部分</h2>
                                                    <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
                                                    <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
                                                    <p>Phasellus fermentum, neque sit amet sodales tempor, enim ante interdum eros, eget luctus ipsum eros ut ligula. Nunc ornare erat quis faucibus molestie. Proin malesuada consequat commodo. Mauris iaculis, eros ut dapibus luctus, massa enim elementum purus, sit amet tristique purus purus nec felis. Morbi vestibulum sapien eget porta pulvinar. Nam at quam diam. Proin rhoncus, felis elementum accumsan dictum, felis nisi vestibulum tellus, et ultrices risus felis in orci. Quisque vestibulum sem nisl, vel congue leo dictum nec. Cras eget est at velit sagittis ullamcorper vel et lectus. In hac habitasse platea dictumst. Etiam interdum iaculis velit, vel sollicitudin lorem feugiat sit amet. Etiam luctus, quam sed sodales aliquam, lorem libero hendrerit urna, faucibus rhoncus massa nibh at felis. Curabitur ac tempus nulla, ut semper erat. Vivamus porta ullamcorper sem, ornare egestas mauris facilisis id.</p>
                                                    <p>Ut ut risus nisl. Fusce porttitor eros at magna luctus, non congue nulla eleifend. Aenean porttitor feugiat dolor sit amet facilisis. Pellentesque venenatis magna et risus commodo, a commodo turpis gravida. Nam mollis massa dapibus urna aliquet, quis iaculis elit sodales. Sed eget ornare orci, eu malesuada justo. Nunc lacus augue, dictum quis dui id, lacinia congue quam. Nulla sem sem, aliquam nec dolor ac, tempus convallis nunc. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla suscipit convallis iaculis. Quisque eget commodo ligula. Praesent leo dui, facilisis quis eleifend in, aliquet vitae nunc. Suspendisse fermentum odio ac massa ultricies pellentesque. Fusce eu suscipit massa.</p>
                                                    <hr>
                                                    <h2 id="section-5">第五部分</h2>
                                                    <p>Nam eget purus nec est consectetur vehicula. Nullam ultrices nisl risus, in viverra libero egestas sit amet. Etiam porttitor dolor non eros pulvinar malesuada. Vestibulum sit amet est mollis nulla tempus aliquet. Praesent luctus hendrerit arcu non laoreet. Morbi consequat placerat magna, ac ornare odio sagittis sed. Donec vitae ullamcorper purus. Vivamus non metus ac justo porta volutpat.</p>
                                                    <p>Vivamus mattis accumsan erat, vel convallis risus pretium nec. Integer nunc nulla, viverra ut sem non, scelerisque vehicula arcu. Fusce bibendum convallis augue sit amet lobortis. Cras porta urna turpis, sodales lobortis purus adipiscing id. Maecenas ullamcorper, turpis suscipit pellentesque fringilla, massa lacus pulvinar mi, nec dignissim velit arcu eget purus. Nam at dapibus tellus, eget euismod nisl. Ut eget venenatis sapien. Vivamus vulputate varius mauris, vel varius nisl facilisis ac. Nulla aliquet justo a nibh ornare, eu congue neque rutrum.</p>
                                                    <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
                                                    <p>Morbi sed fermentum ipsum. Morbi a orci vulputate tortor ornare blandit a quis orci. Donec aliquam sodales gravida. In ut ullamcorper nisi, ac pretium velit. Vestibulum vitae lectus volutpat, consequat lorem sit amet, pulvinar tellus. In tincidunt vel leo eget pulvinar. Curabitur a eros non lacus malesuada aliquam. Praesent et tempus odio. Integer a quam nunc. In hac habitasse platea dictumst. Aliquam porta nibh nulla, et mattis turpis placerat eget. Pellentesque dui diam, pellentesque vel gravida id, accumsan eu magna. Sed a semper arcu, ut dignissim leo.</p>
                                                    <p>Sed vitae lobortis diam, id molestie magna. Aliquam consequat ipsum quis est dictum ultrices. Aenean nibh velit, fringilla in diam id, blandit hendrerit lacus. Donec vehicula rutrum tellus eget fermentum. Pellentesque ac erat et arcu ornare tincidunt. Aliquam erat volutpat. Vivamus lobortis urna quis gravida semper. In condimentum, est a faucibus luctus, mi dolor cursus mi, id vehicula arcu risus a nibh. Pellentesque blandit sapien lacus, vel vehicula nunc feugiat sit amet.</p>
                                                </div>
                                                <div class="row tab-pane fade" id="sample_id_2" > 
                                                    <h2 id="section-1">第一部分</h2>
                                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam eu sem tempor, varius quam at, luctus dui. Mauris magna metus, dapibus nec turpis vel, semper malesuada ante. Vestibulum id metus ac nisl bibendum scelerisque non non purus. Suspendisse varius nibh non aliquet sagittis. In tincidunt orci sit amet elementum vestibulum. Vivamus fermentum in arcu in aliquam. Quisque aliquam porta odio in fringilla. Vivamus nisl leo, blandit at bibendum eu, tristique eget risus. Integer aliquet quam ut elit suscipit, id interdum neque porttitor. Integer faucibus ligula.</p>
                                                    <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
                                                    <hr>
                                                    <h2 id="section-2">第二部分</h2>
                                                    <p>Nullam hendrerit justo non leo aliquet imperdiet. Etiam in sagittis lectus. Suspendisse ultrices placerat accumsan. Mauris quis dapibus orci. In dapibus velit blandit pharetra tincidunt. Quisque non sapien nec lacus condimentum facilisis ut iaculis enim. Sed viverra interdum bibendum. Donec ac sollicitudin dolor. Sed fringilla vitae lacus at rutrum. Phasellus congue vestibulum ligula sed consequat.</p>
                                                    <p>Vestibulum consectetur scelerisque lacus, ac fermentum lorem convallis sed. Nam odio tortor, dictum quis malesuada at, pellentesque vitae orci. Vivamus elementum, felis eu auctor lobortis, diam velit egestas lacus, quis fermentum metus ante quis urna. Sed at facilisis libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum bibendum blandit dolor. Nunc orci dolor, molestie nec nibh in, hendrerit tincidunt ante. Vivamus sem augue, hendrerit non sapien in, mollis ornare augue.</p>
                                                    <hr>
                                                    <h2 id="section-3">第三部分</h2>
                                                    <p>Integer pulvinar leo id risus pellentesque vestibulum. Sed diam libero, sodales eget sapien vel, porttitor bibendum enim. Donec sed nibh vitae lorem porttitor blandit in nec ante. Pellentesque vitae metus ipsum. Phasellus sed nunc ac sem malesuada condimentum. Etiam in aliquam lectus. Nam vel sapien diam. Donec pharetra id arcu eget blandit. Proin imperdiet mattis augue in porttitor. Quisque tempus enim id lobortis feugiat. Suspendisse tincidunt risus quis dolor fringilla blandit. Ut sed sapien at purus lacinia porttitor. Nullam iaculis, felis a pretium ornare, dolor nisl semper tortor, vel sagittis lacus est consequat eros. Sed id pretium nisl. Curabitur dolor nisl, laoreet vitae aliquam id, tincidunt sit amet mauris.</p>
                                                    <p>Phasellus vitae suscipit justo. Mauris pharetra feugiat ante id lacinia. Etiam faucibus mauris id tempor egestas. Duis luctus turpis at accumsan tincidunt. Phasellus risus risus, volutpat vel tellus ac, tincidunt fringilla massa. Etiam hendrerit dolor eget ante rutrum adipiscing. Cras interdum ipsum mattis, tempus mauris vel, semper ipsum. Duis sed dolor ut enim lobortis pellentesque ultricies ac ligula. Pellentesque convallis elit nisi, id vulputate ipsum ullamcorper ut. Cras ac pulvinar purus, ac viverra est. Suspendisse potenti. Integer pellentesque neque et elementum tempus. Curabitur bibendum in ligula ut rhoncus.</p>
                                                    <p>Quisque pharetra velit id velit iaculis pretium. Nullam a justo sed ligula porta semper eu quis enim. Pellentesque pellentesque, metus at facilisis hendrerit, lectus velit facilisis leo, quis volutpat turpis arcu quis enim. Nulla viverra lorem elementum interdum ultricies. Suspendisse accumsan quam nec ante mollis tempus. Morbi vel accumsan diam, eget convallis tellus. Suspendisse potenti.</p>
                                                    <hr>
                                                    <h2 id="section-4">第四部分</h2>
                                                    <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
                                                    <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
                                                    <p>Phasellus fermentum, neque sit amet sodales tempor, enim ante interdum eros, eget luctus ipsum eros ut ligula. Nunc ornare erat quis faucibus molestie. Proin malesuada consequat commodo. Mauris iaculis, eros ut dapibus luctus, massa enim elementum purus, sit amet tristique purus purus nec felis. Morbi vestibulum sapien eget porta pulvinar. Nam at quam diam. Proin rhoncus, felis elementum accumsan dictum, felis nisi vestibulum tellus, et ultrices risus felis in orci. Quisque vestibulum sem nisl, vel congue leo dictum nec. Cras eget est at velit sagittis ullamcorper vel et lectus. In hac habitasse platea dictumst. Etiam interdum iaculis velit, vel sollicitudin lorem feugiat sit amet. Etiam luctus, quam sed sodales aliquam, lorem libero hendrerit urna, faucibus rhoncus massa nibh at felis. Curabitur ac tempus nulla, ut semper erat. Vivamus porta ullamcorper sem, ornare egestas mauris facilisis id.</p>
                                                    <p>Ut ut risus nisl. Fusce porttitor eros at magna luctus, non congue nulla eleifend. Aenean porttitor feugiat dolor sit amet facilisis. Pellentesque venenatis magna et risus commodo, a commodo turpis gravida. Nam mollis massa dapibus urna aliquet, quis iaculis elit sodales. Sed eget ornare orci, eu malesuada justo. Nunc lacus augue, dictum quis dui id, lacinia congue quam. Nulla sem sem, aliquam nec dolor ac, tempus convallis nunc. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla suscipit convallis iaculis. Quisque eget commodo ligula. Praesent leo dui, facilisis quis eleifend in, aliquet vitae nunc. Suspendisse fermentum odio ac massa ultricies pellentesque. Fusce eu suscipit massa.</p>
                                                    <hr>
                                                    <h2 id="section-5">第五部分</h2>
                                                    <p>Nam eget purus nec est consectetur vehicula. Nullam ultrices nisl risus, in viverra libero egestas sit amet. Etiam porttitor dolor non eros pulvinar malesuada. Vestibulum sit amet est mollis nulla tempus aliquet. Praesent luctus hendrerit arcu non laoreet. Morbi consequat placerat magna, ac ornare odio sagittis sed. Donec vitae ullamcorper purus. Vivamus non metus ac justo porta volutpat.</p>
                                                    <p>Vivamus mattis accumsan erat, vel convallis risus pretium nec. Integer nunc nulla, viverra ut sem non, scelerisque vehicula arcu. Fusce bibendum convallis augue sit amet lobortis. Cras porta urna turpis, sodales lobortis purus adipiscing id. Maecenas ullamcorper, turpis suscipit pellentesque fringilla, massa lacus pulvinar mi, nec dignissim velit arcu eget purus. Nam at dapibus tellus, eget euismod nisl. Ut eget venenatis sapien. Vivamus vulputate varius mauris, vel varius nisl facilisis ac. Nulla aliquet justo a nibh ornare, eu congue neque rutrum.</p>
                                                    <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
                                                    <p>Morbi sed fermentum ipsum. Morbi a orci vulputate tortor ornare blandit a quis orci. Donec aliquam sodales gravida. In ut ullamcorper nisi, ac pretium velit. Vestibulum vitae lectus volutpat, consequat lorem sit amet, pulvinar tellus. In tincidunt vel leo eget pulvinar. Curabitur a eros non lacus malesuada aliquam. Praesent et tempus odio. Integer a quam nunc. In hac habitasse platea dictumst. Aliquam porta nibh nulla, et mattis turpis placerat eget. Pellentesque dui diam, pellentesque vel gravida id, accumsan eu magna. Sed a semper arcu, ut dignissim leo.</p>
                                                    <p>Sed vitae lobortis diam, id molestie magna. Aliquam consequat ipsum quis est dictum ultrices. Aenean nibh velit, fringilla in diam id, blandit hendrerit lacus. Donec vehicula rutrum tellus eget fermentum. Pellentesque ac erat et arcu ornare tincidunt. Aliquam erat volutpat. Vivamus lobortis urna quis gravida semper. In condimentum, est a faucibus luctus, mi dolor cursus mi, id vehicula arcu risus a nibh. Pellentesque blandit sapien lacus, vel vehicula nunc feugiat sit amet.</p>
                                                </div>
                                                <div class="row tab-pane fade" id="sample_id_3" > 
                                                    <h2 id="section-1">第一部分</h2>
                                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam eu sem tempor, varius quam at, luctus dui. Mauris magna metus, dapibus nec turpis vel, semper malesuada ante. Vestibulum id metus ac nisl bibendum scelerisque non non purus. Suspendisse varius nibh non aliquet sagittis. In tincidunt orci sit amet elementum vestibulum. Vivamus fermentum in arcu in aliquam. Quisque aliquam porta odio in fringilla. Vivamus nisl leo, blandit at bibendum eu, tristique eget risus. Integer aliquet quam ut elit suscipit, id interdum neque porttitor. Integer faucibus ligula.</p>
                                                    <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
                                                    <hr>
                                                    <h2 id="section-2">第二部分</h2>
                                                    <p>Nullam hendrerit justo non leo aliquet imperdiet. Etiam in sagittis lectus. Suspendisse ultrices placerat accumsan. Mauris quis dapibus orci. In dapibus velit blandit pharetra tincidunt. Quisque non sapien nec lacus condimentum facilisis ut iaculis enim. Sed viverra interdum bibendum. Donec ac sollicitudin dolor. Sed fringilla vitae lacus at rutrum. Phasellus congue vestibulum ligula sed consequat.</p>
                                                    <p>Vestibulum consectetur scelerisque lacus, ac fermentum lorem convallis sed. Nam odio tortor, dictum quis malesuada at, pellentesque vitae orci. Vivamus elementum, felis eu auctor lobortis, diam velit egestas lacus, quis fermentum metus ante quis urna. Sed at facilisis libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum bibendum blandit dolor. Nunc orci dolor, molestie nec nibh in, hendrerit tincidunt ante. Vivamus sem augue, hendrerit non sapien in, mollis ornare augue.</p>
                                                    <hr>
                                                    <h2 id="section-3">第三部分</h2>
                                                    <p>Integer pulvinar leo id risus pellentesque vestibulum. Sed diam libero, sodales eget sapien vel, porttitor bibendum enim. Donec sed nibh vitae lorem porttitor blandit in nec ante. Pellentesque vitae metus ipsum. Phasellus sed nunc ac sem malesuada condimentum. Etiam in aliquam lectus. Nam vel sapien diam. Donec pharetra id arcu eget blandit. Proin imperdiet mattis augue in porttitor. Quisque tempus enim id lobortis feugiat. Suspendisse tincidunt risus quis dolor fringilla blandit. Ut sed sapien at purus lacinia porttitor. Nullam iaculis, felis a pretium ornare, dolor nisl semper tortor, vel sagittis lacus est consequat eros. Sed id pretium nisl. Curabitur dolor nisl, laoreet vitae aliquam id, tincidunt sit amet mauris.</p>
                                                    <p>Phasellus vitae suscipit justo. Mauris pharetra feugiat ante id lacinia. Etiam faucibus mauris id tempor egestas. Duis luctus turpis at accumsan tincidunt. Phasellus risus risus, volutpat vel tellus ac, tincidunt fringilla massa. Etiam hendrerit dolor eget ante rutrum adipiscing. Cras interdum ipsum mattis, tempus mauris vel, semper ipsum. Duis sed dolor ut enim lobortis pellentesque ultricies ac ligula. Pellentesque convallis elit nisi, id vulputate ipsum ullamcorper ut. Cras ac pulvinar purus, ac viverra est. Suspendisse potenti. Integer pellentesque neque et elementum tempus. Curabitur bibendum in ligula ut rhoncus.</p>
                                                    <p>Quisque pharetra velit id velit iaculis pretium. Nullam a justo sed ligula porta semper eu quis enim. Pellentesque pellentesque, metus at facilisis hendrerit, lectus velit facilisis leo, quis volutpat turpis arcu quis enim. Nulla viverra lorem elementum interdum ultricies. Suspendisse accumsan quam nec ante mollis tempus. Morbi vel accumsan diam, eget convallis tellus. Suspendisse potenti.</p>
                                                    <hr>
                                                    <h2 id="section-4">第四部分</h2>
                                                    <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
                                                    <p>Vestibulum quis quam ut magna consequat faucibus. Pellentesque eget nisi a mi suscipit tincidunt. Ut tempus dictum risus. Pellentesque viverra sagittis quam at mattis. Suspendisse potenti. Aliquam sit amet gravida nibh, facilisis gravida odio. Phasellus auctor velit at lacus blandit, commodo iaculis justo viverra. Etiam vitae est arcu. Mauris vel congue dolor. Aliquam eget mi mi. Fusce quam tortor, commodo ac dui quis, bibendum viverra erat. Maecenas mattis lectus enim, quis tincidunt dui molestie euismod. Curabitur et diam tristique, accumsan nunc eu, hendrerit tellus.</p>
                                                    <p>Phasellus fermentum, neque sit amet sodales tempor, enim ante interdum eros, eget luctus ipsum eros ut ligula. Nunc ornare erat quis faucibus molestie. Proin malesuada consequat commodo. Mauris iaculis, eros ut dapibus luctus, massa enim elementum purus, sit amet tristique purus purus nec felis. Morbi vestibulum sapien eget porta pulvinar. Nam at quam diam. Proin rhoncus, felis elementum accumsan dictum, felis nisi vestibulum tellus, et ultrices risus felis in orci. Quisque vestibulum sem nisl, vel congue leo dictum nec. Cras eget est at velit sagittis ullamcorper vel et lectus. In hac habitasse platea dictumst. Etiam interdum iaculis velit, vel sollicitudin lorem feugiat sit amet. Etiam luctus, quam sed sodales aliquam, lorem libero hendrerit urna, faucibus rhoncus massa nibh at felis. Curabitur ac tempus nulla, ut semper erat. Vivamus porta ullamcorper sem, ornare egestas mauris facilisis id.</p>
                                                    <p>Ut ut risus nisl. Fusce porttitor eros at magna luctus, non congue nulla eleifend. Aenean porttitor feugiat dolor sit amet facilisis. Pellentesque venenatis magna et risus commodo, a commodo turpis gravida. Nam mollis massa dapibus urna aliquet, quis iaculis elit sodales. Sed eget ornare orci, eu malesuada justo. Nunc lacus augue, dictum quis dui id, lacinia congue quam. Nulla sem sem, aliquam nec dolor ac, tempus convallis nunc. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla suscipit convallis iaculis. Quisque eget commodo ligula. Praesent leo dui, facilisis quis eleifend in, aliquet vitae nunc. Suspendisse fermentum odio ac massa ultricies pellentesque. Fusce eu suscipit massa.</p>
                                                    <hr>
                                                    <h2 id="section-5">第五部分</h2>
                                                    <p>Nam eget purus nec est consectetur vehicula. Nullam ultrices nisl risus, in viverra libero egestas sit amet. Etiam porttitor dolor non eros pulvinar malesuada. Vestibulum sit amet est mollis nulla tempus aliquet. Praesent luctus hendrerit arcu non laoreet. Morbi consequat placerat magna, ac ornare odio sagittis sed. Donec vitae ullamcorper purus. Vivamus non metus ac justo porta volutpat.</p>
                                                    <p>Vivamus mattis accumsan erat, vel convallis risus pretium nec. Integer nunc nulla, viverra ut sem non, scelerisque vehicula arcu. Fusce bibendum convallis augue sit amet lobortis. Cras porta urna turpis, sodales lobortis purus adipiscing id. Maecenas ullamcorper, turpis suscipit pellentesque fringilla, massa lacus pulvinar mi, nec dignissim velit arcu eget purus. Nam at dapibus tellus, eget euismod nisl. Ut eget venenatis sapien. Vivamus vulputate varius mauris, vel varius nisl facilisis ac. Nulla aliquet justo a nibh ornare, eu congue neque rutrum.</p>
                                                    <p>Suspendisse a orci facilisis, dignissim tortor vitae, ultrices mi. Vestibulum a iaculis lacus. Phasellus vitae convallis ligula, nec volutpat tellus. Vivamus scelerisque mollis nisl, nec vehicula elit egestas a. Sed luctus metus id mi gravida, faucibus convallis neque pretium. Maecenas quis sapien ut leo fringilla tempor vitae sit amet leo. Donec imperdiet tempus placerat. Pellentesque pulvinar ultrices nunc sed ultrices. Morbi vel mi pretium, fermentum lacus et, viverra tellus. Phasellus sodales libero nec dui convallis, sit amet fermentum sapien auctor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed eu elementum nibh, quis varius libero.</p>
                                                    <p>Morbi sed fermentum ipsum. Morbi a orci vulputate tortor ornare blandit a quis orci. Donec aliquam sodales gravida. In ut ullamcorper nisi, ac pretium velit. Vestibulum vitae lectus volutpat, consequat lorem sit amet, pulvinar tellus. In tincidunt vel leo eget pulvinar. Curabitur a eros non lacus malesuada aliquam. Praesent et tempus odio. Integer a quam nunc. In hac habitasse platea dictumst. Aliquam porta nibh nulla, et mattis turpis placerat eget. Pellentesque dui diam, pellentesque vel gravida id, accumsan eu magna. Sed a semper arcu, ut dignissim leo.</p>
                                                    <p>Sed vitae lobortis diam, id molestie magna. Aliquam consequat ipsum quis est dictum ultrices. Aenean nibh velit, fringilla in diam id, blandit hendrerit lacus. Donec vehicula rutrum tellus eget fermentum. Pellentesque ac erat et arcu ornare tincidunt. Aliquam erat volutpat. Vivamus lobortis urna quis gravida semper. In condimentum, est a faucibus luctus, mi dolor cursus mi, id vehicula arcu risus a nibh. Pellentesque blandit sapien lacus, vel vehicula nunc feugiat sit amet.</p>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="card">
                                    <div class="card-main">
                                        <div class="card-img">
                                            <img src="<%=path%>/images/course.jpg" alt="" class="img-responsive" />
                                            <p class="card-img-heading"> 数据库原理 [ Sample ]</p>
                                        </div>
                                        <div class="card-inner"> 
                                            SQL 是用于访问和处理数据库的标准的计算机语言。<br>
                                        </div>
                                        <div class="card-action"> 
                                            <br><a class="btn btn-flat btn-block">  查看详情</a>
                                        </div>
                                    </div>
                                </div>

                                <div class="card">
                                    <div class="card-main">
                                        <div class="card-img">
                                            <img src="<%=path%>/images/course.jpg" alt="" class="img-responsive" />
                                            <p class="card-img-heading"> C 语言 [ Sample ]</p>
                                        </div>
                                        <div class="card-inner"> 
                                            C 语言是一种通用的、面向过程式的计算机程序设计语言。1972 年，为了移植与开发 UNIX 操作系统，丹尼斯·里奇在贝尔电话实验室设计开发了 C 语言。<br>
                                            C 语言是一种广泛使用的计算机语言，它与 Java 编程语言一样普及，二者在现代软件程序员之间都得到广泛使用。
                                        </div>
                                        <div class="card-action"> 
                                            <br><a class="btn btn-flat btn-block">  查看详情</a>
                                        </div>
                                    </div>
                                </div>

                                <div class="card">
                                    <div class="card-main">
                                        <div class="card-img">
                                            <img src="<%=path%>/images/course.jpg" alt="" class="img-responsive" />
                                            <p class="card-img-heading"> 数据库原理 [ Sample ]</p>
                                        </div>
                                        <div class="card-inner"> 
                                            SQL 是用于访问和处理数据库的标准的计算机语言。<br>
                                        </div>
                                        <div class="card-action"> 
                                            <br><a class="btn btn-flat btn-block">  查看详情</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>

            </div>

            <div class="row tab-pane fade" id="ui_tab_example_1" style="height: 2000px;">       

            </div>

        </div>
        <!--footer-->
        <footer class="ui-footer footer">
            <div class="container">
                <p>河南大学</p>
            </div>
        </footer>
        
        <!--scrollUp-->
        <div class="fbtn-container" id="scrollUp" hidden>
            <div class="fbtn-inner">
                <a class="fbtn fbtn-brand waves-attach waves-circle">
                    <span class="fbtn-text fbtn-text-left">返回顶部</span>
                    <span class="fbtn-ori icon">keyboard_arrow_up</span>
                </a>
            </div>
        </div>

        <!--单向信息传递 snackbar-->
        <div id="snackbar"></div>
        
        <!-- js -->
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script>var pluginMasonry = true;</script>
        <script src="<%=path%>/js/api.student.cou.js" type="text/javascript"></script>
        <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
        <script>
            initCoursePage();
//            $('.lms-course-card').masonry({
//            // options
//            itemSelector: '.card',
//            columnWidth: 10 ,
//            singleMode: true
//          });
          
            // 课程监听器
            
            var activeCourseStatus = "xcourse";
            $('.lms-cc-item').click(function(){
                var parm = $(this).children("a").attr("data-parm");
                console.log("parm is: " +　parm);
                var parent = $(this).parent();
                console.log("parent is: " +　parent);
                filter = parent.attr('data-filter');
                console.log("filter is: " +　filter);
                
                $("[data-filter="+ filter +"]").children("li").removeClass("active");
                $("[data-filter="+ filter +"] [data-parm="+ parm +"]").parent("li").addClass("active");
                
                
                if(parm === "ocourse" && (activeCourseStatus!=="ocourse")){
                    CourseAPI.DefaultParms.method = 'o';
                    updataCourseArea();
                    activeCourseStatus = parm;
                }else if(parm === "xcourse" && (activeCourseStatus!=="xcourse")){
                    CourseAPI.DefaultParms.method = 'x';
                    updataCourseArea();
                    activeCourseStatus = parm;
                }else if(parm === "icourse" && (activeCourseStatus!=="icourse")){
                    CourseAPI.DefaultParms.method = 'i';
                    updataCourseArea();
                    activeCourseStatus = parm;
                }else if(parm === "all-status" && (activeCourseStatus!=="all-status")){
                    CourseAPI.DefaultParms.method = 'x';
                    updataCourseArea();
                    activeCourseStatus = parm;
                }
            });
        </script>
    </body>
</html>
