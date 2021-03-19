package com.spring.groupware.yongjin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.yongjin.model.EmployeeVO;
import com.spring.groupware.yongjin.model.InterAddrBookDAO;
import com.spring.groupware.yongjin.model.PersonalBookVO;

@Service
public class AddrBookService implements InterAddrBookService {
	
	@Autowired
	private InterAddrBookDAO dao;
	
	
	// === 사원 수 count === //
	@Override
	public int empNumber(Map<String, String> paraMap) {
		int count = dao.empNumber(paraMap);
		return count;
	}// end of public int empNumber() {}---------------------


	// === 사원 목록 가져오기 === //
	@Override
	public List<EmployeeVO> empList(Map<String, String> paraMap) {
		List<EmployeeVO> empList = dao.empList(paraMap);
		return empList;
	}// end of public List<EmployeeVO> empList() {}--------------------


	// === 전사 주소록에서 사원 정보 상세보기 === //
	@Override
	public EmployeeVO detailContact(String emp_no) {
		EmployeeVO empvo = dao.detailContact(emp_no);
		return empvo;
	}// end of public EmployeeVO detailContact(String emp_no) {}--------------------


	// === 개인 주소록 count === //
	@Override
	public int idv_contactsNumber(Map<String, String> paraMap) {
		int count = dao.idv_contactsNumber(paraMap);
		return count;
	}// end of public int idv_contactsNumber(Map<String, String> paraMap) {}----------------------


	// === 개인 주소록 목록 === //
	@Override
	public List<PersonalBookVO> idv_contactsList(Map<String, String> paraMap) {
		List<PersonalBookVO> pbList = dao.idv_contactsList(paraMap);
		return pbList;
	}// end of public List<PersonalBookVO> idv_contactsList(Map<String, String> paraMap) {}


	// === 개인 주소록에서 정보 상세보기 === //
	@Override
	public PersonalBookVO idv_detailContact(String book_no) {
		PersonalBookVO pbvo = dao.idv_detailContact(book_no);
		return pbvo;
	}// end of public PersonalBookVO idv_detailContact(String book_no) {}-----------------------


	// === 개인 주소록 상세 정보 수정하기 === //
	@Override
	public int idv_detailContactRevise(PersonalBookVO pbvo) {
		int result = dao.idv_detailContactRevise(pbvo);
		return result;
	}// end of public int idv_detailContactRevise(int book_no) {}----------------------


	// === 개인 주소록 상세 정보 수정하기(+파일첨부) === //
	@Override
	public int idv_detailContactReviseWithFile(PersonalBookVO pbvo) {
		int result = dao.idv_detailContactReviseWithFile(pbvo);
		return result;
	}// end of public int idv_detailContactReviseWithFile(PersonalBookVO pbvo) {}-------------------


	// 개인 주소록 추가
	@Override
	public int addIdvBook(Map<String, String> paraMap) {
		int result = dao.addIdvBook(paraMap);
		return result;
	}// end of public int addIdvBook(Map<String, String> paraMap) {}


	// 개인 주소록 목록 가져오기
	@Override
	public List<Map<String, String>> idvBookList(Map<String, String> paraMap) {
		List<Map<String, String>> bookList = dao.idvBookList(paraMap);
		return bookList;
	}


	// 개인 주소록 빠른 등록
	@Override
	public int idv_quickCreateContact(PersonalBookVO pbvo) {
		int result = dao.idv_quickCreateContact(pbvo);
		return result;
	}


	// 개인 주소록 삭제
	@Override
	public int idv_detailContactDelete(String book_no) {
		int result = dao.idv_detailContactDelete(book_no);
		return result;
	}

}
