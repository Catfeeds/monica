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
	private static Connection getConn() {
	    String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	    String url = "jdbc:sqlserver://127.0.0.1:1433;databaseName=monica";
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
	    String sql = "";
	    List<PageData> jsonObj1 = new ArrayList<PageData>();
	    PreparedStatement pstmt;
	    try {
	        pstmt = (PreparedStatement)conn.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery();
	        int col = rs.getMetaData().getColumnCount();
	        int count = 0;
	        String columnName =null;
	        String value = null;
	        while (rs.next()) {

	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return jsonObj1;
	}


}
