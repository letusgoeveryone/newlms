/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.StudentSelectCourse;
import cn.edu.henu.rjxy.lms.model.TermCourse;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *对学生选课情况进行记录
 * @author Administrator
 */
public class StudentSelectCourseDao {
    static Session session;
    public static void saveStudentSelectCourse( String studentSn, Integer termCourseId, Integer state) {
        Student student = StudentDao.getStudentBySn(studentSn);
        if (student == null) {
            throw new RuntimeException("找不到学号对应的学生，找不到的学号为"+studentSn);
        }
        TermCourse tc = TermCourseDao.getTermCourseById(termCourseId);
        Integer courseId = tc.getCourse().getCourseId();
        if (tc == null) {
            throw  new RuntimeException("找不到对应课程,找不到的课程id为"+termCourseId);
        }
        StudentSelectCourse studentSelectCourse = new StudentSelectCourse( student, tc, state);
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List list = session.createQuery("FROM StudentSelectCourse s WHERE s.student.studentSn = :sn AND s.termCourse.course.courseId = :id")
                    .setString("sn", studentSn)
                    .setInteger("id", courseId)
                    .list();
            
            if (list.isEmpty()) {
                session.save(studentSelectCourse);
            }else{
                throw new RuntimeException("选课重复,重复学号为："+studentSn+"重复选课id为"+termCourseId);
            }
            
            
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    
    public static List<StudentSelectCourse> getStudentSelectCourseByTermSnCourseId(Integer term, String studentSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            List<StudentSelectCourse> list = session.createQuery("FROM StudentSelectCourse s WHERE s.termCourse.term = :term AND s.student.studentSn = :sn")
                    .setInteger("term", term)
                    .setString("sn", studentSn)
                    .list();
            
            
            transaction.commit();//提交
            return list;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static StudentSelectCourse getStudentSelectCourseByTermStudentId(Integer termCourseId, Integer studentId) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            StudentSelectCourse ssc = (StudentSelectCourse)session.createQuery("FROM StudentSelectCourse s WHERE s.termCourse.id = :termCourseId AND s.student.studentId = :id")
                    .setInteger("termCourseId", termCourseId)
                    .setInteger("id", studentId)
                    .uniqueResult();
            transaction.commit();//提交
            return ssc;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
//    public static void main(String[] args) {
//           // StudentSelectCourse ssc = getStudentSelectCourseByTermStudentId(1,1);
//          //  updateStudentSelectCourse(ssc);
//            
//    }
    //查询某一学生已选课程（老师已确认）
    public static List getStudentSelectCourseNameByTermSnCourseId(Integer term, String studentSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            List<StudentSelectCourse> list = session.createQuery("FROM StudentSelectCourse s WHERE s.termCourse.term = :term AND s.student.studentSn = :sn AND s.state=1")
                    .setInteger("term", term)
                    .setString("sn", studentSn)
                    .list();
            
            List fList = new LinkedList();
            
            for (StudentSelectCourse list1 : list) {
                fList.add(list1.getTermCourse().getId());
                fList.add(list1.getTermCourse().getCourse().getCourseName());
                fList.add(list1.getTermCourse().getTeacher().getTeacherName());
                fList.add(list1.getTermCourse().getClasses().getClassName());
            }

            transaction.commit();//提交
            return fList;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
 //查询某一学生已选课程（老师未确认）
 public static List getStudentSelectCourseNameByTermSnCourseId2(Integer term, String studentSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            List<StudentSelectCourse> list = session.createQuery("FROM StudentSelectCourse s WHERE s.termCourse.term = :term AND s.student.studentSn = :sn AND s.state=0")
                    .setInteger("term", term)
                    .setString("sn", studentSn)
                    .list();
            
            List fList = new LinkedList();
            
            for (StudentSelectCourse list1 : list) {
                fList.add(list1.getTermCourse().getId());
                fList.add(list1.getTermCourse().getCourse().getCourseName());
                fList.add(list1.getTermCourse().getTeacher().getTeacherName());
                fList.add(list1.getTermCourse().getClasses().getClassName());
            }

            transaction.commit();//提交
            return fList;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
 
    public static void updateStudentSelectCourse(StudentSelectCourse studentSelectCourse) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            session.update(studentSelectCourse);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    
    /**
     *删除指定选课记录
     * @param term
     * @param studentSn
     * @param courseId
     */
    public static void deleteStudentSelectCourse(Integer term, String studentSn, Integer courseId) {
       
        List<StudentSelectCourse> list = getStudentSelectCourseByTermSnCourseId(term, studentSn);
        StudentSelectCourse studentSelectCourse = null;
        for (StudentSelectCourse list1 : list) {
            if (list1.getTermCourse().getId() == courseId) {
                studentSelectCourse = list1;
            }
        }
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            session.delete(studentSelectCourse);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    

    public static Integer getTermCourseIdByothers(Integer term,Integer courseId,Integer classId, Integer teacherId){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            List<TermCourse> list = session.createQuery(
                    "FROM TermCourse s WHERE s.term = :term AND s.course.courseId = :courseId AND s.classes.classId = :classId AND s.teacher.teacherId = :teacherId")
                    .setInteger("term", term)
                    .setInteger("courseId", courseId)
                    .setInteger("classId", classId)
                    .setInteger("teacherId", teacherId)
                    .list();
            Integer x = 0;
            
            
            if(list.isEmpty()){
                throw new RuntimeException("所查课程为空");
            }else if(list.size() == 1){
                TermCourse tc = list.iterator().next();
                x = tc.getId();
            }else{
                throw new RuntimeException("所查课程重复");
            }

            transaction.commit();//提交
            return  x;
            
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }

  
    
}
