/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

/**
 *对college的相关操作<br>
 * @author 王鸿运
 * 
 */
public class CollegeDao {
    
    /**
    *根据传入的学院名称返回对应的学院代号<br>
     * @param collegeName 学院名称
     * @return 若输入无误，则返回1~34，否则返回-1。
    */
     public static int getIdByCollegeName(String collegeName){
        if(collegeName.compareTo("文学院")==0){
            return 1;
        }else if(collegeName.compareTo("历史文化学院")==0){
            return 2;
        }else if(collegeName.compareTo("教育科学学院")==0){
            return 3;
        }else if(collegeName.compareTo("哲学与公共管理学院")==0){
            return 4;
        }else if(collegeName.compareTo("法学院")==0){
            return 5;
        }else if(collegeName.compareTo("新闻与传播学院")==0){
            return 6;
        }else if(collegeName.compareTo("外语学院")==0){
            return 7;
        }else if(collegeName.compareTo("经济学院")==0){
            return 8;
        }else if(collegeName.compareTo("商学院")==0){
            return 9;
        }else if(collegeName.compareTo("数学与统计学院")==0){
            return 10;
        }else if(collegeName.compareTo("物理与电子学院")==0){
            return 11;
        }else if(collegeName.compareTo("计算机与信息工程学院")==0){
            return 12;
        }else if(collegeName.compareTo("环境与规划学院")==0){
            return 13;
        }else if(collegeName.compareTo("生命科学学院")==0){
            return 14;
        }else if(collegeName.compareTo("化学化工学院")==0){
            return 15;
        }else if(collegeName.compareTo("土木建筑学院")==0){
            return 16;
        }else if(collegeName.compareTo("艺术学院")==0){
            return 17;
        }else if(collegeName.compareTo("体育学院")==0){
            return 18;
        }else if(collegeName.compareTo("医学院")==0){
            return 19;
        }else if(collegeName.compareTo("药学院")==0){
            return 20;
        }else if(collegeName.compareTo("护理学院")==0){
            return 21;
        }else if(collegeName.compareTo("淮河临床学院")==0){
            return 22;
        }else if(collegeName.compareTo("东京临床学院")==0){
            return 23;
        }else if(collegeName.compareTo("国际教育学院")==0){
            return 24;
        }else if(collegeName.compareTo("软件学院")==0){
            return 25;
        }else if(collegeName.compareTo("民生学院")==0){
            return 26;
        }else if(collegeName.compareTo("国际汉学院")==0){
            return 27;
        }else if(collegeName.compareTo("欧亚国际学院")==0){
            return 28;
        }else if(collegeName.compareTo("人民武装学院")==0){
            return 29;
        }else if(collegeName.compareTo("远程与继续教育学院")==0){
            return 30;
        }else if(collegeName.compareTo("马克思主义学院")==0){
            return 31;
        }else if(collegeName.compareTo("大学外语教学部")==0){
            return 32;
        }else if(collegeName.compareTo("公共体育部")==0){
            return 33;
        }else if(collegeName.compareTo("军事理论教研部")==0){
            return 34;
        }else{
            return -1;
        }

    }
}
