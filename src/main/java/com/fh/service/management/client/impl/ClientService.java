package com.fh.service.management.client.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.client.ClientManager;

/** 
 * 说明： 客户资料
 * 创建人：成
 * 创建时间：2018-02-25
 * @version
 */
@Service("clientService")
public class ClientService implements ClientManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ClientMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ClientMapper.delete", pd);
	}
	
	@Override
	public void deleteByFITEMID(PageData pd) throws Exception {
		dao.delete("ClientMapper.deleteByFITEMID", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ClientMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ClientMapper.datalistPage", page);
	}
	
	/**列表分类
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getClassify(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ClientMapper.getClassify", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ClientMapper.listAll", pd);
	}
	
	/**列表(全部)不带父id
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllNotParent(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ClientMapper.listAllNotParent", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ClientMapper.findById", pd);
	}
	
	/**通过client_id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByCLIENT_ID(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ClientMapper.findByCLIENT_ID", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ClientMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

