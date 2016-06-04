/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;
import cn.edu.henu.rjxy.lms.dao.ClassesDao;
import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.StudentSelectCourseDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseInfoDao;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.Teacher;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author 刘昱
 */
@Controller
public class StuController {
    
    //返回学生信息页
    @RequestMapping("/student/PersonalInfo")
    public String personal_InfInformation(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Student std=StudentDao.getStudentBySn(sn);
        request.setAttribute("StudentId",std.getStudentSn());
        request.setAttribute("StudentName",std.getStudentName());
        request.setAttribute("StudentIdcard",std.getStudentIdcard());
        request.setAttribute("StudentGrade",std.getStudentGrade()); 
        request.setAttribute("StudentCollege",std.getStudentCollege());
        request.setAttribute("StudentCollege2","\""+std.getStudentCollege()+"\"");
        request.setAttribute("StudentSex",(std.getStudentSex())?("男"):("女"));
        request.setAttribute("StudentTel",std.getStudentTel());
        request.setAttribute("StudentQq",std.getStudentQq()); 
        return "student/PersonalInfo";
    }
    //返回密码修改页
    @RequestMapping("/student/ResetPasswd")
    public String resetpassword(HttpServletRequest request, HttpServletResponse response) {
        return "student/ResetPasswd";
    }
    //密码修改提交处理
    @RequestMapping("/student/resetpw_p")
    public @ResponseBody String resetpassword_p(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Student std=StudentDao.getStudentBySn(sn);
        String pw=request.getParameter("pw");
        String repw=request.getParameter("repw");
        if (!pw.equals(std.getStudentPwd().toLowerCase())) {
             return "1";}
        if (pw.equals(repw.toLowerCase())) {
             return "2";}
        std.setStudentPwd(repw);
        StudentDao.updateStudent(std);
        return "3";
    }
    //个人信息修改提交处理
    @RequestMapping("/student/resetinf_p")
    public @ResponseBody String resetinf_p(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Student std=StudentDao.getStudentBySn(sn);
        String name=request.getParameter("name");
        String idcard=request.getParameter("idcard");
        String grade=request.getParameter("grade");
        String college=request.getParameter("college");
        String sex=request.getParameter("sex");
        String telnum=request.getParameter("telnum");
        String qqnum=request.getParameter("qqnum");
        std.setStudentName(name);
        std.setStudentIdcard(idcard);
        std.setStudentGrade(Integer.valueOf(grade));
        std.setStudentCollege(college);
        std.setStudentSex(sex.equals("男"));
        std.setStudentTel(telnum);
        std.setStudentQq(qqnum);
        StudentDao.updateStudent(std);
        return "1";
    }
    //学生选课提交处理
    @RequestMapping("/student/subcourse")
    public @ResponseBody String submitcourse(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Student std=StudentDao.getStudentBySn(sn);
        Integer cid=Integer.valueOf(request.getParameter("cid"));
        try {
            StudentSelectCourseDao.saveStudentSelectCourse(sn,cid,0);
        } catch (Exception e) {
            return "0";
        }
        return "1";
        
    }
      //选课时展示的课程页
    @RequestMapping("/student/getkcjs")
    public @ResponseBody String[] stugetkcjs(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Integer cid=TermCourseDao.getCourseidByCourseId(request.getParameter("cid"));
        int term=201601;
        String []a = new String[2];
        a[0]=TermCourseInfoDao.getCourseInfo(term, cid, 0);
        a[1]=TermCourseInfoDao.getCourseInfo(term, cid, 1);
        if(a[0].equals(""))a[0]="暂无";
        if(a[1].equals(""))a[1]="暂无";
        return a;
    }
    //返回课程页详情
    @RequestMapping("/student/Course")
    public String Course(HttpServletRequest request, HttpServletResponse response) throws Exception{
         String cid=request.getParameter("cou");
         request.setAttribute("scid",cid);
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(cid));
        String sn=tec.getTeacherSn();
        String tec_sn= tec.getTeacherSn();
        String tec_name = tec.getTeacherName();
        String collage = tec.getTeacherCollege();
        String stusn=getCurrentUsername();
        String term =TermCourseDao.getxueqiBySCId(cid).toString();
        String courseName =TermCourseDao.getCourseNameByCourseId(cid);
        String ff = getFileFolder(request)+"homework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/";
        String ff2;
        int length = haveFile(ff);
        String dataString="";
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        Date d1 = new Date();
        for(int i = 1;i<=length;i++){
            ff2 = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+i+"/"+TermCourseDao.getclassNameByCourseId(cid)+"/"+stusn+"/";
            Date d3 = df.parse(readline(ff+"/"+i+"/Workall.txt")[2]);
            if(d1.getTime() > d3.getTime()){//判断作业是否已开始
            Date d2 = df.parse(readline(ff+"/"+i+"/Workall.txt")[1]);
             File f=new File(ff2+"submitTime.txt");
           if (d1.getTime() < d2.getTime()) {//判断作业是否过期
               if (f.exists()) {
                    dataString=dataString+ "<tr><td>"+i+"</td><td>"+readline(ff+"/"+i+"/Workall.txt")[0]+"</td><td>已提交[上次提交:"+readline(ff2+"submitTime.txt")[0]+"]</td><td>"+readline(ff+"/"+i+"/Workall.txt")[1]+"</td><td><a href=\"dohomework?scid="+cid+"&homeworkid="+i+"\" >"+"作业详情</a></td></tr>";
               }else{
                    dataString=dataString+ "<tr><td>"+i+"</td><td>"+readline(ff+"/"+i+"/Workall.txt")[0]+"</td><td>可提交[尚未提交]</td><td>"+readline(ff+"/"+i+"/Workall.txt")[1]+"</td><td><a href=\"dohomework?scid="+cid+"&homeworkid="+i+"\" >"+"作业详情</a></td></tr>";
               }
           } else{
               if (f.exists()) {
                    dataString=dataString+ "<tr><td>"+i+"</td><td>"+readline(ff+"/"+i+"/Workall.txt")[0]+"</td><td>已过期[最后提交:"+readline(ff2+"submitTime.txt")[0]+"]</td><td>"+readline(ff+"/"+i+"/Workall.txt")[1]+"</td><td><a href=\"dohomework?scid="+cid+"&homeworkid="+i+"\" >"+"作业详情</a></td></tr>";
               }else{
                    dataString=dataString+ "<tr><td>"+i+"</td><td>"+readline(ff+"/"+i+"/Workall.txt")[0]+"</td><td>已过期[尚未提交]</td><td>"+readline(ff+"/"+i+"/Workall.txt")[1]+"</td><td><a href=\"dohomework?scid="+cid+"&homeworkid="+i+"\" >"+"作业详情</a></td></tr>";
               } 
           }
            }
        }
        
        request.setAttribute("homework",dataString);
        request.setAttribute("syllabusspan",TermCourseInfoDao.getCourseInfo(Integer.valueOf(term), TermCourseDao.getCourseidByCourseId(cid), 1));
        File f =new File(getFileFolder(request)+term +"/"+collage+"/"+courseName+"/课程大纲/");
        ff2="../getswf?uri="+term +"/"+collage+"/"+courseName+"/课程大纲/";
        if(f.exists()&&f.isDirectory()){
        String[] files = f.list();
        String tmpString=null;
        StringBuffer sb=new StringBuffer();
        sb.append("<ol class=\"breadcrumb\" id=\"breadcour\">\n" );  

            for (String file : files) {
                if (file.lastIndexOf(".")!=-1) {
                     if((file.substring(file.lastIndexOf("."), file.length())).toLowerCase().equals(".swf")){
                        sb.append("<li><a href=\""+ff2+file+"\" target=\"swfplayer2\">"+file+"</a></li>");  
                        tmpString=ff2+file;
                    }
                }
        }

            sb.append("</ol><iframe src=\""+tmpString+"\" id=\"swfplayer2\" frameborder=\"0\" scrolling=\"no\" marginheight=\"0\" height=\"600px\" width=\"900px\" name=\"swfplayer2\"></iframe>" );  
            if(tmpString!=null){request.setAttribute("Coursesb",sb.toString());}
            
        }
         request.setAttribute("CourseDescription",TermCourseInfoDao.getCourseInfo(Integer.valueOf(term), TermCourseDao.getCourseidByCourseId(cid), 0));
	return "student/Course";
    }

    //学生选课页
    @RequestMapping("/student/JoinCourse")
    public String stu_addcourse(HttpServletRequest request, HttpServletResponse response) {
        String sumcourse="";
        Integer xueqi=Integer.valueOf("201601");
         List<String> coulist = CourseDao.getCourseIdByTerm(xueqi);
        for (String coulist1 : coulist) {
            sumcourse = sumcourse+ "{text: \"" + CourseDao.getCourseById(Integer.valueOf(coulist1)).getCourseName() + "\",state: {expanded: false},";
            List<String> teacher_cou = CourseDao.getTeacherSnByTermCourseId(xueqi, Integer.valueOf(coulist1));
            if (teacher_cou.size()>0) {
                sumcourse=sumcourse+ "nodes: [";
                for (String teacher_cou1 : teacher_cou) {
                    sumcourse = sumcourse+ "{text: \"" + TeacherDao.getTeacherBySn(teacher_cou1).getTeacherName() + "\",";
                    List<String> stu_cou_clas = CourseDao.getClassSnByTermCourseNumber(xueqi, Integer.valueOf(coulist1), teacher_cou1);
                    if (stu_cou_clas.size()>0) {
                        sumcourse=sumcourse+ "nodes: [";
                        for (String stu_cou_cla : stu_cou_clas) {
                            sumcourse = sumcourse+ "{text: \"" + ClassesDao.getClassById(Integer.valueOf(stu_cou_cla)).getClassName() + "\"" + ",coid: \"" + StudentSelectCourseDao.getTermCourseIdByothers(xueqi, Integer.valueOf(coulist1), Integer.valueOf(stu_cou_cla), TeacherDao.getTeacherBySn(teacher_cou1).getTeacherId()) + "\"," + "},";
                        }
                        sumcourse=sumcourse+ "],";
                    }
                    sumcourse=sumcourse+ "},";
                } //j for end
                sumcourse=sumcourse+ "],";
            }
            sumcourse=sumcourse+ "},"; 
        }
	request.setAttribute("Course","["+sumcourse+"]");
	return "student/JoinCourse";
    }
    //学生首页
    @RequestMapping("/student")
    public String stu_index(HttpServletRequest request, HttpServletResponse response) {
        String stusn=getCurrentUsername();
	request.setAttribute("username",stusn);
        Integer xueqi=Integer.valueOf("201601");
        StringBuffer sb=new StringBuffer();

        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId(xueqi, stusn);
        for (int i = 0; i < list.size()/2; i++) {
            sb.append("<li><a href=\"./student/Course?cou="+list.get(2*i)+"\" target=\"coucontent\">"+list.get(2*i+1)+"</a></li>");
 
        }
        request.setAttribute("stucou",sb.toString());
        sb=new StringBuffer();
        list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId2(xueqi, stusn);
         for (int i = 0; i < list.size()/4; i++) {
            sb.append("<li><a href=\"./student/Course_noready?scid="+list.get(4*i)+"\" target=\"noreadycoucontent\">"+list.get(4*i+1)+"</a></li>");
        }
        request.setAttribute("noreadycou",sb.toString());
       
       
	return "student/Index";
    }
    //刷新已选、未选 span
    @RequestMapping("/student/refleshspan")
    public @ResponseBody String[] refleshspan(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String stusn=getCurrentUsername();
        Integer xueqi=Integer.valueOf("201601");
        StringBuffer sb=new StringBuffer();
        String []a = new String[2];
        sb.append("<ol type='1' class='' >");
        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId(xueqi, stusn);
        for (int i = 0; i < list.size()/2; i++) {
            sb.append("<li><a href='./student/Course?cou="+list.get(2*i)+"' target='coucontent'>"+list.get(2*i+1)+"</a></li>");
        }
        sb.append("</ol>");
        a[0]=sb.toString();
        sb=new StringBuffer();
        sb.append("<ol type='1' class='' >");
        list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId2(xueqi, stusn);
         for (int i = 0; i < list.size()/4; i++) {
            sb.append("<li><a href='./student/Course_noready?scid="+list.get(4*i)+"' target='noreadycoucontent'>"+list.get(4*i+1)+"</a></li>");
        }
        sb.append("</ol>");
        a[1]=sb.toString();
        return a;
    }
    
//    //获取已批准课程tree_json
//    @RequestMapping("/student/getreadycourse")
//    public @ResponseBody String[] getReadyCourse(HttpServletRequest request, HttpServletResponse response) throws Exception{
//         String stusn=getCurrentUsername();
//        Integer xueqi=Integer.valueOf("201601");
//        StringBuffer sb=new StringBuffer();
//        sb.append("[");
//        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId(xueqi, stusn);
//        for (int i = 0; i < list.size()/2; i++) {
//            sb.append("{\"text\": \""+list.get(2*i+1)+"\",\"href\": \""+list.get(2*i)+"\"}");
//            if (i != list.size()/2-1) {
//                sb.append(",");
//            }
//        }
//        sb.append("]");
//        String []a = new String[1];
//        a[0]=sb.toString();
//        return a;
//    }
//    //获取未批准课程tree_json
//    @RequestMapping("/student/getnoreadycourse")
//    public @ResponseBody String[] getnoReadyCourse(HttpServletRequest request, HttpServletResponse response) throws Exception{
//         String stusn=getCurrentUsername();
//        Integer xueqi=Integer.valueOf("201601");
//        StringBuffer sb=new StringBuffer();
//        sb.append("[");
//        
//
//        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId2(xueqi, stusn);
//        for (int i = 0; i < list.size()/4; i++) {
//            sb.append("{\"text\": \""+list.get(4*i+1)+"\",\"href\": \""+list.get(4*i)+"\"}");
//            if (i != list.size()/4-1) {
//                sb.append(",");
//            }
//        }
//        sb.append("]");
//        String []a = new String[1];
//        a[0]=sb.toString();
//        return a;
//    }
    //查看未批准课程详情
    @RequestMapping("/student/stu_course_noready")
    public String stulistwpzcourse(HttpServletRequest request, HttpServletResponse response) {
        String stusn=getCurrentUsername();
        String cid = request.getParameter("scid");
        int term=201601;
        int courseid=TermCourseDao.getCourseidByCourseId(cid);
        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId2(term, stusn);
        for (int i = 0; i < list.size()/4; i++) {
            if (list.get(4*i).toString().equals(cid)) {
                request.setAttribute("noreadycou","您选择的是&nbsp;"+list.get(4*i+1)+">>"+list.get(4*i+2)+">>"+list.get(4*i+3)+"&nbsp;&nbsp;&nbsp;<a class='btn btn-primary button-small' onclick='giveupnoreadycou("+cid+")'>取消选课»</a>");
            }
        }
        request.setAttribute("syllabusspan2",TermCourseInfoDao.getCourseInfo(term, courseid, 1));
        request.setAttribute("CourseDescription2",TermCourseInfoDao.getCourseInfo(term, courseid, 0));
        

        return "guestcour";
	
    }    
    
//    //返回选课未批准页
//    @RequestMapping("/student/stu_listwpzcourse")
//    public String stulistwpzcourse(HttpServletRequest request, HttpServletResponse response) {
//        String stusn=getCurrentUsername();
//        Integer xueqi=Integer.valueOf("201601");
//        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId2(xueqi, stusn);
//        String cou="";
//              for (int i = 0; i < list.size()/4; i++) {
//        cou=cou+ "<tr><td>"+list.get(4*i+1)+"</td><td>"+list.get(4*i+2)+"</td><td>"+list.get(4*i+3)+"</td><td><a href=\"cancelcourse?scid="+list.get(4*i)+"\" >"+"取消申请</a></td></tr>";
//        }
//       request.setAttribute("wpzCourse",cou);
//	return "student/stu_listwpzcourse";
//    }
    //取消选课处理
    @RequestMapping("/student/cancelcourse")
    public @ResponseBody  String stuCancelCourse(HttpServletRequest request, HttpServletResponse response) {
        String scid=request.getParameter("scid");
        String stusn=getCurrentUsername();
        System.out.println("Courseid:"+TermCourseDao.getCourseidByCourseId(scid));   
        TeacherDao.updateStudentCourse(StudentDao.getStudentBySn(stusn).getStudentId(),Integer.valueOf(scid), true);
        Integer xueqi=TermCourseDao.getxueqiBySCId(scid);
        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId2(xueqi, stusn);
        String cou="";
              for (int i = 0; i < list.size()/4; i++) {
        cou=cou+ "<tr><td>"+list.get(4*i+1)+"</td><td>"+list.get(4*i+2)+"</td><td>"+list.get(4*i+3)+"</td><td><a href=\"cancelcourse?scid="+list.get(4*i)+"\" >"+"取消申请</a></td></tr>";
        }
       request.setAttribute("wpzCourse",cou);
	return "1";
    }
    //学生退选课程处理
    @RequestMapping("/student/quitcourse")
    public @ResponseBody String stuQuitCourse(HttpServletRequest request, HttpServletResponse response) {
        String scid=request.getParameter("scid");
        String stusn=getCurrentUsername();
        TeacherDao.updateStudentCourse(StudentDao.getStudentBySn(stusn).getStudentId(),Integer.valueOf(scid), true);
	return "1";
    }
    //返回课程内容目录树json
    @RequestMapping(value="/student/kcgs")
    public @ResponseBody String lookMulu(HttpServletRequest request, HttpServletResponse response) throws Exception{
      String cid=request.getParameter("scid");
      Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(cid));
      String sn=tec.getTeacherSn();
      String tec_sn= tec.getTeacherSn();
      String tec_name = tec.getTeacherName();
      String collage = tec.getTeacherCollege();
      String term =TermCourseDao.getxueqiBySCId(cid).toString();
      String courseName =TermCourseDao.getCourseNameByCourseId(cid);
      return read((getFileFolder(request)+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程目录结构"+"/"+"test.json").replaceAll("\\\\", "/"));
  }
    //返回作业详情
    @RequestMapping("/student/Homework")
    public String dohomework(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String stusn=getCurrentUsername();
        String scid = request.getParameter("scid");
        String homeworkid= request.getParameter("homeworkid");
        request.setAttribute("scid",scid);
        request.setAttribute("homeworkid",homeworkid);
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid));
        String sn=tec.getTeacherSn();
        String tec_sn= tec.getTeacherSn();
        String tec_name = tec.getTeacherName();
        String collage = tec.getTeacherCollege();
        String term =TermCourseDao.getxueqiBySCId(scid).toString();
        String courseName =TermCourseDao.getCourseNameByCourseId(scid);
        String ff = getFileFolder(request)+"homework/"+term+"/"+collage +"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/";
        Date d1 = new Date();
        Date d3 = df.parse(readline(ff+"/Workall.txt")[2]);
        if(d1.getTime() > d3.getTime()){//判断作业是否已开始
        request.setAttribute("Hwtitle",readline(ff+"/Workall.txt")[0]);
        request.setAttribute("Hwendtime",readline(ff+"/Workall.txt")[1]);  
        request.setAttribute("Hwhelp",read(ff+"/textWork.html")); 
        
        File f =new File(ff+"1/");
        if(f.exists()&&f.isDirectory()){
        String[] files = f.list();
        String ff2="../file/homework/"+term+"/"+collage +"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/1/";
        StringBuffer sb=new StringBuffer();
            for (String file : files) {
                sb.append("<li><a href=\""+ff2+file+"\">"+file+"</a></li>");  
            }
         request.setAttribute("Hwattachment",sb.toString()); 
        }
        
        ff = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/";
        String ff2="../file/uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/";
        request.setAttribute("HwtextWork",read(ff+"/textWork.html")); 
        request.setAttribute("Hwtime",read(ff+"/submitTime.txt")); 
         f =new File(ff);
        if(f.exists()&&f.isDirectory()){
        String[] files = f.list();
        StringBuffer sb=new StringBuffer();
            for (String file : files) {
                if(!(file.equals("textWork.html")||file.equals("submitTime.txt")) )  
                sb.append("<li><a href=\"downattach?src="+file+"&homeworkid="+homeworkid+"&scid="+scid+"\">"+file+"</a>&nbsp;&nbsp;<a href=\"#\" onclick=\"delmyattach('delattach?src="+file+"&homeworkid="+homeworkid+"&scid="+scid+"')\">删除</a></li>");  
            }
             request.setAttribute("Myattachment",sb.toString());  
            }
        return "student/Homework";
        }else{//作业未开始
        return "redirect:"+request.getHeader("Referer");
        }
        
  }
    //学生上传作业处理
    @RequestMapping("student/homeworksubmit")
    public @ResponseBody String homeworksubmit(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
      String textWork=request.getParameter("HwEitor");
      String cid=request.getParameter("scid");
      String stusn=getCurrentUsername();
      String homeworkid=request.getParameter("homeworkid");
      Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(cid));
      String sn=tec.getTeacherSn();
      String tec_sn= tec.getTeacherSn();
      String tec_name = tec.getTeacherName();
      String collage = tec.getTeacherCollege();
      String term =TermCourseDao.getxueqiBySCId(cid).toString();
      String courseName =TermCourseDao.getCourseNameByCourseId(cid);
      String ff = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(cid)+"/"+stusn+"/";
      String ff2 = getFileFolder(request)+"homework/"+term+"/"+collage +"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/";
      DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
      Date d1 = new Date();
      Date d2 = df.parse(readline(ff2+"/Workall.txt")[1]);
      if (d1.getTime() < d2.getTime()) {//判断作业没有过期
      file(ff);
      System.out.println(textWork);
      if(textWork.trim().equals(""))
      {System.out.println( "无内容" );
      }else{
       OutputStreamWriter pw = null;//定义一个流
       pw = new OutputStreamWriter(new FileOutputStream(new File(ff+"textWork.html")),"GBK");
       pw.write(textWork);
       pw.close();
       
       pw = new OutputStreamWriter(new FileOutputStream(new File(ff+"submitTime.txt")),"GBK");
       pw.write(df.format(new Date()));
       pw.close();
      }
      return "1";     
            }

 return "0";    
  } 
    //学生作业附件刷新
    @RequestMapping("/student/stuhwrefresh")
    public @ResponseBody String[] stuhwrefresh(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String stusn=getCurrentUsername();
        String scid = request.getParameter("scid");
        String homeworkid= request.getParameter("homeworkid");
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid));
        String sn=tec.getTeacherSn();
        String tec_sn= tec.getTeacherSn();
        String tec_name = tec.getTeacherName();
        String collage = tec.getTeacherCollege();
        String term =TermCourseDao.getxueqiBySCId(scid).toString();
        String courseName =TermCourseDao.getCourseNameByCourseId(scid);
        String ff = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/";
        String ff2="../file/uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/";
        request.setAttribute("HwtextWork",read(ff+"/textWork.html")); 
        File f =new File(ff);
        StringBuffer sb=new StringBuffer();
         sb.append("<ol class=\"breadcrumb\" id=\"breadcour2\">");
        if(f.exists()&&f.isDirectory()){
        String[] files = f.list();
        
            for (String file : files) {
                if(!(file.equals("textWork.html")||file.equals("submitTime.txt")) )  
                sb.append("<li><a href=\"downattach?src="+file+"&homeworkid="+homeworkid+"&scid="+scid+"\">"+file+"</a>&nbsp;&nbsp;<a href=\"#\" onclick=\"delmyattach('delattach?src="+file+"&homeworkid="+homeworkid+"&scid="+scid+"')\">删除</a></li>");  
             }
         
        }
        sb.append("</ol>");
        String []a = new String[1];
        a[0]=sb.toString() ;
        return a;
    }
    //学生作业附件下载
    @RequestMapping("/student/downattach")
    public @ResponseBody String[] downattach(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String stusn=getCurrentUsername();
        String scid = request.getParameter("scid");
        String src = request.getParameter("src");
        String homeworkid= request.getParameter("homeworkid");
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid));
        String sn=tec.getTeacherSn();
        String tec_sn= tec.getTeacherSn();
        String tec_name = tec.getTeacherName();
        String collage = tec.getTeacherCollege();
        String term =TermCourseDao.getxueqiBySCId(scid).toString();
        String courseName =TermCourseDao.getCourseNameByCourseId(scid);
        String ff = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/"+src;
        System.out.println(ff);
        File f=new File(ff);
        String []a = new String[1];
        a[0]="";
        HttpSession session = request.getSession();
        session.setAttribute("state", null);
        try {
        FileInputStream inputStream = new FileInputStream(f);
        byte[] data = new byte[(int)f.length()];
        int length = inputStream.read(data);
        inputStream.close();
        response.setContentType("application/octet-stream");
        if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) { 
            response.setHeader("content-disposition", "attachment;filename=" + new String (src.getBytes("gb2312"), "UTF-8"));
        } else {  
            response.setHeader("content-disposition", "attachment;filename=" + new String (src.getBytes("gb2312"), "ISO8859-1" ));
        }  
        OutputStream stream = response.getOutputStream();
        stream.write(data);
        stream.flush();
        stream.close(); 
        } catch (Exception e) {
        } finally {
            session.setAttribute("state", "open");
        }
        return a;
    }
    //学生作业附件删除
    @RequestMapping("/student/delattach")
    public @ResponseBody String delattach(HttpServletRequest request, HttpServletResponse response) throws Exception{
              String stusn=getCurrentUsername();
        String scid = request.getParameter("scid");
        String src = request.getParameter("src");
        String homeworkid= request.getParameter("homeworkid");
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid));
        String sn=tec.getTeacherSn();
        String tec_sn= tec.getTeacherSn();
        String tec_name = tec.getTeacherName();
        String collage = tec.getTeacherCollege();
        String term =TermCourseDao.getxueqiBySCId(scid).toString();
        String courseName =TermCourseDao.getCourseNameByCourseId(scid);
        String ff = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/"+src;
         String ff2 = getFileFolder(request)+"homework/"+term+"/"+collage +"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/";
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
      Date d1 = new Date();
      Date d2 = df.parse(readline(ff2+"/Workall.txt")[1]);
      if (d1.getTime() < d2.getTime()) {//判断作业没有过期
        File f=new File(ff);
        f.delete();
        return "ok";
      }
        return "error";

 
        
    }
    //返回课程目录树下面列表
    @RequestMapping("/student/courdir")
    public @ResponseBody String[] courdir(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String stsn=getCurrentUsername();
        String scid=request.getParameter("scid");
        String dir=request.getParameter("dir");
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid));
        String tec_sn= tec.getTeacherSn();
        String tec_name = tec.getTeacherName();
        String collage = tec.getTeacherCollege();
        String term =TermCourseDao.getxueqiBySCId(scid).toString();
        String courseName =TermCourseDao.getCourseNameByCourseId(scid);
        String ff=getFileFolder(request)+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+dir;
        String ff2="../file/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+dir;
        String ff3="../getswf?uri="+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+dir;
        String ff4="../getvideo?uri="+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+dir;
        String []a = new String[1];
        a[0]="";
        String dlc="";
        File f =new File(ff);
        if(!f.exists()){ a[0]="<ol class=\"breadcrumb\" id=\"breadcour\"><p>此目录下暂无资源</p></ol>";}
        if(f.exists()&&f.isDirectory()){
         String[] files = f.list();
            System.out.println(ff+"===="+files.length);
         if(files.length<=0){
             a[0]="<ol class=\"breadcrumb\" id=\"breadcour\"><p>此目录下暂无资源</p></ol>";
         }else{
             boolean swf=false;
             boolean ddoc=false;
             
             for (String file : files) {
                 System.out.println(file);
                 if (file.lastIndexOf(".")!=-1) {
                     if((file.substring(file.lastIndexOf("."), file.length())).toLowerCase().equals(".swf")){
                 swf=true;
                 a[0]=a[0]+"<li><a href=\""+ff3+file+"\" target=\"swfplayer\" onclick=\"setheight()\">"+file+"</a></li>";
                     }else if((file.substring(file.lastIndexOf("."), file.length())).toLowerCase().equals(".mp4")){
                 swf=true;
                 a[0]=a[0]+"<li><a href=\""+ff4+file+"\" target=\"swfplayer\" onclick=\"setheight()\">"+file+"</a></li>";   
                     }else{
                 ddoc=true;
                 dlc=dlc+"<li><a href=\""+ff2+file+"\">"+file+"</a></li>";
                 }
                 }
                  
             }
             if(swf){a[0]="<ol class=\"breadcrumb\" id=\"breadcour\"><p>以下是可供在线预览的资源</p>"+a[0]+"</ol>";}
             if(ddoc){a[0]=a[0]+"<ol class=\"breadcrumb\" id=\"breadcour\"><p>以下是可以下载的资源</p>"+dlc+"</ol>";}
             if (a[0].equals("")) {a[0]="<ol class=\"breadcrumb\" id=\"breadcour\"><p>此目录下暂无资源</p></ol>";}
         }
      }
        for(String c:a){
            System.out.println(c);
        }
        return a;
    }
    //判断目录是否存在，不存在则创建
    public boolean file(String path){
      File f = new File(path);
      if(!f.exists()&&!f.isDirectory()){
          f.mkdirs();
          return true;
      }
        return true;   
    }
    //判断目录下是否有文件或目录
    public int haveFile(String path){
     int length = 0;
     File f =new File(path);
     if(f.exists()&&f.isDirectory()){
         String[] files = f.list();
         if(files.length==0){
          System.out.println("空");
          return 0;
         }else{
          length = files.length; 
         }
      }
       return length;
    }
    //读出文本内容
    public String read(String ff){
       String fileContent = "";    
       try{      
        File f = new File(ff);     
        if(f.isFile()&&f.exists()){      
            InputStreamReader read = new InputStreamReader(new FileInputStream(f),"gbk");      
            BufferedReader reader=new BufferedReader(read);      
            String line;      
            while ((line = reader.readLine()) != null)  
            {       
                fileContent += line;      
            }        
            read.close();     
        }    
      } catch (Exception e){        
        e.printStackTrace();    
      }    
      return fileContent;
    }
    //java一行一行读取txt文件 
    public String[] readline(String path) throws FileNotFoundException, IOException{
        String []a = new String [3];
        File file = new File(path);//Text文件
        BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
        String s = null;
        int i = 0;
        while((s = br.readLine())!=null){//使用readLine方法，一次读一行 
            a[i] = s;
            i++;  
        }
        br.close();
        return a;
     }
    public String getCurrentUsername() {
      return SecurityContextHolder.getContext().getAuthentication().getName();
   }
    public String getFileFolder(HttpServletRequest request) {
//        String uri=getClass().getResource("/").getFile();  
//        uri=uri.replace("build/web/WEB-INF/classes/", "web/file/");
        String path = this.getClass().getClassLoader().getResource("/").getPath();
        System.out.println(path);
        path=path.replace("build/web/WEB-INF/classes/", "build/web/file/");
        System.out.println(path);
        return path;
    }
}
