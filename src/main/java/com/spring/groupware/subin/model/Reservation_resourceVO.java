package com.spring.groupware.subin.model;

public class Reservation_resourceVO {
	
	private String reservation_resource_no;	// 자원번호
	private String fk_resource_no;			// 자원분류번호
	private String name;					// 자원명
	private String info;					// 자원정보
	
	///////////////////////////////////////////////////////
	
	public Reservation_resourceVO() {	}

	///////////////////////////////////////////////////////

	public String getReservation_resource_no() {
		return reservation_resource_no;
	}


	public void setReservation_resource_no(String reservation_resource_no) {
		this.reservation_resource_no = reservation_resource_no;
	}


	public String getFk_resource_no() {
		return fk_resource_no;
	}


	public void setFk_resource_no(String fk_resource_no) {
		this.fk_resource_no = fk_resource_no;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getInfo() {
		return info;
	}


	public void setInfo(String info) {
		this.info = info;
	}
	
	
	
	
}
