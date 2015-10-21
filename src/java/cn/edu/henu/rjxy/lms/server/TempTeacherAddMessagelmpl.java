/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import java.util.Date;
import cn.edu.henu.rjxy.lms.model.TempTeacher;

/**
 *
 * @author Administrator
 */
public class TempTeacherAddMessagelmpl {
    public static boolean addTempTeacherMessage(TempTeacher teacher){
        if(HibernateUtil.teacherGetBysn(teacher.getTeacherSn()) != null){
            return false;
        }
        HibernateUtil.saveTempTeacher(teacher);
        System.err.println("成功");
        return true;
    }  
    
}
