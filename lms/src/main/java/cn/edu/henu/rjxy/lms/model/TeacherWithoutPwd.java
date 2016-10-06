/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

import java.util.Date;

/**
 *
 * @author admin
 */
public class TeacherWithoutPwd implements java.io.Serializable{
     private Integer teacherId;
     private String teacherSn;//工号
     private String teacherName;//姓名
     private String teacherIdcard;//身份证 
     private String teacherCollege;//yuan
     private String teacherTel;//手机号 
     private String teacherQq;//qq 
     private boolean teacherSex;//性别 
     private String teacherPosition;//职称 
     private Date teacherEnrolling;//注册时间
     private int teacherRoleValue;

    public TeacherWithoutPwd() {
    }

    public TeacherWithoutPwd(Integer teacherId, String teacherSn, String teacherName, String teacherIdcard, String teacherCollege, String teacherTel, String teacherQq, boolean teacherSex, String teacherPosition, Date teacherEnrolling, int teacherRoleValue) {
        this.teacherId = teacherId;
        this.teacherSn = teacherSn;
        this.teacherName = teacherName;
        this.teacherIdcard = teacherIdcard;
        this.teacherCollege = teacherCollege;
        this.teacherTel = teacherTel;
        this.teacherQq = teacherQq;
        this.teacherSex = teacherSex;
        this.teacherPosition = teacherPosition;
        this.teacherEnrolling = teacherEnrolling;
        this.teacherRoleValue = teacherRoleValue;
    }

      public void copy(Teacher Teacher){
        this.teacherId = Teacher.getTeacherId();
       this.teacherSn = Teacher.getTeacherSn();
       this.teacherName = Teacher.getTeacherName();
       this.teacherIdcard = Teacher.getTeacherIdcard();
       this.teacherCollege = Teacher.getTeacherCollege();
       this.teacherTel = Teacher.getTeacherTel();
       this.teacherQq = Teacher.getTeacherQq();
       this.teacherSex = Teacher.getTeacherSex();
       this.teacherPosition = Teacher.getTeacherPosition();
       this.teacherRoleValue = Teacher.getTeacherRoleValue();
    }
     
    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherSn() {
        return teacherSn;
    }

    public void setTeacherSn(String teacherSn) {
        this.teacherSn = teacherSn;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTeacherIdcard() {
        return teacherIdcard;
    }

    public void setTeacherIdcard(String teacherIdcard) {
        this.teacherIdcard = teacherIdcard;
    }

    public String getTeacherCollege() {
        return teacherCollege;
    }

    public void setTeacherCollege(String teacherCollege) {
        this.teacherCollege = teacherCollege;
    }

    public String getTeacherTel() {
        return teacherTel;
    }

    public void setTeacherTel(String teacherTel) {
        this.teacherTel = teacherTel;
    }

    public String getTeacherQq() {
        return teacherQq;
    }

    public void setTeacherQq(String teacherQq) {
        this.teacherQq = teacherQq;
    }

    public boolean isTeacherSex() {
        return teacherSex;
    }

    public void setTeacherSex(boolean teacherSex) {
        this.teacherSex = teacherSex;
    }

    public String getTeacherPosition() {
        return teacherPosition;
    }

    public void setTeacherPosition(String teacherPosition) {
        this.teacherPosition = teacherPosition;
    }

    public Date getTeacherEnrolling() {
        return teacherEnrolling;
    }

    public void setTeacherEnrolling(Date teacherEnrolling) {
        this.teacherEnrolling = teacherEnrolling;
    }

    public int getTeacherRoleValue() {
        return teacherRoleValue;
    }

    public void setTeacherRoleValue(int teacherRoleValue) {
        this.teacherRoleValue = teacherRoleValue;
    }
     
     
}
