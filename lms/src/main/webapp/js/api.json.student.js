/**
 * <br>命名:
 * <br>HS是Html Segment(html片段)的缩写
 * <br>DS是Data Structure(数据结构)的缩写
 * <br>O为已, X为未, OIX分别表示开始中间结尾(生选课表格HS时用到)
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
    numOCourse: 0,
    numXCourse: 0,
    numICourse: 0,
    selectedCourseDS: [],
    selectingCourseDS: [],
    selectableCourseDS: [],
    /**
     * 某门课程的状态值 临时变量
     * @type Boolean
     */
    courseStatus: false,
    schoolYearsDS: [],
    schoolCollegeDS: [],
    schoolYearsListHS: '',
    schoolCollegeListHS: '',
    attachmentListDS: {
        tch:[],
        stu:[]
    },
    DemonCourse: {
        courseName: '',
        teacherName: '',
        teacherSn: '',
        introduction: '[请至少选着一门课程]',
        syllabus: '[请至少选着一门课程]',
        attachment: '',
        resourceDS: {},
        homeworkDS: {}
    },
    /**
     * 长度为二的对象数组 暴露为全局变量 (且唯一) 聚焦 当前的已/未选课程
     * <br>ThisCourse<b>[0]</b>:存储一个<b> 已 </b>选课程的实例
     * <br>ThisCourse<b>[1]</b>:存储一个<b> 待 </b>选课程的实例
     * @type Array
     */
    ThisCourse: [{
            scid: 0, obj: null,
            hid: 0, hobj: null
        },

        {
            scid: 1,
            obj: null
        }
    ],
    /**
     * 当前 聚焦的已选课程
     * @type Object
     */
    OCidIsCourse: {
        courseName: '',
        teacherName: '',
        teacherSn: '',
        introduction: '',
        syllabus: '',
        attachment: '',
        resourceDS: {
            dir: '',
            json: null
        },
        homeworkDS: {}
    },
    /**
     * 当前 聚焦的可选课程
     * @type Object
     */
    XCidIsCourse: {
        courseName: '',
        teacherName: '',
        teacherSn: '',
        introduction: '',
        syllabus: '',
        attachment: ''
    },
    CidIsHomework: {

    },
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

            "/lms/student/getpersoninfo",        //[0] 
            "/lms/student/updatepersoninfo",     //[1]  
            "/lms/student/updatepassword",       //[2]
            "/lms/student/getselectcourse",      //[3] 
            "/lms/student/addnewcourse",         //[4] 
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

            "/lms/student/stu_course",           //[0]  
            "/lms/student/kcgs",                 //[1]  
            "/lms/student/stu_course_homework",  //[2] 
            "/lms/student/courdir",              //[3]
            "/lms/student/resourcedir",          //[4]
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

            "/lms/student/subselectcourse",      //[0] 
            "/lms/student/cancelcourse",         //[1] 
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
        fOperate:[
            "student/delattach",            //[0]
            "student/downattach",           //[1] 
            "student/stuhwrefresh",         //[2] 
            "student/homeworksubmit"        //[3]
        ]

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
                    updataUPanel(0);
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
        console.log("init persnal course info...");
        if (path === undefined ? true : false) {
            path = [
                StudentAPI.Path.uInfo[3],
                StudentAPI.Path.uInfo[4],
                StudentAPI.Path.uInfo[5],
                null
            ];

        };

        //初始化 已选课程列的表树
        console.log("init 已选课程列的表树 info...");
        $.ajax({
            url: path[0],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                StudentAPI.selectedCourseDS = data;
                StudentAPI.numOCourse = data.length;
            },
            error: function() {
                alert("数据[已选课程列的表树]传输失败 ！");
            }
        });

        console.log("init 可选课程的列表树 info...");
        //初始化 可选课程的列表树
        $.ajax({
            url: path[1],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                StudentAPI.selectableCourseDS = data;
            },
            error: function() {
                alert("数据[可选课程的列表树]传输失败 ！");
            }
        });

        //初始化 待批准课程的列表树
        console.log("init 待批准课程的列表树 info...");
        $.ajax({
            url: path[2],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                StudentAPI.selectingCourseDS = data;
                StudentAPI.numICourse = data.length;
            },
            error: function() {
                alert("数据[待批准课程的列表树]传输失败 ！");
            }
        });

        //初始化 未批准课程的列表树
//        console.log("init 未批准课程的列表树 info...");
//        $.ajax({
//            url: path[3],
//            type: 'get',
//            async: false,
//            dataType: 'json',
//            success: function (data) {
//                StudentAPI.unratifiedCourseDS = data;
//            },
//            error: function () {
//                alert("数据传输失败 ！");
//            }
//        });

        console.log("init has done ! ");
    },
    /**
     * 解析相关数据结构
     * @type type
     */
    analyzeDS: {
        selectedCourse: {
            /**
             * 
             * @returns {String}
             */
            getListHS: function() {
                var _o = StudentAPI.selectedCourseDS;
                var ListHS = '';
                for (var i = 0; i < _o.length; i++) {
                    if (i === 0) {
                        ListHS = ListHS +
                            '<li class="active"><a id="cid-' + _o[i].scid + '" herf="#null" data-toggle="tab" class="btn btn-flat " onclick="updataSelectedCourse(' + _o[i].scid + ')">' +
                            _o[i].course + '</a></li>';
                    } else {
                        ListHS = ListHS +
                            '<li><a id="cid-' + _o[i].scid + '" herf="#null" data-toggle="tab" class="btn btn-flat " onclick="updataSelectedCourse(' + _o[i].scid + ')">' +
                            _o[i].course + '</a></li>';
                    }
                }
                return ListHS;
            },
            getTableHS: function() {
                var _head = '<table class="table table-responsive" title="选课表">' +
                    '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 已选</th></tr></thead>',
                    _body = '',
                    _foot = '</table>',
                    _o = StudentAPI.selectedCourseDS;
                if(_o.length === 0){
                    _body = '<tbody><tr><td  class="text-indianred text-blod" colspan="4">暂无已选课程</td></tr></tbody>';
                    return _head + _body + _foot;
                }
                for (var i = 0; i < _o.length; i++) {

                    var hs = '<tbody><tr><td class="text-indianred text-blod">' +
                        (_o[i].course === undefined ? ' ' : _o[i].course) + '</td><td>' +
                        (_o[i].teacher === undefined ? ' ' : _o[i].teacher) + '</td><td>' +
                        (_o[i].ClassName === undefined ? ' ' : _o[i].ClassName) + '</td><td>' +
                        '<a href="javascript: void(0)"' +
                        'id="cancel-' + _o[i].scid + '" ' +
                        'onclick="quitCourse(' + _o[i].scid + ')">退选</a>' +
                        '</td></tr></tbody>';

                    _body += hs;

                }
                return _head + _body + _foot;
            }
        },

        selectableCourse: {
            /**
            * 将一个标准的三级 JSON对象 解析为HTML的表格片段
            * <pre>    
            * JSON 示例 :_o[{
               text: "C", state: {expanded: false},
               nodes: _i[{
                       text: "Long",
                       nodes: _x[{
                           text: "详情",
                           scid: "5"
                       }]
                   }]
               },{...}]
               </pre>
            * @returns {String Object}
            */
            getTableHS: function() {
                var _head = '<table class="table table-responsive" title="选课表">' +
                    '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 可选</th></tr></thead>',
                    _body = '',
                    _foot = '</table>',
                    _o = [],
                    _i = [], //记录 当前课类节点对象
                    _x = [], //记录 当前教师节点对象
                    _numO = 0, //记录 课类数量 
                    _numI = 0, //记录 每个课类下 教师数量 临时变量
                    _numX = 0, //记录 每个教师下 课程数量 临时变量
                    _sum = 0, //记录 所有课程总数
                    TableHS = '';


                _o = StudentAPI.selectableCourseDS;
                if(_o.length === 0){
                    _body = '<tbody><tr><td  class="text-indianred text-blod" colspan="4">暂无可选课程</td></tr></tbody>';
                    return _head + _body + _foot;
                }
                _numO = _o.length;

                for (var i = 0; i < _numO; i++) {
                    _i = _o[i].nodes;
                    _numI = _i.length;

                    var _tmpHS = '';
                    var _tmpSum = 0;

                    for (var j = 0; j < _numI; j++) {
                        _x = _i[j].nodes;
                        _numX = _x.length;
                        _tmpSum += _numX;
                        if (j === 0) {
                            for (var k = 0; k < _numX; k++) {
                                if (k === 0) {
                                    _tmpHS = '<td rowspan="' + _numX + '">' +
                                        _i[j].text + '</td><td>' +
                                        _x[k].text + '</td><td><a onclick="selectCourse(' + _x[k].scid + ')" id="xscid-' + _x[k].scid + '">' +
                                        '选课</a></td></tr>';
                                } else {
                                    _tmpHS = _tmpHS +
                                        '<tr><td>' +
                                        _x[k].text + '</td><td><a onclick="selectCourse(' + _x[k].scid + ')" id="xscid-' + _x[k].scid + '">' +
                                        '选课</a></td></tr>';
                                }
                            }
                        } else {
                            for (var k = 0; k < _numX; k++) {
                                if (k === 0) {
                                    _tmpHS = _tmpHS +
                                        '<tr><td rowspan="' + _numX + '">' +
                                        _i[j].text + '</td><td>' +
                                        _x[k].text + '</td><td><a onclick="selectCourse(' + _x[k].scid + ')" id="xscid-' + _x[k].scid + '">' +
                                        '选课</a></td></tr>';
                                } else {
                                    _tmpHS = _tmpHS +
                                        '<tr><td>' +
                                        _x[k].text + '</td><td><a onclick="selectCourse(' + _x[k].scid + ')" id="xscid-' + _x[k].scid + '">' +
                                        '选课</a></td></tr>';
                                }
                            }
                        }

                        _sum += _numX;
                    }
                    _body += '<tbody id="cname-' + _o[i].text + '"><tr><td class="text-indianred text-blod" rowspan="' + _tmpSum + '">' + _o[i].text + '</td>' + _tmpHS + '</tbody>';


                }
                TableHS = _head + _body + _foot;
                StudentAPI.numXCourse = _sum;
                return TableHS;

            }
        },

        selectingCourse: {
            getTableHS: function() {
                var _head = '<table class="table table-responsive" title="选课表">' +
                    '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 待确认</th></tr></thead>',
                    _body = '',
                    _foot = '</table>',
                    _o = StudentAPI.selectingCourseDS;
                if(_o.length === 0){
                    _body = '<tbody><tr><td  class="text-indianred text-blod"  colspan="4">暂无待批准课程</td></tr></tbody>';
                    return _head + _body + _foot;
                }
                for (var i = 0; i < _o.length; i++) {

                    var hs = '<tr><td  class="text-indianred text-blod">' +
                        _o[i].course + '</td><td>' +
                        _o[i].teacher + '</td><td>' +
                        _o[i].ClassName + '</td><td>' +
                        '<a href="javascript: void(0)"' +
                        'id="cancel-' + _o[i].scid + '" ' +
                        'onclick="cancelCourse(' + _o[i].scid + ')">退选</a>' +
                        '</td></tr>';

                    _body += hs;

                }
                return _head + _body + _foot;
            }
        },

        Resource: {
            getJSON: function() {
                var _root = StudentAPI.OCidIsCourse.resourceDS.json;

                if (_root === undefined || _root === null) return [];
                var _nodeI,
                    _nodeII,
                    _nodeIII,
                    _now = null,
                    JSON = [];

                for (var i = 0; i < _root.length; i++) {

                    _nodeI = _root[i];
                    //初始化位置坐标
                    //console.log('i:' + i);
                    _now = JSON;
                    _now[i] = {
                        description: _nodeI.text,
                        position: [_nodeI.id, null, null],
                        resource: [],
                        nodes: []
                    };
                    if (_nodeI.resource !== undefined) {
                        _now[i].resource = _nodeI.resource;
                    }
                    //                    console.log(_now[i].resource);
                    _now = _now[i].nodes;
                    if (_nodeI.children === undefined) continue;
                    for (var j = 0; j < _nodeI.children.length; j++) {
                        _nodeII = _nodeI.children[j];

                        //初始化位置坐标
                        //console.log('j:' + j);
                        _now[j] = {
                            description: _nodeII.text,
                            position: [_nodeI.id, _nodeII.id, null],
                            resource: [],
                            nodes: []
                        };
                        if (_nodeII.resource !== undefined) {
                            _now[j].resource = _nodeII.resource;
                        }
                        _now = _now[j].nodes;
                        if (_nodeII.children === undefined) continue;
                        for (var k = 0; k < _nodeII.children.length; k++) {
                            _nodeIII = _nodeII.children[k];

                            //初始化位置坐标
                            //console.log('k:' + k);
                            _now[k] = {
                                description: _nodeIII.text,
                                position: [_nodeI.id, _nodeII.id, _nodeIII.id],
                                resource: []
                            };

                            if (_nodeIII.resource !== undefined) {
                                _now[k].resource = _nodeIII.resource;
                            }
                        }
                    }
                }
                return JSON;
            },

            getFileHS: function(nodes) {
                var name = '',
                    size = 0,
                    status = 0,
                    previewPath = '',
                    playPath = '',
                    downloadPath = '';

                var hs = '<hr>';
                if (nodes === undefined) return '';
                var _head = '<table class="table table-responsive table-filelist">' +
                    '<thead><tr><th>文件名</th><th>大小</th><th>下载</th><th>其它</th></tr></thead>',
                    _foot = '</table>';
                if (nodes.length === 0) {
                    return hs + _head + '<tr><td colspan="4">暂无资源</td></tr>' + _foot;
                }
                for (var i = 0; i < nodes.length; i++) {

                    name = nodes[i].name;
                    size = nodes[i].size;
                    size = (size / 1000000 > 1 ? toDecimal2(size / 1000000) + 'MB' : toDecimal2(size / 1000) + 'KB');
                    status = nodes[i].handle.status;
                    downloadPath = "file/" + StudentAPI.OCidIsCourse.resourceDS.dir + nodes[i].handle.downloadDir;
                    //                    alert(downloadPath);
                    previewPath = '' + StudentAPI.OCidIsCourse.resourceDS.dir + nodes[i].handle.previewDir;
                    if (status === -1) {
                        hs += '<tr><td  class="text-indianred text-blod">' +
                            name + '</td><td>' +
                            size + '</td><td>' +
                            '<a class="btn btn-flat btn-brand" href="' + downloadPath + '" target="_blank">下载</a>' + '</td><td>' +
                            '<a class="btn btn-flat btn-red stage-card" href="http://localhost:8084/lms/getswf?uri=' + previewPath + '">预览</a>' +
                            '</td></tr>';

                    } else if (status === 1) {

                        hs += '<tr><td  class="text-indianred text-blod">' +
                            name + '</td><td>' +
                            size + '</td><td>' +
                            '<a class="btn btn-flat btn-brand" href="' + downloadPath + '">下载</a>' + '</td><td>' +
                            '<a class="btn btn-flat btn-red stage-card" target="_blank" href="http://localhost:8084/lms/getvideo?uri=' + downloadPath + '">播放</a>' +
                            '</td></tr>';

                    } else {

                        hs += '<tr><td  class="text-indianred text-blod">' +
                            name + '</td><td>' +
                            size + '</td><td>' +
                            '<a class="btn btn-flat btn-brand" target="_blank" href="' + downloadPath + '">下载</a>' + '</td><td>' +
                            '-' +
                            '</td></tr>';
                    }
                }
                return _head + hs + _foot;
            },

            getFileManagerHS: function() {
                var _o = StudentAPI.analyzeDS.Resource.getJSON();
                if (_o === undefined || _o === null) return '暂无课件';
                var _now;
                var _hs = '',
                    _hsI = '',
                    _hsII = '',
                    _hsIII = '',
                    _hsFile = '';

                _hsI = '<div class="tab-content tab-pane fade in active " id="folder-root">';
                for (var i = 0; i < _o.length; i++) {
                    _hsI += '<a data-toggle="tab" data-posi="' + _o[i].position[0] +
                        '" data-posii="null" data-posiii="null" data-type="folder" href="#nodes-' + _o[i].position[0] +
                        '"><span class="icon icon-5x" >folder</span><span class="folder-name">' + _o[i].description + '</span><span class="file-num">' + (_o[i].nodes.length + _o[i].resource.length) + ' 项</span></a>'; //<span class="file-num">'+ (_o[i].nodes.length + _o[i].resource.length) +'</span>


                    _hsII = '<div class="tab-content tab-pane fade " id="nodes-' + _o[i].position[0] + '">' +
                        '<a data-toggle="tab" href="#folder-root"><span class="icon icon-5x" >folder</span><span class="folder-name">返回根目录</span><span class="file-num">...</span></a>';

                    _now = _o[i].nodes;
                    for (var j = 0; j < _o[i].nodes.length; j++) {
                        _hsII += '<a data-toggle="tab" data-posi="' + _now[j].position[0] + '" data-posii="' + _now[j].position[1] + '" data-posiii="null' +
                            '"data-type="folder" href="#nodes-' + _now[j].position[0] + _now[j].position[1] +
                            '"><span class="icon icon-5x" >folder</span><span class="folder-name">' + _now[j].description + '</span><span class="file-num">' + (_o[i].nodes[j].nodes.length + _now[j].resource.length) + ' 项</span></a>';


                        _hsIII = '<div class="tab-content tab-pane fade " id="nodes-' + _now[j].position[0] + _now[j].position[1] + '">' +
                            '<a data-toggle="tab" href="#folder-root"><span class="icon icon-5x" >folder</span><span class="folder-name">返回根目录</span><span class="file-num">...</span></a><a data-toggle="tab" href="#nodes-' + _o[i].position[0] + '"><span class="icon icon-5x">folder</span><span class="folder-name">返回上一级</span><span class="file-num">...</span></a>';

                        //                        console.log(_now);
                        _now = _o[i].nodes[j].nodes;
                        for (var k = 0; k < _now.length; k++) {

                            _hsIII += '<a data-toggle="tab" data-posi="' + _now[k].position[0] + '" data-posii="' + _now[k].position[1] + '" data-posiii="' + _now[k].position[2] +
                                '"data-type="folder" href="#nodes-' + _now[k].position[0] + _now[k].position[1] + _now[k].position[2] +
                                '"><span class="icon icon-5x">folder</span><span class="folder-name">' + _now[k].description + '</span><span class="file-num">' + (_now[k].resource.length) + ' 项</span></a>';


                            _hsFile = '<div class="tab-content tab-pane fade " id="nodes-' + _now[j].position[0] + _now[j].position[1] + _now[k].position[2] + '">' +
                                '<a data-toggle="tab" href="#folder-root"><span class="icon icon-5x" >folder</span><span class="folder-name">返回根目录</span><span class="file-num">...</span></a><a data-toggle="tab" href="#nodes-' + _now[j].position[0] + _now[j].position[1] + '"><span class="icon icon-5x" >folder</span><span class="folder-name">返回上一级</span><span class="file-num">...</span></a>';


                            _hsFile += StudentAPI.analyzeDS.Resource.getFileHS(_o[i].nodes[j].nodes[k].resource);
                            _hsFile += '</div>';
                            _hs += _hsFile;
                        }
                        _hsIII += StudentAPI.analyzeDS.Resource.getFileHS(_o[i].nodes[j].resource);
                        _hsIII += '</div>';
                        _hs += _hsIII;
                    }
                    _hsII += StudentAPI.analyzeDS.Resource.getFileHS(_o[i].resource);
                    _hsII += '</div>';
                    _hs += _hsII;

                }
                _hsI += '</div>';
                _hs += _hsI;

                //                alert(_hs);
                return _hs;
            }
        },

        Homework: {
            updataJSON: function(scid){
                $.ajax({
                    url: StudentAPI.Path.cInfo[2] + "?scid=" + scid,
                    type: 'get',
                    async: false,
                    dataType: 'json',
                    success: function(data) {
                        StudentAPI.OCidIsCourse.homeworkDS = StudentAPI.analyzeDS.Homework.getJSON(data, scid);
                        statusCode = 1;
                    },
                    error: function() {
                        alert("数据[作业]传输失败 ！");
                        statusCode = -1;
                    }
                });
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
             * @param {type} data
             * @param {type} scid
             * @returns {StudentAPI.analyzeDS.Homework.getJSON.obj}
             */
            getJSON: function(data, scid) {

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
//                        detail = StudentAPI.analyzeDS.Homework.getDetail(scid, data[i].homeworkid);
//                        _i[x].detail = detail.Hwhelp;
//                        _i[x].attachment = detail.Hwattachment;
//                        _i[x].content = detail.HwtextWork;
//                        _i[x].myAttachment = detail.Myattachment;
                        x++;

                    } else if (data[i].status === "已提交") {
                        _o.push(data[i]);
//                        detail = StudentAPI.analyzeDS.Homework.getDetail(scid, data[i].homeworkid);
//                        _o[y].detail = detail.Hwhelp;
//                        _o[y].attachment = detail.Hwattachment;
//                        _o[y].content = detail.HwtextWork;
//                        _o[y].myAttachment = detail.Myattachment;
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
             * @param {Number} scid
             * @param {Number} homeworkid
             * @returns {StudentAPI.analyzeDS.Homework.getJSON.obj}
             */
            getDetail: function(scid, homeworkid) {
                var detail;
                $.ajax({
                    url: StudentAPI.Path.cInfo[5] + '?scid=' + scid + '&homeworkid=' + homeworkid,
                    type: 'get',
                    async: false,
                    dataType: 'json',
                    success: function(data) {
                        detail = data;
                    },
                    error: function() {
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
            
            getDoneHS: function() {
                var _o = StudentAPI.OCidIsCourse.homeworkDS.o;
                if (_o.length === 0) return '<p>暂无已提交作业<p>';
                var hs = '';
                for (var i = 0; i < _o.length; i++) {
                    hs += '<div class="card"><div class="card-main"><div class="card-action divider-b"><div class="card-action-btn btn btn-flat pull-left homework-name">' + _o[i].title + '</div>' +
                        '<a title="编辑" class="btn-edit btn btn-flat pull-right" data-toggle="tab" href="#tab-homework-editor" data-status="true" data-hid="' + _o[i].homeworkid + '" ><span><span class="icon avatar avatar-sm">edit</span></span></a>' +
                        '</div><div class="card-inner">' +
                        '<title class="btn btn-flat text-blod text-indianred">截止日期:</title><p class="homework-info">' + _o[i].deadline + '</p></div>' +
                        '</div></div>';
                }
                return hs;
            },

            getDoingHS: function() {
                var _i = StudentAPI.OCidIsCourse.homeworkDS.i;
                if (_i.length === 0) return '<p>暂无需提交作业<p>';
                var hs = '';
                for (var i = 0; i < _i.length; i++) {
                    hs += '<div class="card"><div class="card-main"><div class="card-action divider-b"><div class="card-action-btn btn btn-flat pull-left homework-name">' + _i[i].title + '</div>' +
                        '<a title="编辑" class="btn-edit collapse btn btn-flat pull-right" data-toggle="tab" href="#tab-homework-editor" data-status="false" data-hid="' + _i[i].homeworkid + '" ><span><span class="icon avatar avatar-sm">edit</span></span></a>' +
                        '</div><div class="card-inner">' +
                        '<title class="btn btn-flat text-blod text-indianred">截止日期:</title><p class="homework-info">' + _i[i].deadline + '</p></div>' +
                        '</div></div>';
                }
                return hs;
            },

            getMissHS: function(fn) {
                var _x = StudentAPI.OCidIsCourse.homeworkDS.x;
                if (_x.length === 0) return '<p>暂无历史作业<p>';
                var hs = '';
                for (var i = 0; i < _x.length; i++) {
                    hs += '<div class="card"><div class="card-main"><div class="card-action"><div class="card-action-btn btn btn-flat pull-left homework-name">' + _x[i].title + '</div>' +
                        '<a title="显示" onclick="getMissDetailHS('+ StudentAPI.ThisCourse[0].scid +' , '+ _x[i].homeworkid +')" class="btn-looks collapse btn btn-flat pull-right" data-toggle="collapse" href="#collapse-history-' + _x[i].homeworkid + '"><span><span class="icon avatar avatar-sm">remove_red_eye</span></span></a></div>' +
                        '<div class="collapsible-region collapse" id="collapse-history-' + _x[i].homeworkid + '"></div>' +
                        '</div></div>';
                }

                return hs;
            },
            
            getMissDetailHS: function(scid, hid) {
                var detail = StudentAPI.analyzeDS.Homework.getDetail(scid, hid);
                console.log(detail);
                var domId = '#collapse-history-' + hid;
                var hs = '';
                
                //构造作业内容和作业详情
                hs += '<title class="btn btn-flat text-blod text-indianred">作业要求</title><p class="homework-info">' + detail.Hwhelp + '</p><title class="btn btn-flat text-blod text-indianred">附件列表</title><p class="homework-attachment"></p>' +
                      '<title class="btn btn-flat text-blod text-indianred">我的作业</title><p class="homework-content"></p><div id="content-' + hid + '" class="content-area">'+ detail.HwtextWork +'</div>';;
                
                //构造附件表格
                var _src;
                var _list = detail.Myattachment;
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

        }
    },
    setDS:{
      resource: function(scid){
        var _o = StudentAPI.OCidIsCourse;
            pathResourceDS = StudentAPI.Path.cInfo[1] + "?scid=" + scid;
            $.ajax({
                url: pathResourceDS,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _o.resourceDS.json = data;
                    //console.log(data);
                },
                error: function () {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: StudentAPI.OCidIsCourse.courseName + '的课程' +
                                '数据 [教学资源] 传输失败 ！ 可能老师并未编辑' +
                                '<a data-dismiss="snackbar">我知道了</a>'
                    });
                }
            });
      }  
    },
    structureCidIsCourse: function(scid, is, path) {
        var _o = StudentAPI.OCidIsCourse;
        var _x = StudentAPI.XCidIsCourse;
        var pathSummary,
            pathResourceDS,
            pathResourceDir,
            pathHomework;
        if (path === undefined ? true : false) {
            pathSummary = StudentAPI.Path.cInfo[0] + "?scid=" + scid;
            pathResourceDS = StudentAPI.Path.cInfo[1] + "?scid=" + scid;
            pathResourceDir = StudentAPI.Path.cInfo[4] + "?scid=" + scid;
            pathHomework = StudentAPI.Path.cInfo[2] + "?scid=" + scid;
        };
        if (is === true) {
            $.ajax({
                url: pathSummary,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function(data) {
                    _x.courseName = data[0].courseName;
                    _x.teacherName = data[1].teacherName;
                    _x.teacherSn = data[2].teacherSn;
                    _x.introduction = data[4].introduction === null ? '暂无介绍' : data[4].introduction;
                    _x.syllabus = data[3].syllabus === null ? '暂无介绍' : data[3].syllabus;
                    _x.attachment = data[5].swf_syllabus;
                },
                error: function() {
                    alert("数据传输失败 ！");
                }
            });

            return _x;
        } else {
            $.ajax({
                url: pathSummary,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function(data) {
                    _o.courseName = data[0].courseName;
                    _o.teacherName = data[1].teacherName;
                    _o.teacherSn = data[2].teacherSn;
                    _o.introduction = data[4].introduction === null ? '暂无介绍' : data[4].introduction;
                    _o.syllabus = data[3].syllabus === null ? '暂无介绍' : data[3].syllabus;
                    _o.attachment = data[5].swf_syllabus;

                    _o.resourceDS.json = null;
                    _o.homeworkDS = null;
                },
                error: function() {
                    alert("数据传输失败 ！");
                }
            });
            $.ajax({
                url: pathResourceDS,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function(data) {
                    _o.resourceDS.json = data;
                    //console.log(data);
                },
                error: function() {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: StudentAPI.OCidIsCourse.courseName + '的课程' +
                            '数据 [教学资源] 传输失败 ！ 可能老师并未编辑' +
                            '<a data-dismiss="snackbar">我知道了</a>'
                    });
                }
            });
            $.ajax({
                url: pathResourceDir,
                type: 'get',
                async: false,
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                    _o.resourceDS.dir = data.dir;
                    console.log(data);
                },
                error: function() {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: StudentAPI.OCidIsCourse.courseName + '的课程' +
                            '数据 [教学资源 地址] 传输失败 ！ 可能老师并未编辑' +
                            '<a data-dismiss="snackbar">我知道了</a>'
                    });
                }
            });
            $.ajax({
                url: pathHomework,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function(data) {
                    _o.homeworkDS = StudentAPI.analyzeDS.Homework.getJSON(data, scid);
                },
                error: function() {
                    alert("数据[作业]传输失败 ！");
                }
            });
        }

        return _o;

    },

    /**
     * 对课程操作 包含以下方法:
     * <br>add - 选课
     * <br>quit - 退选已选课程
     * <br>cancel - 退选待批准课程
     */
    operateCidIsCourse: {

        /**
         * 添加课程
         * @param {Number} scid - 课程ID
         * @param {optional String} path - 提交添加请求的含课程参数的JSON路径
         * @returns {Boolean} 0 - 出错, 1 - 成功
         */
        add: function(scid, path) {
            var status = StudentAPI.courseStatus;
            if (path === undefined ? true : false) {
                //alert("path === undefined");
                path = StudentAPI.Path.cOperate[0] + "?scid=" + scid;
            }
            $.ajax({
                url: path,
                type: 'post',
                async: false,
                dataType: 'json',
                success: function(data) {
                    if (data === 0) {
                        status = false;
                    } else if (data === 1) {
                        status = true;
                    } else {
                        alert("出现 代码逻辑错误 !");
                    }
                },
                error: function() {
                    alert("数据传输失败 ！");
                }
            });
            return status;
        },

        /**
         * 退选课程
         * @param {Number} scid - 课程ID
         * @param {optional String} path - 提交添加请求的含课程参数的JSON路径
         * @returns {Boolean} 0 - 出错, 1 - 成功
         */
        quit: function(scid, path) {
            var status = StudentAPI.courseStatus;
            if (path === undefined ? true : false) {
                path = StudentAPI.Path.cOperate[2] + "?scid=" + scid;
            }
            $.ajax({
                url: path,
                type: 'post',
                async: false,
                dataType: 'json',
                success: function(data) {
                    if (data === 0) {
                        status = false;
                    } else if (data === 1) {
                        status = true;
                    } else {
                        alert("出现 代码逻辑错误 !");
                    }
                },
                error: function() {
                    alert("数据传输失败 ！");
                }
            });
            return status;
        },

        /**
         * 退选待批准
         * @param {Number} scid - 课程ID
         * @param {optional String} path - 提交添加请求的含课程参数的JSON路径
         * @returns {Boolean} 0 - 出错, 1 - 成功
         */
        cancel: function(scid, path) {
            var status = StudentAPI.courseStatus;
            if (path === undefined ? true : false) {
                path = StudentAPI.Path.cOperate[1] + "?scid=" + scid;
            }
            $.ajax({
                url: path,
                type: 'post',
                async: false,
                dataType: 'json',
                success: function(data) {
                    if (data === 0) {
                        status = false;
                    } else if (data === 1) {
                        status = true;
                    } else {
                        alert("出现 代码逻辑错误 !");
                    }
                },
                error: function() {
                    alert("数据传输失败 ！");
                }
            });
            return status;
        }
    },
    operateHomework: {
        downloadAttachment: function(scid, homeworkid, src) {
            $.ajax({
                type: "post",
                url: StudentAPI.Path.fOperate[1] + '?scid=' + scid + '&homeworkid=' + homeworkid + '&src=' + src,
                success: function() {},
                error: function() {
                    alert("出现错误! 作业已过期或文件不存在");
                }
            });
        },

        deleteAttachment: function(scid, homeworkid, src) {
            $.ajax({
                type: "GET",
                url: StudentAPI.Path.fOperate[0] + '?scid=' + scid + '&homeworkid=' + homeworkid + '&src=' + src,
                success: function(data) {

                    if (data === "ok") {
                        $('#snackbar').snackbar({
                            alive: 10000,
                            content: '作业附件删除成功 <a data-dismiss="snackbar">我知道了</a>'
                        });
                    } else {
                        alert("作业附件删除失败！ 可能原因：作业已过期或文件不存在");
                    }

                },
                error: function() {
                    alert("未知错误");
                }
            });
        },

        uploadAttachment: function(scid, homeworkid) {
            $('#uploadify').uploadify("settings", "formData", {
                'scid': scid,
                'homeworkid': homeworkid
            });
            $('#uploadify').uploadify('upload', '*');
        },
        
        getAttachmentList: function(scid, homeworkid) {
            $.ajax({
                url: StudentAPI.Path.fOperate[2] + '?scid=' + scid + '&homeworkid=' + homeworkid,
                type: 'GET',
                cache: false,
                async: false,
                success: function(data) {
                    StudentAPI.attachmentListDS.stu = data;
                },
                error: function() {
                    alert("未知错误");
                }
            });
            return true;
        },
        
        submit: function(scid, homeworkid, hs) {
            var status = 0;
            $.ajax({
                url: StudentAPI.Path.fOperate[3] + '?scid=' + scid + '&homeworkid=' + homeworkid,
                type: 'post',
                data: {
                    HwEitor: hs
                },
                cache: false,
                success: function(data) {
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
                error: function() {
                    status = -1;
                    alert("未知错误");
                }
            });
            console.log(status);
            return status;
        }
    },
    operateResource: {
        load: function() {

        },
        downloadIt: function() {

        },
        downloadItBatch: function() {

        }
    },
    fn: {}

};

//定义全局变量
var statusCode = 0;
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
var HidIsAttachmentHS = '';
//定义初始化函数
function initPage() {

    //Step 初始化 相关基础参数
    StudentAPI.initPersonalInfo();
    if (StudentAPI.sex === true) {
        $('#boy').attr("checked", "checked");
    } else {
        $('#girl').attr("checked", "checked");
    }
    StudentAPI.initPersnalCourseInfo();
    if (StudentAPI.selectedCourseDS[0] !== undefined) {
        
        /**
         * 获得已选课程的第一个,加以初始化
         */
        var scid = StudentAPI.selectedCourseDS[0].scid;
        ThisCourse[0].obj = StudentAPI.structureCidIsCourse(scid);
        ThisCourse[0].scid = scid; 
        ThisCourse[0].obj.__proto__ = new Vue({
            el: '#ucontent',
            data: {
                introduction: ThisCourse[0].obj.introduction,
                syllabus: ThisCourse[0].obj.syllabus + ThisCourse[0].obj.attachment,
                courseliset: StudentAPI.analyzeDS.selectedCourse.getListHS(),
                resource: StudentAPI.analyzeDS.Resource.getFileManagerHS(),
                OHomeworkHS: StudentAPI.analyzeDS.Homework.getDoneHS(),
                IHomeworkHS: StudentAPI.analyzeDS.Homework.getDoingHS(),
                XHomeworkHS: StudentAPI.analyzeDS.Homework.getMissHS()
            }
        });
        
    } else {
        ThisCourse[0].obj = StudentAPI.DemonCourse;
        ThisCourse[0].obj.__proto__ = new Vue({
            el: '#ucontent',
            data: {
                introduction: '<p style="color:grey">请至少选择一门课程</p>',
                syllabus: '<p style="color:grey">请至少选择一门课程</p>',
                courseliset: '<li><a>暂无课程</a></li>',
                resource: [],
                OHomeworkHS: '<p style="color:grey">无</p>',
                IHomeworkHS: '<p style="color:grey">无</p>',
                XHomeworkHS: '<p style="color:grey">无</p>'
            }
        });
    }

    //Step 绑定 相关基础参数


    //    ThisCourse[1].__proto__ = new Vue({
    //        el: '#',
    //        data: {
    //            introduction: ThisCourse[1].introduction,
    //            syllabus: ThisCourse[1].syllabus
    //        }
    //    });


    
    UPanel = new Vue({
        el: "#upanel",
        data: {
            sn: StudentAPI.sn,
            name: StudentAPI.name,
            portrait: StudentAPI.name.toString()[0],
            grade: StudentAPI.grade,
            college: StudentAPI.college,
            qq: StudentAPI.qq,
            numOCourse: StudentAPI.numOCourse,
            numICourse: StudentAPI.numICourse
        }
    });
    UInfo= new Vue({
        el: '#uifo',
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
    UBox = new Vue({
        el: '#ubox',
        data: {
            
        }
    });

};

//定义更新函数(包装函数)
function updataSelectedCourse(scid) {
    NProgress.start();
    ThisCourse[0].scid = scid;
    ThisCourse[0].obj = StudentAPI.structureCidIsCourse(ThisCourse[0].scid);
    ThisCourse[0].obj.$data.introduction = ThisCourse[0].obj.introduction;
    ThisCourse[0].obj.$data.syllabus = ThisCourse[0].obj.syllabus + ThisCourse[0].obj.attachment;
    ThisCourse[0].obj.$data.resource = StudentAPI.analyzeDS.Resource.getFileManagerHS();
    ThisCourse[0].obj.$data.OHomeworkHS = StudentAPI.analyzeDS.Homework.getDoneHS();
    ThisCourse[0].obj.$data.IHomeworkHS = StudentAPI.analyzeDS.Homework.getDoingHS();
    ThisCourse[0].obj.$data.XHomeworkHS = StudentAPI.analyzeDS.Homework.getMissHS();
    $('a[href="#tab-homework"]').click();
    $('#lms-editor').empty();
    setTimeout(function () { 
        fn.bindHid();
    }, 3000);
    
    NProgress.done();
    
};
var fn={};
fn.bindHid=function(){
    $('a[data-hid]').click(function () {
        NProgress.start();
        var hid = $(this).attr('data-hid');
        var isDone = $(this).attr('data-status') === true ? true : false;

        //
        if (ThisCourse[0].hid === 0 || (hid !== ThisCourse[0].hid) || (isDone)) {
            refreshHomeworkArea(hid);
        }

        var content = tinymce.get('lms-editor').getContent({
            format: 'raw'
        });

        console.log(hid);
        NProgress.done();

    });
};
function updataSelectableCourse(scid) {
    ThisCourse[1].scid = scid;
    ThisCourse[1] = StudentAPI.structureCidIsCourse(ThisCourse[1].scid);
    ThisCourse[1].obj.$data.introduction = ThisCourse[1].introduction;
    ThisCourse[1].obj.$data.syllabus = ThisCourse[1].syllabus + ThisCourse[1].attachment;
    //console.log(ThisCourse[1]);
};

function updataPersonalInfo() {
    
    if (!CheckValidation()) {
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
function updataResourceArea(){
    StudentAPI.setDS.resource(ThisCourse[0].scid);
    ThisCourse[0].obj.$data.resource = StudentAPI.analyzeDS.Resource.getFileManagerHS();
    $('.stage-card').boxer();
}
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
}

function updataPassword() {
    
    if(checkPassword()){
        StudentAPI.updatePassword(StudentAPI.Path.uInfo[2] +
            "?pw=" + hex_md5($("#oldPassword").val()) +
            "&repw=" + hex_md5($("#newPassword").val()));
    }
};

function CheckValidation() {
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
}
function updataThisCourse1cid(scid) {
    ThisCourse[1].scid = scid;
};

function updataThisCourse0cid(scid) {
    ThisCourse[0].scid = scid;
};

function updataUPanel(method) {
    switch (method) {
        case 0:
            {
                StudentAPI.initPersonalInfo();
                UPanel.$data.sn = StudentAPI.sn;
                UPanel.$data.name = StudentAPI.name;
                UPanel.$data.portrait = StudentAPI.name.toString()[0];
                UPanel.$data.grade = StudentAPI.grade;
                UPanel.$data.college = StudentAPI.college;
                UPanel.$data.qq = StudentAPI.qq;
                break;
            };
        case 1:
            {

                StudentAPI.initPersnalCourseInfo();
                break;
            };
        default:
            {
                StudentAPI.initPersonalInfo();
                StudentAPI.initPersnalCourseInfo();
                UPanel.$data.sn = StudentAPI.sn;
                UPanel.$data.name = StudentAPI.name;
                UPanel.$data.portrait = StudentAPI.name.toString()[0];
                UPanel.$data.grade = StudentAPI.grade;
                UPanel.$data.college = StudentAPI.college;
                UPanel.$data.qq = StudentAPI.qq;
                break;
            };

    }
}

function selectCourse(scid) {
    var status = StudentAPI.operateCidIsCourse.add(scid);
    if (status === true) {
//        StudentAPI.initPersnalCourseInfo();
//        UCourse.$data.ICourseTableHS = StudentAPI.analyzeDS.selectingCourse.getTableHS();
        $('#snackbar').snackbar({
            alive: 10000,
            content: '选课申请已提交, 等待老师批准 ' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    } else {

        $('#snackbar').snackbar({
            alive: 10000,
            content: '选课申请提交 失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
};

function quitCourse(scid) {
    var status;
    if(confirm("真的确定, 退出这门课程么(请谨慎操作!)?")){
        status = StudentAPI.operateCidIsCourse.quit(scid);
    }
    if (status === true) {
//        StudentAPI.initPersnalCourseInfo();
//        UCourse.$data.OCourseTableHS = StudentAPI.analyzeDS.selectedCourse.getTableHS();
        $('#snackbar').snackbar({
            alive: 10000,
            content: '已经退选课程' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    } else {

        $('#snackbar').snackbar({
            alive: 10000,
            content: '退选失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
};

function cancelCourse(scid) {
    var status = StudentAPI.operateCidIsCourse.cancel(scid);
    if (status === true) {
//        StudentAPI.initPersnalCourseInfo();
//        UCourse.$data.ICourseTableHS = StudentAPI.analyzeDS.selectingCourse.getTableHS();
        $('#snackbar').snackbar({
            alive: 10000,
            content: '已经取消选课' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    } else {

        $('#snackbar').snackbar({
            alive: 10000,
            content: '取消失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
}


function updataHid(hid) {
    ThisCourse[0].hid = hid;
}

function updataByThisHid(hid) {
    ThisCourse[0].hid = hid;
    $('#uploaded-area').hide();
    if (StudentAPI.operateHomework.getAttachmentList(ThisCourse[0].scid, ThisCourse[0].hid)) {
        var _list = StudentAPI.attachmentListDS.stu;
        var _src;
        HidIsAttachmentHS = '<table class="table table-bordered"><thead><tr><th>附件名</th><th>下载</th><th>删除</th></tr></thead>';
        for (var i = 0; i < _list.length; i++) {
            _src = _list[i];
            HidIsAttachmentHS += '<tbody><tr><td><span class="text-indianred">' + _src + '</span></td>' +
                '<td><a class="btn-brand btn-flat" target="_blank" href="' + StudentAPI.Path.fOperate[1] + '?scid=' + ThisCourse[0].scid + '&homeworkid=' + ThisCourse[0].hid + '&src=' + _src + '" class="">下载</a></td>' +
                '<td><a class="btn-default btn-flat" onclick="deleteAttachment(\'' + _src + '\')" class="">删除</a></td></tr></tbody>';
        }
        HidIsAttachmentHS += '</table>';
        console.log(_list);
        $('#uploaded-area').empty();
        $('#uploaded-area').append(HidIsAttachmentHS);
        $('#uploaded-area').fadeIn();
    }
}
function refreshHomeworkList(){
    StudentAPI.analyzeDS.Homework.updataJSON(ThisCourse[0].scid);
    ThisCourse[0].obj.$data.OHomeworkHS = StudentAPI.analyzeDS.Homework.getDoneHS();
    ThisCourse[0].obj.$data.IHomeworkHS = StudentAPI.analyzeDS.Homework.getDoingHS();
    console.log("reflesh homework list done !");
    NProgress.start();
}
function refreshHomeworkArea(hid){
    updataHid(hid);
    refreshUploadedArea();
    
    ThisCourse[0].hobj = StudentAPI.analyzeDS.Homework.getDetail(ThisCourse[0].scid, hid);
    $('#homework-info').empty();
    $('#homework-info').html(ThisCourse[0].hobj.Hwhelp);
    console.log("course info is :" + ThisCourse[0].hobj.Hwhelp);
    $('#lms-editor').empty();
    $('#lms-editor').html(ThisCourse[0].hobj.HwtextWork);
    console.log("my homework's content  is :" + ThisCourse[0].hobj.HwtextWork);
    
}

function refreshUploadedArea() {
    $('#uploaded-area').hide();
    if (StudentAPI.operateHomework.getAttachmentList(ThisCourse[0].scid, ThisCourse[0].hid)) {
        var _list = StudentAPI.attachmentListDS.stu;
        var _src;
        HidIsAttachmentHS = '<table class="table"><thead><tr><td>附件名</td><td>下载</td><td>删除</td></tr><thead>';
        for (var i = 0; i < _list.length; i++) {
            _src = _list[i];
            HidIsAttachmentHS += '<tbody><tr><td><span class="text-indianred">' + _src + '</span></td>' +
                '<td><a href="' + StudentAPI.Path.fOperate[1] + '?scid=' + ThisCourse[0].scid + '&homeworkid=' + ThisCourse[0].hid + '&src=' + _src + '" class="">下载</a></td>' +
                '<td><a onclick="deleteAttachment(\'' + _src + '\')" class="">删除</a></td></tr><tbody>';
        }
        HidIsAttachmentHS += '</table>';
        console.log(_list);
        $('#uploaded-area').empty();
        $('#uploaded-area').append(HidIsAttachmentHS);
        $('#uploaded-area').fadeIn();
    }
}


function uploadAttachment() {
    StudentAPI.operateHomework.uploadAttachment(ThisCourse[0].scid, ThisCourse[0].hid);
    $('#uploaded-area').hide();
    refreshUploadedArea();
    console.log("upload attachment ..." + ThisCourse[0].hid);
}

function downloadAttachment(src) {
    StudentAPI.operateHomework.downloadAttachment(ThisCourse[0].scid, ThisCourse[0].hid, src);
}

function deleteAttachment(src) {
    StudentAPI.operateHomework.deleteAttachment(ThisCourse[0].scid, ThisCourse[0].hid, src);
    $('#uploaded-area').hide();
    refreshUploadedArea();
    console.log("delete attachment ..." + ThisCourse[0].hid);
}

function downloadAttachment(src) {
    StudentAPI.operateHomework.downloadAttachment(ThisCourse[0].scid, ThisCourse[0].hid, src);
}

function submitHomework(hid) {
    hs = tinymce.get('lms-editor').getContent({
        format: 'raw'
    });
    console.log("submit homework ...");
    var status = StudentAPI.operateHomework.submit(ThisCourse[0].scid, hid, hs);
    console.log(status);
    if (status === 1 || status === 0) {
        NProgress.start();
        console.log("reflesh homework list ...");
        setTimeout(refreshHomeworkList, 800);
        return true;
    }else return false;
}

function getMissDetailHS(scid, hid){
    StudentAPI.analyzeDS.Homework.getMissDetailHS(scid, hid);
}
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
}


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
}

function fomatFloat(src, pos) {
    return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);
}

function getIdByDomId(prefix, domId) {
    return domId.replace(prefix, '');
}
function isContinue(){
    
}

function ableSubmitUInfo(){
}

function logout(){
    window.location.href="logout"; 
}
