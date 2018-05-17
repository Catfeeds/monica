package com.fh.controller.test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.classify_item.Classify_itemManager;
import com.fh.service.management.client.ClientManager;
import com.fh.service.management.erp_dep.ERP_DepManager;
import com.fh.service.management.interfaceip.InterfaceIPManager;
import com.fh.service.management.itembase.ItemBaseManager;
import com.fh.service.management.salesorderbill.SalesOrderBillManager;
import com.fh.service.management.salesorderbillentry.SalesOrderBillEntryManager;
import com.fh.service.management.supplier.impl.SupplierService;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;


@Controller
@RequestMapping(value="/http")
public class TestHttpController extends BaseController{
	private static Logger log = LoggerFactory.getLogger(TestHttpController.class);
	@Resource(name="itembaseService")
	private ItemBaseManager itembaseService;
	
	@Resource(name="classify_itemService")
	private Classify_itemManager classify_itemService;
	
	@Resource(name="supplierService")
	private SupplierService supplierService;
	
	@Resource(name="erp_depService")
	private ERP_DepManager erp_depService;
	
	@Resource(name="clientService")
	private ClientManager clientService;
	
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

	//微信js调用
	@RequestMapping(value = "/testEwm")
	public ModelAndView testEwm(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		String nonceStr = UUID.randomUUID().toString(); // 必填，生成签名的随机串
		//System.out.println("nonceStr:"+nonceStr);
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.localhostAgentSecret).getToken();
		String jsapi_ticket =WeiXinUtil.getJsapiTicket(accessToken);// 必填，生成签名的H5应用调用企业微信JS接口的临时票据
		//System.out.println("jsapi_ticket:"+jsapi_ticket);
		String timestamp = Long.toString(System.currentTimeMillis() / 1000); // 必填，生成签名的时间戳
		//System.out.println("timestamp:"+timestamp);
		//String url=request.getRequestURL().toString();
		String url = "http://jittest.s1.natapp.cc/ssww/http/testEwm";
		//System.out.println("url:"+url);

		//2.字典序           ，注意这里参数名必须全部小写，且必须有序
		String sign = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + nonceStr+ "&timestamp=" + timestamp + "&url=" + url;
		System.out.println(sign);
		//3.sha1签名
		String signature = "";
		try {
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(sign.getBytes("UTF-8"));
			signature = WeiXinUtil.byteToHex(crypt.digest());
			//System.out.println("signature:"+signature);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		mv.addObject("timestamp", timestamp);
		mv.addObject("signature", signature);
		mv.addObject("nonceStr", nonceStr);
		mv.setViewName("test/testEwm");
		return mv;
	}

	@RequestMapping(value="/getItembase")
	//@Test
	public void test() throws Exception{
		String requestUrl = "http://lkl.natapp1.cc/ssww/test/search";
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
            System.out.println(jsStr.getJSONArray("Data"));
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
            for (int i = 0; i < jsonarr.size(); i++) {
            	hint = 1;
            	JSONObject job = jsonarr.getJSONObject(i);
    			for (int j = 0; j < varOList.size(); j++) {
    				if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
    					hint = 0;
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
            System.out.println("删除数据"+dcount);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } 
	}
	
	@RequestMapping(value="/getClassify_item")
	//@Test
	public void getClassify_item() throws Exception{
		String requestUrl = "http://lkl.natapp1.cc/ssww/test/food";
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
            System.out.println(jsStr.getJSONArray("Data"));
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
            for (int i = 0; i < jsonarr.size(); i++) {
            	hint = 1;
            	JSONObject job = jsonarr.getJSONObject(i);
    			for (int j = 0; j < varOList.size(); j++) {
    				if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
    					hint = 0;
    				}
    			}
    			if(hint == 1) {
	            	//System.out.println(job.getString("FBasicUnit"));
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
    				if(Integer.parseInt(job.get("FItemID").toString()) == (int)varOList.get(j).get("FITEMID")){
    					dint = 1; //存在
    				}
    			}
    			if(dint == 0){
    				PageData pd2 = new PageData();
    				pd2.put("FITEMID",(int)varOList.get(j).get("FITEMID"));
    				classify_itemService.deleteByFITEMID(pd2);
    				dcount ++ ;
    			}
    			dint = 0;
    		}
            System.out.println("完成");
            System.out.println("新增数据"+count);
            System.out.println("删除数据"+dcount);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } 
		
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/getCommodity")
	//@Test
	public ModelAndView getCommodity() throws Exception{
		String requestUrl = "http://lkl.natapp1.cc/ssww/test/stockfood?test="+"123";
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
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
            System.out.println(jsStr.getJSONArray("Data"));
            JSONArray jsonarr = jsStr.getJSONArray("Data"); // erp数据
            
            List<PageData> varList = (List<PageData>)jsonarr;
            mv.addObject("varList", varList);
            
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } 
		
		mv.setViewName("item/icinventory");
		mv.addObject("pd", pd);
		//mv.addObject("pd", pd);
		return mv;
	}
	
	
	@RequestMapping(value="/getERPDep_item")
	//@Test
	public void getERPDep_item() throws Exception{
		String requestUrl = this.getIpAndProjectName()+"/test_Get/erp_dep?test=123";
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
            System.out.println(jsStr.getJSONArray("Data"));
            JSONArray jsonarr = jsStr.getJSONArray("Data"); // erp数据
            PageData pd = new PageData();
           List<PageData>	varOList = erp_depService.listAll(pd); // 本地数据
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
							System.out.println("修改"+ job.getString("FName"));
							pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
							pd3.put("ERP_DEP_ID", varOList.get(j).get("ERP_DEP_ID"));
							pd3.put("FNAME", job.getString("FName"));
							pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
							pd3.put("FNUMBER", job.getString("FNumber"));
							pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
							pd3.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
							erp_depService.edit(pd3);
							ecount ++ ;
						}
    				}
    			}
    			if(hint == 1) {
	            	//System.out.println(job.getString("FBasicUnit"));
	            	pd.put("ERP_DEP_ID", this.get32UUID());
	            	pd.put("FNAME", job.getString("FName"));
	            	pd.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
	            	pd.put("FNUMBER", job.getString("FNumber"));
	            	pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
	            	pd.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
	            	pd.put("FMODIFYTIME",job.get("FModifyTime").toString());
	            	erp_depService.save(pd);
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
    				erp_depService.deleteByFITEMID(pd2);
    				dcount ++ ;
    			}
    			dint = 0;
    		}
            System.out.println("完成");
            System.out.println("新增数据"+count);
            System.out.println("修改数据"+ecount);
            System.out.println("删除数据"+dcount);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } 
		
	}
	
	@RequestMapping(value="/getSupplier")
	@ResponseBody
	public  Map<String, Object> getSupplier() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		String requestUrl = this.getIpAndProjectName()+"/test_Get/erp_supplier?test=123";
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
            System.out.println(jsStr.getJSONArray("Data"));
            JSONArray jsonarr = jsStr.getJSONArray("Data"); // erp数据
           // System.out.println(jsonarr);
            PageData pd = new PageData();
           //List<PageData>	varOList = erp_depService.listAll(pd); // 本地数据
            List<PageData>	varOList =supplierService.listAll(pd);  //本地数据
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
    						
							pd3.put("SUPPLIER_ID", varOList.get(j).get("SUPPLIER_ID"));
							pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
							pd3.put("FNAME", job.getString("FName"));
							try {
								pd3.put("FADDRESS", job.getString("FAddress"));
							} catch (Exception e) {
								// TODO: handle exception
							}
							try {
								pd3.put("FTELEPHONE", job.getString("FPhone"));
							} catch (Exception e) {
								// TODO: handle exception
							}
							try {
								pd3.put("FCONTACT", job.getString("FContact"));
							} catch (Exception e) {
								// TODO: handle exception
							}
							pd3.put("FNUMBER", job.getString("FNumber"));
							pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
							//pd3.put("FCONTACT", job.getString("FContact"));
							//pd3.put("FTELEPHONE", job.getString("FPhone"));
							supplierService.edit(pd3);
							ecount ++ ;
						}
    				}
    			}
    			if(hint == 1) {
	            	//System.out.println(job.getString("FBasicUnit"));
	            	pd.put("SUPPLIER_ID", this.get32UUID());
	            	pd.put("FMODIFYTIME", job.get("FModifyTime").toString());
	            	pd.put("FNAME", job.getString("FName"));
	            	try {
	            		pd.put("FADDRESS", Integer.parseInt(job.get("FAddress").toString()));
					} catch (Exception e) {
						// TODO: handle exception
					}
	            	try {
	            		pd.put("FCONTACT", job.get("FContact").toString());
					} catch (Exception e) {
						// TODO: handle exception
					}
	            	try {
	            		pd.put("FTELEPHONE", job.get("FPhone").toString());
					} catch (Exception e) {
						// TODO: handle exception
					}
	            	pd.put("FNUMBER", job.getString("FNumber"));
	            	pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
	            	supplierService.save(pd);
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
    				supplierService.deleteByFITEMID(pd2);
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
	
	@RequestMapping(value="/getClient")
	@ResponseBody
	public  Map<String, Object> getClient() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		String requestUrl = this.getIpAndProjectName()+"/test_Get/getClient";
		//String requestUrl = "http://127.0.0.1:8080/ssww"+"/test_Get/getClient";
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
            System.out.println(jsStr.getJSONArray("Data"));
            JSONArray jsonarr = jsStr.getJSONArray("Data"); // erp数据
            //System.out.println(jsonarr);
            PageData pd = new PageData();
            List<PageData>	varOList =clientService.listAll(pd);  //本地数据
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
							pd3.put("CLIENT_ID", varOList.get(j).get("CLIENT_ID"));
							pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
							pd3.put("FNAME", job.getString("FName"));
							pd3.put("FNUMBER", job.getString("FNumber"));
							pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
							pd3.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
			            	pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
			            	clientService.edit(pd3);
							ecount ++ ;
						}
    				}
    			}
    			if(hint == 1) {
	            	//System.out.println(job.getString("FBasicUnit"));
	            	pd.put("CLIENT_ID", this.get32UUID());
	            	pd.put("FMODIFYTIME", job.get("FModifyTime").toString());
	            	pd.put("FNAME", job.getString("FName"));
	            	pd.put("FNUMBER", job.getString("FNumber"));
	            	pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
	            	pd.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
	            	pd.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
	            	clientService.save(pd);
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
    				clientService.deleteByFITEMID(pd2);
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
	
	@Resource(name="salesorderbillService")
	private SalesOrderBillManager salesorderbillService;
	
	@Resource(name="salesorderbillentryService")
	private SalesOrderBillEntryManager salesorderbillentryService;
	
	@RequestMapping(value="/test_getSalesorderbill")
	@ResponseBody
	public  Map<String, Object> test_get() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		page.setPd(pd);
		List<PageData> synList = salesorderbillService.listNotSyn(page);
		List<PageData> synEntryList = salesorderbillentryService.list_salesOrderEntry(page);
		json.put("Data", synList);
		json.put("synEntryList", synEntryList);
		for (PageData pageData : synList) {
			pageData.put("FSYNSTATUS",1);
			salesorderbillService.edit(pageData);
		}
		return json;
	}
	
}
