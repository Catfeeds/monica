package com.fh.controller.test;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.dbutil.JdbcUtil;
import com.fh.entity.Page;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.qy.service.Contacts_UserService;
import com.fh.service.item.impl.ItemService;
import com.fh.service.wxqy.qywxuser.QyWxUserManager;
import com.fh.service.wxqy.weixindepartment.impl.WeixinDepartmentService;
import com.fh.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


@Controller
@RequestMapping(value="/test1")
public class TestController extends BaseController{
	@Resource(name="qywxuserService")
	private QyWxUserManager qywxuserService;
	@Resource(name="weixindepartmentService")
	WeixinDepartmentService weixindepService;
	@Resource(name="itemService")
	ItemService itemService;
	
	@RequestMapping(value="/test_getUser")
	@ResponseBody
	public  Map<String, Object> test_getUser() throws Exception{
		System.out.println("----------->:同步用户信息controller");
		Map<String, Object> json = new HashMap<String, Object>();
		//2.获取access_token:根据企业id和通讯录密钥获取access_token,并拼接请求url
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.contactsSecret).getToken();
		System.out.println("accessToken:"+accessToken);
		//1.获取部门ID以及是否获取子部门成员
		String departmentId="1";
		String fetchChild="1";
		Contacts_UserService cus = new Contacts_UserService();
		JSONObject jsonObject = cus.getDepartmentUser(accessToken, departmentId, fetchChild);
		JSONArray userlist=(JSONArray) jsonObject.get("userlist");
		Iterator<Object> it = userlist.iterator();
		String userid = null;
		String openidString = null;
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> pages = qywxuserService.listAll(pd);
		List<PageData> depPages = weixindepService.listAll(pd);
		//System.out.println("成员集合："+pages);
		//新增开关
		int hint = 0; //开0,关1
		//删除开关
		int dint = 0; //开0,关1
		int count = 1;
		int dcount = 1;
		int i;
		String[] strs = null;
		ArrayList<String>  depName = new ArrayList<String>();
		while (it.hasNext()) {
			JSONObject ob = (JSONObject) it.next();
			strs = ob.getString("department").substring(1, ob.getString("department").length()-1).split(",");
			for (i = 0; i < pages.size(); i++) {
				if(ob.getString("userid").equals(pages.get(i).getString("USERID"))){
					hint = 1;
				}
			}
			if (hint != 1) {
				userid = ob.getString("userid");
				openidString = cus.useridToOpenid(accessToken, userid);
				pd.put("QYWXUSER_ID",this.get32UUID());	//主键
				pd.put("USERID",ob.getString("userid"));	
				pd.put("NAME",ob.getString("name"));
				pd.put("DEPNUM",ob.getString("department"));
				for (int x = 0; x < strs.length; x++) {
					System.out.println(strs[x].getClass());
					for (int y = 0; y < depPages.size(); y++) {
						if (strs[x].equals(depPages.get(y).get("ID").toString())) {
							{
								depName.add(depPages.get(y).getString("DNAME"));
							}
						}
					}
				}
				//pd.put("DEPARTMENT",ob.getString("department"));	
				pd.put("DEPARTMENT",depName.toString().substring(1, depName.toString().length()-1));
				pd.put("OPENID",openidString);	
				qywxuserService.save(pd);
				System.out.println("插入"+count+"条数据");
				count ++ ;
				depName.clear();
			}
			hint = 0;
		}
		json.put("result", "成功");
		return json;
		
	}
	//DengJiaCheng
	
	@RequestMapping(value="/test_getOpenId")
	@ResponseBody
	public  Map<String, Object> test_getOpenId() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		//2.获取access_token:根据企业id和通讯录密钥获取access_token,并拼接请求url
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.contactsSecret).getToken();
		Contacts_UserService cus = new Contacts_UserService();
		String openidString = cus.useridToOpenid(accessToken, "DengJiaCheng");
		json.put("result", "成功");
		return json;
	}

}
