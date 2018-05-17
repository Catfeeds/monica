package com.fh.wx.utils;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fh.wx.info.WeixinInfo;
import com.fh.wx.menu.Button;
import com.fh.wx.menu.CommonButton;
import com.fh.wx.menu.ComplexButton;
import com.fh.wx.menu.Menu;
import com.fh.wx.menu.ViewButton;
import com.fh.wx.pojo.AccessToken;


/**
* 类名: MenuManager </br>
* 包名： com.souvc.weixin.main
* 描述:菜单管理器类 </br>
* 发布版本：V1.0  </br>
 */

public class MenuManager {
	//private static Logger log = LoggerFactory.getLogger(MenuManager.class);

    public static void main(String[] args) {
        // 第三方用户唯一凭证
        String appId = WeixinInfo.AppID;
        // 第三方用户唯一凭证密钥
        String appSecret = WeixinInfo.AppSecret;

        // 调用接口获取access_token
        AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);
        System.out.println(at.getToken());
        if (null != at) {
            // 调用接口创建菜单
            int result = WeixinUtil.createMenu(getMenu(), at.getToken());

            // 判断菜单创建结果
            if (0 == result)
                System.out.println("菜单创建成功！");
            else
            	System.out.println("菜单创建失败，错误码：" + result);
        }
    }
    
    @Test
    public void createMenu(){
    	 // 第三方用户唯一凭证
        String appId = WeixinInfo.AppID;
        // 第三方用户唯一凭证密钥
        String appSecret = WeixinInfo.AppSecret;

        // 调用接口获取access_token
        AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);
        System.out.println(at.getToken());
        if (null != at) {
            // 调用接口创建菜单
            int result = WeixinUtil.createMenu(getMenu(), at.getToken());

            // 判断菜单创建结果
            if (0 == result)
                System.out.println("菜单创建成功！");
            else
            	System.out.println("菜单创建失败，错误码：" + result);
        }
    }
    
    @Test
    public void delete() {
    	// 第三方用户唯一凭证
        String appId = WeixinInfo.AppID;
        // 第三方用户唯一凭证密钥
        String appSecret = WeixinInfo.AppSecret;
		try {
			AccessToken token = WeixinUtil.getAccessToken(appId, appSecret);
			System.out.println("票据"+token.getToken());
			System.out.println("有效时间"+token.getExpiresIn());
			
			int result = WeixinUtil.deleteMenu(token.getToken());
			if(result == 0){
				System.out.println("删除菜单成功！！");
			}else {
				System.out.println("错误码："+result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    /**
     * 组装菜单数据
     * 
     * @return
     */
    private static Menu getMenu() {
    	ViewButton vb11 = new ViewButton();
    	vb11.setName("协同平台");
    	vb11.setType("view");
    	vb11.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf297fc64f92b7f99&redirect_uri=http%3a%2f%2fjittest.s1.natapp.cc%2fssww%2fsynergy%2findex&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect");
    	
    	ViewButton vb21 = new ViewButton();
    	vb21.setName("业务咨询");
    	vb21.setType("view");
    	vb21.setUrl("http://www.baidu.com");
    	
        ViewButton vb31 = new ViewButton();
    	vb31.setName("身份认证");
    	vb31.setType("view");
    	vb31.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf297fc64f92b7f99&redirect_uri=http%3a%2f%2fjittest.s1.natapp.cc%2fssww%2fsynergy%2faddClient&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect");
    	
    	/**
         * 封装整个菜单
         */
        Menu menu = new Menu();
        menu.setButton(new Button[] {vb11,vb21,vb31});

        return menu;
    }
}
