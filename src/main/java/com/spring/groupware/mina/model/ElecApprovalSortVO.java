package com.spring.groupware.mina.model;

public class ElecApprovalSortVO {
	
	private int approval_sort_no;
	private String approval_sort_name;
	
	//기본생성자
	public ElecApprovalSortVO() {}
	
	public ElecApprovalSortVO(int approval_sort_no, String approval_sort_name) {
		this.approval_sort_no = approval_sort_no;
		this.approval_sort_name = approval_sort_name;
	}

	public int getApproval_sort_no() {
		return approval_sort_no;
	}

	public void setApproval_sort_no(int approval_sort_no) {
		this.approval_sort_no = approval_sort_no;
	}

	public String getApproval_sort_name() {
		return approval_sort_name;
	}

	public void setApproval_sort_name(String approval_sort_name) {
		this.approval_sort_name = approval_sort_name;
	}
	
	
	
}
