package com.spring.groupware.mina.model;

import java.util.*;

import com.spring.groupware.yongjin.model.EmployeeVO;

public interface InterAttendanceDAO {
	
	
	// 페이징 처리한 결재대기중 리스트 가져오기 (select)
	List<AttendanceVO> waitingApprList(Map<String, String> paraMap);
	
	// 페이징 처리한 진행중문서 리스트 가져오기 (select)
	List<AttendanceVO> processingApprList(Map<String, String> paraMap);
	
	// 페이징 처리한 완료문서 리스트 가져오기 (select)
	List<AttendanceVO> finishedApprList(Map<String, String> paraMap);
	
	
	// 중간 결재대기중 문서에 의견 넣기, 결재 (글수정, update)
	int confirmMidApproval(AttendanceVO attvo);
	
	// 최종 결재대기중 문서에 의견 넣기, 결재 (글수정, update)
	int confirmFinApproval(AttendanceVO attvo);
	
	// 중간 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
	int rejectMidApproval(AttendanceVO attvo);
	
	// 최종 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
	int rejectFinApproval(AttendanceVO attvo);
		
	// 진행중문서 수정 (글수정, update)
	int updateApproval(AttendanceVO attvo);
	
	
	// 총 Waiting 게시물 건수(totalCount) 구하기 // 
	int getTotalWaitingCount(Map<String, String> paraMap);

	// 총 Processing 게시물 건수(totalCount) 구하기 // 
	int getTotalProcessingCount(Map<String, String> paraMap);
	
	// 총 Finished 게시물 건수(totalCount) 구하기 //
	int getTotalFinishedCount(Map<String, String> paraMap);

	// 문서 1개를 보여주기
	AttendanceVO elecApprView(String attendance_apply_no);

	 // 사원테이블에서 사원 리스트 가져와서 모달창에 보여주기
	List<EmployeeVO> findEmpList(Map<String, String> paraMap);

	// 새결재진행
	int write(AttendanceVO attvo);

	// 파일이 있는 새결재진행
	int write_withFile(AttendanceVO attvo);

	// 사원테이블에서 사원정보 가져오기
	EmployeeVO findEmp(String emp_no);

	// 결재중(processing) 문서 삭제하기
	int delProcessing(Map<String, String> paraMap);
	
	// 출퇴근 테이블 가져오기
	List<WorktimeVO> getWorktimeList(String fk_emp_no);
	
	// 연차테이블 가져오기
	VacationDaysVO getVacationDays(String fk_emp_no);

	// 오늘자 출퇴근 여부 확인하기
	public int countTodayWorktime(String worktime_no);

	// 오늘자 출퇴근내역 수정하기
	int updateWorktime(WorktimeVO wtvo);

	// 오늘자 출퇴근내역 삽입하기
	int insertWorktime(WorktimeVO wtvo);

	// 연차현황 수정하기
	int updateVacationDays(VacationDaysVO vdvo);
}
