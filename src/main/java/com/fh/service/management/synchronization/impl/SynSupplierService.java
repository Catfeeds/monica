package com.fh.service.management.synchronization.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.dao.DaoSupport2;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.supplier.SupplierManager;
import com.fh.service.management.synchronization.SynSupplierManager;

/** 
 * 说明： supplier
 * 创建人：成
 * 创建时间：2017-12-08
 * @version
 */
@Service("synSupplierService")
public class SynSupplierService implements SynSupplierManager{

	@Resource(name = "daoSupport2")
	private DaoSupport2 dao2;

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> supplier_synchronization(Page page) throws Exception {
		return (List<PageData>)dao2.findForList("SynSupplierManager.supplier_synchronization", page);
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> poorder_synchronization(Page page) throws Exception {
		return (List<PageData>)dao2.findForList("SynSupplierManager.poorder_synchronization", page);
	}
	

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> poorderEntry_synchronization(Page page) throws Exception {
		return (List<PageData>)dao2.findForList("SynSupplierManager.poorderEntry_synchronization", page);
	}
}

