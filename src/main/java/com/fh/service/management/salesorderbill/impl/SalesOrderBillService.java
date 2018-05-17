package com.fh.service.management.salesorderbill.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.salesorderbill.SalesOrderBillManager;

/** 
 * 说明： 销售订单
 * 创建人：成
 * 创建时间：2018-01-18
 * @version
 */
@Service("salesorderbillService")
public class SalesOrderBillService implements SalesOrderBillManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SalesOrderBillMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SalesOrderBillMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SalesOrderBillMapper.edit", pd);
	}
	
	/**批量提交
	 * @param
	 * @throws Exception
	 */
	public void editSomeOrder(String[] strArr)throws Exception{
		dao.update("SalesOrderBillMapper.editSomeOrder", strArr);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editOrderAndSum(PageData pd)throws Exception{
		dao.update("SalesOrderBillMapper.editOrderAndSum", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillMapper.datalistPage", page);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list_withFtype(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillMapper.list_withFtype", page);
	}
	
	/**根据历史记录时间获取列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list_HisDate(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillMapper.list_HisDate", page);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listNotSyn(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillMapper.listNotSyn", page);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list_ClientOrderCount(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillMapper.list_ClientOrderCount", page);
	}
	
	public PageData list_withSALESORDERBILL_ID(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SalesOrderBillMapper.list_withSALESORDERBILL_ID", pd);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SalesOrderBillMapper.findById", pd);
	}
	/**获取月份的订单量
	 * @param page
	 * @throws Exception
	 */
	public PageData list_OrderCount(Page page)throws Exception{
		return (PageData)dao.findForObject("SalesOrderBillMapper.list_OrderCount", page);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SalesOrderBillMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

