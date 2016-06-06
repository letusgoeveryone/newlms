/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;


import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author Administrator
 */
public class TeacherCourseResult  {
  //  private Set<String> className = new HashSet();
    private Integer id;  //课程编号 
    private String state;
    private String text; //课程名称  
    private String attributes;
    private List<NewClass> children = new LinkedList(); //子节点

    public String getAttributes() {
        return attributes;
    }

    public void setAttributes(String attributes) {
        this.attributes = attributes;
    }

    
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
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

    public void setId(Integer id) {
        this.id = id;
    }



    public List<NewClass> getChildren() {
        return children;
    }

    public void setChildren(List<NewClass> children) {
        this.children = children;
    }
   
    /**
     * @return the id
     */

 
}
