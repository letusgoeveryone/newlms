/**
 * jQuery EasyUI 1.4
 * 
 * Copyright (c) 2009-2014 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the GPL license: http://www.gnu.org/licenses/gpl.txt
 * To use it on other terms please contact us at info@jeasyui.com
 *
 */
(function($){
function _1(_2){
var _3=$.data(_2,"dialog").options;
if(_3.toolbar){
if($.isArray(_3.toolbar)){
$(_2).siblings("div.dialog-toolbar").remove();
var _4=$("<div class=\"dialog-toolbar\"><table cellspacing=\"0\" cellpadding=\"0\"><tr></tr></table></div>").appendTo(_2);
var tr=_4.find("tr");
for(var i=0;i<_3.toolbar.length;i++){
var _5=_3.toolbar[i];
if(_5=="-"){
$("<td><div class=\"dialog-tool-separator\"></div></td>").appendTo(tr);
}else{
var td=$("<td></td>").appendTo(tr);
var _6=$("<a href=\"javascript:void(0)\"></a>").appendTo(td);
_6[0].onclick=eval(_5.handler||function(){
});
_6.linkbutton($.extend({},_5,{plain:true}));
}
}
}else{
$(_3.toolbar).addClass("dialog-toolbar").appendTo(_2);
$(_3.toolbar).show();
}
}else{
$(_2).siblings("div.dialog-toolbar").remove();
}
if(_3.buttons){
if($.isArray(_3.buttons)){
$(_2).siblings("div.dialog-button").remove();
var _7=$("<div class=\"dialog-button\"></div>").appendTo(_2);
for(var i=0;i<_3.buttons.length;i++){
var p=_3.buttons[i];
var _8=$("<a href=\"javascript:void(0)\"></a>").appendTo(_7);
if(p.handler){
_8[0].onclick=p.handler;
}
_8.linkbutton(p);
}
}else{
$(_3.buttons).addClass("dialog-button").appendTo(_2);
$(_3.buttons).show();
}
}else{
$(_2).siblings("div.dialog-button").remove();
}
var tb=$(_2).children(".dialog-toolbar");
var bb=$(_2).children(".dialog-button");
$(_2).css({marginTop:(tb._outerHeight()-tb.length)+"px",marginBottom:(bb._outerHeight()-bb.length)+"px"});
var _9=$("<div class=\"dialog-spacer\"></div>").prependTo(_2);
$(_2).window($.extend({},_3,{onResize:function(w,h){
_a(_2);
var s=$(this).children("div.dialog-spacer");
if(s.length){
setTimeout(function(){
s.remove();
},0);
}
_3.onResize.call(this,w,h);
}}));
};
function _a(_b,_c){
var t=$(_b);
t.children(".dialog-toolbar,.dialog-button").css("position","absolute").appendTo(t.parent());
var tb=t.siblings(".dialog-toolbar");
var bb=t.siblings(".dialog-button");
t._outerHeight(t._outerHeight()-tb._outerHeight()-bb._outerHeight()+tb.length+bb.length);
tb.css({top:(t.position().top-1+parseInt(t.css("borderTopWidth")))+"px"});
bb.css({top:(t.position().top+t.outerHeight(true)-bb._outerHeight())+"px"});
tb.add(bb)._outerWidth(t._outerWidth());
var _d=$.data(_b,"window").shadow;
if(_d){
var cc=t.panel("panel");
_d.css({width:cc._outerWidth(),height:cc._outerHeight()});
}
};
$.fn.dialog=function(_e,_f){
if(typeof _e=="string"){
var _10=$.fn.dialog.methods[_e];
if(_10){
return _10(this,_f);
}else{
return this.window(_e,_f);
}
}
_e=_e||{};
return this.each(function(){
var _11=$.data(this,"dialog");
if(_11){
$.extend(_11.options,_e);
}else{
$.data(this,"dialog",{options:$.extend({},$.fn.dialog.defaults,$.fn.dialog.parseOptions(this),_e)});
}
_1(this);
});
};
$.fn.dialog.methods={options:function(jq){
var _12=$.data(jq[0],"dialog").options;
var _13=jq.panel("options");
$.extend(_12,{width:_13.width,height:_13.height,left:_13.left,top:_13.top,closed:_13.closed,collapsed:_13.collapsed,minimized:_13.minimized,maximized:_13.maximized});
return _12;
},dialog:function(jq){
return jq.window("window");
}};
$.fn.dialog.parseOptions=function(_14){
return $.extend({},$.fn.window.parseOptions(_14),$.parser.parseOptions(_14,["toolbar","buttons"]));
};
$.fn.dialog.defaults=$.extend({},$.fn.window.defaults,{title:"New Dialog",collapsible:false,minimizable:false,maximizable:false,resizable:false,toolbar:null,buttons:null});
})(jQuery);

