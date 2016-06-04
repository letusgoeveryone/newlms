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
    
    /**
     *保存一个学期开课课程
     * @param term 学期

     * @param CourseId 课程id
     */
    public static void saveOpenCourse(Integer term,  Integer CourseId) {
        Course course = CourseDao.getCourseById(CourseId);
        TermOpenCourseDao.saveTermOpenCourse(new TermOpenCourse(term, course));
    }
    public static void main(String[] args) {
        //saveOpenCourse(201601, 1);
    }
    
    /**
     *根据id删除学期开课课程
     * @param id 学期开课课程
     */
    public void deleteOpenCourseById(Integer id){
        TermOpenCourseDao.deleteTermOpenCourseById(id);
    }
    
    /**
     *删除一个学期开课课程
     * @param termOpenCourse 学期开课课程对象
     */
    public void deleteTermOpenCourse(TermOpenCourse termOpenCourse) {
        TermOpenCourseDao.deleteTermOpenCourse(termOpenCourse);
    }
    
    /**
     *根据id获取一个学期开课课程
     * @param id 学期开课课程id
     * @return 学期开课课程对象
     */
    public TermOpenCourse getTermOpenCourse(Integer id) {
        return TermOpenCourseDao.getTermOpenCourse(id);
    }
    
    
    
}
