/*!
 * AlohaStage, A Javascript Library Based jQuery   v0.0.1
 *
 *
 * Author : LongYeh
 *
 *
 * Copyright
 * Released under the MIT license
 *
 *
 * Date:
 */
  // lighthouse 被触发时的效果设计
 $(document).ready(function(){
     var Lstatus = 0;
     $('#lightHole').click(function(){
         var status = Lstatus;
         if ( status == 0 ){
             $('.lighthouse').animate({
                 height: "400px"
             }, 100 );
              Lstatus = 1;
         }else {
             $('.lighthouse').animate({
                 height: "0"
             }, 100 );
               Lstatus = 0;
         }
     });
 });

 $(function(){

	 var treeFrame = $(window).height();
	 var treeHeader =$("#tree-header").height();
     var treeFooter =$("#tree-footer").height();
	 var treeContent = treeFrame - treeHeader-35;

	 $("#consolebar").height(treeContent);
	 $("#consolebarToShow").height(treeContent);

    //  treeContent = treeFrame - treeHeader-treeFooter;
    //   $("#tree-body").height(treeContent);
 });

$(document).ready(function(){
    $('.course-chapter, .course-sections').children().hide();
    var gStatus = 2;
    $('.course-chapter').click(function(){
        var Status = gStatus;
        $(this).children().fadeIn('fast','linear',function(){});
        $('.course-sections').hover(
            function(){
                status = 0;
                $('.course-sections').click(function(){
                    status = 1;
                    $(this).children().fadeIn('fast','linear',function(){});
                });
            },
            function(){
                $(this).children().fadeOut('slow','linear',function(){

                });
            }
        )
        switch (status) {
            case 0:{
                $('.course-chapter').click(function(){
                    $(this).children().fadeOut('fast','linear',function(){});
                });

                break;
            }
            case 1:{
                $('.course-sections').click(function(){
                    $('.course-chapter').children().fadeOut('fast','linear',function(){});
                });
                break;
            }
            case 2:{

                break;
            }
            default:
        }
    });

})


//  课程列表 自动生成 自动显示
/* $(document).ready(function(){
     var courseList = $("#course-list li a");
     var courseListLen = courseList.length;
     var courseStatus = 0;
     var courseIDStr = $(courseList[courseStatus]).attr('href');
     var pattCourseID=/[a-z0-9-]{1,}/;
     var courseID = courseIDStr.match(pattCourseID);
    //  var courseNav = document.getElementById(courseID);

     var courseStr = '#' + courseID + ' ' + 'h3';
     var courseNav =  $(courseStr);
     for (var i=0; i<courseNav.length; i++){
         var pattCourseNavContent = /(^\s*)|(\s*$)/g;
         var courseNavContentStr = courseNav[i].innerHTML;
         var courseNavContent = courseNavContentStr.replace(pattCourseNavContent,"");

         var courseChaptersStr = '#' + courseID + ' ' + '.course-chapters' + '>' + 'ul';
         var courseChapters = $(courseChaptersStr);
         for( var j=0; j<courseChapters.length; j++){
             var courseChapterStr = '#' + courseID + ' ' + '.course-chapter' + '>' + 'li';
             var courseChapter = $(courseChapterStr);
             for(var k=0; k<courseChapter.length; k++){
                 var courseSectionsStr = '#' + courseID + ' ' + '.course-sections' + '>' + 'ul'+ '>' + '.course-section';
                 var courseSections = $(courseSectionsStr);
                 for(var t=0; t<courseSections.length; t++){
                     var pattcourseSectionContent = /(^\s*)|(\s*$)/g;
                     var courseSection = courseSections[t];
                     alert(courseSection.length);
                      alert(courseSections.length);
                       alert(courseChapter.length);
                        alert(courseChapters.length);
                 }
             }
         }


     }


    //  $(".course-item").click(fuction(){});
 });
 */
 //默认生成课程列表中第一个课程的导航

    //   var pattCourseNav=/course-\w{1,}/;
    //   var courseClassStr = $(courseNav[i]).attr('class');
    //    var courseClass = courseClassStr.match(pattCourseNav);
    //    alert(courseClass);
