/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.hibernateutil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;



/**
 * Hibernate Utility class with a convenient method to get Session Factory
 * object.
 *
 * @author Administrator
 */
public class HibernateUtil {

    private static final SessionFactory sessionFactory;
    
    static {
         Configuration configuration = new Configuration().configure();
         StandardServiceRegistry serviceRegistry =  new StandardServiceRegistryBuilder()
                .applySettings(configuration.getProperties())
                .build();
         //生成session工厂,全局只需要一个就可以了
         sessionFactory = configuration.buildSessionFactory((org.hibernate.service.ServiceRegistry) serviceRegistry);
         
    }

    public static SessionFactory getSessionFactory(){
        return sessionFactory;
    }
    
    //从全局惟一的工厂中打开一个session
    public static Session openSessionFactory(){
        return sessionFactory.openSession();
    }
}