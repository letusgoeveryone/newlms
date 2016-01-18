<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%> 
<%
    String[] words = {"amani", "abc", "apple", "abstract", "an", "bike", "byebye",
        "beat", "be", "bing", "come", "cup", "class", "calendar", "china"};
    if (request.getParameter("search-text") != null) {
        String key = request.getParameter("search-text");
        if (key.length() != 0) {
            String json = "[";
            for (int i = 0; i < words.length; i++) {
                if (words[i].startsWith(key)) {
                    json += "\"" + words[i] + "\"" + ",";
                }
            }
            json = json.substring(0, json.length() - 1 > 0 ? json.length() - 1 : 1);
            json += "]";
            System.out.println("json:" + json);
            out.println(json);
        }
    }
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"> 
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
        <title>搜索词自动完成</title> 
        <style type="text/css"> 
            #search{ 
                text-align: center; 
                position:relative; 
            } 
            .autocomplete{ 
                border: 1px solid #9ACCFB; 
                background-color: white; 
                text-align: left; 
            } 
            .autocomplete li{ 
                list-style-type: none; 
            } 
            .clickable { 
                cursor: default; 
            } 
            .highlight { 
                background-color: #9ACCFB; 
            } 
        </style> 
        <script type="text/javascript" src="<%=path%>/js/jquery.js"></script> 
        <script type="text/javascript">
            $(function () {
                //取得div层 
                var $search = $('#search');
                //取得输入框JQuery对象 
                var $searchInput = $search.find('#search-text');
                //关闭浏览器提供给输入框的自动完成 
                $searchInput.attr('autocomplete', 'off');
                //创建自动完成的下拉列表，用于显示服务器返回的数据,插入在搜索按钮的后面，等显示的时候再调整位置 
                var $autocomplete = $('<div>  </div>')
                        .hide()
                        .insertAfter('#submit');
                //清空下拉列表的内容并且隐藏下拉列表区 
                var clear = function () {
                    $autocomplete.empty().hide();
                };
                //注册事件，当输入框失去焦点的时候清空下拉列表并隐藏 
                $searchInput.blur(function () {
                    setTimeout(clear, 500);
                });
                //下拉列表中高亮的项目的索引，当显示下拉列表项的时候，移动鼠标或者键盘的上下键就会移动高亮的项目，想百度搜索那样 
                var selectedItem = null;
                //timeout的ID 
                var timeoutid = null;
                //设置下拉项的高亮背景 
                var setSelectedItem = function (item) {
                    //更新索引变量 
                    selectedItem = item;
                    //按上下键是循环显示的，小于0就置成最大的值，大于最大值就置成0 
                    if (selectedItem < 0) {
                        selectedItem = $autocomplete.find('li').length - 1;
                    }
                    else if (selectedItem > $autocomplete.find('li').length - 1) {
                        selectedItem = 0;
                    }
                    //首先移除其他列表项的高亮背景，然后再高亮当前索引的背景 
                    $autocomplete.find('li').removeClass('highlight')
                            .eq(selectedItem).addClass('highlight');
                };
                var ajax_request = function () {
                    //ajax服务端通信 
                    $.ajax({
                        url: 'zdpqjsxm', //服务器的地址 
                        data: {'search-text': $searchInput.val()}, //参数 
                       // dataType: 'json', //返回数据类型 
                        type: 'POST', //请求类型 
                        success: function (data) {
                            if (data.length) {
                                //遍历data，添加到自动完成区 
                                $.each(data, function (index, term) {
                                    //创建li标签,添加到下拉列表中 
                                    $('<li></li>').text(term).appendTo($autocomplete)
                                            .addClass('clickable')
                                            .hover(function () {
                                                //下拉列表每一项的事件，鼠标移进去的操作 
                                                $(this).siblings().removeClass('highlight');
                                                $(this).addClass('highlight');
                                                selectedItem = index;
                                            }, function () {
                                                //下拉列表每一项的事件，鼠标离开的操作 
                                                $(this).removeClass('highlight');
                                                //当鼠标离开时索引置-1，当作标记 
                                                selectedItem = -1;
                                            })
                                            .click(function () {
                                                //鼠标单击下拉列表的这一项的话，就将这一项的值添加到输入框中 
                                                $searchInput.val(term);
                                                //清空并隐藏下拉列表 
                                                $autocomplete.empty().hide();
                                            });
                                });//事件注册完毕 
                                //设置下拉列表的位置，然后显示下拉列表 
                                var ypos = $searchInput.position().top;
                                var xpos = $searchInput.position().left;
                                $autocomplete.css('width', $searchInput.css('width'));
                                $autocomplete.css({'position': 'relative', 'left': xpos + "px", 'top': ypos + "px"});
                                setSelectedItem(0);
                                //显示下拉列表 
                                $autocomplete.show();
                            }
                        }
                    });
                };
                //对输入框进行事件注册 
                $searchInput
                        .keyup(function (event) {
                            //字母数字，退格，空格 
                            if (event.keyCode > 40 || event.keyCode == 8 || event.keyCode == 32) {
                                //首先删除下拉列表中的信息 
                                $autocomplete.empty().hide();
                                clearTimeout(timeoutid);
                                timeoutid = setTimeout(ajax_request, 100);
                            }
                            else if (event.keyCode == 38) {
                                //上 
                                //selectedItem = -1 代表鼠标离开 
                                if (selectedItem == -1) {
                                    setSelectedItem($autocomplete.find('li').length - 1);
                                }
                                else {
                                    //索引减1 
                                    setSelectedItem(selectedItem - 1);
                                }
                                event.preventDefault();
                            }
                            else if (event.keyCode == 40) {
                                //下 
                                //selectedItem = -1 代表鼠标离开 
                                if (selectedItem == -1) {
                                    setSelectedItem(0);
                                }
                                else {
                                    //索引加1 
                                    setSelectedItem(selectedItem + 1);
                                }
                                event.preventDefault();
                            }
                        })
                        .keypress(function (event) {
                            //enter键 
                            if (event.keyCode == 13) {
                                //列表为空或者鼠标离开导致当前没有索引值 
                                if ($autocomplete.find('li').length == 0 || selectedItem == -1) {
                                    return;
                                }
                                $searchInput.val($autocomplete.find('li').eq(selectedItem).text());
                                $autocomplete.empty().hide();
                                event.preventDefault();
                            }
                        })
                        .keydown(function (event) {
                            //esc键 
                            if (event.keyCode == 27) {
                                $autocomplete.empty().hide();
                                event.preventDefault();
                            }
                        });
                //注册窗口大小改变的事件，重新调整下拉列表的位置 
                $(window).resize(function () {
                    var ypos = $searchInput.position().top;
                    var xpos = $searchInput.position().left;
                    $autocomplete.css('width', $searchInput.css('width'));
                    $autocomplete.css({'position': 'relative', 'left': xpos + "px", 'top': ypos + "px"});
                });
            });
        </script> 
    </head> 
    <body> 
        <div id = "search"> 
            <label for="search-text">请输入关键词</label><input type="text" id="search-text" name="search-text" /> 
            <input type="button" id="submit"  value="搜索"/> 
        </div> 
    </body> 
</html>