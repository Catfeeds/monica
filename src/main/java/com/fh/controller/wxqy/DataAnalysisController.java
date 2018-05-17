package com.fh.controller.wxqy;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.item.impl.ItemService;
import com.fh.service.management.interfaceip.InterfaceIPManager;
import com.fh.service.management.salesorderbill.SalesOrderBillManager;
import com.fh.service.wxqy.newforwx.NewForWxManager;
import com.fh.util.PageData;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.*;


@Controller
@RequestMapping(value="/dataAnalysis")
public class DataAnalysisController extends BaseController{

	@Resource(name="salesorderbillService")
	private SalesOrderBillManager salesorderbillService;

	//图片域名pic_url
	private String pic_url = "http://jittest.s1.natapp.cc/ssww";

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

	@RequestMapping(value="/toLoadAnalysis")
	public ModelAndView toLoadAnalysis(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		mv.setViewName("wxqy/dataAnalysis/toLoadAnalysis");
		return mv;
	}
	@RequestMapping(value="/load")
	@ResponseBody
	public Map<String, Object> load(Page page)throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		String requestUrl = this.getIpAndProjectName()+"/erp_Get/load";
		//String requestUrl = "http://127.0.0.1:8080/ssww"+"/test_Get/getClient";
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
			JSONArray jsonarr2 = jsStr.getJSONArray("data2"); // erp数据
			JSONArray jsonarr1 = jsStr.getJSONArray("data1"); // erp数据
			json.put("data2",jsonarr2);
			json.put("data1",jsonarr1);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return json;
	}

	@RequestMapping(value="/loadforClient")
	@ResponseBody
	public Map<String, Object> loadforClient(Page page)throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		//String requestUrl = this.getIpAndProjectName()+"/erp_Get/loadforClient?month="+pd.get("month");
		//System.out.println("========>"+requestUrl);
		String requestUrl = this.getIpAndProjectName()+"/erp_Get/loadforClient";
		if(pd.get("month") != null && !"".equals(pd.get("month"))){
			requestUrl = this.getIpAndProjectName()+"/erp_Get/loadforClient?month="+pd.get("month");
		}
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
			JSONArray jsonData1 = jsStr.getJSONArray("data"); // erp数据
			JSONArray jsonarrdataOfClient = jsStr.getJSONArray("dataOfClient"); // erp数据
			json.put("jsonData1",jsonData1);
			json.put("jsonarrdataOfClient",jsonarrdataOfClient);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json ;
	}
}
