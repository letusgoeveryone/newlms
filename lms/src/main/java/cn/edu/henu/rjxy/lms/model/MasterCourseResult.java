/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

/**
 *
 * @author Administrator
 */
public class MasterCourseResult {

    private String courseName;
    private Integer teacherId;
    private String teacherSn;
    private String teacherName;

    public MasterCourseResult() {
    }

    public MasterCourseResult(String courseName, String teacherName, Integer teacherId, String teacherSn) {
        this.courseName = courseName;
        this.teacherName = teacherName;
        this.teacherId = teacherId;
        this.teacherSn = teacherSn;
    }

    /**
     * @return the courseName
     */
    public String getCourseName() {
        return courseName;
    }

    /**
     * @param courseName the courseName to set
     */
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    /**
     * @return the teacherSn
     */
    public String getTeacherSn() {
        return teacherSn;
    }

    /**
     * @param teacherSn the teacherSn to set
     */
    public void setTeacherSn(String teacherSn) {
        this.teacherSn = teacherSn;
    }

    /**
     * @return the teacherName
     */
    public String getTeacherName() {
        return teacherName;
    }

    /**
     * @param teacherName the teacherName to set
     */
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    /**
     * @param teacherId the teacherId to set
     */
    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    /**
     * @return the teacherId
     */
    public Integer getTeacherId() {
        return teacherId;
    }
}
