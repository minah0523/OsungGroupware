package com.spring.groupware.hoyeon.model;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {

	private String  seq;                //글번호
	private String  fk_emp_no;         // 사원번호
	private String name;               // 성명
	private String writeDay;           // 작성일자
	private String download_count;     // 다운로드 횟수 
	private String status;          // 글삭제여부   1:사용가능한 글,  0:삭제된글
	private String fileName;       //WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png)                                       
	private String orgFilename;    // 진짜 파일명(강아지.png)   
	private String fileSize;      //파일크기  
	
	private MultipartFile file;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	      진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
              조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
 	   /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
 	     동일해야만 파일첨부가 가능해진다.!!!!
    */

	
	
	
	public FileVO() {}

	public FileVO(String seq, String fk_emp_no, String name, String writeDay, String download_count,
			String status, String fileName, String orgFilename, String fileSize, MultipartFile file) {
		 
		this.seq = seq;
		this.fk_emp_no = fk_emp_no;
		this.name = name;
		this.writeDay = writeDay;
		this.download_count = download_count;
		this.status = status;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.file = file;
	}

	
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(String fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}



	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWriteDay() {
		return writeDay;
	}

	public void setWriteDay(String writeDay) {
		this.writeDay = writeDay;
	}

	public String getDownload_count() {
		return download_count;
	}

	public void setDownload_count(String download_count) {
		this.download_count = download_count;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	
}
