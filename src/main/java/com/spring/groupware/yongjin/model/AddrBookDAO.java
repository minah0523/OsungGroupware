package com.spring.groupware.yongjin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AddrBookDAO implements InterAddrBookDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	// === 사원 수 count === //
	@Override
	public int empNumber(Map<String, String> paraMap) {
		int count = sqlsession.selectOne("common.empNumber", paraMap);
		return count;
	}// end of public int empNumber() {}---------------------

	
	// === 사원 목록 가져오기 === //
	@Override
	public List<EmployeeVO> empList(Map<String, String> paraMap) {
		List<EmployeeVO> empList = sqlsession.selectList("common.empList", paraMap);
		return empList;
	}// end of public List<EmployeeVO> empList() {}--------------------


	// === 전사 주소록에서 사원 정보 상세보기 === //
	@Override
	public EmployeeVO detailContact(String emp_no) {
		EmployeeVO empvo = sqlsession.selectOne("common.detailContact", emp_no);
		return empvo;
	}// end of public EmployeeVO detailContact(String emp_no) {}---------------------


	// === 개인 주소록 count === //
	@Override
	public int idv_contactsNumber(Map<String, String> paraMap) {
		int count = sqlsession.selectOne("yongjin.idv_contactsNumber", paraMap);
		return count;
	}// end of public int idv_contactsNumber(Map<String, String> paraMap) {}---------------------


	// === 개인 주소록 목록 === //
	@Override
	public List<PersonalBookVO> idv_contactsList(Map<String, String> paraMap) {
		List<PersonalBookVO> pbList = sqlsession.selectList("yongjin.idv_contactsList", paraMap);
		return pbList;
	}// end of public List<PersonalBookVO> idv_contactsList(Map<String, String> paraMap) {}


	// === 개인 주소록에서 정보 상세보기 === //
	@Override
	public PersonalBookVO idv_detailContact(String book_no) {
		PersonalBookVO pbvo = sqlsession.selectOne("yongjin.idv_detailContact", book_no);
		return pbvo;
	}// end of public PersonalBookVO idv_detailContact(String book_no) {}-----------------------


	// === 개인 주소록 상세 정보 수정하기 === //
	@Override
	public int idv_detailContactRevise(PersonalBookVO pbvo) {
		int result = sqlsession.update("yongjin.idv_detailContactRevise", pbvo);
		return result;
	}// end of public int idv_detailContactRevise(int book_no) {}------------------------


	// === 개인 주소록 상세 정보 수정하기(+파일첨부) === //
	@Override
	public int idv_detailContactReviseWithFile(PersonalBookVO pbvo) {
		int result = sqlsession.update("yongjin.idv_detailContactReviseWithFile", pbvo);
		return result;
	}// end of public int idv_detailContactReviseWithFile(PersonalBookVO pbvo) {}----------------------


	// 개인 주소록 추가
	@Override
	public int addIdvBook(Map<String, String> paraMap) {
		int result = sqlsession.insert("yongjin.addIdvBook", paraMap);
		return result;
	}// end of public int addIdvBook(Map<String, String> paraMap) {}----------------------


	// 개인 주소록 목록 가져오기
	@Override
	public List<Map<String, String>> idvBookList(Map<String, String> paraMap) {
		List<Map<String, String>> bookList = sqlsession.selectList("yongjin.idvBookList", paraMap);
		return bookList;
	}


	// 개인 주소록 빠른 등록
	@Override
	public int idv_quickCreateContact(PersonalBookVO pbvo) {
		int result = sqlsession.insert("yongjin.idv_quickCreateContact", pbvo);
		return result;
	}


	// 개인 주소록 삭제
	@Override
	public int idv_detailContactDelete(String book_no) {
		int result = sqlsession.delete("yongjin.idv_detailContactDelete", book_no);
		return result;
	}

}
