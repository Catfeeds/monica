package com.fh.wx_api.api.coupon.location.model;

import com.fh.wx_api.api.core.annotation.ReqType;
import com.fh.wx_api.api.core.req.model.WeixinReqParam;

@ReqType("getLocationInfo")
public class LocationInfo extends WeixinReqParam {
	// 图片地址
	private String filePathName;

	public String getFilePathName() {
		return filePathName;
	}

	public void setFilePathName(String filePathName) {
		this.filePathName = filePathName;
	}


	
}
