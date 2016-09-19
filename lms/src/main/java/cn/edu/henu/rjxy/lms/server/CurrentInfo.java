/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;
import  cn.edu.henu.rjxy.lms.dao.KeyValueDao;
import java.util.List;
/**
 *
 * @author 刘昱
 */
public class CurrentInfo {
    public static List<String> getAllTerm() {
        List<String> list =null;
        String AllTerm=KeyValueDao.get("AllTerm");
        if (AllTerm.equals("")) {
             String str[] = {"201601","201602","201603","201701","201702","201703","201801","201802","201803",};
            list = java.util.Arrays.asList(str);
        } else {
           list = java.util.Arrays.asList(AllTerm.split(","));
        }
        return list;
    }
        public static List<String> getAllGrade() {
        List<String> list =null;
        String AllGrade=KeyValueDao.get("AllGrade");
        if (AllGrade.equals("")) {
             String str[] = {"2011","2013","2014","2015","2016","2017",};
            list = java.util.Arrays.asList(str);
        } else {
           list = java.util.Arrays.asList(AllGrade.split(","));
        }
        return list;
    }
    public static int getCurrentTerm() {
        String CurrentTerm=KeyValueDao.get("CurrentTerm");
        if (CurrentTerm.equals("")) {
            return 201602;
        } else {
            return Integer.parseInt(CurrentTerm);
        }
    }
    public static List<String> getAllCollege() {
        List<String> list =null;
        String AllCollege=KeyValueDao.get("AllCollege");
        if (AllCollege.equals("")) {
             String str[] = {"软件学院","文学院","历史文化学院","教育科学学院","哲学与公共管理学院","法学院","新闻与传播学院","外语学院","经济学院","商学院","数学与统计学院",
       "物理与电子学院","计算机与信息工程学院","环境与规划学院","生命科学学院","化学化工学院","土木建筑学院","艺术学院","体育学院","医学院","药学院","护理学院","淮河临床学院",
       "东京临床学院","国际教育学院","民生学院","国际汉学院","欧亚国际学院","人民武装学院","远程与继续教育学院","马克思主义学院","大学外语教学部","公共体育部","军事理论教研部",
       "迈阿密学院"};
           list = java.util.Arrays.asList(str);
        } else {
           list = java.util.Arrays.asList(AllCollege.split(","));
        }
        return list;
    }
    public static void setAllCollege(String AllCollege) {
       
    }   
    public static void setAllTerm(String AllTerm) {
       
    }      
    public static void setAllGrade(String AllGrade) {
       
    }
    public static void setCurrentTerm(String CurrentTerm) {
       
    } 
    public static String getFileFolder() {
//        Tomcat配置虚拟路径，使上传文件与服务器分离http://blog.csdn.net/xiaoyu19910321/article/details/51363679  
        String path = CurrentInfo.class.getClassLoader().getResource("/").getPath();
        System.out.println(path);
        path=path.replace("lms/target/lms-1.0/WEB-INF/classes/", "lms/target/lms-1.0/file/");
        System.out.println(path);
        return path;
//        return null;
    }
    public static void main(String[] args) {
        
    }
    
}
