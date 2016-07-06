/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;



/**
 *记录学生所选课程
 * @author Administrator
 */
public class StudentSelectCourse {
    private Integer id;
    private Student student;
    private TermCourse termCourse;
    private Integer state;

    public StudentSelectCourse() {
    }

    public StudentSelectCourse( Student student, TermCourse termCourse, Integer state) {
        this.student = student;
        this.termCourse = termCourse;
        this.state = state;
    }
    
    


    


    /**
     * @return the student
     */
    public Student getStudent() {
        return student;
    }

    /**
     * @param student the student to set
     */
    public void setStudent(Student student) {
        this.student = student;
    }



    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the state
     */
    public Integer getState() {
        return state;
    }

    /**
     * @param state the state to set
     */
    public void setState(Integer state) {
        this.state = state;
    }

    /**
     * @return the termCourse
     */
    public TermCourse getTermCourse() {
        return termCourse;
    }

    /**
     * @param termCourse the termCourse to set
     */
    public void setTermCourse(TermCourse termCourse) {
        this.termCourse = termCourse;
    }

}
