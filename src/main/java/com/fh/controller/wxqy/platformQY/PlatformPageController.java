package com.fh.controller.wxqy.platformQY;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.qy.service.CodeToUserService;
import com.fh.service.wxqy.qywxuser.QyWxUserManager;
import com.fh.util.PageData;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value="/platformpage")
public class PlatformPageController extends BaseController {
	
	@Resource(name="qywxuserService")
	private QyWxUserManager qywxuserService;

	CodeToUserService ctus = new CodeToUserService();

	//二维码追溯
	@RequestMapping(value="/toQRcode")
	public ModelAndView toIndex(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("UserId", "");
		mv.setViewName("wxqy/platformQY/platform_page/QRcode");
		return mv;
	}

	//库存查询
	@RequestMapping(value="/icinventory")
	public ModelAndView icinventory(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("UserId", "");
		mv.setViewName("wxqy/platformQY/platform_page/icinventory");
		return mv;
	}

	//库存明细查询
	@RequestMapping(value="/icinventoryDetail")
	public ModelAndView icinventoryDetail(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("UserId", "");
		mv.setViewName("wxqy/platformQY/platform_page/icinventoryDetail");
		return mv;
	}

	//订单系统
	@RequestMapping(value="/toOrder")
	public ModelAndView toOrder(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("UserId", "");
		mv.setViewName("wxqy/platformQY/platform_page/toOrder");
		return mv;
	}
}
