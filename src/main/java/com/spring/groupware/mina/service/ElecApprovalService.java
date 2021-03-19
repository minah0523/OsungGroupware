package com.spring.groupware.mina.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.common.common.FileManager;
import com.spring.groupware.mina.model.ElecApprovalVO;
import com.spring.groupware.mina.model.InterElecApprovalDAO;
import com.spring.groupware.yongjin.model.EmployeeVO;

@Service
public class ElecApprovalService implements InterElecApprovalService {

	/*
	    ex) 주문
		  ==> 주문테이블 insert (DAO 에 있는 주문테이블에 insert 관련 method 호출) 
		  ==> 제품테이블에 주문받은 제품의 개수는 주문량 만큼 감소해야 한다 (DAO 에 있는 제품테이블에 update 관련 method 호출) 
		  ==> 장바구니에서 주문을 한 경우이라면 장바구니 비우기를 해야 한다 (DAO 에 있는 장바구니테이블에 delete 관련 method 호출) 
		  ==> 회원테이블에 포인트(마일리지)를 증가시켜주어야 한다 (DAO 에 있는 회원테이블에 update 관련 method 호출) 
	  
	    위에서 호출된 4가지의 메소드가 모두 성공되었다면 commit 해주고
	  	1개라도 실패하면 rollback 해준다. 이러한 트랜잭션처리를 해주는 곳이 Service 단이다.      
	*/
	
	// === 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterElecApprovalDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.groupware.mina.model.ElecApprovalVO 의 bean 을  dao 에 주입시켜준다. 
	// 그러므로 dao 는 null 이 아니다.
	
	
	// === 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	//@Autowired
	//private AES256 aes;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.groupware.common.model.AES256 의 bean 을  aes 에 주입시켜준다. 
	// 그러므로 aes 는 null 이 아니다.
	// com.spring.groupware.common.model.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.  
	
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	
	// 페이징 처리한 결재대기중 리스트 가져오기 (select)
	@Override
	public List<ElecApprovalVO> waitingApprList(Map<String, String> paraMap) {
		List<ElecApprovalVO> elecapprvoList = dao.waitingApprList(paraMap);
		return elecapprvoList;
	}

	// 페이징 처리한 진행중문서 리스트 가져오기 (select)
	@Override
	public List<ElecApprovalVO> processingApprList(Map<String, String> paraMap) {
		List<ElecApprovalVO> elecapprvoList = dao.processingApprList(paraMap);
		return elecapprvoList;
	}

	// 페이징 처리한 완료문서 리스트 가져오기 (select)
	@Override
	public List<ElecApprovalVO> finishedApprList(Map<String, String> paraMap) {
		List<ElecApprovalVO> elecapprvoList = dao.finishedApprList(paraMap);
		return elecapprvoList;
	}
	
	// 문서 1개를 보여주기
	@Override
	public ElecApprovalVO elecApprView(String approval_no) {
        // login_userid 는 로그인을 한 상태이라면 로그인한 사용자의 userid 이고, 
        // 로그인을 하지 않은 상태이라면 login_userid 는 null 이다. 

		ElecApprovalVO elecapprvo = dao.elecApprView(approval_no); // 글1개 조회하기  
		
		return elecapprvo;
	}
	
	// 결재대기중 문서에 의견 넣기, 결재 (글수정, update)
	@Override
	public int confirmMidApproval(ElecApprovalVO elecapprvo) {
		int n = dao.confirmMidApproval(elecapprvo);
		return n;
	}
	
	// 결재대기중 문서에 의견 넣기, 결재 (글수정, update)
	@Override
	public int confirmFinApproval(ElecApprovalVO elecapprvo) {
		int n = dao.confirmFinApproval(elecapprvo);
		return n;
	}
	
	// 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
	@Override
	public int rejectMidApproval(ElecApprovalVO elecapprvo) {
		int n = dao.rejectMidApproval(elecapprvo);
		return n;
	}
	
	// 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
	@Override
	public int rejectFinApproval(ElecApprovalVO elecapprvo) {
		int n = dao.rejectFinApproval(elecapprvo);
		return n;
	}

	// 진행중문서 수정 (글수정, update)
	@Override
	public int updateApproval(ElecApprovalVO elecapprvo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	// 총 Waiting 게시물 건수(totalCount) 구하기 // 
	@Override
	public int getTotalWaitingCount(Map<String, String> paraMap) {
		int n = dao.getTotalWaitingCount(paraMap);
		return n;
	}

	// 총 Processing 게시물 건수(totalCount) 구하기 // 
	@Override
	public int getTotalProcessingCount(Map<String, String> paraMap) {
		int n = dao.getTotalProcessingCount(paraMap);
		return n;
	}
	
	// 총 Finished 게시물 건수(totalCount) 구하기 // 
	@Override
	public int getTotalFinishedCount(Map<String, String> paraMap) {
		int n = dao.getTotalFinishedCount(paraMap);
		return n;
	}

	// 사원테이블에서 사원정보 가져오기
    @Override
    public EmployeeVO findEmp(String emp_no) {
       EmployeeVO empvo = dao.findEmp(emp_no);
       return empvo;
    }

	 // 사원테이블에서 부서에 따른 사원 리스트 가져와서 모달창에 보여주기
	 @Override
	 public List<EmployeeVO> findEmpList(Map<String, String> paraMap) {
	    List<EmployeeVO> empList = dao.findEmpList(paraMap);
	    return empList;
	 }

	 // 새 결재 진행 (글쓰기, insert)
	 @Override
	 public int write(ElecApprovalVO elecapprvo) {
		
		int n = dao.write(elecapprvo);
		return n;
	
	 } 
	 
	// 파일첨부가 있는 새 결재 진행 (글쓰기, insert)
	@Override
	public int write_withFile(ElecApprovalVO elecapprvo) {

		int n = dao.write_withFile(elecapprvo); // 첨부파일이 있는 경우 
		return n;		
	}

	// 결재중(processing) 문서 삭제하기
	@Override
	public int delProcessing(Map<String, String> paraMap) {
		
		int n = dao.delProcessing(paraMap);
		
		// === 파일첨부가 된 글이라면 DB에서 글 삭제가 성공된 후 첨부파일을 삭제해주어야 한다. === //
		if(n==1) {
			String fileName = paraMap.get("fileName");
			String path = paraMap.get("path");
			
			if( fileName != null && !"".equals(fileName) ) {
				try {
					fileManager.doFileDelete(fileName, path);
				} catch (Exception e) {	}
			}
		}
        ///////////////////////////////////////////////////////////////////
		
		return n;
	}

	
}
