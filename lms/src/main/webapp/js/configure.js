/* 
 * 插件中心
 * 
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

function toggleCourseTileLocked(is){
    if(is===true){
        $(".tile-toggle-lock").show();
        $(".tile-toggle-unlock").hide();
    }else{
        
        $(".tile-toggle-lock").toggle();
        $(".tile-toggle-unlock").toggle();
        $(".fix-tile-position>div").toggleClass("dock");
    }
}
function makeCourseTileColse(){
    $("#tile-course-list").removeClass("in")
    $(".fix-tile-position>div").removeClass("active");
    $(".fix-tile-position>div").removeClass("dock");
}