package com.fh.timer;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import net.sf.json.JSONObject;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class TimerProcedure {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public void context() throws Exception{
    	System.out.println("定时器加载成功!!!");
		PageData pd = new PageData();

         /**
         * 设置一个定时器  
         */    
		final long timeInterval = 1000*60*5;
		Runnable runnable = new Runnable() {
			public void run() {  
				OutputStreamWriter outWrite = null;
				String synStr = null;
                while (true) {
                	System.out.println("开始把订单数据同步到erp服务器...");
					//pd = (PageData)dao.findForObject("InterfaceIPMapper.findByNew", pd);
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
