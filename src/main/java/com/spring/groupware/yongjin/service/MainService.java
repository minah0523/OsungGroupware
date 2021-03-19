package com.spring.groupware.yongjin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.yongjin.model.EmployeeVO;
import com.spring.groupware.yongjin.model.InterMainDAO;

@Service
public class MainService implements InterMainService {
	
	@Autowired
	private InterMainDAO dao;

	
	// === 로그인 처리하기 === //
	@Override
	public EmployeeVO loginEnd(Map<String, String> paraMap) {
		EmployeeVO empvo = dao.loginEnd(paraMap);
		
		if(empvo != null) {
			// 접속기록 테이블에 입력하기
			dao.insertLoginHistory(paraMap);
		}// end of if(empvo != null) {
		
		return empvo;
	}// end of public EmployeeVO loginEnd(Map<String, String> paraMap) {}---------------------


	// === 비밀번호 찾기 결과 보여주기 === //
	@Override
	public int pwdFindEnd(Map<String, String> paraMap) {
		int count = dao.pwdFindEnd(paraMap);
		return count;
	}// end of public boolean pwdFindEnd(Map<String, String> paraMap) {}--------------------


	// === 임시 비밀번호를 DB 에 업데이트 === //
	@Override
	public int certPassword(Map<String, String> paraMap) {
		int result = dao.certPassword(paraMap);
		return result;
	}// end of public int certPassword(String certPassword) {}-------------------------


	// === 조직도 불러오기 === //
	@Override
	public List<EmployeeVO> empList() {
		List<EmployeeVO> empList = dao.empList();
		return empList;
	}// end of public List<EmployeeVO> empList() {}---------------------
	
	// === 부서 불러오기 === //
	@Override
	public List<String> deptList() {
		List<String> deptList = dao.deptList();
		return deptList;
	}// end of public List<EmployeeVO> empList() {}---------------------


	// 로그인 기록 확인하기
	@Override
	public int getLoginHistory(String emp_no) {
		int count = dao.getLoginHistory(emp_no);
		return count;
	}// end of public int getLoginHistory(String emp_no) {}------------------------

}
