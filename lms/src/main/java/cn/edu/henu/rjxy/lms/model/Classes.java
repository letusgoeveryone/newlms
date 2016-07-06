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
public class Classes {
    private int classId;
    private int classGrade;
    private String className;
    private Set<TermCourse> termCourse;
    private Set<TermClass> termClass;
    
    public Classes() {
    }

    public Classes(int classGrade, String className) {
        this.classGrade = classGrade;
        this.className = className;
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



    /**
     * @return the termCourse
     */
    public Set<TermCourse> getTermCourse() {
        return termCourse;
    }

    /**
     * @param termCourse the termCourse to set
     */
    public void setTermCourse(Set<TermCourse> termCourse) {
        this.termCourse = termCourse;
    }

    /**
     * @return the termClass
     */
    public Set<TermClass> getTermClass() {
        return termClass;
    }

    /**
     * @param termClass the termClass to set
     */
    public void setTermClass(Set<TermClass> termClass) {
        this.termClass = termClass;
    }


    
}
