package com.spring.groupware.jieun.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.yongjin.model.EmployeeVO;

@Repository  
public class NoteDAO implements InterNoteDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession; 
	
	// 사원테이블에서 전체 사원 리스트 가져와서 모달창에 보여주기
	@Override
	public List<EmployeeVO> findEmpListAll() {
		List<EmployeeVO> empAllList = sqlsession.selectList("note.findEmpListAll");
		return empAllList;
	}
	
	// 사원테이블에서 사원 리스트 가져와서 모달창에 보여주기
	@Override
	public List<EmployeeVO> findEmpList(Map<String, String> paraMap) {
		
		List<EmployeeVO> empList = sqlsession.selectList("note.findEmpList", paraMap);
		return empList;
	}
	
	// 사원테이블에서 입력한 이름에 따른 사원 리스트 가져와서 모달창에 보여주기
	@Override
	public List<EmployeeVO> empSearchList(Map<String, String> paraMap) {
		List<EmployeeVO> empSearchList = sqlsession.selectList("note.empSearchList", paraMap);
		return empSearchList;
	}
	
	// 쪽지테이블에 첨부파일이 없는 쪽지 insert 하기
	@Override
	public int write(NoteVO notevo) {
		int n = sqlsession.insert("note.write", notevo);
		return n;
	}
	
	// 쪽지테이블에 첨부파일이 있는 쪽지 insert 하기
	@Override
	public int write_withFile(NoteVO notevo) {
		int n = sqlsession.insert("note.write_withFile", notevo);
		return n;
	}
	
	// 임시보관함에서 제목클릭해서 들어왔을때 첨부파일이 있는경우 쪽지테이블에 따로 insert 하기
	@Override
	public int writeTempFileInsert(NoteVO notevo) {
		int n = sqlsession.insert("note.writeTempFileInsert", notevo);
		return n;
	}
	
	// 로그인한 사원번호로 보낸편지를 쪽지테이블에서 select 해서 보여주기
	@Override
	public List<NoteVO> sendList(Map<String, String> paraMap) {
		List<NoteVO> noteSendList = sqlsession.selectList("note.sendList", paraMap);
		return noteSendList;
	}
	
	// 보낸쪽지함에서 쪽지 상세 보기 select 하기
	@Override
	public NoteVO sendOneDetail(Map<String, String> paraMap) {
		NoteVO notevo = sqlsession.selectOne("note.sendOneDetail", paraMap);
		return notevo;
	}
	
	// 쪽지 테이블에서 삭제가 아니라 note_no에 해당하는 보낸 사원 삭제 여부(보낸쪽지함에서 삭제 여부)의 상태를 1로 변경하기
	@Override
	public int updateFromTblNoteSendDelStatus(Map<String, String> paraMap) {
		int n = sqlsession.update("note.updateFromTblNoteSendDelStatus", paraMap);
		return n;
	}
	
	// 보낸쪽지함의 리스트 개수 얻어오기
	@Override
	public int getNoteSendTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("note.getNoteSendTotalCount", paraMap);
		return n;
	}
	
	// 로그인한 사원번호로 받은편지를 쪽지테이블에서 select 해서 보여주기
	@Override
	public List<NoteVO> receiveList(Map<String, String> paraMap) {
		List<NoteVO> noteReceiveList = sqlsession.selectList("note.receiveList", paraMap);
		return noteReceiveList;
	}
	
	// 받은 쪽지함  리스트 개수 얻어오기
	@Override
	public int getNoteReceiveTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("note.getNoteReceiveTotalCount", paraMap);
		return n;
	}
	
	// 받은편지함 리스트에서 제목클릭 시 read_status 컬럼 상태 1로 변경하기(update)
	@Override
	public int receiveReadCountChange(Map<String, String> paraMap) {
		int n = sqlsession.update("note.receiveReadCountChange", paraMap);
		return n;
	}
	
	// 받은쪽지함에서 쪽지 상세 보기 select 하기
	@Override
	public NoteVO receiveOneDetail(Map<String, String> paraMap) {
		NoteVO notevo = sqlsession.selectOne("note.receiveOneDetail", paraMap);
		return notevo;
	}
	
	// 받은 쪽지함에서 선택한 쪽지번호를 가지고 휴지통 테이블에 insert 해주기(휴지통)
	@Override
	public int moveToTrashcan(Map<String, String> paraMap) {
		int n = sqlsession.insert("note.moveToTrashcan", paraMap);
		return n;
	}
	
	// 받은 쪽지함에서 선택한 쪽지번호를 가지고 파일 없는 경우 insert
	@Override
	public int moveToTrashcanNoFile(Map<String, String> paraMap) {
		int n = sqlsession.insert("note.moveToTrashcanNoFile", paraMap);
		return n;
	}
	
	// 예약임시보관함 테이블을 휴지통 테이블에 insert 하기
	@Override
	public int moveToTrashcanReservation(Map<String, String> paraMap) {
		int n = sqlsession.insert("note.moveToTrashcanReservation", paraMap);
		return n;
	}
	
	// 예약임시보관함 테이블을 휴지통 테이블에 첨부파일 없는 경우 insert 하기 
	@Override
	public int moveToTrashcanReservationNoFile(Map<String, String> paraMap) {
		int n = sqlsession.insert("note.moveToTrashcanReservationNoFile", paraMap);
		return n;
	}
	
	// 쪽지 임시보관함 테이블을 휴지통 테이블에 insert 하기
	@Override
	public int moveToTrashcanTemp(Map<String, String> paraMap) {
		int n = sqlsession.insert("note.moveToTrashcanTemp", paraMap);
		return n;
	}
	
	//쪽지 임시보관함 테이블을 휴지통 테이블에 파일 없는 경우 insert 하기 
	@Override
	public int moveToTrashcanTempNoFile(Map<String, String> paraMap) {
		int n = sqlsession.insert("note.moveToTrashcanTempNoFile", paraMap);
		return n;
	}
	
	// 받은 쪽지함의  쪽지테이블에서 쪽지번호를 가지고 삭제하기 (delete) (휴지통)
	@Override
	public int deleteFromTblNote(Map<String, String> paraMap) {
		int n = sqlsession.delete("note.deleteFromTblNote", paraMap);
		return n;
	}
	
	// 쪽지 테이블에서 삭제가 아니라 note_no에 해당하는 받은 사원 삭제 여부의 상태를 1로 변경하기
	@Override
	public int updateFromTblNoteReceiveDelStatus(Map<String, String> paraMap) {
		int n = sqlsession.update("note.updateFromTblNoteReceiveDelStatus", paraMap);
		return n;
	}
	
	// 로그인한 사원번호로 받은편지 중 중요한 편지를 쪽지테이블에서 select 해서 보여주기
	@Override
	public List<NoteVO> importantList(Map<String, String> paraMap) {
		List<NoteVO> noteImportantList = sqlsession.selectList("note.importantList", paraMap);
		return noteImportantList;
	}
	
	// 중요쪽지함 리스트 개수 얻어오기
	@Override
	public int getNoteImportantTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("note.getNoteImportantTotalCount", paraMap);
		return n;
	}
	
	// 쪽지임시보관테이블에 첨부파일이 없는 쪽지 insert 하기
	@Override
	public int writeTemp(NoteTempVO noteTempvo) {
		int n = sqlsession.insert("note.writeTemp", noteTempvo);
		return n;
	}
	
	// 쪽지임시보관테이블에 첨부파일이 있는 쪽지 insert 하기
	@Override
	public int writeTemp_withFile(NoteTempVO noteTempvo) {
		int n = sqlsession.insert("note.writeTemp_withFile", noteTempvo);
		return n;
	}
	
	// 쪽지를 쓰다가 임시저장했을때 임시보관함 테이블에서 임시저장된 쪽지를 select 해서 보여주기
	@Override
	public List<NoteTempVO> tempList(Map<String, String> paraMap) {
		List<NoteTempVO> noteTempList = sqlsession.selectList("note.tempList", paraMap);
		return noteTempList;
	}
	
	// 임시보관함 리스트 개수 얻어오기
	@Override
	public int getNoteTempTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("note.getNoteTempTotalCount", paraMap);
		return n;
	}
	
	// 쪽지 삭제했을때 휴지통에 있는 목록 select 해서 보여주기
	@Override
	public List<NoteTrashVO> trashList(Map<String, String> paraMap) {
		List<NoteTrashVO> noteTrashList = sqlsession.selectList("note.trashList", paraMap);
		return noteTrashList;
	}
	
	// 휴지통 리스트 개수 얻어오기 
	@Override
	public int getNoteTrashTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("note.getNoteTrashTotalCount", paraMap);
		return n;
	}
	
	// 휴지통 쪽지 상세 쪽지 보기 
	@Override
	public NoteTrashVO trashOneDetail(Map<String, String> paraMap) {
		NoteTrashVO noteTrashvo = sqlsession.selectOne("note.trashOneDetail", paraMap);
		return noteTrashvo;
	}
	
	// 휴지통에서 삭제버튼 눌렀을때 휴지통에서 note_no를 삭제
	@Override
	public int deleteFromTblTrash(Map<String, String> paraMap) {
		int n = sqlsession.delete("note.deleteFromTblTrash", paraMap);
		return n;
	}
	
	// 쪽지 예약 임시 보관함테이블에 첨부파일에 첨부파일이 없는 쪽지 insert 하기
	@Override
	public int writeReservationTemp(NoteReservationTempVO noteResTempvo) {
		int n = sqlsession.insert("note.writeReservationTemp", noteResTempvo);
		return n;
	}
	
	// 쪽지 예약 임시 보관함테이블에 첨부파일에 첨부파일이 있는 쪽지 insert 하기
	@Override
	public int writeReservationTemp_withFile(NoteReservationTempVO noteResTempvo) {
		int n = sqlsession.insert("note.writeReservationTemp_withFile", noteResTempvo);
		return n;
	}
	
	// 예약 임시보관테이블에서 select 해오기 
	@Override
	public List<NoteReservationTempVO> getReservationTempList(Map<String, String> paraMap) {
		List<NoteReservationTempVO> reservationTempList = sqlsession.selectList("note.getReservationTempList", paraMap);
		return reservationTempList;
	}
	
	// 예약 발송 했을떄 select 해오는 예약 임시보관함 리스트
	@Override
	public List<NoteReservationTempVO> reservationTempList() {
		List<NoteReservationTempVO> reservationTempList = sqlsession.selectList("note.reservationTempList");
		return reservationTempList;
	}
	
	// 예약 쪽지함 리스트 개수 얻어오기
	@Override
	public int getNoteReservationTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("note.getNoteReservationTotalCount", paraMap);
		return n;
	}
	
	// 예약 쪽지함 상세 쪽지 보기
	@Override
	public NoteReservationTempVO reservationOneDetail(Map<String, String> paraMap) {
		NoteReservationTempVO noteReservationTempvo = sqlsession.selectOne("note.reservationOneDetail", paraMap);
		return noteReservationTempvo;
	}
	
	// 쪽지 테이블에 파일과 함께 예약 상태 insert 하기
	@Override
	public int write_withFileAndReservation(NoteVO notevo) {
		int n = sqlsession.insert("note.write_withFileAndReservation", notevo);
		return n;
	}
	
	// 쪽지 테이블에 파일 없이 예약 상태 insert 하기 
	@Override
	public int write_withReservation(NoteVO notevo) {
		int n = sqlsession.insert("note.write_withReservation", notevo);
		return n;
	}
	
	// 예약 임시보관테이블에서 예약 발송이 성공되어지면 삭제하기
	@Override
	public int deleteFromTblReservationTemp(String note_no) {
		int n = sqlsession.delete("note.deleteFromTblReservationTemp", note_no);
		return n;
	}
	
	// 휴지통 테이블에서 휴지통 자체를 비우기(delete)
	@Override
	public int deleteFromTblTrashClear(int note_del_login_emp_no) {
		int n = sqlsession.delete("note.deleteFromTblTrashClear", note_del_login_emp_no);
		return n;
	}
	
	// 임시보관함에서 쪽지번호로 수정할 쪽지 조회해오기 (select)
	@Override
	public NoteTempVO writeModifySelect(Map<String, String> paraMap) {
		NoteTempVO noteTempvo = sqlsession.selectOne("note.writeModifySelect", paraMap);
		return noteTempvo;
	}
	
	// 임시보관함에서 쪽지 쓰기의 보내기를 한 경우 클릭해서 들어온 임시보관함의 note_no를 삭제
	@Override
	public int deleteFromTblTemp(Map<String, String> paraMap) {
		int n = sqlsession.delete("note.deleteFromTblTemp", paraMap);
		return n;
	}

}
