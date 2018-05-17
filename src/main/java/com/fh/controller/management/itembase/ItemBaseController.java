package com.fh.controller.management.itembase;

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
import com.fh.service.management.itembase.ItemBaseManager;

/** 
 * 说明：物料管理
 * 创建人：成
 * 创建时间：2018-01-25
 */
@Controller
@RequestMapping(value="/itembase")
public class ItemBaseController extends BaseController {
	
	String menuUrl = "itembase/list.do"; //菜单地址(权限用)
	@Resource(name="itembaseService")
	private ItemBaseManager itembaseService;

	@Resource(name="interfaceipService")
	private InterfaceIPManager interfaceipService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增ItemBase");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ITEMBASE_ID", this.get32UUID());	//主键
		itembaseService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除ItemBase");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		itembaseService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ItemBase");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		itembaseService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表ItemBase");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String treeName = pd.getString("treeName");				//关键词检索条件
		if(null != treeName && !"".equals(treeName)){
			pd.put("treeName", treeName.trim());
		}
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		String treeKey = pd.getString("treeKey");				//关键词检索条件
		if(null != treeKey && !"".equals(treeKey)){
			pd.put("treeKey", treeKey.trim());
		}
		page.setPd(pd);
		//List<PageData>	varList = itembaseService.list(page);	//列出ItemBase列表
		List<PageData>	varList = itembaseService.listPageAll(page);
		mv.setViewName("management/itembase/itembase_list");
		mv.addObject("varList", varList);
		mv.addObject("treeKey", treeKey);
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
		mv.setViewName("management/itembase/itembase_edit");
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
		pd = itembaseService.findById(pd);	//根据ID读取
		mv.setViewName("management/itembase/itembase_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ItemBase");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			itembaseService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出ItemBase到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("商品代码");	//1
		titles.add("商品名称");	//2
		titles.add("规格型号");	//3
		titles.add("基本单位");	//4
		titles.add("销售单位");	//5
		titles.add("采购单位");	//6
		titles.add("采购单价");	//7
		titles.add("销售单价");	//8
		titles.add("商品ID");	//9
		titles.add("父项ID");	//10
		titles.add("基本单位ID");	//11
		titles.add("销售单位ID");	//12
		titles.add("采购单位ID");	//13
		dataMap.put("titles", titles);
		List<PageData> varOList = itembaseService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("FNUMBER"));	    //1
			vpd.put("var2", varOList.get(i).getString("FNAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("FMODEL"));	    //3
			vpd.put("var4", varOList.get(i).getString("FBASICUNIT"));	    //4
			vpd.put("var5", varOList.get(i).getString("FSALEUNIT"));	    //5
			vpd.put("var6", varOList.get(i).getString("FORDERUNIT"));	    //6
			vpd.put("var7", varOList.get(i).get("FORDERPRICE").toString());	//7
			vpd.put("var8", varOList.get(i).get("FSALEPRICE").toString());	//8
			vpd.put("var9", varOList.get(i).get("FITEMID").toString());	//9
			vpd.put("var10", varOList.get(i).get("FPARENTID").toString());	//10
			vpd.put("var11", varOList.get(i).get("FUNITID").toString());	//11
			vpd.put("var12", varOList.get(i).get("FSALEUNITID").toString());	//12
			vpd.put("var13", varOList.get(i).get("FORDERUNITID").toString());	//13
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

	@RequestMapping(value="/getItembase")
	@ResponseBody
	public  Map<String, Object> test() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		String requestUrl = this.getIpAndProjectName()+"/test_Get/erp_item";
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
           // System.out.println(jsStr.getJSONArray("Data"));
            JSONArray jsonarr = jsStr.getJSONArray("Data"); // erp数据
            PageData pd = new PageData();
            List<PageData>	varOList = itembaseService.listAll(pd); // 本地数据
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
							//System.out.println("修改"+ job.getString("FName"));
							pd3.put("ITEMBASE_ID", varOList.get(j).get("ITEMBASE_ID"));
							pd3.put("FBASICUNIT", job.getString("FBasicUnit"));
							pd3.put("FORDERUNIT", job.getString("FOrderUnit"));
							pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
							pd3.put("FORDERUNITID", Integer.parseInt(job.get("FOrderUnitID").toString()));
							pd3.put("FSALEPRICE", job.get("FSalePrice"));
							pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
							pd3.put("FNAME", job.getString("FName"));
							pd3.put("FMODEL", job.getString("FModel"));
							pd3.put("FUNITID", Integer.parseInt(job.get("FUnitID").toString()));
							pd3.put("FSALEUNITID", Integer.parseInt(job.get("FSaleUnitID").toString()));
							pd3.put("FORDERPRICE", job.get("FOrderPrice"));
							pd3.put("FNUMBER", job.getString("FNumber"));
							pd3.put("FSALEUNIT", job.getString("FSaleUnit"));
							pd3.put("FMODIFYTIME",job.get("FModifyTime").toString());
							itembaseService.edit(pd3);
							ecount ++ ;
						}
    				}
    			}
    			if(hint == 1) {
	            	//System.out.println(job.getString("FBasicUnit"));
	            	pd.put("ITEMBASE_ID", this.get32UUID());
	            	pd.put("FBASICUNIT", job.getString("FBasicUnit"));
	            	pd.put("FORDERUNIT", job.getString("FOrderUnit"));
	            	pd.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
	            	pd.put("FORDERUNITID", Integer.parseInt(job.get("FOrderUnitID").toString()));
	            	pd.put("FSALEPRICE", job.get("FSalePrice"));
	            	pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
	            	pd.put("FNAME", job.getString("FName"));
	            	pd.put("FMODEL", job.getString("FModel"));
	            	pd.put("FUNITID", Integer.parseInt(job.get("FUnitID").toString()));
	            	pd.put("FSALEUNITID", Integer.parseInt(job.get("FSaleUnitID").toString()));
	            	pd.put("FORDERPRICE", job.get("FOrderPrice"));
	            	pd.put("FNUMBER", job.getString("FNumber"));
	            	pd.put("FSALEUNIT", job.getString("FSaleUnit"));
	            	pd.put("FMODIFYTIME",job.get("FModifyTime").toString());
	            	//System.out.println(pd);
	            	itembaseService.save(pd);
	            	count++;
    			}
			}
            
            for (int j = 0; j < varOList.size(); j++) {
    			for (int i = 0; i < jsonarr.size(); i++) {
    				JSONObject job = jsonarr.getJSONObject(i);
    				if(Integer.parseInt(job.get("FItemID").toString()) == (int)varOList.get(j).get("FITEMID")){
    					dint = 1; //存在
    				}
    			}
    			if(dint == 0){
    				PageData pd2 = new PageData();
    				pd2.put("FITEMID",(int)varOList.get(j).get("FITEMID"));
    				itembaseService.deleteByFITEMID(pd2);
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
	
}
