package com.spring.groupware.hoyeon.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.yongjin.model.EmployeeVO;

@Repository
public class BoardDAO implements InterBoardDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	//부서 이름을 알아온다.	
	@Override
	public List<Map<String,String>> deptNameList() {
		 List<Map<String,String>> deptNameList = sqlsession.selectList("board.deptNameList");
		 return deptNameList;
	}

	//첨부파일이 없는 글쓰기 
	@Override
	public int addBoard(BoardVO boardvo) {
		int addBoard = sqlsession.insert("board.addBoard",boardvo);
		return addBoard;
	}

	//첨부파일이 있는 글쓰기
	@Override
	public int add_withFile(BoardVO boardvo) {
		int add_withFile=sqlsession.insert("board.add_withFile",boardvo);
		return add_withFile;
	}
	
    //게시글 개수 세오기
	@Override
	public int totalBoardCnt(Map<String, String> paraMap) {
		int totalBoardCnt = sqlsession.selectOne("board.totalBoardCnt",paraMap);
		return totalBoardCnt;
	}

	//페이징 처리한 글 목록을 불러온다(검색있음)
	@Override
	public List<BoardVO> boardListSearchP(Map<String, String> paraMap) {
		List<BoardVO> boardListSearchP = sqlsession.selectList("board.boardListSearchP",paraMap);
		return boardListSearchP;
	}

	// 원글쓰기일 경우 groupno 의  최대값 알아오기.
	@Override
	public int getGroupNoMax() {
		int getGroupNoMax =  sqlsession.selectOne("board.getGroupNoMax");
		return getGroupNoMax;
	}


	//글 1개 조회하기
	@Override
	public BoardVO getView(String seq) {
		BoardVO getView = sqlsession.selectOne("board.getView",seq);
		return getView;
	}

	//조회수 1 증가하기 
	@Override
	public void setAddReadCount(String seq) {
		 sqlsession.update("board.setAddReadCount",seq);
	}

	//글 수정 
	@Override
	public int boardEdit(BoardVO boardvo) {
		
		int n = sqlsession.update("board.boardEdit",boardvo);
		
		return n ;
	}

	//글 삭제
	@Override
	public int boardDel(Map<String, String> paraMap) {
		int n = sqlsession.delete("board.boardDel",paraMap);
		return n;
	}

	
	//댓글쓰기
	@Override
	public int addComment(CommentVO commentvo) {
		int n =sqlsession.insert("board.addComment",commentvo);
		return n;
	}
	
	
	//덧글이 insert되면 tbl_board 에 덧글 수를 업데이트 해주기 
		@Override
		public int updateCommentCount(String parentSeq) {
			 int n = sqlsession.update("board.updateCommentCount",parentSeq);
			return n;
		}
	
	//댓글 페이징 처리해서 읽어오기
	@Override
	public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<CommentVO>getCommentListPaging=sqlsession.selectList("board.getCommentListPaging",paraMap);
		return getCommentListPaging;
	}

	
	//총페이지수(totalPage)구하기
	@Override
	public int getCommentTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("board.getCommentTotalCount",paraMap);
		return n;
	}

	///////////////////////////////////////////////////////////
	//파일 업로드
	@Override
	public int add_FileUpload(FileVO filevo) { 
		
		int n =sqlsession.insert("board.add_FileUpload",filevo);
		 
		return n;
	}

	//파일의 총 갯수
	@Override
	public int getFileTotalCount() {
		int n = sqlsession.selectOne("board.getFileTotalCount");
		return n ;
	}

	//파일 리스트 페이징처리해서 읽어오기 
	@Override
	public List<FileVO> fileListSearchWithPaging(Map<String, String> paraMap) {
		 List<FileVO>fileList = sqlsession.selectList("board.fileListSearchWithPaging",paraMap);
		return fileList;
	}

	
	//1개의 파일 다운로드를 위해 조회하기
	@Override
	public FileVO fileboard(String seq) {
		 FileVO fileboard=sqlsession.selectOne("board.fileboard",seq);
		return fileboard;
	}
	
	//파일 삭제하기
	@Override
	public int fileboardDel(Map<String, Object> paraMap) {
		int n = sqlsession.delete("board.fileboardDel",paraMap);
		return n;
	}
	
	//삭제할 파일명 알아오기
	@Override
	public List<Map<String, String>> fileNameList(Map<String, Object> paraMap) {
		 List<Map<String,String>>fileNameList = sqlsession.selectList("board.fileNameList",paraMap);
		return fileNameList;
	}
	
	///////////////////////////////////////////////////////////
	//총 공지게시글의 개수 구하기
	@Override
	public int totalNoticeCnt(Map<String, String> paraMap) {
		 int totalNoticeCnt = sqlsession.selectOne("board.totalNoticeCnt",paraMap);
		return totalNoticeCnt;
	}

	// 페이징 처리한 글목록 가져오기(검색을 포함한다.)
	@Override
	public List<NoticeVO> noticeListSearchP(Map<String, String> paraMap) {
		List<NoticeVO>noticeListSearchP=sqlsession.selectList("board.noticeListSearchP",paraMap);
		return noticeListSearchP;
	}

	//첨부파일 없는 공지글쓰기
	@Override
	public int addNotice(NoticeVO noticevo) {
		int n = sqlsession.insert("board.addNotice",noticevo);
		return n;
	}
	//첨부파일 있는 공지글쓰기
	@Override
	public int add_withFileNotice(NoticeVO noticevo) {
		 int n = sqlsession.insert("board.add_withFileNotice",noticevo);
		return n;
	}

	//공지글 하나 조회
	@Override
	public NoticeVO noticeView(String seq) {
		NoticeVO noticeView = sqlsession.selectOne("board.noticeView",seq);
		return noticeView;
	}

	//공지글 조회수 1증가 
	@Override
	public void setNoticeReadCount(String seq) {
		
		sqlsession.update("board.setNoticeReadCount",seq);
	}

	//공지게시판 수정하기 
	@Override
	public int noticeEdit(NoticeVO noticevo) {
		int n = sqlsession.update("board.noticeEdit",noticevo);
		return n;
	}

	//공지게시판 삭제하기 
	@Override
	public int noticeDel(Map<String, String> paraMap) {
		int n = sqlsession.delete("board.noticeDel",paraMap);
		return n;
	}

	//공지게시판 덧글쓰기 
	@Override
	public int noticeAddComment(NoticeCommentVO commentvo) {
		int n = sqlsession.insert("board.noticeAddComment",commentvo);
		return n;
	}
	//공지게시판에 덧글이 insert되면 공지게시판에 덧글개수가 +1 되어지는 메소드 
	@Override
	public int updateNoticeCommentCount(String parentSeq) {
		int n = sqlsession.update("board.updateNoticeCommentCount",parentSeq);
		return n;
	}

	//총 덧글의 리스트를 페이징처리해서 가져오기
	@Override
	public List<NoticeCommentVO> getNoticeCommentListPaging(Map<String, String> paraMap) {
	List<NoticeCommentVO>commentList=sqlsession.selectList("board.getNoticeCommentListPaging",paraMap);
		return commentList;
	}

	// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기 
	@Override
	public int getNoticeCommentTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("board.getNoticeCommentTotalCount",paraMap);
		return n;
	}

	//파일 다운로드 시 다운로드 횟수 증가
	@Override
	public int downloadCntUpdate(String seq) {
		 int n = sqlsession.update("board.downloadCntUpdate",seq);
		return n;
	}

 



}
