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
    attachmentListDS:[],
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
        resourceDS:{
            dir:'',
            json:null
        },
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
         * <br>cInfo[3] 用于文件地1预览和播放 
         * <br>cInfo[4] 返回某个课程的资源根地址 
         * <br>cInfo[5] 返回某个作业的详情 
         * 
         * @type Array 
         */
        cInfo :[
            
            "student/stu_course",           //[0]  
            "student/kcgs",                 //[1]  
            "student/stu_course_homework",  //[2] 
            "student/courdir",              //[3]
            "student/resourcedir",          //[4]
            "student/dohomework"            //[5]
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
            getListHS:function (){
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
            getTableHS: function () {
                var _head = '<table class="table table-responsive" title="选课表">'
                        + '<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态: 已选</th></tr></thead>',
                        _body = '',
                        _foot = '</table>',
                        _o = StudentAPI.selectedCourseDS;
                for (var i = 0; i < _o.length; i++) {

                    var hs = '<tbody><tr><td class="text-indianred text-blod">'
                            + (_o[i].course===undefined ?' ':_o[i].course) + '</td><td>'
                            + (_o[i].teacher===undefined ?' ':_o[i].teacher) + '</td><td>'
                            + (_o[i].ClassName===undefined ?' ':_o[i].ClassName) + '</td><td>'
                            + '<a href="javascript: void(0)"'
                            + 'id="cancel-' + _o[i].scid + '" '
                            + 'onclick="cancelCourse(' + _o[i].scid + ')">退选</a>'
                            + '</td></tr></tbody>';

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
            getTableHS: function(){
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
                var _root = StudentAPI.OCidIsCourse.resourceDS.json;
                
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
                    if(_nodeI.resource !== undefined){
                        _now[i].resource = _nodeI.resource;
                    }
//                    _now[i].resource = StudentAPI.analyzeDS.Resource.getResourceArray(_now[i].position);
//                    console.log(_now[i].resource);
                    _now = _now[i].nodes;
                    if (_nodeI.children === undefined) continue;
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
                        if (_nodeII.resource !== undefined) {
                            _now[j].resource = _nodeII.resource;
                        }
//                        _now[j].resource = StudentAPI.analyzeDS.Resource.getResourceArray(_now[j].position);
                        _now = _now[j].nodes;
                        if(_nodeII.children === undefined) continue;
                        for(var k=0; k< _nodeII.children.length; k++){
                        _nodeIII =  _nodeII.children[k];
                        
                            //初始化位置坐标
                            //console.log('k:' + k);
                            _now[k] ={
                                description: _nodeIII.text,
                                position: [_nodeI.id, _nodeII.id, _nodeIII.id],
                                resource: []
                            };
                            
                            if (_nodeIII.resource !== undefined) {
                                _now[k].resource = _nodeIII.resource;
                            }
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
                var name='',
                    size=0,
                    status=0,
                    previewPath='',
                    playPath='',
                    downloadPath='';
            
                var hs='<hr>';
                if(nodes === undefined) return '';
                var _head = '<table class="table table-responsive table-filelist">'
                            + '<thead><tr><th>文件名</th><th>大小</th><th>下载</th><th>其它</th></tr></thead>',
                    _foot = '</table>';
                if(nodes.length===0){
                    return hs + _head + '<tr><td colspan="4">暂无资源</td></tr>' + _foot;
                }    
                for(var i=0; i< nodes.length; i++){
                    
                    name = nodes[i].name;
                    size = nodes[i].size;
                    size = (size/1000000 > 1 ? toDecimal2(size/1000000)+'MB':toDecimal2(size/1000)+'KB');
                    status = nodes[i].handle.status;
                    downloadPath = "file/"+ StudentAPI.OCidIsCourse.resourceDS.dir + nodes[i].handle.downloadDir;
//                    alert(downloadPath);
                    previewPath = ''+ StudentAPI.OCidIsCourse.resourceDS.dir + nodes[i].handle.previewDir;
                    if(status === -1){
                        hs += '<tr><td  class="text-indianred text-blod">' 
                            + name + '</td><td>' 
                            + size + '</td><td>' 
                            + '<a class="btn btn-flat btn-brand" href="'+ downloadPath +'">下载</a>' + '</td><td>' 
                            + '<a class="btn btn-flat btn-red stage-card" href="http://localhost:8084/lms/getswf?uri='+ previewPath +'">预览</a>' 
                            + '</td></tr>';
                    
                    }else if(status === 1){
                        
                        hs += '<tr><td  class="text-indianred text-blod">'
                                + name + '</td><td>'
                                + size + '</td><td>'
                                + '<a class="btn btn-flat btn-brand" href="' + downloadPath + '">下载</a>' + '</td><td>'
                                + '<a class="btn btn-flat btn-red stage-card" href="http://localhost:8084/lms/getvideo?uri=' + downloadPath + '">播放</a>'
                                + '</td></tr>';
                        
                    }else{
                        
                        hs += '<tr><td  class="text-indianred text-blod">'
                                + name + '</td><td>'
                                + size + '</td><td>'
                                + '<a class="btn btn-flat btn-brand" href="' + downloadPath + '">下载</a>' + '</td><td>'
                                + '-'
                                + '</td></tr>';
                    }
                }
                return _head + hs + _foot;
            },
            
            getFileManagerHS: function(){
                var _o = StudentAPI.analyzeDS.Resource.getJSON();
                if(_o===undefined || _o===null) return '暂无课件';
                var _now;
                var _hs='',
                    _hsI='',
                    _hsII='',
                    _hsIII='',
                    _hsFile='';
                
                _hsI = '<div class="tab-content tab-pane fade in active " id="folder-root">';
                for(var i=0; i<_o.length; i++){
                    _hsI += '<a data-toggle="tab" data-posi="'+ _o[i].position[0] 
                           +'" data-posii="null" data-posiii="null" data-type="folder" href="#nodes-' + _o[i].position[0]
                           +'"><span class="icon icon-5x" >folder</span><span class="folder-name">'+ _o[i].description +'</span><span class="file-num">'+ (_o[i].nodes.length + _o[i].resource.length) +' 项</span></a>';//<span class="file-num">'+ (_o[i].nodes.length + _o[i].resource.length) +'</span>
                    
                   
                    _hsII = '<div class="tab-content tab-pane fade " id="nodes-' + _o[i].position[0]+ '">'
                            + '<a data-toggle="tab" href="#folder-root"><span class="icon icon-5x" >folder</span><span class="folder-name">返回根目录</span><span class="file-num">...</span></a>';
                    
                    _now = _o[i].nodes;
                    for(var j=0; j< _o[i].nodes.length; j++){
                        _hsII += '<a data-toggle="tab" data-posi="' + _now[j].position[0] + '" data-posii="' + _now[j].position[1] + '" data-posiii="null'
                                + '"data-type="folder" href="#nodes-' + _now[j].position[0] + _now[j].position[1]
                                + '"><span class="icon icon-5x" >folder</span><span class="folder-name">' + _now[j].description + '</span><span class="file-num">'+ (_o[i].nodes[j].nodes.length + _now[j].resource.length) +' 项</span></a>'; 
                        
                        
                        _hsIII = '<div class="tab-content tab-pane fade " id="nodes-' + _now[j].position[0] + _now[j].position[1] + '">' 
                                    + '<a data-toggle="tab" href="#folder-root"><span class="icon icon-5x" >folder</span><span class="folder-name">返回根目录</span><span class="file-num">...</span></a><a data-toggle="tab" href="#nodes-' + _o[i].position[0]+'"><span class="icon icon-5x">folder</span><span class="folder-name">返回上一级</span><span class="file-num">...</span></a>';
                        
//                        console.log(_now);
                        _now = _o[i].nodes[j].nodes;
                        for(var k=0; k< _now.length; k++){
                            
                            _hsIII += '<a data-toggle="tab" data-posi="' + _now[k].position[0] + '" data-posii="'+ _now[k].position[1] + '" data-posiii="'+ _now[k].position[2]
                                    + '"data-type="folder" href="#nodes-' + _now[k].position[0] + _now[k].position[1] + _now[k].position[2]
                                    + '"><span class="icon icon-5x">folder</span><span class="folder-name">' + _now[k].description + '</span><span class="file-num">'+ (_now[k].resource.length) +' 项</span></a>';
                            
                            
                            _hsFile = '<div class="tab-content tab-pane fade " id="nodes-' + _now[j].position[0] + _now[j].position[1] +  _now[k].position[2] +'">'
                                    + '<a data-toggle="tab" href="#folder-root"><span class="icon icon-5x" >folder</span><span class="folder-name">返回根目录</span><span class="file-num">...</span></a><a data-toggle="tab" href="#nodes-' +  _now[j].position[0] + _now[j].position[1]+ '"><span class="icon icon-5x" >folder</span><span class="folder-name">返回上一级</span><span class="file-num">...</span></a>';
                            
                            
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
            getJSON: function(data, scid){
                
                var _o=[];
                var _i=[];
                var _x=[];
                var _deadline = false;
                
                for(var i=0; i<data.length; i++){
                    var xtime = new Date(data[i].deadline);
                    var detail;
                    $.ajax({
                        url: StudentAPI.Path.cInfo[5] + '?scid=' + scid + '&homeworkid=' + data[i].homeworkid,
                        type: 'get',
                        async: false,
                        dataType: 'json',
                        success: function (data) {
                            detail = data;
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
                    if ((xtime - new Date())>0){
                        _deadline = true;
                    }else{
                        _deadline = false;
                    }
                    if (data[i].status==="未提交"&&_deadline){
                        _i.push(data[i]);
                        _i[i].attachment = detail.Myattachment;
                        _i[i].detail = detail.Hwhelp;
                        
                    }else if(data[i].status==="已提交"){
                        _o.push(data[i]);
                        _o[i].attachment = detail.Myattachment;
                        _o[i].detail = detail.Hwhelp;
                    }else{
                        _x.push(data[i]);
                    }
                }
                
                var obj={
                    o:_o,
                    i:_i,
                    x:_x
                };
                
                return obj;
            },
            //<div class="card"><div class="card-main"><div class="card-action"><div class="card-action-btn btn btn-flat pull-left homework-name">作业</div>
            //
            //
            //
            //            <a class="card-action-btn btn btn-flat pull-right"><span><span class="icon avatar avatar-sm">cloud_upload</span></span></a>
            //            <a class="card-action-btn btn btn-flat pull-right"><span><span class="icon avatar avatar-sm">attachment</span></span></a>
            //            <a class="collapse card-action-btn btn btn-flat pull-right" data-toggle="collapse" href="#collapse-homework-id"><span><span class="icon avatar avatar-sm">edit</span></span></a>
            //
            //        </div>
            //
            //        <div class="card-inner"><title class="btn btn-flat text-blod text-indianred">作业要求</title><p class="homework-info"></p>
            //
            //            <title class="btn btn-flat text-blod text-indianred">截止日期:</title><p class="homework-info"></p></div>
            //
            //        <div class="card-inner collapsible-region collapse" id="collapse-homework-id"> <div id="demo" class="editor-area"></div></div>
            //
            //        <div class="card-action"><div class="card-action-btn btn btn-flat attachment-list"><span class="icon">attachment</span> 附件列表</div></div></div></div>
            getDoneHS: function(){
                var _o = StudentAPI.OCidIsCourse.homeworkDS.o;
                if(_o.length===0) return '<p>暂无已提交作业<p>';
                var hs = '';
                for (var i = 0; i < _o.length; i++) {
                    hs += '<div class="card"><div class="card-main"><div class="card-action"><div class="card-action-btn btn btn-flat pull-left homework-name">' + _o[i].title + '</div>'
                            + '<a class="card-action-btn btn btn-flat pull-right" onclick="submitHomework('+ _o[i].homeworkid +')"><span><span class="icon avatar avatar-sm">cloud_upload</span></span></a>'
                            + '<a title="" class="btn btn-flat btn-upload pull-right" onclick="updataByThisHid('+ _o[i].homeworkid +')" href="#modal-uploadify" data-toggle="modal" id="btn-upload-'+ _o[i].homeworkid +'"><span><span class="icon avatar avatar-sm">attachment</span></span></a>'
                            + '<a class="collapse card-action-btn btn btn-flat pull-right" data-toggle="collapse" href="#collapse-homework-'+ _o[i].homeworkid +'"><span><span class="icon avatar avatar-sm">edit</span></span></a>'
                            + '</div><div class="card-inner"><title class="btn btn-flat text-blod text-indianred">作业要求</title><p class="homework-info">'+_o[i].detail+'</p>'
                            + '<title class="btn btn-flat text-blod text-indianred">截止日期:</title><p class="homework-info">'+ _o[i].deadline +'</p></div>'
                            + '<div class="card-inner collapsible-region collapse" id="collapse-homework-'+ _o[i].homeworkid +'"> <div id="editor-'+ _o[i].homeworkid +'" class="editor-area"></div></div>'
                            + '<div class="card-action"><div class="card-action-btn btn btn-flat attachment-list"><span class="icon">attachment</span> 附件列表</div></div></div></div>';
                }
                return hs;
            },
            getDoingHS: function(){
                var _i = StudentAPI.OCidIsCourse.homeworkDS.i;
                if(_i.length===0) return '<p>暂无需提交作业<p>';
                var hs = '';
                for (var i = 0; i < _i.length; i++) {
                    hs += '<div class="card"><div class="card-main"><div class="card-action"><div class="card-action-btn btn btn-flat pull-left homework-name">' + _i[i].title + '</div>'
                            + '<a title="提交作业" class="btn-submit btn btn-flat pull-right" onclick="submitHomework('+ _i[i].homeworkid +')"><span><span class="icon avatar avatar-sm">cloud_upload</span></span></a>'
                            + '<a title="附件" class="btn-upload btn btn-flat pull-right" onclick="updataByThisHid('+ _i[i].homeworkid +')" href="#modal-uploadify" data-toggle="modal" id="btn-upload-'+ _i[i].homeworkid +'"><span><span class="icon avatar avatar-sm">attachment</span></span></a>'
                            + '<a title="编辑" class="btn-edit collapse btn btn-flat pull-right" data-toggle="collapse" href="#collapse-homework-'+ _i[i].homeworkid +'"><span><span class="icon avatar avatar-sm">edit</span></span></a>'
                            + '</div><div class="card-inner"><title class="btn btn-flat text-blod text-indianred">作业要求</title><p class="homework-info">'+_i[i].detail+'</p>'
                            + '<title class="btn btn-flat text-blod text-indianred">截止日期:</title><p class="homework-info">'+ _i[i].deadline +'</p></div>'
                            + '<div class="card-inner collapsible-region collapse" id="collapse-homework-'+ _i[i].homeworkid +'"> <div id="editor-'+ _i[i].homeworkid +'" class="editor-area"></div></div>'
                            + '<div class="card-action"><div class="card-action-btn btn btn-flat attachment-list"><span class="icon">attachment</span> 附件列表</div></div></div></div>';
                }
                return hs;
            },
            
            getMissHS: function(){
                var _x = StudentAPI.OCidIsCourse.homeworkDS.x;
                if(_x.length===0) return '<p>暂无过期作业<p>';
            }
            
        }
    },
    structureCidIsCourse: function(scid, is, path){
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
                        content:StudentAPI.OCidIsCourse.courseName + '的课程'
                                +'数据 [教学资源] 传输失败 ！ 可能老师并未编辑'
                                +'<a data-dismiss="snackbar">我知道了</a>'
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
                    //console.log(data);
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
                    _o.homeworkDS = StudentAPI.analyzeDS.Homework.getJSON(data, scid);
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
        downloadAttachment: function (scid, homeworkid, src) {
            $.ajax({
                type: "post",
                url: StudentAPI.Path.fOperate[1]+'?scid='+scid+'&homeworkid='+homeworkid+'&src='+src,
                success: function () {},
                error: function () {alert("出现错误! 作业已过期或文件不存在");}
            });
        },

        deleteAttachment: function (scid, homeworkid, src) {
            $.ajax({
                type: "GET",
                url: StudentAPI.Path.fOperate[0]+'?scid='+scid+'&homeworkid='+homeworkid+'&src='+src,
                success: function (data) {

                    if (data === "ok") {
                        $('#snackbar').snackbar({
                            alive: 10000,
                            content: '作业附件删除成功 <a data-dismiss="snackbar">我知道了</a>'
                        });
                        updataAttachmentArea();
                    } else {
                        alert("作业附件删除失败！ 可能原因：作业已过期或文件不存在");
                    }

                },
                error: function () {
                    alert("未知错误");
                }
            });
        },
        
        uploadAttachment: function(scid, homeworkid){
            $('#uploadify').uploadify("settings", "formData", {'scid':scid, 'homeworkid': homeworkid});
            $('#uploadify').uploadify('upload', '*');
        },
        getAttachmentList: function(scid, homeworkid){
            $.ajax({
                url: StudentAPI.Path.fOperate[2] + '?scid=' + scid + '&homeworkid=' + homeworkid,
                type: 'GET',
                cache: false,
                async: false,
                success: function (data) {
                    StudentAPI.attachmentListDS = data;
                },
                error: function () {
                    alert("未知错误");
                }
            });
            return true;
        },
        submit: function(scid, homeworkid, hs){
            $.ajax({
                url: StudentAPI.Path.fOperate[3] + '?scid='+ scid +'&homeworkid='+ homeworkid,
                type: 'POST',
                data: {HwEitor: hs},
                cache: false,
                success: function (status) {
                    if (status === "1") {
                        $('#snackbar').snackbar({
                            alive: 10000,
                            content:'作业提交成功 <a data-dismiss="snackbar">我知道了</a>'
                        });
                        console.log(status);
                    } else {
                        console.log(status);
                        alert("作业提交失败！ 可能原因：作业已不存在");
                    }

                },
                error: function () {
                    alert("未知错误");
                }
            });
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
    fn: {}
    
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
        scid: 0,
        hid: 0,
        obj: {}
    },
    
    {
        scid: 1,
        obj: {}
    }
];
var HidIsAttachmentHS='';
var OCourse;
var XCourse;
//定义初始化函数
function initPage() {
    
    //Step 初始化 相关基础参数
    StudentAPI.initPersonalInfo();if(StudentAPI.sex === true){$('#boy').attr("checked","checked");}else {$('#girl').attr("checked","checked");}
    StudentAPI.initPersnalCourseInfo();
    if(StudentAPI.selectedCourseDS[0] !== undefined ){
        var scid = StudentAPI.selectedCourseDS[0].scid;
        ThisCourse[0].obj = StudentAPI.structureCidIsCourse(scid);    
        ThisCourse[0].scid = scid;//获得已选课程的第一个,加以初始化
    }else{
        ThisCourse[0] = StudentAPI.WhippingBoy;
    }
    
    //Step 绑定 相关基础参数

    ThisCourse[0].obj.__proto__ = new Vue({
        el: '#ucontent',
        data: {
            introduction: ThisCourse[0].obj.introduction,
            syllabus: ThisCourse[0].obj.syllabus + ThisCourse[0].obj.attachment,
            courseliset: StudentAPI.analyzeDS.selectedCourse.getListHS(),
            resource: StudentAPI.analyzeDS.Resource.getFileManagerHS(),
            OHomeworkHS:StudentAPI.analyzeDS.Homework.getDoneHS(),
            IHomeworkHS:StudentAPI.analyzeDS.Homework.getDoingHS(),
            XHomeworkHS:StudentAPI.analyzeDS.Homework.getMissHS()
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
            XCourseTableHS: StudentAPI.analyzeDS.selectableCourse.getTableHS(),
            ICourseTableHS: StudentAPI.analyzeDS.selectingCourse.getTableHS(),
            OCourseTableHS: StudentAPI.analyzeDS.selectedCourse.getTableHS()
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
    ThisCourse[0].obj = StudentAPI.structureCidIsCourse(ThisCourse[0].scid);
    ThisCourse[0].obj.$data.introduction=ThisCourse[0].obj.introduction;
    ThisCourse[0].obj.$data.syllabus= ThisCourse[0].obj.syllabus + ThisCourse[0].obj.attachment;
    ThisCourse[0].obj.$data.resource = StudentAPI.analyzeDS.Resource.getFileManagerHS();
};
function updataSelectableCourse(scid){
    ThisCourse[1].scid = scid;
    ThisCourse[1] = StudentAPI.structureCidIsCourse(ThisCourse[1].scid);
    OCourse.$data.introduction = ThisCourse[1].introduction;
    OCourse.$data.syllabus = ThisCourse[1].syllabus + ThisCourse[1].attachment;
    //console.log(ThisCourse[1]);
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
        USetting.$data.ICourseTableHS = StudentAPI.analyzeDS.selectingCourse.getTableHS();
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
        USetting.$data.OCourseTableHS = StudentAPI.analyzeDS.selectedCourse.getTableHS();
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
        USetting.$data.ICourseTableHS =  StudentAPI.analyzeDS.selectingCourse.getTableHS();
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
function submitHomework(hid){
    hs = tinymce.get('editor-'+hid).getContent({format: 'raw'});
    StudentAPI.operateHomework.submit(ThisCourse[0].scid, hid, hs);
}
function uploadAttachment(){
    StudentAPI.operateHomework.uploadAttachment(ThisCourse[0].scid, ThisCourse[0].hid);
}
function downloadAttachment(src){
    StudentAPI.operateHomework.downloadAttachment(ThisCourse[0].scid, ThisCourse[0].hid, src);
}
function updataHid(hid){
    ThisCourse[0].hid = hid;
}
function updataByThisHid(hid){
    ThisCourse[0].hid = hid;
    $('#uploaded-area').hide();
    if(StudentAPI.operateHomework.getAttachmentList(ThisCourse[0].scid,ThisCourse[0].hid)){
        var _list = StudentAPI.attachmentListDS;
        var _src;
        HidIsAttachmentHS ='<table class="table table-bordered"><thead><tr><th>附件名</th><th>下载</th><th>删除</th></tr></thead>';
        for(var i=0; i<_list.length; i++){
            _src = _list[i];
            HidIsAttachmentHS+= '<tbody><tr><td><span class="text-indianred">'+ _src +'</span></td>'
                    +'<td><a class="btn-brand btn-flat" href="'+ StudentAPI.Path.fOperate[1]+'?scid='+ThisCourse[0].scid+'&homeworkid='+ThisCourse[0].hid+'&src='+ _src +'" class="">下载</a></td>'
                    +'<td><a class="btn-default btn-flat" onclick="deleteAttachment(\''+_src+'\')" class="">删除</a></td></tr></tbody>';
        }
        HidIsAttachmentHS+='</table>';
        console.log(_list);
        $('#uploaded-area').empty();
        $('#uploaded-area').append(HidIsAttachmentHS);
        $('#uploaded-area').fadeIn();
    }
}
function refreshUploadedArea(){
    $('#uploaded-area').hide();
    if(StudentAPI.operateHomework.getAttachmentList(ThisCourse[0].scid,ThisCourse[0].hid)){
        var _list = StudentAPI.attachmentListDS;
        var _src;
        HidIsAttachmentHS ='<table class="table"><thead><tr><td>附件名</td><td>下载</td><td>删除</td></tr><thead>';
        for(var i=0; i<_list.length; i++){
            _src = _list[i];
            HidIsAttachmentHS+= '<tbody><tr><td><span class="text-indianred">'+ _src +'</span></td>'
                    +'<td><a href="'+ StudentAPI.Path.fOperate[1]+'?scid='+ThisCourse[0].scid+'&homeworkid='+ThisCourse[0].hid+'&src='+ _src +'" class="">下载</a></td>'
                    +'<td><a onclick="deleteAttachment(\''+_src+'\')" class="">删除</a></td></tr><tbody>';
        }
        HidIsAttachmentHS+='</table>';
        console.log(_list);
        $('#uploaded-area').empty();
        $('#uploaded-area').append(HidIsAttachmentHS);
        $('#uploaded-area').fadeIn();
    }
}
$('#uploadify-o').click(function(){
    $('#uploadify').uploadify("settings", "formData", {'scid':ThisCourse[0].scid, 'homeworkid':ThisCourse[0].hid});
    $('#uploadify').uploadify('upload', '*');
    console.log('#btn-upload-'+ThisCourse[0].hid);
});
$('#uploadify-s').click(function(){
    $('#uploadify').uploadify('stop', '*');
});
$('#uploadify-c').click(function(){
    $('#uploadify').uploadify('cancel', '*');
});
function deleteAttachment(src){
    StudentAPI.operateHomework.deleteAttachment(ThisCourse[0].scid,ThisCourse[0].hid, src);$('#uploaded-area').hide();
    refreshUploadedArea()
}
function downloadAttachment(src){
    StudentAPI.operateHomework.downloadAttachment(ThisCourse[0].scid,ThisCourse[0].hid, src);
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


//制保留2位小数，如：2，会在2后面补上00.即2.00    
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
function getIdByDomId(prefix, domId){
            return domId.replace(prefix,'');
        }
// 执行!
initPage();