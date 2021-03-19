package com.spring.groupware.subin.model;

public class ReservationVO {
	
	private String reservation_no;				// 예약번호
	private String fk_resource_no;				// 자원분류번호
	private String fk_reservation_resource_no;	// 자원번호
	private String fk_emp_no;					// 사원번호
	private String startday;					// 시작일
	private String endday;						// 종료일
	private String reason;						// 사용용도
	
	
	// select용
	
	private String Rname;						// 자원분류명
	private String RSname;						// 자원명
	private String emp_name;					// 등록자
	private String info;						// 자원정보
	
	/////////////////////////////////////////////////////////////////////////////
	
	public ReservationVO() {	}
	
	/////////////////////////////////////////////////////////////////////////////

	public String getReservation_no() {
		return reservation_no;
	}

	public void setReservation_no(String reservation_no) {
		this.reservation_no = reservation_no;
	}

	public String getFk_resource_no() {
		return fk_resource_no;
	}

	public void setFk_resource_no(String fk_resource_no) {
		this.fk_resource_no = fk_resource_no;
	}

	public String getFk_reservation_resource_no() {
		return fk_reservation_resource_no;
	}

	public void setFk_reservation_resource_no(String fk_reservation_resource_no) {
		this.fk_reservation_resource_no = fk_reservation_resource_no;
	}

	public String getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(String fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
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

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getRname() {
		return Rname;
	}

	public void setRname(String rname) {
		Rname = rname;
	}

	public String getRSname() {
		return RSname;
	}

	public void setRSname(String rSname) {
		RSname = rSname;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
	
	
	
	
	
	
	

}
