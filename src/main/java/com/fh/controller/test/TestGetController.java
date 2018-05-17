package com.fh.controller.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.item.impl.ItemService;
import com.fh.service.management.erp_dep.ERP_DepManager;
import com.fh.service.management.synchronization.impl.SynSupplierService;
import com.fh.util.PageData;


@Controller
@RequestMapping(value="/test_Get")
public class TestGetController extends BaseController{
	
	@Resource(name="erp_depService")
	private ERP_DepManager erp_depService;
	
	@Resource(name="itemService")
	ItemService itemService;
	
	@Resource(name="synSupplierService")
	private SynSupplierService synSupplierService;
	
	
	@RequestMapping(value="/getBillNO")
	@ResponseBody
	public  Map<String, Object> getBillNO(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData varList = itemService.getBillNO(pd);
		json.put("Data", varList);
		return json;
		
	}
	
	@RequestMapping(value="/erp_dep")
	@ResponseBody
	public  Map<String, Object> erp_dep(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setShowCount(1000);
		System.out.println(pd.getString("test"));
		List<PageData>	varList = itemService.listAll_ERP(page);
		json.put("Data", varList);
		return json;
		
	}
	
	@RequestMapping(value="/erp_supplier")
	@ResponseBody
	public  Map<String, Object> erp_supplier(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setShowCount(1000);
		System.out.println(pd.getString("test"));
		List<PageData>	varList  =synSupplierService.supplier_synchronization(page);
		//List<PageData>	varList = itemService.listAll_ERP(page);
		json.put("Data", varList);
		return json;
		
	}
	
	@RequestMapping(value="/erp_item")
	@ResponseBody
	public  Map<String, Object> erp_item(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		//page.setShowCount(1000);
		//System.out.println(pd.getString("test"));
		List<PageData>	varList  =itemService.listItemAll(pd);
		//System.out.println(varList);
		//List<PageData>	varList = itemService.listAll_ERP(page);
		json.put("Data", varList);
		return json;
		
	}
	
	
	@RequestMapping(value="/getClient")
	@ResponseBody
	public  Map<String, Object> getClient(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		List<PageData>	varList  =itemService.listClient(page);
		json.put("Data", varList);
		return json;
	}
	
}
