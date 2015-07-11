/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.DAO;

import cn.edu.henu.rjxy.lms.bean.*;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author wht
 */
public class CollegeDAO {

    private static CollegeDAO cd = null;
    private List<College> list = null;
    private boolean fresh = true;

    /**
     * @param dbs 数据库方案
     * @return the list 为学院列表
     */
    public List<College> getList(String dbs) {
        if (isFresh()) {
            //setList(cd.queryList(dbs));
            list = queryList(dbs);
            //list.remove(0);
            System.out.println("get College list");
        }
        return list;
    }

    private List<College> queryList(String databaseSchema) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory(databaseSchema);  //相当于hibernate的sessionFactory
        EntityManager em = factory.createEntityManager();//创建实体管理器
        //em.getTransaction().begin();
        //JPQL为面向对象的查询，所以下面语句中的College是java中的类，而非数据库中的表名
        Query query = em.createQuery("select o from College o");//where o.collegeName = :cn");//:cn 也可换成?1等

        //query.setParameter("cn", "计算机学院");//“cn”换成数字1等
        List<College> li = (List<College>) query.getResultList();
        em.close();//关闭事务
        factory.close();//关闭实体管理工厂

        return li;
    }

    /**
     * @param aList the list to set
     */
    public void setList(List<College> aList) {
        list = aList;
    }

    private CollegeDAO() {
        System.out.println("new College DAO()");
    }
//单例模式

    public static CollegeDAO getCollegeDAO() {
        if (cd == null) {
            cd = new CollegeDAO();
        }
        return cd;
    }

    public void save(String collegeName) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("lms");  //相当于hibernate的sessionFactory
        EntityManager em = factory.createEntityManager();//创建实体管理器
        em.getTransaction().begin();//开始一个事务
        em.persist(new College(collegeName));//public College(String collegeName, Integer collegeSn, Set departs, Set students, Set teachers, Set tempStudents, Set tempTeachers, Set classeses) {
        em.getTransaction().commit();//提交事务
        em.close();//关闭事务
        factory.close();//关闭实体管理工厂

    }

//    public void getCollege() {
//        EntityManagerFactory factory = Persistence.createEntityManagerFactory("lms");  //相当于hibernate的sessionFactory
//        EntityManager em = factory.createEntityManager();//创建实体管理器
//        //em.getTransaction().begin();//开始一个事务
//        // em.persist(new College("计算机学院",null));//public College(String collegeName, Integer collegeSn, Set departs, Set students, Set teachers, Set tempStudents, Set tempTeachers, Set classeses) {
//        College college = em.find(College.class, 1);
//        System.out.print(college.getCollegeName());
//        // em.getTransaction().commit();//提交事务
//        em.close();//关闭事务
//        factory.close();//关闭实体管理工厂
//
//    }
    public void updateCollege(String collegeName) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("lms");  //相当于hibernate的sessionFactory
        EntityManager em = factory.createEntityManager();//创建实体管理器
        em.getTransaction().begin();//开始一个事务
        College college = em.find(College.class, 1);//第二个参数为主键id
        college.setCollegeName(collegeName);
        em.getTransaction().commit();//提交事务
        em.close();//关闭事务
        factory.close();//关闭实体管理工厂

    }

    
    public void delete(int collegeId) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("lms");  //相当于hibernate的sessionFactory
        EntityManager em = factory.createEntityManager();//创建实体管理器
        em.getTransaction().begin();//开始一个事务
        College college = em.find(College.class, collegeId);//第二个参数为主键id
        em.remove(college);
        em.getTransaction().commit();//提交事务
        em.close();//关闭事务
        factory.close();//关闭实体管理工厂
    }

//    public String queryJSON() {
//        EntityManagerFactory factory = Persistence.createEntityManagerFactory("lms");  //相当于hibernate的sessionFactory
//        EntityManager em = factory.createEntityManager();//创建实体管理器
//        //em.getTransaction().begin();
//        //JPQL为面向对象的查询，所以下面语句中的College是java中的类，而非数据库中的表名
//        Query query = em.createQuery("select o from College o");//where o.collegeName = :cn");//:cn 也可换成?1等
//
//        //query.setParameter("cn", "计算机学院");//“cn”换成数字1等
//        List<College> list = (List<College>) query.getResultList();
//        
////        JSONArray jsArr = JSONArray.fromObject(list);
////        int size = list.size();
////        College clg = list.get(size - 1);
////        JSONObject jsonObject = new JSONObject();
////        College it = list.get(0);
////        for(College it: list) {
////            System.out.println(it.getCollegeId()+" name= "+it.getCollegeName());
////            jsonObject.element("college", it);
////        }
////        JSONObject jsonObject = new JSONObject();
////        College it = list.get(0);
////        jsonObject.accumulate("college", it);
////        System.out.println(jsArr.toString());
//
////        System.out.print(clg.getCollegeId() + " name=" + clg.getCollegeName());
////        String[] colleges = new String[clg.getCollegeId() + 1];
////        for (College college : list) {
////            colleges[college.getCollegeId()] = college.getCollegeName();
////            System.out.println(college.getCollegeName() + "id:" + college.getCollegeId());
////            System.out.println(colleges);
////        }
////        for (String college : colleges) {
////            System.out.println(college);
////        }
//        em.close();//关闭事务
//        factory.close();//关闭实体管理工厂
//        return list.toString();
////        return jsonObject.toString();
//    }
//    public void deletequery() {
//        EntityManagerFactory factory = Persistence.createEntityManagerFactory("lms");  //相当于hibernate的sessionFactory
//        EntityManager em = factory.createEntityManager();//创建实体管理器
//        em.getTransaction().begin();//开启事务
//        //JPQL为面向对象的查询，所以下面语句中的College是java中的类，而非数据库中的表名
//        Query query = em.createQuery("delete from College o where o.collegeName =?1");//:cn 也可换成?1等
//
//        query.setParameter(1, "计算机学院");//“cn”换成数字1等
//        query.executeUpdate();
//        em.getTransaction().commit();//提交事务
//        em.close();//关闭事务
//        factory.close();//关闭实体管理工厂
//    }
//
//    public void queryupdate() {
//        EntityManagerFactory factory = Persistence.createEntityManagerFactory("lms");  //相当于hibernate的sessionFactory
//        EntityManager em = factory.createEntityManager();//创建实体管理器
//        em.getTransaction().begin();//开启事务
//        //JPQL为面向对象的查询，所以下面语句中的College是java中的类，而非数据库中的表名
//        Query query = em.createQuery("update College  o set o.collegeName=:name where o.collegeName = :cn");//:cn 也可换成?1等
//
//        query.setParameter("name", "物理学院");
//        query.setParameter("cn", "计算机学院");//“cn”换成数字1等
//        query.executeUpdate();
//        em.getTransaction().commit();//提交事务
//        em.close();//关闭事务
//        factory.close();//关闭实体管理工厂
//    }
    /**
     * @return the fresh
     */
    public boolean isFresh() {
        return fresh;
    }

    /**
     * @param fresh the fresh to set
     */
    public void setFresh(boolean fresh) {
        this.fresh = fresh;
    }

}
