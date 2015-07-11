/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.DAO;

import cn.edu.henu.rjxy.lms.bean.Classes;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author wht
 */
public class ClassesDAO {

    private static ClassesDAO dd = null;
    private List<Classes> list = null;
    private boolean fresh = true;

    /**
     * @param dbs 数据库方案在persistence.xml中定义的名字
     * @return the list
     */
    public List<Classes> getList(String dbs) {
        if (list == null) {
            setList(dd.queryList(dbs));
            System.out.println("get Classes list");
        }
        return list;
    }

    /**
     * @param aList the list to set
     */
    public void setList(List<Classes> aList) {
        list = aList;
    }
    
    private ClassesDAO() {

        System.out.println("new Classes DAO()");
    }

    public static ClassesDAO getClassesDAO() {
        if (dd == null) {
            dd = new ClassesDAO();
        }
        return dd;
    }

    private List<Classes> queryList(String databaseSchema) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory(databaseSchema);  //相当于hibernate的sessionFactory
        EntityManager em = factory.createEntityManager();//创建实体管理器
        //em.getTransaction().begin();
        //JPQL为面向对象的查询，所以下面语句中的Classes是java中的类，而非数据库中的表名
        Query query = em.createQuery("select o from Classes o");//where o.collegeName = :cn");//:cn 也可换成?1等

        //query.setParameter("cn", "计算机学院");//“cn”换成数字1等
        List<Classes> li = (List<Classes>) query.getResultList();
//        if(li.get(0).getClassId()==0){
//            li.remove(0);
//        }
        em.close();//关闭事务
        factory.close();//关闭实体管理工厂

        return li;
    }

    public String queryJSON(Integer collegeId, Integer gradeId, String databaseSchema) {

        List<Classes> li = this.getList(databaseSchema);
//        list.remove(0);
        String json = "{\"classes\":[";
        int i = 0;
        for (Classes it : li) {
            if (it.getDepart().getDepartId() == collegeId && it.getGrade().getId() == gradeId) {
                if (i != 0) {
                    json = json + ",";
                }
                i++;
                json = json + "{" + "\"id\":\"" + it.getClassId() + "\",\"name\":\"" + it.getClassName() + "\"}";

            }
        }
        json = json + "]}";
        return json;
    }

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
