package com.fh.wx.test;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;


import com.fh.wx.info.WeixinInfo;
import com.fh.wx.pojo.Token;
import com.fh.wx.pojo.WeixinUserInfo;
import com.fh.wx.utils.CommonUtil;
import com.fh.wx.utils.MyX509TrustManager;
import com.fh.wx.utils.TokenUtil;
import org.junit.Test;


public class TokenTest {
	public static void main(String[] args) throws Exception {
		//修改appID，secret
	        String tokenUrl="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wxf90953f03e350eb5&secret=6ddfe15a1b98f550e5f9c9eedc5df4db";
	        //建立连接
	        URL url = new URL(tokenUrl);
	        HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
	        
	        // 创建SSLContext对象，并使用我们指定的信任管理器初始化
	        TrustManager[] tm = { new MyX509TrustManager() };
	        SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
	        sslContext.init(null, tm, new java.security.SecureRandom());
	        // 从上述SSLContext对象中得到SSLSocketFactory对象
	        SSLSocketFactory ssf = sslContext.getSocketFactory();
	        
	        httpUrlConn.setSSLSocketFactory(ssf);
	        httpUrlConn.setDoOutput(true);
	        httpUrlConn.setDoInput(true);
	        
	        // 设置请求方式（GET/POST）
	        httpUrlConn.setRequestMethod("GET");
	        
	        // 取得输入流
	        InputStream inputStream = httpUrlConn.getInputStream();
	        InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
	        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
	        //读取响应内容
	        StringBuffer buffer = new StringBuffer();
	        String str = null;
	        while ((str = bufferedReader.readLine()) != null) {
	            buffer.append(str);
	        }
	        bufferedReader.close();
	        inputStreamReader.close();
	        // 释放资源
	        inputStream.close();
	        httpUrlConn.disconnect();
	        //输出返回结果
	        System.out.println(buffer);
	    }
	/*@Test
    public void testGetToken3() {
        Map<String, Object> token=TokenUtil.getToken();
        System.out.println(token.get("access_token"));
        System.out.println(token.get("expires_in"));
    }*/
    
    
    @Test
    public void testSaveToken4() {
        Token token=CommonUtil.getToken(WeixinInfo.AppID,WeixinInfo.AppSecret);
       // TokenUtil.saveToken(token);
    }
	
	@Test
    public void testGetToken1() throws Exception {
        String tokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+WeixinInfo.AppID+"&secret="+WeixinInfo.AppSecret;
        // 建立连接
        URL url = new URL(tokenUrl);
        HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();

        // 创建SSLContext对象，并使用我们指定的信任管理器初始化
        TrustManager[] tm = { new MyX509TrustManager() };
        SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
        sslContext.init(null, tm, new java.security.SecureRandom());
        // 从上述SSLContext对象中得到SSLSocketFactory对象
        SSLSocketFactory ssf = sslContext.getSocketFactory();

        httpUrlConn.setSSLSocketFactory(ssf);
        httpUrlConn.setDoOutput(true);
        httpUrlConn.setDoInput(true);

        // 设置请求方式（GET/POST）
        httpUrlConn.setRequestMethod("GET");

        // 取得输入流
        InputStream inputStream = httpUrlConn.getInputStream();
        InputStreamReader inputStreamReader = new InputStreamReader(
                inputStream, "utf-8");
        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
        // 读取响应内容
        StringBuffer buffer = new StringBuffer();
        String str = null;
        while ((str = bufferedReader.readLine()) != null) {
            buffer.append(str);
        }
        bufferedReader.close();
        inputStreamReader.close();
        // 释放资源
        inputStream.close();
        httpUrlConn.disconnect();
        // 输出返回结果
        System.out.println(buffer);
    }

    @Test
    public void testGetToken2() {
        Token token = CommonUtil.getToken(WeixinInfo.AppID,WeixinInfo.AppSecret);
        //System.out.println(token);
        System.out.println("access_token:"+token.getAccessToken());
        System.out.println("expires_in:"+token.getExpiresIn());
    }
    
    @Test
    public  void userinfo() {
        // 获取接口访问凭证
        String accessToken = CommonUtil.getToken(WeixinInfo.AppID,WeixinInfo.AppSecret).getAccessToken();
        /**
         * 获取用户信息
         */
        CommonUtil commonUtil = new CommonUtil();
        WeixinUserInfo user = commonUtil.getUserInfo(accessToken, "o_gndvyfWCsyre_xo5hy4Pqnf-Zo");
        System.out.println("OpenID：" + user.getOpenId());
        System.out.println("关注状态：" + user.getSubscribe());
        System.out.println("关注时间：" + user.getSubscribeTime());
        System.out.println("昵称：" + user.getNickname());
        System.out.println("性别：" + user.getSex());
        System.out.println("国家：" + user.getCountry());
        System.out.println("省份：" + user.getProvince());
        System.out.println("城市：" + user.getCity());
        System.out.println("语言：" + user.getLanguage());
        System.out.println("头像：" + user.getHeadImgUrl());
    }
    
    
    
}
