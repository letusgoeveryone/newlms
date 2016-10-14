/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;


import cn.edu.henu.rjxy.lms.dao.StudentDao;
import static cn.edu.henu.rjxy.lms.dao.StudentDao.getStudentById;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseInfoDao;
import cn.edu.henu.rjxy.lms.model.AutoCourseNode;
import cn.edu.henu.rjxy.lms.model.Mystudent;
import cn.edu.henu.rjxy.lms.model.NewClass;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.StuSelectResult;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TeacherCourseResult;
import cn.edu.henu.rjxy.lms.model.TeacherMyclassstudent;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.server.AuthorityManage;
import cn.edu.henu.rjxy.lms.server.CurrentInfo;
import cn.edu.henu.rjxy.lms.server.StudentMethod;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
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
//@RequestMapping("teacher/teacher")
public class TeaController {
    
    @RequestMapping("teacher")
    public String tea_index(HttpServletRequest request, HttpServletResponse response) {
        return "teacher/Index";
    }
    
    @RequestMapping("teacher/student")
    public String student(HttpServletRequest request,HttpServletResponse response) {
        
        return "teacher/mystudent";
    } 
    @RequestMapping("teacher/mycourse")
    public String alljsp(HttpServletRequest request,HttpServletResponse response) {
        String term = request.getParameter("term");
        String courseid = request.getParameter("courseid");
        String courseName = request.getParameter("courseName");
        request.setAttribute("term", term);
        request.setAttribute("courseid",courseid);
        request.setAttribute("courseName",courseName );
        return "teacher/mycourse";
    } 
    @RequestMapping("/teacher/pinfo")
    public String pinfo(HttpServletRequest request, HttpServletResponse response) {

        return "/teacher/PersonalInfo";
    }
    //返回teacher信息
    @RequestMapping("/teacher/getpersoninfo")
    public @ResponseBody Teacher teacherPersonalInformation(HttpServletRequest request, HttpServletResponse response) {
        return AuthorityManage.GetTecPersonalInfo();
    }
     //个人信息修改提交处理
    @RequestMapping("/teacher/updatepersoninfo")
    public @ResponseBody String teacherUpdatePersonInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return AuthorityManage.UpdateTecPersonlInfo(request, response);
    }
     //密码修改提交处理
    @RequestMapping("/teacher/updatepassword")
    public @ResponseBody String teacherUpdatePassword(HttpServletRequest request, HttpServletResponse response) {
        return AuthorityManage.UpdateTecPassword(request, response);
    }  
     //更新头像id
    @RequestMapping("/teacher/updateimgid")
    public @ResponseBody String teacherUpdateimgid(HttpServletRequest request, HttpServletResponse response) {
        return AuthorityManage.updateTecImgId(request, response);
    }  
    
    
     //临时学生根据学号分页
     @RequestMapping("/teacher/ls_xs_search")
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
    
       //批准临时表学生
    @RequestMapping(value = "/teacher/pzstu", method = RequestMethod.POST)
    public @ResponseBody String pzstu(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        System.out.println(params.length);
        for (String param : params) {
            new StudentMethod().addStudentFromtempStudent(Integer.parseInt(param));
            TempStudentDao.deleteTempStudentById(Integer.parseInt(param)); //批准的同时删除
        }    
        return "批准成功！";
    }
    
        //删除临时表学生
    @RequestMapping(value="/teacher/scstu", method = RequestMethod.POST)
    public @ResponseBody String scstu(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        for (String param : params) {
            TempStudentDao.deleteTempStudentById(Integer.parseInt(param)); //删除临时表学生
        }    
        return "删除成功！";
    }
    
    //教师课程树http://localhost:8080/lms/teacher/courselist?xueqi=201602
    @RequestMapping(value = "courselist",method = RequestMethod.GET)
    public @ResponseBody List<TeacherCourseResult> courselist(HttpServletRequest request,@RequestParam ("xueqi") String xueqi) throws UnsupportedEncodingException{
      request.setCharacterEncoding("utf-8");
       String sn=AuthorityManage.getCurrentUsername();
       Teacher tec = TeacherDao.getTeacherBySn(sn);
       System.out.println(tec.getTeacherSn());
       return  TeacherDao.getTeacherCourseByTermSn(Integer.parseInt(xueqi), tec.getTeacherSn());          
    }

    //修改密码
    @RequestMapping("teacher/teaPassward")
    public @ResponseBody String teaPassward(HttpServletRequest request){
         String sn=AuthorityManage.getCurrentUsername();
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
      
      //班级学生信息显示
      @RequestMapping("teacher/mystudent")
      public @ResponseBody JSONObject mystudent(HttpServletRequest request,HttpServletResponse response){
          int pc = Integer.parseInt(request.getParameter("page"));
          int ps = Integer.parseInt(request.getParameter("rows"));
          int classid = Integer.parseInt(request.getParameter("classid"));
          int course_id = Integer.parseInt(request.getParameter("course_id"));
          int term = Integer.parseInt(request.getParameter("term"));
          String sn=AuthorityManage.getCurrentUsername();
          Teacher tec = TeacherDao.getTeacherBySn(sn);
          int tec_id = tec.getTeacherId();
          System.out.println("classid="+classid+"\n"+"course_id="+course_id+"\n"+"term="+term+"\n"+"tec_id="+tec_id);
          int trem_courseid = TermCourseDao.getTermCourseId(term, course_id, classid, tec_id);
          System.out.println(trem_courseid+"trem_courseid");
        
          PageBean<StuSelectResult> mystudent =TeacherDao.getStuSelectByTermCourseId(trem_courseid,pc,ps);
          List<Mystudent> beanList =  new LinkedList();
          for(int i = 0;i<mystudent.getBeanList().size();i++){   
           StuSelectResult a = (StuSelectResult)mystudent.getBeanList().get(i);
           Mystudent student = new Mystudent();
           student.setState(a.getState());
           student.setStudentCollege(getStudentById(a.getStuid()).getStudentCollege());
           student.setStudentGrade(getStudentById(a.getStuid()).getStudentGrade());
           student.setStudentId(a.getStuid());
           student.setStudentName(getStudentById(a.getStuid()).getStudentName());
           student.setStudentIdcard(getStudentById(a.getStuid()).getStudentIdcard());
           student.setStudentQq(getStudentById(a.getStuid()).getStudentQq());
           student.setStudentSex(getStudentById(a.getStuid()).getStudentSex());
           student.setStudentSn(getStudentById(a.getStuid()).getStudentSn());
           student.setStudentTel(getStudentById(a.getStuid()).getStudentTel());
           beanList.add(student);
          }
          //创建需要的类型     
          TeacherMyclassstudent b = new TeacherMyclassstudent();
          b.setPc(pc);
          b.setPs(ps);
          b.setTr(mystudent.getTr());
          b.setBeanList(beanList);
          Map<String,Object> jg = new HashMap<>();
          jg.put("total", b.getTr()); 
          jg.put("rows",b.getBeanList());
          System.out.println("mystudent");
          return JSONObject.fromObject(jg);
      }
      //删除班级学生
      @RequestMapping("teacher/scstu")
      public @ResponseBody String[] scstu(HttpServletRequest request,HttpServletResponse response){
          String [] a =new String [1];
          a[0] = "删除成功";
          int term = Integer.parseInt(request.getParameter("term"));
          int classid = Integer.parseInt(request.getParameter("zjd_id"));
          int course_id = Integer.parseInt(request.getParameter("fjd_id"));
          int Stu_id = Integer.parseInt(request.getParameter("stu_id"));
          System.out.println("term = "+term+" classid=" + classid+" course_id="+course_id+" stu_id = "+Stu_id);
          String sn=AuthorityManage.getCurrentUsername();
          Teacher tec = TeacherDao.getTeacherBySn(sn);
          int tec_id = tec.getTeacherId();
          int trem_courseid = TermCourseDao.getTermCourseId(term, course_id, classid, tec_id);
          System.out.println("term_courseid= "+trem_courseid);
          //学生ｉd和termcourseid
          TeacherDao.updateStudentCourse(Stu_id, trem_courseid, true);
          return a;
      }
      
    //批准班级学生
    @RequestMapping("teacher/pzstu")
    public @ResponseBody String[] pzstu(HttpServletRequest request,HttpServletResponse response){
          String [] a =new String [1];
          a[0] = "批准班级学生成功";
          int term = Integer.parseInt(request.getParameter("term"));
          int classid = Integer.parseInt(request.getParameter("zjd_id"));
          int course_id = Integer.parseInt(request.getParameter("fjd_id"));
          int Stu_id = Integer.parseInt(request.getParameter("stu_id"));
          System.out.println("term = "+term+" classid=" + classid+" course_id="+course_id+" stu_id = "+Stu_id);
          String sn=AuthorityManage.getCurrentUsername();
          Teacher tec = TeacherDao.getTeacherBySn(sn);
          int tec_id = tec.getTeacherId();
          int trem_courseid = TermCourseDao.getTermCourseId(term, course_id, classid, tec_id);
          System.out.println("term_courseid= "+trem_courseid);
          //学生ｉd和termcourseid
          TeacherDao.updateStudentCourse(Stu_id, trem_courseid, false);
          return a;
      }
      
      //批量批准学生
       @RequestMapping("teacher/pzPLstu")
      public @ResponseBody String[] pzPLstu(HttpServletRequest request,HttpServletResponse response,@RequestParam("jssz[]") int[] stuid){
          String [] a =new String [1];
          a[0] = "批准班级学生成功";
          int term = Integer.parseInt(request.getParameter("term"));
          int classid = Integer.parseInt(request.getParameter("zjdid"));
          int course_id = Integer.parseInt(request.getParameter("fjdid"));
          String sn=AuthorityManage.getCurrentUsername();
          Teacher tec = TeacherDao.getTeacherBySn(sn);
          int tec_id = tec.getTeacherId();
          int trem_courseid = TermCourseDao.getTermCourseId(term, course_id, classid, tec_id);
          System.out.println("term_courseid= "+trem_courseid);
          //学生ｉd和termcourseid
          for(int i = 0;i<stuid.length;i++){
              TeacherDao.updateStudentCourse(stuid[i], trem_courseid, false);
          }
          return a;
      }

        //导出学生信息,getStuSelectByTermCourseId(trem_courseid,1,300);1表示第一页．300表示最大学生数
    @RequestMapping("teacher/xz_xs_xx")
    public @ResponseBody String daochuxuesheng(HttpServletRequest request, HttpServletResponse response) throws IOException{
          int classid = Integer.parseInt(request.getParameter("zjd_id"));
          int course_id = Integer.parseInt(request.getParameter("fjd_id"));
          int term = Integer.parseInt(request.getParameter("term"));
          String sn=AuthorityManage.getCurrentUsername();
          Teacher tec = TeacherDao.getTeacherBySn(sn);
          int tec_id = tec.getTeacherId();
          int trem_courseid = TermCourseDao.getTermCourseId(term, course_id, classid, tec_id);
          System.out.println(trem_courseid+"trem_courseid");
          PageBean<StuSelectResult> mystudent =TeacherDao.getStuSelectByTermCourseId(trem_courseid,1,300);
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
            for (int i = 0; i < mystudent.getBeanList().size(); i++) {
                StuSelectResult a = (StuSelectResult)mystudent.getBeanList().get(i);
                System.out.println(getStudentById(a.getStuid()).getStudentSn());
                row = sheet.createRow((int) i + 1);
                row.createCell((short) 0).setCellValue(getStudentById(a.getStuid()).getStudentSn());
                row.createCell((short) 1).setCellValue(getStudentById(a.getStuid()).getStudentName());
                row.createCell((short) 2).setCellValue(getStudentById(a.getStuid()).getStudentIdcard());
                row.createCell((short) 3).setCellValue(getStudentById(a.getStuid()).getStudentGrade());
                row.createCell((short) 4).setCellValue((getStudentById(a.getStuid()).getStudentSex())?("男"):("女"));
                row.createCell((short) 5).setCellValue(getStudentById(a.getStuid()).getStudentCollege());
                row.createCell((short) 6).setCellValue(getStudentById(a.getStuid()).getStudentTel());
                row.createCell((short) 7).setCellValue(getStudentById(a.getStuid()).getStudentQq());

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
        return "1";
    
    }

  //教师课程设置格式
  @RequestMapping("teacher/kcgs")
  public @ResponseBody List<AutoCourseNode> kcgs(){
     List<AutoCourseNode> list = new LinkedList();
     AutoCourseNode node1 = new AutoCourseNode();
     AutoCourseNode node2 = new AutoCourseNode();
     AutoCourseNode node3 = new AutoCourseNode();
     AutoCourseNode node4= new AutoCourseNode();
     node1.setId(1);
     node1.setState("open");
     node1.setText("第一部分");
     node1.setAttributes("1");
     node2.setId(2);
     node2.setState("open");
     node2.setText("第二部分");
     node2.setAttributes("1");
     node3.setId(3);
     node3.setState("open");
     node3.setText("第三部分");
     node3.setAttributes("1");
     node4.setId(4);
     node4.setState("open");
     node4.setText("第四部分");
     node4.setAttributes("1");
     TeacherCourseResult kcsz = new TeacherCourseResult();
     TeacherCourseResult kcsz1 = new TeacherCourseResult();
     TeacherCourseResult kcsz2 = new TeacherCourseResult();
     TeacherCourseResult kcsz3 = new TeacherCourseResult();
     NewClass children1 = new NewClass(1000,"第一节");
     NewClass children2 = new NewClass(2000,"第二节");
     NewClass children3 = new NewClass(3000,"第一节");
     NewClass children4 = new NewClass(4000,"第二节");
     NewClass children5 = new NewClass(5000,"第一节");
     NewClass children6 = new NewClass(6000,"第二节");
     NewClass children7 = new NewClass(7000,"第一节");
     NewClass children8 = new NewClass(8000,"第二节");
     kcsz.setId(1);
     kcsz.setState("open");
     kcsz.setText("第一章");
     kcsz.setAttributes("2");
     kcsz.getChildren().add(children1);
     kcsz.getChildren().add(children2);
     kcsz1.setId(2);
     kcsz1.setState("open");
     kcsz1.setText("第二章");
     kcsz1.setAttributes("2");
     kcsz1.getChildren().add(children3);
     kcsz1.getChildren().add(children4);
     kcsz2.setId(3);
     kcsz2.setState("open");
     kcsz2.setText("第二章");
     kcsz2.setAttributes("2");
     kcsz2.getChildren().add(children5);
     kcsz2.getChildren().add(children6);
     kcsz3.setId(4);
     kcsz3.setState("open");
     kcsz3.setText("第二章");
     kcsz3.setAttributes("2");
     kcsz3.getChildren().add(children7);
     kcsz3.getChildren().add(children8);
     node1.getChildren().add(kcsz);
     node2.getChildren().add(kcsz1);
     node3.getChildren().add(kcsz2);
     node4.getChildren().add(kcsz3);
     list.add(node1);
     list.add(node2);
     list.add(node3);
     list.add(node4);
     return list;
  }
 //存成josn文件保存到教师目录
  @RequestMapping("teacher/saveTree")
  public @ResponseBody String saveTree(HttpServletRequest request,@RequestBody String data) throws Exception{
      String sn=AuthorityManage.getCurrentUsername();
      Teacher tec = TeacherDao.getTeacherBySn(sn);
      String tec_sn= tec.getTeacherSn();
      String tec_name = tec.getTeacherName();
      String collage = tec.getTeacherCollege();
      String term = request.getParameter("term");
      String courseName = request.getParameter("courseName");
      // .../学期/学院／教师工号／教师姓名／课程名称 //课程目录结构
      File f = new File(getFileFolder()+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程目录结构"+"/");
      //判断目录是否存在，不存在则创建
      if(!f.exists()&&!f.isDirectory()){
          System.out.println("不存在");
          f.mkdirs();
      }else{
          System.out.println("存在");
      }
    String ff = getFileFolder()+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程目录结构"+"/";
    List list =new LinkedList();
//    String ss = "",aa;
//    for(int i =0;i < users.length-1;i++){
//        list.add(users[i]); 
//        aa = JSONObject.fromObject(users[i])+"";
//        ss +=aa+',';
//    }
//    aa = JSONObject.fromObject(users[users.length-1])+"";
//    ss = ss+aa;
//    ss= '['+ss+']';
    System.out.println(data);
    OutputStreamWriter pw = null;//定义一个流
    pw = new OutputStreamWriter(new FileOutputStream(new File(ff+File.separator+"test.json")),"GBK");
    pw.write(data);
    pw.close();
    return "1";
  }
 
  
  //解析josn文件生成树
  @RequestMapping("teacher/scTree")
  public @ResponseBody String scTree(HttpServletRequest request) throws FileNotFoundException, IOException{
      String sn=AuthorityManage.getCurrentUsername();
      Teacher tec = TeacherDao.getTeacherBySn(sn);
      String tec_sn= tec.getTeacherSn();
      String tec_name = tec.getTeacherName();
      String collage = tec.getTeacherCollege();
      String term = request.getParameter("term");
      String courseName = request.getParameter("courseName");
      String ff = getFileFolder()+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程目录结构"+"/"+"test.json";
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
      System.out.println(fileContent);   
      return fileContent;
  }

  //检查老师是否设置过课程目录
  @RequestMapping("teacher/lookMulu")
  public @ResponseBody String lookMulu(HttpServletRequest request){
      String sn=AuthorityManage.getCurrentUsername();
      Teacher tec = TeacherDao.getTeacherBySn(sn);
      String tec_sn= tec.getTeacherSn();
      String tec_name = tec.getTeacherName();
      String collage = tec.getTeacherCollege();
      String term = request.getParameter("term");
      String courseName = request.getParameter("courseName");
      String ff = getFileFolder()+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程目录结构"+"/"+"test.json";
      File f =new File(ff);
      if(!f.exists()){
          return "0";//不存在
      }
      return "1";
  }
  
  //课程内容树的删除
  @RequestMapping("teacher/kcnr_sc")
  public @ResponseBody String kcnr_sc(HttpServletRequest request){
     String sn=AuthorityManage.getCurrentUsername();
     Teacher tec = TeacherDao.getTeacherBySn(sn);
     String tec_sn= tec.getTeacherSn();
     String tec_name = tec.getTeacherName();
     String collage = tec.getTeacherCollege();
     String term = request.getParameter("term");
     String courseName = request.getParameter("courseName");
     String node1 = request.getParameter("node1");
     String node2 = request.getParameter("node2");
     String node3 = request.getParameter("node3");
     String ff = getFileFolder()+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+"/";
     if(node3.endsWith("null")){//2
        ff = ff+"/"+node1+"/"+node2+"/"; 
        File f = new File(ff);
        if(!f.exists()&&!f.isDirectory()){
          return "1";
        }else{
           if(deleteDir(f)){return "1";}
           else{ return "0";}
        }
     }else{//3
        ff = ff+"/"+node1+"/"+node2+"/"+node3+"/"; 
        File f = new File(ff);
        if(!f.exists()&&!f.isDirectory()){
          return "1";
        }else{
          if(deleteDir(f)){return "1";}
          else{ return "0";}
        }
     }
  }
  
  //上传课程内容
  @RequestMapping("teacher/kcnr_submit")
  public @ResponseBody String[] kcnr_submit(HttpServletRequest request) throws IOException, FileUploadException, Exception{
     String []s=new String[1];
     String sn=AuthorityManage.getCurrentUsername();
     Teacher tec = TeacherDao.getTeacherBySn(sn);
     String tec_sn= tec.getTeacherSn();
     String tec_name = tec.getTeacherName();
     String collage = tec.getTeacherCollege();
     String term = request.getParameter("term");
     String courseName = request.getParameter("courseName");
     String node1 = request.getParameter("node1");
     String node2 = request.getParameter("node2");
     String node3 = request.getParameter("node3");
     System.out.println(node1 + " "+ node2+"  "+node3+"  "+term+"  "+courseName);
     String ff = getFileFolder()+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+"/";
     if(node2.equals("undefined")&&node3.equals("undefined")){//1
         ff = ff+node1;
      }else if(node3.equals("undefined")&&(!node2.equals("undefined"))){//2
         ff = ff+"/"+node1+"/"+node2+"/"; 
      }else if((!node1.equals("undefined"))&&(!node2.equals("undefined"))&&(!node3.equals("undefined"))){//3
         ff = ff+"/"+node1+"/"+node2+"/"+node3+"/"; 
      }
      File f = new File(ff);
      //判断是否已经上传文件
       if (f.exists() && f.isDirectory()){
         if (f.listFiles().length > 0) {
             System.out.println("当前目录已经上传文件");
             s[0]="0";
             return s;
         }
       }
     int length= haveFile(ff);
     if(length==0){s[0]=""+"<ol class=\"breadcrumb\" id=\"breadcour\"><p>暂时无附件,你可以选择附件下载</p></ol>";return s;}
     String a = readname(ff,1)[0];
     String ff2="../file/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+"/"+node1+"/"+node2+"/"+node3+"/"+a ;
     s[0] = "<li><a href=\""+ff2+"\">"+a+"</a>&nbsp;<a  onclick=\"kcdg_sc()\">"+"删除"+"</a></li>";
     s[0]= "<ol class=\"breadcrumb\" id=\"breadcour\"><p>​课程内容附件，你可以点击下载</p>"+s[0]+"</ol>";
//        System.out.println("上传课程内容 路径："+file.getOriginalFilename());
//        DocConverter dc=new DocConverter(f+"/"+file.getOriginalFilename());
//        boolean res=dc.conver();
//        String swftmp=(f+"/"+file.getOriginalFilename()).replace(getFileFolder(), "");
//        swftmp=swftmp.substring(0,swftmp.lastIndexOf("."))+".swf";
//        if (res){
//            System.out.println("转换为flash成功。网页引用地址:http://localhost:8080/Web/getswf?uri="+swftmp);
//        }
      return s;
  }
  
  //更新课程介绍
  @RequestMapping("teacher/addcourseinfo")
  public @ResponseBody String addcourseinfo(HttpServletRequest request,HttpServletResponse response){
     String term = request.getParameter("term");
     String courseid = request.getParameter("courseid");
     String info = request.getParameter("arrinfor");
     System.out.println("term="+term+"\n"+"courseid="+courseid+"\n"+info);
     TermCourseInfoDao.addCourseInfo(Integer.parseInt(term), Integer.parseInt(courseid), info,1);
     return "1";
  }
  
  //更新课程大纲
  @RequestMapping("teacher/addcourseoutline")
  public @ResponseBody String addcourseoutline(HttpServletRequest request,HttpServletResponse response) throws IOException{
     String term = request.getParameter("term");
     String courseid = request.getParameter("courseid");
     String info = request.getParameter("arrinfor");
     System.out.println("term="+term+"\n"+"courseid="+courseid+"\n"+info);
     TermCourseInfoDao.addCourseInfo(Integer.parseInt(term), Integer.parseInt(courseid), info,0);   
     return "1";
  }

  //删除课程大纲附件
  @RequestMapping("teacher/scDGwork")
  public @ResponseBody String[] scDGwork(HttpServletRequest request){
     String []a = new String[1];
     String term = request.getParameter("term");
     String coursename = request.getParameter("coursename");
     String sn=AuthorityManage.getCurrentUsername();
     Teacher tec = TeacherDao.getTeacherBySn(sn);
     String collage = tec.getTeacherCollege();
     String ff = getFileFolder()+term +"/"+collage+"/"+coursename+"/"+"课程大纲"; 
     File f = new File(ff);
     if(!f.exists()&&!f.isDirectory()){
          a[0]="0";
          return a;//无文件
     }
     if(deleteDir(f)){System.out.println("删除课程大纲成功");}
     a[0]=""+"<ol class=\"breadcrumb\" id=\"breadcour\"><p>暂时无附件,你可以选择附件下载</p></ol>";
    return a;
  }
  //look课程内容
  @RequestMapping("teacher/courdir")
  public @ResponseBody String[] courdir(HttpServletRequest request){
     String []s=new String[4];
     String sn=AuthorityManage.getCurrentUsername();
     Teacher tec = TeacherDao.getTeacherBySn(sn);
     String tec_sn= tec.getTeacherSn();
     String tec_name = tec.getTeacherName();
     String collage = tec.getTeacherCollege();
     String term = request.getParameter("term");
     String courseName = request.getParameter("courseName");
     String node1 = request.getParameter("node1");
     String node2 = request.getParameter("node2");
     String node3 = request.getParameter("node3");
     String dir="",ff=null;
     if(!node2.equals("null")&&!node3.equals("null")){
        dir = node1+"/"+node2+"/"+node3+"/";
        ff= node1+"/"+node2+"/"+node3+"/";
     }else if(!node2.equals("null")&&node3.equals("null")){
        dir =node1+"/"+node2+"/";
        ff= node1+"/"+node2+"/";
     }else if(node2.equals("null")&&node3.equals("null")){
        dir = node1+"/";
        ff= node1+"/";
     }
     dir = term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+"/"+dir;
     ff = getFileFolder()+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"+"/"+ff;
     System.out.println("dir="+dir);
     String ff3="../"+"getswf?uri="+dir;
     String ff4="../"+"getvideo?uri="+dir;
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
                 a[0]=a[0]+"<li><a href=\""+ff3+file+"\" target=\"swfplayer\" onclick=\"showSwfPlayer()\">"+file+"</a>&nbsp;<a  onclick=\"kcnrfj_sc('"+file+"')\">"+"删除"+"</a></li>";
                     }else if((file.substring(file.lastIndexOf("."), file.length())).toLowerCase().equals(".mp4")){
                 swf=true;
                 a[0]=a[0]+"<li><a href=\""+ff4+file+"\" target=\"swfplayer\" onclick=\"showSwfPlayer()\">"+file+"</a>&nbsp;<a  onclick=\"kcnrfj_sc('"+file+"')\">"+"删除"+"</a></li>";   
                     }else{
                 ddoc=true;
                 dlc=dlc+"<li><a  onclick=\"kcnrxz('"+dir+file+"')\">"+file+"</a>&nbsp;<a  onclick=\"kcnrfj_sc('"+file+"')\">"+"删除"+"</a></li>";
                 }
                 }
             }
             if(swf){a[0]="<ol class=\"breadcrumb\" id=\"breadcour\"><p>以下是可供在线预览的资源</p>"+a[0]+"</ol>";}
             if(ddoc){a[0]=a[0]+"<ol class=\"breadcrumb\" id=\"breadcour\"><p>以下是可以下载的资源</p>"+dlc+"</ol>";}
             if (a[0].equals("")) {a[0]="<ol class=\"breadcrumb\" id=\"breadcour\"><p>此目录下暂无资源</p></ol>";}
         }
      }
     return a;
  }
  
  //显示大纲名称
  @RequestMapping("teacher/lookDGwork")
 public @ResponseBody String[] lookDGwork(HttpServletRequest request){
     String term = request.getParameter("term");
     String coursename = request.getParameter("coursename");
     String sn=AuthorityManage.getCurrentUsername();
     Teacher tec = TeacherDao.getTeacherBySn(sn);
     String tec_sn= tec.getTeacherSn();
     String tec_name = tec.getTeacherName();
     String collage = tec.getTeacherCollege();
     String ff = getFileFolder()+term +"/"+collage+"/"+coursename+"/"+"课程大纲";
     String s[] = new String[2];
     int length= haveFile(ff);
     if(length==0){s[0]=""+"<ol class=\"breadcrumb\" id=\"breadcour\"><p>暂时无附件,你可以选择附件上传</p></ol>";s[1]="0";return s;}
     String a,b;
     if(readname(ff,2)[0].endsWith(".swf")){a = readname(ff,2)[1];b = readname(ff,2)[0];}else{ a = readname(ff,2)[0];b = readname(ff,2)[1];}
     b =term +"/"+collage+"/"+coursename+"/"+"课程大纲"+"/"+ b;
     String ff2=term +"/"+collage+"/"+coursename+"/"+"课程大纲/"+a;
     s[0] = "<li><a onclick=\"dgxz('"+ff2+"')\">"+a+"</a>&nbsp;<a  onclick=\"scfj()\">"+"删除"+"</a>&nbsp;<a  onclick=\"dgyl('"+b+"')\">"+"预览"+"</a>&nbsp;<a  onclick=\"gbdgyl()\">"+"关闭预览"+"</a>";
     s[0]= "<ol class=\"breadcrumb\" id=\"breadcour\"><p>​课程大纲附件：</p>"+s[0]+"</ol>";
     s[1]="1";
     return s;
 }
  //返回课程大纲
  @RequestMapping("teacher/lookcourseDG")
  public @ResponseBody String[] lookcourseDG(HttpServletRequest request,HttpServletResponse response){
     String term = request.getParameter("term");
     String courseid = request.getParameter("courseid");
     System.out.println(term+" "+courseid);
     String []a = new String[1];
     a[0]=  TermCourseInfoDao.getCourseInfo(Integer.parseInt(term), Integer.parseInt(courseid), 0);
     System.out.println(a[0]);
     return a;
  }
  //返回课程介绍
   @RequestMapping("teacher/lookcourseline")
  public @ResponseBody String[] lookcourseline(HttpServletRequest request,HttpServletResponse response){
     String term = request.getParameter("term");
     String courseid = request.getParameter("courseid");
     System.out.println(term+" "+courseid);
     String []a = new String[1];
     a[0]  =  TermCourseInfoDao.getCourseInfo(Integer.parseInt(term), Integer.parseInt(courseid), 1);
     System.out.println(a[0]+" "+"DG");
      return a;
  }
  
  
  //查看是否为课程负责人
  @RequestMapping("teacher/lookisCourseMaster")
  public @ResponseBody String lookisCourseMaster(HttpServletRequest request,HttpServletResponse response){
     String term = request.getParameter("term");
     String courseid = request.getParameter("courseid");
     String sn=AuthorityManage.getCurrentUsername();
     Teacher tec = TeacherDao.getTeacherBySn(sn);
     if(TeacherDao.isCourseMaster(Integer.parseInt(term), Integer.parseInt(courseid),tec.getTeacherId())==false){
       return "0";//不是课程负责人
     }
     return "1";//是课程负责人
  }
  
  //课件删除
  @RequestMapping("teacher/kcsc")
  public @ResponseBody String[] kcsc(HttpServletRequest request,HttpServletResponse response){
     System.out.println("课件删除课件删除课件删除课件删除课件删除课件删除课件删除课件删除课件删除课件删除课件删除课件删除课件删除课件删除课件删除111");
     String []a = new String[1];
     String sn=AuthorityManage.getCurrentUsername();
     Teacher tec = TeacherDao.getTeacherBySn(sn);
     String tec_sn= tec.getTeacherSn();
     String tec_name = tec.getTeacherName();
     String collage = tec.getTeacherCollege();
     String term = request.getParameter("term");
     String courseName = request.getParameter("courseName");
     String filename = request.getParameter("filename");
     String node1 = request.getParameter("node1");
     String node2 = request.getParameter("node2");
     String node3 = request.getParameter("node3");
     String ff = getFileFolder()+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+"课程内容"; 
     if(!node2.equals("null")&&!node3.equals("null")){
       ff = ff+"/"+node1+"/"+node2+"/"+node3+"/";
     }else if(!node2.equals("null")&&node3.equals("null")){
       ff = ff+"/"+node1+"/"+node2+"/";
     }else  if(node2.equals("null")&&node3.equals("null")){
        ff = ff+"/"+node1+"/";
     }
     
     String a1 = ff+filename;//要删除的文件 
//     String a2 = ff+getFileNameNoEx(filename)+".swf";//判断是否有swf
      System.out.println("a1="+a1);
     File f =new File(a1);
     if(f.exists()){//删除文件
            f.delete();
            System.out.println("no");
     }else{
       a[0] = "0";
     }
    
     return a;   
  }

  //作业要求上传
  @RequestMapping("teacher/work")
  public @ResponseBody String work(HttpServletRequest request) throws IOException{
      int length = 0;
      String textWork = request.getParameter("arred");//作业要求
      String time = request.getParameter("time");//学生提交作业截至时间
      String starttime = request.getParameter("onetime");//学生提交作业截至时间
      String miaoshu = request.getParameter("miaoshu");
      String coursename =request.getParameter("courseName");
      String term = request.getParameter("term");
      String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
      String collage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
      String sn = AuthorityManage.getCurrentUsername();
       //                                 学期　     工号　   姓名　          课程名
       String ff = getFileFolder()+"homework/"+term +"/"+collage+"/"+sn+"/"+tec_name+"/"+coursename+"/";
       file(ff);//判断目录是否存在，不存在则创建
       length = haveFile(ff);
       ff=ff+(length+1)+"/";
       file(ff);
       //写入作业要求html
       OutputStreamWriter pw = null;
       pw = new OutputStreamWriter(new FileOutputStream(new File(ff+File.separator+"textWork.html")),"GBK");
       pw.write(textWork);
       pw.close();
       //作业总描述
       PrintStream ps = null;
       ps = new PrintStream(new FileOutputStream(new File(ff+File.separator+"Workall.txt")));
       ps.printf(miaoshu);//作业名称:
       ps.println();;
       ps.println(time);//学生提交作业截至时间:
       ps.println(starttime);//学生提交作业开始时间
       ps.close();
      return "1";
  }
  
   //修改作业要求上传
  @RequestMapping("teacher/xgwork")
  public @ResponseBody String xgwork(HttpServletRequest request) throws IOException{
      String textWork = request.getParameter("arred");//作业要求
      String time = request.getParameter("time");//学生提交作业截至时间
      String miaoshu = request.getParameter("miaoshu");
      String starttime = request.getParameter("starttime");
      String coursename =request.getParameter("courseName");
      String term = request.getParameter("term");
      String id = request.getParameter("id");
      String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
      String collage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
      String sn = AuthorityManage.getCurrentUsername();
       //                                 学期　     工号　   姓名　          课程名
      String ff = getFileFolder()+"homework/"+term +"/"+collage+"/"+sn+"/"+tec_name+"/"+coursename+"/"+id+"/";
      
       //写入作业要求html
       OutputStreamWriter pw = null;
       pw = new OutputStreamWriter(new FileOutputStream(new File(ff+File.separator+"textWork.html")),"GBK");
       pw.write(textWork);
       pw.close();
       //作业总描述
       PrintStream ps = null;
       ps = new PrintStream(new FileOutputStream(new File(ff+File.separator+"Workall.txt")));
       ps.printf(miaoshu);//作业名称:
       ps.println();;
       ps.println(time);//学生提交作业截至时间:
       ps.println(starttime);//学生提交作业截至时间:
       ps.close();
      return "1";
  }
    //作业附件添加上传
 @RequestMapping(value = "scworkfj",method = RequestMethod.POST)
  public @ResponseBody String course_submit(HttpServletRequest request,@RequestParam("file") MultipartFile file ) throws IOException, Exception {
     String workid =request.getParameter("workid");
     String coursename =request.getParameter("courseName");
     String term = request.getParameter("term"); 
     String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
     String sn = AuthorityManage.getCurrentUsername();
     String collage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
       //                                 学期　     工号　   姓名　          课程名
     String ff = getFileFolder()+"homework/"+term +"/"+collage+"/"+sn+"/"+tec_name+"/"+coursename+"/"+workid+"/"+1+"/";
     file(ff);//判断目录是否存在，不存在则创建
     if(haveFile(ff)!=0){return "0";}
     File f = new File(ff);
      //以字节输出文件
      if(!file.isEmpty()){         
            try {  
                InputStream in;  
                try (FileOutputStream os = new FileOutputStream(f+"/"+file.getOriginalFilename())) {
                    in = file.getInputStream();
                    int b=0;
                    while((b=in.read())!=-1){
                        os.write(b);
                    }   os.flush();
                }  
                in.close();  
            } catch (FileNotFoundException e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            }  
      }
        
      return "1";

  }

  @RequestMapping("teacher/homework_submit")
  public @ResponseBody String homework_submit(HttpServletRequest request,@RequestParam("file") MultipartFile file) throws FileNotFoundException, IOException{
     int length = 0;
     String textWork = request.getParameter("arr1");//作业要求
     String time = request.getParameter("time");//学生提交作业截至时间
     String miaoshu = request.getParameter("miaoshu");
     String coursename =request.getParameter("courseName");
     String term = request.getParameter("term"); 
     String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
     String sn = AuthorityManage.getCurrentUsername();
     String collage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
       //                                 学期　     工号　   姓名　          课程名
     String ff = getFileFolder()+"homework/"+term +"/"+collage+"/"+sn+"/"+tec_name+"/"+coursename+"/";
     file(ff);//判断目录是否存在，不存在则创建
     length = haveFile(ff);
     ff=ff+(length+1)+"/";
     file(ff);
     //写入作业要求html
     OutputStreamWriter pw = null;//定义一个流
     pw = new OutputStreamWriter(new FileOutputStream(new File(ff+File.separator+"textWork.html")),"GBK");
     pw.write(textWork);
     pw.close();
       //作业总描述
     PrintStream ps = null;
     ps = new PrintStream(new FileOutputStream(new File(ff+File.separator+"Workall.txt")));
     ps.printf(miaoshu);//作业名称:
     ps.println();;
     ps.println(time);//学生提交作业截至时间:
     ps.close();
      //以字节输出文件
     if(!file.isEmpty()){         
            try {  
                InputStream in;  
                try (FileOutputStream os = new FileOutputStream(ff+"/"+file.getOriginalFilename())) {
                    in = file.getInputStream();
                    int b=0;
                    while((b=in.read())!=-1){
                        os.write(b);
                    }   os.flush();
                }  
                in.close();  
            } catch (FileNotFoundException e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            }  
      }
    return "1";
  }
  
  //显示共有几次作业
  @RequestMapping("teacher/ckcourselist")
  public @ResponseBody String [] ckcourselist(HttpServletRequest request) throws IOException{
      String []a = new String[100000];
      int length = 0;
      String coursename =request.getParameter("courseName");
      String term = request.getParameter("term");
      String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
      String sn = AuthorityManage.getCurrentUsername();
      String colage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
      String ff = getFileFolder()+"homework/"+term +"/"+colage+"/"+sn+"/"+tec_name+"/"+coursename+"/";
      System.out.println(haveFile(ff));
      length = haveFile(ff);
      a[0] = length+"";//返回长度
      for(int i = 1;i<=length;i++){
          System.out.println(read(ff+"/"+i+"/"+"WorkName.txt"));
          a[i]=readline(ff+"/"+i+"/"+"Workall.txt")[0];
          System.out.println(read(ff+"/"+i+"/"+"homeworkTime.html"));
          a[i+length]=readline(ff+"/"+i+"/"+"Workall.txt")[1];       
      }
      return a;
  }
  
  //窗口显示作业详情
  @RequestMapping("teacher/worknewwindow")
  public @ResponseBody String[] worknewwindow(HttpServletRequest request) throws IOException{
      String coursename =request.getParameter("courseName");
      String term = request.getParameter("term");
      String id = request.getParameter("id");
      String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
      String sn = AuthorityManage.getCurrentUsername();
      String colage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
      String ff = getFileFolder()+"homework/"+term +"/"+colage+"/"+sn+"/"+tec_name+"/"+coursename+"/"+id+"/";
      String a = read(ff+"/"+"textWork.html");
      String a2 =  readline(ff+"/"+"Workall.txt")[1];//endtime
      String a3 =  readline(ff+"/"+"Workall.txt")[2];//starttime
      int length = haveFile(ff+"/"+1+"/");
      String []b = new String[4];
      b[0] = a;//作业要求
      b[1] = a2;//作业截至时间
      b[2] = a3;////starttime
      if(length==1){
           String a1 = readname(ff+"/"+1+"/", 1)[0];
           String ff2="../file/"+"homework"+"/"+term +"/"+colage+"/"+sn+"/"+tec_name+"/"+coursename+"/"+id+"/"+1+"/";
           ff2=ff2+a1;
           String c;
           c = "<li ><a href=\""+ff2+"\">"+a1+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a  onclick=\"sczyfj()\">"+"删除"+"</a></li>";
           c = "<ol class=\"breadcrumb\" id=\"breadcour\"><p>​附件：</p>"+c+"</ol>";
           b[3] = c;
      }else{b[3]="2";}
      return b;
  }
 // 删除作业附件
  @RequestMapping("teacher/dlworkfj")
  public @ResponseBody String scworkfj(HttpServletRequest request) throws IOException{
      String coursename =request.getParameter("courseName");
      String term = request.getParameter("term");
      String id = request.getParameter("id");
      String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
      String sn = AuthorityManage.getCurrentUsername();
      String colage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
      String ff = getFileFolder()+"homework/"+term +"/"+colage+"/"+sn+"/"+tec_name+"/"+coursename+"/"+id+"/";
      int length = haveFile(ff+"/"+1+"/");
      if(length==1){
       File f = new File(ff+"/"+1+"/"); 
         if(deleteDir(f)){
           return "1";
         }else{
           return "0";
         }
      }
      return "1";
  }
  
  // 作业目录下班级显示
  @RequestMapping("teacher/lkworkbj")
  public @ResponseBody String[] lkworkbj(HttpServletRequest request) throws IOException{
      String []c = new String[1];
      String coursename =request.getParameter("courseName");
      String term = request.getParameter("term");
      String id = request.getParameter("id");
      String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
      String sn = AuthorityManage.getCurrentUsername();
      String colage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
      String ff = getFileFolder()+"uploadhomework/"+term +"/"+colage+"/"+sn+"/"+tec_name+"/"+coursename+"/"+id+"/";
      File file=new File(ff);
      if(!file.exists()&&!file.isDirectory()){
           c[0]= "0";
           System.out.println("meiyou文件夹");  
          return c;//如果文件夹不存在，就返回0
      }
      int length = haveFile(ff);//作业目录下班级长度
      String []b = new String[length];
      File[] tempList = file.listFiles();//该方法返回的是文件数组
      String allString="",temp;
      for (int i = 0; i < tempList.length; i++) {//循环这个数组
        if (tempList[i].isDirectory()) {//根据需要取出文件夹
           String a =tempList[i].toString();
           System.out.println("a="+a);
           if(a.indexOf("\\") != -1){  
              temp = a.substring(a.lastIndexOf("\\")+1);
            } else{
              temp = a.substring(a.lastIndexOf("/")+1);
            }  
           System.out.println("temp="+temp);
           b[i] =  " <a onclick=\"czxs('"+temp+"')\" >"+temp+"</a>"; 
           allString=allString+b[i];
        }
      }
      if(allString!=""){ b[0]=allString;}
      if(tempList.length==0){
         b[0] = "0";
      }
      System.out.println("b[0]="+b[0]);
      return b;
  }
  
  ////班级目录下学生长度
  @RequestMapping("teacher/lkworkxs")
  public @ResponseBody String[] lkworkxs(HttpServletRequest request) throws IOException{
      String []c = new String[1];
      String clsssname =request.getParameter("a");
      String coursename =request.getParameter("courseName");
      String term = request.getParameter("term");
      String id = request.getParameter("id");
      String tec_name =TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
      String sn = AuthorityManage.getCurrentUsername();
      String colage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
      String ff = getFileFolder()+"uploadhomework/"+term +"/"+colage+"/"+sn+"/"+tec_name+"/"+coursename+"/"+id+"/"+clsssname+"/";
      String ff2="../file/"+"uploadhomework/"+term +"/"+colage+"/"+sn+"/"+tec_name+"/"+coursename+"/"+id+"/"+clsssname+"/";
      int length = haveFile(ff);//班级目录下学生长度
      String []b = new String[length+1];
      if(length==0){c[0]="0";return c;}
      File file=new File(ff);
      File[] tempList = file.listFiles();//该方法返回的是文件数组
      String allString="",temp;
      for (int i = 0; i < tempList.length; i++) {//循环这个数组
        if (tempList[i].isDirectory()) {//根据需要取出文件夹
           String a =tempList[i].toString();
            String fileStudentPath = null;
             if(a.indexOf("\\") != -1){  
              temp = a.substring(a.lastIndexOf("\\")+1);
              fileStudentPath = ff+"\\"+temp;
            } else{
              temp = a.substring(a.lastIndexOf("/")+1);
               fileStudentPath = ff+"/"+temp;
            }  
           int studentWorkLength = haveFile(fileStudentPath);//学生作业文件总长度
           String stu_name =StudentDao.getStudentBySn(temp).getStudentName();//学生姓名  
           String []ld=new String[studentWorkLength];
           String []look=new String[studentWorkLength];//除了提交作业时间外剩余的文件
           for(int m = 0;m <studentWorkLength;m++){//初始化学生交的作业名称
              look[m] = "null";//剩余文件初始化文件名null
           }
           ld = readname(fileStudentPath,studentWorkLength);//读出所有的文件名
           String studentWorktime="0";//学生提交时间变量
           int ml = 0;
           for(int j = 0; j <studentWorkLength;j++){
               if(ld[j].equals("submitTime.txt")){
                  studentWorktime = readline(fileStudentPath+"/"+"submitTime.txt")[0];//找学生提交时间并赋值studentWorktime
               }else{
                  look[ml] = ld[j];//不是作业提交时间文件，全部赋值给look数组
                  ml++;//本项目中学生最多上传5个文件，所以ml最大为5.... [0 1 2 3 4 5]  .5个上传文件，一个百度副文本编辑的内容
               }
           }
           
            System.out.println("学生共上传"+ml+"了个文件");
            if(ml==0){}
            if(ml==1){
                String a1 = "<tr><td>"+temp+"</td><td>"+stu_name+"</td><td>"+clsssname+"</td><td>"+studentWorktime+"</td><td>";
                String a2 = "<a href=\""+ff2+temp+"/"+look[0]+"\" target=\""+0+"\">"+look[0]+"</a>";
                allString=allString+a1+a2+"</td></tr>";
            }
            else if(ml==2){
                String a1 = "<tr><td>"+temp+"</td><td>"+stu_name+"</td><td>"+clsssname+"</td><td>"+studentWorktime+"</td><td>";
                String a2 = "<a href=\""+ff2+temp+"/"+look[0]+"\" target=\""+0+"\">"+look[0]+"</a>&nbsp";
                String a3 = "<a href=\""+ff2+temp+"/"+look[1]+"\" target=\""+0+"\">"+look[1]+"</a>";
                allString=allString+a1+a2+a3+"</td></tr>";
            }
            else if(ml==3){
                String a1 = "<tr><td>"+temp+"</td><td>"+stu_name+"</td><td>"+clsssname+"</td><td>"+studentWorktime+"</td><td>";
                String a2 = "<a href=\""+ff2+temp+"/"+look[0]+"\" target=\""+0+"\">"+look[0]+"</a>&nbsp";
                String a3 = "<a href=\""+ff2+temp+"/"+look[1]+"\" target=\""+0+"\">"+look[1]+"</a>&nbsp";
                String a4 = "<a href=\""+ff2+temp+"/"+look[2]+"\" target=\""+0+"\">"+look[2]+"</a>";
                allString=allString+a1+a2+a3+a4+"</td></tr>";
            }
            else if(ml==4){
                String a1 = "<tr><td>"+temp+"</td><td>"+stu_name+"</td><td>"+clsssname+"</td><td>"+studentWorktime+"</td><td>";
                String a2 = "<a href=\""+ff2+temp+"/"+look[0]+"\" target=\""+0+"\">"+look[0]+"</a>&nbsp";
                String a3 = "<a href=\""+ff2+temp+"/"+look[1]+"\" target=\""+0+"\">"+look[1]+"</a>&nbsp";
                String a4 = "<a href=\""+ff2+temp+"/"+look[2]+"\" target=\""+0+"\">"+look[2]+"</a>&nbsp";
                String a5 = "<a href=\""+ff2+temp+"/"+look[3]+"\" target=\""+0+"\">"+look[3]+"</a>";
                allString=allString+a1+a2+a3+a4+a5+"</td></tr>";
            }
            else if(ml==5){
                String a1 = "<tr><td>"+temp+"</td><td>"+stu_name+"</td><td>"+clsssname+"</td><td>"+studentWorktime+"</td><td>";
                String a2 = "<a href=\""+ff2+temp+"/"+look[0]+"\" target=\""+0+"\">"+look[0]+"</a>&nbsp";
                String a3 = "<a href=\""+ff2+temp+"/"+look[1]+"\" target=\""+0+"\">"+look[1]+"</a>&nbsp";
                String a4 = "<a href=\""+ff2+temp+"/"+look[2]+"\" target=\""+0+"\">"+look[2]+"</a>&nbsp";
                String a5 = "<a href=\""+ff2+temp+"/"+look[3]+"\" target=\""+0+"\">"+look[3]+"</a>&nbsp";
                String a6 = "<a href=\""+ff2+temp+"/"+look[4]+"\" target=\""+0+"\">"+look[4]+"</a>";
                allString=allString+a1+a2+a3+a4+a5+a6+"</td></tr>";
            }
            else if(ml==6){
                String a1 = "<tr><td>"+temp+"</td><td>"+stu_name+"</td><td>"+clsssname+"</td><td>"+studentWorktime+"</td><td>";
                String a2 = "<a href=\""+ff2+temp+"/"+look[0]+"\" target=\""+0+"\">"+look[0]+"</a>&nbsp";
                String a3 = "<a href=\""+ff2+temp+"/"+look[1]+"\" target=\""+0+"\">"+look[1]+"</a>&nbsp";
                String a4 = "<a href=\""+ff2+temp+"/"+look[2]+"\" target=\""+0+"\">"+look[2]+"</a>&nbsp";
                String a5 = "<a href=\""+ff2+temp+"/"+look[3]+"\" target=\""+0+"\">"+look[3]+"</a>&nbsp";
                String a6 = "<a href=\""+ff2+temp+"/"+look[4]+"\" target=\""+0+"\">"+look[4]+"</a>&nbsp";
                String a7 = "<a href=\""+ff2+temp+"/"+look[5]+"\" target=\""+0+"\">"+look[5]+"</a>";
                allString=allString+a1+a2+a3+a4+a5+a6+a7+"</td></tr>";
            }    
        }
      }
      b[length]=length+"";
      if(!"".equals(allString)){ b[0]=allString;}
      System.out.println("b="+b[0]);
    return b;
  }
  //下载全部作业
   @RequestMapping("teacher/download")    
    public ResponseEntity<byte[]> download(HttpServletRequest request,HttpServletResponse response) throws IOException {  
        String term = request.getParameter("term");
        String courseName = request.getParameter("courseName");
        String workid = request.getParameter("workid");
        String sn = AuthorityManage.getCurrentUsername();
        String collage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
        String teacherName = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
        String path=getFileFolder()+"uploadhomework/"+term+"/"+collage+"/"+sn+"/"+teacherName+"/"+courseName+"/"+workid+"/"; // 压缩的目录
        String fileNamelast = workid+".zip";//下载的文件名
        file( getFileFolder()+"uploadhomework/"+term+"/"+collage+"/"+sn+"/"+teacherName+"/"+"临时压缩");
        String compress = getFileFolder()+"uploadhomework/"+term+"/"+collage+"/"+sn+"/"+teacherName+"/"+"临时压缩"+"/"+fileNamelast;
        //压缩后下载
        ZipCompressor zc = new ZipCompressor(compress);//压缩的位置   
        zc.compress(path,"","");  //压缩一个目录，，压缩后文件不删除，下次压缩自动替换
        //压缩完成
        
        File file=new File(compress);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(fileNamelast.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
                                                  headers, HttpStatus.CREATED);    
    }    
    
    //下载当前班级的提交作业
   @RequestMapping("teacher/downloadclas")    
    public ResponseEntity<byte[]> downloadclass(HttpServletRequest request,HttpServletResponse response) throws IOException {  
        String term = request.getParameter("term");
        String courseName = request.getParameter("courseName");
        String workid = request.getParameter("workid");
        String classname = request.getParameter("classname");
        String sn = AuthorityManage.getCurrentUsername();
        String collage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
        String teacherName = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
        String path=getFileFolder()+"uploadhomework/"+term+"/"+collage+"/"+sn+"/"+teacherName+"/"+courseName+"/"+workid+"/"+classname+"/"; // 压缩的目录
        String fileNamelast = classname+".zip";//下载的文件名
        file( getFileFolder()+"uploadhomework/"+term+"/"+collage+"/"+sn+"/"+teacherName+"/"+"临时压缩");
        String compress = getFileFolder()+"uploadhomework/"+term+"/"+collage+"/"+sn+"/"+teacherName+"/"+"临时压缩"+"/"+fileNamelast;
        //压缩后下载
        ZipCompressor zc = new ZipCompressor(compress);//压缩的位置   
        zc.compress(path,"","");  //压缩一个目录，，压缩后文件不删除，下次压缩自动替换
        //压缩完成
        
        File file=new File(compress);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(fileNamelast.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
                                                 headers, HttpStatus.CREATED);    
    }    

      //下载当前班级的提交作业
   @RequestMapping("teacher/downloadDG")    
    public ResponseEntity<byte[]> downloadDG(HttpServletRequest request,HttpServletResponse response) throws IOException {  
        String path = request.getParameter("temp");
        String filename =path.substring(path.lastIndexOf("/"));
        String compress = getFileFolder()+path;   
        File file=new File(compress);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String(filename.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
                                                 headers, HttpStatus.CREATED);    
    } 
    
    //教师下载作业后清楚临时文件
    @RequestMapping("teacher/clear")    
    public @ResponseBody String clear(HttpServletRequest request,HttpServletResponse response) throws IOException {  
        String term = request.getParameter("term");
        String sn = AuthorityManage.getCurrentUsername();
        String collage = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherCollege();
        String teacherName = TeacherDao.getTeacherBySn(AuthorityManage.getCurrentUsername()).getTeacherName();
        String path = getFileFolder()+"uploadhomework/"+term+"/"+collage+"/"+sn+"/"+teacherName+"/"+"临时压缩";
        File f = new File(path);
        if(f.exists()&&f.isDirectory()){
            System.out.println("临时压缩文件存在----------------执行删除临时压缩文件");
            if(deleteDir(f)){
                System.out.println("临时压缩文件删除成功");
                return "0";
            }
        }else{
            return "0";
        }
        return "0";    
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
            while ((line = reader.readLine()) != null){       
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

    public String [] readname(String ff,int j){
        String []a=new String[j];
        File file = new File(ff);    
        File[] array = file.listFiles();       
         for(int i=0;i<array.length;i++){   
                if(array[i].isFile()){   
                    a[i]=array[i].getName();  
                } 
         }
        return a;
    }
    


    /**
     * 递归删除目录下的所有文件及子目录下所有文件
     * @param dir 将要删除的文件目录
     * @return 
     */
    private static boolean deleteDir(File dir) {
        if (dir.isDirectory()) {
            String[] children = dir.list();
            //　　递归删除目录中的子目录下
            for (int i=0; i<children.length; i++) {
                boolean success = deleteDir(new File(dir, children[i]));
                if (!success) {
                    return false;
                }
            }
        }
        // 目录此时为空，可以删除
        return dir.delete();
    }
    
    /*
 * Java文件操作 获取不带扩展名的文件名
 */
    public  String getFileNameNoEx(String filename) { 
        if ((filename != null) && (filename.length() > 0)) { 
            int dot = filename.lastIndexOf('.'); 
            if ((dot >-1) && (dot < (filename.length()))) { 
                return filename.substring(0, dot); 
            } 
        } 
        return filename; 
    }
    public String getFileFolder() {
        return CurrentInfo.getFileFolder();    
    }  
}
    
    
  
