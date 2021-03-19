package com.spring.groupware.subin.model;

public class ScheduleVO {
	
	private String schedule_no;
	private String fk_emp_no;
	private String fk_calendar_no;
	private String title;
	private String startday;
	private String endday;
	private String content;
	
	// select용
	private String color;
	
	///////////////////////////////////////////////////////////
	
	public ScheduleVO() {	}
	
	///////////////////////////////////////////////////////////

	public String getSchedule_no() {
		return schedule_no;
	}

	public void setSchedule_no(String schedule_no) {
		this.schedule_no = schedule_no;
	}

	public String getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(String fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public String getFk_calendar_no() {
		return fk_calendar_no;
	}

	public void setFk_calendar_no(String fk_calendar_no) {
		this.fk_calendar_no = fk_calendar_no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStartday() {
		return startday;
	}

	public void setStartday(String startday) {
		this.startday = startday;
	}

	public String getEndday() {
		return endday;
	}

	public void setEndday(String endday) {
		this.endday = endday;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
	
	
	
	
	
}
