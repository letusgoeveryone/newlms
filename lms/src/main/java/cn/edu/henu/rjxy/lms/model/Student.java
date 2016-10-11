package cn.edu.henu.rjxy.lms.model;
// Generated 2015-10-23 19:30:46 by Hibernate Tools 4.3.1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;




/**
 * Student generated by hbm2java
 */
@Entity(name = "Student")
public class Student  implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
     private Integer studentId;
    @Column(name = "studentSn", length= 45, nullable = false)
     private String studentSn;
    @Column(name = "studentName", length= 45, nullable = false)
     private String studentName;
    @Column(name = "studentIdcard", length= 18, nullable = false)
     private String studentIdcard;
    @Column(name = "studentGrade", length= 18, nullable = false)
     private int studentGrade;
    @Column(name = "studentImgId", length= 18, nullable = true,columnDefinition = "0")
     private int studentImgId;
    @Column(name = "studentCollege", length= 18, nullable = false)
     private String studentCollege;
    @Column(name = "studentTel", length= 20, nullable = false)
     private String studentTel;
    @Column(name = "studentQq", length= 20, nullable = false)
     private String studentQq;
    @Column(name = "studentPwd", length= 45, nullable = false)
     private String studentPwd;
    @Column(name = "studentSex", nullable = false)
     private boolean studentSex;

    public Student() {
    }

    public Student(String studentSn, String studentName, String studentIdcard, int studentGrade, String studentCollege, String studentTel, String studentQq, String studentPwd, boolean studentSex) {
       this.studentSn = studentSn;
       this.studentName = studentName;
       this.studentIdcard = studentIdcard;
       this.studentGrade = studentGrade;
       this.studentCollege = studentCollege;
       this.studentTel = studentTel;
       this.studentQq = studentQq;
       this.studentPwd = studentPwd;
       this.studentSex = studentSex;
    }
    
    public void copy(TempStudent tempStudent){
        this.setStudentCollege(tempStudent.getStudentCollege());
        this.setStudentSn(tempStudent.getStudentSn());
        this.setStudentName(tempStudent.getStudentName());
        this.setStudentIdcard(tempStudent.getStudentIdcard());
        this.setStudentGrade(tempStudent.getStudentGrade());
        this.setStudentTel(tempStudent.getStudentTel());
        this.setStudentQq(tempStudent.getStudentQq());
        this.setStudentPwd(tempStudent.getStudentPwd());
        this.setStudentSex(tempStudent.getStudentSex());
    }
   
    public Integer getStudentId() {
        return this.studentId;
    }
    
    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }
    public String getStudentSn() {
        return this.studentSn;
    }
    
    public void setStudentSn(String studentSn) {
        this.studentSn = studentSn;
    }
    public String getStudentName() {
        return this.studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    public String getStudentIdcard() {
        return this.studentIdcard;
    }
    
    public void setStudentIdcard(String studentIdcard) {
        this.studentIdcard = studentIdcard;
    }
    public int getStudentGrade() {
        return this.studentGrade;
    }
    
    public void setStudentGrade(int studentGrade) {
        this.studentGrade = studentGrade;
    }
    public String getStudentCollege() {
        return this.studentCollege;
    }
    
    public void setStudentCollege(String studentCollege) {
        this.studentCollege = studentCollege;
    }
    public String getStudentTel() {
        return this.studentTel;
    }
    
    public void setStudentTel(String studentTel) {
        this.studentTel = studentTel;
    }
    public String getStudentQq() {
        return this.studentQq;
    }
    
    public void setStudentQq(String studentQq) {
        this.studentQq = studentQq;
    }
    public String getStudentPwd() {
        return this.studentPwd;
    }
    
    public void setStudentPwd(String studentPwd) {
        this.studentPwd = studentPwd;
    }
    public boolean getStudentSex() {
        return this.isStudentSex();
    }
    
    public void setStudentSex(boolean studentSex) {
        this.studentSex = studentSex;
    }



    /**
     * @return the studentSex
     */
    public boolean isStudentSex() {
        return studentSex;
    }

    /**
     * @return the studentImgId
     */
    public int getStudentImgId() {
        return studentImgId;
    }

    /**
     * @param studentImgId the studentImgId to set
     */
    public void setStudentImgId(int studentImgId) {
        this.studentImgId = studentImgId;
    }

   





}


