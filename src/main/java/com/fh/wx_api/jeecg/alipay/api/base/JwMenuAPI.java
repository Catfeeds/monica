package com.fh.wx_api.jeecg.alipay.api.base;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.request.AlipayMobilePublicMenuAddRequest;
import com.alipay.api.request.AlipayMobilePublicMenuGetRequest;
import com.alipay.api.request.AlipayMobilePublicMenuUpdateRequest;
import com.alipay.api.response.AlipayMobilePublicMenuAddResponse;
import com.alipay.api.response.AlipayMobilePublicMenuGetResponse;
import com.alipay.api.response.AlipayMobilePublicMenuUpdateResponse;
import com.fh.wx_api.jeecg.alipay.api.base.vo.menuVo.BizContent;
import com.fh.wx_api.jeecg.alipay.api.core.AlipayClientFactory;
import com.fh.wx_api.jeecg.alipay.api.core.AlipayConfig;

/**
 * 支付服务窗菜单API
 * 
 * @author zhangdaihao
 * 
 */
public class JwMenuAPI {

	/**
	 * 添加菜单方法
	 * 
	 * @param appAuthToken
	 * @param bizContent
	 * @return
	 * @throws AlipayApiException
	 */
	public static AlipayMobilePublicMenuAddResponse menuAdd(String appAuthToken, BizContent model, AlipayConfig config) throws AlipayApiException {
		AlipayMobilePublicMenuAddRequest request = new AlipayMobilePublicMenuAddRequest();
		request.putOtherTextParam("app_auth_token", appAuthToken);
		String json = JSONObject.toJSONString(model);
		request.setBizContent(json);
		return AlipayClientFactory.getAlipayClientInstance(config).execute(request);
	}

	/**
	 * 更新菜单方法
	 * 
	 * @param appAuthToken
	 * @param bizContent
	 * @return
	 * @throws AlipayApiException
	 */
	public static AlipayMobilePublicMenuUpdateResponse menuUpdate(String appAuthToken, BizContent model, AlipayConfig config) throws AlipayApiException {
		AlipayMobilePublicMenuUpdateRequest request = new AlipayMobilePublicMenuUpdateRequest();
		request.putOtherTextParam("app_auth_token", appAuthToken);
		String json = JSONObject.toJSONString(model);
 
		json = json.replace(",\"subButton\":[]", "");
 
		request.setBizContent(json);
		return AlipayClientFactory.getAlipayClientInstance(config).execute(request);
	}

	/**
	 * 查询菜单方法
	 * 
	 * @param appAuthToken
	 * @return
	 * @throws AlipayApiException
	 */
	public static AlipayMobilePublicMenuGetResponse menuGet(String appAuthToken, AlipayConfig config) throws AlipayApiException {
		AlipayMobilePublicMenuGetRequest request = new AlipayMobilePublicMenuGetRequest();
		request.putOtherTextParam("app_auth_token", appAuthToken);
		return AlipayClientFactory.getAlipayClientInstance(config).execute(request);
	}

}
