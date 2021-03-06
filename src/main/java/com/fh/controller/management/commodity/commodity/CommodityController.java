package com.fh.controller.management.commodity.commodity;

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
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.interfaceip.InterfaceIPManager;
import com.fh.util.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.commodity.CommodityManager;
import com.fh.service.management.commoditypic.CommodityPicManager;
import com.fh.service.item.impl.ItemService;

/** 
 * 说明：商品管理
 * 创建人：成
 * 创建时间：2017-12-04
 */
@Controller
@RequestMapping(value="/commodity")
public class CommodityController extends BaseController {
	//图片域名pic_url
	private String pic_qzurl = "http://127.0.0.1:8080/monica";

	String menuUrl = "commodity/list.do"; //菜单地址(权限用)

	@Resource(name="commodityService")
	private CommodityManager commodityService;

	@Resource(name="itemService")
	private ItemService itemService;

	@Resource(name="commoditypicService")
	private CommodityPicManager commoditypicService;

	@Resource(name="interfaceipService")
	private InterfaceIPManager interfaceipService;

	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Commodity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMMODITY_ID", this.get32UUID());	//主键
		commodityService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Commodity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		commodityService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Commodity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData pd1 = new PageData();
		pd = this.getPageData();
		if(pd.getString("MAIN_PIC") != null && pd.getString("COMMODITYPIC_ID") == null && "".equals(pd.getString("COMMODITYPIC_ID"))){
			System.out.println("开始执行主图为null的保存");
			pd1.put("PIC_URL", pd.getString("MAIN_PIC"));
			pd1.put("COMMODITY_ID", pd.getString("COMMODITY_ID"));
			pd1.put("ISMAINPIC", "是");
			pd1.put("COMMODITYPIC_ID", this.get32UUID());
			commoditypicService.save(pd1);
		}else {
			System.out.println("开始执行主图不为null的修改");
			pd1.put("COMMODITYPIC_ID", pd.getString("COMMODITYPIC_ID"));
			pd1.put("PIC_URL", pd.getString("MAIN_PIC"));
			pd1.put("ISMAINPIC","是");
			commoditypicService.edit(pd1);
		}
		commodityService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	//树
	@RequestMapping(value="/listTree")
	public ModelAndView listTree() throws Exception{
		ModelAndView mv = new ModelAndView();
		//mv.addObject("zNodes", jsStr);
		mv.setViewName("commodity/commodity/commodity_tree");
		return mv;
	}

	//树
	@RequestMapping(value="/listTree_select")
	public ModelAndView listTree_select() throws Exception{
		ModelAndView mv = new ModelAndView();
		//mv.addObject("zNodes", jsStr);
		mv.setViewName("management/salesorderbill/commodity_tree_select");
		return mv;
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/toCommodityBy_tree")
	public ModelAndView toCommodityBy_tree(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Commodity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String FPARENTID = pd.getString("fparentid");
		String fnumber = pd.getString("fnumber");				//关键词检索条件
		String fname = pd.getString("fname");
		if(null != FPARENTID && !"".equals(FPARENTID)){
			pd.put("fparentid", FPARENTID);
		}
		if(null != fnumber && !"".equals(fnumber)){
			pd.put("fnumber", fnumber.trim());
		}
		if(null != fname && !"".equals(fname)){
			pd.put("fname", fname.trim());
		}
		page.setPd(pd);
		List<PageData>	tvarList = itemService.tree_dataByid(page);
		for (int i = 0; i < tvarList.size(); i++) {
			pd.put("treeKey",tvarList.get(i).getString("CK"));
		}
		List<PageData>	varList = commodityService.list(page);	//列出Commodity列表
		if(null != FPARENTID && !"".equals(FPARENTID)){
			//pd.put("fparentid", Integer.parseInt(FPARENTID));
			pd.put("fparentid", FPARENTID);
		}
		mv.setViewName("management/salesorderbill/toCommodityBy_tree");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Commodity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String FPARENTID = pd.getString("fparentid");
		String keywords = pd.getString("keywords");				//关键词检索条件
		String keywords1 = pd.getString("keywords1");
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		if(null != FPARENTID && !"".equals(FPARENTID)){
			pd.put("fparentid", FPARENTID);
		}
		if(null != keywords1 && !"".equals(keywords1)){
			pd.put("keywords1", keywords1.trim());
		}
		page.setPd(pd);
		List<PageData>	tvarList = itemService.tree_dataByid(page);
		for (int i = 0; i < tvarList.size(); i++) {
			pd.put("treeKey",tvarList.get(i).getString("CK")); 
		}
		List<PageData>	varList = commodityService.list(page);	//列出Commodity列表
		if(null != FPARENTID && !"".equals(FPARENTID)){
			//pd.put("fparentid", Integer.parseInt(FPARENTID));
			pd.put("fparentid", FPARENTID);
		}
		mv.setViewName("commodity/commodity/commodity_list");
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
		mv.setViewName("commodity/commodity/commodity_edit");
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
		pd = commodityService.findById(pd);	//根据ID读取
		mv.setViewName("commodity/commodity/commodity_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	/**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit_commodity")
	public ModelAndView edit_commodity()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData pd1 = new PageData();
		pd = this.getPageData();
		pd = commodityService.findById(pd);	//根据ID读取
		pd1 = commoditypicService.findByCId(pd);
		mv.setViewName("commodity/commodity/edit_commodity");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		mv.addObject("pd1", pd1);
		return mv;
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Commodity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			commodityService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	@RequestMapping(value = "/findCommoditiesByIds")
	@ResponseBody
	public Map<String,List<PageData>> findCommoditiesByIds() throws Exception{
		Map<String,List<PageData>> resultMap = new HashMap<>();
		PageData pd = this.getPageData();
		String[] ids = pd.getString("FCOMMODITYIDS").split(",");
		List<String> idsList = new ArrayList<>();
		for (int i = 0; i < ids.length; i++) {
			idsList.add(ids[i]);
		}
		String sql = EncapsulationUtil.encapsulateIds(idsList);
		pd.put("sql",sql);
		List<PageData> commoditiesList = commodityService.findCommoditiesByIds(pd);
        for (int i = 0; i < commoditiesList.size(); i++) {
            commoditiesList.get(i).put("FSALESORDERBILLENTRYID",this.get32UUID());
        }
		resultMap.put("commoditiesList",commoditiesList);
		return resultMap;
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Commodity到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("FItemID");	//1
		titles.add("FParentID");	//2
		titles.add("规格");	//3
		titles.add("数量");	//4
		titles.add("库存");	//5
		titles.add("上下架");	//6
		titles.add("商品描述");	//7
		titles.add("商品价格");	//8
		titles.add("优惠折扣");	//9
		titles.add("状态");	//10
		titles.add("商品代码");	//11
		titles.add("商品名称");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = commodityService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("FITEMID").toString());	//1
			vpd.put("var2", varOList.get(i).get("FPARENTID").toString());	//2
			vpd.put("var3", varOList.get(i).getString("FMODEL"));	    //3
			vpd.put("var4", varOList.get(i).get("FQTY").toString());	//4
			vpd.put("var5", varOList.get(i).getString("INVENTORY"));	    //5
			vpd.put("var6", varOList.get(i).getString("ISPUTAWAY"));	    //6
			vpd.put("var7", varOList.get(i).getString("FNOTE"));	    //7
			vpd.put("var8", varOList.get(i).get("PRICE").toString());	//8
			vpd.put("var9", varOList.get(i).get("DISCOUNT").toString());	//9
			vpd.put("var10", varOList.get(i).getString("STATE"));	    //10
			vpd.put("var11", varOList.get(i).getString("FNUMBER"));	    //11
			vpd.put("var12", varOList.get(i).getString("FNAME"));	    //12
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	@RequestMapping(value="/synchronization")
	@ResponseBody
	public Map<String, Object> synchronization(Page page)throws Exception {
		 /*Map<String, Object> json = new HashMap<String, Object>();
		//新增开关
		int hint = 0; //1为开启，即存在相应商品      0为关闭
		int count = 0;
		 //page.setPd(pd);
		PageData pd1 = new PageData();
		pd1 = this.getPageData();
		page.setShowCount(100000);
		 try {
		 	//远程接口数据  todo接口
			List<PageData>	varList = itemService.list(page);
			//获取的本地
			List<PageData> varOList = commodityService.listAll(pd1);
			for (int i = 0; i < varList.size(); i++) {
				hint = 1;
				for (int j = 0; j < varOList.size(); j++) {
					if(varOList.get(j).get("FITEMID").equals(varList.get(i).get("FID"))&&
							varOList.get(j).get("INVENTORY").equals(varList.get(i).get("DFName"))){
						hint = 0;
					}
				}
				if(hint == 1) {
					 PageData pd = new PageData();
					 pd = this.getPageData();
					 pd.put("COMMODITY_ID", this.get32UUID());	//主键
					 pd.put("FITEMID", varList.get(i).get("FID"));
					 pd.put("FPARENTID", varList.get(i).get("PID"));
					 pd.put("FMODEL", varList.get(i).get("AFModel"));
					 pd.put("FQTY", varList.get(i).get("CFQty"));
					 pd.put("INVENTORY", varList.get(i).get("DFName"));
					 pd.put("ISPUTAWAY", "未上架");
					 pd.put("PRICE", 0);
					 pd.put("DISCOUNT", 0);
					 pd.put("STATE", "普通商品");
					 pd.put("FNUMBER", varList.get(i).get("AFNumber"));
					 pd.put("FNAME",varList.get(i).get("AFName"));
					 commodityService.save(pd);
					 count ++ ;
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		 json.put("success", "success");
		 System.out.println(count);
		 return json ;*/
		Map<String, Object> json = new HashMap<String, Object>();
		String requestUrl = this.getIpAndProjectName()+"/erp_get/erp_cus";
		//调用方式  0为远程接口方式，1为多数据源调用方式
		String todoType = Tools.readTxtFile("admin/config/TYPE.txt");
		JSONArray jsonarr = null;
		//System.out.println(DateUtil.getDateTimeStr());
		try {
			PageData pd = new PageData();
			if(todoType.equals("0")){
				//执行接口调用
				jsonarr = this.executeInter(requestUrl,"GET");
			}else {
				//多数据源连接，erp数据库
				List<PageData> jsonlist = itemService.listClient(pd);  //null换成service查询数据
				jsonarr = JSONArray.fromObject(jsonlist);
			}
			//查询本地数据
			List<PageData> varOList = commodityService.listAll(pd);  //本地数据
			//新增开关
			int hint = 0; //1为开启，0为关闭
			//删除开关
			int dint = 0; //开1,关0
			//int dstr = 0;
			int count = 0;
			int dcount = 0;
			int ecount = 0;
			StringBuffer strbuf = new StringBuffer();
			JSONObject job = null;
			PageData pd3 = new PageData();
			List<PageData> strlist = new ArrayList<PageData>();
			if(jsonarr.size() > 0 ){
				int num = 100; //设置每次100条
				int remainder = jsonarr.size() % num;  //取到余数
				int numcount = jsonarr.size() / num;  //次数
				for (int x = 0; x < numcount; x++) {
					strlist.clear();
					for (int i = num * x; i < num * (x + 1); i++) {
						hint = 1;
						job = jsonarr.getJSONObject(i);
						if (varOList.size() > 0){
							for (int j = 0; j < varOList.size(); j++) {
								//判断本地数据和erp数据是否已经存在FITEMID
								if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
									//存在即把开关关闭
									hint = 0;
									//判断本地数据和erp的FMODIFYTIME和本地FMODIFYTIME是否相等，如果不相等即进行修改
									if (!varOList.get(j).get("FMODIFYTIME").equals(job.get("FModifyTime").toString())) {
										/*PageData pd = new PageData();
										pd = this.getPageData();
										pd.put("COMMODITY_ID", this.get32UUID());	//主键
										pd.put("FITEMID", varList.get(i).get("FID"));
										pd.put("FPARENTID", varList.get(i).get("PID"));
										pd.put("FMODEL", varList.get(i).get("AFModel"));
										pd.put("FQTY", varList.get(i).get("CFQty"));
										pd.put("INVENTORY", varList.get(i).get("DFName"));
										pd.put("ISPUTAWAY", "未上架");
										pd.put("PRICE", 0);
										pd.put("DISCOUNT", 0);
										pd.put("STATE", "普通商品");
										pd.put("FNUMBER", varList.get(i).get("AFNumber"));
										pd.put("FNAME",varList.get(i).get("AFName"));*/
										pd3.put("", varOList.get(j).get(""));
										pd3.put("", job.get("").toString());
										pd3.put("", job.getString(""));
										pd3.put("", job.getString(""));
										pd3.put("", Integer.parseInt(job.get("").toString()));
										pd3.put("", Integer.parseInt(job.get("").toString()));
										pd3.put("", Integer.parseInt(job.get("").toString()));
										//执行修改（找到对应的service）
										commodityService.edit(pd3);
										ecount ++ ;
									}
								}
							}
						}
						//如果上面没有把开关关闭，即执行保存
						if(hint == 1) {
							PageData pdCus = new PageData();
							pdCus.put("CLIENT_ID", this.get32UUID());
							pdCus.put("FMODIFYTIME", job.get("FModifyTime").toString());
							pdCus.put("FNAME", job.getString("FName"));
							pdCus.put("FNUMBER", job.getString("FNumber"));
							pdCus.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
							pdCus.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
							pdCus.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
							strlist.add(pdCus);
							count++;
						}
					}
					//System.out.println(strlist);
					if(strlist.size() > 0){
						//commodityService.saveByList(strlist);
					}
				}
				strlist.clear();
				for (int i = (jsonarr.size() - remainder); i < jsonarr.size(); i++) {
					hint = 1;
					job = jsonarr.getJSONObject(i);
					if (varOList.size() > 0){
						for (int j = 0; j < varOList.size(); j++) {
							//判断本地数据和erp数据是否已经存在FITEMID
							if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
								//存在即把开关关闭
								hint = 0;
								//判断本地数据和erp的FMODIFYTIME和本地FMODIFYTIME是否相等，如果不相等即进行修改
								if (!varOList.get(j).get("FMODIFYTIME").equals(job.get("FModifyTime").toString())) {
									pd3.put("COMMODITY_ID", varOList.get(j).get("COMMODITY_ID"));
									pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
									pd3.put("FNAME", job.getString("FName"));
									pd3.put("FNUMBER", job.getString("FNumber"));
									pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
									pd3.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
									pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
									//执行修改（找到对应的service）
									commodityService.edit(pd3);
									ecount ++ ;
								}
							}
						}
					}
					//如果上面没有把开关关闭，即执行保存
					if(hint == 1) {
						PageData pdCus = new PageData();
						pdCus.put("COMMODITY_ID", this.get32UUID());
						pdCus.put("FMODIFYTIME", job.get("FModifyTime").toString());
						pdCus.put("FNAME", job.getString("FName"));
						pdCus.put("FNUMBER", job.getString("FNumber"));
						pdCus.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
						pdCus.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
						pdCus.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
						strlist.add(pdCus);
						count++;
					}
				}
				//System.out.println(strlist);
				if(strlist.size() > 0){
					//commodityService.saveByList(strlist);
				}
			}
			//在这里做一次嵌套for循环，必须分开做，反向判断
			PageData pd2 = new PageData();
			if(varOList.size() > 0){
				for (int j = 0; j < varOList.size(); j++) {
					dint = 1;  //初始化开关
					if(jsonarr.size() > 0){
						for (int i = 0; i < jsonarr.size(); i++) {
							job = jsonarr.getJSONObject(i);
							if(Integer.parseInt(job.get("FItemID").toString()) == Integer.parseInt(varOList.get(j).get("FITEMID").toString())){
								dint = 0; //erp存在改数据，关闭删除
							}
						}
						//当没有检查到erp存在对应FITEMID的话，关闭删除没有设定，执行删除
						if(dint == 1){
							pd2.put("FITEMID",Integer.parseInt(varOList.get(j).get("FITEMID").toString()));
							//commodityService.deleteByFITEMID(pd2);
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
			//System.out.println(DateUtil.getDateTimeStr());
			System.gc();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;

	}
	
	@RequestMapping(value="/toUpdatePic")
	public ModelAndView toUpdatePic()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("commodity/commodity/toUpdatePic");
		/*mv.addObject("msg", "save");*/
		/*mv.addObject("pd", pd);*/
		return mv;
	}
	
	@RequestMapping(value = "/toPreview", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView toPreview(@RequestParam("cid") String cid) throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("commodity/commodity/preview");
		PageData pd1 = new PageData();
		pd1.put("COMMODITY_ID", cid);
		pd1 = commoditypicService.findByCId(pd1);
		mv.addObject("pd1", pd1);
		mv.addObject("pic_qzurl", pic_qzurl);
		return mv;
	}

	public String getIpAndProjectName()throws Exception{
		String ip = null;
		String projectName = null;
		PageData pd = new PageData();
		pd = interfaceipService.findByNew(pd);
		ip = pd.getString("IP");
		projectName = pd.getString("PROJECTNAME");
		return ip+"/"+projectName;
	}

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

}
