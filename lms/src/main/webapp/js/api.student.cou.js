

var CourseAPI = {
    
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
         * 返回课程JSON, 可传参数加以过滤
         * @type Array
         */
        cStructure: [],
        
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
        ]

    },
    
    Courses:{
        
        o: {
            num: 0,
            ds: {}
        },
        i: {
            num: 0,
            ds: {}
        },
        x: {
            num: 0,
            ds: {}
        },
        
        setO: function(){
            //初始化 已选课程列的表树
            console.log("init 已选课程列的表树 info...");
            $.ajax({
                url: CourseAPI.Path.uInfo[3],
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    CourseAPI.selectedCourseDS = data;
                    CourseAPI.Courses.o.num = data.length;
                },
                error: function () {
                    alert("数据[已选课程列的表树]传输失败 ！");
                }
            });
        },
        
        setI: function(){
            //初始化 待批准课程的列表树
            console.log("init 待批准课程的列表树 info...");
            $.ajax({
                url: CourseAPI.Path.uInfo[5],
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    CourseAPI.selectingCourseDS = data;
                    CourseAPI.Courses.i.num = data.length;
                },
                error: function () {
                    alert("数据[待批准课程的列表树]传输失败 ！");
                }
            });
        },
        
        
        setX: function(){
            console.log("init 可选课程的列表树 info...");
            //初始化 可选课程的列表树
            $.ajax({
                url: CourseAPI.Path.uInfo[4],
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    CourseAPI.allCourseDS = data;
                    CourseAPI.selectableCourseDS = CourseAPI.Courses.getX(data);
                    CourseAPI.Courses.x.num = data.length;
                },
                error: function () {
                    alert("数据[可选课程的列表树]传输失败 ！");
                }
            });
        },
        getX: function(data){
            var _o = CourseAPI.selectedCourseDS;
            var _i = CourseAPI.selectingCourseDS;
            var _x = [];
            for(var i=0; i<data.length; i++){
                var isO = false;
                var isI = false;
                
                console.log(data[i].text  + " is : ");
                for (var k = 0; k < _o.length; k++) {
                    isO = data[i].text === _o[k].course ? true : false;
                    if(isO) break;
                }

                if (isO) {
                    console.log(" O ");
                    continue;
                }
                
                for (var k = 0; k < _i.length; k++) {
                    isI = data[i].text === _i[k].course ? true : false;
                    if(isI) break;
                }

                if (isI) {
                    console.log(" I ");
                    continue;
                }
                
                console.log(" X ");
                _x.push(data[i]);
            }
            return _x;
        }
    },
    
    initPersnalCourseInfo: function (path) {

        CourseAPI.Courses.setO();
        CourseAPI.Courses.setI();
        CourseAPI.Courses.setX();
        
        console.log("init has done ! ");
    },
    
    /**
     * 长度为二的对象数组 暴露为全局变量 (且唯一) 聚焦 当前的已/未选课程
     * <br>ThisCourse<b>[0]</b>:存储一个<b> 已 </b>选课程的实例
     * <br>ThisCourse<b>[1]</b>:存储一个<b> 待 </b>选课程的实例
     * @type Array
     */
    ThisCourse: {
        cid:0,
        cobj:{
            introduction: '',
            syllabus: '',
            teacherName: '',
            courseName: ''
        }
    },
    
    structureCidIsCourse: function (scid, is, path) {
        var _o = CourseAPI.OCidIsCourse;
        var _x = CourseAPI.XCidIsCourse;
        var pathSummary,
                pathResourceDS,
                pathResourceDir,
                pathHomework;
        if (path === undefined ? true : false) {
            pathSummary = CourseAPI.Path.cInfo[0] + "?scid=" + scid;
            pathResourceDS = CourseAPI.Path.cInfo[1] + "?scid=" + scid;
            pathResourceDir = CourseAPI.Path.cInfo[4] + "?scid=" + scid;
            pathHomework = CourseAPI.Path.cInfo[2] + "?scid=" + scid;
        }
        ;
        if (is === true) {
            $.ajax({
                url: pathSummary,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _x.courseName = data[0].courseName;
                    _x.teacherName = data[1].teacherName;
                    _x.teacherSn = data[2].teacherSn;
                    _x.introduction = data[4].introduction === null ? '暂无介绍' : data[4].introduction;
                    _x.syllabus = data[3].syllabus === null ? '暂无介绍' : data[3].syllabus;
                    _x.attachment = data[5].swf_syllabus;
                },
                error: function () {
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
                success: function (data) {
                    _o.courseName = data[0].courseName;
                    _o.teacherName = data[1].teacherName;
                    _o.teacherSn = data[2].teacherSn;
                    _o.introduction = data[4].introduction === null ? '暂无介绍' : data[4].introduction;
                    _o.syllabus = data[3].syllabus === null ? '暂无介绍' : data[3].syllabus;
                    _o.attachment = data[5].swf_syllabus;

                    _o.resourceDS.json = null;
                    _o.homeworkDS = null;
                },
                error: function () {
                    alert("数据传输失败 ！");
                }
            });
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
                        content: CourseAPI.OCidIsCourse.courseName + '的课程' +
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
                success: function (data) {
                    _o.resourceDS.dir = data.dir;
                    console.log(data);
                },
                error: function () {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: CourseAPI.OCidIsCourse.courseName + '的课程' +
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
                success: function (data) {
                    _o.homeworkDS = CourseAPI.analyzeDS.Homework.getJSON(data, scid);
                },
                error: function () {
                    alert("数据[作业]传输失败 ！");
                }
            });
        }

        return _o;

    },
    
    operateCidIsCourse: {
        /**
         * 添加课程
         * @param {Number} scid - 课程ID
         * @param {optional String} path - 提交添加请求的含课程参数的JSON路径
         * @returns {Boolean} 0 - 出错, 1 - 成功
         */
        add: function (scid, path) {
            var status = CourseAPI.courseStatus;
            if (path === undefined ? true : false) {
                //alert("path === undefined");
                path = CourseAPI.Path.cOperate[0] + "?scid=" + scid;
            }
            $.ajax({
                url: path,
                type: 'post',
                async: false,
                dataType: 'json',
                success: function (data) {
                    if (data === 0) {
                        status = false;
                    } else if (data === 1) {
                        status = true;
                    } else {
                        alert("出现 代码逻辑错误 !");
                    }
                },
                error: function () {
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
        quit: function (scid, path) {
            var status = CourseAPI.courseStatus;
            if (path === undefined ? true : false) {
                path = CourseAPI.Path.cOperate[2] + "?scid=" + scid;
            }
            $.ajax({
                url: path,
                type: 'post',
                async: false,
                dataType: 'json',
                success: function (data) {
                    if (data === 0) {
                        status = false;
                    } else if (data === 1) {
                        status = true;
                    } else {
                        alert("出现 代码逻辑错误 !");
                    }
                },
                error: function () {
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
        cancel: function (scid, path) {
            var status = CourseAPI.courseStatus;
            if (path === undefined ? true : false) {
                path = CourseAPI.Path.cOperate[1] + "?scid=" + scid;
            }
            $.ajax({
                url: path,
                type: 'post',
                async: false,
                dataType: 'json',
                success: function (data) {
                    if (data === 0) {
                        status = false;
                    } else if (data === 1) {
                        status = true;
                    } else {
                        alert("出现 代码逻辑错误 !");
                    }
                },
                error: function () {
                    alert("数据传输失败 ！");
                }
            });
            return status;
        }
    },
    
    /**
     * 默认的 初始化使用的 参数对象数组(每个数组第一位为状态值,第二位为查询参数)
     * @type Object Array
     */
    DefaultParms: {
        method: 'x',
        parms: null
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
            getListHS: function () {
                var _o = CourseAPI.selectedCourseDS;
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
            getTableHS: function () {
                var _head = '<table class="table table-responsive" title="选课表">' +
                        '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 已选</th></tr></thead>',
                        _body = '',
                        _foot = '</table>',
                        _o = CourseAPI.selectedCourseDS;
                if (_o.length === 0) {
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
            getTableHS: function () {
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


                _o = CourseAPI.selectableCourseDS;
                if (_o.length === 0) {
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
                CourseAPI.numXCourse = _sum;
                return TableHS;

            }
        },
        selectingCourse: {
            getTableHS: function () {
                var _head = '<table class="table table-responsive" title="选课表">' +
                        '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 待确认</th></tr></thead>',
                        _body = '',
                        _foot = '</table>',
                        _o = CourseAPI.selectingCourseDS;
                if (_o.length === 0) {
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
        allCourse:{
            
            getTableHS: function () {
                var _head = '<table class="table table-responsive" title="选课表">' +
                        '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 无</th></tr></thead>',
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


                _o = CourseAPI.allCourseDS;
                if (_o.length === 0) {
                    _body = '<tbody><tr><td  class="text-indianred text-blod" colspan="4">暂无课程</td></tr></tbody>';
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
                                            _x[k].text + '</td><td></td></tr>';
                                } else {
                                    _tmpHS = _tmpHS +
                                            '<tr><td>' +
                                            _x[k].text + '</td><td></td></tr>';
                                }
                            }
                        } else {
                            for (var k = 0; k < _numX; k++) {
                                if (k === 0) {
                                    _tmpHS = _tmpHS +
                                            '<tr><td rowspan="' + _numX + '">' +
                                            _i[j].text + '</td><td>' +
                                            _x[k].text + '</td><td></td></tr>';
                                } else {
                                    _tmpHS = _tmpHS +
                                            '<tr><td>' +
                                            _x[k].text + '</td><td></td></tr>';
                                }
                            }
                        }

                        _sum += _numX;
                    }
                    _body += '<tbody id="cname-' + _o[i].text + '"><tr><td class="text-indianred text-blod" rowspan="' + _tmpSum + '">' + _o[i].text + '</td>' + _tmpHS + '</tbody>';


                }
                TableHS = _head + _body + _foot;
                CourseAPI.numXCourse = _sum;
                return TableHS;

            }
        }
    }
};

var UCourse = new Vue({
    el: '#ucourses',
    data: {
        courseTableArea: ''
    }
});

function initCoursePage() {
    CourseAPI.initPersnalCourseInfo();
    updataCourseArea();
};

function updataParms(parms, is) {
    if (is === 'o') {
        CourseAPI.DefaultParms.method = 'o';
        CourseAPI.DefaultParms.parms = parms;
    } else if (is === 'i') {
        CourseAPI.DefaultParms.method = 'i';
        CourseAPI.DefaultParms.parms = parms;
    } else if (is === 'x') {
        CourseAPI.DefaultParms.method = 'x';
        CourseAPI.DefaultParms.parms = parms;
    }
};

function setDefaultParms(){};//直接修改CourseAPI.Parms内容

function updataCourseArea(){
    if(CourseAPI.DefaultParms.method === 'o'){
        console.log("updata courseTableArea by selectedCourseDS...");
        UCourse.$data.courseTableArea = CourseAPI.analyzeDS.selectedCourse.getTableHS();
    }else if(CourseAPI.DefaultParms.method === 'i'){
        console.log("updata courseTableArea by selectingCourse...");
        UCourse.$data.courseTableArea = CourseAPI.analyzeDS.selectingCourse.getTableHS();
    }else if(CourseAPI.DefaultParms.method === 'x'){
        console.log("updata courseTableArea by selectableCourse...");
        UCourse.$data.courseTableArea = CourseAPI.analyzeDS.selectableCourse.getTableHS();
    }else if(CourseAPI.DefaultParms.method === 'a'){
        
        console.log("updata courseTableArea by allCourseDS...");
        UCourse.$data.courseTableArea = CourseAPI.analyzeDS.allCourse.getTableHS();
    }
    console.log("updata courseTableArea has done !");
};

function selectCourse(scid) {
    var status = CourseAPI.operateCidIsCourse.add(scid);
    if (status === true) {
        CourseAPI.initPersnalCourseInfo();
        UCourse.$data.courseTableArea = CourseAPI.analyzeDS.selectableCourse.getTableHS();
        $('#snackbar').snackbar({
            alive: 10000,
            content: '选课申请已提交, 等待老师批准 ' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    } else {

        $('#snackbar').snackbar({
            alive: 10000,
            content: '选课申请提交 失败 (可能重复选课) !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
};

function quitCourse(scid) {
    var status=undefined;
    if (confirm("真的确定, 退出这门课程么(请谨慎操作!)?")) {
        status = CourseAPI.operateCidIsCourse.quit(scid);
    }else{
        $('#snackbar').snackbar({
            alive: 10000,
            content: '操作已取消 ' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
    if (status === true) {
        CourseAPI.initPersnalCourseInfo();
        UCourse.$data.courseTableArea = CourseAPI.analyzeDS.selectedCourse.getTableHS();
        $('#snackbar').snackbar({
            alive: 10000,
            content: '已经退选课程' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    } else if (status === false) {

        $('#snackbar').snackbar({
            alive: 10000,
            content: '退选失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
};

function cancelCourse(scid) {
    var status = CourseAPI.operateCidIsCourse.cancel(scid);
    if (status === true) {
        CourseAPI.initPersnalCourseInfo();
        UCourse.$data.courseTableArea = CourseAPI.analyzeDS.selectingCourse.getTableHS();
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
};