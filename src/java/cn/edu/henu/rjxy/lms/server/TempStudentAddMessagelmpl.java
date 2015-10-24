/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import java.util.Date;
import org.hibernate.Hibernate;
import org.hibernate.SessionFactory;



/**
 *
 * @author Administrator
 */
public class TempStudentAddMessagelmpl {
    public static final SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    public static boolean addTempStudentMessage(int studentSn, String studentName, String studentIdcard, int studentGrade, String studentCollegeName, String studentTel, String studentQq, String studentPwd, String studentSex, Date studentEnrolling){
        //性别和学院信息我在下面做了转换，添加参数时，学院名称会在下面自动转换为学院代号，性别填“男”或“女”，否则注册失败
        //我觉得这里注册失败不应返回发fals而是抛出异常，这个容后再说
        if(studentSex.compareTo("男")!= 0 && studentSex.compareTo("女") != 0){//检查性别参数
            return false;
        }
        TempStudent tempStudent = new TempStudent(studentSn, studentName, studentIdcard, studentGrade, HibernateUtil.getIdByCollegeName(studentCollegeName) , studentTel, studentQq, studentPwd, studentSex.compareTo("男")==0, studentEnrolling);
        HibernateUtil.saveTempStudent(tempStudent);
        return true;
    }
}
