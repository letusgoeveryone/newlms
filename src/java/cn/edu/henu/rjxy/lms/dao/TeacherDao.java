/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;



import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *对正式老师的基本操作
 * @author Administrator
 */
public  class TeacherDao {
    static Session session = HibernateUtil.getSessionFactory().openSession();
    
     //根据用户名查询正式教师对象
    
    /**
     * 根据用户名返回相关信息，并将信息用QueryResult封装并返回<br>
     * @param userName 传入用户名
     * @return 返回一个QueryResult对象
     */
    public static QueryResult getTeacherByUserName(String userName){
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria;
           if(userName.length() == 10){//十位即根据学号查询
            criteria = session.createCriteria(Teacher.class);
            criteria.add(Restrictions.eq("teacherSn", userName));
           }else if(userName.length() == 11){//十一位即根据手机号查询
            criteria = session.createCriteria(Teacher.class);
            criteria.add(Restrictions.eq("teacherTel", userName));
           }else{//其他则根据身份证查询
            criteria = session.createCriteria(Teacher.class);
            criteria.add(Restrictions.eq("teacherIdcard", userName));
           }
            QueryResult<Teacher> queryResult = new QueryResult<Teacher>();
            queryResult.setList((List<Teacher>) criteria.list());//记录结果集合
            queryResult.setNumber(criteria.list().size());//记录条数
            if(queryResult.getNumber() == 1){//若结果唯一，则为结果中的对象赋值
                Iterator<Teacher> iterator = criteria.list().iterator();
                queryResult.setE(iterator.next());
            }
            transaction.commit();//提交
            return queryResult;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    public static void addTeacherFromtempTeacher(TempTeacher tempTeacher){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Teacher teacher = new Teacher();
            teacher.setTeacherSn(tempTeacher.getTeacherSn());
            teacher.setTeacherName(tempTeacher.getTeacherName());
            teacher.setTeacherIdcard(tempTeacher.getTeacherIdcard());
            teacher.setTeacherCollegeId(tempTeacher.getTeacherCollegeId());
            teacher.setTeacherTel(tempTeacher.getTeacherTel());
            teacher.setTeacherQq(tempTeacher.getTeacherQq());
            teacher.setTeacherPwd(tempTeacher.getTeacherPwd());
            teacher.setTeacherSex(tempTeacher.getTeacherSex());
            teacher.setTeacherPositionId(tempTeacher.getTeacherPositionId());
            teacher.setTeacherEnrolling(tempTeacher.getTeacherEnrolling());
            teacher.setTeacherRoleValue(0);
            session.save(teacher);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    public static void saveTeacher(Teacher teacher){
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            session.save(teacher);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
}
