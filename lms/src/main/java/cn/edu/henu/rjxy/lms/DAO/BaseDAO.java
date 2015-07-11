/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.DAO;

import java.util.List;
import org.springframework.data.repository.Repository;

/**
 *
 * @author wht
 */
public interface BaseDAO<T,E> extends Repository{

    public E save(T t);
}
