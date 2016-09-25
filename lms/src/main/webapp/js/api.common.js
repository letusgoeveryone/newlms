var PATH = getRootPath();

function initMessage(objId) {
    var obj = document.getElementById(objId);
    
    if (objId === "nameMsg") {
        obj.innerHTML = "<span class='text-tooltips'>用户名为2-5位的汉字构成</span>";
    } else if (objId === "passwFristMsg") {
        obj.innerHTML = "<span class='text-tooltips'>密码为6-18位的字母,数字或下划线构成</span>";
    }
};

/**
 * 
 * @param {Number | Element ID} checkText
 * @param {Number | Element ID} checkMessage
 * @returns {Boolean}
 */
function verifyText(checkText, checkMessage) {
    var text = document.getElementById(checkText).value;
    var verifyObj = new verifyObject(text);
    verifyObj.trim();
    
    if (checkText === "name") {
        if (!(verifyObj.isPattern(/^[\u4e00-\u9fa5]{2,5}$/))) {
            document.getElementById(checkMessage).innerHTML = "用户名有误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "nameCheck") {
        if (!(verifyObj.isEqual(document.getElementById("name").value))) {
            document.getElementById(checkMessage).innerHTML = "用户名前后不一致";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "id") {
        if (!(verifyObj.isPattern(/^[0-9]{10,10}$/))) {
            document.getElementById(checkMessage).innerHTML = "学号/工号格式有误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "sn") {
        if (!(verifyObj.isPattern(/^[0-9]{10,10}$/))) {
            document.getElementById(checkMessage).innerHTML = "学号有误";
            return false;
        } else {
            if (isSnExist(document.getElementById("sn").value)) {
                document.getElementById(checkMessage).innerHTML = "<span class='text-orange'>学号已注册, 完成注册后请...</span>";
            } else {

                document.getElementById(checkMessage).innerHTML = "";
            }
            return true;
        }
    } else if (checkText === "snCheck") {
        if (!(verifyObj.isEqual(document.getElementById("sn").value))) {
            document.getElementById(checkMessage).innerHTML = "学号前后不一致";
            return false;
        } else {
            if (isSnExist(document.getElementById("snCheck").value)) {
                document.getElementById(checkMessage).innerHTML = "<span class='text-orange'>学号已注册, 完成注册后请...</span>";
            } else {
                document.getElementById(checkMessage).innerHTML = "";
            }
            return true;
        }
    } else if (checkText === "tn") {
        if (!(verifyObj.isPattern(/^[0-9 _]{6,18}$/))) {
            document.getElementById(checkMessage).innerHTML = "工号有误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "tnCheck") {
        if (!(verifyObj.isEqual(document.getElementById("tn").value))) {
            document.getElementById(checkMessage).innerHTML = "工号前后不一致";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "ID") {
        if (!(verifyObj.isPattern(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/g))) {
            document.getElementById(checkMessage).innerHTML = "身份证号有误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "IDCheck") {
        if (!(verifyObj.isEqual(document.getElementById("ID").value))) {
            document.getElementById(checkMessage).innerHTML = "身份证号前后不一致";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "pw") {
        if (!(verifyObj.isPattern(/^[a-z A-Z 0-9 _]{5,18}$/))) {
            document.getElementById(checkMessage).innerHTML = "密码格式有误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    }else if (checkText === "passwFrist") {
        if (!(verifyObj.isPattern(/^[a-z A-Z 0-9 _]{6,18}$/))) {
            document.getElementById(checkMessage).innerHTML = "密码有误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "passwLast") {
        if (!(verifyObj.isEqual(document.getElementById("passwFrist").value))) {
            document.getElementById(checkMessage).innerHTML = "密码前后不一致";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "tel") {
        if (!(verifyObj.isPattern(/^1\d{10}$/g))) {
            document.getElementById(checkMessage).innerHTML = "手机号有误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "qq") {
        if (!(verifyObj.isPattern(/^[0-9]{6,12}$/))) {
            document.getElementById(checkMessage).innerHTML = "Qq号有误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else if (checkText === "email") {
        if (!(verifyObj.isPattern(/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$/))) {
            document.getElementById(checkMessage).innerHTML = "邮箱格式不对";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
        }
    } else if (checkText === "ccd") {
        if (!isCCDEqual(document.getElementById("ccd").value)) {
            document.getElementById(checkMessage).innerHTML = "验证码输入错误";
            return false;
        } else {
            document.getElementById(checkMessage).innerHTML = "";
            return true;
        }
    } else {
        return false;
    }

};

/**
 * 
 * @param {type} targetParm targetParm为待验证的消息
 * @returns {verifyObject}
 */
function verifyObject(targetParm) {
    this.target = targetParm;
};

verifyObject.prototype.trim = function () {
    var pattern = /(^\s*)|(\s*$)/g;
    this.target = this.target.replace(pattern, "");
};

verifyObject.prototype.isEqual = function (anyParm) {
    if (this.target === anyParm) {
        return true;
    } else {
        return false;
    }
};

verifyObject.prototype.isPattern = function (patternParm) {
    var pattern = new RegExp(patternParm);
    var flag = pattern.test(this.target);
    if (flag) {
        return true;
    } else {
        return false;
    }
};

/**
 * 检验验证码
 * @param {String} ccd
 * @returns {Boolean}
 */
function isCCDEqual(ccd) {
    var status = false;
    $.ajax({
        url: PATH + '/reg/ckccd?ccd=' + ccd,
        type: 'get',
        async: false,
        dataType: 'json',
        success: function (data) {
            
            if(data===1){
                status = true;
            } else {
                status = false;
            }
            
        },
        error: function () {
            console.log("验证码信息传回失败 ！");
        }
    });
    console.log(status);
    return status;
};

function updateCcdImage(id) {
    console.log((id === undefined ? "#ccdImage" : "#" + id));
    $((id === undefined ? "#ccdImage" : "#" + id)).attr("src", PATH+"/reg/createImage?dt=" + Math.random()); //随机生成验证码
};

function isSnExist(sn){
    var status = false;
    $.ajax({
        type: "get",
        url: PATH + '/reg/cjxh?jssz='+ sn,
        dataType: 'json',
        async: false,
        success: function (data) {

            if (data === 1) {
                status = true;
            } else {
                status = false;
            }
        },
        error: function () {
            alert("error!！");
        }
    });
    
    console.log(status);
    return status;
}

var CommonAPI = {
    Institute: [],
    SchoolYear:[],
    Path:{
        sInfo:[
            'fhnj',
            'hq_xy'
        ]
    },
    setDS:{
        Institute: function (path){
            
            if (path === undefined ? true : false) {
                path = CommonAPI.Path.sInfo[1];
            } else {
                path = PATH + path;
            };
            
            $.ajax({
                type: "get",
                url: path,
                dataType: 'json',
                async: false,
                success: function (data) {
                    CommonAPI.Institute = data;
                },
                error: function () {
                    alert("error!！");
                }
            });
        },
        SchoolYear:function(path){
            
            if (path === undefined ? true : false) {
                path = CommonAPI.Path.sInfo[0];
            } else {
                path = PATH + path;
            };
            
            $.ajax({
                type: "get", 
                url:  path, 
                dataType: 'json',
                async: false,
                success: function (data) {
                    CommonAPI.SchoolYear = data;
                },
                error: function () {
                    alert("error!！");
                }
            });
        }
    },
    setHS:{
        Institute: function(id){
            var o = CommonAPI.Institute;

            document.getElementById(id).options.length = 0;
            for (var i = 0; i < o.length; i++) {
                document.getElementById(id).options.add(new Option(o[i], o[i]));
            }
        },
        SchoolYear: function (id) {
            var o = CommonAPI.SchoolYear;

            document.getElementById(id).options.length = 0;
            for (var i = 0; i < o.length; i++) {
                document.getElementById(id).options.add(new Option(o[i], o[i]));
            }
        }
    }
};