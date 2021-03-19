package com.spring.groupware.mina.model;

public class AttendanceSortVO {
	
	private int attendance_sort_no;
	private String attendance_sort_name;
	
	//기본생성자
	public AttendanceSortVO() {}

	public AttendanceSortVO(int attendance_sort_no, String attendance_sort_name) {
		this.attendance_sort_no = attendance_sort_no;
		this.attendance_sort_name = attendance_sort_name;
	}

	public int getAttendance_sort_no() {
		return attendance_sort_no;
	}

	public void setAttendance_sort_no(int attendance_sort_no) {
		this.attendance_sort_no = attendance_sort_no;
	}

	public String getAttendance_sort_name() {
		return attendance_sort_name;
	}

	public void setAttendance_sort_name(String attendance_sort_name) {
		this.attendance_sort_name = attendance_sort_name;
	}
	
	
	
	
	
}
