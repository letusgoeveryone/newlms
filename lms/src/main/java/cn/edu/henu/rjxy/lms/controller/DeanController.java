/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.model.ManageResult;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import cn.edu.henu.rjxy.lms.server.StudentMethod;
import cn.edu.henu.rjxy.lms.server.TeacherMethod;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
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
import cn.edu.henu.rjxy.lms.server.AuthorityManage;
import cn.edu.henu.rjxy.lms.server.CurrentInfo;
import net.sf.json.JSONArray;
/**
 *
 * @author Administrator
 */
@Controller
public class DeanController {
    @RequestMapping("/dean")
     public String personal_InfInformation(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("username",SecurityContextHolder.getContext().getAuthentication().getName());
        String sn=AuthorityManage.getCurrentUsername();
        Teacher tec = TeacherDao.getTeacherBySn(sn);
        int avatarId = tec.getTeacherImg();
        Boolean sex = tec.getTeacherSex();
        
        if(avatarId == 0){
            if(!sex){
                request.setAttribute("avatar", "female");
            }
            else{
                request.setAttribute("avatar", "male");
            }
            
        }else{
            
            request.setAttribute("avatar", avatarId);
        }
        
        return "dean/Index";
     }
     
     @RequestMapping("/stu_index2")
     public String stu2(HttpServletRequest request, HttpServletResponse response) {


         return "stu_index2";
     }
    
    @RequestMapping("/dean/pinfo")
    public String pinfo(HttpServletRequest request, HttpServletResponse response) {

        return "/dean/PersonalInfo";
    }
    
    @RequestMapping("dean/pmanage")
    public String PersonManage(HttpServletRequest request, HttpServletResponse response) {
        return "dean/PersonManage";
    }
    //更新头像id
    @RequestMapping("/dean/updateimgid")
    public @ResponseBody String deanUpdateimgid(HttpServletRequest request, HttpServletResponse response) {
        return AuthorityManage.updateTecImgId(request, response);
    }
        //返回admin信息
    @RequestMapping("/dean/getpersoninfo")
    public @ResponseBody Teacher deanPersonalInformation(HttpServletRequest request, HttpServletResponse response) {
        return AuthorityManage.GetTecPersonalInfo();
    }
     //个人信息修改提交处理
    @RequestMapping("/dean/updatepersoninfo")
    public @ResponseBody String deanUpdatePersonInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return AuthorityManage.UpdateTecPersonlInfo(request, response);
    }
    //密码修改提交处理
    @RequestMapping("/dean/updatepassword")
    public @ResponseBody String deanUpdatePassword(HttpServletRequest request, HttpServletResponse response) {
        return AuthorityManage.UpdateTecPassword(request, response);
    } 
//     @RequestMapping("/dean/MyInfo")
//     public String myInfo_InfInformation(HttpServletRequest request, HttpServletResponse response) {
//         String sn=getCurrentUsername();
//         Teacher teacher = TeacherDao.getTeacherBySn(sn);
//         request.setAttribute("sn", sn);
//         request.setAttribute("name", teacher.getTeacherName());
//         request.setAttribute("idCard", teacher.getTeacherIdcard());
//         request.setAttribute("qq", teacher.getTeacherQq());
//         request.setAttribute("tel", teacher.getTeacherTel());
//         return "dean/MyInfo";
//     }
     @RequestMapping("/dean/deanButton")
     public String deanButton(HttpServletRequest request, HttpServletResponse response) {


         return "dean/deanButton";
     }
    @RequestMapping("/dean/szlsjsxx")
    public String szlsjsxx(HttpServletRequest request, HttpServletResponse response) {
        return "dean/teacherManager";
     }
     @RequestMapping("/dean/szxs")
    public String szxs(HttpServletRequest request, HttpServletResponse response) {
        return "dean/studentzs";
     }

    @RequestMapping("/dean/end")
    public @ResponseBody  String end(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("end");
        return "1";
    }
    
    @RequestMapping("/dean/start")
    public @ResponseBody  String start(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try {
            Properties p = new Properties();
            String x = System.getProperty("file.separator");
            File f = new File("D:"+x+"My.ini");
            System.out.println(f.getAbsolutePath());
        if (!f.exists()) {
            f.createNewFile();
            p.setProperty("term", "201602");//初始化学期信息
        }else{
            System.out.println(f.getAbsolutePath());//打印了配置文件的绝对路径
            p.load(new FileInputStream(f));//下载数据
            String term = p.getProperty("term");
            char c = term.charAt(5);
            term = term.substring(0, term.length()-1);
            if (c=='1') {
                term += '2';
            }else if (c == '2'){
                term += '3';
            }else{
                String tempString = term.substring(4);
                Integer tempInteger = new Integer(term.substring(0, 4))+1;
                term = tempInteger + tempString+"1";
            }
            p.setProperty("term", term);
            
        }
        p.store(new FileOutputStream(f), "");//将修改的信息保存
            
        } catch (Exception e) {
            System.out.println(e.toString());
            return "0";
        }
        
        return "1";
     }
  
       //正式教师根据工号范围分页
     @RequestMapping("dean/zs_js_search")
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
     
    
     //正式教师根据学院
     @RequestMapping("dean/zs_js_xy_search")
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
     
      //批量删除正式教师信息
    @RequestMapping(value = "dean/pzsc_zs_jsxx", method = RequestMethod.POST)
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
    
     //正式教师信息分页
      @RequestMapping("dean/fh_zs_jsme")
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
    
      //删除正式学生的
    @RequestMapping(value = "dean/sc_zs_xs", method = RequestMethod.POST)
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
    
      //正式学生分页 
    @RequestMapping("dean/fh_zs_stume")
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
        @RequestMapping("dean/xh_search")
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
    
       //正式学生学院年级
    @RequestMapping("dean/xy_nianji_search")
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
    @RequestMapping("dean/daochuxuesheng")
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
    //前台显示学院
    @RequestMapping("dean/reg/hq_xy")
    public @ResponseBody List<String> xy(HttpServletRequest request){
      return CurrentInfo.getAllCollege();
    }
    
    //学期返回前台,下拉框显示
       @RequestMapping("dean/fhxq")
        public @ResponseBody List<String> xq(HttpServletRequest request){
            return CurrentInfo.getAllTerm();
        }
         //年级返回前台,下拉框显示
       @RequestMapping("dean/reg/fhnj")
        public @ResponseBody List<String> nj(HttpServletRequest request){
          return CurrentInfo.getAllGrade();
        }
   

           
    //导出正式表教师信息
   @RequestMapping("dean/daochualltoxls")
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

      @RequestMapping("dean/search")
    public @ResponseBody
    List<ManageResult> search(HttpServletRequest request, HttpServletResponse response) {
        String flag = (String) request.getParameter("flag");
        String text = (String) request.getParameter("text");

        List<ManageResult> lists = new LinkedList();
        List<ManageResult> l = new LinkedList();
        if ("0".equals(flag)) {//权限管理
            List list = TeacherDao.getAllTeacher();
            for (Object ob : list) {
                ManageResult mr = new ManageResult();
                mr.copy(ob);
                mr.setControl("<a herf=\"#\"  onclick=\"manage(" + mr.getSn() + "," + 0 + ")\">权限管理</a>");
                l.add(mr);
            }
        } else {//密码重置
            List list = StudentDao.getAllStudent();
            list.addAll(TeacherDao.getAllTeacher());
            for (Object ob : list) {//获取所有对象
                ManageResult mr = new ManageResult();
                mr.copy(ob);
                mr.setControl("<a herf=\"#\" class = \"m\" onclick=\"manage(" + mr.getSn() + "," + 1 + ")\">重置密码</a>");
                l.add(mr);
            }
        }

        for (ManageResult mr : l) {
            boolean b = false;

            String x;
            x = mr.getSn();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setSn("<div class=\"text-primary\">" + x + "</div>");

            }
            x = mr.getTel();
            if (x.matches(".*" + text + ".*")) {
                b = true;

                mr.setTel("<div class=\"text-primary\">" + x + "</div>");
            }
            x = mr.getQq();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setQq("<div class=\"text-primary\">" + x + "</div>");
            }
            x = mr.getPosition();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setPosition("<div class=\"text-primary\">" + x + "</div>");
            }
            x = mr.getName();
            if (x.matches(".*" + text + ".*")) {
                b = true;

                mr.setName("<div class=\"text-primary\">" + x + "</div>");

            }
            x = mr.getIdCard();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setIdCard("<div class=\"text-primary\">" + x + "</div>");
            }

            x = mr.getSex();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setSex("<div class=\"text-primary\">" + x + "</div>");
            }
            if (b) {
                lists.add(mr);
            }
        }
        System.out.println("size"+lists.size());


        return lists;
    }

    @RequestMapping("dean/all")
    public @ResponseBody
    List<ManageResult> all(HttpServletRequest request, HttpServletResponse response) {
        List list = StudentDao.getAllStudent();
        list.addAll(TeacherDao.getAllTeacher());
        List<ManageResult> l = new LinkedList();
        for (Object ob : list) {
            ManageResult mr = new ManageResult();
            mr.copy(ob);
            mr.setControl("<a herf=\"#\" class = \"m\" onclick=\"manage(" + mr.getSn() + "," + 1 + ")\">重置密码</a>");
            l.add(mr);
        }
        return l;
    }

    @RequestMapping("dean/czmm")
    public @ResponseBody
    String czmm(HttpServletRequest request, HttpServletResponse response) {
        String sn = request.getParameter("sn");
        Teacher t = TeacherDao.getTeacherBySn(sn);

        if (t != null) {
            t.setTeacherPwd("e10adc3949ba59abbe56e057f20f883e");
            TeacherDao.updateTeacherById(t);
        } else {
            Student s = StudentDao.getStudentBySn(sn);
            s.setStudentPwd("e10adc3949ba59abbe56e057f20f883e");
            StudentDao.updateStudent(s);
        }

        return "0";
    }

    @RequestMapping("dean/teacher")
    public @ResponseBody
    List<ManageResult> All(HttpServletRequest request, HttpServletResponse response) {
        List list = TeacherDao.getAllTeacher();
        List<ManageResult> l = new LinkedList();
        String pw = request.getParameter("a");
        System.out.println(pw);
        for (Object ob : list) {
            ManageResult mr = new ManageResult();
            mr.copy(ob);
            mr.setControl("<a herf=\"#\"  onclick=\"manage(" + mr.getSn() + "," + 0 + ")\">权限管理</a>");
            l.add(mr);
        }
        return l;
    }


    //管理员页面Role编辑

    @RequestMapping("/dean/rolecheck")
    public @ResponseBody
    String[] rolecheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        String p = request.getParameter("p");
        String[] a = new String[1];
        String sn = request.getParameter("sn");
        StringBuffer sb = new StringBuffer();
        sb.append("<form role=\"form\">已选择教师sn：" + sn + "<br><div class=\"checkbox\">");
        List<String> list = AuthorityManage.getCurrentAuthoritiest(sn);
        String str[] = {"ROLE_ACDEMIC","ROLE_TEACHER"};
        String str2[] = {"教务员",  "教工"};
        String str3[] = {"1", "4"};
        // System.out.println(list);
        for (int i = 0; i < str.length; i++) {
            if (list.contains(str[i])) {
                sb.append("<label><input name=\"rolevelue\" value=\"" + str3[i] + "\" type=\"checkbox\" checked = checked>" + str2[i] + "</label><br>");
            } else {
                sb.append("<label><input name=\"rolevelue\" value=\"" + str3[i] + "\"  type=\"checkbox\">" + str2[i] + "</label><br>");
            }
        }
        sb.append("</div></form>");
        a[0] = sb.toString();
        return a;
    }

    //管理员页面Role设置

    @RequestMapping("/dean/roleset")
    public @ResponseBody
    String roleset(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //System.out.println("logincheck");
        request.setCharacterEncoding("UTF-8");
        String sn = request.getParameter("sn");
        String rolesum = request.getParameter("rolesum");
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
//        List<String> list = AuthorityManage.getCurrentAuthoritiest(sn);
//        if(list.contains("ROLE_ADMIN")){        //先判断此人之前是否有管理员权限
//            teacher.setTeacherRoleValue(Integer.valueOf(rolesum)+8);
//        }else{
//            teacher.setTeacherRoleValue(Integer.valueOf(rolesum));
//        }
        if (rolesum.equals("1")||rolesum.equals("4")||rolesum.equals("5")) {
            teacher.setTeacherRoleValue(Integer.valueOf(rolesum));
            TeacherDao.updateTeacherById(teacher);
            return "ok";
        }else{
            return "error";
        }
       
    } 
    
    //设置教务员
    @RequestMapping("dean/teachermessage")
    public @ResponseBody String deanteachermessage(){
         System.out.println("设置教务员");
         List list = TeacherDao.getAllacdemicTeacher();
         System.out.println(list.size());
        JSONArray json = JSONArray.fromObject(list);
        System.out.println("json="+json.toString());
         return json.toString();
    }
    
     //批准教务员
    @RequestMapping("dean/acedmicqxpz")
    public @ResponseBody String acedmicqxpz(HttpServletRequest request){
         int id = Integer.parseInt(request.getParameter("id"));
         Teacher teacher = TeacherDao.getTeacherById(id);
         teacher.setTeacherRoleValue(5);
         TeacherDao.updateTeacherById(teacher);
         return "1";
    }
     //取消教务员
    @RequestMapping("dean/acedmicqx")
    public @ResponseBody String acedmicqx(HttpServletRequest request){
        int id = Integer.parseInt(request.getParameter("id"));
        Teacher teacher = TeacherDao.getTeacherById(id);
        teacher.setTeacherRoleValue(4);
        TeacherDao.updateTeacherById(teacher);
         return "1";
    }
    
}
