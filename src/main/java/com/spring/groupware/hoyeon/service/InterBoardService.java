package com.spring.groupware.hoyeon.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.hoyeon.model.BoardVO;
import com.spring.groupware.hoyeon.model.CommentVO;
import com.spring.groupware.hoyeon.model.FileVO;
import com.spring.groupware.hoyeon.model.NoticeCommentVO;
import com.spring.groupware.hoyeon.model.NoticeVO;
import com.spring.groupware.yongjin.model.EmployeeVO;

public interface InterBoardService {
	
	//글쓰기 페이지 요청에 필요한 부서이름List 불러오기. 
	List<Map<String,String>> deptNameList();

	int addBoard(BoardVO boardvo);//첨부파일 없는 글쓰기	
	int add_withFile(BoardVO boardvo); //첨부파일이 있는 글쓰기 

	int totalBoardCnt(Map<String, String> paraMap);//총 게시글의 개수 구하기

	List<BoardVO> boardListSearchP(Map<String, String> paraMap);// 페이징 처리한 글목록 가져오기(검색을 포함한다.)

	int getGroupNoMax(); // 원글쓰기일 경우 groupno 의  최대값 알아오기.

	BoardVO getView(String seq, String loginemp_no);// 글조회수 증가와 함께 글1개를 조회를 해주는 것

	BoardVO getViewWithNoAddCount(String seq);// 글조회수 증가는 없고 단순히 글1개 조회만 하는 메서드

	int boardEdit(BoardVO boardvo);//글을 수정하는 메서드

	int boardDel(Map<String, String> paraMap);//글을 삭제하는 메서드

	int addComment(CommentVO commentvo);//덧글 쓰기 

	List<CommentVO> getCommentListPaging(Map<String, String> paraMap);//페이징처리한 덧글 읽어오기. 

	int getCommentTotalCount(Map<String, String> paraMap); //댓글 총페이지수(totalPage)구하기

	
	///////////////////////////////////////////////////////
	
	int add_FileUpload(FileVO filevo);//파일업로드  

	int getFileTotalCount();//파일게시판 총 게시글 건수

	List<FileVO> fileListSearchWithPaging(Map<String, String> paraMap);//페이징처리한 파일 목록리스트 불러오기

	FileVO fileboard(String seq);//클릭한 글 번호로 무슨 파일인지 알아오기(1개 글보기랑 비슷)

	int fileboardDel(Map<String, Object> paraMap);//파일 삭제하기

	List<Map<String, String>> fileNameList(Map<String, Object> paraMap);//삭제할 파일명을 얻어온다.
	
	int downloadCntUpdate(String seq);//다운로드 횟수 +1
	///////////////////////////////////////////////////////

	int totalNoticeCnt(Map<String, String> paraMap);//총 공지게시글의 개수 구하기

	List<NoticeVO> noticeListSearchP(Map<String, String> paraMap);// 페이징 처리한 글목록 가져오기(검색을 포함한다.)

	int addNotice(NoticeVO noticevo);//첨부파일 없는 공지글쓰기

	int add_withFileNotice(NoticeVO noticevo);//첨부파일 있는 공지글쓰기

	NoticeVO getnoticeView(String seq, String loginemp_no);// 조회수 증가와 함께 공지글1개를 조회를 해주는 메소드

	NoticeVO noticeViewWithNoAddCount(String seq);// 조회수 증가없이 함께 공지글1개를 조회를 해주는 메소드

	int noticeEdit(NoticeVO noticevo);//공지게시판 수정하기 

	int noticeDel(Map<String, String> paraMap);//공지게시판 삭제하기 

	int noticeAddComment(NoticeCommentVO commentvo);//공지게시판 덧글쓰기 

	List<NoticeCommentVO> getNoticeCommentListPaging(Map<String, String> paraMap);//총 덧글의 리스트를 페이징처리해서 가져오기

	int getNoticeCommentTotalCount(Map<String, String> paraMap);// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기 

	 

	

	
	

 

	 
	

	 


}
