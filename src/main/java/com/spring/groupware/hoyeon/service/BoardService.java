package com.spring.groupware.hoyeon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.hoyeon.model.BoardVO;
import com.spring.groupware.hoyeon.model.CommentVO;
import com.spring.groupware.hoyeon.model.FileVO;
import com.spring.groupware.hoyeon.model.InterBoardDAO;
import com.spring.groupware.hoyeon.model.NoticeCommentVO;
import com.spring.groupware.hoyeon.model.NoticeVO;
 

@Service
public class BoardService implements InterBoardService{

	@Autowired
	private InterBoardDAO dao;
	
	
	//글쓰기 페이지 요청에 필요한 부서이름List 불러오기. 
	@Override
	public List<Map<String,String>> deptNameList() {
		List<Map<String,String>> deptNameList = dao.deptNameList();
		return deptNameList;
	}


	//첨부파일 없는 글쓰기
	@Override
	public int addBoard(BoardVO boardvo) {
		 int addBoard = dao.addBoard(boardvo);
		return addBoard;
	}

	//첨부파일 있는 글쓰기
	@Override
	public int add_withFile(BoardVO boardvo) {
		int add_withFile = dao.add_withFile(boardvo);
		return add_withFile;
	}
	
	//총 게시글의 글 개수
	@Override
	public int totalBoardCnt(Map<String, String> paraMap) {
		 int totalBoardCnt = dao.totalBoardCnt(paraMap);
		return totalBoardCnt;
	}

	
	// 페이징 처리한 글목록 가져오기(검색을 포함한다.)
	@Override
	public List<BoardVO> boardListSearchP(Map<String, String> paraMap) {
		List<BoardVO> boardListSearchP = dao.boardListSearchP(paraMap);
		return boardListSearchP;
	}


	// 원글쓰기일 경우 groupno 의  최대값 알아오기.
	@Override
	public int getGroupNoMax() {
		int groupnoMax = dao.getGroupNoMax();
		return groupnoMax;
	}

	// 글조회수 증가와 함께 글1개를 조회를 해주는 것
	@Override
	public BoardVO getView(String seq, String loginemp_no) {
        // login_userid 는 로그인을 한 상태이라면 로그인한 사용자의 userid 이고, 
        // 로그인을 하지 않은 상태이라면 login_userid 는 null 이다. 

		BoardVO boardvo = dao.getView(seq); // 글1개 조회하기  

		if(loginemp_no != null && boardvo != null && 
		!loginemp_no.equals(boardvo.getFk_emp_no()) ) {
		// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 해야 한다. 
		
		dao.setAddReadCount(seq);   //글조회수 1증가 하기 
		boardvo = dao.getView(seq); //글을 조회해오기
		}
		
		return boardvo;
	}

	//조회수 증가 없이 글 1개를 조회해주는 것 
	@Override
	public BoardVO getViewWithNoAddCount(String seq) {
		BoardVO boardvo = dao.getView(seq); // 글1개 조회하기  
		
		return boardvo;
	}

	//글 수정 메서드
	@Override
	public int boardEdit(BoardVO boardvo) {
		int n = dao.boardEdit(boardvo);
		return n;
	}

	//글 삭제 메서드
	@Override
	public int boardDel(Map<String, String> paraMap) {
		 int n = dao.boardDel(paraMap);
		return n;
	}


	//덧글 쓰기
	@Override
	public int addComment(CommentVO commentvo) {
		int n=0, m=0;
		
		 n = dao.addComment(commentvo);//댓글을 쓰면 DB에 insert해준다.
		 
		 if(n==1) {
			 m=dao.updateCommentCount(commentvo.getParentSeq());
			 //덧글이 insert되면 tbl_board 에 덧글 수를 업데이트 해주기 
		 }
		return m;
	}

	//덧글 페이징처리해서 읽어오기 
	@Override
	public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {
		 List<CommentVO> getCommentListPaging = dao.getCommentListPaging(paraMap);
		return getCommentListPaging;
	}

	//총페이지수(totalPage)구하기
	@Override
	public int getCommentTotalCount(Map<String, String> paraMap) {
		int n = dao.getCommentTotalCount(paraMap);
		return n;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////
	//파일 업로드
	@Override
	public int add_FileUpload(FileVO filevo) {
		int add_FileUpload = dao.add_FileUpload(filevo);
		return add_FileUpload;
	}

	//총 파일수 세어보기
	@Override
	public int getFileTotalCount() {
		 int n = dao.getFileTotalCount();
		return n;
	}

	//페이징처리한 파일 리스트 
	@Override
	public List<FileVO> fileListSearchWithPaging(Map<String, String> paraMap) {
		List<FileVO> fileList = dao.fileListSearchWithPaging(paraMap);
		return fileList;
	}

	//1개의 파일 다운로드를 위해 조회하기
	@Override
	public FileVO fileboard(String seq) {
		FileVO fileboard =dao.fileboard(seq);
		return fileboard;
	}

	//파일 삭제하기
	@Override
	public int fileboardDel(Map<String, Object> paraMap) {
		int n = dao.fileboardDel(paraMap);
		return n;
	}
	
	//삭제할 파일명을 알아온다.
	@Override
	public List<Map<String, String>> fileNameList(Map<String, Object> paraMap) {
		List<Map<String,String>>fileNameList = dao.fileNameList(paraMap);
		return fileNameList;
	}

	/////////////////////////////////////////////////////////////////////////////////////////
	//총 공지게시글의 개수 구하기
	@Override
	public int totalNoticeCnt(Map<String, String> paraMap) {
		 int totalNoticeCnt = dao.totalNoticeCnt(paraMap);
			return totalNoticeCnt;
	}

	// 페이징 처리한 글목록 가져오기(검색을 포함한다.)
	@Override
	public List<NoticeVO> noticeListSearchP(Map<String, String> paraMap) {
		List<NoticeVO>noticeListSearchP=dao.noticeListSearchP(paraMap);
		return noticeListSearchP;
	}

	//첨부파일 없는 공지글쓰기
	@Override
	public int addNotice(NoticeVO noticevo) {
		int n = dao.addNotice(noticevo);
		return n;
	}

	//첨부파일 있는 공지글쓰기
	@Override
	public int add_withFileNotice(NoticeVO noticevo) {
		 int n = dao.add_withFileNotice(noticevo);
		return n;
	}

	//조회수 증가와 함께 공지글1개를 조회를 해주는 메소드
	@Override
	public NoticeVO getnoticeView(String seq, String loginemp_no) {
	
		NoticeVO noticevo = dao.noticeView(seq); // 글1개 조회하기  

		if(loginemp_no != null && noticevo != null && 
		!loginemp_no.equals(noticevo.getFk_emp_no()) ) {
		// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 해야 한다. 
		
		dao.setNoticeReadCount(seq);   //글조회수 1증가 하기 
		noticevo = dao.noticeView(seq); //공지글 하나를 조회해오기
		
		}
	
		return noticevo;
	}

	// 조회수 증가와 함께 공지글1개를 조회를 해주는 메소드
	@Override
	public NoticeVO noticeViewWithNoAddCount(String seq) {
		NoticeVO noticevo = dao.noticeView(seq); // 공지 글1개 조회하기  

		return noticevo;
	}


	//공지게시판 수정하기 
	@Override
	public int noticeEdit(NoticeVO noticevo) {
		int n = dao.noticeEdit(noticevo);
		return n;
	}
	
	
	//공지게시판 삭제하기 
	@Override
	public int noticeDel(Map<String, String> paraMap) {
		 int n = dao.noticeDel(paraMap);
		return n ;
	}

	//공지게시판 덧글쓰기 
	@Override
	public int noticeAddComment(NoticeCommentVO commentvo) {
		int n=0, m=0;
		
		 n = dao.noticeAddComment(commentvo);//댓글을 쓰면 DB에 insert해준다.
		 
		 if(n==1) {
			 m=dao.updateNoticeCommentCount(commentvo.getParentSeq());
			 //덧글이 insert되면 tbl_notice_board 에 덧글 수를 업데이트 해주기 
		 }
		return m;
	}

	//총 덧글의 리스트를 페이징처리해서 가져오기
	@Override
	public List<NoticeCommentVO> getNoticeCommentListPaging(Map<String, String> paraMap) {
		List<NoticeCommentVO> commentList = dao.getNoticeCommentListPaging(paraMap);
		
		return commentList;
	}


	// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기 
	@Override
	public int getNoticeCommentTotalCount(Map<String, String> paraMap) {
		int n = dao.getNoticeCommentTotalCount(paraMap);
		return n;
	}


	//파일 다운로드 시 다운로드 횟수 증가
	@Override
	public int downloadCntUpdate(String seq) {

		int n = dao.downloadCntUpdate(seq);
		
		return n ;
		
	}


 

 


	


	
	
}
