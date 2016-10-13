/*---------------------------------------------------------------- 
 文件名：api.json.adt.js
 
 文件功能描述：院长信息 前端接口
 
 依赖关系：Jquery, Vue 以及 前端组件Snackbar(信息提示) 和一些元素绑定(详见相关函数说明)

 //----------------------------------------------------------------*/  

var AdtAPI = {};

/**
 * JSON路径 对象数组
 * @type Object Array 
 */
AdtAPI.Path = {
    
    /**
     * 用以初始化个人相关信息 
     * <br>uInfo[0] 当前登录的个人信息 
     * <br>uInfo[1] 更新个人信息 服务器提交路径 
     * <br>uInfo[2] 更新个人密码 服务器提交路径 
     * 
     * @type Array 
     */
    uInfo: [
        "getpersoninfo",      //[0] 
        "updatepersoninfo",   //[1]  
        "updatepassword"      //[2]
    ]
};

/**
 * 个人基础信息 对象
 * @type Object
 */
AdtAPI.uInfo = {
    id: 0,
    tn: 0,
    name: '',
    ID: 0,
    pw: '',
    sex: false,
    college: '',
    tel: '',
    qq: '',
    avatar:0,
    position:'',
    enrolling:'',
    roleValue:'',
    termCourse:''
};

/**
 * JSON数据结构 设定函数集
 * @type Object
 */
AdtAPI.setDS = {
    uInfo: function(path){
        var status = false;
        if (path === undefined){ path = AdtAPI.Path.uInfo[0]; }
        $.ajax({
            url: path,
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (data) {
                AdtAPI.uInfo.id = data.teacherId;
                AdtAPI.uInfo.tn = data.teacherSn;
                AdtAPI.uInfo.name = data.teacherName;
                AdtAPI.uInfo.ID = data.teacherIdcard;
                AdtAPI.uInfo.grade = data.teacherPosition;
                AdtAPI.uInfo.college = data.teacherCollege;
                AdtAPI.uInfo.tel = data.teacherTel;
                AdtAPI.uInfo.qq = data.teacherQq;
                AdtAPI.uInfo.pw = data.teacherPwd;
                AdtAPI.uInfo.sex = data.teacherSex;
                AdtAPI.uInfo.avatar = data.teacherImg;
                AdtAPI.uInfo.position = data.teacherPosition;
                AdtAPI.uInfo.enrolling = data.teacherEnrolling;
                AdtAPI.uInfo.roleValue = data.teacherRoleValue;
                AdtAPI.uInfo.termCourse = data.termCourse;
                status = true;
            },
            error: function () {
                console.log("数据 [个人信息] 传输失败 ！");
            }
        });
        return status;
    }
};

/**
 * 
 * @param {String} param
 * @param {String | AdtAPI.Path} path
 * @returns {Number}
 */
AdtAPI.updatePersonalInfo = function(param,path){
    var status = 0;
    if (path === undefined ? true : false) {
        path = AdtAPI.Path.uInfo[1];
    };
    $.ajax({
        url: path + param,
        type: 'post',
        async: false,
        dataType: 'json',
        success: function (data) {
            status = data;
        },
        error: function () {
            console.log("个人信息更新 出现错误 ！");
            status = -1;
        }
    });
    return status;
};

AdtAPI.updatePassword = function(op, np, path){
    var status = 0;
    if (path === undefined ? true : false) {
        path = AdtAPI.Path.uInfo[2];
    };
    $.ajax({
        url: path + "?pw=" + op + "&repw=" + np,
        type: 'post',
        async: false,
        dataType: 'json',
        success: function (data) {
            status = data;
        },
        error: function () {
            status = -1;
        }
    });
    return status;
};

/**
 * 绑定个人信息到 Vue 对象上
 * @param {Vue Object} e
 * @param {String} eid
 * @returns {undefined}
 */
function bindInfo(e, eid){
    AdtAPI.setDS.uInfo();
    e = new Vue({
        el: '#' + eid,
        data: {
            id: uInfo.id,
            tn: uInfo.tn,
            name: uInfo.name,
            ID: uInfo.ID,
            college: uInfo.college,
            tel: uInfo.tel,
            qq: uInfo.qq,
            pw: uInfo.pw,
            sex: uInfo.sex
        }
    });
}

function updatePersonalInfo() {

    if (!checkPersonalInfo()) {
        return false;
    }

    var name = $('#name').val();
    var ID = $('#ID').val();
    var institute = $('#institute').val();
    var sex = $('#male').is(":checked") ? '男' : '女';
    console.log(sex);
    var tel = $('#tel').val();
    var qq = $('#qq').val();
    var param = "?name=" + name + "&idcard=" + ID + "&college=" + institute +
                "&sex=" + sex +"&telnum=" + tel +"&qqnum=" + qq;
    var status = AdtAPI.updatePersonalInfo(param);
    if (status === 0) {
        $('#snackbar').snackbar({
            alive: 10000,
            content: '个人信息修改失败 !' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    } else {
        $('#snackbar').snackbar({
            alive: 10000,
            content: '个人信息已修改...' + '<a data-dismiss="snackbar">我知道了</a>'
        });
    }        
    return true;
};

/**
 * 依赖 api.common.js verifyText()函数
 * @returns {Boolean}
 */
function checkPersonalInfo() {
    var status = false;
    
    if (verifyText('name', 'nameMsg') && verifyText('tel', 'telMsg') && verifyText('qq', 'qqMsg')) {
        status = true;
    } else
        status = false;

    return status;
};

function updatePassword() {
    
    if (checkPassword()) {
        var status = AdtAPI.updatePassword(hex_md5($("#pw").val()), hex_md5($("#passwLast").val()));
        
        if (status === 1) {
            alert("原密码不正确！");
            $("#msg-op").fadeIn();
        } else if (status === 2) {
            $('#snackbar').snackbar({
                alive: 10000,
                content: '密码并未更新 原因:新密码与旧密码相同 <a data-dismiss="snackbar">我知道了</a>'
            });
        } else if (status === 3) {
            setTimeout(logout, 1500);
            $('#snackbar').snackbar({
                alive: 10000,
                content: '密码修改成功, 需跳转至登陆界面... <a data-dismiss="snackbar" href="logout">立即跳转</a>'
            });
        } else if (status === -1){
            alert("数据传输失败 ！");
        }
    }
};

/**
 * 依赖 api.common.js verifyText()函数
 * @returns {Boolean}
 */
function checkPassword() {
    var status = false;
    
    if (verifyText('pw', 'pwMsg') && verifyText('passwFrist', 'passwFristMsg') && verifyText('passwLast', 'passwLastMsg')) {
        status = true;
    } else
        status = false;

    return status;
};

function logout(){
    window.location.href = "../logout"; 
}


// 初始化
var uInfo = AdtAPI.uInfo;
var UProfile;
bindInfo(UProfile, 'uinfo');
if (AdtAPI.uInfo.sex === true) {
    $('#male').attr("checked", "checked");
} else {
    $('#female').attr("checked", "checked");
}
