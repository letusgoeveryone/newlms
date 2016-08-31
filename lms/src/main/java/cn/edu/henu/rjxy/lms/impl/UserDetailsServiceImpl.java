/**
 *
 * @author 刘昱
 */
package cn.edu.henu.rjxy.lms.impl;
import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.server.StudentMethod;
import java.util.ArrayList;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public class UserDetailsServiceImpl implements UserDetailsService {
    @Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = null;
        String password = null;
        password=StudentMethod.studentLoginGetPasswordByUserName(username);
        if (password.equals("") ||  password == null) {
            password=TeacherDao.getTeacherBySn(username).getTeacherPwd();
        };
        password=password.toLowerCase();
        //账户是否可用
        boolean enabled = true;
        //账户是否没过期
        boolean accountNonExpired = true;
        //凭证是否没有过期
        boolean credentialsNonExpired = true;
        //账号是否没有被锁定
        boolean accountNonLocked = true;
        //用户所具有的权限信息的集合, 该集合中存放 GrantedAuthorityImpl 类的对象即可
        //GrantedAuthorityImpl 只有 role 这一个属性, 该属性类似于为 ROLE_ADMIN 
        //创建 User 对象, User 类是 UserDetails 的实现类
        user=new User(username, password, enabled, accountNonExpired,credentialsNonExpired, accountNonLocked, getAuthoritiesBySn(username));
        
        
 System.out.println(password+user.toString());
        return user;
    
  }

public static ArrayList<GrantedAuthority> getAuthoritiesBySn(String sn){
    ArrayList<GrantedAuthority> authorities = new ArrayList<>();
    String str[] = {"ROLE_ACDEMIC","ROLE_DEAN","ROLE_TEACHER","ROLE_ADMIN"};
    //                   1              2              4             8          
    //                                                              15
        try {
            Teacher tea=TeacherDao.getTeacherBySn(sn);
            System.out.println("找到老师"+tea.getTeacherName());
            System.out.println("getTeacherPosition"+tea.getTeacherRoleValue());
            char[] ch= Integer.toBinaryString(Integer.valueOf(tea.getTeacherRoleValue())).toCharArray();
            int j=-1;
            for (int i = ch.length-1; i >=0; i--) {
                j++;
                if(String.valueOf(ch[i]).equals("1")){
                authorities.add(new SimpleGrantedAuthority(str[j]));
                }
              }
             
        } catch (Exception e) {
        }
        try {
             Student std=StudentDao.getStudentBySn(sn);
             System.out.println("找到学生"+std.getStudentName());
             authorities.add(new SimpleGrantedAuthority("ROLE_STUDENT"));
             
        } catch (Exception e) {
        }
       System.out.println(authorities.toString());
            return authorities;
}
  

}
