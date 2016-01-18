/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TermOpenCourseDao;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TermOpenCourse;

/**
 *
 * @author Administrator
 * 学期开课表，包括学期，课程，课程负责人
 */
public class TermOpenCourseMethod {
    

    public void saveOpenCourse(int term, int teacherId, int CourseId) {
        Teacher teacher = TeacherDao.getTeacherById(teacherId);
        Course course = new CourseDao().getCourseById(CourseId);
        new TermOpenCourseDao().saveTermOpenCourse(new TermOpenCourse(term, course, teacher));
    }
    
    
    public void deleteOpenCourseById(int id){
        new TermOpenCourseDao().deleteTermOpenCourseById(id);
    }
    

    public void deleteTermOpenCourse(TermOpenCourse termOpenCourse) {
        new TermOpenCourseDao().deleteTermOpenCourse(termOpenCourse);
    }
    

    public TermOpenCourse getTermOpenCourse(int id) {
        return new TermOpenCourseDao().getTermOpenCourse(id);
    }
    
    
    
}
