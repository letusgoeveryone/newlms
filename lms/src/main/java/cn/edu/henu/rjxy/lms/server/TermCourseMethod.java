/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.ClassesDao;
import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseDao;
import cn.edu.henu.rjxy.lms.model.Classes;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TermCourse;

/**
 *
 * @author Administrator
 * 学期课程表，包含学期，课程，授课人，班级信息
 */


public class TermCourseMethod {
    
    /**
     *保存一个学期课程
     * @param term 学期
     * @param teacherSn 教师工号
     * @param courseName 课程名
     * @param classId 班级id
     */
    public static void saveTermCourse(Integer term, String teacherSn, String courseName, Integer classId){
        Course course = CourseDao.getCourseByName(courseName);
        Classes classes = ClassesDao.getClassById(classId);
        Teacher teacher = TeacherDao.getTeacherBySn(teacherSn);
        TermCourseDao.saveTermCourse(new TermCourse(term,  course,  classes,  teacher));
    }
    public static void main(String[] args) {
        saveTermCourse(201501, "1445203222", "mysql", 2);
    }
    
    /**
     *根据id删除一个学期课程
     * @param id 学期课程id
     */
    public void deleteTermCourseById(Integer id){
         TermCourseDao.deleteTermCourseById(id);
    }
    
    /**
     *根据id获取学期课程
     * @param id 学期课程Id
     * @return
     */
    public TermCourse getTermCourse(Integer id){
         return TermCourseDao.getTermCourseById(id);
    }
    
}
