package com.fh.service.management.synchronization;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 同步接口
 * 创建人：成
 * 创建时间：2017-12-08
 * @version
 */
public interface SynSupplierManager{

	/**
	 * 同步供应商数据
	 */
	public List<PageData> supplier_synchronization(Page page)throws Exception;
	
	/**
	 * 同步采购订单数据
	 */
	public List<PageData> poorder_synchronization(Page page)throws Exception;
	/**
	 * 同步采购订单明细数据
	 */
	public List<PageData> poorderEntry_synchronization(Page page)throws Exception;
}

