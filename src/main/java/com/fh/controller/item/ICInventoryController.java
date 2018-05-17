package com.fh.controller.item;

import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
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
import com.fh.service.item.impl.ItemService;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

@Controller
@RequestMapping(value = "/icinventory")
public class ICInventoryController extends BaseController {

	@Resource(name = "itemService")
	ItemService itemService;

	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表NewForWx");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		String treeKey = pd.getString("treeKey");
		String showCount = pd.getString("showCount");
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		if (null != treeKey && !"".equals(treeKey)) {
			pd.put("treeKey", URLDecoder.decode(treeKey, "UTF-8").trim());
		}
		if (null == showCount || "".equals(showCount)) {
			page.setShowCount(15);
		}
		page.setPd(pd);
		List<PageData> varList = itemService.list(page);
		System.out.println(varList.size());
		mv.setViewName("item/icinventory");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	@RequestMapping(value = "/listTree")
	public ModelAndView listTree() throws Exception {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("zNodes", jsStr);
		mv.setViewName("item/item_tree");
		return mv;
	}

	@RequestMapping(value = "/dateTree")
	@ResponseBody
	public JSONArray dateTree(Page page) {
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		JSONArray arr = null;
		try {
			arr = JSONArray.fromObject(itemService.list_tree(page));
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONArray jsStr = JSONArray.fromObject(this.makeTree(arr));
		// System.out.println("====>"+jsStr);
		return jsStr;
	}

	@SuppressWarnings("unchecked")
	public String makeTree(JSONArray arr) {
		// Check Roles is null
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		Iterator<Object> it = arr.iterator();
		while (it.hasNext()) {
			JSONObject ob = (JSONObject) it.next();
			sb.append("{id:").append(ob.getString("CKid")).append(",pId:")
					.append(ob.getString("CKFid")).append(",name:\"")
					.append(ob.getString("CK")).append("\"").append(",open:")
					.append("false").append("},");
		}
		// System.out.println(sb.substring(0,sb.length()-1)+"]");
		return sb.substring(0, sb.length() - 1) + "]";
	}

	// 库存表导出Excel
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出stock到excel");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("商品代码"); // 1
		titles.add("商品名称"); // 2
		titles.add("规格型号"); // 3
		titles.add("库存数量"); // 4
		titles.add("单位"); // 5
		titles.add("仓库"); // 6
		dataMap.put("titles", titles);
		page.setShowCount(1000000);
		List<PageData> varOList = itemService.list(page);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("AFNumber")); // 1
			vpd.put("var2", varOList.get(i).getString("AFName")); // 2
			vpd.put("var3", varOList.get(i).getString("AFModel")); // 3
			System.out.println(varOList.get(i).get("CFQty").toString());
			if (varOList.get(i).get("CFQty").toString().equals("0E-10")) {
				vpd.put("var4", "0"); // 4
			} else {
				vpd.put("var4",
						varOList.get(i)
								.get("CFQty")
								.toString()
								.substring(
										0,
										varOList.get(i).get("CFQty").toString()
												.indexOf("."))); // 4
			}
			vpd.put("var5", varOList.get(i).getString("BFName")); // 5
			vpd.put("var6", varOList.get(i).getString("DFName")); // 6
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}
}
