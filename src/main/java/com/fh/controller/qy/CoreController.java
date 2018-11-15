/*
package com.fh.controller.qy;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fh.entity.TB_WXQYAPP;
import com.fh.qy.aes.WXBizMsgCrypt;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.service.MessageService;
import com.fh.qy.service.MessageService1;
import com.fh.service.wxqy.app.QyAppService;

@Controller
@RequestMapping(value = "/qywx")
public class CoreController {
	@Resource(name="qyappService")
	private QyAppService qyAppService;
	
	@RequestMapping(value = "/jitqy", method = { RequestMethod.GET,	RequestMethod.POST })
	public void jitqy(HttpServletRequest request,HttpServletResponse response) throws IOException {
		boolean isGet = request.getMethod().toLowerCase().equals("get");
		TB_WXQYAPP tb_WxQyApp =  qyAppService.getApp("123");
		if (isGet) {
			// 微信加密签名
			String msg_signature = request.getParameter("msg_signature");
			// 时间戳
			String timestamp = request.getParameter("timestamp");
			// 随机数
			String nonce = request.getParameter("nonce");
			// 随机字符串
			String echostr = request.getParameter("echostr");

			System.out.println("request=" + request.getRequestURL());

			PrintWriter out = response.getWriter();
			// 通过检验msg_signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
			String result = null;
			try {
				WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(tb_WxQyApp.getToken(),tb_WxQyApp.getEncodingaeskey(),WeiXinParamesUtil.corpId);
				result = wxcpt.VerifyURL(msg_signature, timestamp, nonce,
						echostr);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (result == null) {
				result = tb_WxQyApp.getToken();
			}
			out.print(result);
			out.close();
			out = null;
		} else {
			// 1.将请求、响应的编码均设置为UTF-8（防止中文乱码）
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");

			// 2.调用消息业务类接收消息、处理消息
			MessageService msgsv = new MessageService();
			String respMessage = msgsv.getEncryptRespMessage(request);
			// 处理表情
			// String respMessage = CoreService.processRequest_emoj(request);
			// 处理图文消息
			// String respMessage = Test_NewsService.processRequest(request);

			// 3.响应消息
			PrintWriter out = response.getWriter();
			out.print(respMessage);
			out.close();
			// return null;
		}
	}

	@RequestMapping(value = "/test1qy", method = { RequestMethod.GET,RequestMethod.POST })
	public void test1qy(HttpServletRequest request,HttpServletResponse response) throws IOException {
		boolean isGet = request.getMethod().toLowerCase().equals("get");
		TB_WXQYAPP tb_WxQyApp =  qyAppService.getApp("test1");
		System.out.println("开始回调");
		if (isGet) {
			// 微信加密签名
			String msg_signature = request.getParameter("msg_signature");
			// 时间戳
			String timestamp = request.getParameter("timestamp");
			// 随机数
			String nonce = request.getParameter("nonce");
			// 随机字符串
			String echostr = request.getParameter("echostr");

			System.out.println("request=" + request.getRequestURL());

			PrintWriter out = response.getWriter();
			// 通过检验msg_signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
			String result = null;
		
			try {
				WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(
						tb_WxQyApp.getToken(),tb_WxQyApp.getEncodingaeskey(),
						WeiXinParamesUtil.corpId);
				result = wxcpt.VerifyURL(msg_signature, timestamp, nonce,
						echostr);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (result == null) {
				result = tb_WxQyApp.getToken();
			}
			out.print(result);
			out.close();
			out = null;
		} else {
			// 1.将请求、响应的编码均设置为UTF-8（防止中文乱码）
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");

			// 2.调用消息业务类接收消息、处理消息
			MessageService1 msgsv = new MessageService1();
			String respMessage = msgsv.getEncryptRespMessage(request);
			// 3.响应消息
			PrintWriter out = response.getWriter();
			out.print(respMessage);
			out.close();
			// return null;
		}
	}
}
*/
