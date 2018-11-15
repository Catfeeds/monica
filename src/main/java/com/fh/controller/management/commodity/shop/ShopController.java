package com.fh.controller.management.commodity.shop;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;

/** 
 * 说明：商城管理
 * 创建人：成
 * 创建时间：2017-12-04
 */
@Controller
@RequestMapping(value="/commodity_shop")
public class ShopController extends BaseController{
	
	
	@RequestMapping(value="/toShopIndex")
	public ModelAndView toShopIndex(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		//PageData pd = new PageData();
		//pd = this.getPageData();
		mv.setViewName("commodity/shop/shopIndex");
		return mv;
	}
}
