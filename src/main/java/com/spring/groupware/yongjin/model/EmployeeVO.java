package com.spring.groupware.yongjin.model;

public class EmployeeVO {
	
	private int emp_no;  			// 사원번호
	private int fk_dept_no;  		// 부서번호
	private int fk_position_no;  	// 직급번호
	private int fk_board_grant_no;  // 게시판 권한번호
	private int fk_site_grant_no;   // 사이트 권한번호
	private String emp_name;  		// 사원명
	private String emp_pwd;  		// 비밀번호
	private String corp_phone;  	// 회사전화번호
	private String postcode;  		// 우편번호
	private String address; 	 	// 주소
	private String detail_address;  // 상세주소
	private String extra_address;   // 주소 참고항목
	private String mobile;  		// 휴대폰번호
	private String email;  			// 이메일
	private String firstday;  		// 입사일
	private String photo_route;  	// 사진파일경로
	private String photo_name;  	// 사진파일명
	private int status;  			// 입퇴사상태(입사 중 = 1(기본값), 퇴사 = 0)
	
	// select용
	private String dept_name;  		  // 부서명
	private String position_name;     // 직급명
	private String board_grant_name;  // 게시판 권한명
	private String site_grant_name;   // 사이트 권한명
	
	public int getEmp_no() {
		return emp_no;
	}
	
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	
	public int getFk_dept_no() {
		return fk_dept_no;
	}
	
	public void setFk_dept_no(int fk_dept_no) {
		this.fk_dept_no = fk_dept_no;
	}
	
	public int getFk_position_no() {
		return fk_position_no;
	}
	
	public void setFk_position_no(int fk_position_no) {
		this.fk_position_no = fk_position_no;
	}
	
	public int getFk_board_grant_no() {
		return fk_board_grant_no;
	}
	
	public void setFk_board_grant_no(int fk_board_grant_no) {
		this.fk_board_grant_no = fk_board_grant_no;
	}
	
	public int getFk_site_grant_no() {
		return fk_site_grant_no;
	}
	
	public void setFk_site_grant_no(int fk_site_grant_no) {
		this.fk_site_grant_no = fk_site_grant_no;
	}
	
	public String getEmp_name() {
		return emp_name;
	}
	
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	
	public String getEmp_pwd() {
		return emp_pwd;
	}
	
	public void setEmp_pwd(String emp_pwd) {
		this.emp_pwd = emp_pwd;
	}
	
	public String getCorp_phone() {
		return corp_phone;
	}
	
	public void setCorp_phone(String corp_phone) {
		this.corp_phone = corp_phone;
	}
	
	public String getPostcode() {
		return postcode;
	}
	
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getDetail_address() {
		return detail_address;
	}
	
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	
	public String getExtra_address() {
		return extra_address;
	}
	
	public void setExtra_address(String extra_address) {
		this.extra_address = extra_address;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getFirstday() {
		return firstday;
	}
	
	public void setFirstday(String firstday) {
		this.firstday = firstday;
	}
	
	public String getPhoto_route() {
		return photo_route;
	}
	
	public void setPhoto_route(String photo_route) {
		this.photo_route = photo_route;
	}
	
	public String getPhoto_name() {
		return photo_name;
	}
	
	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}
	
	public int getStatus() {
		return status;
	}
	
	public void setStatus(int status) {
		this.status = status;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getPosition_name() {
		return position_name;
	}

	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}

	public String getBoard_grant_name() {
		return board_grant_name;
	}

	public void setBoard_grant_name(String board_grant_name) {
		this.board_grant_name = board_grant_name;
	}

	public String getSite_grant_name() {
		return site_grant_name;
	}

	public void setSite_grant_name(String site_grant_name) {
		this.site_grant_name = site_grant_name;
	}

}
