package com.fh.wx_api.api.coupon.location.model;

import com.fh.wx_api.api.core.annotation.ReqType;
import com.fh.wx_api.api.core.req.model.WeixinReqParam;

import java.util.List;

@ReqType("getBatchadd")
public class Batchadd extends WeixinReqParam{
	//门店信息
	private List<LocationList> location_list;

	public List<LocationList> getLocation_list() {
		return location_list;
	}

	public void setLocation_list(List<LocationList> location_list) {
		this.location_list = location_list;
	}

	
	
}
