package com.spring.groupware.hoyeon.model;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {

	private String seq;            
	private String fk_emp_no;          // 사원번호
	private String fk_dept_no;         // 부서번호 
	private String title;              // 글제목
	private String content;            // 글내용   -- clob (최대 4GB까지 허용) 
	private String name;               // 성명
	private String readCount;          // 글조회수
	private String writeDay;           // 작성일자
	private String status;             // 글삭제여부   1:사용가능한 글,  0:삭제된글
	private String commentCount;       // 댓글의 개수 

	private String groupno;   		// 답변글쓰기에 있어서 그룹번호 
			                 		//원글(부모글)과 답변글은 동일한 groupno 를 가진다.
									//답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.

	private String fk_seq;    		  // fk_seq 컬럼은 절대로 foreign key가 아니다.!!!!!!
									  // fk_seq 컬럼은 자신의 글(답변글)에 있어서 
					                  // 원글(부모글)이 누구인지에 대한 정보값이다.
					                  // 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
					                  //  원글(부모글)의 seq 컬럼의 값을 가지게 되며,
					                  //  답변글이 아닌 원글일 경우 0 을 가지도록 한다.

	private String depthno;        	// 답변글쓰기에 있어서 답변글 이라면
									//원글(부모글)의 depthno + 1 을 가지게 되며,
									// 답변글이 아닌 원글일 경우 0 을 가지도록 한다.

	private MultipartFile file;
	//form 태그에서 타입이 file인 파일을 받아서 저장되는 필드이다. 진짜 파일은 WAS 톰캣의 디스크에 저장됨.
	//테이블의 컬럼이 아니다.
	// jsp 파일에서 input 태그의 타입이 file인것의 name과.이 필드명이 동일해야 파일첨부가 가능하다.
	
	private String fileName;      // WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png)                                       
	private String orgFilename;   //진짜 파일명(강아지.png)   
	private String fileSize;	  //파일크기      
	
	public BoardVO() {}
	
	public BoardVO(String seq, String fk_emp_no, String fk_dept_no, String title, String content, String name,
			String readCount, String writeDay, String status, String commentCount, String groupno,
			String fk_seq, String depthno, String fileName, String orgFilename, String fileSize) {
		super();
		this.seq = seq;
		this.fk_emp_no = fk_emp_no;
		this.fk_dept_no = fk_dept_no;
		this.title = title;
		this.content = content;
		this.name = name;
		this.readCount = readCount;
		this.writeDay = writeDay;
		this.status = status;
		this.commentCount = commentCount;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
	}
	
	
	
	public MultipartFile getFile() {
		return file;
	}


	

	public void setFile(MultipartFile file) {
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
	public String getFk_dept_no() {
		return fk_dept_no;
	}
	public void setFk_dept_no(String fk_dept_no) {
		this.fk_dept_no = fk_dept_no;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getReadCount() {
		return readCount;
	}
	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}

	public String getWriteDay() {
		return writeDay;
	}
	public void setWriteDay(String writeDay) {
		this.writeDay = writeDay;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	public String getGroupno() {
		return groupno;
	}
	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}
	public String getFk_seq() {
		return fk_seq;
	}
	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}
	public String getDepthno() {
		return depthno;
	}
	public void setDepthno(String depthno) {
		this.depthno = depthno;
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
	
	
	
	
}
