/**
 * 游客API 主要包括:
 * <br>1. 课程查看
 * @type API Object
 */
var GuestAPI = {
    Path: {
        /**
         * 返回课程JSON, 可传参数加以过滤
         * @type Array
         */
        cStructure: [
            'guest/getcoulist'
        ],
        cInfo: [
            'guest/coudetails'
        ]
    },
    
    CourseListDS:null,
    /**
     * 课程实例 临时变量
     * @type Course
     */
    ThisCourse:{
        cid: 0,
        obj:{
            courseName: '',
            introduction: '',
            syllabus: ''
        }
    },
    DemonCourse: {
        cid: 0,
        obj:{
            //courseName: '',
            introduction: '',
            syllabus: ''
        }
    },
    
    
    setDS:{
        CourseListDS: function(path){
            if(path === undefined ? true : false){
                path = GuestAPI.Path.cStructure[0];
            }
            $.ajax({
                url: path,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    GuestAPI.CourseListDS = data;
                    //console.log(data);
                },
                error: function () {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '资源 [课程列表] 传输失败! <a data-dismiss="snackbar">我知道了</a>'
                    });
                }
            });
        },
        
        /**
         * CidIsCourse 构造函数 
         * @param {type} cid
         * @param {type} path
         * @returns Boolean
         */
        CidIsCourse: function (cid, path) {
            var _o = GuestAPI.ThisCourse.obj;
            _o.courseName = GuestAPI.getCNameByCid(cid);
            console.log(_o.courseName);
            var status = true;
            if (path === undefined ? true : false) {
                path = GuestAPI.Path.cInfo[0] + "?cid=" + cid;
            };
            $.ajax({
                url: path,
                type: 'get',
                async: false,
                dataType: 'json',
                success: function (data) {
                    _o.introduction = data[0] === null ? '暂无介绍' : data[0];
                    _o.syllabus = data[1] === null ? '暂无介绍' : data[1];
                    
                    status = true;
                },
                error: function () {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '课程（'+ _o.courseName + '）资源 [课程详情] 传输失败! <a data-dismiss="snackbar">我知道了</a>'
                    });
                    status = false;
                }
            });

            return status;

        }
    },
    analyzeDS:{
        CourseList:{
            getListHS: function(){
                var _o = GuestAPI.CourseListDS;
                var ListHS = '';
                for (var i = 0; i < _o.length; i++) {
                    if (i === 0) {
                        ListHS = ListHS +
                            '<li class="active"><a id="cid-' + _o[i].cid + '" herf="#null" data-toggle="tab" class="btn btn-flat " onclick="updataCourseArea(' + _o[i].cid + ')">' +
                            _o[i].course + '</a></li>';
                    } else {
                        ListHS = ListHS +
                            '<li><a id="cid-' + _o[i].cid + '" herf="#null" data-toggle="tab" class="btn btn-flat " onclick="updataCourseArea(' + _o[i].cid + ')">' +
                            _o[i].course + '</a></li>';
                    }
                }
                return ListHS;
            }
        }
    },
    getCNameByCid: function(cid){
        var list = GuestAPI.CourseListDS;
        
        for(var i=0; i<list.length; i++){
            if(cid == list[i].cid){
                return list[i].course;
            }
            
        }
        return '';
    }
};