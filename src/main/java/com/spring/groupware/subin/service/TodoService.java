package com.spring.groupware.subin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.subin.model.InterTodoDAO;
import com.spring.groupware.subin.model.TodoVO;

@Service
public class TodoService implements InterTodoService {

	@Autowired
	private InterTodoDAO dao;
	
	// 할일 추가
	@Override
	public int addEndTodo(Map<String, String> paraMap) {
		
		int n = dao.addEndTodo(paraMap);
		
		return n;
	}
	
	// 할일 불러오기
	@Override
	public List<TodoVO> selectTodoList(String fk_emp_no) {
		
		List<TodoVO> todoList = dao.selectTodoList(fk_emp_no);
		
		return todoList;
	}
	
	// 즐겨찾기 스위치
	@Override
	public int switchBookmark(Map<String, String> paraMap) {
		
		int n = dao.switchBookmark(paraMap);
		
		return n;
	}
	
	// 할일 한개 가져오기
	@Override
	public TodoVO selectOneTodo(String todo_no) {
		
		TodoVO todovo = dao.selectOneTodo(todo_no);
		
		return todovo;
	}
	
	// 할일 수정
	@Override
	public int editTodo(Map<String, String> paraMap) {
		
		int n = dao.editTodo(paraMap);
		
		return n;
	}
	
	// 즐겨찾기 불러오기
	@Override
	public List<TodoVO> readBookmark(String fk_emp_no) {

		List<TodoVO> bookmarkList = dao.readBookmark(fk_emp_no);
		
		return bookmarkList;
	}
	
	// 할일 삭제
	@Override
	public int deleteTodo(String todo_no) {
		
		int n = dao.deleteTodo(todo_no);
		
		return n;
	}
	
}
