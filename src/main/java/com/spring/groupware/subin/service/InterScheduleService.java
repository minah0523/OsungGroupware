package com.spring.groupware.subin.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.yongjin.model.EmployeeVO;
import com.spring.groupware.subin.model.CalendarVO;
import com.spring.groupware.subin.model.ScheduleVO;

public interface InterScheduleService {

	// 전체 일정 불러오기
	List<ScheduleVO> selectSchList(Map<String, Object> paraMap);

	// 캘린더(내일정)를 읽어오기
	List<CalendarVO> readCalList(String fk_emp_no);

	// 캘린더(내일정)를 추가하기
	int addCal(Map<String, String> paraMap);

	// 캘린더(내일정)의 색상 변경하기
	int editCalColor(Map<String, String> paraMap);

	// 캘린더(내일정) 삭제하기
	int delCal(Map<String, Object> paraMap);

	// 캘린더(내일정)의 이름 변경하기
	int editCalName(Map<String, String> paraMap);
	
	///////////////////////지은언니 주소록 Modal////////////////////////////////
	List<EmployeeVO> findEmpList(Map<String, String> paraMap);
	List<EmployeeVO> empSearchList(Map<String, String> paraMap);
	///////////////////////지은언니 주소록 Modal////////////////////////////////

	// (Modal) 일정 추가하기
	int addModalSch(Map<String, String> paraMap) throws Throwable;

	// 일정 상세 추가하기(다수의 참가자)
	int addDetailSch(Map<String, Object> paraMap) throws Throwable;

	// 같은 일정일 시 묶어줄 groupid를 받음
	String selectGroupId();

	// 참가자(이름) 불러오기
	List<EmployeeVO> selectAtd(Map<String, String> paraMap);

	// 일정번호로 일정 하나 불러오기
	ScheduleVO selectOneSch(Map<String, String> paraMap);

	// 삭제할 일정 번호 받아오기
	List<String> findDelSchNo(Map<String, Object> paraMap);

	// 위에서 받은 일정번호를 삭제하기
	int delSch(Map<String, Object> paraMap);

	// 기존 참가자 데이터 전부 삭제 및 추가
	int updateAtd(Map<String, Object> paraMap);

	// 삭제할 참가자 groupid 받아오기
	List<String> findDelGroupid(String schedule_no);

	// 기존 참가자 데이터 전부 삭제
	int delGroupid(Map<String, Object> paraMap);

	// 받아온 배열로 not in(받아온 배열)을 사용해서 내 캘린더에 없는 일정 받아오기
	List<ScheduleVO> selectNoCalSchList(Map<String, Object> paraMap);

}
