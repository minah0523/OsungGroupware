package com.spring.groupware.mina.service;

import java.util.*;

import com.spring.groupware.mina.model.ElecApprovalVO;
import com.spring.groupware.yongjin.model.EmployeeVO;

public interface InterElecApprovalService {
	
		
		// 페이징 처리한 결재대기중 리스트 가져오기 (select)
		List<ElecApprovalVO> waitingApprList(Map<String, String> paraMap);
		
		// 페이징 처리한 진행중문서 리스트 가져오기 (select)
		List<ElecApprovalVO> processingApprList(Map<String, String> paraMap);
		
		// 페이징 처리한 완료문서 리스트 가져오기 (select)
		List<ElecApprovalVO> finishedApprList(Map<String, String> paraMap);
		
		
		// 문서 1개를 보여주기
		ElecApprovalVO elecApprView(String approval_no);

		// 중간 결재대기중 문서에 의견 넣기, 결재 또는 반려 (글수정, update)
		int confirmMidApproval(ElecApprovalVO elecapprvo);
		
		// 최종 결재대기중 문서에 의견 넣기, 결재 또는 반려 (글수정, update)
		int confirmFinApproval(ElecApprovalVO elecapprvo);
		
		// 중간 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
		int rejectMidApproval(ElecApprovalVO elecapprvo);

		// 최종 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
		int rejectFinApproval(ElecApprovalVO elecapprvo);
		
		// 진행중문서 수정 (글수정, update)
		int updateApproval(ElecApprovalVO elecapprvo);
		
		// 총 Waiting 게시물 건수(totalCount) 구하기// 
		int getTotalWaitingCount(Map<String, String> paraMap);
		
		// 총 Processing 게시물 건수(totalCount) 구하기// 
		int getTotalProcessingCount(Map<String, String> paraMap);

		// 총 Finished 게시물 건수(totalCount) 구하기 //
		int getTotalFinishedCount(Map<String, String> paraMap);

		// 사원테이블에서 부서에 따른 사원 리스트 가져와서 모달창에 보여주기
		List<EmployeeVO> findEmpList(Map<String, String> paraMap);

		// 새 결재 진행 (글쓰기, insert)
		int write(ElecApprovalVO elecapprvo);

		// 파일첨부가 있는 새 결재 진행 (글쓰기, insert)
		int write_withFile(ElecApprovalVO elecapprvo);

		// 사원테이블에서 사원정보 가져오기
		EmployeeVO findEmp(String emp_no);

		// 결재중(processing) 문서 삭제하기
		int delProcessing(Map<String, String> paraMap);

}
