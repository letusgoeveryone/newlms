/**
 * <br>命名:
 * <br>HS是Html Segment(html片段)的缩写
 * <br>DS是Data Structure(数据结构)的缩写
 * <br>O/o为已, X/x为未, OIX/oix分别表示开始中间结尾(生选课表格HS时用到)
 * @author longyeh\@outlook.com
 */

/**
 * 
 * 
 */

//定义API接口
var StudentAPI = {
    
    id: 0,
    sn: 0,
    name: '',
    ID: 0,
    pw: '',
    sex: false,
    grade: '',
    college: '',
    tel: '',
    qq: '',
    avatar:0,
    

    /**
     * 包含相关JSON路径数组的对象
     * @type Object
     */
    Path: {
        /**
         * 用以初始化个人相关信息 
         * <br>uInfo[0] 当前登录的个人信息 
         * <br>uInfo[1] 更新个人信息 服务器提交路径 
         * <br>uInfo[2] 更新个人密码 服务器提交路径 
         * <br>uInfo[3] 获取已选课程 
         * <br>uInfo[4] 获取可选课程 
         * <br>uInfo[5] 获取已选未批准课程 
         * 
         * @type Array 
         */
        uInfo: [
            "/lms/student/getpersoninfo", //[0] 
            "/lms/student/updatepersoninfo", //[1]  
            "/lms/student/updatepassword", //[2]
            "/lms/student/getselectcourse", //[3] 
            "/lms/student/addnewcourse", //[4] 
            "/lms/student/getselectingcourse"    //[5] 
        ],
        /**
         * 用以初始化课程相关信息 
         * <br>均需额外的路径参数:?scid= 
         * <br>cInfo[0] 返回课程详情 
         * <br>cInfo[1] 返回课程内容目录树JSON 
         * <br>cInfo[2] 返回作业列表 
         * <br>cInfo[3] 用于文件地1预览和播放 
         * <br>cInfo[4] 返回某个课程的资源根地址 
         * <br>cInfo[5] 返回某个作业的详情 
         * 
         * @type Array 
         */
        cInfo: [
            "/lms/student/stu_course", //[0]  
            "/lms/student/kcgs", //[1]  
            "/lms/student/stu_course_homework", //[2] 
            "/lms/student/courdir", //[3]
            "/lms/student/resourcedir", //[4]
            "/lms/student/dohomework"            //[5]
        ],
        /**
         * 用以完成对课程的相关操作 
         * <br>均需额外的路径参数:?scid= 
         * <br>cOperate[0] 提交选课申请,并返回相关状态 [0 - 出错, 1 - 成功]
         * <br>cOperate[1] 取消未批准课程,并返回相关状态 同上
         * <br>cOperate[2] 退出已选课程,并返回相关状态 同上
         * 
         * @type Array
         */
        cOperate: [
            "/lms/student/subselectcourse", //[0] 
            "/lms/student/cancelcourse", //[1] 
            "/lms/student/quitcourse"            //[2] 
        ],
        /**
         * 用以完成对附件的相关操作 
         * <br>fOperate[0] 删除某个作业下面的某一附件 三个参数选课id，作业id，附件名（scid，homeworkid，src） [0 - 出错, 1 - 成功]
         * <br>fOperate[1] 下载某个作业下面的某一附件,三个参数选课id，作业id，附件名（scid，homeworkid，src）
         * <br>fOperate[2] 返回某个作业下面的附件列表,两个参数选课id和作业id（scid，homeworkid）
         * <br>fOperate[3] 学生附件上传处理 这块比较复杂，需要结合flash控件上传 
         * 
         * @type Array
         */
        fOperate: [
            "student/delattach", //[0]
            "student/downattach", //[1] 
            "student/stuhwrefresh", //[2] 
            "student/homeworksubmit"        //[3]
        ]

    },
    
    CourseDS: {},

    CourseDB: {
        eleN: {},
        eleC: {
            i:{},
            o:{}
        },
        eleR: {
            
        },
        eleH: {
            o: {},
            x: {},
            i: {}
        },
        
        configure: function (e) {

            StudentAPI.CourseDB.eleN = document.getElementById(e.n);
            StudentAPI.CourseDB.eleH.o = document.getElementById(e.ho);
            StudentAPI.CourseDB.eleH.i = document.getElementById(e.hi);
            StudentAPI.CourseDB.eleH.x = document.getElementById(e.hx);
            StudentAPI.CourseDB.eleC.i = document.getElementById(e.ci);
            StudentAPI.CourseDB.eleC.o = document.getElementById(e.co);

        },
        
        set: function () {

            StudentAPI.CourseDB.structureCoursesNav();
            StudentAPI.CourseDB.structureCourseContent();
            StudentAPI.CourseDB.structureCourseResource();
            StudentAPI.CourseDB.structureCourseHomework();
            
            $('.stage-card').lightbox();

        },
        
        structureCoursesNav: function () {
            var ele = StudentAPI.CourseDB.eleN;
            var _o = StudentAPI.CourseDS;

            for (var i = 0; i < _o.length; i++) {

                if (i === 0) {
                    StudentAPI.CourseDB.structureCourseNav(ele, _o[i], true);
                } else
                    StudentAPI.CourseDB.structureCourseNav(ele, _o[i], false);

            }
        },
        
        structureCourseNav: function(eles, ele, active){
            var li = document.createElement('li');
            var a = document.createElement('a');
            var cid = ele.scid;
            
            a.id = 'cid-' + ele.scid;
            a.innerHTML = ele.course;
            a.className = 'btn btn-flat';
            a.setAttribute('data-toggle', 'tab');
            a.addEventListener('click', function () {
                StudentAPI.CourseDB.structureThisCourse(cid);
            });
            
            if(active === true)
                li.className = 'active';


            li.appendChild(a);
            eles.appendChild(li);  
        },
        
        structureThisCourse:function(cid){
            
            StudentAPI.ThisCourse.set(cid);
            
            StudentAPI.CourseDB.clearThisCourse();
            StudentAPI.CourseDB.structureCourseContent();
            StudentAPI.CourseDB.structureCourseResource();
            StudentAPI.CourseDB.structureCourseHomework();
            
            $('.stage-card').lightbox();
            
        },
        
        clearThisCourse: function(){
            
            StudentAPI.CourseDB.eleC.i.innerHTML = '';
            StudentAPI.CourseDB.eleC.o.innerHTML = '';
            StudentAPI.CourseDB.eleH.i.innerHTML = '';
            StudentAPI.CourseDB.eleH.o.innerHTML = '';
            StudentAPI.CourseDB.eleH.x.innerHTML = '';
            StudentAPI.CourseDB.eleR.innerHTML = '';
        },
        
        structureCourseContent: function () {

            var eleCi = StudentAPI.CourseDB.eleC.i;
            var eleCo = StudentAPI.CourseDB.eleC.o;
            var _o = StudentAPI.ThisCourse;

            var p1 = document.createElement('p');
            p1.innerHTML = _o.cobj.introduction;
            var p2 = document.createElement('p');
            p2.innerHTML = _o.cobj.outline;
            
            // 课程大纲 附件只有一个！
            var att = document.createElement('div');
            setStyle(att, {
                position: 'absolute',
                right: '0px',
                top: '-86px'
            });
            //att.className = 'bs-breadcrumb';
            if(_o.cobj.attachment === ''){
                var span = document.createElement('span');
                span.innerHTML = '暂无附件';
                span.className = 'btn btn-flat text-grey';
                att.appendChild(span);
            }else {
                var a = document.createElement('a');
                a.href = '/lms' + _o.cobj.attachment;
                a.innerHTML = '课程大纲附件, 点击预览';
                a.className  = 'btn btn-flat text-grey stage-card';
                //a.setAttribute('target', '_blank');
                att.appendChild(a);
            }
            p2.appendChild(att);
            p2.style.position = 'relative';
            
            

            eleCi.appendChild(p1);
            eleCo.appendChild(p2);

        },
        
        structureCourseResource: function () {
            StudentAPI.FileManage.structureCresourceBrowser();
        },
        
        structureCourseHomework: function () {

            StudentAPI.CourseDB.setDoneH();
            StudentAPI.CourseDB.setDoingH();
            StudentAPI.CourseDB.setMissH();

        },
        
        setDoneH: function () {
            var ele = StudentAPI.CourseDB.eleH.o; ele.innerHTML = '';
            var _o = StudentAPI.ThisCourse.cobj.homework.o;

            if (_o.length === 0) {
                ele.innerHTML = '<p>暂无已提交作业<p>';
                return;
            }

            for (var i = 0; i < _o.length; i++) {

                ele.appendChild(StudentAPI.CourseDB.getDoneH(_o[i]));
            }
        },
        getDoneH: function(o){
            //DOM 元素
                var card = document.createElement('div');

                var cardMain = document.createElement('div');
                var cardHead = document.createElement('div');
                var cardBtn = document.createElement('div');
                var cardBtnEdit = document.createElement('a');
                var icon = document.createElement('span');

                var cardInner = document.createElement('div');
                var title = document.createElement('span');
                var deadline = document.createElement('span');

                //CSS
                card.className = 'card';
                cardMain.className = 'card-main';
                cardHead.className = 'card-action divider-b';
                cardBtn.className = 'card-action-btn btn btn-flat pull-left homework-name';
                cardBtnEdit.className = 'btn-edit btn btn-flat pull-right';
                icon.className = 'icon avatar avatar-sm';
                cardInner.className = 'card-inner';
                title.className = 'btn btn-flat text-blod text-indianred';
                deadline.className = 'homework-info';

                //数据|函数 绑定
                cardBtn.innerHTML = o.title;
                cardBtnEdit.title = '编辑';
                cardBtnEdit.addEventListener('click', function () {
                    editThisHomework(o.homeworkid, true);
                });
                icon.innerHTML = 'edit';
                title.innerHTML = '截止日期';
                deadline.innerHTML = o.deadline;

                //DOM 构造
                cardInner.appendChild(title);
                cardInner.appendChild(deadline);

                cardBtnEdit.appendChild(icon);
                cardHead.appendChild(cardBtnEdit);
                cardHead.appendChild(cardBtn);

                cardMain.appendChild(cardHead);
                cardMain.appendChild(cardInner);

                card.appendChild(cardMain);

                return card;
        },
        
        setDoingH: function () {

            var ele = StudentAPI.CourseDB.eleH.i; ele.innerHTML = '';
            var _o = StudentAPI.ThisCourse.cobj.homework.i;

            if (_o.length === 0) {
                ele.innerHTML = '<p>暂无需提交作业<p>';
                return;
            }

            for (var i = 0; i < _o.length; i++) {
                ele.appendChild(StudentAPI.CourseDB.getDoingH(_o[i]));
            }
        },
        getDoingH: function(o){
            
            //DOM 元素
            var card = document.createElement('div');

            var cardMain = document.createElement('div');
            var cardHead = document.createElement('div');
            var cardBtn = document.createElement('div');
            var cardBtnEdit = document.createElement('a');
            var icon = document.createElement('span');

            var cardInner = document.createElement('div');
            var title = document.createElement('span');
            var deadline = document.createElement('span');

            //CSS
            card.className = 'card';
            cardMain.className = 'card-main';
            cardHead.className = 'card-action divider-b';
            cardBtn.className = 'card-action-btn btn btn-flat pull-left homework-name';
            cardBtnEdit.className = 'btn-edit btn btn-flat pull-right';
            icon.className = 'icon avatar avatar-sm';
            cardInner.className = 'card-inner';
            title.className = 'btn btn-flat text-blod text-indianred';
            deadline.className = 'homework-info';

            //数据|函数 绑定
            cardBtn.innerHTML = o.title;
            cardBtnEdit.title = '编辑';
            cardBtnEdit.addEventListener('click', function () {
                editThisHomework(o.homeworkid, false);
            });
            cardBtnEdit.setAttribute('data-hid',o.homeworkid);
            icon.innerHTML = 'edit';
            title.innerHTML = '截止日期';
            deadline.innerHTML = o.deadline;

            //DOM 构造
            cardInner.appendChild(title);
            cardInner.appendChild(deadline);

            cardBtnEdit.appendChild(icon);
            cardHead.appendChild(cardBtnEdit);
            cardHead.appendChild(cardBtn);

            cardMain.appendChild(cardHead);
            cardMain.appendChild(cardInner);

            card.appendChild(cardMain);

            return card;
        },
        
        setMissH: function () {
            var ele = StudentAPI.CourseDB.eleH.x; ele.innerHTML = '';
            var _o = StudentAPI.ThisCourse.cobj.homework.x;

            if (_o.length === 0) {
                ele.innerHTML = '<p>暂无历史作业<p>';
                return;
            }

            for (var i = 0; i < _o.length; i++){
                ele.appendChild(StudentAPI.CourseDB.getMissH(_o[i]));
            }
        },
        getMissH: function(o){

            //DOM 元素
            var card = document.createElement('div');

            var cardMain = document.createElement('div');
            var cardHead = document.createElement('div');
            var cardBtn = document.createElement('div');
            var cardBtnEdit = document.createElement('a');
            var icon = document.createElement('span');

            var cardInner = document.createElement('div');

            //CSS
            card.className = 'card';
            cardMain.className = 'card-main';
            cardHead.className = 'card-action divider-b';
            cardBtn.className = 'card-action-btn btn btn-flat pull-left homework-name';
            cardBtnEdit.className = 'btn-looks collapse btn btn-flat pull-right';
            icon.className = 'icon avatar avatar-sm';
            cardInner.className = 'collapsible-region collapse';

            //数据|函数 绑定
            cardBtn.innerHTML = o.title;
            cardBtnEdit.title = '显示';
            cardBtnEdit.setAttribute('data-toggle', 'collapse');
            cardBtnEdit.setAttribute('href', '#collapse-history-' + o.homeworkid);
            cardBtnEdit.addEventListener('click', function () {
                previewThisHomework(o.homeworkid);
            });
            icon.innerHTML = 'remove_red_eye';
            cardInner.id = 'collapse-history-' + o.homeworkid;

            //DOM 构造
            cardBtnEdit.appendChild(icon);
            cardHead.appendChild(cardBtn);
            cardHead.appendChild(cardBtnEdit);

            cardMain.appendChild(cardHead);
            cardMain.appendChild(cardInner);

            card.appendChild(cardMain);

            return card;
        }
    },
    
    /**
     * 全局变量 (且唯一) 聚焦 当前已选课程的一个实例
     * @type Array
     */
    ThisCourse: {
        cid: 0,
        
        cobj: {
            courseName: '',
            teacherName: '',
            teacherSn: '',
            introduction: '',
            outline: '',
            attachment: '',
            resource: {
                dir: '',
                om: {},
                ds: {}
            },
            homework: {}
        },
        
        set: function (cid) {
            
            StudentAPI.ThisCourse.cid = cid;
            StudentAPI.ThisCourse.setCreourceDir();
            StudentAPI.ThisCourse.structureCidIsCourse();
            
        },
        
        structureCidIsCourse: function () {
            StudentAPI.ThisCourse.setCinfo();
            StudentAPI.ThisCourse.setCreource();
            StudentAPI.ThisCourse.setHomework();
        },
        
        setCinfo: function () {
            var _o = StudentAPI.ThisCourse.cobj;
            var cid = StudentAPI.ThisCourse.cid;
            var status = 0;

            $.ajax({
                url: StudentAPI.Path.cInfo[0] + "?scid=" + cid,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _o.courseName = data[0].courseName;
                    _o.teacherName = data[1].teacherName;
                    _o.teacherSn = data[2].teacherSn;
                    _o.introduction = data[4].introduction === null ? '暂无介绍' : data[4].introduction;
                    _o.outline = data[3].syllabus === null ? '暂无介绍' : data[3].syllabus;
                    _o.attachment = data[5].swf_syllabus;
                },
                error: function () {
                    status = -1;
                }
            });

            return status;
        },

        setCreource: function () {
            StudentAPI.ThisCourse.setCreourceOD();
            StudentAPI.ThisCourse.setCreourceDS();
        },

        setCreourceOD: function () {
            var _o = StudentAPI.ThisCourse.cobj;
            var cid = StudentAPI.ThisCourse.cid;
            var status = 0;


            $.ajax({
                url: StudentAPI.Path.cInfo[1] + "?scid=" + cid,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _o.resource.om = data;
                    //console.log(data);
                },
                error: function () {
                    _o.resource.om = [];
                    status = -1;
                }
            });

            return status;
        },
        
        setCreourceDS: function () {
            StudentAPI.FileManage.setDS();
        },
        
        setCreourceDir: function () {
            var _o = StudentAPI.ThisCourse.cobj;
            var cid = StudentAPI.ThisCourse.cid;
            var status = 0;

            $.ajax({
                url: StudentAPI.Path.cInfo[4] + "?scid=" + cid,
                type: 'get',
                async: false,
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    _o.resource.dir = data.dir;
                    console.log(data);
                },
                error: function () {
                    status = -1;
                }
            });

            return status;
        },

        getPlayPath: function (pos, name) {
        var folder = '';
                for (var i = 1; i < pos.length; i++) {
        folder += '/' + pos[i];
        }

        return 'http://localhost:8084/lms/getvideo?uri=' + "file/" + StudentAPI.ThisCourse.cobj.resource.dir + folder + '/' + name;
        },
        
        getPreviewPath: function (pos, name) {
        var folder = '';
                for (var i = 1; i < pos.length; i++) {
        folder += '/' + pos[i];
        }

        return 'http://localhost:8084/lms/getswf?uri=' + "file/" + StudentAPI.ThisCourse.cobj.resource.dir + folder + '/' + name;
        },
        
        getDownloadPath: function (pos, name) {

        var folder = '';
                for (var i = 1; i < pos.length; i++) {
        folder += '/' + pos[i];
        }

        return "file/" + StudentAPI.ThisCourse.cobj.resource.dir + folder + '/' + name;
        },
        
        setHomework: function (hid, path) {
            
            var _o = StudentAPI.ThisCourse.cobj;
            var cid = StudentAPI.ThisCourse.cid;
            var status = 0;

            $.ajax({
                url: StudentAPI.Path.cInfo[2] + "?scid=" + cid,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _o.homework = StudentAPI.ThisCourse.getFormattedHomework(data);
                    status = data.status;
                    console.log(status);
                },
                error: function () {
                    status = -1;
                }
            });
        },
        
        getFormattedHomework: function (data) {
            var _o = [];
            var _i = [];
            var _x = [];
            var _deadline = false;
            var x = 0,
                    y = 0,
                    z = 0;

            for (var i = 0; i < data.length; i++) {
                var xtime = new Date(data[i].deadline);
//                    var detail;
                if ((xtime - new Date()) > 0) {
                    _deadline = true;
                } else {
                    _deadline = false;
                }
                if (data[i].status === "未提交" && _deadline) {
                    _i.push(data[i]);
                    x++;

                } else if (data[i].status === "已提交") {
                    _o.push(data[i]);
                    y++;
                } else {
                    _x.push(data[i]);
                    z++;
                }
            }

            var obj = {
                o: _o,
                i: _i,
                x: _x
            };

            return obj;
        }
    },
    
    ThisHomework: {

        hid: 0,
        
        hobj: {
            title:'',
            detail:'',
            startdata:null,
            deadline:null,
            content:'',
            atts:{
                stu:[],
                tch:[]
            }
        },
        
        editor:{
            configure: function(eid){
                
                // 编辑器 初始化
                tinymce.init({
                    mode : "exact",
                    selector: '#lms-editor',
                    fixed_toolbar_container: 'body',
                    theme: 'inlite',
                    language: 'zh_CN',
                    inline: true,
                    plugins: [
                        'advlist autolink autosave code link image lists charmap codesample hr anchor',
                        'searchreplace visualchars insertdatetime media nonbreaking fullscreen',
                        'table contextmenu directionality emoticons template paste preview textcolor textpattern visualblocks'
                    ],
                    insert_toolbar: 'h1 h2 h3 hr bullist numlist outdent indent  blockquote quickimage codesample insertdatetime template | removeformat',
                    selection_toolbar: 'bold italic underline subscript superscript textcolor forecolor backcolor strikethrough | alignleft aligncenter alignright alignjustify  outdent indent | link h1 h2 h3 blockquote codesample media | removeformat | ',
                    contextmenu: 'image media codesample | charmap | link anchor | inserttable | cell row column deletetable | visualblocks preview',
                    insertdatetime_formats: ["%H:%M:%S %Y-%m-%d", "%H:%M:%S", "%Y-%m-%d", "%I:%M:%S %p", "%D"],
                    templates: [
                        {title: 'Some title 1', description: 'Some desc 1', content: 'My content'},
                        {title: 'Some title 2', description: 'Some desc 2', url: 'development.html'}
                    ],
                    textpattern_patterns: [
                        {start: '*', end: '*', format: 'italic'},
                        {start: '**', end: '**', format: 'bold'},
                        {start: '#', format: 'h1'},
                        {start: '##', format: 'h2'},
                        {start: '###', format: 'h3'},
                        {start: '####', format: 'h4'},
                        {start: '#####', format: 'h5'},
                        {start: '######', format: 'h6'},
                        {start: '>_ ', format: 'blockquote'},
                        {start: '1. ', cmd: 'InsertOrderedList'},
                        {start: '* ', cmd: 'InsertUnorderedList'},
                        {start: '- ', cmd: 'InsertUnorderedList'}
                    ],
                    media_live_embeds: true,
                    init_instance_callback: function (editor) {
                        editor.on('Change', function (e) {
                            cntIsChange = true;
                            hidIsSubmit = false;
                            console.log('Editor contents was changed.');
                            console.log("有未提交内容 !");
                        });
                    }

                });
            },
            getContent: function(){
                return tinymce.get('lms-editor').getContent({
                    format: 'raw'
                });
            }
        },
        
        uploadify:{
          configure: function (){} 
        },
        
        /**
         * 数据结构:
         * <br> Myattachment    我的附件 myATT
         * <br> HwtextWork      我的作业 content
         * <br> Hwtitle         作业标题 title
         * <br> Hwhelp          作业详情 detail
         * <br> Hwattachment    作业附件 ATT
         * <br> Hwtime          作业起始时间 deadline
         * <br> Hwendtime       作业截止时间 
         * @param {Number} hid
         * @param {Number} cid
         * @returns {StudentAPI.analyzeDS.Homework.getJSON.obj}
         */
        getHidDetail: function (hid, cid) {

            if (cid === undefined) {
                cid = StudentAPI.ThisCourse.cid;
            }
            var detail = {
                title:'',
                detail:'',
                startdata:null,
                deadline:null,
                content:'',
                atts:{
                    stu:[],
                    tch:[]
                }
            };
            $.ajax({
                url: StudentAPI.Path.cInfo[5] + '?scid=' + cid + '&homeworkid=' + hid,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    detail.title = data.Hwtitle;
                    detail.detail = data.Hwhelp;
                    detail.startdata = data.Hwtime;
                    detail.deadline = data.Hwendtime;
                    detail.content = data.HwtextWork;
                    detail.atts.stu = data.Myattachment;
                    detail.atts.tch = data.Hwattachment;
                },
                error: function () {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: StudentAPI.OCidIsCourse.courseName + '的课程' +
                                '数据 [ 某一作业详情 ] 传输失败 ！ 可能老师并未编辑' +
                                '<a data-dismiss="snackbar">我知道了</a>'
                    });
                }
            });
            return detail;
        },
        
        downloadAttachment: function (scid, homeworkid, src) {
            $.ajax({
                type: "post",
                url: StudentAPI.Path.fOperate[1] + '?scid=' + scid + '&homeworkid=' + homeworkid + '&src=' + src,
                success: function () {},
                error: function () {
                    alert("出现错误! 作业已过期或文件不存在");
                }
            });
        },
        
        deleteAttachment: function (scid, homeworkid, src) {
            $.ajax({
                type: "GET",
                url: StudentAPI.Path.fOperate[0] + '?scid=' + scid + '&homeworkid=' + homeworkid + '&src=' + src,
                success: function (data) {

                    if (data === "ok") {
                        $('#snackbar').snackbar({
                            alive: 10000,
                            content: '作业附件删除成功 <a data-dismiss="snackbar">我知道了</a>'
                        });
                    } else {
                        alert("作业附件删除失败！ 可能原因：作业已过期或文件不存在");
                    }

                },
                error: function () {
                    alert("未知错误");
                }
            });
        },
        
        uploadAttachment: function (scid, homeworkid) {
            $('#uploadify').uploadify("settings", "formData", {
                'scid': scid,
                'homeworkid': homeworkid
            });
            $('#uploadify').uploadify('upload', '*');
        },
        
        getAttachmentList: function (scid, homeworkid) {
            $.ajax({
                url: StudentAPI.Path.fOperate[2] + '?scid=' + scid + '&homeworkid=' + homeworkid,
                type: 'GET',
                cache: false,
                async: false,
                success: function (data) {
                    StudentAPI.ThisHomework.hobj.atts.stu = data;
                },
                error: function () {
                    alert("未知错误");
                }
            });
            return true;
        },
        
        submit: function (scid, homeworkid, hs) {
            var status = 0;
            $.ajax({
                url: StudentAPI.Path.fOperate[3] + '?scid=' + scid + '&homeworkid=' + homeworkid,
                type: 'post',
                data: {
                    HwEitor: hs
                },
                cache: false,
                success: function (data) {
                    if (data === "1") {
                        $('#snackbar').snackbar({
                            alive: 10000,
                            content: '作业提交成功 <a data-dismiss="snackbar">我知道了</a>'
                        });
                        status = data;
                    } else {
                        alert("作业提交失败！ 可能原因：作业已不存在");
                        status = data;
                    }

                },
                error: function () {
                    status = -1;
                    alert("未知错误");
                }
            });
            console.log(status);
            return status;
        }
    },
    
    DemonCourse: {
        courseName: '',
        teacherName: '',
        teacherSn: '',
        introduction: '[请至少选着一门课程]',
        outline: '[请至少选着一门课程]',
        attachment: '',
        resource: {
            dir:'',
            om:[],
            ds:[]
        },
        homework: {
            o:[],
            x:[],
            i:[]
        }
    },

    /** 
        调用 学生信息json路径
        初始化学生的[id,sn,name,ID,pw,sex,grade,college,tel,qq]的信息

        @param {optional String } path - 学生信息json路径
    
    */
    initPersonalInfo: function(path) {
        if (path === undefined ? true : false) {
            path = StudentAPI.Path.uInfo[0];
        };
        $.ajax({
            url: path,
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                StudentAPI.id = data.studentId;
                StudentAPI.sn = data.studentSn;
                StudentAPI.name = data.studentName;
                StudentAPI.ID = data.studentIdcard;
                StudentAPI.grade = data.studentGrade;
                StudentAPI.college = data.studentCollege;
                StudentAPI.tel = data.studentTel;
                StudentAPI.qq = data.studentQq;
                StudentAPI.pw = data.studentPwd;
                StudentAPI.sex = data.studentSex;
                StudentAPI.avatar = data.studentImg;
            },
            error: function() {
                alert("数据传输失败 ！");
            }
        });
        $.ajax({
            url: 'reg/fhnj',
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                var _hs = '';
                StudentAPI.schoolYearsDS = data;

                for (var i = 0; i < data.length; i++) {

                    _hs += '<option value="' + data[i] + '"> ' + data[i] + ' </option>';
                }
                StudentAPI.schoolYearsListHS = _hs;
            },
            error: function() {
                $('#snackbar').snackbar({
                    alive: 10000,
                    content: '数据 [学年] 传输失败 ！ <a data-dismiss="snackbar">我知道了</a>'
                });
            }
        });
        $.ajax({
            url: 'reg/hq_xy',
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                var _hs = '';
                StudentAPI.schoolCollegeDS = data;

                for (var i = 0; i < data.length; i++) {
                    _hs += '<option value="' + data[i] + '"> ' + data[i] + ' </option>';
                }
                StudentAPI.schoolCollegeListHS = _hs;
            },
            error: function() {
                $('#snackbar').snackbar({
                    alive: 10000,
                    content: '数据 [学院] 传输失败 ！ <a data-dismiss="snackbar">我知道了</a>'
                });
            }
        });
    },

    /** 
        解析 包含 更新学生信息的json路径?name=&ID=&sex=&grade=&college=&tel=&qq=  
        更新学生的[name,ID,sex,grade,college,tel,qq]的信息

        @param { String } path - 包含更新过的学生信息参数的json路径
     
     */
    updatePersonalInfo: function(path) {
        if (path === undefined ? true : false) {
            path = StudentAPI.Path.uInfo[1];
        }
        ;
        $.ajax({
            url: path,
            type: 'post',
            async: false,
            dataType: 'json',
            success: function(data) {
                if (data === 0) {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '个人信息修改失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
                    });
                } else {
                    updateUPanel(0);
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '个人信息已修改...' + '<a data-dismiss="snackbar">我知道了</a>'
                    });
                }
            },
            error: function() {
                alert("个人信息更新失败 ！");
            }
        });
    },

    /** 
        解析 包含 更新学生密码的json路径?pw=&repw=
        更新学生的[password]的信息

        @param { String } path - 包含旧的以及更新过的学生密码参数的json路径
        @return { Number } 1 - 原密码不正确; 2 - 和原密码相同; 3 - 更新成功
     
     */
    updatePassword: function(path) {
        $.ajax({
            url: path,
            type: 'post',
            async: false,
            dataType: 'json',
            success: function(data) {
                if (data === 3) {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '密码修改成功, 需跳转至登陆界面... <a data-dismiss="snackbar" href="logout">立即跳转</a>'
                    });
                    setTimeout(logout,1500);
                } else if (data === 1) {
                    alert("原密码不正确！");
                    $("#validMsg-opw").fadeIn();
                } else {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '密码并未更新 原因:新密码与旧密码相同 <a data-dismiss="snackbar">我知道了</a>'
                    });
                }
            },
            error: function() {
                alert("数据传输失败 ！");
            }
        });
    },

    /** 
        调用 学生课程信息的JSON路径数组
        <br>返回 符合规范数据结构的JSON对象
        <br>初始化 学生课程的
        [selectedCourseDS,selectableCourseDS,selectingCourseDS,unratifiedCourseDS]的树的数据结构信息
        
        @param {optional String Array} path - 包含JSON路径的数组
        <br>path[0]  已选课程的
        <br>path[1]  可选课程的
        <br>path[2]  待批准课程的
        <br>path[3]  未批准课程的
    
     
     */
    initPersnalCourseInfo: function(path) {
        
        if (path === undefined ? true : false) {
            path = StudentAPI.Path.uInfo[3];

        };

        //初始化 已选课程列的表树
        console.log("init 已选课程列的表树 info...");
        $.ajax({
            url: path,
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                StudentAPI.CourseDS = data;
            },
            error: function() {
                alert("数据[已选课程列的表树]传输失败 ！");
            }
        });

        console.log("init has done ! ");
    },
    
    FileManage:{
        configure:function(e){
            StudentAPI.FileManage.setDS = e.setCresourceDS;
            StudentAPI.FileManage.structureCresourceBrowser = e.structureCresourceBrowser;
        },
        
        setDS: function(){},
        
        getOM: function(){
            return StudentAPI.ThisCourse.cobj.resource.om;
        },
        
        structureCresourceBrowser:function(){}
    },
    
    configure: function(e){
        StudentAPI.CourseDB.configure(e);
        StudentAPI.FileManage.configure(e);
    }

};

//定义全局变量
var isCourseInited = false;
var isEditorInited = false;

/**
 * 对个人面板的信息进行绑定
 * <br><b>选择器:</b>
 * <br>ID:ubox
 * <br><b>对象属性:</b>
 * <br>sn, name, portrait, grade, college, qq
 * <br>
 * @type Vue
 */
var UPanel;

/**
 * 
 * @type Vue
 */
var UProfile;

var ThisCourse = StudentAPI.ThisCourse;
var ThisHomework = StudentAPI.ThisHomework;

var HidIsAttachmentHS = '';

//定义初始化函数
function init() {

    //初始化 个人信息
    StudentAPI.initPersonalInfo();
    
    if (StudentAPI.sex === true) $('#boy').attr("checked", "checked");
    else $('#girl').attr("checked", "checked");
    
    UPanel = new Vue({
        el: "#upanel",
        data: {
            sn: StudentAPI.sn,
            name: StudentAPI.name,
            portrait: StudentAPI.name.toString()[0],
            grade: StudentAPI.grade,
            college: StudentAPI.college,
            qq: StudentAPI.qq
        }
    });
    
    UInfo = new Vue({
        el: '#uinfo',
        data: {
            id: StudentAPI.id,
            sn: StudentAPI.sn,
            name: StudentAPI.name,
            ID: StudentAPI.ID,
            grade: StudentAPI.grade,
            schoolYearsList: StudentAPI.schoolYearsListHS,
            college: StudentAPI.college,
            schoolCollegeList: StudentAPI.schoolCollegeListHS,
            tel: StudentAPI.tel,
            qq: StudentAPI.qq,
            pw: StudentAPI.pw,
            sex: StudentAPI.sex
        }
    });
    
};

function initCourse(){
    
    if(isCourseInited === false){
        //初始化 课程信息
        StudentAPI.initPersnalCourseInfo();
        isCourseInited = true;

        if (StudentAPI.CourseDS[0] !== undefined) {
            StudentAPI.ThisCourse.set(StudentAPI.CourseDS[0].scid);
            StudentAPI.CourseDB.set();
            $('#anchor-mcourse').click();
        } else {
            //ThisCourse.cobj = StudentAPI.DemonCourse;
            if (confirm("暂无已选课程！是否前往选课中心进行选课？")){
                window.location.href = 'student/courses';
            }
        }

    }else{
        $('#anchor-mcourse').click();
    }
}

//定义相关操作函数(包装函数)

function updatePersonalInfo() {
    
    if (!CheckPersonalInfo()) {
        return false;
    }
    
    var name = $('#name').val();
    var ID = $('#ID').val();
    var grade = $('#grade').val();
    var college = $('#college').val();
    var sex = $('#boy').is(":checked") ? '男' : '女';
    var tel = $('#tel').val();
    var qq = $('#qq').val();
    StudentAPI.updatePersonalInfo(StudentAPI.Path.uInfo[1] +
        "?name=" + name +
        "&idcard=" + ID +
        "&grade=" + grade +
        "&college=" + college +
        "&sex=" + sex +
        "&telnum=" + tel +
        "&qqnum=" + qq)
    ;
    return true;
};

function checkPassword(){
    var status = true;
    if ($("#oldPassword").val() === '') {
        console.log($("#oldPassword").val());
        $("#validMsg-opw").html("请输入原始密码！");
        $("#validMsg-opw").fadeIn();
        status = false;
    } else
        $("#validMsg-opw").fadeOut();

    if ($("#newPasswordConfirm").val() !== $("#newPassword").val()) {
        $("#validMsg-npwconfirm").html("两次输入的密码不一致！");
        $("#newPasswordConfirm").val("");
        $("#validMsg-npwconfirm").fadeIn();
        status = false;
    } else
        $("#validMsg-npwconfirm").fadeOut();


    var r = /^[a-z A-Z 0-9 _]{6,18}$/;
    var flag = r.test($("#newPassword").val());
    if (!flag && ($("#oldPassword").val() !== '')) {
        $("#validMsg-npw").html("新密码不符合要求（6到18位），是不是太简单了?");
        $("#validMsg-npw").fadeIn();
        status = false;
    } else
        $("#validMsg-npw").fadeOut();

    if (status === false)
        return false;
    else {
        $("#validMsg-opw").fadeOut();
        $("#validMsg-npw").fadeOut();
        $("#validMsg-npwconfirm").fadeOut();
    }
    return true;
};

function updatePassword() {
    
    if(checkPassword()){
        StudentAPI.updatePassword(StudentAPI.Path.uInfo[2] +
            "?pw=" + hex_md5($("#oldPassword").val()) +
            "&repw=" + hex_md5($("#newPassword").val()));
    }
};

function CheckPersonalInfo() {
    var status = true;
//    if () {
//        alert("Unknow Error !");
//        status = false;
//    }

    //若值为空 复位
    if ($.trim($("#name").val()) === "") {
        $('#name').val(UProfile.$data.name);
    }
    if ($.trim($("#ID").val()) === "") {
        $('#ID').val(UProfile.$data.ID);
    }
    if ($.trim($("#tel").val()) === "") {
        $('#tel').val(UProfile.$data.tel);
    }
    if ($.trim($("#qq").val()) === "") {
        $('#qq').val(UProfile.$data.qq);
    }
    
    //合法性检验 并提示
    var r = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/g;
    var flag = r.test($.trim($("#ID").val()));
    if (!flag) {
        $("#validMsg-ID").fadeIn();
        status = false;
    }else $("#validMsg-ID").fadeOut();
    
    r = /^1\d{10}$/g;
    flag = r.test($.trim($("#tel").val()));
    if (!flag) {
        $("#validMsg-tel").fadeIn();
        status = false;
    }else $("#validMsg-tel").fadeOut();
    
    r = /^[0-9]{6,10}$/;
    flag = r.test($.trim($("#qq").val()));
    if (!flag) {
        $("#validMsg-qq").fadeIn();
        status = false;
    }else $("#validMsg-qq").fadeOut();
    
    return status;
};

function updateUPanel() {
    StudentAPI.initPersonalInfo();
    UPanel.$data.sn = StudentAPI.sn;
    UPanel.$data.name = StudentAPI.name;
    UPanel.$data.portrait = StudentAPI.name.toString()[0];
    UPanel.$data.grade = StudentAPI.grade;
    UPanel.$data.college = StudentAPI.college;
    UPanel.$data.qq = StudentAPI.qq;
};

function updateResource() {
    StudentAPI.ThisCourse.setCreource();

    StudentAPI.FileManage.setDS();
    StudentAPI.FileManage.structureCresourceBrowser();
};

function updateHid(hid) {
    ThisHomework.hid = hid;
};

function editThisHomework(hid, status) {
    NProgress.start();
    
    if ((hid !== ThisHomework.hid) || (status)) {
        ThisHomework.hid = hid;
        ThisHomework.hobj = ThisHomework.getHidDetail(hid);
        updateHomeworkContent(hid);
    }
    NProgress.set(0.3);
    
    if(isEditorInited === false){
        ThisHomework.editor.configure('lms-editor');
        ThisHomework.uploadify.configure();
        isEditorInited = true;
        window.onbeforeunload = null;
    }
    NProgress.set(0.8);
    
    $('#uploaded-area').hide();
    
    if (StudentAPI.ThisHomework.getAttachmentList(ThisCourse.cid, ThisHomework.hid)) {
        var _slist = StudentAPI.ThisHomework.hobj.atts.stu;
        var _tlist = StudentAPI.ThisHomework.hobj.atts.tch;
        var _src;
        HidIsAttachmentHS = '<table class="table table-bordered"><thead><tr><th>附件名</th><th>下载</th><th>删除</th></tr></thead>';
        
        if(_tlist.length !== 0){
            for (var i = 0; i < _tlist.length; i++) {
                _src = _tlist[i];
                HidIsAttachmentHS += '<tbody><tr><td><span class="text-indianred att-tch">' + '教师附件' + '</span></td>' +
                        '<td><a class="btn-brand btn-flat" target="_blank" href="/lms/'+ _src + '" class="">下载</a></td>' +
                        '<td></td></tr></tbody>';
            }
        } else {
            HidIsAttachmentHS += '<tbody><tr><td><span class="text-indianred att-tch">' + '教师附件' + '</span></td>' +
                    '<td>暂无</td>' +
                    '<td></td></tr></tbody>';
        }        
        for (var i = 0; i < _slist.length; i++) {
            _src = _slist[i];
            HidIsAttachmentHS += '<tbody><tr><td><span class="text-indianred">' + _src + '</span></td>' +
                '<td><a class="btn-brand btn-flat" target="_blank" href="' + StudentAPI.Path.fOperate[1] + '?scid=' + ThisCourse.cid + '&homeworkid=' + ThisHomework.hid + '&src=' + _src + '" class="">下载</a></td>' +
                '<td><a class="btn-default btn-flat" onclick="deleteAttachment(\'' + _src + '\')" class="">删除</a></td></tr></tbody>';
        }
        
        HidIsAttachmentHS += '</table>';
        console.log(_tlist);
        $('#uploaded-area').empty();
        $('#uploaded-area').append(HidIsAttachmentHS);
        $('#uploaded-area').fadeIn();
    };
    NProgress.set(0.9);

    $('#anchor-heditor').click();
    NProgress.done();
};

function previewThisHomework(hid){
    var detail = StudentAPI.ThisHomework.getHidDetail(hid);
    console.log(detail);
    var domId = '#collapse-history-' + hid;
    var hs = '';

    //构造作业内容和作业详情
    hs += '<title class="btn btn-flat text-blod text-indianred">作业要求</title><p class="homework-info">' + detail.title + '</p><title class="btn btn-flat text-blod text-indianred">附件列表</title><p class="homework-attachment"></p>' +
            '<title class="btn btn-flat text-blod text-indianred">我的作业</title><p class="homework-content"></p><div id="content-' + hid + '" class="content-area">' + detail.content + '</div>';
    ;

    //构造附件表格
    var _src;
    var _list = detail.atts.stu;
    hs += '<div class="table-wrap"><table class="table table-bordered"><thead><tr><th>附件名</th><th>下载</th></tr></thead>';
    for (var i = 0; i < _list.length; i++) {
        _src = _list[i];
        hs += '<tbody><tr><td><span class="text-indianred">' + _src + '</span></td>' +
                '<td><a class="btn-brand btn-flat" target="_blank" href="' + StudentAPI.Path.fOperate[1] + '?scid=' + ThisCourse[0].scid + '&homeworkid=' + ThisCourse[0].hid + '&src=' + _src + '" class="">下载</a></td>' +
                '</tr></tbody>';
    }
    hs += '</table></div>';
    hs = '<div class="history-wrap">' + hs + '</div>';
    console.log(_list);
    $(domId).empty();
    $(domId).append(hs);
    $(domId).fadeIn();
}

function updateHomeworkList(){
    StudentAPI.ThisCourse.setHomework();
    StudentAPI.CourseDB.structureCourseHomework();
    console.log("reflesh homework list done !");
    
};

function updateHomeworkContent(hid){
    updateHid(hid);
    updateUploadedContent();
    
    ThisCourse.hobj = ThisHomework.getHidDetail(hid);
    
    $('#homework-info').empty();
    $('#homework-info').html(ThisHomework.hobj.detail);
    console.log("course info is :" + ThisHomework.hobj.detail);
    
    $('#lms-editor').empty();
    $('#lms-editor').html(ThisHomework.hobj.content);
    console.log("my homework's content  is :" + ThisHomework.hobj.content);
    
};

function updateUploadedContent() {
    $('#uploaded-area').hide();
    if (StudentAPI.ThisHomework.getAttachmentList(ThisCourse.cid, ThisHomework.hid)) {
        var _list = StudentAPI.ThisHomework.hobj.atts.stu;
        var _src;
        HidIsAttachmentHS = '<table class="table"><thead><tr><td>附件名</td><td>下载</td><td>删除</td></tr><thead>';
        for (var i = 0; i < _list.length; i++) {
            _src = _list[i];
            HidIsAttachmentHS += '<tbody><tr><td><span class="text-indianred">' + _src + '</span></td>' +
                '<td><a href="' + StudentAPI.Path.fOperate[1] + '?scid=' + ThisCourse.cid + '&homeworkid=' + ThisHomework.hid + '&src=' + _src + '" class="">下载</a></td>' +
                '<td><a onclick="deleteAttachment(\'' + _src + '\')" class="">删除</a></td></tr><tbody>';
        }
        HidIsAttachmentHS += '</table>';
        console.log(_list);
        $('#uploaded-area').empty();
        $('#uploaded-area').append(HidIsAttachmentHS);
        $('#uploaded-area').fadeIn();
    }
};

function uploadAttachment() {
    StudentAPI.ThisHomework.uploadAttachment(ThisCourse.cid, ThisHomework.hid);
    $('#uploaded-area').hide();
    updateUploadedContent();
    console.log("upload attachment ..." + ThisHomework.hid);
};

function downloadAttachment(src) {
    StudentAPI.ThisHomework.downloadAttachment(ThisCourse.cid, ThisHomework.hid, src);
};

function deleteAttachment(src) {
    StudentAPI.ThisHomework.deleteAttachment(ThisCourse.cid, ThisHomework.hid, src);
    $('#uploaded-area').hide();
    updateUploadedContent();
    console.log("delete attachment ..." + ThisHomework.hid);
};

function submitHomework(hid) {
    hs = StudentAPI.ThisHomework.editor.getContent();
    console.log("submit homework ...");
    
    var status = StudentAPI.ThisHomework.submit(ThisCourse.cid, hid, hs);
    
    if (status === 1 || status === 0) {
        
        $('[href="#tab-homework"]').click();
        setTimeout(updateHomeworkList, 800);
        return true;
        
    }else return false;
};

//其它函数
//保留两位小数
//功能：将浮点数四舍五入，取小数点后2位
function toDecimal(x) {
    var f = parseFloat(x);
    if (isNaN(f)) {
        return;
    }
    f = Math.round(x * 100) / 100;
    return f;
};

//强制保留2位小数，如：2，会在2后面补上00.即2.00
function toDecimal2(x) {
    var f = parseFloat(x);
    if (isNaN(f)) {
        return false;
    }
    var f = Math.round(x * 100) / 100;
    var s = f.toString();
    var rs = s.indexOf('.');
    if (rs < 0) {
        rs = s.length;
        s += '.';
    }
    while (s.length <= rs + 2) {
        s += '0';
    }
    return s;
};

function fomatFloat(src, pos) {
    return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);
};

function getIdByDomId(prefix, domId) {
    return domId.replace(prefix, '');
};

function getFileManagePath() {
    var Path = StudentAPI.Path;
    return Path;
};

function setStyle(ele, style){
    
    for (var i in style){
        ele.style[i] = style[i];
    }
}

function logout() {
    window.location.href = "logout";
};
