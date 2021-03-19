package com.spring.groupware.subin.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.subin.model.TodoVO;

public interface InterTodoService {

	// 할일을 추가
	int addEndTodo(Map<String, String> paraMap);

	// 할일 불러오기
	List<TodoVO> selectTodoList(String fk_emp_no);

	// 할일 수정
	int editTodo(Map<String, String> paraMap);

	// 즐겨찾기 불러오기
	List<TodoVO> readBookmark(String fk_emp_no);

	// 할일 삭제
	int deleteTodo(String todo_no);

	// 즐겨찾기 스위치
	int switchBookmark(Map<String, String> paraMap);

	// 할일 한개 가져오기
	TodoVO selectOneTodo(String todo_no);

}
