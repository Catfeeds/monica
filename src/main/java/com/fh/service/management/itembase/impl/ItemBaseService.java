package com.fh.service.management.itembase.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.itembase.ItemBaseManager;

/** 
 * 说明： 物料管理
 * 创建人：成
 * 创建时间：2018-01-25
 * @version
 */
@Service("itembaseService")
public class ItemBaseService implements ItemBaseManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ItemBaseMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void deleteByFITEMID(PageData pd)throws Exception{
		dao.delete("ItemBaseMapper.deleteByFITEMID", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ItemBaseMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ItemBaseMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ItemBaseMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ItemBaseMapper.listAll", pd);
	}
	
	/**列表(全部)
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPageAll(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ItemBaseMapper.listPageAll", page);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ItemBaseMapper.findById", pd);
	}

	public PageData findByFITEMID(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ItemBaseMapper.findByFITEMID", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ItemBaseMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

