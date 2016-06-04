package cn.edu.henu.rjxy.lms.model;



/**
 *
 * @author Administrator
 */
public class CourseMaster {

    private Integer courseMasterId;
    private Integer term;
    private Teacher teacher;
    private Course course;

    /**
     * @return the courseMasterId
     */
    public Integer getCourseMasterId() {
        return courseMasterId;
    }

    /**
     * @param courseMasterId the courseMasterId to set
     */
    public void setCourseMasterId(Integer courseMasterId) {
        this.courseMasterId = courseMasterId;
    }


    /**
     * @return the term
     */
    public Integer getTerm() {
        return term;
    }

    /**
     * @param term the term to set
     */
    public void setTerm(Integer term) {
        this.term = term;
    }

    /**
     * @return the teacher
     */
    public Teacher getTeacher() {
        return teacher;
    }

    /**
     * @param teacher the teacher to set
     */
    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    /**
     * @return the course
     */
    public Course getCourse() {
        return course;
    }

    /**
     * @param course the course to set
     */
    public void setCourse(Course course) {
        this.course = course;
    }
}
