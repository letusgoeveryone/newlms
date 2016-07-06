/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseDao;
import cn.edu.henu.rjxy.lms.model.Classes;
import cn.edu.henu.rjxy.lms.model.Classes1;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.MasterCourseResult;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import cn.edu.henu.rjxy.lms.model.TermCourseResult;
import cn.edu.henu.rjxy.lms.server.ClassesMethod;
import cn.edu.henu.rjxy.lms.server.CourseMethod;
import cn.edu.henu.rjxy.lms.server.StudentMethod;
import cn.edu.henu.rjxy.lms.server.TeacherMethod;
import cn.edu.henu.rjxy.lms.server.TempStudentMethod;
import cn.edu.henu.rjxy.lms.server.TempTeacherMethod;
import cn.edu.henu.rjxy.lms.server.TermClassMethod;
import cn.edu.henu.rjxy.lms.server.TermCourseMethod;
import cn.edu.henu.rjxy.lms.server.TermOpenCourseMethod;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
@Controller
public class AcdemicController {
     
    @RequestMapping("/acdemic")
    public String index2() {
        return "acdemic/console_dean";
    }
      @RequestMapping("/teacherIndex")
    public String teacher(HttpServletRequest request,HttpServletResponse response) {
       
        return "teacher/teacherIndex";
    } 
      @RequestMapping("acdemic/resetpw_p")
    public @ResponseBody String resetpw_p(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Teacher teacher=TeacherDao.getTeacherBySn(sn);
        String pw=request.getParameter("pw");
        String repw=request.getParameter("repw");
        if (!pw.equals(teacher.getTeacherPwd().toLowerCase())) {
             return "1";}
        if (pw.equals(repw.toLowerCase())) {
             return "2";}
        teacher.setTeacherPwd(repw);
        TeacherDao.updateTeacherById(teacher);
        return "3";
     }
     @RequestMapping("/acdemic/teapnda")
    public String teacher12(HttpServletRequest request,HttpServletResponse response) {
         String sn=getCurrentUsername();
         Teacher teacher = TeacherDao.getTeacherBySn(sn);
         String name = teacher.getTeacherName();
         String idCard = teacher.getTeacherIdcard();
         String qq = teacher.getTeacherQq();
         String tel =teacher.getTeacherTel();
         request.setAttribute("sn", sn);
         request.setAttribute("name",name);
         request.setAttribute("idCard",idCard );
         request.setAttribute("qq", qq);
         request.setAttribute("tel", tel);
         request.setAttribute("college", teacher.getTeacherCollege());
         request.setAttribute("zc", teacher.getTeacherPosition());
        return "acdemic/teapnda";
    } 
    
    
     @RequestMapping("/acdemic/updatetea")
    public @ResponseBody
        String update(HttpServletRequest request,HttpServletResponse response) {
        String a="0";
        System.out.println("111111111");
        String tsn=getCurrentUsername();
        Teacher teacher=TeacherDao.getTeacherBySn(tsn);
        System.out.println(tsn);
        String qq=request.getParameter("qq");
        teacher.setTeacherQq(qq);
        String name=request.getParameter("name");
        teacher.setTeacherName(name);
        String tel=request.getParameter("tel");
        teacher.setTeacherTel(tel);
        String idCard=request.getParameter("idCard");
        teacher.setTeacherIdcard(idCard);
        TeacherDao.updateTeacherById(teacher);
        return a;
    } 
    
    //修改密码
       @RequestMapping("teaPassward")
      public @ResponseBody String teaPassward(HttpServletRequest request,HttpServletResponse response){
         String sn=getCurrentUsername();
         Teacher tec = TeacherDao.getTeacherBySn(sn);
         String lastPw = request.getParameter("passPassward");
         String newPw1 = request.getParameter("passward");
         String newPw2 = request.getParameter("passward1");
         if(!newPw1.equals(newPw2)){
            return "0";//输入新密码不对
         }
         if(!tec.getTeacherPwd().equals(lastPw)){
            return "2";//输入旧密码不对
         }
         tec.setTeacherPwd(newPw2);
         TeacherDao.updateTeacherById(tec);
         return "3";
      }
      //删除临时表学生
    @RequestMapping(value="scstu", method = RequestMethod.POST)
    public @ResponseBody String scstu(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        for (String param : params) {
            TempStudentDao.deleteTempStudentById(Integer.parseInt(param)); //删除临时表学生
        }    
        return "删除成功！";
    }
    
      ////批准临时表学生
    @RequestMapping(value = "pzstu", method = RequestMethod.POST)
    public @ResponseBody String pzstu(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        System.out.println(params.length);
        for (String param : params) {
            new StudentMethod().addStudentFromtempStudent(Integer.parseInt(param));
            TempStudentDao.deleteTempStudentById(Integer.parseInt(param)); //批准的同时删除
        }    
        return "批准成功！";
    }
    
     //正式学生分页 
    @RequestMapping("/fh_zs_stume")
    public @ResponseBody
    JSONObject fhstume(HttpServletRequest request, HttpServletResponse response) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        System.out.println(pc);
        System.out.println(ps);
        PageBean<Student> pb =new StudentMethod().findAll(pc, ps);
        Map<String, Object> jsonMap;
        jsonMap = new HashMap<>();
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }
    
    //正式学生学号范围
        @RequestMapping("/xh_search")
    public @ResponseBody
    JSONObject search(HttpServletRequest request) {
       int min = Integer.parseInt(request.getParameter("min"));
       int max = Integer.parseInt(request.getParameter("max"));
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<Student> list = StudentDao.findAllStudentBySn(min, max, pc, ps);
       Map<String, Object> jsonMap = new HashMap<>();
       jsonMap.put("total", list.getTr()); 
       jsonMap.put("rows",list.getBeanList());
       return JSONObject.fromObject(jsonMap);
    }
   
     //删除正式学生的
    @RequestMapping(value = "sc_zs_xs", method = RequestMethod.POST)
    public @ResponseBody String sczsxs(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        for (String param : params) {
            if(StudentDao.deleteStudentById(Integer.parseInt(param))){
                System.out.println("success!");
            }else{
                System.out.println("删除正式表学生出错，已经存在依赖关系．");
                return "1";
            }
        }    
        return "删除成功！";
    }
    
    
    //临时学生根据学号分页
     @RequestMapping("ls_xs_search")
    public @ResponseBody
    JSONObject search_ls(HttpServletRequest request) {
       int min = Integer.parseInt(request.getParameter("min"));
       int max = Integer.parseInt(request.getParameter("max"));
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<TempStudent> list = TempStudentDao.findAllTempStudentBySn(min, max, pc, ps);
        Map<String, Object> jsonMap = new HashMap<>();
        jsonMap.put("total", list.getTr()); 
        jsonMap.put("rows",list.getBeanList());
        return JSONObject.fromObject(jsonMap);
    }
    
    
    //临时学生学院年级
     @RequestMapping("/ls_xs_xy_ni__search")
    public @ResponseBody
    JSONObject search_ls1(HttpServletRequest request) {
       String min =request.getParameter("xueyuan");
       int max = Integer.parseInt(request.getParameter("nianji"));
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       if(pc==0){
        pc++;
       }
       PageBean<TempStudent> list = TempStudentDao.findAllTempStudentByCollegeGrade(min, max, pc, ps);
        Map<String, Object> jsonMap = new HashMap<>();
        jsonMap.put("total", list.getTr()); 
        jsonMap.put("rows",list.getBeanList());
         System.out.println(list.getTr());
        return JSONObject.fromObject(jsonMap);
    }
    
     //正式学生学院年级
    @RequestMapping("/xy_nianji_search")
    public @ResponseBody
    JSONObject search_ls2(HttpServletRequest request) {
       String min =request.getParameter("xueyuan");
        System.out.println(min);
       int max = Integer.parseInt(request.getParameter("nianji"));
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<Student> list = StudentDao.findAllStudentByCollegeSn(min, max, pc, ps);
        Map<String, Object> jsonMap;
        jsonMap = new HashMap<>();
        jsonMap.put("total", list.getTr()); 
        jsonMap.put("rows",list.getBeanList());
         System.out.println(list.getTr());
        return JSONObject.fromObject(jsonMap);
    }
    
     //导出正式表学生信息
    @RequestMapping("daochuxuesheng")
    public void daochuxuesheng(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession session = request.getSession();
        session.setAttribute("state", null);
        // 生成提示信息，  
        response.setContentType("application/vnd.ms-excel");
        String codedFileName;
        codedFileName = "正式学生信息";
        OutputStream fOut = null;
        try {
            // 进行转码，使其支持中文文件名  
            codedFileName = java.net.URLEncoder.encode("中文", "UTF-8");
            response.setHeader("content-disposition", "attachment;filename=" + "student_messsage" + ".xls");
            HSSFWorkbook wb = new HSSFWorkbook();
            // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
            HSSFSheet sheet = wb.createSheet("导出的表");
            // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
            HSSFRow row = sheet.createRow((int) 0);
            // 第四步，创建单元格，并设置值表头 设置表头居中  
            HSSFCellStyle style = wb.createCellStyle();
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式 
            HSSFCell cell = row.createCell((short) 0);
            cell.setCellValue("学号");
            cell.setCellStyle(style);
            cell = row.createCell((short) 1);
            cell.setCellValue("姓名");
            cell.setCellStyle(style);
            cell = row.createCell((short) 2);
            cell.setCellValue("身份证号");
            cell.setCellStyle(style);
            cell = row.createCell((short) 3);
            cell.setCellValue("年级");
            cell.setCellStyle(style);
            cell = row.createCell((short) 4);
            cell.setCellValue("性别");
            cell.setCellStyle(style);
            cell = row.createCell((short) 5);
            cell.setCellValue("学院");
            cell.setCellStyle(style);
            cell = row.createCell((short) 6);
            cell.setCellValue("电话");
            cell.setCellStyle(style);
            cell = row.createCell((short) 7);
            cell.setCellValue("qq");
            cell.setCellStyle(style);

            List allstudent = StudentDao.getAllStudent();

            for (int i = 0; i < allstudent.size(); i++) {
                StudentWithoutPwd tmp = (StudentWithoutPwd) allstudent.get(i);
                row = sheet.createRow((int) i + 1);
                row.createCell((short) 0).setCellValue(tmp.getStudentSn());
                row.createCell((short) 1).setCellValue(tmp.getStudentName());
                row.createCell((short) 2).setCellValue(tmp.getStudentIdcard());
                row.createCell((short) 3).setCellValue(tmp.getStudentGrade());
                row.createCell((short) 4).setCellValue((tmp.isStudentSex())?("男"):("女"));
                row.createCell((short) 5).setCellValue(tmp.getStudentCollege());
                row.createCell((short) 6).setCellValue(tmp.getStudentTel());
                row.createCell((short) 7).setCellValue(tmp.getStudentQq());

            }

            fOut = response.getOutputStream();
            wb.write(fOut);
        } catch (UnsupportedEncodingException e1) {
        } catch (Exception e) {
        } finally {
            fOut.flush();
            fOut.close();
            session.setAttribute("state", "open");
        }
        System.out.println("学生文件生成...");
    
    }
    
       @RequestMapping("/fhstume")//临时学生分页
    public @ResponseBody
    JSONObject fhstume1(HttpServletRequest request, HttpServletResponse response) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        System.out.println(pc);
        System.out.println(ps);
        PageBean<TempStudent> pb = TempStudentMethod.findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }

    
    
    
    //临时教师分页
    @RequestMapping(value = "/fhjsxx", method = RequestMethod.GET)
    public @ResponseBody
    JSONObject json_test2(HttpServletRequest request, HttpServletResponse response) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        System.out.println(pc);
        System.out.println(ps);
        TempTeacherMethod teacherMethod = new TempTeacherMethod();
        PageBean<TempTeacher> pb = teacherMethod.findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }

    
     //删除临时表教师信息
    @RequestMapping("sc")
    public @ResponseBody
    String pz(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
         for (int i=0;i<params.length;i++) {  
            TempTeacherDao.deleteTempTeacherById(Integer.parseInt(params[i])); //批准的同时删除临时表教师信息
        }
        return "成功";
    }
    
    //批准的同时删除临时表教师信息
    @RequestMapping(value = "pzscjs", method = RequestMethod.POST)
    public @ResponseBody
    String pzscjsxx(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        System.out.println(params.length+"j");
       for (int i=0;i<params.length;i++){
            TeacherDao.addTeacherFromTempTeacherById(Integer.parseInt(params[i]));
//            TempTeacherDao.deleteTempTeacherById(Integer.parseInt(params[i])); 
        }

        return "批量删除成功！";
    }
    
    //正式教师信息分页
      @RequestMapping("fh_zs_jsme")
    public @ResponseBody
    JSONObject fhtecme(HttpServletRequest request, HttpServletResponse response) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        PageBean<Teacher> pb =new TeacherMethod().findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }
    
    //批量删除正式教师信息
    @RequestMapping(value = "pzsc_zs_jsxx", method = RequestMethod.POST)
    public @ResponseBody
    String pzsc_zs_jsxx(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        System.out.println(params.length+"j");
       for (int i=0;i<params.length;i++) {
            if( TeacherDao.deleteTeacherById(Integer.parseInt(params[i]))){
                System.out.println("success!");
            }else{
                System.out.println("删除正式表教师出错，已经存在依赖关系．");
                return "1";
            }      
        }
        return "批量删除成功！";
    }
    public static void main(String[] args) {
         List allteacher = TeacherDao.getAllTeacher();
         System.err.println(allteacher);
    }
    
    //正式教师根据工号范围分页
     @RequestMapping("/zs_js_search")
    public @ResponseBody
    JSONObject search_ls_js(HttpServletRequest request) {
       int min = Integer.parseInt(request.getParameter("min"));
       int max = Integer.parseInt(request.getParameter("max"));
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<Teacher> list = TeacherDao.findAllTeacherBySn(min, max, pc, ps);
       Map<String, Object> jsonMap = new HashMap<String, Object>();
       jsonMap.put("total", list.getTr()); 
       jsonMap.put("rows",list.getBeanList());
       return JSONObject.fromObject(jsonMap);
    }
    
     //匹配教师姓名
    @RequestMapping("/ppjsxx")
    public @ResponseBody String[]
     ppjsxx(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
      response.setContentType("text/html;charset=utf-8");
       request.setCharacterEncoding("UTF-8");
       String str[] = {
         "不存在"
       };
       String min =request.getParameter("value");
       if(TeacherDao.getTeacherNameBySn(request.getParameter("value")).equals("1")){ 
           System.out.println("1");
           return str;
       } else {
           str[0] = TeacherDao.getTeacherNameBySn(request.getParameter("value"));
           System.out.println("2");   
           return str;
       } 
    }
     
      //临时教师根据工号范围分页
     @RequestMapping("/ls_js_search")
    public @ResponseBody
    JSONObject search_zs(HttpServletRequest request) {
       int min = Integer.parseInt(request.getParameter("min"));
       int max = Integer.parseInt(request.getParameter("max"));
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<TempTeacher> list = TempTeacherDao.getTeachersBySn(min, max, pc, ps);
       Map<String, Object> jsonMap = new HashMap<String, Object>();
       jsonMap.put("total", list.getTr()); 
       jsonMap.put("rows",list.getBeanList());
       return JSONObject.fromObject(jsonMap);
    }
     
     //临时教师根据学院年级分页
       @RequestMapping("/ls_js_xy_search")
    public @ResponseBody JSONObject
     ppjsxx1(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
       String collage =request.getParameter("min");
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
     
       PageBean<TempTeacher> list =  TempTeacherDao.findAllTempTeacherByCollege(collage, pc, ps);
       Map<String, Object> jsonMap = new HashMap<String, Object>();
       jsonMap.put("total", list.getTr()); 
       jsonMap.put("rows",list.getBeanList());
       return JSONObject.fromObject(jsonMap);      
    }
     
      //正式教师根据学院
     @RequestMapping("/zs_js_xy_search")
    public @ResponseBody JSONObject
     ppjsxx2(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
       String collage =request.getParameter("min");
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<Teacher> list =  TeacherDao.findAllTeacherByCollege(collage, pc, ps);
       Map<String, Object> jsonMap = new HashMap<>();
       jsonMap.put("total", list.getTr()); 
       jsonMap.put("rows",list.getBeanList());
       return JSONObject.fromObject(jsonMap);      
    }
     
      
    //导出正式表教师信息
   @RequestMapping("daochualltoxls")
    public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
         System.out.println("1...");
        session.setAttribute("state", null);
        // 生成提示信息，  
        response.setContentType("application/vnd.ms-excel");
        String codedFileName;
        codedFileName = "正式教师信息";
        OutputStream fOut = null;
        try {
            // 进行转码，使其支持中文文件名  
            codedFileName = java.net.URLEncoder.encode("中文", "UTF-8");
            response.setHeader("content-disposition", "attachment;filename=" + "teacher_messsage" + ".xls");
            HSSFWorkbook wb = new HSSFWorkbook();
            // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
            HSSFSheet sheet = wb.createSheet("导出的表");
            // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
            HSSFRow row = sheet.createRow((int) 0);
            // 第四步，创建单元格，并设置值表头 设置表头居中  
            HSSFCellStyle style = wb.createCellStyle();
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式 
            HSSFCell cell = row.createCell((short) 0);
            cell.setCellValue("学号");
            cell.setCellStyle(style);
            cell = row.createCell((short) 1);
            cell.setCellValue("姓名");
            cell.setCellStyle(style);
            cell = row.createCell((short) 2);
            cell.setCellValue("身份证号");
            cell.setCellStyle(style);
            cell = row.createCell((short) 3);
            cell.setCellValue("职称");
            cell.setCellStyle(style);
            cell = row.createCell((short) 4);
            cell.setCellValue("学院");
            cell.setCellStyle(style);
            cell = row.createCell((short) 5);
            cell.setCellValue("qq");
            cell.setCellStyle(style);
            cell = row.createCell((short) 6);
            cell.setCellValue("电话");
            cell.setCellStyle(style);
            cell = row.createCell((short) 7);
            cell.setCellValue("性别");
            cell.setCellStyle(style);

            List allteacher = TeacherDao.getAllTeacher();

            for (int i = 0; i < allteacher.size(); i++) {
                TempTeacherWithoutPwd tmp = (TempTeacherWithoutPwd) allteacher.get(i);
                row = sheet.createRow((int) i + 1);
                row.createCell((short) 0).setCellValue(tmp.getTeacherSn());
                row.createCell((short) 1).setCellValue(tmp.getTeacherName());
                row.createCell((short) 2).setCellValue(tmp.getTeacherIdcard());
                row.createCell((short) 3).setCellValue(tmp.getTeacherPosition());
                row.createCell((short) 4).setCellValue(tmp.getTeacherCollege());
                row.createCell((short) 5).setCellValue(tmp.getTeacherQq());
                row.createCell((short) 6).setCellValue(tmp.getTeacherTel());
                row.createCell((short) 7).setCellValue((tmp.getTeacherSex())?("男"):("女"));

            }

            fOut = response.getOutputStream();
            wb.write(fOut);
        } catch (UnsupportedEncodingException e1) {
        } catch (Exception e) {
        } finally {
            fOut.flush();
            fOut.close();
            session.setAttribute("state", "open");
        }
        System.out.println("文件生成...");
    }
    
    
       //添加班级  
    @RequestMapping(value = "/tjbj", method = RequestMethod.POST)
    public @ResponseBody
    String tjbj(HttpServletRequest request, @RequestParam("jssz[]") String[] params) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ClassesMethod cla = new ClassesMethod();
        cla.addClass(Integer.parseInt(params[0]), params[1]);
        System.out.println(params[0] + ":" + params[1] + "\n" + "添加班级success");
        return "添加成功！";
    }
    
    
   //查看班级
    @RequestMapping(value = "/ckbj_xx", method = RequestMethod.GET)
    public @ResponseBody
    JSONObject fhtjbj(HttpServletRequest request) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        ClassesMethod cla = new ClassesMethod();
        PageBean<Classes> pb = cla.findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }
    
    //删除班级
    @RequestMapping(value = "/scbj",method = RequestMethod.POST)
    public  @ResponseBody String scbj(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        for (int i=0;i<params.length;i++) {
            if(ClassesMethod.deleteClassById(Integer.parseInt(params[i]))){
                System.out.println("success!");
            }else{
                System.out.println("删除班级出错，已经存在依赖关系．");
                return "1";
            }     
        }
        return "批量删除成功！";
    }
    
    //添加学期课程
     @RequestMapping("tj_next_course")
    public @ResponseBody String tj_next_course(HttpServletRequest request, @RequestParam("jssz[]") String[] params,
            @RequestParam("tecgh[]") String[] tec_gh,@RequestParam("term[]") String[] term,@RequestParam("courseName[]") String[] courseName){
        for(int i = 0;i<tec_gh.length;i++){
          new TermOpenCourseMethod().saveOpenCourse(Integer.parseInt(term[0]), Integer.parseInt(params[i]));
          CourseDao.saveCourseMaster(Integer.parseInt(term[0]),tec_gh[i],courseName[i]);
        }
       return "添加成功";
    }
    
    //设置的课程和课程负责人分页
    @RequestMapping("next_cs_tr")
      public @ResponseBody
      JSONObject course_fanhui1(HttpServletRequest request, HttpServletResponse response) {
        int pc;
        if( (request.getParameter("page")==" ")||Integer.parseInt(request.getParameter("page"))==0){
           pc= 1;
        }else{
           pc = Integer.parseInt(request.getParameter("page"));
        }
        System.out.println(pc);
        int ps = Integer.parseInt(request.getParameter("rows"));
        String params =  request.getParameter("term");
        PageBean<MasterCourseResult> pb =  CourseDao.findAllCourseMaster(Integer.parseInt(params), pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>(); 
        jsonMap.put("total", pb.getTr());
        jsonMap.put("rows", pb.getBeanList());
        return JSONObject.fromObject(jsonMap);
    }
      
     //添加学期班级
    @RequestMapping(value = "/tj_next_bj", method = RequestMethod.POST)
    public @ResponseBody
    String tj_next_bj(HttpServletRequest request, @RequestParam("jssz[]") String[] params
            ,@RequestParam("term[]") String[] terms) {
        for(int i = 0;i < params.length;i++){
        new TermClassMethod().saveTermClass(Integer.parseInt(params[i]),Integer.parseInt(terms[0]));
        }
        return "sucess";
    }
    //显示学期班级
    @RequestMapping(value = "/next_bj",method = RequestMethod.POST)
    public @ResponseBody JSONObject next_bj(HttpServletRequest request){
        int pc;
        if( (request.getParameter("page")==" ")||Integer.parseInt(request.getParameter("page"))==0){
           pc= 1;
        }else{
           pc = Integer.parseInt(request.getParameter("page"));
        }
       int term = Integer.parseInt(request.getParameter("term"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<Classes1> pb =  new TermClassMethod().findAll(term, pc, ps);
       System.out.println(pb.getClass()+":"+pb.getPs());
       Map<String, Object> jsonMap = new HashMap<String, Object>();
       jsonMap.put("total", pb.getTr());
       jsonMap.put("rows",  pb.getBeanList());
       return JSONObject.fromObject(jsonMap);          
    }
      
    //课程表的添加
      @RequestMapping(value = "courselist_add", method = RequestMethod.POST)
    public @ResponseBody
    String pz2(HttpServletRequest request, @RequestParam("tec_gh[]") String[] tec_gh,@RequestParam("classId[]") String[] classId) {
      String term = request.getParameter("xueqi");
      String courseName = request.getParameter("courseName");
      System.out.println(term);
      for (int i = 0 ;i < tec_gh.length;i++) { 
          new TermCourseMethod().saveTermCourse(Integer.parseInt(term), tec_gh[i], courseName,Integer.parseInt(classId[i]));
      }
      return "success";
    }
    
    //课程表的分页
    @RequestMapping("courselist_fanhui")
     public @ResponseBody JSONObject courselist_fanhui(HttpServletRequest request){
       int term = Integer.parseInt(request.getParameter("term"));
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<TermCourseResult> pb = TermCourseDao.findAll(term, pc, ps);
       System.out.println(pb.getClass()+":"+pb.getPs());
       Map<String, Object> jsonMap = new HashMap<String, Object>();
       jsonMap.put("total", pb.getTr());
       jsonMap.put("rows",  pb.getBeanList());
       return JSONObject.fromObject(jsonMap);          
    }
     
      @RequestMapping(value = "course_add", method = RequestMethod.POST)
    public @ResponseBody
    String pz2(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        String course_number = params[0];
        String course_name = params[1];
        String course_Ename =params[2];
        String  courseType = params[3];
        int faceTeacherHourse =Integer.parseInt(params[4]);
        int testTeacherHourse = Integer.parseInt(params[5]);
        int course_cridet = Integer.parseInt(params[6]);  
        System.out.println(courseType);
        CourseMethod.addCourse(course_number, course_name, course_Ename, courseType, faceTeacherHourse, testTeacherHourse, course_cridet);
       
        return "success";
    }

    //课程显示
    @RequestMapping("course_fanhui")
    public @ResponseBody
    JSONObject course_fanhui(HttpServletRequest request, HttpServletResponse response) {
        int pc;
        if( (request.getParameter("page")==" ")||Integer.parseInt(request.getParameter("page"))==0){
           pc= 1;
        }else{
           pc = Integer.parseInt(request.getParameter("page"));
        }
        int ps = Integer.parseInt(request.getParameter("rows"));
        PageBean<Course> pb = CourseMethod.findAllCourse(pc, ps);
        Map<String, Object> jsonMap = new HashMap<>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        return JSONObject.fromObject(jsonMap);
    }
    
    //课程delete
    @RequestMapping("sckc")
    public @ResponseBody
    String sckc(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        System.out.println(params[0]);
        for (String param : params){
            if(CourseMethod.deleteCourse(Integer.parseInt(param))){
                System.out.println("success!");
            }else{
                System.out.println("删除课程出错，已经存在依赖关系．");
                return "1";
            } 
        }
        return "批准删除成功";
    }
    
   
  

 //根据工号自动补全姓名
  @RequestMapping(value = "zdpqjsxm",method = RequestMethod.POST)
  public @ResponseBody String zdpq(HttpServletRequest request,@RequestParam("search-text") String params){
     System.out.println(params);
    return "accccccccccccccc";
  }
  

  //获取教务员个人资料
  @RequestMapping("/getAcdemic")
  public @ResponseBody String[] getAcdemic(HttpServletRequest request,HttpServletResponse response){
       String sn=getCurrentUsername();
       Teacher tec = TeacherDao.getTeacherBySn(sn);
       String []a = new String[6];
       a[0] = tec.getTeacherSn();
       a[1] = tec.getTeacherName();
       a[2] = tec.getTeacherSex()?"男":"女";
       a[3] = tec.getTeacherCollege();
       a[4] =  tec.getTeacherPosition();
       a[5] = tec.getTeacherIdcard();
       return a;
  }
  
   public String getCurrentUsername() {
      return SecurityContextHolder.getContext().getAuthentication().getName();
   }
    
}
