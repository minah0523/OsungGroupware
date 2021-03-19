package com.spring.groupware.subin.model;

import java.util.List;
import java.util.Map;

public interface InterReservationDAO {

	// 나의 예약 목록을 읽어오는 함수
	List<ReservationVO> readRsvList(Map<String, String> paraMap);

	// 예약 상세보기 불러오기
	ReservationVO readDetailRsvList(Map<String, String> paraMap);

	// 예약 취소하기
	int rsvCancel(Map<String, String> paraMap);

	// 예약정보 불러오기(회원번호, 자원번호로 검색)
	List<ReservationVO> selectRsvList(Map<String, String> paraMap);

	// (modal) 예약하기 모달에 이용가능한 자원명 리스트를 select 해옴
	List<Reservation_resourceVO> readRsList();

	// 예약 테이블에 넣어줄 fk_resource_no 구해오기
	String findFk_resource_no(Map<String, String> paraMap);

	// 입력받은 일시가 중복된 날짜인지 검사
	int checkOverlapRsv(Map<String, String> paraMap);

	// (modal) 예약 테이블에 예약한 값 넣어주기
	int addModalRsv(Map<String, String> paraMap);

}
