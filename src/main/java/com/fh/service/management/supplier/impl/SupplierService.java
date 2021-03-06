package com.fh.service.management.supplier.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.dao.DaoSupport2;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.supplier.SupplierManager;

/** 
 * 说明： supplier
 * 创建人：成
 * 创建时间：2017-12-08
 * @version
 */
@Service("supplierService")
public class SupplierService implements SupplierManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SupplierMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SupplierMapper.delete", pd);
	}
	
	@Override
	public void deleteByFITEMID(PageData pd) throws Exception {
		dao.delete("SupplierMapper.deleteByFITEMID", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SupplierMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SupplierMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SupplierMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SupplierMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SupplierMapper.deleteAll", ArrayDATA_IDS);
	}

	
	
	
	
}

