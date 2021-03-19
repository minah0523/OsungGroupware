package com.spring.groupware.subin.model;

public class CalendarVO {

	private String calendar_no;
	private String fk_emp_no;
	private String name;
	private String color;
	
	/////////////////////////////////////////////////////////
	
	public CalendarVO() {	}

	/////////////////////////////////////////////////////////
	
	public String getCalendar_no() {
		return calendar_no;
	}

	public void setCalendar_no(String calendar_no) {
		this.calendar_no = calendar_no;
	}

	public String getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(String fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
	
	
}
