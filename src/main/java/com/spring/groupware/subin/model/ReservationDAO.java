package com.spring.groupware.subin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReservationDAO implements InterReservationDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 나의 예약 목록을 읽어오는 함수
	@Override
	public List<ReservationVO> readRsvList(Map<String, String> paraMap) {
		
		List<ReservationVO> rsvList = sqlsession.selectList("reservation.readRsvList", paraMap);
		
		return rsvList;
	}
	
	// 예약 상세보기 불러오기
	@Override
	public ReservationVO readDetailRsvList(Map<String, String> paraMap) {
		
		ReservationVO rsvvo = sqlsession.selectOne("reservation.readDetailRsvList", paraMap);
		
		return rsvvo;
	}
	
	// 예약 취소하기
	@Override
	public int rsvCancel(Map<String, String> paraMap) {
		
		int n = sqlsession.delete("reservation.rsvCancel", paraMap);
		
		return n;
	}
	
	// 예약정보 불러오기(회원번호, 자원번호로 검색)
	@Override
	public List<ReservationVO> selectRsvList(Map<String, String> paraMap) {
		
		List<ReservationVO> rsvList = sqlsession.selectList("reservation.selectRsvList", paraMap);
		
		return rsvList;
	}
	
	// (modal) 예약하기 모달에 이용가능한 자원명 리스트를 select 해옴
	@Override
	public List<Reservation_resourceVO> readRsList() {
		
		List<Reservation_resourceVO> rsvo = sqlsession.selectList("reservation.readRsList");
		
		return rsvo;
	}
	
	// 예약 테이블에 넣어줄 fk_resource_no 구해오기
	@Override
	public String findFk_resource_no(Map<String, String> paraMap) {
		
		String fk_resource_no = sqlsession.selectOne("reservation.findFk_resource_no", paraMap);
		
		return fk_resource_no;
	}
	
	// 입력받은 일시가 중복된 날짜인지 검사
	@Override
	public int checkOverlapRsv(Map<String, String> paraMap) {
		
		int overlap = sqlsession.selectOne("reservation.checkOverlapRsv", paraMap);
		
		return overlap;
	}
	
	// (modal) 예약 테이블에 예약한 값 넣어주기
	@Override
	public int addModalRsv(Map<String, String> paraMap) {
		
		int n = sqlsession.insert("reservation.addModalRsv", paraMap);
		
		return n;
	}
	
}
