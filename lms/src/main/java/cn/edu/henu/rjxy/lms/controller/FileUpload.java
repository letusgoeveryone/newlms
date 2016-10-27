 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;


import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseDao;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TermCourse;
import cn.edu.henu.rjxy.lms.server.CurrentInfo;
import cn.edu.henu.rjxy.lms.server.DocConverter;
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */


@Controller
public class FileUpload extends HttpServlet {
    //大纲附件提交
    @RequestMapping(value = "teacher/dgupload100.do", method = RequestMethod.POST)
	@ResponseBody
    public String uploaddg(HttpServletRequest request,HttpServletResponse response) throws IOException {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		// 上传到服务端的路径
		String[] term = multipartRequest.getParameterValues("term");
		String[] coursename = multipartRequest.getParameterValues("coursename");
                //前台自定义参数结束
                String sn=getCurrentUsername();
                Teacher tec = TeacherDao.getTeacherBySn(sn);
                String collage = tec.getTeacherCollege();
                String ff = getFileFolder(request)+term[0] +"/"+collage+"/"+coursename[0]+"/"+"课程大纲"+"/";
                String ctxPath= ff;
                if(haveFile(ff)>0){
                   System.out.println(haveFile(ff));
                   return "other file upload fail";
                }
                System.out.println(ctxPath);
		String originalFileName = null;
                String newFileName = null;
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			// 上传文件名
			MultipartFile mf = entity.getValue();
			originalFileName = mf.getOriginalFilename();//fileName
                        newFileName = originalFileName;   
			String uploadFolder3 = ctxPath + "/";
			File otherFile = new File(uploadFolder3);
			if (!otherFile.exists()) {
			     otherFile.mkdirs();
			}
			String uploadFileLocation = uploadFolder3 + newFileName;
			if (this.htmlUpload(mf.getInputStream(), uploadFileLocation)){
                                        zhuanhuanswf(ff,newFileName,request);//转换swf
					return "other file upload success";
			} else {
					System.out.println(" ------- other upload fail");
					return "other file upload fail";
			}
		}
		return null;
	}
        //作业上传
	@RequestMapping(value = "teacher/zyupload100.do", method = RequestMethod.POST)
	@ResponseBody
	public String uploadzy(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
                //前台自定义参数
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获取前台传值
                String[] term = multipartRequest.getParameterValues("term");
		String[] coursename = multipartRequest.getParameterValues("coursename");
                String []workid =multipartRequest.getParameterValues("workid");
                String tec_name =TeacherDao.getTeacherBySn(getCurrentUsername()).getTeacherName();
                String sn = getCurrentUsername();
                String collage = TeacherDao.getTeacherBySn(getCurrentUsername()).getTeacherCollege();
                 //                              学期　     工号　   姓名　          课程名
                String ff = getFileFolder(request)+"homework/"+term[0] +"/"+collage+"/"+sn+"/"+tec_name+"/"+coursename[0]+"/"+workid[0]+"/"+1+"/";
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		// 上传到服务端的路径
                if(haveFile(ff)>0){
                   System.out.println(haveFile(ff));
                   return "other file upload fail";
                }
                String ctxPath= ff;
                System.out.println(ctxPath);
		String originalFileName = null;
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			// 上传文件名
			MultipartFile mf = entity.getValue();
			originalFileName = mf.getOriginalFilename();//fileName
			String newFileName;
                        newFileName = originalFileName;   
			String uploadFolder3 = ctxPath + "/";
			File otherFile = new File(uploadFolder3);
			if (!otherFile.exists()) {
					otherFile.mkdirs();
			}
			String uploadFileLocation = uploadFolder3 + newFileName;
			if (this.htmlUpload(mf.getInputStream(), uploadFileLocation)) {
					System.out.println(" 作业上传  success");
					return "other file upload success";
			} else {
					System.out.println(" 作业上传 fail");
					return "other file upload fail";
			}
		}
		return null;
	}
	//课程内容upload
	@RequestMapping(value = "teacher/upload100.do", method = RequestMethod.POST)
	@ResponseBody
	public String upload(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
                //前台自定义参数
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获取前台传值
		String[] term = multipartRequest.getParameterValues("term");
		String[] coursename = multipartRequest.getParameterValues("coursename");
                String[] node1 = multipartRequest.getParameterValues("a1");
                String[] node2 = multipartRequest.getParameterValues("a2");
                String[] node3 = multipartRequest.getParameterValues("a3");
                //前台自定义参数结束
                String sn=getCurrentUsername();
                Teacher tec = TeacherDao.getTeacherBySn(sn);
                String tec_sn= tec.getTeacherSn();
                String tec_name = tec.getTeacherName();
                String collage = tec.getTeacherCollege();
                String dir="";
                if(!node2[0].equals("null")&&!node3[0].equals("null")){
                   dir = node1[0]+"/"+node2[0]+"/"+node3[0]+"/";
                }else if(!node2[0].equals("null")&&node3[0].equals("null")){
                   dir =node1[0]+"/"+node2[0]+"/";
                }else if(node2[0].equals("null")&&node3[0].equals("null")){
                   dir = node1[0]+"/";
                }
                System.out.println("dir="+dir);
                String ff = getFileFolder(request)+term[0] +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+coursename[0]+"/"+"课程内容"+"/"+dir+"/";
                String temp = null;//文件格式，视频表示0，word表示1
//                if(haveFile(ff)>0){return "other file upload fail";}
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		// 上传到服务端的路径
                String ctxPath= ff;
                System.out.println(ctxPath);
		String originalFileName = null;
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			// 上传文件名
			MultipartFile mf = entity.getValue();
			originalFileName = mf.getOriginalFilename();//fileName
			String newFileName;
                        newFileName = originalFileName;   
                        System.out.println("上传文件名后缀:"+newFileName);
                        if(newFileName.endsWith(".docx")||newFileName.endsWith(".doc")||newFileName.endsWith(".xls")||newFileName.endsWith(".xlsx")||newFileName.endsWith(".ppt")||newFileName.endsWith(".pdf")||newFileName.endsWith(".pptx")){
                            System.out.println("上传的是word");
                            temp="1";
                        }else{
                            System.out.println("上传的是视频");
                            temp="0";
                        }
			String uploadFolder3 = ctxPath + "/";
			File otherFile = new File(uploadFolder3);
			if (!otherFile.exists()) {
					otherFile.mkdirs();
			}
			String uploadFileLocation = uploadFolder3 + newFileName;
			if (this.htmlUpload(mf.getInputStream(), uploadFileLocation)){
                                        if(temp.equals("0")){
                                           System.out.println("上传的是视频");
                                        }else{
                                            System.out.println("上传的是word进行文件转换");
                                            zhuanhuanswf(ff,newFileName,request);//转换swf
                                        }
					return "other file upload success";
			} else {
					System.out.println(" ------- other upload fail");
					return "other file upload fail";
			}
		}
		return null;
	}
        
        
        
        
         //学生作业上传
	@RequestMapping(value = "student/zyupload100.do", method = RequestMethod.POST)
	@ResponseBody
	public String stuuploadzy(HttpServletRequest request,HttpServletResponse response) throws Exception {
                //前台自定义参数
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获取前台传值
                String[] scid = multipartRequest.getParameterValues("scid");
		String homeworkid = request.getParameter("homeworkid");
                String term =TermCourseDao.getxueqiBySCId(scid[0]).toString();
                Teacher tec=TeacherDao.getTeacherById(TermCourseDao.getTecsnByCourseId(scid[0]));
                String tec_sn= tec.getTeacherSn();
                String tec_name = tec.getTeacherName();
                String collage = tec.getTeacherCollege();
                String courseName =TermCourseDao.getCourseNameByCourseId(scid[0]);
                String stusn=getCurrentUsername();
                String ff = getFileFolder(request)+"uploadhomework/"+term +"/"+collage+"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/"+TermCourseDao.getclassNameByCourseId(scid[0])+"/"+stusn+"/";
                String ff2 = getFileFolder(request)+"homework/"+term+"/"+collage +"/"+tec_sn+"/"+tec_name+"/"+courseName+"/"+homeworkid+"/";
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
                DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                
      Date d1 = new Date();
      Date d2 = df.parse(readline(ff2+"/Workall.txt")[1]);
      if (d1.getTime() < d2.getTime()) {//判断作业没有过期
    
          // 上传到服务端的路径
                String ctxPath= ff;
                System.out.println(ctxPath);
                if(haveFile(ff)>5){   System.out.println("student upload fail");   ;return "other file upload fail";}
		String originalFileName = null;
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			// 上传文件名
			MultipartFile mf = entity.getValue();
			originalFileName = mf.getOriginalFilename();//fileName
			String newFileName;
                        newFileName = originalFileName;   
			String uploadFolder3 = ctxPath + "/";
			File otherFile = new File(uploadFolder3);
			if (!otherFile.exists()) {
					otherFile.mkdirs();
			}
                        if(!( newFileName.equals("textWork.html")|| newFileName.equals("submitTime.txt")) )  {
                            String uploadFileLocation = uploadFolder3 + newFileName;
                            
                            if (this.htmlUpload(mf.getInputStream(), uploadFileLocation)) {
                                            System.out.println(" 作业上传  success");
                                            OutputStreamWriter pw = null;
                                            pw = new OutputStreamWriter(new FileOutputStream(new File(ff+"/submitTime.txt")),"GBK");
                                            pw.write(df.format(new Date()));
                                            pw.close();
                                            
                                            
                                            return "other file upload success";
                            } else {
                                            System.out.println(" 作业上传 fail");
                                            return "other file upload fail";
                            }
                        }
		}
          
          
      
         
      }else{
       return "other file upload fail";
      }

		return null;
	}
	/**
	* @Title: htmlUpload
	* @param @param inputStream	传进一个流
	* @param @param uploadFile		服务端输出的路径和文件名
	* @return boolean    返回类型
	* @throws
	*/
	private boolean htmlUpload(InputStream inputStream, String uploadFile) {
		try {
			byte[] buff = new byte[4096]; // 缓冲区
			FileOutputStream output = new FileOutputStream(uploadFile); // 输出流
			int bytecount = 1;
			while ((bytecount = inputStream.read(buff, 0, 4096)) != -1) { // 当input.read()方法，不能读取到字节流的时候，返回-1
				output.write(buff, 0, bytecount); // 写入字节到文件
			}
			output.flush();
			output.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
        
        //判断目录下是否有文件或目录
    public int haveFile(String path){
     int length = 0;
     File f =new File(path);
     if(f.exists()&&f.isDirectory()){
         String[] files = f.list();
         if(files.length==0){
          System.out.println("空");
          return 0;
         }else{
          length = files.length; 
         }
      }
       return length;
    }
        
        public void zhuanhuanswf(String ff,String newFileName,HttpServletRequest request){
           File f =new File(ff);        
           DocConverter dc=new DocConverter(f+"/"+newFileName);
           boolean res=dc.conver();
           String swftmp=(ff+"/"+newFileName).replace(getFileFolder(request), "");
           swftmp=swftmp.substring(0,swftmp.lastIndexOf("."))+".swf";
           if (res){
            System.out.println("转换为flash成功。网页引用地址:http://localhost:8080/lms/getswf?uri="+swftmp);
           }else{System.out.println("转换为flash失败");}
        }
   
         public String getCurrentUsername() {
              return SecurityContextHolder.getContext().getAuthentication().getName();
         }
  
       public String getFileFolder(HttpServletRequest request) {
        return CurrentInfo.getFileFolder();
    }  
       
         //判断目录是否存在，不存在则创建
    public boolean file(String path){
      File f = new File(path);
      if(!f.exists()&&!f.isDirectory()){
          f.mkdirs();
          return true;
      }
        return true;   
    }
    
     //java一行一行读取txt文件 
    public String[] readline(String path) throws FileNotFoundException, IOException{
        String []a = new String [3];
        File file = new File(path);//Text文件
        BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
        String s = null;
        int i = 0;
        while((s = br.readLine())!=null){//使用readLine方法，一次读一行 
            a[i] = s;
            i++;  
        }
        br.close();
        return a;
     }
}