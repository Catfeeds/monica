package com.fh.qy.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONObject;

import com.fh.qy.pojo.message.send.BaseMessage;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.wx.utils.CommonUtil;
import com.google.gson.Gson;

public class CodeToUserService {
	
	private static Logger log = LoggerFactory.getLogger(CommonUtil.class);
	//private  String getUserinfo_url="https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=ACCESS_TOKEN&code=CODE";
	
	public JSONObject getUserinfo(String accessToken,String code){
		String getUserinfo_url="https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=ACCESS_TOKEN&code=CODE";
		getUserinfo_url = getUserinfo_url.replace("ACCESS_TOKEN", accessToken).replace("CODE", code);
		System.out.println(getUserinfo_url);
		//getUserinfo_url = getUserinfo_url.replace("CODE", code);
		//3.调用接口，发送消息
		JSONObject jsonObject = CommonUtil.httpsRequest(getUserinfo_url, "GET", null);
        System.out.println(jsonObject);
	
		//4.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("创建成员失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}
		return jsonObject;
	}  
}
