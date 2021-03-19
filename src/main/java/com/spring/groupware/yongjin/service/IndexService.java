package com.spring.groupware.yongjin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.yongjin.model.EmployeeVO;
import com.spring.groupware.yongjin.model.InterIndexDAO;
import com.spring.groupware.yongjin.model.LoginHistoryVO;

@Service
public class IndexService implements InterIndexService {
	
	@Autowired
	private InterIndexDAO dao;

	
	// === 기본정보 수정하기 === //
	@Override
	public int profileRevise(EmployeeVO empvo) {
		int result = dao.profileRevise(empvo);
		return result;
	}// end of public int profileRevise(EmployeeVO empvo) {}---------------------


	// === 비밀번호 변경하기 === //
	@Override
	public int pwdChangeEnd(Map<String, String> paraMap) {
		int result = dao.pwdChangeEnd(paraMap);
		return result;
	}// end of public int pwdChangeEnd(Map<String, String> paraMap) {}--------------------


	// === 게시판 글 목록 불러오기 === //
	@Override
	public List<Map<String, String>> getIntegratedBoard() {
		List<Map<String, String>> boardMap = dao.getIntegratedBoard();
		return boardMap;
	}// end of public List<Map<String, String>> getIntegratedBoard() {}-----------------------
	
	// 공지게시판
	@Override
	public List<Map<String, String>> getNoticeBoard() {
		List<Map<String, String>> boardMap = dao.getNoticeBoard();
		return boardMap;
	}

	// === 일반게시판 글 목록 불러오기 === //
	@Override
	public List<Map<String, String>> getGeneralBoard() {
		List<Map<String, String>> boardMap = dao.getGeneralBoard();
		return boardMap;
	}// end of public List<Map<String, String>> getIntegratedBoard() {}------------------------
	
	// 자료게시판
	@Override
	public List<Map<String, String>> getFileBoard() {
		List<Map<String, String>> boardMap = dao.getFileBoard();
		return boardMap;
	}


	// === 받은 쪽지함, 보낸 쪽지함 목록 불러오기 === //
	@Override
	public List<Map<String, String>> getReceivedAndSendNote(Map<String, String> paraMap) {
		List<Map<String, String>> noteList = dao.getReceivedAndSendNote(paraMap);
		return noteList;
	}// end of public List<Map<String, String>> getReceivedAndSendNote(String fk_emp_no) {}----------------------


	// === 로그인 기록 불러오기 === //
	@Override
	public List<LoginHistoryVO> getLoginHistory(String fk_emp_no) {
		List<LoginHistoryVO> lhList = dao.getLoginHistory(fk_emp_no);
		return lhList;
	}// end of public LoginHistoryVO getLoginHistory(String fk_emp_no) {}--------------------


	// 결제 문서 수
	@Override
	public int getElecApprovalCount(String fk_emp_no) {
		int count = dao.getElecApprovalCount(fk_emp_no);
		return count;
	}


	// 오늘 일정 수
	@Override
	public int getScheduleCount(String fk_emp_no) {
		int count = dao.getScheduleCount(fk_emp_no);
		return count;
	}


	// 주간 근무 시간
	@Override
	public int getThisWeekWorkTime(String fk_emp_no) {
		int total = dao.getThisWeekWorkTime(fk_emp_no);
		return total;
	}


	// ToDo 목록
	@Override
	public List<Map<String, String>> getToDoList(String fk_emp_no) {
		List<Map<String, String>> doMap = dao.getToDoList(fk_emp_no);
		return doMap;
	}

}
