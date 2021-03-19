package com.spring.groupware.hoyeon.model;

import java.util.List;
import java.util.Map;

import com.spring.groupware.yongjin.model.EmployeeVO;

public interface InterBoardDAO {
	
	//==일반 부서별 게시판///////////////////////////////////////////////////////////
	
	List<Map<String,String>> deptNameList();//글쓰기 페이지 요청에 필요한 부서이름List 불러오기. 

	int addBoard(BoardVO boardvo);//첨부파일이 없는 글쓰기
	int add_withFile(BoardVO boardvo);//첨부파일이 있는 글쓰기 

	int totalBoardCnt(Map<String, String> paraMap);//총 게시글의 글 개수

	List<BoardVO> boardListSearchP(Map<String, String> paraMap);// 페이징 처리한 글목록 가져오기(검색을 포함한다.)

	int getGroupNoMax(); // 원글쓰기일 경우 groupno 의  최대값 알아오기.

	BoardVO getView(String seq);// 글조회수 증가와 함께 글1개를 조회를 해주는 것

	void setAddReadCount(String seq);// 글조회수 1증가 하기 

	int boardEdit(BoardVO boardvo);//글 수정 메서드 

	int boardDel(Map<String, String> paraMap);//글 삭제 메서드

	int addComment(CommentVO commentvo);//덧글쓰기

	List<CommentVO> getCommentListPaging(Map<String, String> paraMap);//댓글 페이징처리해서 읽어오기 

	int getCommentTotalCount(Map<String, String> paraMap);//총페이지수(totalPage)구하기

	int updateCommentCount(String parentSeq);////덧글이 insert되면 tbl_board 에 덧글 수를 업데이트 해주기 

	
	//==자료실 게시판///////////////////////////////////////////////////////////
	
	int add_FileUpload(FileVO filevo);//파일 업로드

	int getFileTotalCount();//총 파일수 세어보기

	List<FileVO> fileListSearchWithPaging(Map<String, String> paraMap);//페이징처리한 파일 리스트 

	FileVO fileboard(String seq);//1개의 파일 다운로드를 위해 조회하기

	int fileboardDel(Map<String, Object> paraMap);//파일 삭제하기

	List<Map<String, String>> fileNameList(Map<String, Object> paraMap);//삭제할 파일명 알아오기

	//==공지사항 게시판///////////////////////////////////////////////////////////
	int totalNoticeCnt(Map<String, String> paraMap);//총 공지게시글의 개수 구하기

	List<NoticeVO> noticeListSearchP(Map<String, String> paraMap);// 페이징 처리한 글목록 가져오기(검색을 포함한다.)

	int addNotice(NoticeVO noticevo);//첨부파일 없는 공지글쓰기
	int add_withFileNotice(NoticeVO noticevo);//첨부파일 있는 공지글쓰기

	NoticeVO noticeView(String seq);//공지글 하나 조회

	void setNoticeReadCount(String seq);//공지글 조회수 1 증가하기 

	int noticeEdit(NoticeVO noticevo);//공지게시판 수정하기 

	int noticeDel(Map<String, String> paraMap);//공지게시판 삭제하기

	int noticeAddComment(NoticeCommentVO commentvo);//공지게시판 덧글쓰기 

	int updateNoticeCommentCount(String parentSeq);//공지게시판에 덧글이 insert되면 공지게시판에 덧글개수가 +1 되어지는 메소드 

	List<NoticeCommentVO> getNoticeCommentListPaging(Map<String, String> paraMap);//총 덧글의 리스트를 페이징처리해서 가져오기

	int getNoticeCommentTotalCount(Map<String, String> paraMap);// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기 

	int downloadCntUpdate(String seq);	//파일 다운로드 시 다운로드 횟수 증가
 
	


}
