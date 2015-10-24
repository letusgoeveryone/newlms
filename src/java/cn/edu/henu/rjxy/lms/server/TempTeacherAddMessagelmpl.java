/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;

import cn.edu.henu.rjxy.lms.model.TempTeacher;
import java.util.Date;

/**
 *
 * @author Administrator
 */
public class TempTeacherAddMessagelmpl {
        //性别和学院信息我在下面做了转换，添加参数时，学院名称会在下面自动转换为学院代号，性别填“男”或“女”，否则注册失败
        //我觉得这里注册失败不应返回发fals而是抛出异常，这个容后再说
    public static boolean addTempTeacherMessage(int teacherSn, String teacherName, String teacherIdcard, String teacherCollegeName, int teacherDepartId, String teacherTel, String teacherQq, String teacherPwd, String teacherSex, int teacherPositionId, Date teacherEnrolling){
        if(teacherSex.compareTo("男") != 0 && teacherSex.compareTo("女") != 0 ){
            return false;
        }
        TempTeacher tempTeacher = new TempTeacher(teacherSn, teacherName, teacherIdcard, HibernateUtil.getIdByCollegeName(teacherCollegeName), teacherDepartId, teacherTel, teacherQq, teacherPwd, teacherSex.compareTo("男")==0, teacherPositionId, teacherEnrolling);
        HibernateUtil.saveTempTeacher(tempTeacher);
//        System.err.println("成功");
        return true;
    }  
    
}
