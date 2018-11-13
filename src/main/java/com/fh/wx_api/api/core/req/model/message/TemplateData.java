package com.fh.wx_api.api.core.req.model.message;


/**
 * 取多媒体文件
 * 
 * @author sfli.sir
 * 
 */
public class TemplateData {

	private String value;
	
	private String color;

	public TemplateData(){
		
	}		
	public TemplateData(String value, String color) {
		this.value = value;
		this.color = color;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	
	
}
