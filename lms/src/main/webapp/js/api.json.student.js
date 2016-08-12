/**
 * <br>命名:
 * <br>HS是Html Segment(html片段)的缩写
 * <br>DS是Data Structure(数据结构)的缩写
 * <br>O为已, X为未, OIX分别表示开始中间结尾(生选课表格HF时用到)
 * @author longyeh\@outlook.com
 */

/**
 * 
 * 
 */

//定义API接口
var StudentAPI = {
    id:0, 
    sn:0, 
    name:'', 
    ID:0, 
    pw:'', 
    sex:false, 
    grade:'', 
    college:'', 
    tel:'', 
    qq:'',
    numOCourse:0,
    numXCourse:0,
    numICourse:0,
    selectedCourseDS:[],
    selectingCourseDS:[],
    selectableCourseDS:[],
    courseStatus:false,
    schoolYearsDS: [],
    schoolCollegeDS: [],
    schoolYearsListHS:'',
    schoolCollegeListHS:'',
    WhippingBoy:{
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
     * 当前 聚焦的已选课程
     * @type Object
     */
    OCidIsCourse: {
        courseName:'',
        teacherName:'',
        teacherSn:'',
        introduction:'',
        syllabus:'',
        attachment:'',
        resourceDS:{},
        homeworkDS:{}
    },
    PostionIsResource:[],
    /**
     * 当前 聚焦的可选课程
     * @type Object
     */
    XCidIsCourse: {
        courseName:'',
        teacherName:'',
        teacherSn:'',
        introduction:'',
        syllabus:'',
        attachment:''
    },
    /**
     * 包含相关JSON路径数组的对象
     * @type Object
     */
    Path : {
        
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
        uInfo :[
            
            "student/getpersoninfo",        //[0] 
            "student/updatepersoninfo",     //[1]  
            "student/updatepassword",       //[2]
            "student/getselectcourse",      //[3] 
            "student/addnewcourse",         //[4] 
            "student/getselectingcourse"    //[5] 
        ],
        
        /**
         * 用以初始化课程相关信息 
         * <br>均需额外的路径参数:?scid= 
         * <br>cInfo[0] 返回课程详情 
         * <br>cInfo[1] 返回课程内容目录树JSON 
         * <br>cInfo[2] 返回作业列表 
         * 
         * @type Array 
         */
        cInfo :[
            
            "student/stu_course",           //[0]  
            "student/kcgs",                 //[1]  
            "student/stu_course_homework",  //[2] 
            "student/courdir"               //[3]
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
            
            "student/subselectcourse",      //[0] 
            "student/cancelcourse",         //[1] 
            "student/quitcourse"            //[2] 
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
            success: function (data) {
                var _hs = '';
                StudentAPI.schoolYearsDS = data;
                
                for(var i=0; i<data.length; i++){
                    
                    _hs +=  '<option value="'+ data[i] +'"> ' + data[i] +' </option>';
                }
                StudentAPI.schoolYearsListHS = _hs;
            },
            error: function () {
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
            success: function (data) {
                var _hs = '';
                StudentAPI.schoolCollegeDS = data;
                
                for(var i=0; i<data.length; i++){
                    _hs +=  '<option value="'+ data[i] +'"> ' + data[i] +' </option>';
                }
                StudentAPI.schoolCollegeListHS = _hs;
            },
            error: function () {
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
                alert("数据传输失败 ！");
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
                if (data === 1) {
                    alert("原密码不正确 !");
                } else if ( data === 2 ){
                    alert("新密码与原密码一致 !");
                } else {
                    alert("密码已经修改成功 !");
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
    initPersnalCourseInfo: function (path){
        if (path === undefined ? true : false) {
            path = [
                StudentAPI.Path.uInfo[3],
                StudentAPI.Path.uInfo[4],
                StudentAPI.Path.uInfo[5],
                null
            ];
            
        };
        
        //初始化 已选课程列的表树
        $.ajax({
            url: path[0],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (data) {
                StudentAPI.selectedCourseDS = data;
                StudentAPI.numOCourse = data.length;
            },
            error: function () {
                alert("数据[已选课程列的表树]传输失败 ！");
            }
        });
        
        //初始化 可选课程的列表树
        $.ajax({
            url: path[1],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (data) {
                StudentAPI.selectableCourseDS = data;
            },
            error: function () {
                alert("数据[可选课程的列表树]传输失败 ！");
            }
        });
        
        //初始化 待批准课程的列表树
        $.ajax({
            url: path[2],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (data) {
                StudentAPI.selectingCourseDS = data;
                StudentAPI.numICourse = data.length;
            },
            error: function () {
                alert("数据[待批准课程的列表树]传输失败 ！");
            }
        });
        
        //初始化 未批准课程的列表树
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
            getListHF:function (){
                var _o = StudentAPI.selectedCourseDS;
                var ListHS = '';
                for (var i = 0; i < _o.length; i++) {
                    if(i===0){
                        ListHS = ListHS
                                + '<li class="active"><a id="cid-' + _o[i].scid + '" herf="#null" data-toggle="tab" class="btn btn-flat " onclick="updataSelectedCourse(' + _o[i].scid + ')">'
                                + _o[i].course + '</a></li>';
                    } else {
                        ListHS = ListHS
                                + '<li><a id="cid-' + _o[i].scid + '" herf="#null" data-toggle="tab" class="btn btn-flat " onclick="updataSelectedCourse(' + _o[i].scid + ')">'
                                + _o[i].course + '</a></li>';
                    }
                }
                return ListHS;
            },
            getTableHF: function () {
                var _head = '<table class="table table-responsive" title="选课表">'
                        + '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 已选</th></tr></thead>',
                        _body = '',
                        _foot = '</table>',
                        _o = StudentAPI.selectedCourseDS;
                for (var i = 0; i < _o.length; i++) {

                    var hs = '<tr><td class="text-indianred text-blod">'
                            + (_o[i].course===undefined ?' ':_o[i].course) + '</td><td>'
                            + (_o[i].teacher===undefined ?' ':_o[i].teacher) + '</td><td>'
                            + (_o[i].ClassName===undefined ?' ':_o[i].ClassName) + '</td><td>'
                            + '<a href="javascript: void(0)"'
                            + 'id="cancel-' + _o[i].scid + '" '
                            + 'onclick="cancelCourse(' + _o[i].scid + ')">退选</a>'
                            + '</td></tr>';

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
            getTableHF: function () {
                var _head = '<table class="table table-responsive" title="选课表">'
                            +'<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 可选</th></tr></thead>',
                    _body = '',
                    _foot = '</table>',
                    _o=[],
                    _i=[],    //记录 当前课类节点对象
                    _x=[],    //记录 当前教师节点对象
                    _numO = 0,//记录 课类数量 
                    _numI = 0,//记录 每个课类下 教师数量 临时变量
                    _numX = 0,//记录 每个教师下 课程数量 临时变量
                    _sum = 0, //记录 所有课程总数
                    TableHS = '';


                _o = StudentAPI.selectableCourseDS;
                _numO = _o.length;

                for(var i=0; i<_numO; i++){
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
                                    _tmpHS = '<td rowspan="' + _numX + '">'
                                            + _i[j].text + '</td><td>'
                                            + _x[k].text + '</td><td><a onclick="selectCourse(' + _x[k].scid + ')" id="xscid-' + _x[k].scid + '">'
                                            + '选课</a></td></tr>';
                                } else {
                                    _tmpHS = _tmpHS
                                            + '<tr><td>'
                                            + _x[k].text + '</td><td><a onclick="selectCourse(' + _x[k].scid + ')" id="xscid-' + _x[k].scid + '">'
                                            + '选课</a></td></tr>';
                                }
                            }
                        } else {
                            for (var k = 0; k < _numX; k++) {
                                if (k === 0) {
                                    _tmpHS = _tmpHS
                                            + '<tr><td rowspan="' + _numX + '">'
                                            + _i[j].text + '</td><td>'
                                            + _x[k].text + '</td><td><a onclick="selectCourse(' + _x[k].scid + ')" id="xscid-' + _x[k].scid + '">'
                                            + '选课</a></td></tr>';
                                } else {
                                    _tmpHS = _tmpHS
                                            + '<tr><td>'
                                            + _x[k].text + '</td><td><a onclick="selectCourse(' + _x[k].scid + ')" id="xscid-' + _x[k].scid + '">'
                                            + '选课</a></td></tr>';
                                }
                            }
                        }

                        _sum += _numX;
                    }
                    _body += '<tbody id="cname-' +_o[i].text+ '"><tr><td class="text-indianred text-blod" rowspan="' + _tmpSum + '">' + _o[i].text + '</td>' + _tmpHS + '</tbody>';


                }
                TableHS = _head + _body + _foot;
                StudentAPI.numXCourse = _sum;
                return TableHS;

            }
        },
        
        selectingCourse:{
            getTableHF: function(){
                var _head = '<table class="table table-responsive" title="选课表">'
                            + '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 待确认</th></tr></thead>',
                    _body = '',
                    _foot = '</table>',
                    _o = StudentAPI.selectingCourseDS;
                for (var i = 0; i < _o.length; i++) {
                    
                    var hs = '<tr><td  class="text-indianred text-blod">' 
                            + _o[i].course + '</td><td>' 
                            + _o[i].teacher + '</td><td>' 
                            + _o[i].ClassName + '</td><td>' 
                            + '<a href="javascript: void(0)"' 
                                    +'id="cancel-'+ _o[i].scid +'" ' 
                                    +'onclick="cancelCourse('+ _o[i].scid +')">退选</a>' 
                            + '</td></tr>';
                    
                    _body += hs;
                    
                }
                return _head + _body + _foot;
            }
        },
        
        Resource: {
            getJSON: function(){
                var _root = StudentAPI.OCidIsCourse.resourceDS;
                if(_root === undefined || _root === null)return [];
                var _nodeI,
                    _nodeII,
                    _nodeIII,
                    _now=null,
                    JSON=[];
            
                for(var i=0; i< _root.length; i++){
                    
                    _nodeI = _root[i];
                    //初始化位置坐标
                    //console.log('i:' + i);
                    _now = JSON;
                    _now[i] = {
                        description:_nodeI.text,
                        position:[_nodeI.id,null,null],
                        resource:[],
                        nodes:[]
                    };
//                    _now[i].resource = StudentAPI.analyzeDS.Resource.getResourceArray(_now[i].position);
//                    console.log(_now[i].resource);
                    _now = _now[i].nodes;
                    for(var j=0; j< _nodeI.children.length; j++){
                        _nodeII =  _nodeI.children[j];
                        
                        //初始化位置坐标
                        //console.log('j:' + j);
                        _now[j] = {
                            description: _nodeII.text,
                            position: [_nodeI.id, _nodeII.id, null],
                            resource: [],
                            nodes:[]
                        };
//                        _now[j].resource = StudentAPI.analyzeDS.Resource.getResourceArray(_now[j].position);
                        _now = _now[j].nodes;
                        for(var k=0; k< _nodeII.children.length; k++){
                        _nodeIII =  _nodeII.children[k];
                        
                            //初始化位置坐标
                            //console.log('k:' + k);
                            _now[k] ={
                                description: _nodeIII.text,
                                position: [_nodeI.id, _nodeII.id, _nodeIII.id],
                                resource: []
                            };
//                            _now[k].resource = StudentAPI.analyzeDS.Resource.getResourceArray(_now[k].position);
                        }
                    }
                }
                return JSON;
            },
            
            getResourceArray: function(position){
                var dir = (position[0] === null ? '':('/' +position[0]))
                        + (position[1] === null ? '':('/' +position[1]))
                        + (position[2] === null ? '':('/' +position[2]));
                var path = StudentAPI.Path.cInfo[3] 
                        + '?scid=' + StudentAPI.OCidIsCourse.scid 
                        + '&dir=' + dir;
                var _o = StudentAPI.PostionIsResource;
                $.ajax({
                    url: path,
                    type: 'get',
                    async: false,
                    dataType: 'json',
                    success: function (data) {
                        _o = data;
                    },
                    error: function () {
                        $('#snackbar').snackbar({
                            alive: 10000,
                            content: StudentAPI.OCidIsCourse.courseName + '的课程'
                                    + '数据 [教学资源] 传输失败 ！ 可能老师并未编辑'
                                    + '<a data-dismiss="snackbar">我知道了</a>'
                        });
                    }
                });
                return _o;
            },
            
            getFileHS: function(nodes){
                var type,
                    postfix,
                    root,
                    dir,
                    previewPath,
                    playPath,
                    downloadPath,
                    hs='';
            
                
                
                for(var i=0; i< nodes.resource.length; i++){
                    
                    dir = (nodes.position[0] === null ? '' : ('/' + nodes.position[0]))
                        + (nodes.position[1] === null ? '' : ('/' + nodes.position[1]))
                        + (nodes.position[2] === null ? '' : ('/' + nodes.position[2]));
                
                    downloadPath = root +  dir + nodes.resource[i].description;
                    postfix = nodes.resource[i].value.match(/^(.*)(\.)(.{1,8})$/)[3].toLowerCase();
                    if(postfix === "doc" || postfix === "docx" || postfix === "pdf"){
                        type=-1;
                        hs += '<div class="file-wrapper" >'
                                + '<span class="icon icon-5x"></span><span class="file-name">'+ nodes.resource[i].description +'</span>'
                                + '<div class="file-btn-wrapper">'
                                + '<a href="<%=path%>/getswf?uri=+swftmp" class="btn"><span class="icon stage-card">preview</span></a>'
                                + '<a><span class="icon" href="">download</span></a></div></div>';
                    }else if(postfix === "mp4"){
                        type= 1;
                    }else{
                        type= 0;
                    }
                }
                
            },
            
            getFileManagerHF: function(){
                var _o = StudentAPI.analyzeDS.Resource.getJSON();
                if(_o===undefined || _o===null)return '暂无课件';
                var _now;
                var _hs='';
                
                _hsI = '<div class="tab-content tab-pane fade in active " id="folder-root">';
                for(var i=0; i<_o.length; i++){
                   _hsI += '<a data-toggle="tab" data-posi="'+ _o[i].position[0] 
                           +'" data-posii="null" data-posiii="null" data-type="folder" href="#nodes-' + _o[i].position[0]
                           +'"><span class="icon icon-5x" >folder</span><span class="folder-name">'+ _o[i].description +'</span></a>';//<span class="file-num">'+ (_o[i].nodes.length + _o[i].resource.length) +'</span>
                   
                    _hsII = '<div class="tab-content tab-pane fade " id="nodes-' + _o[i].position[0]+ '">'
                            + '<a data-toggle="tab" href="#folder-root"><span class="icon icon-5x" >folder</span><span class="folder-name">返回根目录</span></a>';
                    
                    _now = _o[i].nodes;
                    for(var j=0; j< _o[i].nodes.length; j++){
                        _hsII += '<a data-toggle="tab" data-posi="' + _now[j].position[0] + '" data-posii="' + _now[j].position[1] + '" data-posiii="null'
                                + '"data-type="folder" href="#nodes-' + _now[j].position[0] + _now[j].position[1]
                                + '"><span class="icon icon-5x" >folder</span><span class="folder-name">' + _now[j].description + '</span></a>'; 
                        
                        _hsIII = '<div class="tab-content tab-pane fade " id="nodes-' + _now[j].position[0] + _now[j].position[1] + '">' 
                                    + '<a data-toggle="tab" href="#nodes-' + _o[i].position[0]+'"><span class="icon icon-5x">folder</span><span class="folder-name">返回上一级</span></a>';
                        
//                        console.log(_now);
                        _now = _o[i].nodes[j].nodes;
                        for(var k=0; k< _now.length; k++){
                            
                            _hsIII += '<a data-toggle="tab" data-posi="' + _now[k].position[0] + '" data-posii="'+ _now[k].position[1] + '" data-posiii="'+ _now[k].position[2]
                                    + '"data-type="folder" href="#nodes-' + _now[k].position[0] + _now[k].position[1] + _now[k].position[2]
                                    + '"><span class="icon icon-5x">folder</span><span class="folder-name">' + _now[k].description + '</span></a>';
                            _hsFile = '<div class="tab-content tab-pane fade " id="nodes-' + _now[j].position[0] + _now[j].position[1] +  _now[k].position[2] +'">'
                                    + '<a data-toggle="tab" href="#nodes-' +  _now[j].position[0] + _now[j].position[1]+ '"><span class="icon icon-5x" >folder</span><span class="folder-name">返回上一级</sapn></a></div>';
                            _hs += _hsFile;
                        }
                        _hsIII += '</div>';
                        _hs += _hsIII;
                    }
                    _hsII += '</div>';
                    _hs += _hsII;
                   
                }
                _hsI += '</div>';
                _hs += _hsI;
                
//                alert(_hs);
                return _hs;
            }
        },
        
        Homework: function(){
            
        }
    },
    structureCidIsCourse: function(scid, is, path){
        var _o = StudentAPI.OCidIsCourse;
        var _x = StudentAPI.XCidIsCourse;
        var pathSummary,
            pathResource,
            pathHomework;
        if (path === undefined ? true : false) {
            pathSummary = StudentAPI.Path.cInfo[0] + "?scid=" + scid;
            pathResource = StudentAPI.Path.cInfo[1] + "?scid=" + scid;
            pathHomework = StudentAPI.Path.cInfo[2] + "?scid=" + scid;
        };
        if (is === true){
            $.ajax({
                url: pathSummary,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _x.courseName = data[0].courseName;
                    _x.teacherName = data[1].teacherName;
                    _x.teacherSn = data[2].teacherSn;
                    _x.introduction = data[4].introduction === null? '暂无介绍':data[4].introduction;
                    _x.syllabus = data[3].syllabus === null? '暂无介绍':data[3].syllabus;
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
                    _o.introduction = data[4].introduction === null? '暂无介绍':data[4].introduction;
                    _o.syllabus = data[3].syllabus === null? '暂无介绍':data[3].syllabus;
                    _o.attachment = data[5].swf_syllabus;

                    _o.resourceDS = null;
                    _o.homework = null;
                },
                error: function () {
                    alert("数据传输失败 ！");
                }
            });
            $.ajax({
                url: pathResource,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _o.resourceDS = data;
                },
                error: function () {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content:StudentAPI.OCidIsCourse.courseName + '的课程'
                                +'数据 [教学资源] 传输失败 ！ 可能老师并未编辑'
                                +'<a data-dismiss="snackbar">我知道了</a>'
                    });
                }
            });
            $.ajax({
                url: pathHomework,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _o.homework = data;
                },
                error: function () {
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
        add: function(scid, path){
            var status = StudentAPI.courseStatus;
            if(path === undefined ? true : false){
                //alert("path === undefined");
                path = StudentAPI.Path.cOperate[0] + "?scid=" + scid;
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
        quit: function(scid, path){
            var status = StudentAPI.courseStatus;
            if(path === undefined ? true : false){
                path = StudentAPI.Path.cOperate[2] + "?scid=" + scid;
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
        cancel: function(scid, path){
            var status = StudentAPI.courseStatus;
            if(path === undefined ? true : false){
                path = StudentAPI.Path.cOperate[1] + "?scid=" + scid;
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
    operateHomework: {
        openEditor: function(scid){
            
        },
        closeEditor: function (scid) {

        },
        upload: function(scid){
            
        },
        download: function(scid){
            
        },
        delete: function(scid){
            
        }
    },
    operateResource: {
        load: function(){
            
        },
        downloadIt: function(){
            
        },
        downloadItBatch: function(){
            
        }
        
        
    },
    fn: {
        getIdByDomId: function(prefix, domId){
            var id;
            return id;
        }
    }
    
};

//定义全局变量

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

/**
 * 长度为二的对象数组 全局变量 (且唯一)
 * <br>ThisCourse<b>[0]</b>:存储一个<b> 已 </b>选课程的实例
 * <br>ThisCourse<b>[1]</b>:存储一个<b> 待 </b>选课程的实例
 * @type Array
 */
var ThisCourse = [
    
    {
        scid: 0
    },
    
    {
        scid: 1
    }
];

var OCourse;
var XCourse;
var schoolYearsList;
var collegeList;
//定义初始化函数
function initPage() {
    
    //Step 初始化 相关基础参数
    StudentAPI.initPersonalInfo();if(StudentAPI.sex === true){$('#boy').attr("checked","checked");}else {$('#girl').attr("checked","checked");}
    StudentAPI.initPersnalCourseInfo();
    if(StudentAPI.selectedCourseDS[0] !== undefined ){
        ThisCourse[0].scid = StudentAPI.selectedCourseDS[0].scid;//获得已选课程的第一个,加以初始化
        ThisCourse[0] = StudentAPI.structureCidIsCourse(ThisCourse[0].scid);    
    }else{
        ThisCourse[0] = StudentAPI.WhippingBoy;
    }
    
    //Step 绑定 相关基础参数

    ThisCourse[0].__proto__ = new Vue({
        el: '#ucontent',
        data: {
            introduction: ThisCourse[0].introduction,
            syllabus: ThisCourse[0].syllabus + ThisCourse[0].attachment,
            courseliset: StudentAPI.analyzeDS.selectedCourse.getListHF(),
            resource: StudentAPI.analyzeDS.Resource.getFileManagerHF()
        }
    });

//    ThisCourse[1].__proto__ = new Vue({
//        el: '#',
//        data: {
//            introduction: ThisCourse[1].introduction,
//            syllabus: ThisCourse[1].syllabus
//        }
//    });
    

    UProfile = new Vue({
        el: "#tab-personalInfo",
        data: {
            id: StudentAPI.id,
            sn: StudentAPI.sn,
            name: StudentAPI.name,
            ID: StudentAPI.ID,
            grade: StudentAPI.grade,
            schoolYearsList: StudentAPI.schoolYearsListHS,
            college: StudentAPI.college,
            schoolCollegeList:StudentAPI.schoolCollegeListHS,
            tel: StudentAPI.tel,
            qq: StudentAPI.qq,
            pw: StudentAPI.pw,
            sex: StudentAPI.sex
        }
    });
    USetting = new Vue({
        el: '#usettings',
        data: {
            XCourseTableHF: StudentAPI.analyzeDS.selectableCourse.getTableHF(),
            ICourseTableHF: StudentAPI.analyzeDS.selectingCourse.getTableHF(),
            OCourseTableHF: StudentAPI.analyzeDS.selectedCourse.getTableHF()
        }
    });  
    UPanel = new Vue({
        el: "#ubox",
        data: {
            sn: StudentAPI.sn,
            name: StudentAPI.name,
            portrait: StudentAPI.name.toString()[0],
            grade: StudentAPI.grade,
            college: StudentAPI.college,
            qq: StudentAPI.qq,
            numOCourse: StudentAPI.numOCourse,
            numICourse: StudentAPI.numICourse,
            numXCourse: StudentAPI.numXCourse
        }
    });
};

//定义更新函数(包装函数)
function updataSelectedCourse(scid){
    ThisCourse[0].scid = scid;
    ThisCourse[0] = StudentAPI.structureCidIsCourse(ThisCourse[0].scid);
    ThisCourse[0].$data.introduction=ThisCourse[0].introduction;
    ThisCourse[0].$data.syllabus= ThisCourse[0].syllabus + ThisCourse[0].attachment;
    ThisCourse[0].$data.resource = StudentAPI.analyzeDS.Resource.getFileManagerHF();
};
function updataSelectableCourse(scid){
    ThisCourse[1].scid = scid;
    ThisCourse[1] = StudentAPI.structureCidIsCourse(ThisCourse[1].scid);
    OCourse.$data.introduction = ThisCourse[1].introduction;
    OCourse.$data.syllabus = ThisCourse[1].syllabus + ThisCourse[1].attachment;
    console.log(ThisCourse[1]);
};
function updataPersonalInfo(){
    var name = $('#name').val();
    var ID = $('#ID').val();
    var grade = $('#grade').val();
    var college = $('#college').val();
    var sex = $('#boy').is(":checked") ? '男' : '女';
    
    var tel = $('#tel').val();
    var qq = $('#qq').val();
    StudentAPI.updatePersonalInfo(StudentAPI.Path.uInfo[1] 
            +"?name=" + name 
            +"&idcard=" + ID 
            +"&grade=" + grade 
            +"&college=" + college 
            +"&sex=" + sex 
            +"&telnum=" + tel 
            +"&qqnum=" + qq);
};
function updataPassword(){
    StudentAPI.updatePassword(StudentAPI.Path.uInfo[2]
            +"?pw=" + hex_md5($("#oldPassword").val()) 
            +"&repw=" + hex_md5($("#newPassword").val()));
};
function updataThisCourse1cid(scid){
    ThisCourse[1].scid = scid;
};
function updataThisCourse0cid(scid){
    ThisCourse[0].scid = scid;
};
function updataUPanel(method){
    switch (method){
        case 0:{
            StudentAPI.initPersonalInfo();
            UPanel.$data.sn = StudentAPI.sn;
            UPanel.$data.name = StudentAPI.name;
            UPanel.$data.portrait = StudentAPI.name.toString()[0];
            UPanel.$data.grade = StudentAPI.grade;
            UPanel.$data.college = StudentAPI.college;
            UPanel.$data.qq = StudentAPI.qq;
            break;
        };
        case 1:{
                
            StudentAPI.initPersnalCourseInfo();
            UPanel.$data.numOCourse = StudentAPI.numOCourse;
            UPanel.$data.numICourse = StudentAPI.numICourse;
            UPanel.$data.numXCourse = StudentAPI.numXCourse;
            break;
        };
        default :{
            StudentAPI.initPersonalInfo();
            StudentAPI.initPersnalCourseInfo();
            UPanel.$data.sn = StudentAPI.sn;
            UPanel.$data.name = StudentAPI.name;
            UPanel.$data.portrait = StudentAPI.name.toString()[0];
            UPanel.$data.grade = StudentAPI.grade;
            UPanel.$data.college = StudentAPI.college;
            UPanel.$data.qq = StudentAPI.qq;
            UPanel.$data.numOCourse = StudentAPI.numOCourse;
            UPanel.$data.numICourse = StudentAPI.numICourse;
            UPanel.$data.numXCourse = StudentAPI.numXCourse;
            break;
        };
        
    }
}
function selectCourse(scid){
    var status = StudentAPI.operateCidIsCourse.add(scid);
    if(status === true){
        StudentAPI.initPersnalCourseInfo();
        USetting.$data.ICourseTableHF = StudentAPI.analyzeDS.selectingCourse.getTableHF();
        UPanel.$data.numICourse = StudentAPI.numICourse;
        $('#snackbar').snackbar({
            alive: 10000,
            content: '选课申请已提交, 等待老师批准 '+ '<a data-dismiss="snackbar">我知道了</a>'
        });
    }else{
        
        $('#snackbar').snackbar({
            alive: 10000,
            content: '选课申请提交 失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
};
function quitCourse(scid){
    var status = StudentAPI.operateCidIsCourse.quit(scid);
    if(status === true){
        StudentAPI.initPersnalCourseInfo();
        USetting.$data.OCourseTableHF = StudentAPI.analyzeDS.selectedCourse.getTableHF();
        UPanel.$data.numOCourse = StudentAPI.numOCourse;
        $('#snackbar').snackbar({
            alive: 10000,
            content: '已经退选课程'+ '<a data-dismiss="snackbar">我知道了</a>'
        });
    }else{
        
        $('#snackbar').snackbar({
            alive: 10000,
            content: '退选失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
};
function cancelCourse(scid){
    var status = StudentAPI.operateCidIsCourse.cancel(scid);
    if(status === true){
        StudentAPI.initPersnalCourseInfo();
        USetting.$data.ICourseTableHF =  StudentAPI.analyzeDS.selectingCourse.getTableHF();
        UPanel.$data.numICourse = StudentAPI.numICourse;
        $('#snackbar').snackbar({
            alive: 10000,
            content: '已经取消选课'+ '<a data-dismiss="snackbar">我知道了</a>'
        });
    }else{
        
        $('#snackbar').snackbar({
            alive: 10000,
            content: '取消失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }
}
// 执行!
initPage();