$.extend($.fn.validatebox.defaults.rules, {
    minLength: {
        validator: function (value, param) {
            return value.length >= param[0];
        },
        message: '请输入至少 {0} 文字'
    },
    number: {
        validator: function (value) {
            var reg = /^[0-9]+$/;
            return reg.test(value);
        },
        message: '请输入数字'
    },
    chs: {
        validator: function (value) {

            return /^([\u0391-\uFFE5])([\u0391-\uFFE5])+$/.test(value);
        },
        message: '请输入至少两个汉字，不得含有非汉字符号'
    },
    IdCard: {
        validator: function (value) {
            var id = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/g;
            return id.test(value);
        },
        message: '您输入的身份证格式不正确，正确格式为15或18位数字，最后一个可以是X'

    },
    mobile: {//value值为文本框中的值  
        validator: function (value) {
            var reg = /^1\d{10}$/g;
            return reg.test(value);
        },
        message: '请输入正确手机号'
    },
    QQ: {
        validator: function (value) {
            var reg = /^[0-9]+$/;
            return reg.test(value);
        },
        message: '请输入正确QQ号'
    },
    stu_sno: {
        validator: function (value) {
            var sno = $('#sno').val();
//            alert($('#hsno').val());
            return sno === $('#sno2').val();
        },
        message: "您输入的学号同前一页不同，如需回到上一页请单击“上一步”"
    },
    tch_sno: {
        validator: function (value) {
            var sno = $('#sno').val();
//            alert($('#hsno').val());
            return sno === $('#sno2').val();
        },
        message: "您输入的工号同前一页不同，如需回到上一页请单击“上一步”"
    },
    chk_idcard: {
        validator: function (value) {
            return $('#idcard').val() === $('#idcard2').val();
        },
        message: '您输入的身份证号同前一页不同，如需回到上一页请单击“上一步”'
    },
    chk_pwd: {
        validator: function (value) {
            return $('#pwd').val() === $('#pwd2').val();
        },
        message: '您输入的密码同前一页不同，如需回到上一页请单击“上一步”'
    },
    chk_name: {
        validator: function (value) {
            return $('#name').val() === $('#name2').val();
        },
        message: '您输入的姓名同前一页不同，如需回到上一页请单击“上一步”'
    },
    chk_code: {
        validator: function (value) {
            //alert("checkcode before");
            $.get("checkCode", function (data) {
                //alert("checkcode");
                res=data;
            });
            return res==value.toUpperCase();
        },
        message:'您输入的验证码尚不正确'
    },
    stl_name:{
        validator:function(value){
            return /^(([\u0391-\uFFE5])|([A-Za-z])|(\.))+$/.test(value);
        },
        message:'请不要输入非文字字符'
    }
    
});



