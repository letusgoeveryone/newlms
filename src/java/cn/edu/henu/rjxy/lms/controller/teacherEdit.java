/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TempStudentWithoutPwd;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import cn.edu.henu.rjxy.lms.server.TeacherMethod;
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
import javax.swing.plaf.multi.MultiButtonUI;
import net.sf.json.JSONObject;
//import org.apache.commons.fileupload.FileItemFactory;
//import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
@Controller
@RequestMapping("/")
public class teacherEdit {

    //删除临时表教师信息
    @RequestMapping("sc")
    public @ResponseBody
    String pz(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
         for (int i=0;i<params.length;i++) {  
            TempTeacherDao.deleteTempTeacherById(Integer.parseInt(params[i])); //批准的同时删除临时表教师信息
        }
        return "成功";
    }

    @RequestMapping(value = "pzscjs", method = RequestMethod.POST)
    public @ResponseBody
    String pzscjsxx(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        System.out.println(params.length+"j");
       for (int i=0;i<params.length;i++) {
           TeacherDao.addTeacherFromTempTeacherById(Integer.parseInt(params[i]));//批准临时表教师
            TempTeacherDao.deleteTempTeacherById(Integer.parseInt(params[i])); //批准的同时删除临时表教师信息
        }

        return "批量删除成功！";
    }
//正式教师信息分页
      @RequestMapping("fh_zs_jsme")
    public @ResponseBody
    JSONObject fhstume(HttpServletRequest request, HttpServletResponse response) {
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
            TeacherDao.deleteTeacherById(Integer.parseInt(params[i])); //批准的同时删除临时表教师信息
        }
        return "批量删除成功！";
    }
    public static void main(String[] args) {
         List allteacher = TeacherDao.getAllTeacher();
         System.err.println(allteacher);
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

  @RequestMapping(value = "course_submit",method = RequestMethod.POST)
  public @ResponseBody String course_submit(HttpServletRequest request,@RequestParam("desc") String desc,@RequestParam("file") MultipartFile file ) throws IOException {
    //  DiskFileItemFactory factory = new DiskFileItemFactory();//通过工厂创建解析器，
    //  ServletFileUpload sfu = new ServletFileUpload((FileItemFactory) factory);                                          //通过request,遍历Fileitem,
                                                      //遍历fileitem,完成api的调用
      
      System.out.println("file.getContentType():"+file.getContentType());
      System.out.println("file.getName():"+file.getName());
      System.out.println("file.getOriginalFilename():"+file.getOriginalFilename());
      System.out.println("file.getInputStream:s"+file.getInputStream());
      System.out.println("file size:"+file.getSize());
      if(!file.isEmpty()){         
            try {  
                FileOutputStream os = new FileOutputStream("/home/liubingxu/temp/"+new Date().getTime()+file.getOriginalFilename());  
                InputStream in = file.getInputStream();  
                int b=0;  
                while((b=in.read())!=-1){  
                    os.write(b);  
                }  
                os.flush();  
                os.close();  
                in.close();  
                System.out.println("success:submit");
            } catch (FileNotFoundException e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            }  
      }
       return "submit_success";
  }

 //根据工号自动补全姓名
  @RequestMapping(value = "zdpqjsxm",method = RequestMethod.POST)
  public @ResponseBody String zdpq(HttpServletRequest request,@RequestParam("search-text") String params){
     System.out.println(params);
    return "accccccccccccccc";
  }

}
