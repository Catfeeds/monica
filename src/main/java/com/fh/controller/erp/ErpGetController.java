package com.fh.controller.erp;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.item.impl.ItemService;
import com.fh.service.management.erp_dep.ERP_DepManager;
import com.fh.service.management.interfaceip.InterfaceIPManager;
import com.fh.service.management.salesorderbill.SalesOrderBillManager;
import com.fh.service.management.salesorderbillentry.SalesOrderBillEntryManager;
import com.fh.service.management.synchronization.impl.SynSupplierService;
import com.fh.util.PageData;


@Controller
@RequestMapping(value="/erp_Get")
public class ErpGetController extends BaseController{
	
	@Resource(name="erp_depService")
	private ERP_DepManager erp_depService;
	
	@Resource(name="itemService")
	ItemService itemService;
	
	@Resource(name="synSupplierService")
	private SynSupplierService synSupplierService;
	
	@Resource(name="salesorderbillService")
	private SalesOrderBillManager salesorderbillService;
	
	@Resource(name="salesorderbillentryService")
	private SalesOrderBillEntryManager salesorderbillentryService;
	
	@Resource(name="interfaceipService")
	private InterfaceIPManager interfaceipService;
	
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

	@RequestMapping(value="/load")
	@ResponseBody
	public Map<String, Object> load(Page page)throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		ArrayList<String> dataOfMonth = new ArrayList<String>();
		for (int i = 1; i < 13; i++) {
			if (i<10){
				pd.put("FDATE","2018-0"+i);
			}else {
				pd.put("FDATE","2018-"+i);
			}
			page.setPd(pd);
			pd = itemService.list_OrderCount(page);
			dataOfMonth.add(pd.get("count").toString());
		}
		ArrayList<String> dataOfMonthWithStatus = new ArrayList<String>();
		for (int i = 1; i < 13; i++) {
			if (i<10){
				pd.put("FDATE","2018-0"+i);
			}else {
				pd.put("FDATE","2018-"+i);
			}
			pd.put("FSTATUS",1);
			page.setPd(pd);
			pd = itemService.list_OrderCount(page);
			dataOfMonthWithStatus.add(pd.get("count").toString());
		}
		//System.out.println(dataOfMonth);
		json.put("data2",dataOfMonthWithStatus);
		json.put("data1", dataOfMonth);
		return json ;
	}

	@RequestMapping(value="/loadforClient")
	@ResponseBody
	public Map<String, Object> loadforClient(Page page)throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month =cal.get(Calendar.MONTH)+1;
		String monthstr = "";
		if (pd.getString("month") != null && !"".equals(pd.getString("month"))){
			monthstr = pd.getString("month").toString();
		}else {
			if (month<10) {
				monthstr = "0"+ month;
			}else{
				monthstr =  ""+month;
			}
		}
		String datestr = year+"-" + monthstr;
		System.out.println(datestr);
		if (pd.get("FDATE") == null || "".equals(pd.get("FDATE"))){
			pd.put("FDATE",datestr);
		}
		page.setPd(pd);
		List<PageData> list = itemService.list_ClientOrderCount(page);
		ArrayList<String> dataOfClient = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			dataOfClient.add(list.get(i).getString("name"));
		}
		System.out.println(list);
		json.put("data", list);
		json.put("dataOfClient", dataOfClient);
		return json ;
	}

	@RequestMapping(value="/getClient")
	@ResponseBody
	public  Map<String, Object> getClient(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		List<PageData>	varList  =itemService.listClient(page);
		System.out.println("---------"+varList);
		json.put("Data", varList);
		return json;
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
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/setSalesOrder")
	@ResponseBody
	public  Map<String, Object> setSalesOrder(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String requestUrl = this.getIpAndProjectName()+"/http/test_getSalesorderbill";
		//String requestUrl ="http://192.168.1.187:8080/ssww/http/test_getSalesorderbill";
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
            //System.out.println(jsStr.getJSONArray("Data"));
            JSONArray jsonarr = jsStr.getJSONArray("Data"); // erp数据
            JSONArray synEntryJsonarr = jsStr.getJSONArray("synEntryList"); // erp数据
            //System.out.println("----------"+synEntryJsonarr);
            List<PageData>	varOList = itemService.listAllSalesOrder(page);  //erp销售订单表临时数据
            List<PageData>	varEntryList = itemService.listAllSalesOrderEntry(page); //erp销售订单详细表临时数据
            //新增开关
    		int hint = 0; //0为开启，1为关闭
    		//删除开关
    		int dint = 0; //开0,关1
    		//int dstr = 0;
    		int count = 0;
    		int dcount = 0;
    		int ecount = 0;
    		SimpleDateFormat sdf =   new SimpleDateFormat("MMM d, yyyy K:m:s a",Locale.ENGLISH);
    		PageData pd3 = new PageData();
            for (int i = 0; i < jsonarr.size(); i++) {
            	hint = 1;
            	JSONObject job = jsonarr.getJSONObject(i);
    			for (int j = 0; j < varOList.size(); j++) {
    				if(varOList.get(j).get("SALESORDERBILL_ID").equals(job.get("SALESORDERBILL_ID"))){
    					hint = 0;
    				}
    			}
    			if(hint == 1) {
	            	//System.out.println(job.getString("FBasicUnit"));
	            	pd.put("SALESORDERBILL_ID",job.get("SALESORDERBILL_ID"));
	            	pd.put("FSYNSTATUS", 0);
	            	pd.put("FSTATUS", Integer.parseInt(job.get("FSTATUS").toString()));
	            	pd.put("FTEMPID", job.getString("FTEMPID"));
					pd.put("CLIENT_ID", Integer.parseInt(job.get("CLIENT_ID").toString()));
					pd.put("FCustID", Integer.parseInt(job.get("CLIENT_ID").toString()));
	            	pd.put("FBILLNO", job.getString("FBILLNO"));
	            	pd.put("FDEPTID", Integer.parseInt(job.get("FDEPTID").toString()));
	            	System.out.println(job.get("FDATE").toString());
	            	pd.put("FDATE", sdf.parse( job.get("FDATE").toString()));
	            	itemService.save_salesOrder(pd);
	            	count++;
    			}
			}
            
            for (int i = 0; i < synEntryJsonarr.size(); i++) {
            	hint = 1;
            	JSONObject job = synEntryJsonarr.getJSONObject(i);
    			for (int j = 0; j < varEntryList.size(); j++) {
    				if(varEntryList.get(j).get("SALESORDERBILLENTRY_ID").equals(job.get("SALESORDERBILLENTRY_ID"))){
    					hint = 0;
    				}
    			}
    			if(hint == 1) {
	            	//System.out.println(job.getString("FBasicUnit"));
	            	pd.put("SALESORDERBILLENTRY_ID",job.getString("SALESORDERBILLENTRY_ID"));
					if (job.get("FENTRYID") != null && !"".equals(job.get("FENTRYID"))){
						pd.put("FENTRYID", Integer.parseInt(job.get("FENTRYID").toString()));
					}
	            	pd.put("FAUXQTY", Double.parseDouble(job.get("FAUXQTY").toString()));
	            	pd.put("SALESORDERBILL_ID", job.getString("SALESORDERBILL_ID"));
	            	pd.put("FITEMID", Integer.parseInt(job.get("FITEMID").toString()));
	            	itemService.save_salesOrderEntry(pd);
	            	ecount++;
    			}
			}
            System.out.println("SALESORDERBILL表新增数据"+count);
            System.out.println("TB_SALESORDERBILLENTRY表新增数据"+ecount);
            //System.out.println(jsonarr);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
		json.put("res","1");
		return json;
	}
	
}
