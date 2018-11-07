package com.fh.controller.management.classify_item;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.interfaceip.InterfaceIPManager;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.service.management.classify_item.Classify_itemManager;

/**
 * 说明：分类管理 创建人：成 创建时间：2018-01-31
 */
@Controller
@RequestMapping(value = "/classify_item")
public class Classify_itemController extends BaseController {

	String menuUrl = "classify_item/list.do"; // 菜单地址(权限用)
	@Resource(name = "classify_itemService")
	private Classify_itemManager classify_itemService;
	@Resource(name="interfaceipService")
	private InterfaceIPManager interfaceipService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增Classify_item");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CLASSIFY_ITEM_ID", this.get32UUID()); // 主键
		classify_itemService.save(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除Classify_item");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		classify_itemService.delete(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改Classify_item");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		classify_itemService.edit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	// 树
	@RequestMapping(value = "/listTree")
	public ModelAndView listTree() throws Exception {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("zNodes", jsStr);
		mv.setViewName("management/classify_item/classify_item_tree");
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
			arr = JSONArray.fromObject(classify_itemService.listAll(pd));
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONArray jsStr = JSONArray.fromObject(this.makeTree(arr));
		//System.out.println(jsStr);
		return jsStr;
	}

	@SuppressWarnings("unchecked")
	public String makeTree(JSONArray arr) {
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		Iterator<Object> it = arr.iterator();
		while (it.hasNext()) {
			JSONObject ob = (JSONObject) it.next();
			sb.append("{id:").append(ob.getString("FITEMID")).append(",pId:")
					.append(ob.getString("FPARENTID")).append(",name:\"")
					.append(ob.getString("FNAME")).append("\"")
					.append(",open:").append("false").append("},");
		}
		return sb.substring(0, sb.length() - 1) + "]";
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Classify_item");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList = classify_itemService.list(page); // 列出Classify_item列表
		mv.setViewName("management/classify_item/classify_item_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

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

	@RequestMapping(value="/getClassify_item")
	@ResponseBody
	public Map<String, Object> getClassify_item() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		String requestUrl = this.getIpAndProjectName()+"/erp_Get/getClassify_item";
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
			PageData pd = new PageData();
			List<PageData>	varOList = classify_itemService.listAll(pd); // 本地数据
			//新增开关
			int hint = 0; //0为开启，1为关闭
			//删除开关
			int dint = 0; //开0,关1
			//int dstr = 0;
			int count = 0;
			int dcount = 0;
			int ecount = 0;
			PageData pd3 = new PageData();
			for (int i = 0; i < jsonarr.size(); i++) {
				hint = 1;
				JSONObject job = jsonarr.getJSONObject(i);
				for (int j = 0; j < varOList.size(); j++) {
					if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
						hint = 0;
						if (!varOList.get(j).get("FMODIFYTIME").equals(job.get("FModifyTime").toString())) {
							pd3.put("CLASSIFY_ITEM_ID", varOList.get(j).get("CLASSIFY_ITEM_ID"));
							pd3.put("FNAME", job.getString("FName"));
							pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
							pd3.put("FNUMBER", job.getString("FNumber"));
							pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
							pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
							classify_itemService.edit(pd3);
							ecount ++ ;
						}
					}
				}
				if(hint == 1) {
					pd.put("CLASSIFY_ITEM_ID", this.get32UUID());
					pd.put("FNAME", job.getString("FName"));
					pd.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
					pd.put("FNUMBER", job.getString("FNumber"));
					pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
					pd.put("FMODIFYTIME", job.get("FModifyTime").toString());
					classify_itemService.save(pd);
					count++;
				}
			}

			for (int j = 0; j < varOList.size(); j++) {
				for (int i = 0; i < jsonarr.size(); i++) {
					JSONObject job = jsonarr.getJSONObject(i);
					if(Integer.parseInt(job.get("FItemID").toString()) == Integer.parseInt(varOList.get(j).get("FITEMID").toString())){
						dint = 1; //存在
					}
				}
				if(dint == 0){
					PageData pd2 = new PageData();
					pd2.put("FITEMID",Integer.parseInt(varOList.get(j).get("FITEMID").toString()));
					classify_itemService.deleteByFITEMID(pd2);
					dcount ++ ;
				}
				dint = 0;
			}
			System.out.println("完成");
			System.out.println("新增数据"+count);
			System.out.println("修改数据"+ecount);
			System.out.println("删除数据"+dcount);
			json.put("Data", "新增数据"+count+"条；"+"修改数据"+ecount+"条；"+"删除数据"+dcount+"条。");
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("management/classify_item/classify_item_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = classify_itemService.findById(pd); // 根据ID读取
		mv.setViewName("management/classify_item/classify_item_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Classify_item");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			classify_itemService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出Classify_item到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("FItemID"); // 1
		titles.add("编号"); // 2
		titles.add("名称"); // 3
		titles.add("父ID"); // 4
		titles.add("FModifyTime"); // 5
		dataMap.put("titles", titles);
		List<PageData> varOList = classify_itemService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("FITEMID").toString()); // 1
			vpd.put("var2", varOList.get(i).getString("FNUMBER")); // 2
			vpd.put("var3", varOList.get(i).getString("FNAME")); // 3
			vpd.put("var4", varOList.get(i).get("FPARENTID").toString()); // 4
			vpd.put("var5", varOList.get(i).getString("FMODIFYTIME")); // 5
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,
				true));
	}
}
