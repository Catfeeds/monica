package com.fh.service.management.salesorderbill;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 销售订单接口
 * 创建人：成
 * 创建时间：2018-01-18
 * @version
 */
public interface SalesOrderBillManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editOrderAndSum(PageData pd)throws Exception;
	
	
	/**修改并提交
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**批量提交
	 * @param pd
	 * @throws Exception
	 */
	public void editSomeOrder(String[] strArr)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;

	/**获取月份的订单量
	 * @param page
	 * @throws Exception
	 */
	public PageData list_OrderCount(Page page)throws Exception;

	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list_withFtype(Page page)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list_HisDate(Page page)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listNotSyn(Page page)throws Exception;

	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list_ClientOrderCount(Page page)throws Exception;

	public PageData list_withSALESORDERBILL_ID(PageData pd)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

