package com.spring.groupware.yongjin.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.yongjin.model.EmployeeVO;
import com.spring.groupware.yongjin.model.LoginHistoryVO;

public interface InterIndexService {

	// 기본정보 수정하기
	int profileRevise(EmployeeVO empvo);

	// 비밀번호 변경하기
	int pwdChangeEnd(Map<String, String> paraMap);

	// 게시판 글 목록 불러오기
	List<Map<String, String>> getIntegratedBoard();
	
	// 공지게시판 글 목록 불러오기
	List<Map<String, String>> getNoticeBoard();

	// 일반게시판 글 목록 불러오기
	List<Map<String, String>> getGeneralBoard();
	
	// 자료게시판
	List<Map<String, String>> getFileBoard();

	// 받은 쪽지함, 보낸 쪽지함 목록 불러오기
	List<Map<String, String>> getReceivedAndSendNote(Map<String, String> paraMap);

	// 로그인 기록 불러오기
	List<LoginHistoryVO> getLoginHistory(String fk_emp_no);

	// 결제 문서 수
	int getElecApprovalCount(String fk_emp_no);

	// 오늘 일정 수
	int getScheduleCount(String fk_emp_no);

	// 주간 근무 시간
	int getThisWeekWorkTime(String fk_emp_no);

	// ToDo 목록
	List<Map<String, String>> getToDoList(String fk_emp_no);

}
