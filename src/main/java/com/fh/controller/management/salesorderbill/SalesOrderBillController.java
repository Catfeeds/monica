package com.fh.controller.management.salesorderbill;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.system.dictionaries.DictionariesManager;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
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
import com.fh.service.management.salesorderbill.SalesOrderBillManager;
import com.fh.service.management.salesorderbillentry.SalesOrderBillEntryManager;

/** 
 * 说明：销售订单
 * 创建人：成
 * 创建时间：2018-01-18
 */
@Controller
@RequestMapping(value="/salesorderbill")
public class SalesOrderBillController extends BaseController {
	
	String menuUrl = "salesorderbill/list.do"; //菜单地址(权限用)
	@Resource(name="salesorderbillService")
	private SalesOrderBillManager salesorderbillService;
	
	@Resource(name="salesorderbillentryService")
	private SalesOrderBillEntryManager salesorderbillentryService;

    @Resource(name="dictionariesService")
    private DictionariesManager dictionariesService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增SalesOrderBill");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SALESORDERBILL_ID", this.get32UUID());	//主键
		salesorderbillService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除SalesOrderBill");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		salesorderbillService.delete(pd);
		salesorderbillentryService.deleteBySALESORDERBILL_ID(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改SalesOrderBill");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		salesorderbillService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表SalesOrderBill");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = salesorderbillService.list(page);	//列出SalesOrderBill列表
		mv.setViewName("management/salesorderbill/salesorderbill_list");
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
		pd.put("PNAME","包装");
		List<PageData> packList = dictionariesService.listByParentName(pd);
        mv.addObject("packList", packList);

        pd.put("PNAME","喷码");
        List<PageData> codeSpurtingList = dictionariesService.listByParentName(pd);
        mv.addObject("codeSpurtingList", codeSpurtingList);

        pd.put("PNAME","镜面抛");
        List<PageData> mirrorbehindList = dictionariesService.listByParentName(pd);
        mv.addObject("mirrorbehindList", mirrorbehindList);

        pd.put("PNAME","客户验货");
        List<PageData> customerinspectionList = dictionariesService.listByParentName(pd);
        mv.addObject("customerinspectionList", customerinspectionList);

        pd.put("PNAME","胶水");
        List<PageData> glueList = dictionariesService.listByParentName(pd);
        mv.addObject("glueList", glueList);

        pd.put("PNAME","跟柜物品");
        List<PageData> articleList = dictionariesService.listByParentName(pd);
        mv.addObject("articleList", articleList);

        pd.put("PNAME","标识要求");
        List<PageData> identificationrequirementsList = dictionariesService.listByParentName(pd);
        mv.addObject("identificationrequirementsList", identificationrequirementsList);

        pd.put("PNAME","物流");
        List<PageData> logisticsList = dictionariesService.listByParentName(pd);
        mv.addObject("logisticsList", logisticsList);

        mv.setViewName("management/salesorderbill/salesorderbill_edit");
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
		pd = salesorderbillService.findById(pd);	//根据ID读取
		mv.setViewName("management/salesorderbill/salesorderbill_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除SalesOrderBill");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			salesorderbillService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出SalesOrderBill到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("模板id");	//1
		titles.add("订单编号");	//2
		titles.add("要求发货日期");	//3
		titles.add("部门ID");	//4
		titles.add("联络人");	//5
		titles.add("联系电话");	//6
		titles.add("制作人ID");	//7
		titles.add("制作日期");	//8
		titles.add("状态");	//9
		titles.add("审核人ID");	//10
		titles.add("审核日期");	//11
		titles.add("备注");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = salesorderbillService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("FTEMPID"));	    //1
			vpd.put("var2", varOList.get(i).getString("FBILLNO"));	    //2
			vpd.put("var3", varOList.get(i).getString("FNEEDDATE"));	    //3
			vpd.put("var4", varOList.get(i).get("FDEPTID").toString());	//4
			vpd.put("var5", varOList.get(i).getString("FCONTACT"));	    //5
			vpd.put("var6", varOList.get(i).getString("FTELEPHONE"));	    //6
			vpd.put("var7", varOList.get(i).getString("FBILLERID"));	    //7
			vpd.put("var8", varOList.get(i).getString("FDATE"));	    //8
			vpd.put("var9", varOList.get(i).getString("FSTATUS"));	    //9
			vpd.put("var10", varOList.get(i).getString("FCHECKERID"));	    //10
			vpd.put("var11", varOList.get(i).getString("FCHECKDATE"));	    //11
			vpd.put("var12", varOList.get(i).getString("FREMARK"));	    //12
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
}
