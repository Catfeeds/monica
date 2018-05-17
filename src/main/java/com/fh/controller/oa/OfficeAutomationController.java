package com.fh.controller.oa;


import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.qy.service.CodeToUserService;
import com.fh.util.PageData;

@Controller
@RequestMapping(value="/officeautomation")
public class OfficeAutomationController extends BaseController{
	CodeToUserService ctus = new CodeToUserService();
	@RequestMapping(value="/toIndex")
	public ModelAndView tojump(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String code = pd.getString("code").trim();
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.officeaAgentSecret).getToken();
		JSONObject jsonObject = ctus.getUserinfo(accessToken, code);
		System.out.println(jsonObject);
		try {
			pd.put("USERID", jsonObject.getString("UserId"));
		} catch (Exception e) {
			System.out.println("=========================");
		}
		mv.setViewName("officeautomation/index");
		return mv;
	}
	
	@RequestMapping(value="/toLeave")
	public ModelAndView toLeave(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("officeautomation/toLeave");
		return mv;
	}
	
}
