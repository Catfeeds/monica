package com.fh.controller.wxqy.qywxuser;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.fh.qy.pojo.User;
import com.fh.qy.qyutil.WeiXinParamesUtil;
import com.fh.qy.qyutil.WeiXinUtil;
import com.fh.qy.service.Contacts_UserService;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.wxqy.qywxuser.QyWxUserManager;
import com.fh.service.wxqy.weixindepartment.WeixinDepartmentManager;
import com.fh.service.wxqy.weixindepartment.impl.WeixinDepartmentService;

/** 
 * 说明：企业部门员工管理
 * 创建人：成
 * 创建时间：2017-10-30
 */
@Controller
@RequestMapping(value="/qywxuser")
public class QyWxUserController extends BaseController {
	
	String menuUrl = "qywxuser/list.do"; //菜单地址(权限用)
	@Resource(name="qywxuserService")
	private QyWxUserManager qywxuserService;
	@Resource(name="weixindepartmentService")
	private WeixinDepartmentManager weixindepartmentService;
	@Resource(name="weixindepartmentService")
	WeixinDepartmentService weixindepService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增QyWxUser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("QYWXUSER_ID", this.get32UUID());	//主键
		pd.put("UORDER", "");	//排序值
		pd.put("POSITION", "");	//职位信息
		pd.put("ISLEADER", "");	//标示是否为上级
		pd.put("AVATAR", "");	//头像url
		pd.put("ENGLISH_NAME", "");	//英文名
		pd.put("STATUS", "");	//状态
		pd.put("EXTATTR", "");	//扩展属性
		qywxuserService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除QyWxUser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		qywxuserService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改QyWxUser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String[] arr = pd.getString("DEPARTMENT").split(",");
		//String keywords = null;
		System.out.println("pd:::"+pd);
		Page page = new Page();
		Contacts_UserService cus = new Contacts_UserService();
		ArrayList<String>  depNums = new ArrayList<String>();
		for (int i = 0; i < arr.length; i++) {
			pd.put("keywords", arr[i].trim());
			page.setPd(pd);
			List<PageData> departments = weixindepartmentService.list(page);
			//System.out.println("//////////"+departments);
			for (int j = 0; j < departments.size(); j++) {
				System.out.println(departments.get(j).get("ID"));
				depNums.add(departments.get(j).get("ID").toString());
			}
		}
		String gender = null;
		if (pd.getString("GENDER").trim().equals("男")) {
			gender = "1";
		}else {
			gender = "2";
		}
		
		cus.updateUserToQy(pd.getString("USERID"),pd.getString("NAME"),depNums.toString(),"",pd.getString("MOBILE"),gender,
				pd.getString("EMAIL"));
		qywxuserService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表QyWxUser");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//keywords  = "3";
		//System.out.println("keywords值："+keywords);
		if(null != pd.getString("keywords") && !"".equals(pd.getString("keywords"))){
			String keywords = URLDecoder.decode(pd.getString("keywords"), "UTF-8");				//关键词检索条件
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = qywxuserService.list(page);	//列出QyWxUser列表
		mv.setViewName("wxqy/qywxuser/qywxuser_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("wxqy/qywxuser/qywxuser_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = qywxuserService.findById(pd);	//根据ID读取
		mv.setViewName("wxqy/qywxuser/qywxuser_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除QyWxUser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			qywxuserService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出QyWxUser到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("管理id");	//1
		titles.add("员工名称");	//2
		titles.add("手机号码");	//3
		titles.add("所属部门");	//4
		titles.add("排序值");	//5
		titles.add("职位信息");	//6
		titles.add("性别");	//7
		titles.add("邮箱");	//8
		titles.add("标示是否为上级");	//9
		titles.add("头像url");	//10
		titles.add("座机");	//11
		titles.add("英文名");	//12
		titles.add("状态");	//13
		titles.add("扩展属性");	//14
		titles.add("openid");	//15
		dataMap.put("titles", titles);
		List<PageData> varOList = qywxuserService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("USERID"));	    //1
			vpd.put("var2", varOList.get(i).getString("NAME"));	    //2
			vpd.put("var3", varOList.get(i).get("MOBILE").toString());	//3
			vpd.put("var4", varOList.get(i).getString("DEPARTMENT"));	    //4
			vpd.put("var5", varOList.get(i).getString("UORDER"));	    //5
			vpd.put("var6", varOList.get(i).getString("POSITION"));	    //6
			vpd.put("var7", varOList.get(i).getString("GENDER"));	    //7
			vpd.put("var8", varOList.get(i).getString("EMAIL"));	    //8
			vpd.put("var9", varOList.get(i).getString("ISLEADER"));	    //9
			vpd.put("var10", varOList.get(i).getString("AVATAR"));	    //10
			vpd.put("var11", varOList.get(i).getString("TELEPHONE"));	    //11
			vpd.put("var12", varOList.get(i).getString("ENGLISH_NAME"));	    //12
			vpd.put("var13", varOList.get(i).getString("STATUS"));	    //13
			vpd.put("var14", varOList.get(i).getString("EXTATTR"));	    //14
			vpd.put("var15", varOList.get(i).getString("OPENID"));	    //15
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	@RequestMapping(value="/listTree")
	public ModelAndView listTree() throws Exception{
		ModelAndView mv = new ModelAndView();
		//mv.addObject("zNodes", jsStr);
		mv.setViewName("wxqy/qywxuser/qywxuser_tree");
		return mv;
	}
	
	@RequestMapping(value="/dateTree")
	@ResponseBody  
	public JSONArray  dateTree(){
		Page page = new Page();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		JSONArray arr = null;
		try {
			arr = JSONArray.fromObject(weixindepartmentService.list(page));
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONArray jsStr = JSONArray.fromObject(this.makeTree(arr));
		//System.out.println(jsStr);
		 return jsStr;
	}
	
	@SuppressWarnings("unchecked")
	public  String makeTree(JSONArray arr){  
        //Check Roles is null  
        StringBuffer sb = new StringBuffer();  
       sb.append("["); 
	Iterator<Object> it = arr.iterator();
		while (it.hasNext()) {
           JSONObject ob = (JSONObject) it.next();
           	sb.append("{id:").append(ob.getString("ID")).append(",pId:").append(ob.getString("PARENTID")).append(",name:\"")  
            .append(ob.getString("DNAME")).append("\"").append(",open:").append("true").append("},");  
           }
       // System.out.println(sb.substring(0,sb.length()-1)+"]");
        return sb.substring(0,sb.length()-1)+"]";  
    } 
	
	@RequestMapping(value="/getUserByQYwx")
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
		json.put("result", "同步企业用户信息成功");
		return json;
		
	}
	
	
}
