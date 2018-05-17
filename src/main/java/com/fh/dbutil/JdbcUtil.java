package com.fh.dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



import com.fh.util.PageData;

public class JdbcUtil {
	/*url2:jdbc:sqlserver://127.0.0.1:1433;databaseName=sswwdb
		driverClassName2:com.microsoft.sqlserver.jdbc.SQLServerDriver
		username2:sa
		password2:sa*/
	private static Connection getConn() {
	    String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	    String url = "jdbc:sqlserver://127.0.0.1:1433;databaseName=sswwdb";
	    String username = "sa";
	    String password = "sa";
	    Connection conn = null;
	    try {
	        Class.forName(driver); //classLoader,加载对应驱动
	        conn = (Connection) DriverManager.getConnection(url, username, password);
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return conn;
	}
	
	
	public  List<PageData> getAll(String key) {
	    Connection conn = getConn();
	    String sql = "select A.FNumber,A.FName as AFName,A.FModel AFModel,B.FName as BFName,Sum(IsNull(C.FQty,0)) as FQty,ISNULL(D.FName,'') as DFName "
	    			+"from t_ICItem A "+
	    			"inner join T_MeasureUnit B on A.FUnitID=B.FMeasureUnitID "+
	    			"left Join ICInventory C on C.FItemID=A.FItemID "+
	    			"left Join t_Stock D on D.FItemID=C.FStockID "+
	    			"where A.FName +ISNULL(A.FModel,'') Like '%"+key+"%' "+
	    			"group By A.FNumber,A.FName,A.FModel,B.FName,ISNULL(D.FName,'') "+
	    			"order By A.FNumber,ISNULL(D.FName,'') ";
	    /*String sql = "Select * from t_ICItem";*/
	    List<PageData> jsonObj1 = new ArrayList<PageData>(); 
	    PreparedStatement pstmt;
	    try {
	        pstmt = (PreparedStatement)conn.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery();
	        int col = rs.getMetaData().getColumnCount();
	        int count = 0;
	        String columnName =null;
	        String value = null;
	        System.out.println("============================");
	        while (rs.next()) {
	        	 PageData pd = new PageData();
		        	pd.put("AFNumber", rs.getObject("FNumber"));
		        	pd.put("AFName", rs.getObject("AFName"));
		                pd.put("AFModel", rs.getObject("AFModel"));
		                pd.put("BFName", rs.getObject("BFName"));
		                pd.put("FQty", rs.getObject("FQty"));
		                pd.put("DFName", rs.getObject("DFName"));
		                jsonObj1.add(pd);
	            count ++ ;
	            
	        }
	        //System.out.println(pd);
	            System.out.println("============================"+count);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return jsonObj1;
	}
	
	
}
