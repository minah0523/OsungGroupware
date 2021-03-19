package com.spring.groupware.subin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.yongjin.model.EmployeeVO;

@Repository
public class ScheduleDAO implements InterScheduleDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 전체일정 불러오기
	@Override
	public List<ScheduleVO> selectSchList(Map<String, Object> paraMap) {

		List<ScheduleVO> schList = sqlsession.selectList("calendar.selectSchList", paraMap);
		
		return schList;
	}
	
	// 캘린더(내일정)를 읽어오기
	@Override
	public List<CalendarVO> readCalList(String fk_emp_no) {
		
		List<CalendarVO> calList = sqlsession.selectList("calendar.readCalList", fk_emp_no);
		
		return calList;
	}
	
	// 캘린더(내일정)를 추가하기
	@Override
	public int addCal(Map<String, String> paraMap) {
		
		int n = sqlsession.insert("calendar.addCal", paraMap);
		
		return n;
	}
	
	// 캘린더(내일정)의 색상 변경하기
	@Override
	public int editCalColor(Map<String, String> paraMap) {
		
		int n = sqlsession.update("calendar.editCalColor", paraMap);
		
		return n;
	}
	
	// 캘린더(내일정) 삭제하기
	@Override
	public int delCal(Map<String, Object> paraMap) {
		
		int n = sqlsession.delete("calendar.delCal", paraMap);
		
		return n;
	}
	
	// 캘린더(내일정)의 이름 변경하기
	@Override
	public int editCalName(Map<String, String> paraMap) {
		
		int n = sqlsession.update("calendar.editCalName", paraMap);
		
		return n;
	}
	
	///////////////////////지은언니 주소록 Modal////////////////////////////////
	// 사원테이블에서 사원 리스트 가져와서 모달창에 보여주기
	   @Override
	   public List<EmployeeVO> findEmpList(Map<String, String> paraMap) {
	      
	      List<EmployeeVO> empList = sqlsession.selectList("calendar.findEmpList", paraMap);
	      return empList;
	   }
	   
	   // 사원테이블에서 입력한 이름에 따른 사원 리스트 가져와서 모달창에 보여주기
	   @Override
	   public List<EmployeeVO> empSearchList(Map<String, String> paraMap) {
	      List<EmployeeVO> empSearchList = sqlsession.selectList("calendar.empSearchList", paraMap);
	      return empSearchList;
	   }

	///////////////////////지은언니 주소록 Modal////////////////////////////////
	
	// 아직 만들어지지 않은 일정 시퀀스 번호를 받아옴
	@Override
	public String fk_schedule_no() {
		
		String seq = sqlsession.selectOne("calendar.fk_schedule_no");
		
		return seq;
	}
	
	
	// (Modal) 일정 추가하기 => 일정 참석자 추가(작성자)
	@Override
	public int insertOneAtt(Map<String, String> paraMap) {
		
		int n = sqlsession.insert("calendar.insertOneAtt", paraMap);
		
		return n;
	}
	
	// (Modal) 일정 추가하기
	@Override
	public int addModalSch(Map<String, String> paraMap) {
		
		int n = sqlsession.insert("calendar.addModalSch", paraMap);
		
		return n;
	}
	
	// 일정 상세 추가하기(다수)
	@Override
	public int addDetailSch(Map<String, Object> paraMap) {
		
		int n = sqlsession.insert("calendar.addDetailSch", paraMap);
		
		return n;
	}
	
	// 일정 상세 추가하기 => 일정 참석자 추가(다수의 참가자)
	@Override
	public int insertMultiAtt(Map<String, Object> paraMap) {
		
		int n = sqlsession.insert("calendar.insertMultiAtt", paraMap);
		
		return n;
	}
	
	// 같은 일정일 시 묶어줄 groupid를 받음
	@Override
	public String selectGroupId() {
		
		String groupId = sqlsession.selectOne("calendar.selectGroupId");
		
		return groupId;
	}
	
	// 참가자(이름) 불러오기
	@Override
	public List<EmployeeVO> selectAtd(Map<String, String> paraMap) {
		
		List<EmployeeVO> empList = sqlsession.selectList("calendar.selectAtd", paraMap);
		
		return empList;
	}
	
	// 일정번호로 일정 하나 불러오기
	@Override
	public ScheduleVO selectOneSch(Map<String, String> paraMap) {
		
		ScheduleVO schvo = sqlsession.selectOne("calendar.selectOneSch", paraMap);
		
		return schvo;
	}
	
	// 삭제할 일정 번호 받아오기
	@Override
	public List<String> findDelSchNo(Map<String, Object> paraMap) {
		
		List<String> fk_schedule_noArr = sqlsession.selectList("calendar.findDelSchNo", paraMap);
		
		return fk_schedule_noArr;
	}
	
	// 위에서 받은 일정번호를 삭제하기
	@Override
	public int delSch(Map<String, Object> paraMap) {
		
		int n = sqlsession.delete("calendar.delSch", paraMap);
		
		return n;
	}
	
	// (수정)삭제할 참가자 groupid 받아오기
	@Override
	public List<String> findDelGroupid(String schedule_no) {
		
		List<String> groupid = sqlsession.selectList("calendar.findDelGroupid", schedule_no);
		
		return groupid;
	}
	
	// 기존 참가자 데이터 전부 삭제
	@Override
	public int delGroupid(Map<String, Object> paraMap) {
		
		int n = sqlsession.delete("calendar.delGroupid", paraMap);
		
		return n;
	}
	
	// 받아온 배열로 not in(받아온 배열)을 사용해서 내 캘린더에 없는 일정 받아오기
	@Override
	public List<ScheduleVO> selectNoCalSchList(Map<String, Object> paraMap) {
		
		List<ScheduleVO> noCalschList = sqlsession.selectList("calendar.selectNoCalSchList", paraMap);
		
		return noCalschList;
	}
	
}






