package com.fh.qy.test;

import org.junit.Test;

import com.fh.qy.pojo.menu.Menu;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.qy.service.MenuService;

public class MenuTest {
	
  @Test	
  public void testCreateMenu(){
	  //1.组装菜单
	  MenuService ms=new MenuService();
	  Menu menu=ms.getMenu();
	  //2.获取access_token:根据企业id和应用密钥获取access_token
	  String accessToken=WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, "GCB1HLm-Ii0lfACOjoZmW9qMdjPIKV0pOyBda-DPMec").getToken();
	  System.out.println("accessToken:"+accessToken);
	  //3.创建菜单
	  ms.createMenu( accessToken, menu, 1000003);
  }
  
  
}
