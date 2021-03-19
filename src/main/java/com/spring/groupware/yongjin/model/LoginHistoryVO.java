package com.spring.groupware.yongjin.model;

public class LoginHistoryVO {
	
	private int fk_emp_no;     // 사원번호
	private String emp_ip;     // 접속아이피
	private String logindate;  // 로그인일자
	
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	
	public String getEmp_ip() {
		return emp_ip;
	}
	
	public void setEmp_ip(String emp_ip) {
		this.emp_ip = emp_ip;
	}
	
	public String getLogindate() {
		return logindate;
	}
	
	public void setLogindate(String logindate) {
		this.logindate = logindate;
	}

}
