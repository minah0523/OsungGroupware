package com.spring.groupware.jieun.model;

import java.util.List;
import java.util.Map;

import com.spring.groupware.yongjin.model.EmployeeVO;

public interface InterNoteDAO {
	
	// 사원테이블에서 전체 사원 리스트 가져와서 모달창에 보여주기
	List<EmployeeVO> findEmpListAll();

	// 사원테이블에서 부서에 따른 사원 리스트 가져와서 모달창에 보여주기
	List<EmployeeVO> findEmpList(Map<String, String> paraMap);

	// 사원테이블에서 입력한 이름에 따른 사원 리스트 가져와서 모달창에 보여주기
	List<EmployeeVO> empSearchList(Map<String, String> paraMap);
	
	// 쪽지테이블에 첨부파일이 없는 쪽지 insert 하기
	int write(NoteVO notevo);
	
	// 쪽지테이블에 첨부파일이 있는 쪽지 insert 하기
	int write_withFile(NoteVO notevo);	

	// 로그인한 사원번호로 보낸편지를 쪽지테이블에서 select 해서 보여주기
	List<NoteVO> sendList(Map<String, String> paraMap);
	
	// 보낸쪽지함에서 쪽지 상세 보기 select 하기
	NoteVO sendOneDetail(Map<String, String> paraMap);	
	
	// 쪽지 테이블에서 삭제가 아니라 note_no에 해당하는 보낸 사원 삭제 여부(보낸쪽지함에서 삭제 여부)의 상태를 1로 변경하기
	int updateFromTblNoteSendDelStatus(Map<String, String> paraMap);
	
	// 보낸쪽지함의 리스트 개수 얻어오기
	int getNoteSendTotalCount(Map<String, String> paraMap);	

	// 로그인한 사원번호로 받은편지를 쪽지테이블에서 select 해서 보여주기
	List<NoteVO> receiveList(Map<String, String> paraMap);
	
	// 받은 쪽지함  리스트 개수 얻어오기
	int getNoteReceiveTotalCount(Map<String, String> paraMap);
	
	// 받은편지함 리스트에서 제목클릭 시 read_status 컬럼 상태 1로 변경하기(update)
	int receiveReadCountChange(Map<String, String> paraMap);
	
	// 받은쪽지함에서 쪽지 상세 보기 select 하기
	NoteVO receiveOneDetail(Map<String, String> paraMap);	
	
	// 받은 쪽지함에서 선택한 쪽지번호를 가지고 휴지통 테이블에 insert 해주기(휴지통)
	int moveToTrashcan(Map<String, String> paraMap);
	
	// 받은 쪽지함에서 선택한 쪽지번호를 가지고 파일 없는 경우 insert
	int moveToTrashcanNoFile(Map<String, String> paraMap);	
	
	// 예약임시보관함 테이블을 휴지통 테이블에 insert 하기
	int moveToTrashcanReservation(Map<String, String> paraMap);
	
	// 예약임시보관함 테이블을 휴지통 테이블에 첨부파일 없는 경우 insert 하기 
	int moveToTrashcanReservationNoFile(Map<String, String> paraMap);	
	
	// 쪽지 임시보관함 테이블을 휴지통 테이블에 insert 하기
	int moveToTrashcanTemp(Map<String, String> paraMap);

	//쪽지 임시보관함 테이블을 휴지통 테이블에 파일 없는 경우 insert 하기 
	int moveToTrashcanTempNoFile(Map<String, String> paraMap);
	
	// 받은 쪽지함의  쪽지테이블에서 쪽지번호를 가지고 삭제하기 (delete) (휴지통)
	int deleteFromTblNote(Map<String, String> paraMap);	
	
	// 쪽지 테이블에서 삭제가 아니라 note_no에 해당하는 받은 사원 삭제 여부의 상태를 1로 변경하기
	int updateFromTblNoteReceiveDelStatus(Map<String, String> paraMap);	

	// 로그인한 사원번호로 받은편지 중 중요한 편지를 쪽지테이블에서 select 해서 보여주기
	List<NoteVO> importantList(Map<String, String> paraMap);
	
	// 중요쪽지함 리스트 개수 얻어오기
	int getNoteImportantTotalCount(Map<String, String> paraMap);	

	// 쪽지임시보관테이블에 첨부파일이 없는 쪽지 insert 하기
	int writeTemp(NoteTempVO noteTempvo);

	// 쪽지임시보관테이블에 첨부파일이 있는 쪽지 insert 하기	
	int writeTemp_withFile(NoteTempVO noteTempvo);
	
	// 임시보관함에서 제목클릭해서 들어왔을때 첨부파일이 있는경우 쪽지테이블에 따로 insert 하기
	int writeTempFileInsert(NoteVO notevo);	

	// 쪽지를 쓰다가 임시저장했을때 임시보관함 테이블에서 임시저장된 쪽지를 select 해서 보여주기
	List<NoteTempVO> tempList(Map<String, String> paraMap);

	// 임시보관함 리스트 개수 얻어오기
	int getNoteTempTotalCount(Map<String, String> paraMap);

	// 쪽지 삭제했을때 휴지통에 있는 목록 select 해서 보여주기
	List<NoteTrashVO> trashList(Map<String, String> paraMap);
	
	// 휴지통 리스트 개수 얻어오기
	int getNoteTrashTotalCount(Map<String, String> paraMap);
	
	// 휴지통 쪽지 상세 쪽지 보기 
	NoteTrashVO trashOneDetail(Map<String, String> paraMap);

	// 휴지통에서 삭제버튼 눌렀을때 휴지통에서 note_no를 삭제
	int deleteFromTblTrash(Map<String, String> paraMap);	
	
	// 쪽지 예약 임시 보관함테이블에 첨부파일에 첨부파일이 없는 쪽지 insert 하기
	int writeReservationTemp(NoteReservationTempVO noteResTempvo);

	// 쪽지 예약 임시 보관함테이블에 첨부파일에 첨부파일이 있는 쪽지 insert 하기
	int writeReservationTemp_withFile(NoteReservationTempVO noteResTempvo);

	// 쪽지 예약 임시테이블에서 select 해오기(페이징 처리)
	List<NoteReservationTempVO> getReservationTempList(Map<String, String> paraMap);
	
	// 예약 발송 했을떄 select 해오는 예약 임시보관함 리스트
	List<NoteReservationTempVO> reservationTempList();	
	
	// 예약 쪽지함 리스트 개수 얻어오기
	int getNoteReservationTotalCount(Map<String, String> paraMap);
	
	// 예약 쪽지함 상세 쪽지 보기
	NoteReservationTempVO reservationOneDetail(Map<String, String> paraMap);	

	// 쪽지 테이블에 파일과 함께 예약 상태 insert 하기
	int write_withFileAndReservation(NoteVO notevo);

	// 쪽지 테이블에 파일 없이 예약 상태 insert 하기 
	int write_withReservation(NoteVO notevo);	
	
	// 예약 임시보관테이블에서 예약 발송이 성공되어지면 삭제하기 
	int deleteFromTblReservationTemp(String note_no);

	// 휴지통 테이블에서 휴지통 자체를 비우기(delete)
	int deleteFromTblTrashClear(int note_del_login_emp_no);

	// 임시보관함에서 쪽지번호로 수정할 쪽지 조회해오기 (select)
	NoteTempVO writeModifySelect(Map<String, String> paraMap);

	// 임시보관함에서 쪽지 쓰기의 보내기를 한 경우 클릭해서 들어온 임시보관함의 note_no를 삭제
	int deleteFromTblTemp(Map<String, String> paraMap);

}
