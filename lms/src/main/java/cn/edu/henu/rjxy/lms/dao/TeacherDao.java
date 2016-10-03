/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;


import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.CourseMaster;
import cn.edu.henu.rjxy.lms.model.NewClass;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.StuSelectResult;
import cn.edu.henu.rjxy.lms.model.StudentSelectCourse;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TeacherCourseResult;
import cn.edu.henu.rjxy.lms.model.Teachers;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.*;
import cn.edu.henu.rjxy.lms.model.TermCourse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;


/**
 * 对正式老师的基本操作
 *
 * @author Administrator
 */
public class TeacherDao {

    static Session session;

    //根据用户名查询正式教师对象

    /**
     *根据id获取教师
     * @param id 教师id
     * @return 返回指定教师
     */
    public static Teacher getTeacherById(Integer id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Teacher teacher = (Teacher) session.get(Teacher.class, id);
            transaction.commit();//提交
            return teacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
        
        
    }
    
    public static boolean isCourseMaster(Integer term, Integer teacherId, Integer courseId) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            CourseMaster cm = (CourseMaster) session.createQuery("FROM CourseMaster c WHERE c.teacher.teacherId = :tid AND c.course.courseId = :cid AND c.term = :term")
                    .setInteger("term", term)
                    .setInteger("tid", teacherId)
                    .setInteger("cid", courseId)
                    .uniqueResult();
            boolean flag = (cm != null);
            transaction.commit();//提交
            return flag;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
        
        
    }
    
    public static void main(String[] args) {
        Teacher t = getTeacherBySn("144520666");
        t.setTeacherRoleValue(127);
        updateTeacherById(t);
    }
    
    public static void updateStudentCourse(Integer studentId, Integer termCourseId, boolean state) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            
            StudentSelectCourse  ssc= (StudentSelectCourse) session.createQuery("FROM StudentSelectCourse s WHERE s.termCourse.id = :courseId AND s.student.studentId = :stuId")
                    .setInteger("courseId", termCourseId)
                    .setInteger("stuId", studentId)
                    .uniqueResult();
            
            if(state){
                session.delete(ssc);
            }else{
                ssc.setState(1);
                session.update(ssc);
            }      
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    

    
    
    
    public static Teacher updateTeacherById(Teacher teacher) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            session.update(teacher);
            transaction.commit();//提交
            return teacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    public static PageBean<StuSelectResult> getStuSelectByTermCourseId(Integer termCourseId,Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List<StudentSelectCourse> list = session.createQuery("FROM StudentSelectCourse s WHERE s.termCourse.id = :id")
                    .setInteger("id", termCourseId)
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            Long x = (Long) session.createQuery("SELECT COUNT(*) FROM StudentSelectCourse s WHERE s.termCourse.id = :id")
                    .setInteger("id", termCourseId)
                    .uniqueResult();
            
            List<StuSelectResult> fList = new LinkedList();
            
            for (StudentSelectCourse list1 : list) {
                StuSelectResult ssr = new StuSelectResult();
                ssr.setState(list1.getState());
                ssr.setStuid(list1.getStudent().getStudentId());
                fList.add(ssr);
    
            }
            PageBean<StuSelectResult> pageBean = new PageBean<>();
            pageBean.setPc(pc);
            pageBean.setPs(ps);
            pageBean.setTr(x.intValue());
            pageBean.setBeanList(fList);
            
            transaction.commit();//提交
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    
    
    
    
    
    
    /**
     *将一个临时教师移动到正式教师
     * @param tempTeacher 临时教师对象
     */
    public static void addTeacherFromtempTeacher(TempTeacher tempTeacher) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Teacher teacher = new Teacher();
            teacher.copy(tempTeacher);
            session.save(teacher);
            session.delete(tempTeacher);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     *保存一个教师对象
     * @param teacher 教师对象
     */
    public static void saveTeacher(Teacher teacher) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List list = session.createQuery(//学号重复检查
                    "FROM Teacher s WHERE s.teacherSn = :sn")
                    .setString("sn", teacher.getTeacherSn())
                    .list();
            
            if (!list.isEmpty()) {//重复判断  重复则抛异常
                throw new RuntimeException("工号重复！ 重复工号为："+ teacher.getTeacherSn());
            }
            
            session.save(teacher);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    /**
     *根据教师id删除教师
     * @param id 教师id
     */
    public static boolean deleteTeacherById(Integer id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List list = session.createQuery("FROM TermCourse t, Teacher  a WHERE a.teacherId = :id AND t.teacher.teacherId = a.teacherId")
                    .setInteger("id", id)
                    .list();
            
            list.addAll(session.createQuery("FROM Teacher t , CourseMaster c where t.teacherId = :id AND c.teacher.teacherId = :id")
                    .setInteger("id", id)
                    .list());
            if(list.isEmpty()){
                session.delete(session.get(Teacher.class, id));
                transaction.commit();
                return true;
            }else{
                transaction.commit();
                return false;
            }

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     *
     * @param term 学期
     * @param teacherSn  教师工号
     * @return
     */
    public static List<TeacherCourseResult> getTeacherCourseByTermSn(Integer term, String teacherSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            List<TermCourse> tempList =  session.createQuery("FROM TermCourse t WHERE  t.term = :term AND t.teacher.teacherSn = :sn")
                    .setString("sn", teacherSn)
                    .setInteger("term", term)
                    .list();
            List<TeacherCourseResult> list = new LinkedList();
            TeacherCourseResult tr;
            for (TermCourse termCourse : tempList) {
                Integer flag = 0;
                for (TeacherCourseResult list1 : list) {//判断课程是否存在
                    if(list1.getText().equals(termCourse.getCourse().getCourseName())){
                        tr = list1;
                        tr.getChildren().add(new NewClass(termCourse.getClasses().getClassId(),termCourse.getClasses().getClassName())); 
                        flag = 1;
                        break;
                    }
                }
                if (flag == 0) {
                    tr = new TeacherCourseResult();
                    tr.setId(termCourse.getCourse().getCourseId());
                    tr.setText(termCourse.getCourse().getCourseName());
                    tr.setState("open");
                    tr.getChildren().add(new NewClass(termCourse.getClasses().getClassId(),termCourse.getClasses().getClassName())); 
                    list.add(tr);
                }
            }
            transaction.commit();
            return list;
        } catch (RuntimeException e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
    

    

    /**
     *根据id将一个临时教师移动到正式教师列表
     * @param id  教师id
     */
    public static void addTeacherFromTempTeacherById(Integer id) {//批准临时表教师的方法
        TempTeacher tempTeacher = TempTeacherDao.getTempTeacherById(id);
        Teacher teacher = new Teacher();
        teacher.copy(tempTeacher);
        TeacherDao.saveTeacher(teacher);
        TempTeacherDao.deleteTempTeacherById(id);
        
    }

    /**
     *获取所有教师
     * @return  全体教师列表
     */
    public static List getAllTeacher() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作

            List lists = session.createQuery("From Teacher").list();

            Teacher Teacher;
            TempTeacherWithoutPwd teacherWithoutPwd;
            Iterator<Teacher> it = lists.iterator();
            List list = new LinkedList();
            while (it.hasNext()) {
                Teacher = it.next();
                teacherWithoutPwd = new TempTeacherWithoutPwd();
                teacherWithoutPwd.copy(Teacher);
                list.add(teacherWithoutPwd);
            }
            transaction.commit();//提交
            return list;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

       public static List getAllacdemicTeacher() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List lists = session.createQuery("From Teacher").list();
            Teacher Teacher;
            TeacherWithoutPwd teacherWithoutPwd;
            Iterator<Teacher> it = lists.iterator();
            List list = new LinkedList();
            while (it.hasNext()) {
                Teacher = it.next();
                teacherWithoutPwd = new TeacherWithoutPwd();
                teacherWithoutPwd.copy(Teacher);
                list.add(teacherWithoutPwd);
            }
            transaction.commit();//提交
            return list;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    /**
     *判断教师是否存在
     * @param teacherSn 教师工号
     * @return 存在则返回true，不存在返回fals
     */
    public static boolean isExistBySn(String teacherSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List list = session.createQuery("FROM Teacher t WHERE t.teacherSn = :sn")
                    .setString("sn", teacherSn)
                    .list();
            transaction.commit();//提交

            return !list.isEmpty();
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    /**
     *根据教师工号获取教师姓名
     * @param teacherSn 教师工号
     * @return 教师姓名
     */
    public static String getTeacherNameBySn(String teacherSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            Teacher teacher = (Teacher) session.createQuery("FROM Teacher t Where t.teacherSn = :sn")
                    .setString("sn", teacherSn)
                    .uniqueResult();
            return teacher.getTeacherName();
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
//    public static void main(String[] args) {
//        List<TeacherCourseResult> list = getTeacherCourseByTermSn(201702, "1445203222");
//        for (TeacherCourseResult list1 : list) {
//            System.out.print(list1.getName()+"   ");
//            List<NewClass> list2 = list1.getChildren();
//            for (NewClass list21 : list2) {
//                System.out.print(list21.getName()+",");;
//            }
//            System.out.println("");
//        }
//    }
    
    /**
     *为学号在指定范围内的教师分页
     * @param min 工号最小值
     * @param max 工号最大值
     * @param pc  当前页
     * @param ps  每页记录最大数
     * @return  返回一个分页bean对象
     */
    public static PageBean<Teacher> findAllTeacherBySn(Integer min, Integer max, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List<Teacher> lists = session.createQuery("FROM Teacher t WHERE t.teacherSn BETWEEN :min  AND  :max")
                    .setInteger("min", min)
                    .setInteger("max", max)
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long x = (Long) session.createQuery("SELECT COUNT(*) FROM Teacher t WHERE t.teacherSn BETWEEN :min  AND  :max")
                    .setInteger("min", min)
                    .setInteger("max", max)
                    .uniqueResult();
            PageBean<Teacher> pageBean = new PageBean<>();
            pageBean.setPc(pc);
            pageBean.setPs(ps);
            pageBean.setTr(x.intValue());
            
            Iterator<Teacher> it = lists.iterator();
            Teacher next;
            Teachers teachers;
            List list = new LinkedList();
            while (it.hasNext()) {
                next = it.next();
                teachers = new Teachers();
                teachers.copy(next);
                list.add(teachers);
            }
            pageBean.setBeanList(list);
            transaction.commit();
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     *根据学院为教师分页
     * @param teacherCollege 教师学院
     * @param pc  当前页
     * @param ps  每页记录最大数
     * @return  返回一个分页bean对象
     */
    public static PageBean<Teacher> findAllTeacherByCollege(String teacherCollege, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List lists = session.createQuery("FROM Teacher t WHERE t.teacherCollege = :college")
                    .setString("college", teacherCollege)
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            Long x = (Long) session.createQuery("SELECT COUNT(*) FROM Teacher t WHERE t.teacherCollege = :college")
                    .setString("college", teacherCollege)
                    .uniqueResult();
            PageBean<Teacher> pageBean = new PageBean<>();
            pageBean.setPc(pc);
            pageBean.setPs(ps);
            pageBean.setTr(x.intValue());
            Iterator <Teacher>it = lists.iterator();
            Teacher next;
            Teachers teachers;
            List list = new LinkedList();
            while(it.hasNext()){
                next = it.next();
                teachers = new Teachers();
                teachers.copy(next);
                list.add(teachers);
            }
            pageBean.setBeanList(list);
            transaction.commit();
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     *根据教师id获取教师
     * @param teacherSn
     * @return 返回指定教师对象
     */
    public static Teacher getTeacherBySn(String teacherSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            Teacher teacher = (Teacher) session.createQuery("FROM Teacher t WHERE t.teacherSn = :sn")
                    .setString("sn", teacherSn)
                    .uniqueResult();
            
            transaction.commit();
            return teacher;
        } catch (RuntimeException e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
    
    
    


}
