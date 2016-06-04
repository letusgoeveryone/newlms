/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
public class NewClass {
    private Integer id;  //班级编号  
    private String text; //班级名称
    
    public NewClass(Integer id, String text) {
        this.id = id;
        this.text = text;
    }


    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
   
    public Integer getId() {
        return id;
    }

   
}
