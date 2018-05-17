package com.fh.service.item.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.dao.DaoSupport2;
import com.fh.entity.Page;
import com.fh.service.item.ItemManager;
import com.fh.util.PageData;

@Service("itemService")
public class ItemService implements ItemManager {
	@Resource(name = "daoSupport2")
	private DaoSupport2 dao2;
	
	public void save_salesOrder(PageData pd)throws Exception{
		dao2.save("ItemManager.save_salesOrder", pd);
	}
	
	public void save_salesOrderEntry(PageData pd)throws Exception{
		dao2.save("ItemManager.save_salesOrderEntry", pd);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list_ClientOrderCount(Page page)throws Exception{
		return (List<PageData>)dao2.findForList("ItemManager.list_ClientOrderCount", page);
	}

	/**获取月份的订单量
	 * @param page
	 * @throws Exception
	 */
	public PageData list_OrderCount(Page page)throws Exception{
		return (PageData)dao2.findForObject("ItemManager.list_OrderCount", page);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> list(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.datalistPage11", page);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listAll(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.listAll", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listItemAll(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.listItemAll", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listClient(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.listClient", page);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listAllSalesOrder(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.listAllSalesOrder", page);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listAllSalesOrderEntry(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.listAllSalesOrderEntry", page);
	}
	
	public PageData getBillNO(PageData pd)throws Exception{
		return (PageData)dao2.findForObject("ItemManager.getBillNO", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> list_tree(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.tree_data", page);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> list_z_ARSummary(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.z_ARSummary", page);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> tree_dataByid(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.tree_dataByid", page);
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listAll_ERP(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao2.findForList("ItemManager.datalistPage_erp", page);
	}

}
