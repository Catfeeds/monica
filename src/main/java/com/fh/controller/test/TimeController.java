package com.fh.controller.test;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.service.commodity.commoditypic.CommodityPicManager;
import com.fh.service.fhdb.timingbackup.TimingBackUpManager;
import com.fh.util.PageData;
import com.fh.util.Tools;

@Controller
public class TimeController extends BaseController{
	
	@Resource(name="commoditypicService")
	private CommodityPicManager commoditypicService;
    
	@RequestMapping(value="/test_get")
	@ResponseBody
    public Map<String, Object> testname() throws Exception {
		Map<String, Object> json = new HashMap<String, Object>();
    	System.out.println("zhixing service");
    	PageData pd = new PageData();
    	pd.put("COMMODITYPIC_ID", this.get32UUID());	//主键
		pd.put("COMMODITY_ID", "1231");	//COMMODITY_ID
		pd.put("FITEMID", "11");	//FITEMID
		pd.put("FPARENTID", "12");	//FPARENTID
		commoditypicService.save(pd);
		json.put("result", "123");
		return json;
	}
    
   
}
