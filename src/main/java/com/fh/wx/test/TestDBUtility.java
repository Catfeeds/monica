package com.fh.wx.test;

import java.sql.SQLException;

import org.junit.Test;

import com.fh.wx.utils.DBUtility;


public class TestDBUtility {
	@Test
    public void testgetConnection() throws SQLException {
        DBUtility db = new DBUtility();
        //System.out.println(db.getConnection());
    }
}
