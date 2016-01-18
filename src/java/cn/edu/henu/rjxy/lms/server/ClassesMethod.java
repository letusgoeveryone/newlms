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
    
    public void addClass(int classGrade, String className ){
        Classes classes = new Classes();
        classes.setClassGrade(classGrade);
        classes.setClassName(className);
        new ClassesDao().addClass(classes);
    }
    
    public void deleteClassById(int id){
        ClassesDao classesDao = new ClassesDao();
        classesDao.deleteClass(classesDao.getClassById(id));
    }
    
    
    public Classes getClassById(int id){
        return new ClassesDao().getClassById(id);
    }
    
    public PageBean<Classes>  findAll(int pc, int ps){
        return new ClassesDao().findAll(pc, ps);
    }
    
    public static void main(String[] args) {
        ClassesMethod classesMethod = new ClassesMethod();
        classesMethod.addClass(2222, "网工三班");
    }
    
}
