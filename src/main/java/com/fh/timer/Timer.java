package com.fh.timer;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import sun.tools.tree.ThisExpression;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.util.UuidUtil;

public class Timer {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public void context() throws Exception{
    	System.out.println("定时器加载成功!!!");
		PageData pd = new PageData();
		pd = (PageData)dao.findForObject("InterfaceIPMapper.findByNew", pd);
		final String ip = pd.getString("IP");
		final String projectName = pd.getString("PROJECTNAME");
		
         /**  
         * 设置一个定时器  
         */    
        //final long timeInterval = 1000*60*12;
		final long timeInterval = 1000*10;
		Runnable runnable = new Runnable() {
			public void run() {  
				OutputStreamWriter outWrite = null;
				String synStr = null;
                while (true) {
                	//synStr = "[{";
                	System.out.println("开始把订单数据同步到erp服务器...");
                    PageData pd = new PageData();
                    Page page = new Page();
                    try {
						String requestUrl = ip+"/"+projectName+"/erp_Get/setSalesOrder";
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
				            ByteArrayOutputStream buff = new ByteArrayOutputStream();
				            int c;
				            while((c = is.read()) >= 0){
				                buff.write(c);
				            }
				            byte[] data = buff.toByteArray();
				            buff.close();
				            String htmlText = new String(data, "UTF-8");
				            JSONObject jsStr = JSONObject.fromObject(htmlText);
				            System.out.println(jsStr);
				        } catch (MalformedURLException e) {
				            e.printStackTrace();
				        } catch (IOException e) {
				            e.printStackTrace();
				        } 
					} catch (Exception e1) {
						e1.printStackTrace();
					}
                    try {  
                        Thread.sleep(timeInterval);  
                    } catch (InterruptedException e) {  
                        e.printStackTrace();  
                    }
                    
                }  
            }  
        };  
        Thread thread = new Thread(runnable);  
        thread.start(); 
    }

}
