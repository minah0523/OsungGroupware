package com.spring.groupware.jieun.model;

import org.springframework.web.multipart.MultipartFile;

public class NoteTrashVO { // 휴지통

	private int note_no;					// 편지번호
	private int fk_emp_no_send;				// 보낸사원번호	
	private int fk_emp_no_receive;			// 받은사원번호
	private String fk_emp_name;				// 받은사원명
	private String note_title;				// 편지제목 
	private String note_content;			// 편지내용
	private String note_filename;			// 첨부파일명(톰캣에 저장되는 파일명)
	private String note_orgfilename;		// 원본파일명(선택한 파일명)
	private String note_filesize;			// 파일크기 
	private int note_important;				// 중요도(중요한 파일인지 아닌지 여부, 중요함 체크 : 1, 아니면 0)
	private int note_reservation_status;	// 예약여부(예약 발송 여부 , 예약발송 : 1, 일반발송 : 0)
	private int note_read_status;			// 열람여부(쪽지 수신여부, 읽었으면 : 1, 안읽었으면 : 0)
	private String note_write_date;			// 작성시간
	private String note_reservation_date;   // 예약 설정 시간 (null 허용)
	
	private String emp_name;				// employeeVO에 있는 이름 가져오기(받은 편지함에서 보낸 사원번호에 해당하는 이름 select 용)
	private String dept_name_send;			// 쪽지 상세 조회시 보낸사원의 부서명을 알려주기 위한 select 용
	private String dept_name_receive;		// 쪽지 상세 조회시 받은사원의 부서명을 알려주기 위한 select 용
	
	private String note_del_login_emp_no;	// 삭제한 사원번호 select 용
	
	private MultipartFile attach;
    /*
		form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
		진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
		조심할 것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.!!!!!!  
		/FinalTeamProject/src/main/webapp/WEB-INF/views/tiles1/jieun/note/write.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
		동일해야만 파일첨부가 가능해진다.!!!!
    */
	
	public NoteTrashVO() {}
	
	public NoteTrashVO(int note_no, int fk_emp_no_send, int fk_emp_no_receive, String fk_emp_name, String note_title,
			String note_content, String note_filename, String note_orgfilename, String note_filesize,
			int note_important, int note_reservation_status, int note_read_status, String note_write_date,
			String note_reservation_date, String emp_name, MultipartFile attach) {
		super();
		this.note_no = note_no;
		this.fk_emp_no_send = fk_emp_no_send;
		this.fk_emp_no_receive = fk_emp_no_receive;
		this.fk_emp_name = fk_emp_name;
		this.note_title = note_title;
		this.note_content = note_content;
		this.note_filename = note_filename;
		this.note_orgfilename = note_orgfilename;
		this.note_filesize = note_filesize;
		this.note_important = note_important;
		this.note_reservation_status = note_reservation_status;
		this.note_read_status = note_read_status;
		this.note_write_date = note_write_date;
		this.note_reservation_date = note_reservation_date;
		this.emp_name = emp_name;
		this.attach = attach;
	}

	public int getNote_no() {
		return note_no;
	}

	public void setNote_no(int note_no) {
		this.note_no = note_no;
	}

	public int getFk_emp_no_send() {
		return fk_emp_no_send;
	}

	public void setFk_emp_no_send(int fk_emp_no_send) {
		this.fk_emp_no_send = fk_emp_no_send;
	}

	public int getFk_emp_no_receive() {
		return fk_emp_no_receive;
	}

	public void setFk_emp_no_receive(int fk_emp_no_receive) {
		this.fk_emp_no_receive = fk_emp_no_receive;
	}

	public String getFk_emp_name() {
		return fk_emp_name;
	}

	public void setFk_emp_name(String fk_emp_name) {
		this.fk_emp_name = fk_emp_name;
	}

	public String getNote_title() {
		return note_title;
	}

	public void setNote_title(String note_title) {
		this.note_title = note_title;
	}

	public String getNote_content() {
		return note_content;
	}

	public void setNote_content(String note_content) {
		this.note_content = note_content;
	}

	public String getNote_filename() {
		return note_filename;
	}

	public void setNote_filename(String note_filename) {
		this.note_filename = note_filename;
	}

	public String getNote_orgfilename() {
		return note_orgfilename;
	}

	public void setNote_orgfilename(String note_orgfilename) {
		this.note_orgfilename = note_orgfilename;
	}

	public String getNote_filesize() {
		return note_filesize;
	}

	public void setNote_filesize(String note_filesize) {
		this.note_filesize = note_filesize;
	}

	public int getNote_important() {
		return note_important;
	}

	public void setNote_important(int note_important) {
		this.note_important = note_important;
	}

	public int getNote_reservation_status() {
		return note_reservation_status;
	}

	public void setNote_reservation_status(int note_reservation_status) {
		this.note_reservation_status = note_reservation_status;
	}

	public int getNote_read_status() {
		return note_read_status;
	}

	public void setNote_read_status(int note_read_status) {
		this.note_read_status = note_read_status;
	}

	public String getNote_write_date() {
		return note_write_date;
	}

	public void setNote_write_date(String note_write_date) {
		this.note_write_date = note_write_date;
	}
	
	public String getNote_reservation_date() {
		return note_reservation_date;
	}

	public void setNote_reservation_date(String note_reservation_date) {
		this.note_reservation_date = note_reservation_date;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getDept_name_send() {
		return dept_name_send;
	}

	public void setDept_name_send(String dept_name_send) {
		this.dept_name_send = dept_name_send;
	}

	public String getDept_name_receive() {
		return dept_name_receive;
	}

	public void setDept_name_receive(String dept_name_receive) {
		this.dept_name_receive = dept_name_receive;
	}

	public String getNote_del_login_emp_no() {
		return note_del_login_emp_no;
	}

	public void setNote_del_login_emp_no(String note_del_login_emp_no) {
		this.note_del_login_emp_no = note_del_login_emp_no;
	}
	
}
