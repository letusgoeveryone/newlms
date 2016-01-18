package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.Teachers;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TermCourse;
import cn.edu.henu.rjxy.lms.model.TermOpenCourse;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *该类包含了关于正式老师的相关操作
 * @author Administrator
 */
public class TeacherMethod {
    
    /**
     * 
     * @param userName  用户名，填写学号（10位），手机号（11位），身份证号（其它位数）都可以
     * @param stuPwd    密码
     * @return   用户名正确，不重复，且与相应的密码吻合则返回true，否则返回false
     */
    public static boolean teacherSignInByUserName(String userName, String stuPwd){
        QueryResult queryResult = TeacherDao.getTeacherByUserName(userName);
        if(queryResult.getNumber() == 1){
            cn.edu.henu.rjxy.lms.model.Teacher teacher = (cn.edu.henu.rjxy.lms.model.Teacher)queryResult.getE();
            if(teacher.getTeacherPwd().compareTo(stuPwd)==0){
               return true;
           }
       }
       return false;
    }
    //当且仅当学号和身份证查询到同一对象时，才将该对象添加到正式表
    public void addTeacherFromtempTeacher(String userName){
        TempTeacher tempTeacher = (TempTeacher)TempTeacherDao.getTempTeacherByUserName(userName).getE();
            Teacher teacher = new Teacher();
            teacher.copy(tempTeacher);
            TeacherDao.saveTeacher(teacher);
            
    }
    //正式教师信息分页
    public PageBean<Teacher>  findAll(int pc, int ps){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            List list = session.createSQLQuery("select * from teacher limit "+(pc-1)+", "+ps)
                    .addEntity(Teacher.class)
                    .list();
            
            Long count = (Long)  session.createQuery(
                    "SELECT COUNT(*) FROM Teacher"
            ).uniqueResult();
            PageBean<Teacher> pageBean = new PageBean<Teacher>();
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
        }finally{
            session.close();
        }
    }
    
    public static void main(String[] args) {
        List list = new TeacherMethod().findAll(1, 10).getBeanList();
        System.out.print(list.size());
    }
    
    public  List getAllTeacher(){
        return TeacherDao.getAllTeacher();
    }
    
//    public static void main(String[] args) {
//        System.out.print(new TeacherMethod().findAll(1, 10).getTr());
//    }

}

