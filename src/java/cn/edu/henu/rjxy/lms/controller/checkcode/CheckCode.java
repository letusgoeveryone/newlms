/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.checkcode;

//import com.sun.image.codec.jpeg.ImageFormatException;
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
//import java.io.ByteArrayInputStream;
//import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author wht
 */
@Controller
@RequestMapping("/reg/")
public class CheckCode {

//    private InputStream imageStream;
//	private String code;
    private Color getRandColor(int fc, int bc) {// 给定范围获得随机颜色
        Random random = new Random();
        if (fc > 255) {
            fc = 255;
        }
        if (bc > 255) {
            bc = 255;
        }
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

    @RequestMapping("/createImage")
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 在内存中创建图象
        int width = 80, height = 20;
        BufferedImage image = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);

        // 获取图形上下文
        Graphics g = image.getGraphics();

        // 生成随机类
        Random random = new Random();

        // 设定背景色
        g.setColor(getRandColor(200, 250));
        g.fillRect(0, 0, width, height);

        // 设定字体
        g.setFont(new Font("Times New Roman", Font.BOLD, 18));

        // 画边框
        g.setColor(new Color(0, 0, 0));
        g.drawRect(0, 0, width - 1, height - 1);

        // 随机产生155条干扰线，使图象中的认证码不易被其它程序探测到
        g.setColor(getRandColor(160, 200));
        for (int i = 0; i < 155; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            g.drawLine(x, y, x + xl, y + yl);
        }

        // 取随机产生的认证码(4位数字)
        String sRand = "";
        for (int i = 0; i < 4; i++) {
            String rand;
            // 随机生成数字或者字母
            if (random.nextInt(10) > 5) {
                rand = String.valueOf((char) (random.nextInt(10) + 48));
            } else {
                char ch = (char) (random.nextInt(26) + 65);
                while (ch == 'O' || ch == 'I') {
                    ch = (char) (random.nextInt(26) + 65);
                }
                rand = String.valueOf(ch);
            }
            sRand += rand;
            // 将认证码显示到图象中
            g.setColor(new Color(random.nextInt(80), random.nextInt(80), random
                    .nextInt(80)));
            // 调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
            g.drawString(rand, 15 * i + 10, 16);
        }
        //将认证码存入code
//		setCode(sRand);

//		// 将认证码存入SESSION
        //       Map<String, Object> session = ActionContext.getContext().getSession();
        request.getSession().setAttribute("hccd", sRand);
        System.out.println("验证码:" + request.getSession().getAttribute("hccd"));
//		System.out.println("验证码:"+getCode());

        // 图象生效
        g.dispose();

        // 输出图象到页面
//        try {
//            ByteArrayOutputStream bos = new ByteArrayOutputStream();
//            JPEGImageEncoder jpeg = JPEGCodec.createJPEGEncoder(bos);
//            jpeg.encode(image);
//            byte[] bts = bos.toByteArray();
//            imageStream = new ByteArrayInputStream(bts);
//        } catch (IOException | ImageFormatException e) {
//            e.printStackTrace();
//            return "error";
//        }
        //设置页面不缓存
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        try {
            // 输出图象到页面
            ImageIO.write(image, "JPEG", response.getOutputStream());
        } catch (IOException ex) {
            Logger.getLogger(CheckCode.class.getName()).log(Level.SEVERE, null, ex);
        }
//		HttpServletResponse response = ServletActionContext.getResponse();
//		try {
//			ImageIO.write(image, "JPEG", response.getOutputStream());
//		} catch (IOException e) {
//			e.printStackTrace();
//			return "error";
//		}
        return "success";
    }

    @RequestMapping("/checkCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String ccd = (String) session.getAttribute("hccd");
        System.out.println("验证码:" + ccd);

        response.setCharacterEncoding("utf-8");
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.print(ccd);
            out.flush();
            out.close();

        } catch (IOException ex) {
            Logger.getLogger(CheckCode.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//    public InputStream getImageStream() {
//        return imageStream;
//    }
//
//    public void setImageStream(InputStream imageStream) {
//        this.imageStream = imageStream;
//    }
}
