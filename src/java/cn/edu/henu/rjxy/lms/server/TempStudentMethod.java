/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;


import cn.edu.henu.rjxy.lms.dao.CollegeDao;
import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author Administrator
 */
public class TempStudentMethod {
    
    
    
    public static boolean addTempStudentMessage(String studentSn, String studentName,
            String studentIdcard, int studentGrade, String studentCollegeName, String studentTel,
            String studentQq, String studentPwd, String studentSex, Date studentEnrolling){
        if(studentSex.compareTo("男")!= 0 && studentSex.compareTo("女") != 0){//检查性别参数
            return false;
        }
        TempStudent tempStudent = new TempStudent(studentSn, studentName, studentIdcard, studentGrade, CollegeDao.getIdByCollegeName(studentCollegeName), studentTel, studentQq, studentPwd, studentSex.compareTo("男")==0, studentEnrolling);
        TempStudentDao.saveTempStudent(tempStudent);
        return true;
    }
}
