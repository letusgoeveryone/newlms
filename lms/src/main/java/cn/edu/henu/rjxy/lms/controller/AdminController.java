/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.model.ManageResult;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.Teacher;
import java.io.UnsupportedEncodingException;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.edu.henu.rjxy.lms.server.AuthorityManage;
import cn.edu.henu.rjxy.lms.server.CurrentInfo;
/**
 *
 * @author Administrator
 */
@Controller
public class AdminController {

    @RequestMapping("/admin")
    public String personal_InfInformation(HttpServletRequest request, HttpServletResponse response) {
	request.setAttribute("username",SecurityContextHolder.getContext().getAuthentication().getName());
        return "admin/Index";
    }

    @RequestMapping("/admin/FunctionManage")
    public String functionManage(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("AllTerm", listToString(CurrentInfo.getAllTerm()));
        request.setAttribute("AllGrade",listToString(CurrentInfo.getAllGrade()));
        request.setAttribute("AllCollege", listToString(CurrentInfo.getAllCollege()));
        request.setAttribute("CurrentTerm", CurrentInfo.getCurrentTerm());
        request.setAttribute("FileFolder", CurrentInfo.getFileFolder());

        return "admin/FunctionManage";
    }
    //保存配置提交
    @RequestMapping("/admin/saveconfigure")
    public @ResponseBody String adminSaveConfigure(HttpServletRequest request, HttpServletResponse response) {
        String AllTerm=request.getParameter("AllTerm");
        String AllGrade=request.getParameter("AllGrade");
        String AllCollege=request.getParameter("AllCollege");
        String CurrentTerm=request.getParameter("CurrentTerm");
        String FileFolder=request.getParameter("FileFolder");
        String Selfverification=request.getParameter("Selfverification");
//        System.out.println("\n"+AllTerm+"\n==========================\n"+
//                "\n"+AllGrade+"\n==========================\n"+
//                "\n"+CurrentTerm+"\n==========================\n"+
//                "\n"+AllCollege+"\n==========================\n"+
//                "\n"+FileFolder+"\n==========================\n"+
//                "\n"+Selfverification+"\n==========================\n");
        CurrentInfo.setAllCollege(AllCollege);
        CurrentInfo.setAllGrade(AllGrade);
        CurrentInfo.setAllTerm(AllTerm);
        CurrentInfo.setCurrentTerm(CurrentTerm);
        CurrentInfo.setFileFolder(FileFolder);
        CurrentInfo.setOtherConfigure("Selfverification", Selfverification);
        return "0";
    }
     public static String listToString(List<String> stringList){
        if (stringList==null) {
            return null;
        }
        StringBuilder result=new StringBuilder();
        boolean flag=false;
        for (String string : stringList) {
            if (flag) {
                result.append(",");
            }else {
                flag=true;
            }
            result.append(string);
        }
        return result.toString();
    }
     
    @RequestMapping("admin/PersonManage")
    public String PersonManage(HttpServletRequest request, HttpServletResponse response) {
        return "admin/PersonManage";
    }

    @RequestMapping("/admin/UserSituation")
    public String UserSituation(HttpServletRequest request, HttpServletResponse response) {
        Integer t = TeacherDao.getAllTeacher().size();
        Integer tt = TempTeacherDao.getAllTempTeacher().size();
        Integer s = StudentDao.getAllStudent().size();
        Integer ts = TempStudentDao.getAllTempStudent().size();
        request.setAttribute("t", t);
        request.setAttribute("tt", tt);
        request.setAttribute("s", s);
        request.setAttribute("ts", ts);

        return "admin/UserSituation";
    }

    @RequestMapping("/admin/ServerInfo")
    public String ServerInformation(HttpServletRequest request, HttpServletResponse response) {
        return "admin/EnvInfo";
    }
    
    
    @RequestMapping("/admin/pinfo")
    public String pinfo(HttpServletRequest request, HttpServletResponse response) {

        return "/admin/PersonalInfo";
    }
    //返回admin信息
    @RequestMapping("/admin/getpersoninfo")
    public @ResponseBody Teacher adminPersonalInformation(HttpServletRequest request, HttpServletResponse response) {
        String sn=AuthorityManage.getCurrentUsername();
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
        teacher.setTeacherPwd("");
        teacher.setTeacherRoleValue(0);
        teacher.setTeacherEnrolling(null);
        teacher.setTermCourse(null);
        return teacher;
    }
     //个人信息修改提交处理
    @RequestMapping("/admin/updatepersoninfo")
    public @ResponseBody String adminUpdatePersonInfo(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String sn=AuthorityManage.getCurrentUsername();
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
        String name=request.getParameter("name");
        String idcard=request.getParameter("idcard");
        String college=request.getParameter("college");
        String sex=request.getParameter("sex");
        String telnum=request.getParameter("telnum");
        String qqnum=request.getParameter("qqnum");
        if (!name.matches("[\u4e00-\u9fa5]{2,4}")) {
            return "姓名校验未通过！";
        }
        teacher.setTeacherName(name);
        if (!idcard.matches("([0-9]{17}([0-9]|X))|([0-9]{15})") ){
            return "身份证校验未通过！";
        }       
        teacher.setTeacherIdcard(idcard);
        teacher.setTeacherCollege(college);
        teacher.setTeacherSex(sex.equals("男"));
        if (!telnum.matches("\\d{11}") ){
            return "电话号码校验未通过！";
        } 
        teacher.setTeacherTel(telnum);
        if (!qqnum.matches("\\d{5,10}") ){
            return "QQ号码校验未通过！";
        } 
        teacher.setTeacherQq(qqnum);
        TeacherDao.updateTeacherById(teacher);
        return "1";
    }
    //密码修改提交处理
    @RequestMapping("/admin/updatepassword")
    public @ResponseBody String adminUpdatePassword(HttpServletRequest request, HttpServletResponse response) {
        String sn=AuthorityManage.getCurrentUsername();
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
        String pw=request.getParameter("pw");
        String repw=request.getParameter("repw");
        if (repw.matches("\\w{6,18}")) {
             return "0";}
        if (!pw.equals(teacher.getTeacherPwd().toLowerCase())) {
             return "1";}
        if (pw.equals(repw.toLowerCase())) {
             return "2";}
        teacher.setTeacherPwd(repw);
        TeacherDao.updateTeacherById(teacher);
        return "3";
    }
    @RequestMapping("admin/search")
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

    @RequestMapping("admin/all")
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

    @RequestMapping("admin/czmm")
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

    @RequestMapping("admin/teacher")
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

    @RequestMapping("/admin/rolecheck")
    public @ResponseBody
    String[] rolecheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        String p = request.getParameter("p");
        String[] a = new String[1];

        String sn = request.getParameter("sn");

        StringBuffer sb = new StringBuffer();
        sb.append("<form role=\"form\">已选择教师sn：" + sn + "<br><div class=\"checkbox\">");
        List<String> list = AuthorityManage.getCurrentAuthoritiest(sn);
        String str[] = {"ROLE_ACDEMIC","ROLE_DEAN","ROLE_TEACHER", "ROLE_ADMIN"};
        String str2[] = {"教务员", "院长",  "教工", "系统管理员"};
        String str3[] = {"1", "2", "4", "8"};
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

    @RequestMapping("/admin/roleset")
    public @ResponseBody
    String roleset(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //System.out.println("logincheck");
        request.setCharacterEncoding("UTF-8");
        String sn = request.getParameter("sn");
        String rolesum = request.getParameter("rolesum");
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
        teacher.setTeacherRoleValue(Integer.valueOf(rolesum));
        TeacherDao.updateTeacherById(teacher);
        return "ok";
    }
}
