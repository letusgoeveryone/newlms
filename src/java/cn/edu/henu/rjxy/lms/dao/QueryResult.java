/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import java.util.List;

/**
 *
 * @author 王鸿运
 * @param <E> 
 * 
 */

//由于查询过程中有多个可能性，所以创建此类来封装这些信息
public class QueryResult<E> {//泛型类 使用时将E替换为相应的类型，如 QueryResult<Student> queryResult = new QueryResult<Student>();
    private int number;//查询结果条数
    private E e;//查询的对象,若结果条数为一，则该对象则存在值，否则为空
    private List<E> list;//查询结果的列表
    
    public int getNumber(){
        return this.number;
    }

    /**
     * @param number the number to set
     */
    public void setNumber(int number) {
        this.number = number;
    }

    /**
     * @return the e
     */
    public E getE() {
        return e;
    }

    /**
     * @param e the e to set
     */
    public void setE(E e) {
        this.e = e;
    }

    /**
     * @return the list
     */
    public List<E> getList() {
        return list;
    }

    /**
     * @param list the list to set
     */
    public void setList(List<E> list) {
        this.list = list;
    }
}
