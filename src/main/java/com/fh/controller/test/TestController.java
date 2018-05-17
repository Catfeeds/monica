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
	
	@RequestMapping(value="/ceshi")
	@ResponseBody
	public  String getAjax(){
		System.out.println("test_controller");
		//stockService.lt();
		return "成功";
		
	}


	
	@RequestMapping(value="/test_getUser")
	@ResponseBody
	public  Map<String, Object> test_getUser() throws Exception{
		System.out.println("----------->:同步用户信息controller");
		Map<String, Object> json = new HashMap<String, Object>();
		//2.获取access_token:根据企业id和通讯录密钥获取access_token,并拼接请求url
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.contactsSecret).getToken();
		//String accessToken2= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.contactsSecret).getToken();
		System.out.println("accessToken:"+accessToken);
		//System.out.println("accessToken:"+accessToken2);
		//1.获取部门ID以及是否获取子部门成员
		String departmentId="1";
		String fetchChild="1";
		Contacts_UserService cus = new Contacts_UserService();
		JSONObject jsonObject = cus.getDepartmentUser(accessToken, departmentId, fetchChild);
		JSONArray userlist=(JSONArray) jsonObject.get("userlist");
		@SuppressWarnings("unchecked")
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
				System.out.println("======>>"+pd);
				qywxuserService.save(pd);
				System.out.println("插入"+count+"条数据");
				count ++ ;
				depName.clear();
			}
			hint = 0;
		}
		/*for (int j = 0; j < pages.size(); j++) {
			while (it.hasNext()) {
				JSONObject obj = (JSONObject) it.next();
				if(pages.get(j).getString("USERID").equals(obj.getString("userid"))){
					dint = 1;
				}
			} 
			if (dint != 1) {
				pd.put("USERID",pages.get(j).getString("USERID"));
				qywxuserService.delete(pd);
			}
			dint = 0;
		}*/
		json.put("result", "成功");
		return json;
		
	}
	//DengJiaCheng
	
	@RequestMapping(value="/test_getOpenId")
	@ResponseBody
	public  Map<String, Object> test_getOpenId() throws Exception{
		System.out.println("----------->:getOpenid");
		Map<String, Object> json = new HashMap<String, Object>();
		//2.获取access_token:根据企业id和通讯录密钥获取access_token,并拼接请求url
		String accessToken= WeiXinUtil.getAccessToken(WeiXinParamesUtil.corpId, WeiXinParamesUtil.contactsSecret).getToken();
		System.out.println("accessToken:"+accessToken);
		Contacts_UserService cus = new Contacts_UserService();
		String openidString = cus.useridToOpenid(accessToken, "DengJiaCheng");
		json.put("result", "成功");
		return json;
	}
	
	@RequestMapping(value="/test_getUserByDb")
	@ResponseBody
	public  Map<String, Object> test_getUserByDb() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = "2";				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		Page page = new Page();
		page.setPd(pd);
		List<PageData>	userList =qywxuserService.list(page);	
		System.out.println(userList);
		json.put("result", userList);
		return json;
	}
	
	@RequestMapping(value="/test_db")
	@ResponseBody
	public  Map<String, Object> test_db() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		/*T_ICItemExample t_ICItemExample = new T_ICItemExample();
		T_ICItemExample.Criteria criteria = t_ICItemExample.createCriteria();
		criteria.andFnameLike("浴巾");*/
		/*List<T_ICItem> t_ICItems = t_icitemmapper.selectByOther(null);
		System.out.println(t_ICItems.size());*/
		int pn = 1;
		PageHelper.startPage(pn,3);//每页的条数
		JdbcUtil jdbcUtil = new JdbcUtil();
		List<PageData> jsonObj = jdbcUtil.getAll("FW0231浴巾架＿有标");
		PageInfo<PageData> varListPage=new PageInfo<PageData>(jsonObj,1); //5表示要连续显示的页数
		System.out.println(jsonObj);
		json.put("result",jsonObj);
		return json;
		
		
	}
	

	@RequestMapping(value="/test_dbItem")
	@ResponseBody
	public  Map<String, Object> test_dbItem(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = "浴巾";
		pd.put("keywords", keywords.trim());
		page.setPd(pd);
		System.out.println(pd);
		List<PageData>	varList = itemService.list(page);
		System.out.println(varList);
		System.out.println(varList.size());
		json.put("result",varList);
		return json;
		
		
	}
	

	//z_ARSummary
	/**
	 * @Year		INT, --年份
	 	@Period		INT, --期间
		@CustNum	VARCHAR(255), --客户名称
		@EmpName	VARCHAR(255) --业务员
	 * 
	 * <p>Title: test_z_ARSummary</p>
	 * <p>Description: </p>
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/z_ARSummary")
	@ResponseBody
	public  Map<String, Object> test_z_ARSummary(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("Year", 2017);
		pd.put("Period",2);
		pd.put("CustNum","");
		pd.put("EmpName","");
		System.out.println(pd);
		page.setPd(pd);
		System.out.println(pd);
		List<PageData>	varList = itemService.list_z_ARSummary(page);
		System.out.println(varList);
		System.out.println(varList.size());
		json.put("result",varList);
		return json;
		
		
	}
	
	@RequestMapping(value="/load")
	public ModelAndView load(Page page) throws Exception{
		/*logBefore(logger, Jurisdiction.getUsername()+"列表NewForWx");*/
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		String treeKey = pd.getString("treeKey");
		String showCount = pd.getString("showCount");
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		if(null != treeKey && !"".equals(treeKey)){
			pd.put("treeKey", URLDecoder.decode(treeKey, "UTF-8").trim());
		}
		if(null == showCount || "".equals(showCount)){
			page.setShowCount(150);
		}
		
		page.setPd(pd);
		List<PageData> list_tree =  itemService.list_tree(page);
		List<PageData>	varList = itemService.list(page);
		mv.addObject("varList", varList);
		mv.addObject("list_tree", list_tree);
		mv.setViewName("item/wxic");
		mv.addObject("pd", pd);
		//mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
		
		
	}
}
