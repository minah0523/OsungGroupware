package com.spring.groupware.yongjin.model;

import org.springframework.web.multipart.MultipartFile;

public class PersonalBookVO {
	
	private int book_no;  			// 주소록 번호
	private int fk_emp_no;  		// 주소록을 소유한 사원번호
	private int fk_book_part_no;  	// 주소록 구분번호(어떤 사원의 어떤 주소록인지 구분)
	private String dept_name;  		// 부서명
	private String position_name;   // 직급명
	private String name;  			// 이름
	private String corp_phone;  	// 회사 전화번호
	private String postcode;  		// 우편번호
	private String address;  		// 주소
	private String detail_address;  // 상세주소
	private String extra_address;   // 주소 참고항목
	private String mobile;  		// 휴대폰
	private String email;  			// 이메일
	private String photo_route;  	// 사진경로
	private String photo_name;  	// 사진명(실제 파일명)
	private String company_name;  	// 회사명
	private String memo;  			// 메모
	
	// select 용
	private String book_part_name;  // 주소록 구분명
	
	// 이미지 파일 첨부
	private MultipartFile attach;   // form 태그에서 type="file" 인 파일을 받아서 저장되는 필드
	
	private String attachPhoto_name; // WAS(톰캣)에 저장될 파일명
	private String attachPhoto_size; // 파일크기
	
	public PersonalBookVO() {}

	public PersonalBookVO(int book_no, int fk_emp_no, int fk_book_part_no, String dept_name, String position_name,
			String name, String corp_phone, String postcode, String address, String detail_address,
			String extra_address, String mobile, String email, String photo_route, String photo_name,
			String company_name, String memo, String book_part_name, String attachPhoto_name, String attachPhoto_size) {
		this.book_no = book_no;
		this.fk_emp_no = fk_emp_no;
		this.fk_book_part_no = fk_book_part_no;
		this.dept_name = dept_name;
		this.position_name = position_name;
		this.name = name;
		this.corp_phone = corp_phone;
		this.postcode = postcode;
		this.address = address;
		this.detail_address = detail_address;
		this.extra_address = extra_address;
		this.mobile = mobile;
		this.email = email;
		this.photo_route = photo_route;
		this.photo_name = photo_name;
		this.company_name = company_name;
		this.memo = memo;
		this.book_part_name = book_part_name;
		this.attachPhoto_name = attachPhoto_name;
		this.attachPhoto_size = attachPhoto_size;
	}

	public int getBook_no() {
		return book_no;
	}

	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}

	public int getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public int getFk_book_part_no() {
		return fk_book_part_no;
	}

	public void setFk_book_part_no(int fk_book_part_no) {
		this.fk_book_part_no = fk_book_part_no;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getBook_part_name() {
		return book_part_name;
	}

	public void setBook_part_name(String book_part_name) {
		this.book_part_name = book_part_name;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getAttachPhoto_name() {
		return attachPhoto_name;
	}

	public void setAttachPhoto_name(String attachPhoto_name) {
		this.attachPhoto_name = attachPhoto_name;
	}

	public String getAttachPhoto_size() {
		return attachPhoto_size;
	}

	public void setAttachPhoto_size(String attachPhoto_size) {
		this.attachPhoto_size = attachPhoto_size;
	}

}
