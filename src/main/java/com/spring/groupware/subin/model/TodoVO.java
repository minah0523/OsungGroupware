package com.spring.groupware.subin.model;

public class TodoVO {

	private String todo_no;		// 할일번호
	private String fk_emp_no;	// 사원번호
	private String subject;		// 제목
	private String content;		// 내용
	private String bookmark;	// 즐겨찾기
	
	///////////////////////////////////////////////////////
	
	public TodoVO() {	}

	///////////////////////////////////////////////////////
	
	public String getTodo_no() {
		return todo_no;
	}

	public void setTodo_no(String todo_no) {
		this.todo_no = todo_no;
	}

	public String getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(String fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getBookmark() {
		return bookmark;
	}

	public void setBookmark(String bookmark) {
		this.bookmark = bookmark;
	}
	
	
	
	
	
	
}
