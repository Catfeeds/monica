package com.fh.controller.wxqy.platformQY;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.qy.service.CodeToUserService;
import com.fh.service.system.dictionaries.DictionariesManager;
import com.fh.service.wxqy.qywxuser.QyWxUserManager;
import com.fh.util.PageData;
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
@RequestMapping(value="/platformpage")
public class PlatformPageController extends BaseController {
	
	@Resource(name="qywxuserService")
	private QyWxUserManager qywxuserService;

	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;

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
		mv.setViewName("wxqy/platformQY/platform_page/order/toOrder");
		return mv;
	}

	//新增订单系统
	@RequestMapping(value="/createOrder")
	public ModelAndView createOrder(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PNAME","包装");
		List<PageData> listbz = dictionariesService.listByParentName(pd);
		mv.addObject("listbz", listbz);
		mv.addObject("UserId", "");
		mv.setViewName("wxqy/platformQY/platform_page/order/createOrder");
		return mv;
	}

	@RequestMapping(value = "loadDictionarise")
	@ResponseBody
	public Map<String, Object> loadDictionarise(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PNAME","包装");
		List<PageData> listbz = dictionariesService.listByParentName(pd);
		json.put("listbz", listbz);
		pd.put("PNAME","镜面抛");
		List<PageData> listjmp = dictionariesService.listByParentName(pd);
		json.put("listjmp", listjmp);
		pd.put("PNAME","胶水");
		List<PageData> listjs = dictionariesService.listByParentName(pd);
		json.put("listjs", listjs);
		pd.put("PNAME","标识要求");
		List<PageData> listbsyq = dictionariesService.listByParentName(pd);
		json.put("listbsyq", listbsyq);
		pd.put("PNAME","喷码");
		List<PageData> listpm = dictionariesService.listByParentName(pd);
		json.put("listpm", listpm);
		pd.put("PNAME","客户验货");
		List<PageData> listkhyh = dictionariesService.listByParentName(pd);
		json.put("listkhyh", listkhyh);
		pd.put("PNAME","物流");
		List<PageData> listwl = dictionariesService.listByParentName(pd);
		json.put("listwl", listwl);
		pd.put("PNAME","跟柜物品");
		List<PageData> listggwp = dictionariesService.listByParentName(pd);
		json.put("listggwp", listggwp);
		System.out.println(json);
		return json;
	}
}
