//                                当院的选择发生改变时，重新调整系班的选择项
$("#college").change(function () {
//                                    先清空系班的选择项
//alert($('#college').val());

    $("#department").empty();
    $("#class").empty();
//                                    获取json
//                                    $.getJSON("../loadDepart");

    $.getJSON("../loadDepart.servlet?scid=" + $("#college").val() + "&dbs=" + "lms",
            function (data) {
//                                                data中是返回的json字符串，其中包含每个系的id和名字
                $("#department").append("<option value='0' >请选择系</option>");
                $("#class").append("<option value='0' >请选择班</option>");//alert(data.college);
                $.each(data.departments, function (i, item) {

                    $("#department").append(
                            "<option value=" + item.id + ">" + item.name + "</option>"
                            );
                });
            });

//*/
});

$("#department").change(function () {
//                                    先清空班的选择项
//alert($('#department').val());

    $("#class").empty();
//                                    获取json
//                                    $.getJSON("../loadDepart");

    $.getJSON("../loadClasses.servlet?scid=" + $("#department").val() + "&gid=" + $("#grade").val() + "&dbs=" + "lms",
            function (data) {
//                                                data中是返回的json字符串，其中包含每个班的id和名字

                $("#class").append("<option value='0' >请选择班</option>");//alert(data.college);
                $.each(data.classes, function (i, item) {

                    $("#class").append(
                            "<option value=" + item.id + ">" + item.name + "</option>"
                            );
                });
            });

//*/
});

$("#grade").change(function () {
    // $.changeclasses();
    //                                  先清空班的选择项
//alert($('#department').val());

    $("#class").empty();
//                                    获取json
//                                    $.getJSON("../loadDepart");

    $.getJSON("../loadClasses.servlet?scid=" + $("#department").val() + "&gid=" + $("#grade").val() + "&dbs=" + "lms",
            function (data) {
//                                                data中是返回的json字符串，其中包含每个班的id和名字
                alert(data.classes);
                $("#class").append("<option value='0' >请选择班</option>");//alert(data.college);
                $.each(data.classes, function (i, item) {

                    $("#class").append(
                            "<option value=" + item.id + ">" + item.name + "</option>"
                            );
                });
            });
});