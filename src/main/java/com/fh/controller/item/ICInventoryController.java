package com.fh.controller.item;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.fh.service.management.interfaceip.InterfaceIPManager;
import com.fh.service.management.warehouse.WarehouseManager;
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

	@Resource(name="warehouseService")
	private WarehouseManager warehouseService;

	@Resource(name="interfaceipService")
	private InterfaceIPManager interfaceipService;

	public String getIpAndProjectName()throws Exception{
		String ip = null;
		String projectName = null;
		PageData pd = new PageData();
		pd = interfaceipService.findByNew(pd);
		ip = pd.getString("IP");
		System.out.println("ip:"+ip);
		projectName = pd.getString("PROJECTNAME");
		return ip+"/"+projectName;
	}

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
		String currentPage = pd.getString("currentPage");
		System.out.println("pd"+pd);
		if (null != currentPage && !"".equals(currentPage)) {
			currentPage = pd.getString("currentPage");
		}else {
			currentPage = "0";
		}
		//String showCount  = pd.getString("showCount");
		/*if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}*/
		if (null != treeKey && !"".equals(treeKey)) {
			pd.put("treeKey", treeKey);
		}
		page.setPd(pd);
		//System.out.println(pd);
		String requestUrl = this.getIpAndProjectName()+"/erp_Get/erp_getInventory?currentPage="+currentPage+"&treeKey="+treeKey;
				//+"&keywords="+keywords;
		System.out.println(requestUrl);
		try {
			URL httpclient =new URL(requestUrl);
			HttpURLConnection conn =(HttpURLConnection) httpclient.openConnection();
			conn.setConnectTimeout(50000);
			conn.setReadTimeout(20000);
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.connect();
			InputStream is =conn.getInputStream();
			//int size =is.available();
			ByteArrayOutputStream buff = new ByteArrayOutputStream();
			int c;
			while((c = is.read()) >= 0){
				buff.write(c);
			}
			byte[] data = buff.toByteArray();
			buff.close();

			String htmlText = new String(data, "UTF-8");
			JSONObject jsStr = JSONObject.fromObject(htmlText);
			//System.out.println(jsStr);
			JSONArray jsonarr = jsStr.getJSONArray("Data"); // erp数据
			String jsonPageStr = jsStr.getString("getPageStr"); // 分页
			String jsonPage = jsStr.getString("page"); // 分页
			//System.out.println(jsonPageStr);
			List<PageData> listInventory = jsonarr;
			mv.addObject("varList", listInventory);
			mv.addObject("jsonPageStr", jsonPageStr);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//List<PageData> varList = itemService.list(page);
		mv.setViewName("item/icinventory");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	public void getWarehouse() throws Exception{
		String requestUrl = this.getIpAndProjectName()+"/erp_Get/getWarehouse";
		try {
			URL httpclient =new URL(requestUrl);
			HttpURLConnection conn =(HttpURLConnection) httpclient.openConnection();
			conn.setConnectTimeout(50000);
			conn.setReadTimeout(20000);
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.connect();
			InputStream is =conn.getInputStream();
			//int size =is.available();
			ByteArrayOutputStream buff = new ByteArrayOutputStream();
			int c;
			while((c = is.read()) >= 0){
				buff.write(c);
			}
			byte[] data = buff.toByteArray();
			buff.close();
			String htmlText = new String(data, "UTF-8");
			JSONObject jsStr = JSONObject.fromObject(htmlText);
			JSONArray jsonarr = jsStr.getJSONArray("Data"); // erp数据
			PageData pd = new PageData();
			warehouseService.deleteAll(pd);
			for (int i = 0; i < jsonarr.size(); i++) {
				JSONObject job = jsonarr.getJSONObject(i);
				pd.put("WAREHOUSE_ID", this.get32UUID());
				pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
				pd.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
				pd.put("FNAME",job.getString("FName"));
				//System.out.println(pd);
				warehouseService.save(pd);
				}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
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
	public JSONArray dateTree(Page page) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		getWarehouse();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		JSONArray arr = null;
		try {
			arr = JSONArray.fromObject(warehouseService.listAll(pd));
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
			sb.append("{id:").append(ob.getString("FITEMID")).append(",pId:")
					.append(ob.getString("FPARENTID")).append(",name:\"")
					.append(ob.getString("FNAME")).append("\"").append(",open:")
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
