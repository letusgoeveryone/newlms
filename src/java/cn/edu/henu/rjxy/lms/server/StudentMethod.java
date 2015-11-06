/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;
import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.model.Student;

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
    
    public static void main(String[] args) {
        
        StudentDao.saveStudent(new Student("1445203133", "小郑", "412824199502190611", 2015, 10, "13839248586", "434345356", "123456", true));
        if(studentSignInByUserName("1445203133", "123456")) System.out.print("登录成功");
    }
    
}
