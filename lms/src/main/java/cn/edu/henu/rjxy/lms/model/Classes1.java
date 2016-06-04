/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

import java.util.Set;

/**
 *
 * @author Administrator
 */
public class Classes1 {
    private int classId;
    private int classGrade;
    private String className;

    
    public Classes1() {
    }

    public Classes1(int classGrade, String className) {
        this.classGrade = classGrade;
        this.className = className;
    }
    
    public void copy(Classes classes){
        this.setClassId(classes.getClassId());
        this.setClassName(classes.getClassName());
        this.setClassGrade(classes.getClassGrade());
    }
    

    /**
     * @return the classId
     */
    
    
    
    public int getClassId() {
        return classId;
    }

    /**
     * @param classId the classId to set
     */
    public void setClassId(int classId) {
        this.classId = classId;
    }

    /**
     * @return the classGrade
     */
    public int getClassGrade() {
        return classGrade;
    }

    /**
     * @param classGrade the classGrade to set
     */
    public void setClassGrade(int classGrade) {
        this.classGrade = classGrade;
    }

    /**
     * @return the className
     */
    public String getClassName() {
        return className;
    }

    /**
     * @param className the className to set
     */
    public void setClassName(String className) {
        this.className = className;
    }




    
}
