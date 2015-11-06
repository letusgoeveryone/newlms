package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;

/**
 *该类包含了关于正式老师的相关操作
 * @author Administrator
 */
public class TeacherMethod {
    
    /**
     * 
     * @param userName  用户名，填写学号（10位），手机号（11位），身份证号（其它位数）都可以
     * @param stuPwd    密码
     * @return   用户名正确，不重复，且与相应的密码吻合则返回true，否则返回false
     */
    public static boolean teacherSignInByUserName(String userName, String stuPwd){
        QueryResult queryResult = TeacherDao.getTeacherByUserName(userName);
        if(queryResult.getNumber() == 1){
            cn.edu.henu.rjxy.lms.model.Teacher teacher = (cn.edu.henu.rjxy.lms.model.Teacher)queryResult.getE();
            if(teacher.getTeacherPwd().compareTo(stuPwd)==0){
               return true;
           }
       }
       return false;
    }
}

