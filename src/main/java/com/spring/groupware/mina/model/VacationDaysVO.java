package com.spring.groupware.mina.model;

public class VacationDaysVO {

	private int vacation_no;
	private int fk_emp_no;
	private String total_vacation_days;
	private String use_vacation_days;
	private String rest_vacation_days;
	
	public VacationDaysVO() {}
	public VacationDaysVO(int vacation_no, int fk_emp_no, String total_vacation_days, String use_vacation_days,
			String rest_vacation_days) {
		super();
		this.vacation_no = vacation_no;
		this.fk_emp_no = fk_emp_no;
		this.total_vacation_days = total_vacation_days;
		this.use_vacation_days = use_vacation_days;
		this.rest_vacation_days = rest_vacation_days;
	}
	
	public int getVacation_no() {
		return vacation_no;
	}
	public void setVacation_no(int vacation_no) {
		this.vacation_no = vacation_no;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	public String getTotal_vacation_days() {
		return total_vacation_days;
	}
	public void setTotal_vacation_days(String total_vacation_days) {
		this.total_vacation_days = total_vacation_days;
	}
	public String getUse_vacation_days() {
		return use_vacation_days;
	}
	public void setUse_vacation_days(String use_vacation_days) {
		this.use_vacation_days = use_vacation_days;
	}
	public String getRest_vacation_days() {
		return rest_vacation_days;
	}
	public void setRest_vacation_days(String rest_vacation_days) {
		this.rest_vacation_days = rest_vacation_days;
	}
	
	
	
}
