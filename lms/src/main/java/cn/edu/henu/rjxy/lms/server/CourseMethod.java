/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.PageBean;



/**
 *
 * @author Administrator
 */
public class CourseMethod {
    
    /**
     * 
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个PageBean对象  内有分页所需数据
     */
    public static PageBean<Course>  findAllCourse(Integer pc, Integer ps){
        return CourseDao.findAllCourse(pc, ps);
    }
    
    /**
     * 添加一个课程
     * @param courseNumber 课程编号
     * @param courseName  课程中文名称
     * @param courseEname 课程英文名称
     * @param courseCredit 课程学分
     * @param faceTeacherHourse 面授学时
     * @param testTeacherHourse 实验学时
     * @param courseType 课程类型
     * 
     */
    public static void addCourse(String courseNumber, String courseName, String courseEname, String courseType, Integer faceTeacherHourse, Integer testTeacherHourse, Integer courseCredit) {
        Course course = new Course(courseNumber, courseName, courseEname, courseType, faceTeacherHourse, testTeacherHourse, courseCredit);
        CourseDao.addCourse(course);
    }

    /**
     *根据id删除课程
     * @param id 课程id
     */
    public static boolean deleteCourse(Integer id){
       return CourseDao.deleteCourse(id);
    }
}
