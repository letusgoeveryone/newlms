/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import java.util.List;


/**
 *
 * @author Administrator
 */
public class StudentMethod {
    
    /**
     * 学生登录
     * @param userName 用户名，填写学号（10位），手机号（11位），身份证号（其它位数）都可以
     * @param stuPwd   密码
     * @return  用户名正确，不重复，且与相应的密码吻合则返回true，否则返回false
     */
    //根据学号，密码登录认证
    public static boolean studentSignInByUserName(String userName, String stuPwd){
       Student student = StudentDao.getStudentBySn(userName);
       if(userName.equals(student.getStudentName())){
           return true;
       }
       return false;
    }
    
      public static String studentLoginGetPasswordByUserName(String userName){
       Student student = StudentDao.getStudentBySn(userName);
          if (student != null) {
              return student.getStudentPwd();
          }else{
              return "";
        }   
      }
    
    /**
     *为所有学生分页
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个分页bean对象
     */
    public static PageBean<Student>  findAll(Integer pc, Integer ps){
        return StudentDao.findAll(pc, ps);
    }
    
    /**
     * 将一个临时学生加入到正式学生中
     *
     * @param tempStudent 临时学生对象
     */
    public static void addStudentFromtempStudent(TempStudent tempStudent) {
        StudentDao.addStudentFromtempStudent(tempStudent);
    }
    
    /**
     * 获取全部正式学生
     * @return 返回全体正式学生的集合（不含密码）
     */
    public List getAllStudent() {
        return StudentDao.getAllStudent();
    }
    
    /**
     * 根据id将一个临时学生加入到正式学生中
     * @param id 临时学生id
     */
    public void addStudentFromtempStudent(Integer id) {
        StudentDao.addStudentFromtempStudent(TempStudentDao.getTempStudentById(id));
    }
    
}
