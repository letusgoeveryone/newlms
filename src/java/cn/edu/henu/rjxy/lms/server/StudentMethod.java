/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;
import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.TempStudent;

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
    
    public static boolean studentSignInByUserName(String userName, String stuPwd){
       QueryResult queryResult = StudentDao.getStudentByUserName(userName);
       if(queryResult.getNumber() == 1){//结果惟一
           cn.edu.henu.rjxy.lms.model.Student student = (cn.edu.henu.rjxy.lms.model.Student)queryResult.getE();
           if(student.getStudentPwd().compareTo(stuPwd)==0){//密码吻合
               return true;
                }
       }
       return false;
    }
    
        //当且仅当学号和身份证查询到同一对象时，才将该对象添加到正式表
        public static void addStudentFromtempStudent(String tempStudentSn, String tempStudentIdcard){
            TempStudent tempStudent1 =(TempStudent) TempStudentDao.getTempStudentByUserName(tempStudentSn).getE();
            TempStudent tempStudent2=(TempStudent) TempStudentDao.getTempStudentByUserName(tempStudentIdcard).getE();
            
                Student student = new Student();
                student.copy(tempStudent2);
                StudentDao.saveStudent(student);
                
        }
    
        public static void main(String[] args) {
            addStudentFromtempStudent("1445203130", "012345678912345678");
    }
    
}
