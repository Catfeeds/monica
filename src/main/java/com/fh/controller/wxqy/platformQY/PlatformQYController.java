package com.fh.controller.wxqy.platformQY;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.qy.service.CodeToUserService;
import com.fh.service.wxqy.qywxuser.QyWxUserManager;
import com.fh.util.PageData;
import com.fh.wx.info.WeixinInfo;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/platformQY")
public class PlatformQYController extends BaseController {
	
	@Resource(name="qywxuserService")
	private QyWxUserManager qywxuserService;

	CodeToUserService ctus = new CodeToUserService();
	
	/*@RequestMapping(value="/tojump")
	public ModelAndView tojump(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("wxqy/platformQY/jump");
		return mv;
	}*/
	
	@RequestMapping(value="/index")
	public ModelAndView toIndex(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String code = pd.getString("code").trim();
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.mncAgentSecret).getToken();
		JSONObject jsonObject = ctus.getUserinfo(accessToken, code);
		//System.out.println("----->"+jsonObject);
		try {
			pd.put("USERID", jsonObject.getString("UserId"));
			PageData userData = qywxuserService.findByUserId(pd);
			mv.addObject("userData", userData);
		} catch (Exception e) {
			System.out.println("=========================");
		}
		mv.addObject("code", code);
		mv.addObject("UserId", jsonObject.getString("UserId"));
		mv.setViewName("wxqy/platformQY/index");
		return mv;
	}

	@RequestMapping(value="/testIndex")
	public ModelAndView testIndex(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("UserId", "1213");
		mv.setViewName("wxqy/platformQY/index");
		return mv;
	}
	
	@RequestMapping(value="/getUserId")
	@ResponseBody
	public Map<String, Object> getUserId(Page page) throws Exception {
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String code = pd.getString("code").trim();
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.mncAgentSecret).getToken();
		JSONObject jsonObject = ctus.getUserinfo(accessToken, code);
		pd.put("USERID", jsonObject.getString("UserId"));
		PageData userData = qywxuserService.findByUserId(pd);
		json.put("result", "123");
		return json;
	}
	

}
