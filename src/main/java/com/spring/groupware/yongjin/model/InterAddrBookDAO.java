package com.spring.groupware.yongjin.model;

import java.util.List;
import java.util.Map;

public interface InterAddrBookDAO {
	
	// 사원 수 count
	int empNumber(Map<String, String> paraMap);

	// 사원 목록
	List<EmployeeVO> empList(Map<String, String> paraMap);

	// 전사 주소록에서 사원 정보 상세보기
	EmployeeVO detailContact(String emp_no);

	// 개인 주소록 count
	int idv_contactsNumber(Map<String, String> paraMap);

	// 개인 주소록 목록
	List<PersonalBookVO> idv_contactsList(Map<String, String> paraMap);

	// 개인 주소록에서 정보 상세보기
	PersonalBookVO idv_detailContact(String book_no);

	// 개인 주소록 상세 정보 수정하기
	int idv_detailContactRevise(PersonalBookVO pbvo);

	// 개인 주소록 상세 정보 수정하기(+파일첨부)
	int idv_detailContactReviseWithFile(PersonalBookVO pbvo);

	// 개인 주소록 추가
	int addIdvBook(Map<String, String> paraMap);

	// 개인 주소록 목록 가져오기
	List<Map<String, String>> idvBookList(Map<String, String> paraMap);

	// 개인 주소록 빠른 등록
	int idv_quickCreateContact(PersonalBookVO pbvo);

	// 개인 주소록 삭제
	int idv_detailContactDelete(String book_no);

}
