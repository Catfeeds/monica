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

	@Resource(name="interfaceipService")
	private InterfaceIPManager interfaceipService;

	//微信js调用
	@RequestMapping(value = "/testEwm")
	public ModelAndView testEwm(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		String nonceStr = UUID.randomUUID().toString(); // 必填，生成签名的随机串
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.localhostAgentSecret).getToken();
		String jsapi_ticket =WeiXinUtil.getJsapiTicket(accessToken);// 必填，生成签名的H5应用调用企业微信JS接口的临时票据
		String timestamp = Long.toString(System.currentTimeMillis() / 1000); // 必填，生成签名的时间戳
		String url = "http://jittest.s1.natapp.cc/monica/http/testEwm";
		//字典序，注意这里参数名必须全部小写，且必须有序
		String sign = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + nonceStr+ "&timestamp=" + timestamp + "&url=" + url;
		System.out.println(sign);
		//sha1签名
		String signature = "";
		try {
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(sign.getBytes("UTF-8"));
			signature = WeiXinUtil.byteToHex(crypt.digest());
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


	
	/*@Resource(name="salesorderbillService")
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
		List<PageData> synEntryList = salesorderbillentryService.list_salesOrderEntry(page);
		return json;
	}*/
	
}
