/*
 * 学生选课API文件
 * 课程均只含课程纲要, 课程以状态为基本分类, 其它参数辅助分类
 * (已选课程,可选课程和待批准课程路径 <b>暂时()</b> 通过StudentAPI获得)
 */

var CourseAPI={
    
    /**
     * 默认的 初始化使用的 参数对象数组(每个数组第一位为状态值,第二位为查询参数)
     * @type Object Array
     */
    DefaultParms:{
        method:'o',
        parms:null
    },
    
    /**
     * JSON 路径
     * @type Object Array
     */
    Path: {
        /**
         * 返回课程JSON, 可传参数加以过滤
         * @type Array
         */
        cStructure: [],
        /**
         * 用以初始化课程相关信息 
         * <br>均需额外的路径参数:?scid= 
         * <br>cInfo[0] 返回课程详情 
         * 
         * @type Array 
         */
        cInfo: [
            "student/stu_course"  //[0]   
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
            "student/subselectcourse", //[0] 
            "student/cancelcourse", //[1] 
            "student/quitcourse"        //[2] 
        ]
    },
    
    
    /**
     * 课程实例 临时变量
     * @type Course
     */
    CidIsCourse:{
        scid: 0,
        introduction: '',
        syllabus: '',
        teacherName:'',
        courseName:''
    },
    /**
     * CidIsCourse 构造函数 
     * @param {type} scid
     * @param {type} path
     * @returns {CourseAPI.CidIsCourse|CourseAPI.structureCidIsCourse._o}
     */
    structureCidIsCourse: function (scid, path) {
        var _o = CourseAPI.CidIsCourse;
        if (path === undefined ? true : false) {
            path = CourseAPI.Path.cInfo[0] + "?scid=" + scid;
        };
        
        $.ajax({
            url: path,
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
            },
            error: function () {
                alert("数据传输失败 ！");
            }
        });

        return _o;

    },
    /**
     * 存储 课程信息(默认使用Table初始化,即只包含课程名和课程ID)
     * @type JSON Object
     */
    
    JSONStructure: {
        selectable:null,
        selecting:null,
        selected:null
    },
    /**
     * 通过参数 更新 JSONStructure 
     * @param {String Array} parms
     * @param {String} path
     * @returns {Boolean}
     */
    updataJSONStructure: {
        selectable: function (parms) {
            if(parms===undefined){
                CourseAPI.JSONStructure.selectable = StudentAPI.selectableCourseDS;
            };
        },
        selecting: function (parms) {
            if (parms === undefined) {
                CourseAPI.JSONStructure.selectable = StudentAPI.selectingCourseDS;
            };
        },
        selected: function (parms) {
            if(parms===undefined){
                CourseAPI.JSONStructure.selectable = StudentAPI.selectedCourseDS;
            };
        }
    },
    
    analyzeDS:{
        getHS:{
            Card:function (scid, is){
                if (is === 'o') {
                    return CourseAPI.analyzeDS.selectedCourse.getCardHS();
                } else if (is === 'i') {
                    return CourseAPI.analyzeDS.selectingCourse.getCardHS();
                } else if (is === 'x') {
                    return CourseAPI.analyzeDS.selectableCourse.getCardHS();
                }
            },
            Table:function (scid, is){
                if(is === 'o'){
                    return CourseAPI.analyzeDS.selectedCourse.getTableHS();
                }else if(is === 'i'){
                    return CourseAPI.analyzeDS.selectingCourse.getTableHS();
                }else if(is === 'x'){
                    return CourseAPI.analyzeDS.selectableCourse.getTableHS();
                }
            }
        },
        selectedCourse:{
            getTableHS:function(){
                return StudentAPI.analyzeDS.selectedCourse.getTableHS();
            },
            getCardHS:function(){
                
            }
        },
        selectingCourse:{
            getTableHS:function(){
                return StudentAPI.analyzeDS.selectingCourse.getTableHS();
            },
            getCardHS:function(){
                
            }
        },
        selectableCourse:{
            getTableHS:function(){
                return StudentAPI.analyzeDS.selectableCourse.getTableHS();
            },
            getCardHS:function(){
                
            }
        }
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
    }
    
};
var UPanel = null;
var UCourse = new Vue({
        el: '#ucourses',
        data: {
            courseTableArea:''
        }
    });

function initCoursePage(){
    StudentAPI.initPersnalCourseInfo();
    updataCourseArea();
};

function updataParms(parms, is){
    if (is === 'o') {
        CourseAPI.DefaultParms.method = 'o';
        CourseAPI.DefaultParms.parms=parms;
    } else if (is === 'i') {
        CourseAPI.DefaultParms.method = 'i';
        CourseAPI.DefaultParms.parms=parms;
    } else if (is === 'x') {
        CourseAPI.DefaultParms.method = 'x';
        CourseAPI.DefaultParms.parms=parms;
    }
};

function setDefaultParms(){}//直接修改CourseAPI.Parms内容

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
    }
    console.log("updata courseTableArea has done !");
}