/** 
 * 配置中心
 * @author longyeh@outlook.com
 */

/*!
 * 插件名：ScrollUp
 * Version：v2.4.1
 * Url: http://markgoodyear.com/labs/scrollup/
 * Copyright (c) Mark Goodyear — @markgdyr — http://markgoodyear.com
 * License: MIT
 */
!(function($){$.scrollUp=function(options){var settings={scrollName:"scrollUp",topDistance:"300",topSpeed:300,animation:"fade",animationInSpeed:200,animationOutSpeed:200,scrollText:"Scroll to top",activeOverlay:false};if(options)var settings=$.extend(settings,options);var sn="#"+settings.scrollName,an=settings.animation,os=settings.animationOutSpeed,is=settings.animationInSpeed,td=settings.topDistance,st=settings.scrollText,ts=settings.topSpeed,ao=settings.activeOverlay;$("<a/>",{id:settings.scrollName,href:"#top",title:st,text:st}).appendTo("body");$(sn).css({"display":"none","position":"fixed","z-index":"2147483647"});if(ao){$("body").append("<div id='"+settings.scrollName+"-active'></div>");$(sn+"-active").css({"position":"absolute","top":td+"px","width":"100%","border-top":"1px dotted "+ao,"z-index":"2147483647"})}$(window).scroll(function(){if(an==="fade")$($(window).scrollTop()>td?$(sn).fadeIn(is):$(sn).fadeOut(os));else if(an==="slide")$($(window).scrollTop()>td?$(sn).slideDown(is):$(sn).slideUp(os));else $($(window).scrollTop()>td?$(sn).show(0):$(sn).hide(0))});$(sn).click(function(event){$("html, body").animate({scrollTop:0},ts);return false})}})(jQuery);
//返回顶部 插件 scrollUp 配置
$(function () {
    $.scrollUp({
        scrollName: 'scrollUp',      // Element ID
        scrollDistance: 0,         // Distance from top/bottom before showing element (px)
        scrollFrom: 'top',           // 'top' or 'bottom'
        scrollSpeed: 300,            // Speed back to top (ms)
        easingType: 'linear',        // Scroll to top easing (see http://easings.net/)
        animation: 'fade',           // Fade, slide, none
        animationSpeed: 200,         // Animation speed (ms)
        scrollTrigger: false,        // Set a custom triggering element. Can be an HTML string or jQuery object
        scrollTarget: false,         // Set a custom target element for scrolling to. Can be element or number
        scrollText: '',                  // Text for element, can contain HTML
        scrollTitle: false,           // Set a custom <a> title if required.
        scrollImg: false,            // Set true to use image
        activeOverlay: false,    // Set CSS color to display scrollUp active point, e.g '#00FFFF'
        zIndex: 2000                 // Z-Index for the overlay
    });
});

tinymce.init({
selector: '#MceEditor',
        theme: 'modern',
        height: 300,
        language: 'zh_CN',
        plugins: [
                'advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker',
                'searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking',
                'save table contextmenu directionality emoticons template paste textcolor'
        ],
        content_css: 'css/content.css',
        toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | print preview media fullpage | forecolor backcolor emoticons'
});
        
function toggleCourseTileLocked(isScroll){
        
    $(".tile-toggle-lock").toggle();
    $(".tile-toggle-unlock").toggle();
    $("#tree-course-list > .tile-wrap").toggleClass("tile-position-fixed");

}
function toggleCourseTileScroll(isLocked){
    
    $(".tile-toggle-unscroll").toggle();
    $(".tile-toggle-scroll").toggle();
    $("#tree-course-list .nav").toggleClass("tile-scroll");
}
function makeCourseTileColse(){
    $("#tile-course-list").removeClass("in")
    $(".fix-tile-position>").removeClass("active");
    $(".fix-tile-position>div").removeClass("dock");
}

function toggleSettingContent(){
    $("#anchor-menu").click();
}

function toggleUbox(){
    var ubox = $("#ubox")
    var header = $("header");
    var footer = $("footer");
    var content = $("#ucontent");

    ubox.toggleClass("hide");
    header.toggleClass("hide-ubox");
    footer.toggleClass("hide-ubox");
    content.toggleClass("hide-ubox");
    
    
}
function toggleUserSettings(){
    var home = $('user-home');
    var settings = $('user-settings');
    var homeLeft = home.css("left");
    var settingLeft = settings.css("left");
    var tmpLeft = settingLeft;
    
    for(;settingLeft == tmpLeft;settingLeft++,homeLeft++){
        home.css("left", homeLeft);
        settings.css("left", settingLeft);
    }
};