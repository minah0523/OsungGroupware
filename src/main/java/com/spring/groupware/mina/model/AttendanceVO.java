package com.spring.groupware.mina.model;

import org.springframework.web.multipart.MultipartFile;

import com.spring.groupware.yongjin.model.EmployeeVO;

public class AttendanceVO {
	
	private	int		attendance_apply_no;          
	private	int		fk_attendance_sort_no;
	private	int		fk_emp_no;    
	private	String	vacation_days; 
	private	String	attendance_start_date; 
	private	String	attendance_finish_date; 
	private	String	fk_mid_approver_no;   
	private	String	fk_fin_approver_no;  
	private	String	title;                 
	private	String	content;           
	private	String	contents2;          
	private	String	contents3;           
	private	String	contents4;           
	private	String	server_file_name;    
	private	String	org_file_name;      
	private	String	file_path;          
	private	int		mid_approval_ok;  
	private	int		fin_approval_ok;    
	private	int		approval_status;    
	private	String	mid_approval_opinion;
	private	String	fin_approval_opinion;
	private String 	writeday;
	
	// select 용
	private String emp_name;
	private String dept_name;
	
	private EmployeeVO empvo;
	private EmployeeVO midapprvo;
	private EmployeeVO finapprvo;
	
	private MultipartFile attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	      진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
              조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
 	   /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
 	     동일해야만 파일첨부가 가능해진다.!!!!
    */
	
	
	//기본생성자
	public AttendanceVO() {}
	public AttendanceVO(int attendance_apply_no, int fk_attendance_sort_no, int fk_emp_no, String vacation_days,
			String attendance_start_date, String attendance_finish_date, String fk_mid_approver_no,
			String fk_fin_approver_no, String title, String content, String contents2, String contents3,
			String contents4, String server_file_name, String org_file_name, String file_path, int mid_approval_ok,
			int fin_approval_ok, int approval_status, String mid_approval_opinion, String fin_approval_opinion,
			String writeday, String emp_name, EmployeeVO empvo, EmployeeVO midapprvo, EmployeeVO finapprvo) {
		this.attendance_apply_no = attendance_apply_no;
		this.fk_attendance_sort_no = fk_attendance_sort_no;
		this.fk_emp_no = fk_emp_no;
		this.vacation_days = vacation_days;
		this.attendance_start_date = attendance_start_date;
		this.attendance_finish_date = attendance_finish_date;
		this.fk_mid_approver_no = fk_mid_approver_no;
		this.fk_fin_approver_no = fk_fin_approver_no;
		this.title = title;
		this.content = content;
		this.contents2 = contents2;
		this.contents3 = contents3;
		this.contents4 = contents4;
		this.server_file_name = server_file_name;
		this.org_file_name = org_file_name;
		this.file_path = file_path;
		this.mid_approval_ok = mid_approval_ok;
		this.fin_approval_ok = fin_approval_ok;
		this.approval_status = approval_status;
		this.mid_approval_opinion = mid_approval_opinion;
		this.fin_approval_opinion = fin_approval_opinion;
		this.writeday = writeday;
		this.emp_name = emp_name;
		this.empvo = empvo;
		this.midapprvo = midapprvo;
		this.finapprvo = finapprvo;
	}
	public int getAttendance_apply_no() {
		return attendance_apply_no;
	}
	public void setAttendance_apply_no(int attendance_apply_no) {
		this.attendance_apply_no = attendance_apply_no;
	}
	public int getFk_attendance_sort_no() {
		return fk_attendance_sort_no;
	}
	public void setFk_attendance_sort_no(int fk_attendance_sort_no) {
		this.fk_attendance_sort_no = fk_attendance_sort_no;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	public String getVacation_days() {
		return vacation_days;
	}
	public void setVacation_days(String vacation_days) {
		this.vacation_days = vacation_days;
	}
	public String getAttendance_start_date() {
		return attendance_start_date;
	}
	public void setAttendance_start_date(String attendance_start_date) {
		this.attendance_start_date = attendance_start_date;
	}
	public String getAttendance_finish_date() {
		return attendance_finish_date;
	}
	public void setAttendance_finish_date(String attendance_finish_date) {
		this.attendance_finish_date = attendance_finish_date;
	}
	public String getFk_mid_approver_no() {
		return fk_mid_approver_no;
	}
	public void setFk_mid_approver_no(String fk_mid_approver_no) {
		this.fk_mid_approver_no = fk_mid_approver_no;
	}
	public String getFk_fin_approver_no() {
		return fk_fin_approver_no;
	}
	public void setFk_fin_approver_no(String fk_fin_approver_no) {
		this.fk_fin_approver_no = fk_fin_approver_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContents2() {
		return contents2;
	}
	public void setContents2(String contents2) {
		this.contents2 = contents2;
	}
	public String getContents3() {
		return contents3;
	}
	public void setContents3(String contents3) {
		this.contents3 = contents3;
	}
	public String getContents4() {
		return contents4;
	}
	public void setContents4(String contents4) {
		this.contents4 = contents4;
	}
	public String getServer_file_name() {
		return server_file_name;
	}
	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}
	public String getOrg_file_name() {
		return org_file_name;
	}
	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public int getMid_approval_ok() {
		return mid_approval_ok;
	}
	public void setMid_approval_ok(int mid_approval_ok) {
		this.mid_approval_ok = mid_approval_ok;
	}
	public int getFin_approval_ok() {
		return fin_approval_ok;
	}
	public void setFin_approval_ok(int fin_approval_ok) {
		this.fin_approval_ok = fin_approval_ok;
	}
	public int getApproval_status() {
		return approval_status;
	}
	public void setApproval_status(int approval_status) {
		this.approval_status = approval_status;
	}
	public String getMid_approval_opinion() {
		return mid_approval_opinion;
	}
	public void setMid_approval_opinion(String mid_approval_opinion) {
		this.mid_approval_opinion = mid_approval_opinion;
	}
	public String getFin_approval_opinion() {
		return fin_approval_opinion;
	}
	public void setFin_approval_opinion(String fin_approval_opinion) {
		this.fin_approval_opinion = fin_approval_opinion;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public EmployeeVO getEmpvo() {
		return empvo;
	}
	public void setEmpvo(EmployeeVO empvo) {
		this.empvo = empvo;
	}
	public EmployeeVO getMidapprvo() {
		return midapprvo;
	}
	public void setMidapprvo(EmployeeVO midapprvo) {
		this.midapprvo = midapprvo;
	}
	public EmployeeVO getFinapprvo() {
		return finapprvo;
	}
	public void setFinapprvo(EmployeeVO finapprvo) {
		this.finapprvo = finapprvo;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	
}
