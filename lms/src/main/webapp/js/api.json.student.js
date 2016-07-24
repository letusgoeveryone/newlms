/* 
 *  学生界面 数据传输
 */


var StudentAPI = {
    stuObj: new Object() ,
    path : [
        "student/getpersoninfo",        //[0] 当前登录的个人信息::json解析可得
        "student/updatepersoninfo",     //[1] 更新个人信息 服务器提交路径
        "student/updatepassword",       //[2] 更新个人密码 服务器提交路径
        "student/getselectcourse",      //[3] 获取已选课程
        "student/addnewcourse",         //[4] 获取可选课程
        "student/getkcjs",              //[5] 获取课程大纲和课程介绍
        "student/subselectcourse",      //[6] 获取选课状态
        "student/cancelcourse",         //[7] 取消未批准课程
        "student/quitcourse",           //[8] 退出课程
        "student/getselectingcourse",   //[9] 获取已选未批准课程
        "student/kcgs",                 //[10] 返回课程内容目录树json
        "student/stu_course",           //[11] 返回课程详情 一个参数选课id（scid）
        "student/stu_course_homework"   //[12] 返回作业列表 一个参数选课id（scid）
    ],
        
    //获取个人信息
    getPersonalInfo: function() {
        $.ajax({
            url: StudentAPI.path[0],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                StudentAPI.stuObj.id = data.studentId;
                StudentAPI.stuObj.sn = data.studentSn;
                StudentAPI.stuObj.name = data.studentName;
                StudentAPI.stuObj.ID = data.studentIdcard;
                StudentAPI.stuObj.grade = data.studentGrade;
                StudentAPI.stuObj.college = data.studentCollege;
                StudentAPI.stuObj.tel = data.studentTel;
                StudentAPI.stuObj.qq = data.studentQq;
                StudentAPI.stuObj.pw = data.studentPwd;
                StudentAPI.stuObj.sex = data.studentSex;
            },
            error: function() {
                alert("数据传输失败 ！");
            }
        });
    },

    //更新个人信息
    updatePersonalInfo: function() {
        $.ajax({
            url: path,
            type: 'post',
            async: false,
            dataType: 'json',
            success: function(data) {
                if (data.toString() === "") {
                    $("得到空数据...");
                } else {
                    alert(
                        "studentId : " + data.studentId +
                        "\nstudentSn : " + data.studentSn +
                        "\nstudentName : " + data.studentName +
                        "\nstudentIdcard : " + data.studentIdcard +
                        "\nstudentGrade : " + data.studentGrade +
                        "\nstudentCollege : " + data.studentCollege +
                        "\nstudentTel : " + data.studentTel +
                        "\nstudentQq : " + data.studentQq +
                        "\nstudentPwd : " + data.studentPwd +
                        "\nstudentSex : " + (data.studentSex ? "男" : "女")
                    );
                }
            },
            error: function() {
                alert("数据传输失败 ！");
            }
        });
    },

    //更新密码
    updatePassword: function() {
        $.ajax({
            url: StudentAPI.path[1],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function(data) {
                if (data.toString() === "") {
                    alert("It's null string !");
                }
            },
            error: function() {
                alert("数据传输失败 ！");
            }
        });
    },

    //列出当前学期所有可选课程
    getSelectableCourse: function() {
        $.ajax({
            url: StudentAPI.path[4],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (data) {
                if (data.toString() === "") {
                    alert("It's null string !");
                }
                else{
                    StudentAPI.stuObj.selectableCourseTree = data;
                }
            },
            error: function () {
                alert("数据传输失败 ！");
            }
        });
    },

    //列出当前学期所有可选课程
    getCourseIntroduction: function(cid) {
        $.ajax({
            url: StudentAPI.path[5],
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (data) {
                if (data.toString() === "") {
                    alert("It's null string !");
                }
                else{
                    StudentAPI.stuObj.selectableCourseTree = data;
                }
            },
            error: function () {
                alert("数据传输失败 ！");
            }
        });
    }

    
};
!(function () {
    StudentAPI.getPersonalInfo();
    StudentAPI.getSelectableCourse();
    console.log(Object.getOwnPropertyNames(StudentAPI.stuObj).sort());
})();

alert(StudentAPI.stuObj.id);
alert(StudentAPI.stuObj.selectableCourseTree);