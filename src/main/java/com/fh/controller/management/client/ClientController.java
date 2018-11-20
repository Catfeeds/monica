package com.fh.controller.management.client;

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

import com.fh.service.dst.datasource2.DataSource2Manager;
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
import com.fh.util.Tools;
import com.fh.service.management.client.ClientManager;

/** 
 * 说明：客户资料
 * 创建人：成
 * 创建时间：2018-02-25
 */
@Controller
@RequestMapping(value="/client")
public class ClientController extends BaseController {
	
	String menuUrl = "client/list.do"; //菜单地址(权限用)
	@Resource(name="clientService")
	private ClientManager clientService;

	@Resource(name="interfaceipService")
	private InterfaceIPManager interfaceipService;

	@Resource(name="datasource2Service")
	private DataSource2Manager dataSource2Service;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Client");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CLIENT_ID", this.get32UUID());	//主键
		clientService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Client");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		clientService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Client");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		clientService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	// 树
	@RequestMapping(value = "/listTree")
	public ModelAndView listTree() throws Exception {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("zNodes", jsStr);
		mv.setViewName("management/client/client_tree");
		return mv;
	}

	@RequestMapping(value="/listTree_select")
	public ModelAndView listTree_select() throws Exception{
		ModelAndView mv = new ModelAndView();
		//mv.addObject("zNodes", jsStr);
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("pd", pd);
		mv.setViewName("management/salesorderbill/client_tree_select");
		return mv;
	}

	@RequestMapping(value="/findClientByID")
	@ResponseBody
	public Map<String, Object> findClientByID() throws Exception{
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd = clientService.findById(pd);	//根据ID读取
		json.put("pd", pd);
		return json;
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
			arr = JSONArray.fromObject(clientService.getClassify(page));
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
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Client");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String treeKey = pd.getString("treeKey");				//关键词检索条件
		if(null != treeKey && !"".equals(treeKey)){
			pd.put("treeKey", treeKey.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = clientService.list(page);	//列出Client列表
		mv.setViewName("management/client/client_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	@RequestMapping(value="/toClientBy_tree")
	public ModelAndView toClientBy_tree(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Client");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String treeKey = pd.getString("treeKey");				//关键词检索条件
		if(null != treeKey && !"".equals(treeKey)){
			pd.put("treeKey", treeKey.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = clientService.list(page);	//列出Client列表
		mv.setViewName("management/salesorderbill/toClientBy_tree");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("management/client/client_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = clientService.findById(pd);	//根据ID读取
		mv.setViewName("management/client/client_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Client");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			clientService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	@RequestMapping(value = "/getClassClient")
	public ModelAndView getClassClient(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = clientService.list(page);	//列出Employee列表
		/* TODO 选择客户 */
		mv.setViewName("management/employee/toClient_tree");
		mv.addObject("varList", varList);
		return mv;
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Client到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("FItemID");	//1
		titles.add("客户编码");	//2
		titles.add("客户名称");	//3
		titles.add("FParentID");	//4
		titles.add("FModifyTime");	//5
		titles.add("FDeleted");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = clientService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("FITEMID").toString());	//1
			vpd.put("var2", varOList.get(i).getString("FNUMBER"));	    //2
			vpd.put("var3", varOList.get(i).getString("FNAME"));	    //3
			vpd.put("var4", varOList.get(i).get("FPARENTID").toString());	//4
			vpd.put("var5", varOList.get(i).getString("FMODIFYTIME"));	    //5
			vpd.put("var6", varOList.get(i).get("FDELETED").toString());	//6
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}

	/**
	 * 获取IP地址和项目名
	 * @return
	 * @throws Exception
	 */
	public String getIpAndProjectName()throws Exception{
		String ip = null;
		String projectName = null;
		PageData pd = new PageData();
		pd = interfaceipService.findByNew(pd);
		ip = pd.getString("IP");
		projectName = pd.getString("PROJECTNAME");
		System.out.println(ip + "/" + projectName);
		return ip+"/"+projectName;
	}

	/**
	 * 同步客户资料
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getCustomer")
	@ResponseBody
	public Map<String, Object> getCustomer() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		String requestUrl = this.getIpAndProjectName()+"/erp_get/erp_cus";
		//调用方式  0为远程接口方式，1为多数据源调用方式
		String todoType = Tools.readTxtFile("admin/config/TYPE.txt");
		JSONArray jsonarr = null;
		try {
			if(todoType.equals("0")){
				//执行接口调用
				jsonarr = this.executeInter(requestUrl,"GET");
			}else {
				//多数据源连接，erp数据库
				PageData pd4 = new PageData();
				List<PageData> jsonlist = dataSource2Service.listAll(pd4);  //null换成service查询数据
				jsonarr = JSONArray.fromObject(jsonlist);
			}
			System.out.println(jsonarr.size());
			PageData pd = new PageData();
			//查询本地数据
			List<PageData> varOList = clientService.listAll(pd);  //本地数据
			//新增开关
			int hint = 0; //1为开启，0为关闭
			//删除开关
			int dint = 0; //开1,关0
			//int dstr = 0;
			int count = 0;
			int dcount = 0;
			int ecount = 0;
			PageData pd3 = new PageData();
			if(jsonarr.size() > 0 ){
				for (int i = 0; i < jsonarr.size(); i++) {
					hint = 1;
					JSONObject job = jsonarr.getJSONObject(i);
					if (varOList.size() > 0){
						for (int j = 0; j < varOList.size(); j++) {
							//判断本地数据和erp数据是否已经存在FITEMID
							if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
								//存在即把开关关闭
								hint = 0;
								//判断本地数据和erp的FMODIFYTIME和本地FMODIFYTIME是否相等，如果不相等即进行修改
								if (!varOList.get(j).get("FMODIFYTIME").equals(job.get("FModifyTime").toString())) {
									pd3.put("CLIENT_ID", varOList.get(j).get("CLIENT_ID"));
									pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
									pd3.put("FNAME", job.getString("FName"));
									pd3.put("FNUMBER", job.getString("FNumber"));
									pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
									pd3.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
									pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
									//执行修改（找到对应的service）
									clientService.edit(pd3);
									ecount ++ ;
								}
							}
						}
					}
					//如果上面没有把开关关闭，即执行保存
					if(hint == 1) {
						pd.put("CLIENT_ID", this.get32UUID());
						pd.put("FMODIFYTIME", job.get("FModifyTime").toString());
						pd.put("FNAME", job.getString("FName"));
						pd.put("FNUMBER", job.getString("FNumber"));
						pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
						pd.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
						pd.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
						//执行保存（找到对应的service）
						clientService.save(pd);
						count++;
					}
				}
			}
			//在这里做一次嵌套for循环，必须分开做，反向判断
			PageData pd2 = new PageData();
			if(varOList.size() > 0){
				for (int j = 0; j < varOList.size(); j++) {
					dint = 1;  //初始化开关
					if(jsonarr.size() > 0){
						for (int i = 0; i < jsonarr.size(); i++) {
							JSONObject job = jsonarr.getJSONObject(i);
							if(Integer.parseInt(job.get("FItemID").toString()) == Integer.parseInt(varOList.get(j).get("FITEMID").toString())){
								dint = 0; //erp存在改数据，关闭删除
							}
						}
						//当没有检查到erp存在对应FITEMID的话，关闭删除没有设定，执行删除
						if(dint == 1){
							pd2.put("FITEMID",Integer.parseInt(varOList.get(j).get("FITEMID").toString()));
							clientService.deleteByFITEMID(pd2);
							dcount ++ ;
						}
					}else {
						//逻辑全部删除
					}
				}
			}
			System.out.println("=====数据处理完成=====");
			System.out.println("新增数据"+count);
			System.out.println("修改数据"+ecount);
			System.out.println("删除数据"+dcount);
			json.put("Data", "新增数据"+count+"条；"+"修改数据"+ecount+"条；"+"删除数据"+dcount+"条。");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * ERP系统接口调用
	 * @param url
	 * @param type
	 * @return
	 */
	public JSONArray executeInter(String url,String type){
		JSONArray jsonarr = null;
		try {
			URL httpclient =new URL(url);
			HttpURLConnection conn =(HttpURLConnection) httpclient.openConnection();
			conn.setConnectTimeout(50000);
			conn.setReadTimeout(20000);
			conn.setRequestMethod(type);
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
			jsonarr = jsStr.getJSONArray("Data"); // erp数据
		}catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jsonarr;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
