/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.DAO;

import cn.edu.henu.rjxy.lms.bean.Position;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author wht
 */
public class PositionDAO {
    
    private static PositionDAO pd = null;
    private List<Position> list =null;

    private PositionDAO() {
    }

    public static PositionDAO getPositionDAO(){
        if(pd==null){
            pd = new PositionDAO();
        }
        return pd;
    }
    
    public List<Position> getList(String databaseSchema){
        if(list == null){
            list = queryList(databaseSchema);
            list.remove(0);
        }
        return list;
    }
    
    public List<Position> queryList(String databaseSchema){
        EntityManagerFactory factory = Persistence.createEntityManagerFactory(databaseSchema);  //相当于hibernate的sessionFactory
        EntityManager em = factory.createEntityManager();//创建实体管理器
        //em.getTransaction().begin();
        //JPQL为面向对象的查询，所以下面语句中的Position是java中的类，而非数据库中的表名
        Query query = em.createQuery("select o from Position o");//where o.collegeName = :cn");//:cn 也可换成?1等

        //query.setParameter("cn", "计算机学院");//“cn”换成数字1等
        List<Position> list = (List<Position>)query.getResultList();
        em.close();//关闭事务
        factory.close();//关闭实体管理工厂
        
        return list;
    }
}
