package com.fh.controller.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.supplier.impl.SupplierService;
import com.fh.service.management.synchronization.impl.SynSupplierService;
import com.fh.util.PageData;


@Controller
@RequestMapping(value="/test")
public class TestSynchronizationController extends BaseController{
	@Resource(name="synSupplierService")
	private SynSupplierService synSupplierService;
	@Resource(name="supplierService")
	private SupplierService supplierService;

	@RequestMapping(value="/test_get")
	@ResponseBody
	public  Map<String, Object> test_get() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		page.setPd(pd);
		//新增开关
		int hint = 0; //0为开启，1为关闭
		//删除开关
		int dint = 0; //开0,关1
		//int dstr = 0;
		int count = 0;
		int dcount = 0;
		List<PageData>	synList  =synSupplierService.supplier_synchronization(page);	//需要同步的数据
		List<PageData>	varOList =supplierService.listAll(pd);  //本地数据
		System.out.println("需要同步的数据"+synList.size());
		System.out.println("本地数据"+varOList.size());
		for (int i = 0; i < synList.size(); i++) {
			hint = 1;
			//hint = 1;
			for (int j = 0; j < varOList.size(); j++) {
				if(varOList.get(j).get("FITEMID").equals(synList.get(i).get("FItemID"))){
					hint = 0;
				}
				/*if(!synList.get(i).get("FItemID").equals(varOList.get(j).get("FITEMID"))){
					dint = 0; //不存在
					dstr = (int) synList.get(i).get("FItemID");
				}*/
			}
			if(hint == 1) {
				 PageData pd1 = new PageData();
				 pd1 = this.getPageData();
				 pd1.put("SUPPLIER_ID", this.get32UUID());	//主键
				 pd1.put("FITEMID", synList.get(i).get("FItemID"));
				 pd1.put("FNUMBER", synList.get(i).get("FNumber"));
				 pd1.put("FMODIFYTIME", synList.get(i).get("FModifyTime"));
				 pd1.put("FNAME", synList.get(i).get("FName"));
				 pd1.put("FADDRESS", synList.get(i).get("FAddress"));
				 pd1.put("FCONTACT", synList.get(i).get("FContact"));
				 pd1.put("FTELEPHONE",synList.get(i).get("FPhone"));
				 supplierService.save(pd1);
				 count ++ ;
				// System.out.println(pd);
			}
			
			
		}
		for (int j = 0; j < varOList.size(); j++) {
			for (int i = 0; i < synList.size(); i++) {
				if(synList.get(i).get("FItemID").equals(varOList.get(j).get("FITEMID"))){
					dint = 1; //存在
				}
					//dstr = (int) synList.get(i).get("FItemID");
			}
			if(dint == 0){
				System.out.println(varOList.get(j).get("FITEMID"));
				PageData pd2 = new PageData();
				pd2.put("FITEMID",Integer.parseInt(varOList.get(j).get("FITEMID").toString()));
				System.out.println("delete:"+pd2);
				supplierService.deleteByFITEMID(pd2);
				dcount ++ ;
			}
			dint = 0;
		}
		System.out.println("新增数据"+count);
		System.out.println("删除数据"+dcount);
		json.put("result", "123");
		return json;
	}
	
	


}
