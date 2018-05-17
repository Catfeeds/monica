package com.fh.service.item;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

public interface ItemManager {
	
	public void save_salesOrder(PageData pd)throws Exception;
	
	public void save_salesOrderEntry(PageData pd)throws Exception;

	/**获取月份的订单量
	 * @param page
	 * @throws Exception
	 */
	public PageData list_OrderCount(Page page)throws Exception;
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list_ClientOrderCount(Page page)throws Exception;
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**树
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list_tree(Page page)throws Exception;
	
	/**客户资料
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listClient(Page page)throws Exception;
	
	/**临时表订单资料
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listAllSalesOrder(Page page)throws Exception;
	
	/**临时表订单明细资料
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listAllSalesOrderEntry(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	public PageData getBillNO(PageData pd)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listItemAll(PageData pd)throws Exception;
	
	/**z_ARSummary
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list_z_ARSummary(Page page)throws Exception;
	
	
	public List<PageData> tree_dataByid(Page page)throws Exception;
	
	
	public List<PageData> listAll_ERP(Page page)throws Exception;
}
