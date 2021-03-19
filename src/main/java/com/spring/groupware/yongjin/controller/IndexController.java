package com.spring.groupware.yongjin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.common.common.Sha256;
import com.spring.groupware.yongjin.model.EmployeeVO;
import com.spring.groupware.yongjin.model.LoginHistoryVO;
import com.spring.groupware.yongjin.service.InterIndexService;

@Controller
public class IndexController {

	@Autowired
	private InterIndexService service;
	
	
	// === 로그아웃 === //
	@RequestMapping(value = "/logout.os")
	public String requiredLogin_logout(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/login.os";
	}// end of public void requiredLogin_logout(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 기본정보 페이지 보이기 === //
	@RequestMapping(value = "/profile.os")
	public String requiredLogin_profile(HttpServletRequest request, HttpServletResponse response) {
		return "yongjin/index/profile.tiles1";
	}// end of public String requiredLogin_profile(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 기본정보 수정하기 === //
	@RequestMapping(value = "/profileRevise.os", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_profileRevise(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, EmployeeVO empvo) {
		
		int result = service.profileRevise(empvo);
		
		if(result == 1) {
			
			HttpSession session = request.getSession();
			EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
			
			loginemp.setEmp_name(empvo.getEmp_name());
			loginemp.setEmail(empvo.getEmail());
			loginemp.setMobile(empvo.getMobile());
			loginemp.setPostcode(empvo.getPostcode());
			loginemp.setAddress(empvo.getAddress());
			loginemp.setDetail_address(empvo.getDetail_address());
			loginemp.setExtra_address(empvo.getExtra_address());
			
		}
		
		mav.addObject("result", result);
		mav.setViewName("yongjin/index/profile.tiles1");
		
		return mav;
	}// end of public String requiredLogin_profileRevise(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 비밀번호 변경하기 페이지 보이기 === //
	@RequestMapping(value = "/pwdChange.os")
	public String requiredLogin_pwdChange(HttpServletRequest request, HttpServletResponse response) {
		return "yongjin/index/pwdChange.tiles1";
	}// end of public String requiredLogin_profile(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 비밀번호 변경하기 === //
	@RequestMapping(value = "/pwdChangeEnd.os", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_pwdChangeEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String emp_no = request.getParameter("emp_no");
		String before_pwd = request.getParameter("before_pwd");  // 현재 비밀번호
		String emp_pwd = request.getParameter("emp_pwd");		 // 새 비밀번호
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("emp_no", emp_no);
		paraMap.put("before_pwd", Sha256.encrypt(before_pwd));
		paraMap.put("emp_pwd", Sha256.encrypt(emp_pwd));
		
		// 비밀번호 변경하기
		int result = service.pwdChangeEnd(paraMap);
		
		if(result == 1) {
			mav.addObject("message", "비밀번호 변경에 성공하였습니다.");
		} else {
			mav.addObject("message", "비밀번호가 일치하지 않습니다.");
		}// end of if(result == 1) {}---------------------
		
		mav.addObject("loc", "javascript:history.back()");
		mav.setViewName("msg");
		
		return mav;
	}// end of public ModelAndView requiredLogin_pwdChangeEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {}
	
	
	// === 메뉴 선택 환경설정 페이지 보이기 === //
	@RequestMapping(value = "/setting.os")
	public String requiredLogin_setting(HttpServletRequest request, HttpServletResponse response) {
		return "yongjin/index/setting.tiles1";
	}// end of public String requiredLogin_setting(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 게시판 글 목록 불러오기 === //
	@ResponseBody
	@RequestMapping(value = "/index/getIntegratedBoard.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getIntegratedBoard(HttpServletRequest request, HttpServletResponse response) {
		
		List<Map<String, String>> boardList = service.getIntegratedBoard();
		
		JSONArray jsonArr = new JSONArray();
		
		if(boardList != null && boardList.size() > 0) {
			
			for(Map<String, String> boardMap : boardList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("seq", boardMap.get("seq"));
				jsonObj.put("title", boardMap.get("title"));
				jsonObj.put("writeday", boardMap.get("writeday"));
				jsonObj.put("writer", boardMap.get("writer"));
				jsonObj.put("tblname", boardMap.get("tblname"));
				
				jsonArr.put(jsonObj);
			}// end of for(Map<String, String> boardMap : boardList) {}-----------------------
			
		}// end of if(boardList != null && boardList.size() > 0) {}-----------------------
		
		return jsonArr.toString();
	}// end of public String requiredLogin_ajax_getIntegratedBoard(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 일반 게시판 글 목록 불러오기 === //
	@ResponseBody
	@RequestMapping(value = "/index/getNoticeBoard.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getNoticeBoard(HttpServletRequest request, HttpServletResponse response) {
		
		List<Map<String, String>> boardList = service.getNoticeBoard();
		
		JSONArray jsonArr = new JSONArray();
		
		if(boardList != null && boardList.size() > 0) {
			
			for(Map<String, String> boardMap : boardList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("seq", boardMap.get("seq"));
				jsonObj.put("title", boardMap.get("title"));
				jsonObj.put("content", boardMap.get("content"));
				jsonObj.put("writeday", boardMap.get("writeday"));
				jsonObj.put("writer", boardMap.get("writer"));
				
				jsonArr.put(jsonObj);
			}// end of for(Map<String, String> boardMap : boardList) {}-----------------------
			
		}// end of if(boardList != null && boardList.size() > 0) {}-----------------------
		
		return jsonArr.toString();
	}
	
	
	// === 일반 게시판 글 목록 불러오기 === //
	@ResponseBody
	@RequestMapping(value = "/index/getGeneralBoard.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getGeneralBoard(HttpServletRequest request, HttpServletResponse response) {
		
		List<Map<String, String>> boardList = service.getGeneralBoard();
		
		JSONArray jsonArr = new JSONArray();
		
		if(boardList != null && boardList.size() > 0) {
			
			for(Map<String, String> boardMap : boardList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("seq", boardMap.get("seq"));
				jsonObj.put("title", boardMap.get("title"));
				jsonObj.put("content", boardMap.get("content"));
				jsonObj.put("writeday", boardMap.get("writeday"));
				jsonObj.put("writer", boardMap.get("writer"));
				
				jsonArr.put(jsonObj);
			}// end of for(Map<String, String> boardMap : boardList) {}-----------------------
			
		}// end of if(boardList != null && boardList.size() > 0) {}-----------------------
		
		return jsonArr.toString();
	}// end of public String requiredLogin_ajax_getGeneralBoard(HttpServletRequest request, HttpServletResponse response) {}
	
	// === 자료 게시판 글 목록 불러오기 === //
	@ResponseBody
	@RequestMapping(value = "/index/getFileBoard.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getFileBoard(HttpServletRequest request, HttpServletResponse response) {
		
		List<Map<String, String>> boardList = service.getFileBoard();
		
		JSONArray jsonArr = new JSONArray();
		
		if(boardList != null && boardList.size() > 0) {
			
			for(Map<String, String> boardMap : boardList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("seq", boardMap.get("seq"));
				jsonObj.put("filename", boardMap.get("filename"));
				jsonObj.put("writeday", boardMap.get("writeday"));
				jsonObj.put("writer", boardMap.get("writer"));
				
				jsonArr.put(jsonObj);
			}// end of for(Map<String, String> boardMap : boardList) {}-----------------------
			
		}// end of if(boardList != null && boardList.size() > 0) {}-----------------------
		
		return jsonArr.toString();
	}
	
	
	// === 받은 쪽지함, 보낸 쪽지함 목록 불러오기 === //
	@ResponseBody
	@RequestMapping(value = "/index/getReceivedAndSendNote.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getReceivedAndSendNote(HttpServletRequest request, HttpServletResponse response) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		String index = request.getParameter("index");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("index", index);
		
		List<Map<String, String>> noteList = service.getReceivedAndSendNote(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(noteList != null && noteList.size() > 0) {
			
			for(Map<String, String> noteMap : noteList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("note_no", noteMap.get("note_no"));
				jsonObj.put("fk_emp_name_send", noteMap.get("fk_emp_name_send"));
				jsonObj.put("fk_emp_name_receive", noteMap.get("fk_emp_name_receive"));
				jsonObj.put("note_title", noteMap.get("note_title"));
				jsonObj.put("note_content", noteMap.get("note_content"));
				jsonObj.put("note_write_date", noteMap.get("note_write_date"));
				
				jsonArr.put(jsonObj);
			}// end of for(Map<String, String> boardMap : boardList) {}-----------------------
			
		}// end of if(boardList != null && boardList.size() > 0) {}-----------------------
		
		return jsonArr.toString();
	}// end of public String requiredLogin_ajax_getGeneralBoard(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 로그인 기록 불러오기 === //
	@ResponseBody
	@RequestMapping(value = "/index/getLoginHistory.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getLoginHistory(HttpServletRequest request, HttpServletResponse response) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		List<LoginHistoryVO> lhList = service.getLoginHistory(fk_emp_no);
		
		JSONArray jsonArr = new JSONArray();
		
		if(lhList != null && lhList.size() > 0) {
			
			for(LoginHistoryVO lhvo : lhList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("fk_emp_no", lhvo.getFk_emp_no());
				jsonObj.put("emp_ip", lhvo.getEmp_ip());
				jsonObj.put("logindate", lhvo.getLogindate());
				
				jsonArr.put(jsonObj);
			}// end of for(LoginHistoryVO lhvo : lhList) {}-----------------------
			
		}// end of if(lhList != null && lhList.size() > 0) {}-----------------------
		
		return jsonArr.toString();
	}// end of public String requiredLogin_ajax_getLoginHistory(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 결제 문서 수 === //
	@ResponseBody
	@RequestMapping(value = "/index/getElecApprovalCount.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getElecApprovalCount(HttpServletRequest request, HttpServletResponse response) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		int count = service.getElecApprovalCount(fk_emp_no);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("count", count);
		
		return jsonObj.toString();
	}
	
	
	// === 오늘 일정 수 === //
	@ResponseBody
	@RequestMapping(value = "/index/getScheduleCount.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getScheduleCount(HttpServletRequest request, HttpServletResponse response) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		int count = service.getScheduleCount(fk_emp_no);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("count", count);
		
		return jsonObj.toString();
	}
	
	
	// === 주간 근무 시간 === //
	@ResponseBody
	@RequestMapping(value = "/index/getThisWeekWorkTime.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getThisWeekWorkTime(HttpServletRequest request, HttpServletResponse response) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		int total = service.getThisWeekWorkTime(fk_emp_no);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", total);
		
		return jsonObj.toString();
	}
	
	
	// === ToDo 목록 === //
	@ResponseBody
	@RequestMapping(value = "/index/getToDoList.os", produces = "text/plain;charset=UTF-8")
	public String requiredLogin_ajax_getToDoList(HttpServletRequest request, HttpServletResponse response) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		List<Map<String, String>> doList = service.getToDoList(fk_emp_no);
		
		JSONArray jsonArr = new JSONArray();
		
		if(doList != null && doList.size() > 0) {
			
			for(Map<String, String> doMap : doList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("todo_no", doMap.get("todo_no"));
				jsonObj.put("fk_emp_no", doMap.get("fk_emp_no"));
				jsonObj.put("subject", doMap.get("subject"));
				jsonObj.put("content", doMap.get("content"));
				jsonObj.put("bookmark", doMap.get("bookmark"));
				
				jsonArr.put(jsonObj);
			}// end of for(Map<String, String> doMap : doList) {}-----------------------
			
		}// end of if(doList != null && doList.size() > 0) {}-----------------------
		
		return jsonArr.toString();
	}
	
}
