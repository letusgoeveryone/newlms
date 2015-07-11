package cn.edu.henu.rjxy.lms.bean;
// Generated 2014-8-12 13:22:52 by Hibernate Tools 3.6.0

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Student generated by hbm2java
 */
@Entity
@Table(name = "student", catalog = "lms"
)
public class Student implements java.io.Serializable {

    private Integer stuId;
    private Depart depart;
    private Classes classes;
    private College college;
    private Grade grade;
    private Integer stuSn;
    private String stuName;
    private String stuIdcard;
    private Boolean stuSex;
    private Date stuBirthday;
    private String stuTel;
    private String stuQq;
    private String stuEmail;
    private String stuPwd;
    private Date stuEnrolling;

    public Student() {
    }

    public Student(String name, Integer sn) {
        this.stuName = name;
        this.stuSn = sn;
    }

    public Student(Depart depart, Classes classes, College college, Integer stuSn, String stuName, String stuIdcard, Boolean stuSex, Date stuBirthday, String stuTel, String stuQq, String stuEmail, String stuPwd, Date stuEnrolling) {
        this.depart = depart;
        this.classes = classes;
        this.college = college;
        this.stuSn = stuSn;
        this.stuName = stuName;
        this.stuIdcard = stuIdcard;
        this.stuSex = stuSex;
        this.stuBirthday = stuBirthday;
        this.stuTel = stuTel;
        this.stuQq = stuQq;
        this.stuEmail = stuEmail;
        this.stuPwd = stuPwd;
        this.stuEnrolling = stuEnrolling;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "stu_id", unique = true, nullable = false)
    public Integer getStuId() {
        return this.stuId;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "stu_depart_id")
    public Depart getDepart() {
        return this.depart;
    }

    public void setDepart(Depart depart) {
        this.depart = depart;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "stu_class_id")
    public Classes getClasses() {
        return this.classes;
    }

    public void setClasses(Classes classes) {
        this.classes = classes;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "stu_college_id")
    public College getCollege() {
        return this.college;
    }

    public void setCollege(College college) {
        this.college = college;
    }

    @Column(name = "stu_sn")
    public Integer getStuSn() {
        return this.stuSn;
    }

    public void setStuSn(Integer stuSn) {
        this.stuSn = stuSn;
    }

    @Column(name = "stu_name", length = 40)
    public String getStuName() {
        return this.stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    @Column(name = "stu_idcard", length = 18)
    public String getStuIdcard() {
        return this.stuIdcard;
    }

    public void setStuIdcard(String stuIdcard) {
        this.stuIdcard = stuIdcard;
    }

    @Column(name = "stu_sex")
    public Boolean getStuSex() {
        return this.stuSex;
    }

    public void setStuSex(Boolean stuSex) {
        this.stuSex = stuSex;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "stu_birthday", length = 10)
    public Date getStuBirthday() {
        return this.stuBirthday;
    }

    public void setStuBirthday(Date stuBirthday) {
        this.stuBirthday = stuBirthday;
    }

    @Column(name = "stu_tel", length = 20)
    public String getStuTel() {
        return this.stuTel;
    }

    public void setStuTel(String stuTel) {
        this.stuTel = stuTel;
    }

    @Column(name = "stu_qq", length = 20)
    public String getStuQq() {
        return this.stuQq;
    }

    public void setStuQq(String stuQq) {
        this.stuQq = stuQq;
    }

    @Column(name = "stu_email", length = 40)
    public String getStuEmail() {
        return this.stuEmail;
    }

    public void setStuEmail(String stuEmail) {
        this.stuEmail = stuEmail;
    }

    @Column(name = "stu_pwd")
    public String getStuPwd() {
        return this.stuPwd;
    }

    public void setStuPwd(String stuPwd) {
        this.stuPwd = stuPwd;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "stu_enrolling", length = 19)
    public Date getStuEnrolling() {
        return this.stuEnrolling;
    }

    public void setStuEnrolling(Date stuEnrolling) {
        this.stuEnrolling = stuEnrolling;
    }

    /**
     * @return the grade
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "stu_grade_id")
    public Grade getGrade() {
        return grade;
    }

    /**
     * @param grade the grade to set
     */
    public void setGrade(Grade grade) {
        this.grade = grade;
    }

}
