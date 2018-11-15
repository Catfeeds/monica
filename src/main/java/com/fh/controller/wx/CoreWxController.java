package com.fh.controller.wx;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fh.wx.service.CoreService;

@Controller
@RequestMapping(value="/wx")
public class CoreWxController {
	@RequestMapping(value = "/setWeixin", method ={RequestMethod.GET, RequestMethod.POST})
	public void setWeixin(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		boolean isGet = request.getMethod().toLowerCase().equals("get"); 
		if(isGet){
		try {  
            // 解析出url上的参数值如下：  
            String sVerifyMsgSig = request.getParameter("msg_signature");  
            String sVerifyTimeStamp = request.getParameter("timestamp");  
            String sVerifyNonce = request.getParameter("nonce");  
            String sVerifyEchoStr = request.getParameter("echostr");  
            String sEchoStr; //需要返回的明文  
            // 验证URL成功，将sEchoStr返回  
            PrintWriter out = response.getWriter();  
            out.print(sVerifyEchoStr);  
              
        } catch (Exception e) {  
            PrintWriter out = response.getWriter();  
            out.print(e);  
            //验证URL失败，错误原因请查看异常  
            e.printStackTrace();  
        }  
		}else{
		request.setCharacterEncoding("UTF-8");  //微信服务器POST消息时用的是UTF-8编码，在接收时也要用同样的编码，否则中文会乱码；
        response.setCharacterEncoding("UTF-8"); //在响应消息（回复消息给用户）时，也将编码方式设置为UTF-8，原理同上；boolean isGet = request.getMethod().toLowerCase().equals("get"); 
       // System.out.println(request);
		// response.setCharacterEncoding("UTF-8");
		// 响应消息
		PrintWriter out = response.getWriter();
		String respXml = CoreService.processRequest(request);
		//System.out.println(respXml);

		out.print(respXml);
		out.close();
		}
		//return null;
	}
            
}
