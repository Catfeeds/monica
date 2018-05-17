package com.fh.test;

import java.util.List;

import javax.annotation.Resource;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.util.UuidUtil;

public class Timer {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public void context() {
    	System.out.println("定时器加载成功!!!");
    	 
        // TODO Auto-generated method stub
         /**  
         * 设置一个定时器  
         */    
    	// run in a second  
        final long timeInterval = 5000;  
        Runnable runnable = new Runnable() {  
            @SuppressWarnings("unchecked")
			public void run() {  
                while (true) {  
                    // ------- code for task to run  
                    System.out.println("Hello !!");
                    PageData pd = new PageData();
                    Page page = new Page();
                	pd.put("COMMODITYPIC_ID", UuidUtil.get32UUID());	//主键
            		pd.put("COMMODITY_ID", "1231");	//COMMODITY_ID
            		pd.put("FITEMID", "11");	//FITEMID
            		pd.put("FPARENTID", "12");	//FPARENTID
            		page.setPd(pd);
                    try {
						System.out.println((List<PageData>)dao.findForList("CommodityPicMapper.datalistPage", page));
					} catch (Exception e1) {
						// TODO Auto-generated catch block
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
