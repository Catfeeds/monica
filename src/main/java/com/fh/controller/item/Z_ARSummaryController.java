package com.fh.controller.item;

import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.qy.pojo.message.send.News;
import com.fh.service.item.impl.ItemService;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.jndi.url.rmi.rmiURLContextFactory;

@Controller
@RequestMapping(value="/z_ARSummary")
public class Z_ARSummaryController extends BaseController {
	
	@Resource(name="itemService")
	ItemService itemService;
	
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (null != pd.getString("time") && !"".equals(pd.getString("time"))) {
			System.out.println(pd.getString("time").substring(5, 7));
			pd.put("Year",Integer.parseInt(pd.getString("time").substring(0, 4)));
			pd.put("Period",Integer.parseInt(pd.getString("time").substring(5,7)));
			pd.put("CustNum",pd.getString("CustNum"));
			pd.put("EmpName",pd.getString("EmpName"));
		}else {
			pd.put("Year",Calendar.getInstance().get(Calendar.YEAR));
			pd.put("Period",(Calendar.getInstance().get(Calendar.MONTH)+1));
			pd.put("CustNum",pd.getString("CustNum"));
			pd.put("EmpName",pd.getString("EmpName"));
		}
		/*System.out.println("da");*/
		page.setPd(pd);
		List<PageData>	varList1 = itemService.list_z_ARSummary(page);
		List<PageData>	varList = new ArrayList<PageData>();
		if (varList1.size() == 0) {
			mv.setViewName("item/z_ARSummary");
			return mv; 
		}
		int cf = varList1.size()/15;
		int pagecount;
		if (varList1.size()%15==0) {
			pagecount = cf;
		}else {
			pagecount = cf+1;
		}
		int pageid = 1;
		String pag = "";
		for (int j = 0; j < 5; j++) {
			pag += "<li style='cursor:pointer;''><a onclick='nextPage("+(j+1)+")'>"+(j+1)+"</a></li>";
		}
		if (null != pd.getString("pageid") && !"".equals(pd.getString("pageid"))) {
			if (varList1.size()%15 != 0 && Integer.parseInt(pd.getString("pageid"))==pagecount) {
				for (int i = 0; i < 15*(Integer.parseInt(pd.getString("pageid"))-1)+varList1.size()%15; i++) {
					if (i > 15*(Integer.parseInt(pd.getString("pageid"))-1)-1) {
						varList.add(varList1.get(i));
					}
				}
			}else {
				for (int i = 0; i < 15*Integer.parseInt(pd.getString("pageid")); i++) {
					if (i > 15*(Integer.parseInt(pd.getString("pageid"))-1)-1) {
						varList.add(varList1.get(i));
					}
				}
			}
		}else {
			for (int i = 0; i < 15; i++) {
				varList.add(varList1.get(i));
			}
		}
		if (pd.getString("pageid") != null && !"".equals(pd.getString("pageid"))) {
			if(Integer.parseInt(pd.getString("pageid"))==pagecount){
				pageid = pagecount;
			}else {
				pageid = Integer.parseInt(pd.getString("pageid")) + 1;
			}
		}else {
			pageid = 2;
		}
		String pageString = "<ul class='pagination pull-right no-margin'><li><a>共<font color='red'>";
		pageString += varList1.size()+"</font>条</a></li>";
		pageString += "<li><input type='number' value='' id='toGoPage' style='width:50px;text-align:center;float:left' placeholder='页码'></li>";
		pageString += "<li style='cursor:pointer;'><a onclick='toTiaoz();' class='btn btn-mini btn-success'>跳转</a></li>";
		pageString += "<li><a>首页</a></li>";
		pageString += "<li><a>上页</a></li>";
		pageString += pag;
		pageString += "<li style='cursor:pointer;'><a onclick='nextPage("+pageid+")'>下页</a></li>";
		pageString += "<li style=''cursor:pointer;'><a onclick='nextPage("+pagecount+")'>尾页</a></li>";
		pageString += "<li><a>共"+pagecount+"页</a><a style='display: none;' id= 'maxPage'>"+pagecount+"</a></li>";
		pageString += "</ul>";
		//System.out.println(varList);
		mv.setViewName("item/z_ARSummary");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("pageString", pageString);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	//库存表导出Excel
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出stock到excel");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (null != pd.getString("time") && !"".equals(pd.getString("time"))) {
			System.out.println(pd.getString("time").substring(5, 7));
			pd.put("Year",Integer.parseInt(pd.getString("time").substring(0, 4)));
			pd.put("Period",Integer.parseInt(pd.getString("time").substring(5,7)));
			pd.put("CustNum",pd.getString("CustNum"));
			pd.put("EmpName",pd.getString("EmpName"));
		}else {
			pd.put("Year",Calendar.getInstance().get(Calendar.YEAR));
			pd.put("Period",(Calendar.getInstance().get(Calendar.MONTH)+1));
			pd.put("CustNum",pd.getString("CustNum"));
			pd.put("EmpName",pd.getString("EmpName"));
		}
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("年份");	//1
		titles.add("期间");	//2
		titles.add("客户代码");	//3
		titles.add("客户名称");	//4
		titles.add("期初余额");	//5
		titles.add("本期应收");	//6
		titles.add("本期余额");	//7
		titles.add("本年累计应收");	//8
		titles.add("本年累计实收");	//9
		titles.add("FSumSort");	//10
		dataMap.put("titles", titles);
		page.setShowCount(1000000);
		page.setPd(pd);
		System.out.println(pd);
		List<PageData>	varOList = itemService.list_z_ARSummary(page);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("年份").toString());	    //1
			vpd.put("var2", varOList.get(i).get("期间").toString());	    //2
			vpd.put("var3", varOList.get(i).getString("客户代码"));	    //3
			vpd.put("var4", varOList.get(i).getString("客户名称"));	    //4
			vpd.put("var5", varOList.get(i).get("期初余额").toString().substring(0,varOList.get(i).get("期初余额").toString().indexOf(".")));	    //5
			vpd.put("var6", varOList.get(i).get("本期应收").toString().substring(0,varOList.get(i).get("本期应收").toString().indexOf(".")));	    //6
			vpd.put("var7", varOList.get(i).get("本期余额").toString().substring(0,varOList.get(i).get("本期余额").toString().indexOf(".")));	    //7
			vpd.put("var8", varOList.get(i).get("本年累计应收").toString().substring(0,varOList.get(i).get("本年累计应收").toString().indexOf(".")));	    //8
			vpd.put("var9", varOList.get(i).get("本年累计实收").toString().substring(0,varOList.get(i).get("本年累计实收").toString().indexOf(".")));	    //9
			vpd.put("var10", varOList.get(i).get("FSumSort").toString());	    //10
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
}
