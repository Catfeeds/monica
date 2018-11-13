package com.fh.wx_api.api.core.req.model.user;

import com.fh.wx_api.api.core.annotation.ReqType;
import com.fh.wx_api.api.core.req.model.WeixinReqParam;

/**
 * 分组删除
 * 
 * @author sfli.sir
 * 
 */
@ReqType("groupDelete")
public class GroupDelete extends WeixinReqParam {

	private Group group;

	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
	}
	
}
