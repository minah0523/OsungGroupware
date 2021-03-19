package com.spring.groupware.subin.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.subin.model.TodoVO;
import com.spring.groupware.subin.service.InterTodoService;
import com.spring.groupware.yongjin.model.EmployeeVO;

@Controller
public class TodoController {
	
	@Autowired
	private InterTodoService service;

	@RequestMapping(value = "/goTodo.os")
	public ModelAndView requiredLogin_goTodo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");

		if (loginManager != null) {
			
			String fk_emp_no = String.valueOf(loginManager.getEmp_no());
			List<TodoVO> todoList = service.selectTodoList(fk_emp_no);
			
			mav.addObject("todoList", todoList);
		}

		mav.setViewName("subin/todo/todo.tiles1");
		
		return mav;
	}
	
	// 즐겨찾기 불러오기
	@ResponseBody
	@RequestMapping(value="/readBookmark.os", produces="text/plain;charset=UTF-8")
	public String readBookmark(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		
		List<TodoVO> bookmarkList = service.readBookmark(fk_emp_no);
		
		JSONArray jsonArr = new JSONArray();
		
		if (bookmarkList != null) {
			for (TodoVO todo : bookmarkList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("todo_no", todo.getTodo_no());
				jsonObj.put("fk_emp_no", todo.getFk_emp_no());
				jsonObj.put("subject", todo.getSubject());
				jsonObj.put("content", todo.getContent());
				jsonObj.put("bookmark", todo.getBookmark());
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	// 즐겨찾기 스위치
	@ResponseBody
	@RequestMapping(value="/switchBookmark.os", produces="text/plain;charset=UTF-8")
	public String switchBookmark(HttpServletRequest request) {
		
		String todo_no = request.getParameter("todo_no");
		
		// 할일 한개 가져오기
		TodoVO todovo = service.selectOneTodo(todo_no);
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("todo_no", todo_no);
		paraMap.put("bookmark", todovo.getBookmark());
		
		int n = service.switchBookmark(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 할일 추가
	@ResponseBody
	@RequestMapping(value="/addEndTodo.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String addEndTodo(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		
		int n = service.addEndTodo(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 할일 수정
	@ResponseBody
	@RequestMapping(value="/editTodo.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String editTodo(HttpServletRequest request) {
		
		String todo_no = request.getParameter("todo_no");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("todo_no", todo_no);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		
		int n = service.editTodo(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 할일 삭제
	@ResponseBody
	@RequestMapping(value="/deleteTodo.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String deleteTodo(HttpServletRequest request) {
		
		String todo_no = request.getParameter("todo_no");
		
		int n = service.deleteTodo(todo_no);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 할일 1개 불러오기
	@ResponseBody
	@RequestMapping(value="/readOneTodo.os", produces="text/plain;charset=UTF-8")
	public String readOneTodo(HttpServletRequest request) {
		
		String todo_no = request.getParameter("todo_no");
		
		TodoVO todovo = service.selectOneTodo(todo_no);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("todo_no", todovo.getTodo_no());
		jsonObj.put("fk_emp_no", todovo.getFk_emp_no());
		jsonObj.put("subject", todovo.getSubject());
		jsonObj.put("content", todovo.getContent());
		jsonObj.put("bookmark", todovo.getBookmark());

		return jsonObj.toString();
	}
	
	
	
	
	
}
