package com.fh.wx_api.api.core.req.model.message;

import com.fh.wx_api.api.core.annotation.ReqType;
import com.fh.wx_api.api.core.req.model.WeixinReqParam;

/**
 * 取多媒体文件
 * 
 * @author sfli.sir
 * 
 */
@ReqType("industryTemplateAdd")
public class IndustryTemplateAdd extends WeixinReqParam {

	private String template_id_short;

	public String getTemplate_id_short() {
		return template_id_short;
	}

	public void setTemplate_id_short(String template_id_short) {
		this.template_id_short = template_id_short;
	}
	
	
	
}
