package cn.edu.henu.rjxy.lms.server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.CookieHandler;
import java.net.CookieManager;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;

/**
 *
 * @author 刘昱
 * 2016.09.18
 */
public class KingoApi {

	CookieManager manager = new CookieManager();
	private String ticket =null;
	private String other = null;
	private String usernName = null;
	private String password = null;
	public String step1() {
		String url="http://ids.henu.edu.cn/authserver/login";
		String result = "";
		CookieHandler.setDefault(manager);
		BufferedReader in = null;
		try {
			String urlNameString = url;
			URL realUrl = new URL(urlNameString);
			URLConnection connection = realUrl.openConnection();
			connection.setRequestProperty("accept", "*/*");
			connection.setRequestProperty("connection", "Keep-Alive");
			connection.setRequestProperty("user-agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0");
			connection.connect();
			in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送GET请求出现异常！" + e);
			e.printStackTrace();
		}
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		ticket=stringSub(result, "name=\"lt\" value=\"", "\"");
		//System.out.println(ticket);
		other="execution="+stringSub(result, "name=\"execution\" value=\"", "\"")+"&";
		other+="_eventId="+stringSub(result, "name=\"_eventId\" value=\"", "\"")+"&";
		other+="rmShown="+stringSub(result, "name=\"rmShown\" value=\"", "\"");
		//System.out.println(other);
		return result;
	}
	
	public String step2() {
		String url = "http://ids.henu.edu.cn/authserver/login";
		String param = "username="+usernName+"&password="+password+"&lt="+ticket+"&"+other;
		//System.out.println(param);
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			URLConnection conn = realUrl.openConnection();
			conn.setRequestProperty("accept", "image/png, image/svg+xml, image/jxr, image/*;q=0.8, */*;q=0.5");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("Pragma", "no-cache");
			conn.setRequestProperty("Accept-Language", "zh-CN");
			conn.setRequestProperty("Referer", "http://ids.henu.edu.cn/authserver/login");
			conn.setRequestProperty("user-agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			out = new PrintWriter(conn.getOutputStream());
			out.print(param);
			out.flush();
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
		}
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}
	public String step3(String url) {
		String result = "";
		BufferedReader in = null;
		try {
			String urlNameString = url;
			URL realUrl = new URL(urlNameString);
			URLConnection connection = realUrl.openConnection();
			connection.setRequestProperty("accept", "*/*");
			connection.setRequestProperty("connection", "Keep-Alive");
			connection.setRequestProperty("user-agent","Mozilla/5.0 (Windows NT 10.0; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0");
			connection.connect();
			in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送GET请求出现异常！" + e);
			e.printStackTrace();
		}
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
	public String step4() {
		String url = "http://xk.henu.edu.cn:8093/STU_BaseInfoAction.do";
		String param = "hidOption=InitData&menucode_current=JW13020101";
		System.out.println(param);
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			URLConnection conn = realUrl.openConnection();
			conn.setRequestProperty("accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
			conn.setRequestProperty("connection", "keep-alive");
			conn.setRequestProperty("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
			conn.setRequestProperty("Referer", "http://xk.henu.edu.cn:8093/student/stu.xsxj.xjda.jbxx.html?menucode=JW13020101");
			conn.setRequestProperty("user-agent","Mozilla/5.0 (Windows NT 10.0; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0");
			conn.setDoOutput(true);
			conn.setDoInput(true); 
			out = new PrintWriter(conn.getOutputStream());
			out.print(param);
			out.flush();
			in = new BufferedReader(new InputStreamReader(conn.getInputStream(),"GBK"));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
		}
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}
	public String stringSub(String completeString, String StartString, String EndString) {
		int StartIndex, EndIndex;
		StartIndex = completeString.indexOf(StartString);
		EndIndex = completeString.indexOf(EndString, StartIndex+StartString.length());
		return completeString.substring(StartIndex + StartString.length(), EndIndex);
	}
	public void setUserandPw(String usernName, String password) {
		this.usernName = usernName;
		this.password = password;
	}
	public static void main(String[] args) {
//		long startTime = System.currentTimeMillis();//获取当前时间
//		KingoApi k=new KingoApi();
//		k.usernName="1445203058";
//		k.password="010573";
//		String s="";
//		String s1=k.step1();
//		if(s1.equals("")){
//			System.out.println("认证服务器连接失败");
//		}else{
//			String s2=k.step2();
//			if(s2.indexOf("callback_err_login")>-1){
//				System.out.println("密码有误");
//			}else {
//				System.out.println("登录成功");
//				s=k.step3("http://xk.henu.edu.cn:8093");
//				s=k.step4();
//				System.out.println(s);
//			};
//		}
//		long endTime = System.currentTimeMillis(); 
//		System.out.println("程序运行时间："+(endTime-startTime)+"ms");
	}
}