/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;

import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.server.CurrentInfo;
import cn.edu.henu.rjxy.lms.server.KingoApi;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/reg")
public class Student_teacher_registercontroller {

    @RequestMapping("/student_teacher")
    public String student_register1() {

        return "register/student_teacher";
    }

    @RequestMapping("/teacher_register")
    public String teacherRegister1() {

        return "register/teacher_register";
    }

    @RequestMapping("/student_register")
    public String studet_sign1() {
        return "register/student_register";
    }
    @RequestMapping("/tmptest")
    public @ResponseBody String tmptest() {
        
        return CurrentInfo.getFileFolder();
    }    
    @RequestMapping("/tmp_attestation")
    public @ResponseBody String[] tmp_attestation(HttpServletRequest request, HttpServletResponse response)  {
        //TempStudent stu = TempStudentDao.getTempStudentById();
        String sn=request.getParameter("sn");
        List<TempStudent> tempStudentList = TempStudentDao.getTempStudentListBySn(sn);
        TempStudent stu = tempStudentList.get(tempStudentList.size()-1);
        //TempStudent stu = TempStudentDao.getTempStudentBySn(sn);
        String s="";
        String []result = new String[1];
        result[0]="";
        KingoApi k=new KingoApi();
        s=stu.getStudentIdcard();
        s=s.substring(s.length()-6).toLowerCase();
        k.setUserandPw(stu.getStudentSn(),s );
        System.out.println("尝试认证：sn:"+sn+",password:"+s);
        s=k.step1();
        if(s.equals("")){
                result[0]="认证服务器连接失败";
        }else{
                s=k.step2();
                if(s.indexOf("callback_err_login")>-1){
                        result[0]="密码有误";
                }else {
                        k.step3("http://xk.henu.edu.cn:8093");
                        s=k.step4();
                        String name=k.stringSub(s,"<xm>","</xm>");
                        String sfz=k.stringSub(s,"<sfzjh>","</sfzjh>");
//                        现阶段认证包含三部分：学号，姓名，身份证
//                        String grade=k.stringSub(s,"<rxnj>","</rxnj>");
//                        String college=k.stringSub(s,"<yxb>","</yxb>");
//                        String sex=k.stringSub(s,"<xb>","</xb>");
//                        String telnum=k.stringSub(s,"<dh>","</dh>");
                        if (name.equals(stu.getStudentName())&&sfz.equalsIgnoreCase(stu.getStudentIdcard())) {
                            result[0]="认证成功";
                        }else{
                            result[0]="登录授权成功，认证信息失败。";
                        }
                        System.out.println(s);
                }
        }
        return result;
    }
}
