/*---------------------------------------------------------------- 
 文件名：api.json.adt.js
 
 文件功能描述：院长信息 前端接口
 
 依赖关系：Jquery, Vue 以及 前端组件Snackbar(信息提示) 和一些元素绑定(详见相关函数说明)

 //----------------------------------------------------------------*/  

var CommonAPI = {};

/**
 * JSON路径 对象数组
 * @type Object Array 
 */
CommonAPI.Path = {
    
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
CommonAPI.uInfo = {
    id: 0,
    sn: 0,
    name: '',
    ID: 0,
    pw: '',
    sex: false,
    college: '',
    tel: '',
    qq: '',
    position:'',
    enrolling:'',
    roleValue:'',
    termCourse:''
};

/**
 * JSON数据结构 设定函数集
 * @type Object
 */
CommonAPI.setDS = {
    uInfo: function(path){
        if (path === undefined){ path = CommonAPI.Path.uInfo[0]; }
        $.ajax({
            url: path,
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (data) {
                CommonAPI.uInfo.id = data.teacherId;
                CommonAPI.uInfo.sn = data.teacherSn;
                CommonAPI.uInfo.name = data.teacherName;
                CommonAPI.uInfo.ID = data.teacherIdcard;
                CommonAPI.uInfo.grade = data.teacherPosition;
                CommonAPI.uInfo.college = data.teacherCollege;
                CommonAPI.uInfo.tel = data.teacherTel;
                CommonAPI.uInfo.qq = data.teacherQq;
                CommonAPI.uInfo.pw = data.teacherPwd;
                CommonAPI.uInfo.sex = data.teacherSex;
                CommonAPI.uInfo.position = data.teacherPosition;
                CommonAPI.uInfo.enrolling = data.teacherEnrolling;
                CommonAPI.uInfo.roleValue = data.teacherRoleValue;
                CommonAPI.uInfo.termCourse = data.termCourse;
            },
            error: function () {
                alert("数据 [个人信息] 传输失败 ！");
            }
        });
    }
};

/**
 * 
 * @param {String} param
 * @param {String | CommonAPI.Path} path
 * @returns {Number}
 */
CommonAPI.updatePersonalInfo = function(param,path){
    var status = 0;
    if (path === undefined ? true : false) {
        path = CommonAPI.Path.uInfo[1];
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

CommonAPI.updatePassword = function(op, np, path){
    var status = 0;
    if (path === undefined ? true : false) {
        path = CommonAPI.Path.uInfo[2];
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
    CommonAPI.setDS.uInfo();
    e = new Vue({
        el: '#' + eid,
        data: {
            id: uInfo.id,
            sn: uInfo.sn,
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
    var college = $('#college').val();
    var sex = $('#male').is(":checked") ? '男' : '女';
    console.log(sex);
    var tel = $('#tel').val();
    var qq = $('#qq').val();
    var param = "?name=" + name + "&idcard=" + ID + "&college=" + college +
                "&sex=" + sex +"&telnum=" + tel +"&qqnum=" + qq;
    var status = CommonAPI.updatePersonalInfo(param);
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

function checkPersonalInfo() {
    var status = true;
    
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
    } else
        $("#validMsg-ID").fadeOut();

    r = /^1\d{10}$/g;
    flag = r.test($.trim($("#tel").val()));
    if (!flag) {
        $("#validMsg-tel").fadeIn();
        status = false;
    } else
        $("#validMsg-tel").fadeOut();

    r = /^[0-9]{6,10}$/;
    flag = r.test($.trim($("#qq").val()));
    if (!flag) {
        $("#validMsg-qq").fadeIn();
        status = false;
    } else
        $("#validMsg-qq").fadeOut();

    return status;
};

function updatePassword() {
    
    if (checkPassword()) {
        var status = CommonAPI.updatePassword(hex_md5($("#op").val()), hex_md5($("#np").val()));
        
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
 * ID绑定 | 密码合法性检验(返回值) 以及 相应提示
 * <br>#op
 * <br>#msg-op
 * <br>#np
 * <br>#msg-np
 * <br>#nplast
 * <br>#msg-nplast
 * @returns {Boolean} 
 */
function checkPassword() {
    var status = true;
    if ($("#op").val() === '') {
        $("#msg-op").html("请输入原始密码！");
        $("#msg-op").fadeIn();
        status = false;
    } else
        $("#msg-op").fadeOut();

    if ($("#nplast").val() !== $("#np").val()) {
        $("#nplast").val("");
        $("#msg-nplast").html("两次输入的密码不一致！");
        $("#msg-nplast").fadeIn();
        status = false;
    } else
        $("#msg-nplast").fadeOut();


    var r = /^[a-z A-Z 0-9 _]{6,18}$/;
    var flag = r.test($("#np").val());
    if (!flag && ($("#op").val() !== '')) {
        $("#msg-np").html("新密码不符合要求（6到18位），是不是太简单了?");
        $("#msg-np").fadeIn();
        status = false;
    } else
        $("#msg-np").fadeOut();

    if (status === false)
        return false;
    else {
        $("#msg-op").fadeOut();
        $("#msg-np").fadeOut();
        $("#msg-nplast").fadeOut();
    }
    return true;
};

function logout(){
    window.location.href = "../logout"; 
}


// 初始化
var uInfo = CommonAPI.uInfo;
var UProfile;
bindInfo(UProfile, 'uinfo');
if (CommonAPI.uInfo.sex === true) {
    $('#male').attr("checked", "checked");
} else {
    $('#female').attr("checked", "checked");
}
