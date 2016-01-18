package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import cn.edu.henu.rjxy.lms.server.StudentMethod;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static net.sf.ehcache.search.aggregator.Aggregators.count;
import net.sf.json.JSONObject;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import static org.hibernate.criterion.Projections.count;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
@Controller
@RequestMapping("/")
public class studentEdit {   
    //teacher shanchu删除临时表学生信息
    @RequestMapping(value="scstu", method = RequestMethod.POST)
    public @ResponseBody String scstu(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
         for (int i=0;i<params.length;i++) {  
           TempStudentDao.deleteTempStudentById(Integer.parseInt(params[i])); //批准的同时删除临时表教师信息
        }    
        return "删除成功！";
    }
    
     ////批准临时表学生的controller
    @RequestMapping(value = "pzstu", method = RequestMethod.POST)
    public @ResponseBody String pzstu(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        System.out.println(params.length);
        for (int i=0;i<params.length;i++) {         
            new StudentMethod().addStudentFromtempStudent(Integer.parseInt(params[i]));
            TempStudentDao.deleteTempStudentById(Integer.parseInt(params[i])); //批准的同时删除临时表教师信息
        }    
        return "批准成功！";
    }
    
    @RequestMapping("/fh_zs_stume")//正式学生分页
    public @ResponseBody
    JSONObject fhstume(HttpServletRequest request, HttpServletResponse response) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        System.out.println(pc);
        System.out.println(ps);
        PageBean<Student> pb =new StudentMethod().findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }
  
      @RequestMapping("/xh_search")//学生学号范围
    public @ResponseBody
    JSONObject search(HttpServletRequest request) {
       int min = Integer.parseInt(request.getParameter("min"));
       int max = Integer.parseInt(request.getParameter("max"));
       List list = new StudentDao().getStudentBySn(min,max);
       int total = list.size();
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", total);//total键 存放总记录数，必须的  
        jsonMap.put("rows",list);//rows键 存放每页记录 list  
        return JSONObject.fromObject(jsonMap);
    }
   
     ////删除正式学生的controller
    @RequestMapping(value = "sc_zs_xs", method = RequestMethod.POST)
    public @ResponseBody String sczsxs(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        for (int i=0;i<params.length;i++) { 
           StudentDao.deleteStudentById(Integer.parseInt(params[i]));
        }    
        return "删除成功！";
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
}