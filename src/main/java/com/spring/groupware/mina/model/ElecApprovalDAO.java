package com.spring.groupware.mina.model;

import java.util.*;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.yongjin.model.EmployeeVO;


//=== DAO 선언 ===
@Repository 
public class ElecApprovalDAO implements InterElecApprovalDAO {

	// === 의존객체 주입하기(DI: Dependency Injection) ===
	// >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
	//     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
	//     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 

	//     의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지 
	//     1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다. 
	//                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	
	//     2. @Resource  ==> Java 에서 지원하는 어노테이션이다.
	//                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
	
	//     3. @Inject    ==> Java 에서 지원하는 어노테이션이다.
    //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.	
	
    /*	
	@Autowired
	private SqlSessionTemplate abc; */
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 abc 는 null 이 아니다.

	@Resource
	private SqlSessionTemplate sqlsession; // 원격DB에 연결
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 sqlsession 는 null 이 아니다.

	// 페이징 처리한 결재대기중 리스트 가져오기 (select)
	@Override
	public List<ElecApprovalVO> waitingApprList(Map<String, String> paraMap) {
		List<ElecApprovalVO> elecapprvoList = sqlsession.selectList("elecapproval.waitingApprList", paraMap);
		return elecapprvoList;
	}

	// 페이징 처리한 진행중문서 리스트 가져오기 (select)
	@Override
	public List<ElecApprovalVO> processingApprList(Map<String, String> paraMap) {
		List<ElecApprovalVO> elecapprvoList = sqlsession.selectList("elecapproval.processingApprList", paraMap);
		return elecapprvoList;
	}

	// 페이징 처리한 완료문서 리스트 가져오기 (select)
	@Override
	public List<ElecApprovalVO> finishedApprList(Map<String, String> paraMap) {
		List<ElecApprovalVO> elecapprvoList = sqlsession.selectList("elecapproval.finishedApprList", paraMap);
		return elecapprvoList;
	}

	// 문서 1개를 보여주기
	@Override
	public ElecApprovalVO elecApprView(String approval_no) {
		ElecApprovalVO elecapprvo = sqlsession.selectOne("elecapproval.elecApprView", approval_no);
		return elecapprvo;
	}
	
	
	// 중간결재자 결재대기중 문서에 의견 넣기, 결재  (글수정, update)
	@Override
	public int confirmMidApproval(ElecApprovalVO elecapprvo) {
		int n = sqlsession.update("elecapproval.confirmMidApproval", elecapprvo);
		return n;
	}
	
	// 최종결재자 결재대기중 문서에 의견 넣기, 결재  (글수정, update)
	@Override
	public int confirmFinApproval(ElecApprovalVO elecapprvo) {
		int n = sqlsession.update("elecapproval.confirmFinApproval", elecapprvo);
		return n;
	}

	// 중간결재자 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
	@Override
	public int rejectMidApproval(ElecApprovalVO elecapprvo) {
		int n = sqlsession.update("elecapproval.rejectMidApproval", elecapprvo);
		return n;
	}
	

	// 최종결재자 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
	@Override
	public int rejectFinApproval(ElecApprovalVO elecapprvo) {
		int n = sqlsession.update("elecapproval.rejectFinApproval", elecapprvo);
		return n;
	}
	
	// 진행중문서 수정 (글수정, update)
	@Override
	public int updateApproval(ElecApprovalVO elecapprvo) {
		int n = sqlsession.update("elecapproval.updateApproval", elecapprvo);
		return n;
	}

	// 총 Waiting 게시물 건수(totalCount) 구하기 // 
	@Override
	public int getTotalWaitingCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("elecapproval.getTotalWaitingCount", paraMap);
		return n;
	}
	
	// 총 Processing 게시물 건수(totalCount) 구하기 // 
	@Override
	public int getTotalProcessingCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("elecapproval.getTotalProcessingCount", paraMap);
		return n;
	}

	// 총 Finished 게시물 건수(totalCount) 구하기 //
	@Override
	public int getTotalFinishedCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("elecapproval.getTotalFinishedCount", paraMap);
		return n;
	}

	// 사원테이블에서 사원정보 가져오기
	   @Override
	   public EmployeeVO findEmp(String emp_no) {
	      EmployeeVO empvo = sqlsession.selectOne("elecapproval.findEmp", emp_no);
	      return empvo;
	   }
	
	 // 사원테이블에서 사원 리스트 가져와서 모달창에 보여주기
	   @Override
	   public List<EmployeeVO> findEmpList(Map<String, String> paraMap) {
	      
	      List<EmployeeVO> empList = sqlsession.selectList("elecapproval.findEmpList", paraMap);
	      return empList;
	   }

	// 새결재진행
	@Override
	public int write(ElecApprovalVO elecapprvo) {
		int n = sqlsession.insert("elecapproval.write", elecapprvo);
		return n;
	}
	
	// 파일이 있는 새결재진행
	@Override
	public int write_withFile(ElecApprovalVO elecapprvo) {
		int n = sqlsession.insert("elecapproval.write_withFile", elecapprvo);
		return n;
	}

	// 결재중(processing) 문서 삭제하기
	@Override
	public int delProcessing(Map<String, String> paraMap) {
		int n = sqlsession.delete("elecapproval.delProcessing", paraMap);
		return n;
	}


}
