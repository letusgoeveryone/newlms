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
    
    
    
    public void saveTermCourse(int term, int teacherId, int courseId, int classId){
        Course course = new CourseDao().getCourseById(courseId);
        Classes classes = new ClassesDao().getClassById(classId);
        Teacher teacher = TeacherDao.getTeacherById(teacherId);
        new TermCourseDao().saveTermCourse(new TermCourse(term,  course,  classes,  teacher));
    }
    
    public void deleteTermCourseById(int id){
         new TermCourseDao().deleteTermCourseById(id);
    }
    
    public TermCourse getTermCourse(int id){
         return new TermCourseDao().getTermCourseById(id);
    }
    
}
