package com.spring.groupware.subin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TodoDAO implements InterTodoDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 할일 추가
	@Override
	public int addEndTodo(Map<String, String> paraMap) {
		
		int n = sqlsession.insert("todo.addEndTodo", paraMap);
		
		return n;
	}
	
	// 할일 불러오기
	@Override
	public List<TodoVO> selectTodoList(String fk_emp_no) {
		
		List<TodoVO> todoList = sqlsession.selectList("todo.selectTodoList", fk_emp_no);
		
		return todoList;
	}
	
	// 즐겨찾기 스위치
	@Override
	public int switchBookmark(Map<String, String> paraMap) {
		
		int n = sqlsession.update("todo.switchBookmark", paraMap);
		
		return n;
	}
	
	// 할일 한개 가져오기
	@Override
	public TodoVO selectOneTodo(String todo_no) {
		
		TodoVO todovo = sqlsession.selectOne("todo.selectOneTodo", todo_no);
		
		return todovo;
	}
	
	// 할일 수정
	@Override
	public int editTodo(Map<String, String> paraMap) {
		
		int n = sqlsession.update("todo.editTodo", paraMap);
		
		return n;
	}
	
	// 즐겨찾기 불러오기
	@Override
	public List<TodoVO> readBookmark(String fk_emp_no) {
		
		List<TodoVO> bookmarkList = sqlsession.selectList("todo.readBookmark", fk_emp_no);
		
		return bookmarkList;
	}
	
	// 할일 삭제
	@Override
	public int deleteTodo(String todo_no) {

		int n = sqlsession.delete("todo.deleteTodo", todo_no);
		
		return n;
	}
	
}
