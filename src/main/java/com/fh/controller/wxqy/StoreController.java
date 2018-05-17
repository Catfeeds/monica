package com.fh.controller.wxqy;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.item.impl.ItemService;
import com.fh.service.wxqy.newforwx.NewForWxManager;
import com.fh.util.PageData;


@Controller
@RequestMapping(value="/store")
public class StoreController extends BaseController{
	
	//图片域名pic_url
	private String pic_url = "http://jittest.s1.natapp.cc/ssww";
	
	@Resource(name="newforwxService")
	private NewForWxManager newforwxService;
	@Resource(name="itemService")
	ItemService itemService;
	
	@RequestMapping(value="/index")
	public ModelAndView toIndex(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("wxqy/store/index");
		return mv;
	}
	
	@RequestMapping(value="/list_indent")
	public ModelAndView list_indent(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("wxqy/store/list_indent");
		return mv;
	}
	@RequestMapping(value="/report")
	public ModelAndView toReport(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("wxqy/store/report");
		return mv;
	}
	
	//趋势分析
	@RequestMapping(value="/trendAnalysis")
	public ModelAndView trendAnalysis(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("wxqy/store/trendAnalysis");
		return mv;
	}
	
	//time rate时率分析
	@RequestMapping(value="/timeRateAnalysis")
	public ModelAndView timeRatetrendAnalysis(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("wxqy/store/timeRateAnalysis");
		return mv;
	}
	
	//门店客户
	@RequestMapping(value="/list_client")
	public ModelAndView list_client(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("wxqy/store/list_client");
		return mv;
	}
	
	//新增客户页面
		@RequestMapping(value="/addClient")
		public ModelAndView addClient(){
			ModelAndView mv = this.getModelAndView();
			mv.setViewName("wxqy/store/addClient");
			return mv;
		}
		
	//新闻公告页面
	@RequestMapping(value="/new_page")
	public ModelAndView new_page(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = newforwxService.listAll(pd);	//列出NewForWx列表
		System.out.println("----->"+varList);
		mv.addObject("varList", varList);
		mv.addObject("pic_url", pic_url);
		mv.addObject("pd", pd);
		mv.setViewName("wxqy/store/new_page");
		return mv;
	}
	
	//新闻详细页面（查看原文）
		@RequestMapping(value="/toDetail_new")
		public ModelAndView toDetail_new(Page page) throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			String keywords = pd.getString("keywords");				//关键词检索条件
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			PageData pageData = newforwxService.findById(pd);
			//List<PageData>	varList = newforwxService.list(page);	//列出NewForWx列表
			mv.addObject("pageData", pageData);
			mv.addObject("pd", pd);
			mv.setViewName("wxqy/store/detailed_new");
			return mv;
		}
		
		@RequestMapping(value="/loadICI")
		public ModelAndView load(Page page) throws Exception{
			/*logBefore(logger, Jurisdiction.getUsername()+"列表NewForWx");*/
			//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			String keywords = pd.getString("keywords");				//关键词检索条件
			String treeKey = pd.getString("treeKey");
			String showCount = pd.getString("showCount");
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
			}
			if(null != treeKey && !"".equals(treeKey)){
				pd.put("treeKey", URLDecoder.decode(treeKey, "UTF-8").trim());
			}
			if(null == showCount || "".equals(showCount)){
				page.setShowCount(15);
			}
			page.setPd(pd);
			System.out.println(page.getPageStr());
			List<PageData>	varList = itemService.list(page);
			mv.addObject("varList", varList);
			mv.setViewName("item/wxic");
			mv.addObject("pd", pd);
			//mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			return mv;
			
			
		}
}
