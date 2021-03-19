package com.spring.groupware.mina.model;

public class WorktimeVO {
	private String worktime_no;
	private int fk_emp_no;
	private String regdate;
	private String in_time;
	private String out_time;
	private String total_worktime;

	
	public WorktimeVO() {};
	
	public WorktimeVO(String worktime_no, int fk_emp_no, String regdate, String in_time, String out_time,
			String total_worktime) {
		super();
		this.worktime_no = worktime_no;
		this.fk_emp_no = fk_emp_no;
		this.regdate = regdate;
		this.in_time = in_time;
		this.out_time = out_time;
		this.total_worktime = total_worktime;
	}
	
	
	public String getWorktime_no() {
		return worktime_no;
	}
	public void setWorktime_no(String worktime_no) {
		this.worktime_no = worktime_no;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getIn_time() {
		return in_time;
	}
	public void setIn_time(String in_time) {
		this.in_time = in_time;
	}
	public String getOut_time() {
		return out_time;
	}
	public void setOut_time(String out_time) {
		this.out_time = out_time;
	}
	public String getTotal_worktime() {
		return total_worktime;
	}
	public void setTotal_worktime(String total_worktime) {
		this.total_worktime = total_worktime;
	}
	
	
	
}
