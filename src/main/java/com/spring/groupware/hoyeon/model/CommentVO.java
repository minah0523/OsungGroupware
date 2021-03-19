package com.spring.groupware.hoyeon.model;

//===== #82. 댓글용 VO 생성하기
//      먼저 오라클에서 tbl_comment 테이블을 생성한다.
//      또한 tbl_board 테이블에 commentCount 컬럼을 추가한다. =====
public class CommentVO {

	private String seq;          // 댓글번호
	private String  fk_emp_no;    // 사원번호
	private String name;         // 성명
	private String content;      // 댓글내용
	private String writeDay;      // 작성일자
	private String parentSeq;    // 원게시물 글번호
	private String status;       // 글삭제여부
	
	public CommentVO() { }
	
	public CommentVO(String seq, String fk_emp_no, String name, String content, String writeDay, String parentSeq,
			String status) {
		this.seq = seq;
		this.fk_emp_no = fk_emp_no;
		this.name = name;
		this.content = content;
		this.writeDay = writeDay;
		this.parentSeq = parentSeq;
		this.status = status;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriteDay() {
		return writeDay;
	}

	public void setWriteDay(String writeDay) {
		this.writeDay = writeDay;
	}

	public String getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(String parentSeq) {
		this.parentSeq = parentSeq;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
