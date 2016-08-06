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
    /**
     * 当前 实例化(聚焦)的已选课程
     * @type Object
     */
    OCidIsCourse: {
        courseName:'',
        teacherName:'',
        teacherSn:'',
        introduction:'',
        syllabus:'',
        attachment:'',
        TOC:{},
        homework:{}
    },
    /**
     * 当前 实例化(聚焦)的可选课程
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
            "student/stu_course_homework"   //[2] 
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
                    alter('修改失败 !');
                } else {
                    alert('修改成功 !');
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
                StudentAPI.numOCourse = StudentAPI.selectedCourseDS.length;
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
     * 
     * @param {Number} scid - 课程ID
     * @param {Boolean} is - 是否是为选课而提供的为简要信息
     * @param {optional String Array} path - 课程信息相关JSON路径的字符串数组
     * @returns {Object} 返回包含[courseName,teacherName,teacherSn,syllabus,introduction,attachment,TOC(is为假时),homework(is为假时)]基本信息的课程对象
     */
    returnCidIsCourse: function(scid, is, path){
        var _o = StudentAPI.OCidIsCourse;
        var _x = StudentAPI.XCidIsCourse;
        if (path === undefined ? true : false) {
            pathSummary = StudentAPI.Path.cInfo[0] + "?scid=" + scid;
            pathTOC = StudentAPI.Path.cInfo[1] + "?scid=" + scid;
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
                    _x.introduction = data[4].introduction;
                    _x.syllabus = data[3].syllabus;
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
                    _o.introduction = data[4].introduction;
                    _o.syllabus = data[3].syllabus;
                    _o.attachment = data[5].swf_syllabus;

                    _o.TOC = null;
                    _o.homework = null;
                },
                error: function () {
                    alert("数据传输失败 ！");
                }
            });
            $.ajax({
                url: pathTOC,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _o.TOC = data;
                },
                error: function () {
                    alert("数据[TOC]传输失败 ！");
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
        },{...}]</pre>
     * @param {Object | StudentAPI.XCourseDS} CourseDS
     * @returns {String Object}
     */
    returnXCourseTableHS: function (CourseDS) {
        var _head = '<table class="table table-responsive" title="选课表">'
                    +'<thead><tr><th>课程</th><th>老师</th><th>地点</th><th>状态</th></tr></thead>',
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
                    
        
        _o = CourseDS;
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
            _body += '<tbody id="cname-' +_o[i].text+ '"><tr><td class="bg-light text-blod" rowspan="' + _tmpSum + '">' + _o[i].text + '</td>' + _tmpHS + '</tbody>';


        }
        TableHS = _head + _body + _foot;
        StudentAPI.numXCourse = _sum;
        return TableHS;

    },
    /**
     * 
     * @param {type} CourseDS
     * @returns {String}
     */
    returnOCourseListHS: function (CourseDS){
        var ListHS = '';
        for (var i = 0; i < CourseDS.length; i++) {
            if(i===0){
                ListHS = ListHS
                        + '<li class="active"><a id="cid-' + CourseDS[i].scid + '" herf="#null" data-toggle="tab" class="btn btn-flat " onclick="updataSelectedCourse(' + CourseDS[i].scid + ')">'
                        + OCourse[i].course + '</a></li>';
            } else {
                ListHS = ListHS
                        + '<li><a id="cid-' + CourseDS[i].scid + '" herf="#null" data-toggle="tab" class="btn btn-flat " onclick="updataSelectedCourse(' + CourseDS[i].scid + ')">'
                        + OCourse[i].course + '</a></li>';
            }
        }
        return ListHS;
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
            var status = false;
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
                        return status = false;
                    } else if (data === 1) {
                        return status = true;
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
                        return status = false;
                    } else if (data === 1) {
                        return status = true;
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
                        return status = false;
                    } else if (data === 1) {
                        return status = true;
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
        upload: function(){
            
        },
        download: function(){
            
        },
        delete: function(){
            
        }
    }
    
};

//定义全局变量

/**
 * 长度为二的对象数组 全局变量 (且唯一)
 * <br>ThisCourse<b>[0]</b>:存储一个<b> 已 </b>选课程的实例
 * <br>ThisCourse<b>[1]</b>:存储一个<b> 待 </b>选课程的实例
 * @type Array
 */
var ThisCourse = [{
        scid: 0
    },{
        scid: 1
    }];
/**
 * 已选课程的列表 一维数组对象
 * @type Array|StudentAPI.selectedCourseDS
 */
var OCourse = [];
/**
 * 待选课程的列表 三级JSON对象
 * @type Array|StudentAPI.selectableCourseDS
 */
var XCourse = [];
/**
 * HTML片段: 存储已选课程列表 
 * @type String
 */
var OCourseListHS = "";
/**
 * HTML片段: 存储待选课程表格 
 * @type String
 */
var XCourseTableHS = '';

// 初始化 相关基础参数
StudentAPI.initPersonalInfo();
StudentAPI.initPersnalCourseInfo();
OCourse = StudentAPI.selectedCourseDS;
XCourse = StudentAPI.selectableCourseDS;
ThisCourse[0].scid = OCourse[0].scid;
ThisCourse[0]=StudentAPI.returnCidIsCourse(ThisCourse[0].scid);
OCourseListHS = StudentAPI.returnOCourseListHS(OCourse);
XCourseTableHS = StudentAPI.returnXCourseTableHS(XCourse);
// 绑定 相关基础参数
/**
 * 对个人面板的信息进行绑定
 * <br><b>选择器:</b>
 * <br>ID:ubox
 * <br><b>对象属性:</b>
 * <br>sn, name, portrait, grade, college, qq
 * <br>
 * @type Vue
 */
var bindUBox = new Vue({
    el: "#ubox",
    data: {
        sn: StudentAPI.sn,
        name: StudentAPI.name,
        portrait: StudentAPI.name.toString()[0],
        grade: StudentAPI.grade,
        college: StudentAPI.college,
        qq: StudentAPI.qq,
        numOCourse: StudentAPI.numOCourse,
        numXCourse: StudentAPI.numXCourse
    }
});

/**
 * 
 * @type Vue
 */
var bindPersonalInfo = new Vue({
    el: "#tab-personalInfo",
    data: {
        id: StudentAPI.id,
        sn: StudentAPI.sn,
        name: StudentAPI.name,
        ID: StudentAPI.ID,
        grade: StudentAPI.grade,
        college: StudentAPI.college,
        tel: StudentAPI.tel,
        qq: StudentAPI.qq,
        pw: StudentAPI.pw,
        sex: StudentAPI.sex
    }
});

/**
 * 
 * @type Vue
 */
var bindSelectedCourse = new Vue({
    el: '#ucontent',
    data: {
        introduction: ThisCourse[0].introduction,
        syllabus: ThisCourse[0].syllabus + ThisCourse[0].attachment,
        courseliset: OCourseListHS
    }
});

/**
 * 
 * @type Vue
 */
var bindSelectableCourse = new Vue({
    el: '#tab-course-selectable',
    data: {
        tableData:XCourseTableHS,
        introduction: ThisCourse[1].introduction,
        syllabus: ThisCourse[1].syllabus
    }
});



// 更新  相关基础参数
function updataSelectedCourse(scid) {
    ThisCourse[0].scid = scid;
    ThisCourse[0] = StudentAPI.returnCidIsCourse(ThisCourse[0].scid);
    bindSelectedCourse.$data.introduction=ThisCourse[0].introduction;
    bindSelectedCourse.$data.syllabus= ThisCourse[0].syllabus + ThisCourse[0].attachment;
    console.log(ThisCourse[0]);
};
function updataSelectableCourse(scid){
    ThisCourse[1].scid = scid;
    ThisCourse[1] = StudentAPI.returnCidIsCourse(ThisCourse[1].scid);
    bindSelectedCourse.$data.introduction = ThisCourse[1].introduction;
    bindSelectedCourse.$data.syllabus = ThisCourse[1].syllabus + ThisCourse[1].attachment;
    console.log(ThisCourse[1]);
};

/**
 * 密码个人信息StudentAPI.updataPersonalInfo()的包装函数
 * @returns {void}
 */
function updataPersonalInfo(){
    var name = $('#name').val();
    var ID = $('#ID').val();
    var grade = $('#grade').val();
    var college = $('#college').val();
    var sex = $('#man').is(":checked") ? true : false;
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

/**
 * 密码更新StudentAPI.updatePassword()的包装函数
 * @returns {void}
 */
function updataPassword(){
    StudentAPI.updatePassword(StudentAPI.Path.uInfo[2]
            +"?pw=" + hex_md5($("#oldPassword").val()) 
            +"&repw=" + hex_md5($("#newPassword").val()));
};

/**
 * @param {Number} scid 更新 全局变量ThisCourse[0].scid(可选课程) 的值
 * @returns {void}
 */
function updataThisCourse1cid(scid){
    ThisCourse[1].scid = scid;
}
/**
 * @param {Number} scid 更新 全局变量ThisCourse[1].scid(已选课程) 的值
 * @returns {void}
 */
function updataThisCourse0cid(scid) {
    ThisCourse[0].scid = scid;
}
/**
 * 
 * @param {type} scid
 * @returns {undefined}
 */
function selectCourse(scid){
    StudentAPI.operateCidIsCourse.add(scid);
}