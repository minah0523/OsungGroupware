package com.spring.groupware.jieun.service;

import java.text.SimpleDateFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.spring.groupware.jieun.model.InterNoteDAO;
import com.spring.groupware.jieun.model.NoteReservationTempVO;
import com.spring.groupware.jieun.model.NoteTempVO;
import com.spring.groupware.jieun.model.NoteTrashVO;
import com.spring.groupware.jieun.model.NoteVO;
import com.spring.groupware.yongjin.model.EmployeeVO;

@Service
public class NoteService implements InterNoteService {

	@Autowired
	private InterNoteDAO dao;
	
	// 사원테이블에서 전체 사원 리스트 가져와서 모달창에 보여주기
	@Override
	public List<EmployeeVO> findEmpListAll() {
		List<EmployeeVO> empAllList = dao.findEmpListAll();
		return empAllList;
	}
	
	// 사원테이블에서 부서에 따른 사원 리스트 가져와서 모달창에 보여주기
	@Override
	public List<EmployeeVO> findEmpList(Map<String, String> paraMap) {
		List<EmployeeVO> empList = dao.findEmpList(paraMap);
		return empList;
	}
	
	// 사원테이블에서 입력한 이름에 따른 사원 리스트 가져와서 모달창에 보여주기
	@Override
	public List<EmployeeVO> empSearchList(Map<String, String> paraMap) {
		List<EmployeeVO> empSearchList = dao.empSearchList(paraMap);
		return empSearchList;
	}
	
	// 쪽지테이블에 첨부파일이 없는 쪽지 insert 하기
	@Override
	public int write(NoteVO notevo) {
		int n = dao.write(notevo);
		return n;
	}
	
	// 쪽지테이블에 첨부파일이 있는 쪽지 insert 하기
	@Override
	public int write_withFile(NoteVO notevo) {
		int n = dao.write_withFile(notevo);
		return n;
	}
	
	// 임시보관함에서 제목클릭해서 들어왔을때 첨부파일이 있는경우 쪽지테이블에 따로 insert 하기
	@Override
	public int writeTempFileInsert(NoteVO notevo) {
		int n = dao.writeTempFileInsert(notevo);
		return n;
	}
	
	// 로그인한 사원번호로 보낸편지를 쪽지테이블에서 select 해서 보여주기
	@Override
	public List<NoteVO> sendList(Map<String, String> paraMap) {
		List<NoteVO> noteSendList = dao.sendList(paraMap);
		return noteSendList;
	}
	
	// 보낸쪽지함에서 쪽지 상세 보기 select 하기
	@Override
	public NoteVO sendOneDetail(Map<String, String> paraMap) {
		NoteVO notevo = dao.sendOneDetail(paraMap);
		return notevo;
	}
	
	// 쪽지 테이블에서 삭제가 아니라 note_no에 해당하는 보낸 사원 삭제 여부(보낸쪽지함에서 삭제 여부)의 상태를 1로 변경하기
	@Override
	public int updateFromTblNoteSendDelStatus(Map<String, String> paraMap) {
		int n = dao.updateFromTblNoteSendDelStatus(paraMap);
		return n;
	}
	
	// 보낸쪽지함의 리스트 개수 얻어오기
	@Override
	public int getNoteSendTotalCount(Map<String, String> paraMap) {
		int n = dao.getNoteSendTotalCount(paraMap);
		return n;
	}	
	
	// 로그인한 사원번호로 받은편지를 쪽지테이블에서 select 해서 보여주기
	@Override
	public List<NoteVO> receiveList(Map<String, String> paraMap) {
		List<NoteVO> noteReceiveList = dao.receiveList(paraMap);
		return noteReceiveList;
	}
	
	// 받은 쪽지함  리스트 개수 얻어오기
	@Override
	public int getNoteReceiveTotalCount(Map<String, String> paraMap) {
		int n = dao.getNoteReceiveTotalCount(paraMap);
		return n;
	}
	
	// 받은편지함 리스트에서 제목클릭 시 read_status 컬럼 상태 1로 변경하기(update)
	@Override
	public int receiveReadCountChange(Map<String, String> paraMap) {
		int n = dao.receiveReadCountChange(paraMap);
		return n;
	}
	
	// 받은쪽지함에서 쪽지 상세 보기 select 하기
	@Override
	public NoteVO receiveOneDetail(Map<String, String> paraMap) {
		NoteVO notevo = dao.receiveOneDetail(paraMap);
		return notevo;
	}
	
	// 받은 쪽지함에서 선택한 쪽지번호를 가지고 휴지통 테이블에 insert 해주기(휴지통) 
	@Override
	public int moveToTrashcan(Map<String, String> paraMap) {
		int n = dao.moveToTrashcan(paraMap);
		return n;
	}
	
	// 받은 쪽지함에서 선택한 쪽지번호를 가지고 파일 없는 경우 insert
	@Override
	public int moveToTrashcanNoFile(Map<String, String> paraMap) {
		int n = dao.moveToTrashcanNoFile(paraMap);
		return n;
	}
	
	// 예약임시보관함 테이블을 휴지통 테이블에 insert 하기
	@Override
	public int moveToTrashcanReservation(Map<String, String> paraMap) {
		int n = dao.moveToTrashcanReservation(paraMap);
		return n;
	}
	
	// 예약임시보관함 테이블을 휴지통 테이블에 첨부파일 없는 경우 insert 하기 
	@Override
	public int moveToTrashcanReservationNoFile(Map<String, String> paraMap) {
		int n = dao.moveToTrashcanReservationNoFile(paraMap);
		return n;
	}
	
	// 쪽지 임시보관함 테이블을 휴지통 테이블에 insert 하기
	@Override
	public int moveToTrashcanTemp(Map<String, String> paraMap) {
		int n = dao.moveToTrashcanTemp(paraMap);
		return n;
	}
	
	//쪽지 임시보관함 테이블을 휴지통 테이블에 파일 없는 경우 insert 하기 
	@Override
	public int moveToTrashcanTempNoFile(Map<String, String> paraMap) {
		int n = dao.moveToTrashcanTempNoFile(paraMap);
		return n;
	}
	
	// 받은 쪽지함의  쪽지테이블에서 쪽지번호를 가지고 삭제하기 (delete) (휴지통)
	@Override
	public int deleteFromTblNote(Map<String, String> paraMap) {
		int n = dao.deleteFromTblNote(paraMap);
		return n;
	}
	
	// 쪽지 테이블에서 삭제가 아니라 note_no에 해당하는 받은 사원 삭제 여부의 상태를 1로 변경하기
	@Override
	public int updateFromTblNoteReceiveDelStatus(Map<String, String> paraMap) {
		int n = dao.updateFromTblNoteReceiveDelStatus(paraMap);
		return n;
	}
	
	// 로그인한 사원번호로 받은편지 중 중요한 편지를 쪽지테이블에서 select 해서 보여주기
	@Override
	public List<NoteVO> importantList(Map<String, String> paraMap) {
		List<NoteVO> noteImportantList = dao.importantList(paraMap);
		return noteImportantList;
	}
	
	// 중요쪽지함 리스트 개수 얻어오기
	@Override
	public int getNoteImportantTotalCount(Map<String, String> paraMap) {
		int n = dao.getNoteImportantTotalCount(paraMap);
		return n;
	}
	
	// 쪽지임시보관테이블에 첨부파일이 없는 쪽지 insert 하기
	@Override
	public int writeTemp(NoteTempVO noteTempvo) {
		int n = dao.writeTemp(noteTempvo);
		return n;
	}
	
	// 쪽지임시보관테이블에 첨부파일이 있는 쪽지 insert 하기
	@Override
	public int writeTemp_withFile(NoteTempVO noteTempvo) {
		int n = dao.writeTemp_withFile(noteTempvo);
		return n;
	}
	
	// 쪽지를 쓰다가 임시저장했을때 임시보관함 테이블에서 임시저장된 쪽지를 select 해서 보여주기
	@Override
	public List<NoteTempVO> tempList(Map<String, String> paraMap) {
		List<NoteTempVO> noteTempList = dao.tempList(paraMap);
		return noteTempList;
	}
	
	// 임시보관함 리스트 개수 얻어오기
	@Override
	public int getNoteTempTotalCount(Map<String, String> paraMap) {
		int n = dao.getNoteTempTotalCount(paraMap);
		return n;
	}
	
	// 쪽지 삭제했을때 휴지통에 있는 목록 select 해서 보여주기
	@Override
	public List<NoteTrashVO> trashList(Map<String, String> paraMap) {
		List<NoteTrashVO> noteTrashList = dao.trashList(paraMap);
		return noteTrashList;
	}
	
	// 휴지통 리스트 개수 얻어오기
	@Override
	public int getNoteTrashTotalCount(Map<String, String> paraMap) {
		int n = dao.getNoteTrashTotalCount(paraMap);
		return n;
	}
	
	// 휴지통 쪽지 상세 쪽지 보기 
	@Override
	public NoteTrashVO trashOneDetail(Map<String, String> paraMap) {
		NoteTrashVO noteTrashvo = dao.trashOneDetail(paraMap);
		return noteTrashvo;
	}
	
	// 휴지통에서 삭제버튼 눌렀을때 휴지통에서 note_no를 삭제
	@Override
	public int deleteFromTblTrash(Map<String, String> paraMap) {
		int n = dao.deleteFromTblTrash(paraMap);
		return n;
	}
	
	// 쪽지 예약 임시 보관함테이블에 첨부파일에 첨부파일이 없는 쪽지 insert 하기
	@Override
	public int writeReservationTemp(NoteReservationTempVO noteResTempvo) {
		int n = dao.writeReservationTemp(noteResTempvo);
		return n;
	}
	
	// 쪽지 예약 임시 보관함테이블에 첨부파일에 첨부파일이 있는 쪽지 insert 하기
	@Override
	public int writeReservationTemp_withFile(NoteReservationTempVO noteResTempvo) {
		int n = dao.writeReservationTemp_withFile(noteResTempvo);
		return n;
	}
	
	// 스프링 스케줄러를 사용하여 예약 발송 하기 
	@Override
	@Scheduled(cron="0 * * * * *")
	public void reservationNoteSending() {
		// <주의> 스케줄러로 사용되어지는 메소드는 반드시 파라미터가 없어야 한다.!!!!
	      
	      // === 현재시각 나타내기 === //
	      Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간을 얻어온다. 
	      SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
	      // System.out.println("Note에서 현재시각은 => " + df.format(currentDate.getTime()));
	      // Note에서 현재시각은 => 2020-12-23 14:41
	      // Note에서 현재시각은 => 2020-12-23 14:42
	      
	      // 예약임시테이블에서 select 한 결과의 년, 월, 일, 시, 분과 자바에서 구한 현재 년, 월, 일, 시, 분이 같다면
	      // 쪽지 테이블에 insert 하기 
	      
	      // 예약 임시보관테이블에서 select 해오기 
	      List<NoteReservationTempVO> reservationTempList = dao.reservationTempList();
	      
	      /*
	      for(NoteReservationTempVO reserTempvo : reservationTempList) {
				System.out.println("보낸사원ID==>" + reserTempvo.getFk_emp_no_send());
				System.out.println("사원명==>" + reserTempvo.getEmp_name());
				System.out.println("제목==>" + reserTempvo.getNote_title());
				System.out.println("날짜==>" + reserTempvo.getNote_write_date());	
				System.out.println("쪽지 번호 ==> " + reserTempvo.getNote_no());
				System.out.println("예약 설정 시간 ==> " + reserTempvo.getNote_reservation_date());
		  }	      
	     */
	      
	      int n = 0;
	      
	      // 쪽지 보내기 //
	      if(reservationTempList != null && reservationTempList.size()>0) {
	    	  // reservationTempList 의 값이 null이 아니고 0보다 커야한다.
	    	  
	    	  for(int i=0; i<reservationTempList.size(); i++) {
	    		    /*
					System.out.println("예약 보낸사원ID==>" + reservationTempList.get(i).getFk_emp_no_send());
					System.out.println("예약 사원명==>" + reservationTempList.get(i).getFk_emp_name());
					System.out.println("예약 제목==>" + reservationTempList.get(i).getNote_title());
					System.out.println("예약 쪽지 번호 ==> " + reservationTempList.get(i).getNote_no());
					System.out.println("예약 설정 시간 ==> " + reservationTempList.get(i).getNote_reservation_date());
					// 예약 설정 시간 ==>     2020-12-23 14:50
					// Note에서 현재시각은 => 2020-12-23 14:42
					*/
					
	    		  if( reservationTempList.get(i).getNote_reservation_date().equals(df.format(currentDate.getTime())) ) {
	    			  
	    			  // System.out.println("if문으로 들어와 지니??@@@@@@@");
	    			  // System.out.println("if문 안에서 예약 시간 test ===> " + reservationTempList.get(i).getNote_reservation_date());
	    			  // System.out.println("if문 안에서 예약 시간 현재시간 ===> " + df.format(currentDate.getTime()));
	    			  
	    			  // if문으로 들어와 지니??@@@@@@@
	    			  // if문 안에서 예약 시간 test ===>  2020-12-23 15:10
	    		      // if문 안에서 예약 시간 현재시간 ===> 2020-12-23 15:10
	    			  
	    			  NoteVO notevo = new NoteVO();
	    			  
	    			  notevo.setFk_emp_no_send( reservationTempList.get(i).getFk_emp_no_send() );
	    			  notevo.setFk_emp_no_receive( reservationTempList.get(i).getFk_emp_no_receive() );
	    			  notevo.setFk_emp_name( reservationTempList.get(i).getFk_emp_name() );
	    			  notevo.setNote_title( reservationTempList.get(i).getNote_title() );
	    			  notevo.setNote_content( reservationTempList.get(i).getNote_content() );
	    			  notevo.setNote_filename( reservationTempList.get(i).getNote_filename() );
	    			  notevo.setNote_orgfilename( reservationTempList.get(i).getNote_orgfilename() );
	    			  notevo.setNote_filesize( reservationTempList.get(i).getNote_filesize() );
	    			  notevo.setNote_important( reservationTempList.get(i).getNote_important() );
	    			  notevo.setNote_reservation_status( reservationTempList.get(i).getNote_reservation_status() );
	    			  notevo.setNote_read_status(reservationTempList.get(i).getNote_read_status());
	    			  
	    			  // 작성시간은 보내지는 insert되는 시간을 자동으로 설정할 예정(예약시간)
	    			  
	    			  // notevo.setNote_reservation_date( reservationTempList.get(i).getNote_reservation_date() );
	    			  
	    			  // 파일이 null이 아니면 파일이 있는 경우
	    			  if( reservationTempList.get(i).getNote_filename() != null ) { 
		    			  // 쪽지 테이블에 파일이 있고 예약 상태 insert 하기
		    			  n = dao.write_withFileAndReservation(notevo);
	    			  }
	    			  else {
	    				  // 쪽지 테이블로 첨부 파일 없고 예약 상태 insert 하기 
	    				  n = dao.write_withReservation(notevo);  
	    			  }
	    			  
	    		  } // end of if()----------------------------
	    		  else {
	    			  // System.out.println("아아아아아아!!!!!if문 아님");
	    		  }
	    		  
	    	  } // end of for()------------------------------
	    	  
	    	  int m = 0; // 삭제용 변수
	    	  
			  if(n == 1) {
				  // 예약 발송 성공
				  System.out.println("@@@@@ 예약 시간에 맞춰 발송 되었습니다. @@@@@");
				  
				  // 메일 발송이 성공하는 순간 예약 임시보관 테이블 비워버리기
				  if(reservationTempList != null && reservationTempList.size()>0) {
			    	  // reservationTempList 의 값이 null이 아니고 0보다 커야한다.
			    	  
			    	  for(int i=0; i<reservationTempList.size(); i++) {
			    		  
			    		  // 예약임시보관테이블에는 예약시간이 되면 쪽지테이블로 이동하면서 비워져야 한다. 
			    		  // 그러므로 reservationTempList 길이만큼 반복해서 note_no를 넘기면서 삭제한다. 
			    		  m = dao.deleteFromTblReservationTemp(reservationTempList.get(i).getNote_no());
			    	  }
				  }
				  
				  if(m == 1) {
					  System.out.println("@@@@@ 예약 임시보관 테이블에서 삭제되었습니다. @@@@@@");
				  }
				  else {
					  System.out.println("@@@@@ 예약 임시보관 테이블에서 삭제가 실패되었습니다. @@@@@@");
				  }

			  }
			  else {
				  // 예약 발송 실패
				  System.out.println("@@@@@ 예약 시간에 맞춰 발송이 실패되었습니다. @@@@@");
			  }
	    	  

	      } // end of if(reservationTempList != null && reservationTempList.size()>0) ----------------------------
	      
	} // end of public void reservationNoteSending() {} --------------------------
	
	// 쪽지 예약 임시보관함에서 select 해서 mav로 넘기기 위함
	@Override
	public List<NoteReservationTempVO> getReservationTempList(Map<String, String> paraMap) {
		// 예약 임시보관테이블에서 select 해오기 
	    List<NoteReservationTempVO> reservationTempList = dao.getReservationTempList(paraMap);
	    return reservationTempList;
	}
	
	// 예약 쪽지함 리스트 개수 얻어오기
	@Override
	public int getNoteReservationTotalCount(Map<String, String> paraMap) {
		int n = dao.getNoteReservationTotalCount(paraMap);
		return n;
	}
	
	// 예약 쪽지함 상세 쪽지 보기
	@Override
	public NoteReservationTempVO reservationOneDetail(Map<String, String> paraMap) {
		NoteReservationTempVO noteReservationTempvo = dao.reservationOneDetail(paraMap);
		return noteReservationTempvo;
	}
	
	// 예약임시보관함테이블에서 해당 note_no를 삭제하기
	@Override
	public int deleteFromTblNoteReservationTemp(String note_no) {
		int n = dao.deleteFromTblReservationTemp(note_no);
		return n;
	}
	
	// 휴지통 테이블에서 휴지통 자체를 비우기(delete)
	@Override
	public int deleteFromTblTrashClear(int note_del_login_emp_no) {
		int n = dao.deleteFromTblTrashClear(note_del_login_emp_no);
		return n;
	}
	
	// 임시보관함에서 쪽지번호로 수정할 쪽지 조회해오기 (select)
	@Override
	public NoteTempVO writeModifySelect(Map<String, String> paraMap) {
		NoteTempVO noteTempvo = dao.writeModifySelect(paraMap);
		return noteTempvo;
	}
	
	// 임시보관함에서 쪽지 쓰기의 보내기를 한 경우 클릭해서 들어온 임시보관함의 note_no를 삭제
	@Override
	public int deleteFromTblTemp(Map<String, String> paraMap) {
		int n = dao.deleteFromTblTemp(paraMap);
		return n;
	}
	
}
