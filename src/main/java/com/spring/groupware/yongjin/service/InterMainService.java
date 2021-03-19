package com.spring.groupware.yongjin.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.yongjin.model.EmployeeVO;

public interface InterMainService {

	// 로그인 처리하기
	EmployeeVO loginEnd(Map<String, String> paraMap);

	// 비밀번호 찾기 결과 보여주기
	int pwdFindEnd(Map<String, String> paraMap);

	// 임시 비밀번호를 DB 에 업데이트하기
	int certPassword(Map<String, String> paraMap);

	// 조직도 불러오기
	List<EmployeeVO> empList();
	// 부서 불러오기
	List<String> deptList();

	// 로그인 기록 확인하기
	int getLoginHistory(String emp_no);

}
