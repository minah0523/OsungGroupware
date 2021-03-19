package com.spring.groupware.subin.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.groupware.subin.model.CalendarVO;
import com.spring.groupware.subin.model.InterScheduleDAO;
import com.spring.groupware.subin.model.ScheduleVO;
import com.spring.groupware.yongjin.model.EmployeeVO;

@Service
public class ScheduleService implements InterScheduleService {

	@Autowired
	private InterScheduleDAO dao;
	
	// 전체일정 불러오기
	@Override
	public List<ScheduleVO> selectSchList(Map<String, Object> paraMap) {

		List<ScheduleVO> schList = dao.selectSchList(paraMap);
		
		return schList;
	}
	
	// 캘린더(내일정)를 읽어오기
	@Override
	public List<CalendarVO> readCalList(String fk_emp_no) {

		List<CalendarVO> calList = dao.readCalList(fk_emp_no);
		
		return calList;
	}
	
	// 캘린더(내일정)를 추가하기
	@Override
	public int addCal(Map<String, String> paraMap) {
		
		int n = dao.addCal(paraMap);
		
		return n;
	}
	
	// 캘린더(내일정)의 색상 변경하기
	@Override
	public int editCalColor(Map<String, String> paraMap) {
		
		int n = dao.editCalColor(paraMap);
		
		return n;
	}
	
	// 캘린더(내일정) 삭제하기
	@Override
	public int delCal(Map<String, Object> paraMap) {
		
		int n = dao.delCal(paraMap);
		
		return n;
	}
	
	// 캘린더(내일정)의 이름 변경하기
	@Override
	public int editCalName(Map<String, String> paraMap) {

		int n = dao.editCalName(paraMap);
		
		return n;
	}
	
	///////////////////////지은언니 주소록 Modal////////////////////////////////
	// 사원테이블에서 부서에 따른 사원 리스트 가져와서 모달창에 보여주기
	   @Override
	   public List<EmployeeVO> findEmpList(Map<String, String> paraMap) {
	      List<EmployeeVO> empList = dao.findEmpList(paraMap);
	      return empList;
	   }
	   
	   // 사원테이블에서 입력한 이름에 따른 사원 리스트 가져와서 모달창에 보여주기
	   @Override
	   public List<EmployeeVO> empSearchList(Map<String, String> paraMap) {
	      List<EmployeeVO> empSearchList = dao.empSearchList(paraMap);
	      return empSearchList;
	   }


	///////////////////////지은언니 주소록 Modal////////////////////////////////
	

	// (Modal) 일정 추가하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addModalSch(Map<String, String> paraMap) throws Throwable {
		
		// 아직 만들어지지 않은 일정 시퀀스 번호를 받아옴
		String seq = dao.fk_schedule_no();
		
		paraMap.put("seq", seq);
		
		int n = 0;
		
		int n1 = dao.addModalSch(paraMap);	// 일정 추가
		
		// 일정 참석자 추가(작성자)
		int n2 = dao.insertOneAtt(paraMap);
		
		if(n1 == 1 && n2 == 1) n = 1;
		
		return n;
	}
	
	// 일정 상세 추가하기(다수의 참가자)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addDetailSch(Map<String, Object> paraMap) throws Throwable {
		
		String seq = dao.fk_schedule_no();
		
		paraMap.put("seq", seq);
		
		int n = 0;
		
		// 일정 추가(다수)
		int n1 = dao.addDetailSch(paraMap);	
		
		// 일정 참석자 추가(다수)
		int n2 = dao.insertMultiAtt(paraMap);
		
		if(n1 == 1 && n2 == 1) n = 1;
		
		return n;
	}
	
	// 같은 일정일 시 묶어줄 groupid를 받음
	@Override
	public String selectGroupId() {
		
		String groupId = dao.selectGroupId();
		
		return groupId;
	}
	
	// 참가자(이름) 불러오기
	@Override
	public List<EmployeeVO> selectAtd(Map<String, String> paraMap) {
		
		List<EmployeeVO> empList = dao.selectAtd(paraMap);
		
		return empList;
	}
	
	// 일정번호로 일정 하나 불러오기
	@Override
	public ScheduleVO selectOneSch(Map<String, String> paraMap) {
		
		ScheduleVO schvo = dao. selectOneSch(paraMap);
		
		return schvo;
	}
	
	// 삭제할 일정 번호 받아오기
	@Override
	public List<String> findDelSchNo(Map<String, Object> paraMap) {
		
		List<String> fk_schedule_noArr = dao.findDelSchNo(paraMap);
		
		return fk_schedule_noArr;
	}
	
	// 위에서 받은 일정번호를 삭제하기
	@Override
	public int delSch(Map<String, Object> paraMap) {
		
		int n = dao.delSch(paraMap);
		
		return n;
	}
	
	// 기존 참가자 데이터 전부 삭제 및 추가
	@Override
	public int updateAtd(Map<String, Object> paraMap) {
		
		// 기존 참가자 데이터 추가
		int n = dao.insertMultiAtt(paraMap);
		
		
		return n;
	}
	
	// 삭제할 참가자 groupid 받아오기
	@Override
	public List<String> findDelGroupid(String schedule_no) {
		
		List<String> groupid = dao.findDelGroupid(schedule_no);
		
		return groupid;
	}
	
	// 기존 참가자 데이터 전부 삭제
	@Override
	public int delGroupid(Map<String, Object> paraMap) {
		
		int n = dao.delGroupid(paraMap);
		
		return n;
	}
	
	// 받아온 배열로 not in(받아온 배열)을 사용해서 내 캘린더에 없는 일정 받아오기
	@Override
	public List<ScheduleVO> selectNoCalSchList(Map<String, Object> paraMap) {
		
		List<ScheduleVO> noCalschList = dao.selectNoCalSchList(paraMap);
		
		return noCalschList;
	}
	
}





