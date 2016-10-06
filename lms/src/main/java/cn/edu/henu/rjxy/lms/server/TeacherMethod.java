package cn.edu.henu.rjxy.lms.server;


import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.Teachers;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 * 该类包含了关于正式老师的相关操作
 *
 * @author Administrator
 */
public class TeacherMethod {

    /**
     *
     * @param userName 用户名，填写学号（10位），手机号（11位），身份证号（其它位数）都可以
     * @param teacherPwd
     *
     * @return 用户名正确，不重复，且与相应的密码吻合则返回true，否则返回false
     */
    public static boolean teacherSignInByUserName(String userName, String teacherPwd) {
        Teacher teacher = TeacherDao.getTeacherBySn(userName);
        if (teacher == null) {//用户是否存在
            return false;
        } else {
            if (!teacher.getTeacherPwd().equals(teacherPwd)) {//密码是否匹配
                return false;
            } else {
                return true;
            }
        }
    }

    /**
     *根据工号将一个临时教师加入到正式教师
     * @param userName
     */
    public void addTeacherFromtempTeacher(String userName) {
        TempTeacher tempTeacher = TempTeacherDao.getTempTeacherBySn(userName);
        Teacher teacher = new Teacher();
        teacher.copy(tempTeacher);
        TeacherDao.saveTeacher(teacher);
    }

    
    /*
      *筛选出教务员
    */
     public List findteaacdemic() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List list = session.createQuery("FROM Teacher").list();
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
     *为正式教师分页
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个分页bean对象
     */
    public PageBean<Teacher> findAll(Integer pc, Integer ps) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List list = session.createQuery("FROM Teacher")
                    .setFirstResult((pc-1) * ps)
                    .setMaxResults(ps)
                    .list();

            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM Teacher"
            ).uniqueResult();
            PageBean<Teacher> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            Iterator<Teacher> it = list.iterator();
            Teacher next;
            Teachers teachers;
            List list1 = new LinkedList();
            while (it.hasNext()) {
                next = it.next();
                teachers = new Teachers();
                teachers.copy(next);
                list1.add(teachers);

            }
            pageBean.setBeanList(list1);//设置当前列表
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
     *获取所有教师
     * @return  全体教师列表
     */
    public List getAllTeacher() {
        return TeacherDao.getAllTeacher();
    }
    

}

