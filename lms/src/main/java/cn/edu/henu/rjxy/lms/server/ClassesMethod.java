/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.ClassesDao;
import cn.edu.henu.rjxy.lms.model.Classes;
import cn.edu.henu.rjxy.lms.model.PageBean;

/**
 *
 * @author Administrator
 */
public class ClassesMethod {
    
    /**
     *添加一个班级
     * @param classGrade 班级年级
     * @param className  班级名
     */
    public void addClass(Integer classGrade, String className ){
        Classes classes = new Classes();
        classes.setClassGrade(classGrade);
        classes.setClassName(className);
        ClassesDao.addClass(classes);
    }
    
    /**
     *根据id删除一个班级
     * @param id 班级id
     */
    public static boolean deleteClassById(Integer id){

        return ClassesDao.deleteClass(ClassesDao.getClassById(id));
    }
    public static void main(String[] args) {
        System.out.println(deleteClassById(6));;
    }
    
    /**
     * 根据课程在数据库的id返回这个课程
     * @param id  课程id 
     * @return 返回一个课程对象
     */
    public Classes getClassById(Integer id){
        return ClassesDao.getClassById(id);
    }
    
    /**
     * 对所有课程分页
     * @param pc  当前页数
     * @param ps  每页记录数
     * @return 返回一个分页bean对象
     */
    public PageBean<Classes>  findAll(Integer pc, Integer ps){
        return ClassesDao.findAll(pc, ps);
    }
    

    
}
