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
import java.util.ArrayList;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
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
    
    //返回学生信息
    @RequestMapping("/student/getpersoninfo")
    public @ResponseBody Student personal_InfInformation2(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Student std=StudentDao.getStudentBySn(sn);
        std.setStudentPwd("");
        return std;
    }
    //密码修改提交处理
    @RequestMapping("/student/updatepassword")
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
    @RequestMapping("/student/updatepersoninfo")
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
    @RequestMapping("/student/subselectcourse")
    public @ResponseBody String submitcourse(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Student std=StudentDao.getStudentBySn(sn);
        Integer cid=Integer.valueOf(request.getParameter("scid"));
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
        Integer cid=TermCourseDao.getCourseidByCourseId(request.getParameter("scid"));
        int term=getCurrentTerm();
        String []a = new String[2];
        a[0]=TermCourseInfoDao.getCourseInfo(term, cid, 0);
        a[1]=TermCourseInfoDao.getCourseInfo(term, cid, 1);
        if(a[0].equals(""))a[0]="暂无";
        if(a[1].equals(""))a[1]="暂无";
        return a;
    }
    //获取已选课程
    @RequestMapping("/student/getselectcourse")
    public @ResponseBody Map[] getselectcourse(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String stusn=getCurrentUsername();
        int xueqi=getCurrentTerm();
        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId(xueqi, stusn);
        Map []a = new Map[list.size()/2];
        for (int i = 0; i < list.size()/2; i++) {
           a[i]=new HashMap();
           a[i].put("course", list.get(2*i+1));
           a[i].put("scid", list.get(2*i));
        }
        return a;
    }   
    //获取已选未批准课程
    @RequestMapping("/student/getselectingcourse")
    public @ResponseBody Map[] getselectingcourse(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String stusn=getCurrentUsername();
        int xueqi=getCurrentTerm();
        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId2(xueqi, stusn);
        Map []a = new Map[list.size()/4];
        for (int i = 0; i < list.size()/4; i++) {
            a[i]=new HashMap();
            a[i].put("course", list.get(4*i+1));
            a[i].put("scid", list.get(4*i));
            a[i].put("teacher", list.get(4*i+2));
            a[i].put("ClassName", list.get(4*i+3));
        }
        return a;
    }   
 //返回课程页详情
    @RequestMapping("/student/stu_course")
    public @ResponseBody Map[] stu_course(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String scid=request.getParameter("scid");
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid));
        String term =TermCourseDao.getxueqiBySCId(scid).toString();
        String collage = tec.getTeacherCollege();
        String courseName =TermCourseDao.getCourseNameByCourseId(scid);
        String swf_syllabus="";
        Map []a = new Map[6];
        for (int i = 0; i < 6; i++) {a[i]=new HashMap();} 
        a[0].put("courseName",courseName);//课程名
        a[1].put("teacherName",tec.getTeacherName());//教师名
        a[2].put("teacherSn",tec.getTeacherSn());//教师工号
        a[3].put("syllabus", TermCourseInfoDao.getCourseInfo(Integer.valueOf(term), TermCourseDao.getCourseidByCourseId(scid), 0));//html版课程大纲
        a[4].put("introduction", TermCourseInfoDao.getCourseInfo(Integer.valueOf(term), TermCourseDao.getCourseidByCourseId(scid), 1));//html版课程介绍
        File f =new File(getFileFolder(request)+term +"/"+collage+"/"+courseName+"/课程大纲/");
        if(f.exists()&&f.isDirectory()){
            String[] files = f.list();
            for (String file : files) {
                if (file.toLowerCase().endsWith(".swf")) {
                    swf_syllabus="/getswf?uri="+term +"/"+collage+"/"+courseName+"/课程大纲/"+file;
                    break;
                }
            }
        }
        a[5].put("swf_syllabus",swf_syllabus);//swf版课程大纲
        return a;
    }
 //返回作业列表
    @RequestMapping("/student/stu_course_homework")
    public @ResponseBody List<Map> stu_course_homework(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String scid=request.getParameter("scid");
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid));
        String term =TermCourseDao.getxueqiBySCId(scid).toString();
        String collage = tec.getTeacherCollege();
        String courseName =TermCourseDao.getCourseNameByCourseId(scid);
        String tec_sn= tec.getTeacherSn();
        String tec_name = tec.getTeacherName();
        String stusn=getCurrentUsername();
        String ff = getFileFolder(request)+"homework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/";
        String ff2;
        int length = haveFile(ff);
        String dataString="";
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        Date d1 = new Date();
        List<Map> sumList=new ArrayList<Map>();
        for(int i = 1;i<=length;i++){
            ff2 = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+i+"/"+courseName+"/"+stusn+"/";
            System.out.println(length);
            Date d3 = df.parse(readline(ff+"/"+i+"/Workall.txt")[2]);
            if(d1.getTime() > d3.getTime()){//判断作业是否已开始
            Map a = new HashMap();
            Date d2 = df.parse(readline(ff+"/"+i+"/Workall.txt")[1]);
            File f=new File(ff2+"submitTime.txt");
            a.put("homeworkid", i);
            a.put("title", readline(ff+"/"+i+"/Workall.txt")[0]);
            a.put("deadline",readline(ff+"/"+i+"/Workall.txt")[1]); 
                if (d1.getTime() < d2.getTime()) {//判断作业是否过期
                   if (f.exists()) {
                       a.put("status", "已提交");
                       a.put("lastsubmittime", readline(ff2+"submitTime.txt")[0]);
                   }else{
                       a.put("status", "未提交");
                       a.put("lastsubmittime","");
                   }
                } else{
                   if (f.exists()) {
                       a.put("status", "已过期");
                       a.put("lastsubmittime", readline(ff2+"submitTime.txt")[0]); 
                   }else{
                       a.put("status", "已过期且未提交");
                       a.put("lastsubmittime", "");
                   } 
                }
            sumList.add(a);
            }
        }
        return sumList;
    }
      //学生选课页
    @RequestMapping("/student/addnewcourse")
    public @ResponseBody List<Map> stu_addcourse(HttpServletRequest request, HttpServletResponse response) {
        List<Map> courseList=new ArrayList<Map>();
        int xueqi=getCurrentTerm();
        List<String> coulist = CourseDao.getCourseIdByTerm(xueqi);
        for (String coulist1 : coulist) {
            boolean effective=false;
            List<String> teacher_cou = CourseDao.getTeacherSnByTermCourseId(xueqi, Integer.valueOf(coulist1));
            Map courseMap = new LinkedHashMap();
            Map stateMap = new LinkedHashMap();
            courseMap.put("text", CourseDao.getCourseById(Integer.valueOf(coulist1)).getCourseName());
            stateMap.put("expanded", false);
            courseMap.put("state",stateMap);
            if (teacher_cou.size()>0) {
            List<Map> teacherList=new ArrayList<Map>();
                for (String teacher_cou1 : teacher_cou) {
                    Map teacherMap = new LinkedHashMap();
                    teacherMap.put("text", TeacherDao.getTeacherBySn(teacher_cou1).getTeacherName());
                    List<String> stu_cou_clas = CourseDao.getClassSnByTermCourseNumber(xueqi, Integer.valueOf(coulist1), teacher_cou1);
                    if (stu_cou_clas.size()>0) {                   
                        List<Map> classList=new ArrayList<Map>();
                        for (String stu_cou_cla : stu_cou_clas) {
                            Map classMap = new LinkedHashMap();
                            classMap.put("text", ClassesDao.getClassById(Integer.valueOf(stu_cou_cla)).getClassName());
                            classMap.put("scid",StudentSelectCourseDao.getTermCourseIdByothers(xueqi, Integer.valueOf(coulist1), Integer.valueOf(stu_cou_cla), TeacherDao.getTeacherBySn(teacher_cou1).getTeacherId()));
                            classList.add(classMap);
                            effective=true;
                        }
                        teacherMap.put("nodes", classList);
                    }
                    teacherList.add(teacherMap); 
                }
            courseMap.put("nodes", teacherList);  
            }
            if (effective) {courseList.add(courseMap);}
            
        }
	return courseList;
    }
    //学生首页
    @RequestMapping("/student")
    public String stu_index(HttpServletRequest request, HttpServletResponse response) {
	return "student/Index";
    }
    //取消选课处理
    @RequestMapping("/student/cancelcourse")
    public @ResponseBody  String stuCancelCourse(HttpServletRequest request, HttpServletResponse response) {
        String scid=request.getParameter("scid");
        String stusn=getCurrentUsername();
        TeacherDao.updateStudentCourse(StudentDao.getStudentBySn(stusn).getStudentId(),Integer.valueOf(scid), true);
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
    @RequestMapping("/student/kcgs")
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
    @RequestMapping("/student/dohomework")
    public @ResponseBody Map dohomework(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String stusn=getCurrentUsername();
        int xueqi=getCurrentTerm();
        String scid = request.getParameter("scid");
        String homeworkid= request.getParameter("homeworkid");
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid));
        List list =  StudentSelectCourseDao.getStudentSelectCourseNameByTermSnCourseId2(xueqi, stusn);
        String sn=tec.getTeacherSn();
        String tec_sn= tec.getTeacherSn();
        String tec_name = tec.getTeacherName();
        String collage = tec.getTeacherCollege();
        String term =TermCourseDao.getxueqiBySCId(scid).toString();
        String courseName =TermCourseDao.getCourseNameByCourseId(scid);
        String ff = getFileFolder(request)+"homework/"+term+"/"+collage +"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/";
        Date d1 = new Date();
        Date d3 = df.parse(readline(ff+"/Workall.txt")[2]);
        Map a = new HashMap();
        List<String> HwattachmentList=new ArrayList<String>();
        if(d1.getTime() > d3.getTime()){//判断作业是否已开始
            a.put("Hwtitle", readline(ff+"/Workall.txt")[0]);
            a.put("Hwendtime", readline(ff+"/Workall.txt")[1]);
            a.put("Hwhelp", read(ff+"/textWork.html"));
            File f =new File(ff+"1/");
            if(f.exists()&&f.isDirectory()){
                String[] files = f.list();
                String ff2="/file/homework/"+term+"/"+collage +"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/1/";
                HwattachmentList.add(ff2+"1.txt");
                for (String file : files) {
                    HwattachmentList.add(ff2+file);
                }
            }   
            a.put("Hwattachment",HwattachmentList);   
            HwattachmentList.clear();
            ff = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/";
            String ff2="/file/uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/";
            a.put("HwtextWork", read(ff+"/textWork.html"));
            a.put("Hwtime", read(ff+"/submitTime.txt"));
            f =new File(ff);
            if(f.exists()&&f.isDirectory()){
                String[] files = f.list();
                for (String file : files) {
                    if(!(file.equals("textWork.html")||file.equals("submitTime.txt")) )  {
                        HwattachmentList.add(file);
                    }
                } 
          }
          a.put("Myattachment",HwattachmentList);    
        }
        return a;
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
    public @ResponseBody List<String> stuhwrefresh(HttpServletRequest request, HttpServletResponse response) throws Exception{
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
        String ff2="/file/uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid)+"/"+stusn+"/";  
        File f =new File(ff);
         List<String> HwattachmentList=new ArrayList<String>();
            if(f.exists()&&f.isDirectory()){
                String[] files = f.list();
                for (String file : files) {
                    if(!(file.equals("textWork.html")||file.equals("submitTime.txt")) )  {
                        HwattachmentList.add(file);
                    }
                } 
          }
        return HwattachmentList;
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
    public @ResponseBody List<String> courdir(HttpServletRequest request, HttpServletResponse response) throws Exception{
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
        String ff2="/file/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+dir;
        List<String> fileList=new ArrayList<String>();   
        File f =new File(ff);
        if(!f.exists()){return fileList;}
        if(f.exists()&&f.isDirectory()){
         String[] files = f.list();
         if(files.length<=0){
                 return fileList;
        }else{         
             for (String file : files) {
                 if (file.lastIndexOf(".")!=-1) {
                     fileList.add(file);
                 }              
             }    
         }
      }
        return fileList;
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
   public int getCurrentTerm() {
      return 201602;
   }
    public String getFileFolder(HttpServletRequest request) {
        String path = this.getClass().getClassLoader().getResource("/").getPath();
        System.out.println(path);
        path=path.replace("lms/target/lms-1.0/WEB-INF/classes/", "file/");
        System.out.println(path);
        return path;        
    } 
}
