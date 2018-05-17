package com.fh.qy.service;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fh.qy.pojo.menu.Button;
import com.fh.qy.pojo.menu.CommonButton;
import com.fh.qy.pojo.menu.ComplexButton;
import com.fh.qy.pojo.menu.Menu;
import com.fh.qy.pojo.menu.ViewButton;
import com.fh.qy.qyutil.WeiXinUtil;
import com.google.gson.Gson;

import net.sf.json.JSONObject;


public class MenuService {
	private static Logger log = LoggerFactory.getLogger(MenuService.class);  
	// 菜单创建（POST） 限100（次/天）  
	public static String create_menu_url = "https://qyapi.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN&agentid=AGENTID";  

	/** 
	 * 1.创建菜单 
	 *  
	 * @param menu 菜单实例 
	 * @param accessToken 有效的access_token 
	 * @return 0表示成功，其他值表示失败 
	 */  
	public void createMenu(String accessToken,Menu menu,int agentId) {  

		//1.获取json字符串：将Menu对象转换为json字符串
		/**
		 * 将菜单对象转换成json字符串
		 *String jsonMenu = JSONObject.fromObject(menu).toString();
		 */
		
		Gson gson = new Gson(); 
		//String jsonMenu =gson.toJson(menu);      //使用gson.toJson(user)即可将user对象顺序转成json
		String jsonMenu = JSONObject.fromObject(menu).toString();
		System.out.println("jsonMenu:"+jsonMenu);


		//2.获取请求的url  
		create_menu_url = create_menu_url.replace("ACCESS_TOKEN", accessToken)
				.replace("AGENTID", String.valueOf(agentId));  
		System.out.println("create_menu_url----------->:"+create_menu_url);
		//3.调用接口,发送请求，创建菜单  
		JSONObject jsonObject = WeiXinUtil.httpRequest(create_menu_url, "POST", jsonMenu);  
		System.out.println("jsonObject:"+jsonObject.toString());

		//4.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("创建菜单失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
 
	}  

	/** 
	 * 2.组装菜单数据 
	 *  
	 * @return 
	 */  
	public  Menu getMenu() {  
	/*	ViewButton btn11 = new ViewButton();  
		btn11.setName("添加报销单");  
		btn11.setType("view");  
		btn11.setUrl("http://5nffqn.natappfree.cc/WeiXin_QiYe_Demo/uploadExpenseAccaout.jsp");  
*/
		ViewButton btn11 = new ViewButton();  
		btn11.setName("微门店");  
		btn11.setType("view");  
		btn11.setUrl("http://www.baidu.com");  

		ViewButton btn12 = new ViewButton();  
		btn12.setName("微门店");  
		btn12.setType("view");  
		btn12.setUrl("http://www.baidu.com");  

		ViewButton btn21 = new ViewButton();  
		btn21.setName("查看库存");  
		btn21.setType("view");  
		btn21.setUrl("https://www.baidu.com");  

		ViewButton btn23 = new ViewButton();  
		btn23.setName("订单管理");  
		btn23.setType("view");  
		btn23.setUrl("");  

		ViewButton btn22 = new ViewButton();  
		btn22.setName("来往对账");  
		btn22.setType("view");  
		btn22.setUrl("");  

		ViewButton btn24 = new ViewButton();  
		btn24.setName("报表查询");  
		btn24.setType("view");  
		btn24.setUrl("");  

		ViewButton btn31 = new ViewButton();  
		btn31.setName("身份认证");  
		btn31.setType("view");  
		btn31.setUrl(""); 

		ViewButton btn33 = new ViewButton();  
		btn33.setName("系统教程");  
		btn33.setType("view");  
		btn33.setUrl("");  

		ViewButton btn32 = new ViewButton();  
		btn32.setName("用户反馈");  
		btn32.setType("view");  
		btn32.setUrl("");  


		ComplexButton mainBtn1 = new ComplexButton();  
		mainBtn1.setName("微系统");  
		mainBtn1.setSub_button(new Button[] { btn11, btn12 });  

		ComplexButton mainBtn2 = new ComplexButton();  
		mainBtn2.setName("业务管理");  
		mainBtn2.setSub_button(new Button[] { btn21, btn22, btn23, btn24 });  

		ComplexButton mainBtn3 = new ComplexButton();  
		mainBtn3.setName("更多");  
		mainBtn3.setSub_button(new Button[] { btn31, btn33,btn32 });  

		/** 
		 * 这是企业号目前的菜单结构，每个一级菜单都有二级菜单项<br> 
		 *  
		 * 在某个一级菜单下没有二级菜单的情况，menu该如何定义呢？<br> 
		 * 比如，第三个一级菜单项不是“更多体验”，而直接是“幽默笑话”，那么menu应该这样定义：<br> 
		 * menu.setButton(new Button[] { mainBtn1, mainBtn2, btn33 }); 
		 */  
		Menu menu = new Menu();  
		menu.setButton(new Button[] { mainBtn1, mainBtn2, mainBtn3 });  

		return menu;  
	}  

}
