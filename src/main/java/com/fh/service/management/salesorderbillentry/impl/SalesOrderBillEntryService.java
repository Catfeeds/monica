package com.fh.service.management.salesorderbillentry.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.salesorderbillentry.SalesOrderBillEntryManager;

/** 
 * 说明： 销售订单明细
 * 创建人：成
 * 创建时间：2018-01-19
 * @version
 */
@Service("salesorderbillentryService")
public class SalesOrderBillEntryService implements SalesOrderBillEntryManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SalesOrderBillEntryMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SalesOrderBillEntryMapper.delete", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void deleteBySALESORDERBILL_ID(PageData pd)throws Exception{
		dao.delete("SalesOrderBillEntryMapper.deleteBySALESORDERBILL_ID", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SalesOrderBillEntryMapper.edit", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void toEditOrder(PageData pd)throws Exception{
		dao.update("SalesOrderBillEntryMapper.toEditOrder", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillEntryMapper.datalistPage", page);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list_oneOrder(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillEntryMapper.list_oneOrder", page);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list_salesOrderEntry(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillEntryMapper.list_salesOrderEntry", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SalesOrderBillEntryMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SalesOrderBillEntryMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SalesOrderBillEntryMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

