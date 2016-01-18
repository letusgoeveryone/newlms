/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;
import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class StudentMethod {
    
    /**
     * 学生登录
     * @param userName 用户名，填写学号（10位），手机号（11位），身份证号（其它位数）都可以
     * @param stuPwd   密码
     * @return  用户名正确，不重复，且与相应的密码吻合则返回true，否则返回false
     */
    //根据学号，密码登录认证
    public static boolean studentSignInByUserName(String userName, String stuPwd){
       QueryResult queryResult = StudentDao.getStudentByUserName(userName);
       if(queryResult.getNumber() == 1){//结果惟一
           cn.edu.henu.rjxy.lms.model.Student student = (cn.edu.henu.rjxy.lms.model.Student)queryResult.getE();
           if(student.getStudentPwd().compareTo(stuPwd)==0){//密码吻合
               return true;
                }
       }
       return false;
    }
    //正式学生的查询
    public PageBean<Student>  findAll(int pc, int ps){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List list = session.createQuery("FROM Student")
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long count = (Long)  session.createQuery(
                    "SELECT COUNT(*) FROM Student"
            ).uniqueResult();
            PageBean<Student> pageBean = new PageBean<Student>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            pageBean.setBeanList(list);//设置当前列表
            
            transaction.commit();//提交
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
      //临时学生转移到正式表
        public static void addStudentFromtempStudent(String userName){

            TempStudent tempStudent=(TempStudent) TempStudentDao.getTempStudentByUserName(userName).getE();
            
                Student student = new Student();
                student.copy(tempStudent);
                StudentDao.saveStudent(student);
                
        }
        
        public  List getAllStudent() {
            return StudentDao.getAllStudent();
        }
        
       public  void addStudentFromtempStudent(int id){
            
        Session    session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            StudentDao.addstudentFromtempStudent((TempStudent) session.get(TempStudent.class, id));
           

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }    
        }
    
}
