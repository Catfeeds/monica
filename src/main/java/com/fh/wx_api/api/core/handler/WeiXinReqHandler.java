package com.fh.wx_api.api.core.handler;


import com.fh.wx_api.api.core.exception.WexinReqException;
import com.fh.wx_api.api.core.req.model.WeixinReqParam;

/**
 * 获取微信接口的信息
 * @author liguo
 *
 */
public interface WeiXinReqHandler {
	
	public String doRequest(WeixinReqParam weixinReqParam) throws WexinReqException;
	
}
