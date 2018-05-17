package com.fh.dao2;

import com.fh.entity.ExpInvoiceDistribute;
import com.fh.entity.ExpInvoiceDistributeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ExpInvoiceDistributeMapper {
    long countByExample(ExpInvoiceDistributeExample example);

    int deleteByExample(ExpInvoiceDistributeExample example);

    int deleteByPrimaryKey(Integer fid);

    int insert(ExpInvoiceDistribute record);

    int insertSelective(ExpInvoiceDistribute record);

    List<ExpInvoiceDistribute> selectByExample(ExpInvoiceDistributeExample example);

    ExpInvoiceDistribute selectByPrimaryKey(Integer fid);

    int updateByExampleSelective(@Param("record") ExpInvoiceDistribute record, @Param("example") ExpInvoiceDistributeExample example);

    int updateByExample(@Param("record") ExpInvoiceDistribute record, @Param("example") ExpInvoiceDistributeExample example);

    int updateByPrimaryKeySelective(ExpInvoiceDistribute record);

    int updateByPrimaryKey(ExpInvoiceDistribute record);
}