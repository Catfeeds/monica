package com.fh.qy.service;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fh.qy.pojo.User;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.qy.test.UserTest;
import com.google.gson.Gson;

public class Contacts_UserService {
	private static Logger log = LoggerFactory.getLogger(UserTest.class);  

	private  static  String createUser_url="https://qyapi.weixin.qq.com/cgi-bin/user/create?access_token=ACCESS_TOKEN";  
	private  static  String getUser_url="https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&userid=USERID";  
	private  static  String updateUser_url="https://qyapi.weixin.qq.com/cgi-bin/user/update?access_token=ACCESS_TOKEN";  
	private  static  String deleteUser_url="https://qyapi.weixin.qq.com/cgi-bin/user/delete?access_token=ACCESS_TOKEN&userid=USERID";  
	private  static  String batchdeleteUser_url="https://qyapi.weixin.qq.com/cgi-bin/user/batchdelete?access_token=ACCESS_TOKEN";  
	private  static  String getDepartmentUser_url="https://qyapi.weixin.qq.com/cgi-bin/user/simplelist?access_token=ACCESS_TOKEN&department_id=DEPARTMENT_ID&fetch_child=FETCH_CHILD";  
	private  static  String getDepartmentUserDetails_url="https://qyapi.weixin.qq.com/cgi-bin/user/list?access_token=ACCESS_TOKEN&department_id=DEPARTMENT_ID&fetch_child=FETCH_CHILD";
	private  static  String useridToOpenid_url="https://qyapi.weixin.qq.com/cgi-bin/user/convert_to_openid?access_token=ACCESS_TOKEN";  
	
	//1.创建成员
	public void createUser(String accessToken,User user) {

		//1.获取json字符串：将user对象转换为json字符串	
		Gson gson = new Gson(); 
		String jsonU1 =gson.toJson(user);      //使用gson.toJson(user)即可将user对象顺序转成json
		System.out.println("jsonU1:"+jsonU1);


		//2.获取请求的url  
		createUser_url=createUser_url.replace("ACCESS_TOKEN", accessToken);

		//3.调用接口，发送请求，创建成员
		JSONObject jsonObject = WeiXinUtil.httpRequest(createUser_url, "POST", jsonU1);  
		System.out.println("jsonObject:"+jsonObject.toString());

		//4.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("创建成员失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
	}

	//2.获取成员
	public void getUser(String accessToken,String userId) {

		//1.获取请求的url  
		getUser_url=getUser_url.replace("ACCESS_TOKEN", accessToken)
				.replace("USERID", userId);

		//2.调用接口，发送请求，获取成员
		JSONObject jsonObject = WeiXinUtil.httpRequest(getUser_url, "GET", null);  
		System.out.println("jsonObject:"+jsonObject.toString());

		//3.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("获取成员失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
	}

	//3.更新成员
	public void updateUser(String accessToken,User user) {

		//1.获取json字符串：将user对象转换为json字符串	
		Gson gson = new Gson(); 
		String jsonU1 =gson.toJson(user);      //使用gson.toJson(user)即可将user对象顺序转成json
		System.out.println("jsonU1:"+jsonU1);


		//2.获取请求的url  
		updateUser_url=updateUser_url.replace("ACCESS_TOKEN", accessToken);

		//3.调用接口，发送请求，创建成员
		JSONObject jsonObject = WeiXinUtil.httpRequest(updateUser_url, "POST", jsonU1);  
		System.out.println("jsonObject:"+jsonObject.toString());

		//4.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("更新成员失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
	}

	//4.删除成员
	public void deleteUser(String accessToken,String userId) {	

		//1.获取请求的url  
		deleteUser_url=deleteUser_url.replace("ACCESS_TOKEN", accessToken)
				.replace("USERID", userId);

		//2.调用接口，发送请求，删除成员
		JSONObject jsonObject = WeiXinUtil.httpRequest(deleteUser_url, "GET", null);  
		System.out.println("jsonObject:"+jsonObject.toString());

		//3.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("删除成员失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
	}

	//5.批量删除成员
	public void batchdeleteUser(String accessToken,List<String> userIdList){
		//1.获取json字符串：将user对象转换为json字符串	
		Map<String, Object> content = new HashMap<String, Object>();  
		content.put("useridlist", userIdList);  

		Gson gson=new Gson();
		String useridlist=gson.toJson(content);
		System.out.println(useridlist);

		//2.获取请求的url  
		batchdeleteUser_url=batchdeleteUser_url.replace("ACCESS_TOKEN", accessToken);

		//3.调用接口，发送请求，创建成员
		JSONObject jsonObject = WeiXinUtil.httpRequest(batchdeleteUser_url, "POST", useridlist);  
		System.out.println("jsonObject:"+jsonObject.toString());

		//4.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("批量删除成员失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
	}


	//6.获取部门成员
	public JSONObject getDepartmentUser(String accessToken,String departmentId,String fetchChild) {

		//1.获取请求的url  
		getDepartmentUser_url=getDepartmentUser_url.replace("ACCESS_TOKEN", accessToken)
				.replace("DEPARTMENT_ID", departmentId)
				.replace("FETCH_CHILD", fetchChild);

		//2.调用接口，发送请求，获取部门成员
		JSONObject jsonObject = WeiXinUtil.httpRequest(getDepartmentUser_url, "GET", null);  
		System.out.println("jsonObject:"+jsonObject.toString());

		//3.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("获取部门成员失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
		
		return jsonObject;
	}


	//7.获取部门成员详情
	public JSONObject getDepartmentUserDetails(String accessToken,String departmentId,String fetchChild) {
		//1.获取请求的url  
		getDepartmentUserDetails_url=getDepartmentUserDetails_url.replace("ACCESS_TOKEN", accessToken)
				.replace("DEPARTMENT_ID", departmentId);
			//	.replace("FETCH_CHILD", fetchChild);

		//2.调用接口，发送请求，获取部门成员
		JSONObject jsonObject = WeiXinUtil.httpRequest(getDepartmentUserDetails_url, "GET", null);  
		System.out.println("jsonObject:"+jsonObject.toString());

		//3.错误消息处理
		if (null != jsonObject) {  
			if (0 != jsonObject.getInt("errcode")) {  
				log.error("获取部门成员详情失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
		return jsonObject;
	}
	
	//userid与openid互换
	public String useridToOpenid(String accessToken,String userid) {
		//1.获取请求的url  
		useridToOpenid_url=useridToOpenid_url.replace("ACCESS_TOKEN", accessToken);
		JSONObject gjson =new JSONObject();
        gjson.put("userid",userid);
        String reqjson = gjson.toString();
        String openid = null;
		try {
            URL httpclient =new URL(useridToOpenid_url);
            HttpURLConnection conn =(HttpURLConnection) httpclient.openConnection();
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(2000);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");    
            conn.setDoOutput(true);        
            conn.setDoInput(true);
            conn.connect();
            OutputStream os= conn.getOutputStream();    
            os.write(reqjson.getBytes("UTF-8"));//传入参数    
            os.flush();
            os.close();
            InputStream is =conn.getInputStream();
            int size =is.available();
            byte[] jsonBytes =new byte[size];
            is.read(jsonBytes);
            String message=new String(jsonBytes,"UTF-8");
           
           JSONObject jsonObject=JSONObject.fromObject(message);
            openid = jsonObject.get("openid").toString();
            System.out.println("Openid:"+message);
            
         
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } 
		return openid;
	}
	//更新成员信息
	public void updateUserToQy(String userid,String name,String department,String position,String mobile,String gender,
			String email) {
		JSONObject gjson =new JSONObject();
		 gjson.put("userid",userid);
		 gjson.put("name",name);
		 gjson.put("department",department);
		 gjson.put("mobile",mobile);
		 gjson.put("gender",gender);
		 gjson.put("email",email);
	     String reqjson = gjson.toString();
	     System.out.println("reqjson========>"+reqjson);
	     String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.contactsSecret).getToken();
	     System.out.println("accessToken:"+accessToken);
	     updateUser_url=updateUser_url.replace("ACCESS_TOKEN", accessToken);
	     try {
	            URL httpclient =new URL(updateUser_url);
	            HttpURLConnection conn =(HttpURLConnection) httpclient.openConnection();
	            conn.setConnectTimeout(5000);
	            conn.setReadTimeout(2000);
	            conn.setRequestMethod("POST");
	            conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");    
	            conn.setDoOutput(true);        
	            conn.setDoInput(true);
	            conn.connect();
	            OutputStream os= conn.getOutputStream();    
	            os.write(reqjson.getBytes("UTF-8"));//传入参数    
	            os.flush();
	            os.close();
	            InputStream is =conn.getInputStream();
	            int size =is.available();
	            byte[] jsonBytes =new byte[size];
	            is.read(jsonBytes);
	            String message=new String(jsonBytes,"UTF-8");
	           
	           JSONObject jsonObject=JSONObject.fromObject(message);
	            System.out.println("返回值jsonObject:"+jsonObject);
	         
	        } catch (MalformedURLException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }   
	}
}