package com.spring.groupware.hoyeon.controller;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.hoyeon.model.CommentVO;
import com.spring.groupware.hoyeon.model.FileVO;
import com.spring.groupware.hoyeon.model.NoticeCommentVO;
import com.spring.groupware.hoyeon.model.NoticeVO;
import com.spring.groupware.common.common.FileManager;
import com.spring.groupware.common.common.MyUtil;
import com.spring.groupware.hoyeon.model.BoardVO;
import com.spring.groupware.hoyeon.service.InterBoardService;
import com.spring.groupware.yongjin.model.EmployeeVO;

@Controller
public class BoardController {

   @Autowired // Type에 따라 알아서 Bean 을 주입해준다.
   private InterBoardService service;
   
   
   @Autowired // Type에 따라 알아서 Bean 을 주입해준다.
   private FileManager fileManager;
   
    
      //글 목록 보기
     
     @RequestMapping(value="/boardList.os") public ModelAndView
     boardList(HttpServletRequest request, ModelAndView mav) {
        List<BoardVO> boardList = null;
        
        //부서이름을 가져온다. 
         // List<Map<String,String>> deptNameList = service.deptNameList();
       //가져온 부서 이름과 현재 보는 글 목록의 부서가 일치하면 그 부서 이름만을 가져오도록 한다. 
         // String deptName = service.deptNameOne(deptNameList);
      
       String searchType = request.getParameter("searchType");//검색타입
        String searchWord = request.getParameter("searchWord");//검색한 단어
       String str_currentShowPageNo = request.getParameter("currentShowPageNo");
       // 현재 있는 페이지 번호 
      //무슨 부서의 게시판인지 선택한 게시판의 부서번호를 불러온다. 
      String fk_dept_no = request.getParameter("fk_dept_no");
   //   System.out.println("fk_dept_no>>>"+fk_dept_no);
      
       if(searchType == null ) {
          searchType = "";
       }
         
      if(searchWord == null || searchWord.trim().isEmpty() ) {
         searchWord = "";
      }
      
      if(!"".equals(searchType) && !"".equals(searchWord)) {
          System.out.println("searchWord ==> "+searchWord);
          System.out.println("searchType ===> "+searchType);
      }
      
      Map<String,String> paraMap = new HashMap<>();
      paraMap.put("searchType",searchType);
      paraMap.put("searchWord",searchWord);
      
      paraMap.put("fk_dept_no",fk_dept_no);
      
    
      // 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
      int totalCount = 0;         // 총 게시물 건수
      int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
      int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
      int totalPage = 0;          // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
      
      int startRno = 0;           // 시작 행번호
      int endRno = 0;             // 끝 행번호 
      
      //총 게시물 수를 가져온다      
      totalCount = service.totalBoardCnt(paraMap);
      //총 게시물 수로 총 페이지를 구한다.
       
       
      totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
      
      if(str_currentShowPageNo==null) {
         currentShowPageNo=1;
         
      }else {
         try {
            currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
            if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
               currentShowPageNo = 1;
               //사용자가 자기 마음대로 url에 값을 넣는걸 방지하기 위해서!!
            }
         } catch(NumberFormatException e) {
            currentShowPageNo = 1;
         }//end of try~catch---------------------------
      }//end of if-------------------------------
      
      //시작 페이지와 끝 페이지를 구하는 공식.
      startRno = ((currentShowPageNo-1)*sizePerPage)+1;
      endRno = startRno + sizePerPage - 1; 
      
      paraMap.put("startRno",String.valueOf(startRno));
      paraMap.put("endRno",String.valueOf(endRno));
      
      boardList = service.boardListSearchP(paraMap);
      // 페이징 처리한 글목록 가져오기(검색을 포함한다.)
      
      
      
      if(!"".equals(searchWord)) {
         mav.addObject("paraMap", paraMap);
         //검색 단어가 있다면 넘겨준다.
      }
      
      String pageBar = "<ul style='list-style: none;'>";
      
      int blockSize = 10;
      //페이지 번호의 개수.
      int loop = 1;
      //1부터 증가하고 1개 블럭을 이루는 페이지 번호의 개수. 10개까지만 증가함.
      
      //공식이다.페이지 번호!!
      int pageNo = ((currentShowPageNo-1)/blockSize)*blockSize+1;
      
      String url = "boardList.os";
      
      if(pageNo!=1) { //페이지 번호가 1이 아니라면. 맨 처음의 페이지가 아닌 경우[맨처음   ] 과 [이전]을 만든다.
         pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?fk_dept_no="+fk_dept_no+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
         pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?fk_dept_no="+fk_dept_no+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
      }
      
      //1씩 증가하는 숫자가 블럭사이즈를 초과했거나(불가능함!)
      //페이지 번호가 총 페이지 수를 넘어갔다면(불가능함!) 
      //-이 아니라면. 아래의 while문을 실행한다.
      while(!(loop>blockSize || pageNo>totalPage)) {

         if(pageNo == currentShowPageNo) {//페이지 번호가 현재 보는 페이지 번호와 같을 때.
            pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 0px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
         }
         else {//아니라면 클릭했을때는 그 페이지로 이동하도록 한다. 
            pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?fk_dept_no="+fk_dept_no+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
         }
         
         loop++;
         pageNo++;
      }
      
      // [다음][마지막]  ===
      if( !(pageNo > totalPage) ) {
         pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?fk_dept_no="+fk_dept_no+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo+1)+"'>[다음]</a></li>";
         pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?fk_dept_no="+fk_dept_no+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
         }
      
      pageBar+="</ul>";
      ///////////////////////////////////페이징 처리 끝.
      
      String goBackURL = MyUtil.getCurrentURL(request);
      
      //새로고침 했을때 조회수가 증가되는걸 막기 위해서 session 으로 처리한다.
      HttpSession session = request.getSession();
      session.setAttribute("readCountPermission", "yes");
      // session 에  "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면  반드시 웹브라우저에서 주소창에 "/boardList.os" 이라고 입력해야만 얻어올 수 있다. 
      
      
       
      mav.addObject("boardList",boardList);
      mav.addObject("pageBar",pageBar);
      mav.addObject("goBackURL",goBackURL); 
              
       mav.setViewName("hoyeon/board/boardList.tiles1");
     
     return mav; 
     }
    
   
   //게시판 글쓰기 페이지 요청
   @RequestMapping(value="/boardAdd.os")
   public ModelAndView requiredLogin_boardAdd(HttpServletRequest request, HttpServletResponse response,ModelAndView mav) {
      
       //부서이름을 가져온다. 
       List<Map<String,String>> deptNameList = service.deptNameList();
       
       String fk_dept_no = request.getParameter("fk_dept_no");
       
       //답변글쓰기를 위해 넘겨줄 값들./////////////////////////////
          String fk_seq = request.getParameter("fk_seq");
         String groupno = request.getParameter("groupno");
         String depthno = request.getParameter("depthno");
         
         
      
       // 원글쓰기이라면 groupno 의 값은 현재 존재하고 있늩 groupno 최대값 + 1 로 한다.
          if(groupno == null) { //  원글쓰기인 경우임.
             groupno = String.valueOf(service.getGroupNoMax() + 1);
          }
         
         mav.addObject("fk_seq", fk_seq);
         mav.addObject("groupno", groupno);
         mav.addObject("depthno", depthno);
       //////////////////////////////////////////////////
       
       //부서이름을 view 단으로 넘겨준다.
       mav.addObject("deptNameList",deptNameList);
       
       mav.addObject("fk_dept_no",fk_dept_no);
       
       mav.setViewName("hoyeon/board/boardAdd.tiles1");
      
      return mav;
   }

   //게시판 글쓰기 완료 요청
   @RequestMapping(value="/boardAddEnd.os", method= {RequestMethod.POST})
   public String boardAddEnd(Map<String,String>paraMap,BoardVO boardvo,MultipartHttpServletRequest mrequest) {
      
      MultipartFile file = boardvo.getFile();
      if( !file.isEmpty() ) {
         // file(첨부파일)가 비어있지 않으면(즉, 첨부파일이 있는 경우라면) 
         
      
            //>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
            //우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
      
         // WAS의 webapp 의 절대경로.
         HttpSession session = mrequest.getSession();
         String root = session.getServletContext().getRealPath("/");
         //System.out.println("~~~~ webapp 의 절대경로 => " + root);
   
         String path = root+"resources"+ File.separator +"files";

         // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
         System.out.println("~~~~ path => " + path);
         
      /*
          파일첨부를 위한 변수의 설정 및 값을 초기화  
      */
         String newFileName = "";
         // WAS(톰캣)의 디스크에 저장될 파일명 
         
         byte[] bytes = null;
         // 첨부파일의 내용물을 담는 것  
         
         long fileSize = 0;
         // 첨부파일의 크기 
         
         try {
            bytes = file.getBytes();
            // 첨부파일의 내용물을 읽어오는 것 
            
            newFileName = fileManager.doFileUpload(bytes, file.getOriginalFilename(), path); 
            // 첨부되어진 파일을 업로드 하도록 하는 것이다. 
            // attach.getOriginalFilename() 은 첨부파일의 파일명(예: 강아지.png)이다.
            
            System.out.println(">>> 확인용  newFileName => " + newFileName);
            // >>> 확인용  newFileName => 20201219192838210592889629700.jpg
             
            boardvo.setFileName(newFileName);
            // WAS(톰캣)에 저장될 파일명 
            
            boardvo.setOrgFilename(file.getOriginalFilename());
            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
            
            fileSize = file.getSize(); // 첨부파일의 크기(단위는 byte임)
            boardvo.setFileSize(String.valueOf(fileSize));
         
         } catch(Exception e) {
            e.printStackTrace();
         }
         
      }
      // === !!! 첨부파일이 있는 경우 작업 끝  !!! ===
 
      int n = 0;
      
      // 첨부파일이 없는 경우라면
      if(file.isEmpty()) {
         n = service.addBoard(boardvo);
      }
      else {
      // 첨부파일이 있는 경우라면 
         n = service.add_withFile(boardvo);
      }
         
      if(n==1) {
         String fk_dept_no = boardvo.getFk_dept_no();
         return "redirect:/boardList.os?fk_dept_no="+fk_dept_no;   
 
      }
      else {
         return "redirect:/boardAdd.os";   
          
      }
         
      }
      

   //1개의 글 보기 
   @RequestMapping(value="/boardView.os")
   public ModelAndView boardView(HttpServletRequest request,ModelAndView mav) {
      
   String seq = request.getParameter("seq");
   
   //현재 페이지의 주소를 뷰단으로 넘겨준다.
   String gobackURL = request.getParameter("gobackURL");  
   
   if(gobackURL != null) {
       gobackURL = gobackURL.replaceAll(" ", "&"); // 이전글, 다음글을 클릭해서 넘어온 것이다.
        //System.out.println("###### 확인용 gobackURL : " + gobackURL);
       // ###### 확인용 gobackURL : list.action?searchType=&searchWord=&currentShowPageNo=2 
       
       mav.addObject("gobackURL", gobackURL);
    }
    try {
         Integer.parseInt(seq);
         
         HttpSession session = request.getSession();
          EmployeeVO loginemp = (EmployeeVO) session.getAttribute("loginemp");
         
         
         String loginemp_no = null;
         
         if(loginemp != null) {
            loginemp_no = String.valueOf(loginemp.getEmp_no());
            // login_userid 는 로그인 되어진 사용자의 Emp_no(사원번호) 이다.
         }
            
          
         BoardVO boardvo = null;
         
         // 목록보기 할 때 새로고침 해서 조회수가 올라가지 않도록 설정해둔 것. 
         if( "yes".equals(session.getAttribute("readCountPermission")) ) {
            // 글목록보기를 클릭한 다음에 특정글을 조회해온 경우 
            
            boardvo = service.getView(seq, loginemp_no);
            // 글조회수 증가와 함께 글1개를 조회를 해주는 메소드
            
            session.removeAttribute("readCountPermission");
            // 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
         }
         else {
            // 웹브라우저에서 새로고침(F5)을 클릭한 경우.yes라는 키 값이 없을때.
            boardvo = service.getViewWithNoAddCount(seq);
            // 글조회수 증가는 없고 단순히 글1개 조회만 하는 메서드
         }
         
         
         boardvo = service.getViewWithNoAddCount(seq);
                     
         mav.addObject("boardvo", boardvo);
         
        } catch(NumberFormatException e) {
           
        }

       mav.setViewName("hoyeon/board/boardView.tiles1");
      return mav;
   }
   
   
   //=== 글 수정하는 페이지를 요청한다.===///
   
   @RequestMapping(value = "/boardEdit.os")
   public ModelAndView requiredLogin_boardEdit(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
      
      String seq = request.getParameter("seq");
      
      
        //부서이름을 가져온다. 
        List<Map<String,String>> deptNameList = service.deptNameList();
        //조회수 없이 글 하나만 조회함!!
       BoardVO boardvo = service.getViewWithNoAddCount(seq);
      
       HttpSession session = request.getSession();
       EmployeeVO loginemp = (EmployeeVO) session.getAttribute("loginemp");
       
       if( !String.valueOf(loginemp.getEmp_no()).equals(boardvo.getFk_emp_no())) {
         String message = "다른 사용자의 글은 수정이 불가합니다.";
         String loc = "javascript:history.back()";
         
         mav.addObject("message", message);
         mav.addObject("loc", loc);
         mav.setViewName("msg");
      }
      else {
         // 자신의 글을 수정할 경우
         // 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
         mav.addObject("boardvo", boardvo);
         mav.addObject("deptNameList", deptNameList);
         
         mav.setViewName("hoyeon/board/boardEdit.tiles1");
      }

      return mav;
   }
   
   
   //글 수정을 완료하는 메서드 
   @RequestMapping(value ="/boardEditEnd.os" , method= {RequestMethod.POST})
   public ModelAndView boardEditEnd(BoardVO boardvo, HttpServletRequest request, ModelAndView mav) {
      
      int n = service.boardEdit(boardvo);
      String fk_dept_no = request.getParameter("fk_dept_no");
      if(n==1) {
         
         mav.addObject("message", "글 수정 성공!!");
         
      }else {
         
         mav.addObject("message", "글 수정이 불가합니다.");
      }
      
      mav.addObject("loc", request.getContextPath()+"/boardView.os?fk_dept_no="+fk_dept_no+"&seq="+boardvo.getSeq());    
      mav.setViewName("msg");
      
      return mav;
   }
   
   
   //글 삭제 페이지를 요청한다.
   @RequestMapping(value="/boardDel.os")
   public ModelAndView boardDel(ModelAndView mav, HttpServletResponse response ,HttpServletRequest request) {
      
      String seq = request.getParameter("seq");//지울 글 번호를 가져온다. 
      String fk_dept_no = request.getParameter("fk_dept_no");//부서번호 
      
       BoardVO boardvo = service.getViewWithNoAddCount(seq);
      //조회수 증가 없이 글 1개를 조회한다.
      
        
        HttpSession session = request.getSession();
      
      EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
      //세션에 저장된 로그인 정보를 불러온다. 
      
      if(!String.valueOf(loginemp.getEmp_no()).equals(boardvo.getFk_emp_no())) {
         String message = "다른 사용자의 글은 삭제가 불가능 합니다!!";
         String loc      = "javascript:history.back()";
         
         mav.addObject("message", message);
         mav.addObject("loc", loc);
         mav.setViewName("msg");
      }else {
         mav.addObject("seq",seq);
         
         mav.addObject("fk_dept_no",fk_dept_no);

         mav.setViewName("hoyeon/board/boardDel.tiles1");
      }
 
      return mav;
   }
   
   
   //글 삭제 완료 페이지
   @RequestMapping(value ="/boardDelEnd.os", method = {RequestMethod.POST})
   public ModelAndView boardDelEnd (HttpServletRequest request,ModelAndView mav) {
      
      String seq = request.getParameter("seq");
      String fk_dept_no = request.getParameter("fk_dept_no");
      
      Map<String,String>paraMap = new HashMap<>();
      paraMap.put("seq", seq);
      
      //삭제할때는 첨부파일부터 삭제해준다.
      BoardVO boardvo = service.getViewWithNoAddCount(seq);
      String fileName = boardvo.getFileName();
      System.out.println("fileName>>>"+fileName);
      
      //만일 삭제하려는 글에 첨부파일이 존재한다면 
      if(fileName!=null || !"".equals(fileName)) {
         
         HttpSession session = request.getSession();
         String root = session.getServletContext().getRealPath("/");
         String path = root + "resources"+File.separator+"files";
         
         paraMap.put("path",path); //삭제할 파일의 경로를 얻어 맵에 넣는다.
      }
      
      
      int n = service.boardDel(paraMap);
      
      
      if(n==1) {
         mav.addObject("message","글 삭제가 완료되었습니다.");
          
         //return "redirect:/boardList.os?fk_dept_no="+fk_dept_no;   
         mav.addObject("loc",request.getContextPath()+"/boardList.os?seq="+seq+"&goBackURL=boardList.os&fk_dept_no="+fk_dept_no);
      }else {
         mav.addObject("message","글 삭제가 불가능합니다.");
         mav.addObject("loc",request.getContextPath()+"/boardView.os");
      }
      
      mav.setViewName("msg");
      
      return mav;
   }
   
   
   
   
   
   // === #84. 댓글쓰기(Ajax 로 처리) === // 
      @ResponseBody
      @RequestMapping(value="/addComments.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
      public String requiredLogin_addComments(HttpServletRequest request, HttpServletResponse response, CommentVO commentvo) {
         
      /*   
         String fk_emp_no =  request.getParameter("fk_emp_no");
         String name = request.getParameter("name");
         String content = request.getParameter("content");
         String parentSeq = request.getParameter("parentSeq");
         
         CommentVO commentvo = new CommentVO(); 
         commentvo.setFk_emp_no(Integer.parseInt(fk_emp_no));
         commentvo.setName(name);
         commentvo.setContent(content);
         commentvo.setParentSeq(parentSeq);
      */   
         
         int n = 0;
         
         try {
            n = service.addComment(commentvo);
         } catch (Throwable e) {
            
         } 
         // 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
    
         JSONObject jsonObj = new JSONObject();
         jsonObj.put("n", n);
         jsonObj.put("name", commentvo.getName());
         
         return jsonObj.toString();
      }
      
      
      
      //원게시물에 딸린 댓글들을 페이징처리해서 조회해오기(Ajax 로 처리) === //
      @ResponseBody
      @RequestMapping(value="/commentList.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
      public String commentList(HttpServletRequest request) {
         
         String parentSeq = request.getParameter("parentSeq");//댓글을 달 글의 번호. 
         String currentShowPageNo = request.getParameter("currentShowPageNo");//현재 보고있는 페이지
         
         if(currentShowPageNo == null) {
            currentShowPageNo = "1";
         }
         
         int sizePerPage = 10; // 한페이지당 10개의 덧글을 보여줄것이다. 
         
         //가져올 게시글의 범위를 구하기
         int startRno = (( Integer.parseInt(currentShowPageNo) - 1 ) * sizePerPage) + 1;
         int endRno = startRno + sizePerPage - 1; 
         
         Map<String,String> paraMap = new HashMap<>();
         paraMap.put("parentSeq", parentSeq);
         paraMap.put("startRno", String.valueOf(startRno));
         paraMap.put("endRno", String.valueOf(endRno));
         
         List<CommentVO> commentList = service.getCommentListPaging(paraMap); 
         
         JSONArray jsonArr = new JSONArray();  // []
         
         if(commentList != null) {
            for(CommentVO cmtvo : commentList) {
               JSONObject jsonObj = new JSONObject();
               
               jsonObj.put("content", cmtvo.getContent());
               jsonObj.put("name", cmtvo.getName());
               jsonObj.put("writeDay", cmtvo.getWriteDay());
               
               jsonArr.put(jsonObj);
            }
         }
         
         return jsonArr.toString();
      }
      
      
      //원게시물에 딸린 댓글 totalPage 알아오기 (Ajax 로 처리) === //
      @ResponseBody
      @RequestMapping(value="/getCommentTotalPage.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
      public String getCommentTotalPage(HttpServletRequest request) {
         
         String parentSeq = request.getParameter("parentSeq");
         String sizePerPage = request.getParameter("sizePerPage");
         
         Map<String,String> paraMap = new HashMap<>();
         paraMap.put("parentSeq", parentSeq);
         
         // 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기 
         int totalCount = service.getCommentTotalCount(paraMap);
         
         // === 총페이지수(totalPage)구하기 === 
         int totalPage = (int) Math.ceil((double)totalCount/Integer.parseInt(sizePerPage)); 
         // (double)14/5 ==> 2.8 ==> Math.ceil(2.8) ==> 3.0 ==> (int)3.0 ==> 3  
           
         JSONObject jsonObj = new JSONObject();
         jsonObj.put("totalPage", totalPage);  // {"totalPage":3}
               
         return jsonObj.toString();
      }
      
      
      
      //파일 다운로드 메서드 
      @RequestMapping(value="/download.os") 
      public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
         
         String seq = request.getParameter("seq");
         // 첨부파일이 있는 글번호 
         
         /*
            첨부파일이 있는 글번호에서
          20201209142730107400829530700.jpg 처럼
           이러한 fileName 값을 DB에서 가져와야 한다.
           또한 orgFilename 값도 DB에서 가져와야 한다.       
         */
         
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter writer = null;
         
         try {
            Integer.parseInt(seq);
            
            BoardVO boardvo = service.getViewWithNoAddCount(seq);
            String fileName = boardvo.getFileName(); // 20201209142730107400829530700.jpg  이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다. 
            String orgFilename = boardvo.getOrgFilename(); // berkelekle디스트리뷰트06.jpg  다운로드시 보여줄 파일명.
            
            // 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
            // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
            // WAS 의 webapp 의 절대경로를 알아와야 한다.
            HttpSession session = request.getSession();
            String root = session.getServletContext().getRealPath("/");
            
            System.out.println("~~~~ webapp 의 절대경로 => " + root);
            
            String path = root+"resources"+ File.separator +"files";
             
            
            // **** file 다운로드 하기 **** // 
            boolean flag = false; // file 다운로드의 성공,실패를 알려주는 용도 
            flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
            // file 다운로드 성공시 flag 는 true, 
            // file 다운로드 실패시 flag 는 false 를 가진다.
            
            if(!flag) {
               // 다운로드가 실패할 경우 메시지를 띄워준다.
               try {
                  writer = response.getWriter();
                  // 웹브라우저상에 메시지를 쓰기 위한 객체생성.
                  
                  writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다!!'); history.back();</script>"); 
               } catch (IOException e) { }
            }
            
         } catch(NumberFormatException e) {
            try {
               writer = response.getWriter();
               // 웹브라우저상에 메시지를 쓰기 위한 객체생성.
               
               writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다!!'); history.back();</script>");     
            } catch (IOException e1) {
               
            }
         }
               
      }//end of 게시판 파일 다운로드 메서드 
      
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      
      //자료실 게시판 리스트 
      @RequestMapping(value = "/fileBoardList.os")
      public ModelAndView fileBoardList (HttpServletRequest request ,ModelAndView mav) {
         
         List<FileVO>fileList = null;
         String str_currentShowPageNo = request.getParameter("currentShowPageNo");
         
         
         // 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
         // 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
         int totalCount = 0;         // 총 게시물 건수
         int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
         int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
         int totalPage = 0;          // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
         
         int startRno = 0;           // 시작 행번호
         int endRno = 0;             // 끝 행번호 
         
         // 총 게시물 건수(totalCount)
         totalCount = service.getFileTotalCount();
         
         totalPage = (int) Math.ceil((double)totalCount/sizePerPage); // (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> 13.0 ==> (int)13.0 ==> 13  
                                                                      // (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12 
         
         if(str_currentShowPageNo == null) {
            // 게시판에 보여지는 초기화면
            
            currentShowPageNo = 1;
         }
         else {
            try {
               currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
               if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
                  currentShowPageNo = 1;
               }
            } catch(NumberFormatException e) {
               currentShowPageNo = 1;
            }
         }
         startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
         endRno = startRno + sizePerPage - 1; 
         
         
         Map<String,String> paraMap = new HashMap<>();
         paraMap.put("startRno", String.valueOf(startRno));
         paraMap.put("endRno", String.valueOf(endRno));
         
         fileList = service.fileListSearchWithPaging(paraMap);
         // 페이징 처리한 글목록 가져오기
         
      
         
         // === #121. 페이지바 만들기 === //
         String pageBar = "<ul style='list-style: none;'>";
         
         int blockSize = 10;
         // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
   
         
         int loop = 1;
         /*
             loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
          */
         
         int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
         // *** !! 공식이다. !! *** //
   
         String url = "list.action";
         
         // === [맨처음][이전] 만들기 === 
         if(pageNo != 1) {
            pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
            pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
         }
         
         while( !(loop > blockSize || pageNo > totalPage) ) {
            
            if(pageNo == currentShowPageNo) {
               pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
            }
            else {
               pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
            }
            
            loop++;
            pageNo++;
            
         }// end of while------------------------------
         
         
         // === [다음][마지막] 만들기 ===
         if( !(pageNo > totalPage) ) {
            pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
            pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
         }
         
         pageBar += "</ul>";
         
         mav.addObject("pageBar", pageBar);
         
         mav.addObject("fileList",fileList); 
         mav.setViewName("hoyeon/fileBoard/fileList.tiles1");
         
         return mav;
      }
      
      
      
      
      
      //자료실에 파일추가하기 페이지 요청
      @RequestMapping(value = "/fileAdd.os")
      public ModelAndView requiredLogin_fileAdd( HttpServletRequest request, HttpServletResponse response,ModelAndView mav) {
   
         mav.setViewName("hoyeon/fileBoard/fileAdd.tiles1");
         return mav;
      }
      
      //파일추가 완료 요청
      @RequestMapping(value = "/fileAddEnd.os" , method = {RequestMethod.POST})
      public String fileAddEnd (FileVO filevo ,MultipartHttpServletRequest mrequest) {
         
         
         MultipartFile file =filevo.getFile();
         
         if(!file.isEmpty()) {
            //추가하려는 파일이 있다면
            
            HttpSession session = mrequest.getSession();
            String root = session.getServletContext().getRealPath("/");
            //root: webapp 의 절대경로
            
            String path = root+"resources"+File.separator+"files";
            //File.separator : 운영체제에서 사용하는 폴더와 파일의 구분자.
            //Path가 첨부파일이 저장될 Was의 폴더가 된다. 
            
            String newFileName = "";
            //WAS에 저장될 파일명 초기화
            
            byte[]bytes = null;
            //첨부파일의 내용물을 담는것이다.
            
            long fileSize = 0;
            //첨부파일의 크기
            
            try {
               bytes=file.getBytes();
               
               newFileName=fileManager.doFileUpload(bytes, file.getOriginalFilename(), path);
               //첨부된 파일을 업로드 하도록 한다. 
               
               filevo.setFileName(newFileName);
               filevo.setOrgFilename(file.getOriginalFilename());
               //첨부된 파일 이름, 원래 파일의 이름(사용자가 다운로드 할 때 사용되는 파일이기도 하다) 
               
               fileSize = file.getSize();
               filevo.setFileSize(String.valueOf(fileSize));
            
            } catch (Exception e) {}
   
         } //end of if(!file.isEmpty()) {}---------------------------------------
          
         int n=0;
         
         n=service.add_FileUpload(filevo);
         
         if(n==1) {
            return "redirect:/fileBoardList.os";
         }else {
            return "redirect:/fileAdd.os";
         }
          
      }
      

      //파일 삭제를 요청한다.
      @RequestMapping(value="/fileboardDel.os" ,method= {RequestMethod.POST})
      public ModelAndView fileboardDel(ModelAndView mav, HttpServletResponse response ,HttpServletRequest request) {
         
         
         
         String[] seqArr = request.getParameterValues("seq");//지울 글 번호를 가져온다. 
         
         /*
           for(int i=0; i<seqArr.length; i++) { System.out.println("~~~ 확인용 seq : " +
           seqArr[i]); }
          */
           
         Map<String,Object>paraMap = new HashMap<>();
         paraMap.put("seqArr",seqArr);
         List<Map<String,String>>fileNameList = service.fileNameList(paraMap);
         // 삭제해아할 글번호가 3, 4 
                  // 삭제해야할 파일명을 얻어온다. 
                  // List<String> fileList =  20201228030341929106970144900.png  20201227221617911863002805700.pdf
         /*for(int i=0; i<fileNameList.size(); i++) {
            
            System.out.println("확인용>>>>"+fileNameList.get(i));
         }
         */
         if(fileNameList!=null) {
            
            for(int i=0; i<fileNameList.size(); i++) {
               paraMap.put("fileNameList"+i, fileNameList.get(i));//삭제해야할 파일명
            }
            
            HttpSession session = request.getSession();
            String root = session.getServletContext().getRealPath("/");
            String path = root+"resources"+File.pathSeparator+"files";
            paraMap.put("path",path);//삭제해야할 파일이 저장된 경로 
            
         }
         
       
         // for ==> 20201228030341929106970144900.png  20201227221617911863002805700.pdf 파일을 삭제한다. 
         // 파일을 삭제했으니 테이블에서 삭제해아할 글번호가 3, 4 을 delete 작업만 해주면 된다.
         
         int n = service.fileboardDel(paraMap);
           
         if(n == 0) {
            mav.addObject("message", "삭제가 불가합니다.");
       

            mav.addObject("loc", request.getContextPath()+"/fileBoardList.os");
         }
         else {
            mav.addObject("message", "파일삭제 성공!!");
            mav.addObject("loc", request.getContextPath()+"/fileBoardList.os");
         }
          
         mav.setViewName("msg");
         
         return mav;
      }
      

      //파일 다운로드 메서드 
            @RequestMapping(value="/filedownload.os") 
            public void requiredLogin_Filedownload(HttpServletRequest request, HttpServletResponse response) {
               
               String seq = request.getParameter("seq");
               // 첨부파일이 있는 글번호 
               
               System.out.println("seq이 잘 넘어왔는지 확인하기~>>>>"+seq);
               response.setContentType("text/html; charset=UTF-8");
               
               PrintWriter writer = null;
               
               try {
                  Integer.parseInt(seq);
                  
                  FileVO filevo = service.fileboard(seq);
                  System.out.println("seq이 잘 넘어왔는지 확인하기~>>>>"+seq);
                  
                  String fileName = filevo.getFileName(); // 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명  
                  String orgFilename = filevo.getOrgFilename(); // 다운로드시 보여줄 파일명.
                  
                
                  // WAS 의 webapp 의 절대경로를 알아와야 한다.
                  HttpSession session = request.getSession();
                  String root = session.getServletContext().getRealPath("/");
                  
                  System.out.println("~~~~ webapp 의 절대경로 => " + root);
                  
                  String path = root+"resources"+ File.separator +"files";
                
                  
                  // **** file 다운로드 하기 **** // 
                  boolean flag = false; // file 다운로드의 성공,실패를 알려주는 용도 
                  flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
                  // file 다운로드 성공시 flag 는 true, 
                  // file 다운로드 실패시 flag 는 false 를 가진다.
                  
                  if(!flag) {
                     // 다운로드가 실패할 경우 메시지를 띄워준다.
                     try {
                        writer = response.getWriter();
                        // 웹브라우저상에 메시지를 쓰기 위한 객체생성.
                        
                        writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다!!'); history.back();</script>"); 
                     } catch (IOException e) { }
                  }else {
                     //성공할 경우에는 다운로드 횟수에 +1
                     int update = service.downloadCntUpdate(seq);
                     
                     System.out.println("확인용(성공시:1)>>>"+ update);
                      
                  }
                  
               } catch(NumberFormatException e) {
                  try {
                     writer = response.getWriter();
                     // 웹브라우저상에 메시지를 쓰기 위한 객체생성.
                     
                     writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다!!'); history.back();</script>");     
                  } catch (IOException e1) {
                     
                  }
               }
                     
            }//end of 자료실게시판 파일 다운로드 메서드 
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
   //공지사항 게시판 리스트
              @RequestMapping(value="/noticeList.os") public ModelAndView
              noticeList(HttpServletRequest request, ModelAndView mav) {
                 
                 List<NoticeVO> noticeList = null;
             
                String searchType = request.getParameter("searchType");//검색타입
                 String searchWord = request.getParameter("searchWord");//검색한 단어
                String str_currentShowPageNo = request.getParameter("currentShowPageNo");
                // 현재 있는 페이지 번호 
             
                if(searchType == null ) {
                   searchType = "";
                }
                  
               if(searchWord == null || searchWord.trim().isEmpty() ) {
                  searchWord = "";
               }
               
               if(!"".equals(searchType) && !"".equals(searchWord)) {
                   System.out.println("searchWord ==> "+searchWord);
                   System.out.println("searchType ===> "+searchType);
               }
               
               Map<String,String> paraMap = new HashMap<>();
               paraMap.put("searchType",searchType);
               paraMap.put("searchWord",searchWord);
             
             
               // 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
               int totalCount = 0;         // 총 게시물 건수
               int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
               int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
               int totalPage = 0;          // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
               
               int startRno = 0;           // 시작 행번호
               int endRno = 0;             // 끝 행번호 
               
               //총 게시물 수를 가져온다      
               totalCount = service.totalNoticeCnt(paraMap);
               //총 게시물 수로 총 페이지를 구한다.
                
               totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
               
               if(str_currentShowPageNo==null) {
                  currentShowPageNo=1;
                  
               }else {
                  try {
                     currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
                     if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
                        currentShowPageNo = 1;
                        //사용자가 자기 마음대로 url에 값을 넣는걸 방지하기 위해서!!
                     }
                  } catch(NumberFormatException e) {
                     currentShowPageNo = 1;
                  }//end of try~catch---------------------------
               }//end of if-------------------------------
               
               //시작 페이지와 끝 페이지를 구하는 공식.
               startRno = ((currentShowPageNo-1)*sizePerPage)+1;
               endRno = startRno + sizePerPage - 1; 
               
               paraMap.put("startRno",String.valueOf(startRno));
               paraMap.put("endRno",String.valueOf(endRno));
               
               noticeList = service.noticeListSearchP(paraMap);
               // 페이징 처리한 글목록 가져오기(검색을 포함한다.)
               
               
               
               if(!"".equals(searchWord)) {
                  mav.addObject("paraMap", paraMap);
                  //검색 단어가 있다면 넘겨준다.
               }
               
               String pageBar = "<ul style='list-style: none;'>";
               
               int blockSize = 10;
               //페이지 번호의 개수.
               int loop = 1;
               //1부터 증가하고 1개 블럭을 이루는 페이지 번호의 개수. 10개까지만 증가함.
               
               //공식이다.페이지 번호!!
               int pageNo = ((currentShowPageNo-1)/blockSize)*blockSize+1;
               
               String url = "noticeList.os";
               
               if(pageNo!=1) { //페이지 번호가 1이 아니라면. 맨 처음의 페이지가 아닌 경우[맨처음   ] 과 [이전]을 만든다.
                  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
                  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
               }
               
               //1씩 증가하는 숫자가 블럭사이즈를 초과했거나(불가능함!)
               //페이지 번호가 총 페이지 수를 넘어갔다면(불가능함!) 
               //-이 아니라면. 아래의 while문을 실행한다.
               while(!(loop>blockSize || pageNo>totalPage)) {

                  if(pageNo == currentShowPageNo) {//페이지 번호가 현재 보는 페이지 번호와 같을 때.
                     pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 0px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
                  }
                  else {//아니라면 클릭했을때는 그 페이지로 이동하도록 한다. 
                     pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
                  }
                  
                  loop++;
                  pageNo++;
               }
               
               // [다음][마지막]  ===
               if( !(pageNo > totalPage) ) {
                  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo+1)+"'>[다음]</a></li>";
                  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
                  }
               
               pageBar+="</ul>";
               ///////////////////////////////////페이징 처리 끝.
               
               String goBackURL = MyUtil.getCurrentURL(request);
               
               //새로고침 했을때 조회수가 증가되는걸 막기 위해서 session 으로 처리한다.
               HttpSession session = request.getSession();
               session.setAttribute("readCountPermission", "yes");
               // session 에  "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면  반드시 웹브라우저에서 주소창에 "/boardList.os" 이라고 입력해야만 얻어올 수 있다. 
               
               
                
               mav.addObject("noticeList",noticeList);
               mav.addObject("pageBar",pageBar);
               mav.addObject("goBackURL",goBackURL); 
                       
                mav.setViewName("hoyeon/notice/noticeList.tiles1");
              
              return mav; 
              }         
            
            
            //공지사항에 글쓰기 
              
              @RequestMapping(value="/noticeAdd.os")
               public ModelAndView requiredLogin_noticeAdd(HttpServletRequest request, HttpServletResponse response,ModelAndView mav) {
                 
                     HttpSession session = request.getSession();
                   EmployeeVO loginemp = (EmployeeVO) session.getAttribute("loginemp");
                   
                  System.out.println("loginemp.getBoard_grant_name()>>"+loginemp.getBoard_grant_name());
                  // System.out.println("loginemp.getEmp_no()>>>"+loginemp.getEmp_no()+"의 권한번호는>>>"+board_grant_no);
                   
                 if( !String.valueOf(loginemp.getBoard_grant_name()).equals("전사공지사항")) {
                     String message = "게시판 권한이 없습니다.";
                     String loc = "javascript:history.back()";
                     
                     mav.addObject("message", message);
                     mav.addObject("loc", loc);
                     mav.setViewName("msg");
                  }
                  else {
                   
                     String header = request.getParameter("header");
                     
                     mav.addObject("header",header);
                     
                     mav.setViewName("hoyeon/notice/noticeAdd.tiles1");
                  }
                   
                  
                  return mav;
               }

               //게시판 글쓰기 완료 요청
               @RequestMapping(value="/noticeAddEnd.os", method= {RequestMethod.POST})
               public String noticeAddEnd(Map<String,String>paraMap,NoticeVO noticevo,MultipartHttpServletRequest mrequest) {
                  
                  MultipartFile file = noticevo.getFile();
                  if( !file.isEmpty() ) {
                  
                     // WAS의 webapp 의 절대경로를 알아와야 한다.
                     HttpSession session = mrequest.getSession();
                     String root = session.getServletContext().getRealPath("/");
                     //System.out.println("~~~~ webapp 의 절대경로 => " + root);
                   
                     String path = root+"resources"+ File.separator +"files";
                   
                     // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
                     System.out.println("~~~~ path => " + path);
            
                     String newFileName = "";
                     // WAS(톰캣)의 디스크에 저장될 파일명 
                     byte[] bytes = null;
                     // 첨부파일의 내용물을 담는 것  
                     long fileSize = 0;
                     // 첨부파일의 크기 
                     
                     try {
                        bytes = file.getBytes();
                        // 첨부파일의 내용물을 읽어오는 것 
                        
                        newFileName = fileManager.doFileUpload(bytes, file.getOriginalFilename(), path); 
                        // 첨부되어진 파일을 업로드 하도록 하는 것이다. 
                        
                        System.out.println(">>> 확인용  newFileName => " + newFileName);
                     
                        noticevo.setFileName(newFileName);
                        
                        noticevo.setOrgFilename(file.getOriginalFilename());

                        fileSize = file.getSize(); // 첨부파일의 크기(단위는 byte)
                        noticevo.setFileSize(String.valueOf(fileSize));
                     
                     } catch(Exception e) {
                        e.printStackTrace();
                     }
                     
                  }
                  // === !!! 첨부파일이 있는 경우 작업 끝  !!! ===
             
                  int n = 0;
                  
                  // 첨부파일이 없는 경우라면
                  if(file.isEmpty()) {
                     n = service.addNotice(noticevo);
                  }
                  else {
                  // 첨부파일이 있는 경우라면 
                     n = service.add_withFileNotice(noticevo);
                  }
                     
                  if(n==1) {
                     return "redirect:/noticeList.os";   
             
                  }
                  else {
                     return "redirect:/noticeAdd.os";   
                  }
                     
                  }
   
               //1개의 글 보기 
               @RequestMapping(value="/noticeView.os")
               public ModelAndView noticeView(HttpServletRequest request,ModelAndView mav) {
                  
               String seq = request.getParameter("seq");
               
               //현재 페이지의 주소를 뷰단으로 넘겨준다.
               String gobackURL = request.getParameter("gobackURL");  
               
               if(gobackURL != null) {
                   gobackURL = gobackURL.replaceAll(" ", "&"); // 이전글, 다음글을 클릭해서 넘어온 것이다.
                    //System.out.println("###### 확인용 gobackURL : " + gobackURL);
                   // ###### 확인용 gobackURL : list.action?searchType=&searchWord=&currentShowPageNo=2 
                   
                   mav.addObject("gobackURL", gobackURL);
                }
                try {
                     Integer.parseInt(seq);
                     
                     HttpSession session = request.getSession();
                      EmployeeVO loginemp = (EmployeeVO) session.getAttribute("loginemp");
                     
                     
                     String loginemp_no = null;
                     
                     if(loginemp != null) {
                        loginemp_no = String.valueOf(loginemp.getEmp_no());
                        // login_userid 는 로그인 되어진 사용자의 Emp_no(사원번호) 이다.
                     }
                     NoticeVO noticevo = null;
                     
                     // 목록보기 할 때 새로고침 해서 조회수가 올라가지 않도록 설정해둔 것. 
                     if( "yes".equals(session.getAttribute("readCountPermission")) ) {
                        // 글목록보기를 클릭한 다음에 특정글을 조회해온 경우 
                        
                        noticevo = service.getnoticeView(seq, loginemp_no);
                        //조회수 증가와 함께 공지글1개를 조회를 해주는 메소드
                        
                        session.removeAttribute("readCountPermission");
                        // 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
                     }
                     else {
                        // 웹브라우저에서 새로고침(F5)을 클릭한 경우.yes라는 키 값이 없을때.
                        noticevo = service.noticeViewWithNoAddCount(seq);
                        // 글조회수 증가는 없고 단순히 글1개 조회만 하는 메서드
                     }
                     //noticevo = service.noticeViewWithNoAddCount(seq);
                                 
                     mav.addObject("noticevo", noticevo);
                     
                    } catch(NumberFormatException e) {
                       
                    }

                   mav.setViewName("hoyeon/notice/noticeView.tiles1");
                  return mav;
               }
               
               
               //공지사항 수정하기
               @RequestMapping(value = "noticeEdit.os")
               public ModelAndView requiredLogin_noticeEdit(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
                  
                  String seq = request.getParameter("seq");
                  
                   
                    //조회수 없이 글 하나만 조회함!!
                   NoticeVO noticevo = service.noticeViewWithNoAddCount(seq);
                  
                   HttpSession session = request.getSession();
                   EmployeeVO loginemp = (EmployeeVO) session.getAttribute("loginemp");
                   
                   if( !String.valueOf(loginemp.getEmp_no()).equals(noticevo.getFk_emp_no())) {
                     String message = "다른 사용자의 글은 수정이 불가합니다.";
                     String loc = "javascript:history.back()";
                     
                     mav.addObject("message", message);
                     mav.addObject("loc", loc);
                     mav.setViewName("msg");
                  }
                  else {
                     // 자신의 글을 수정할 경우
                     // 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
                     mav.addObject("noticevo", noticevo);            
                     mav.setViewName("hoyeon/notice/noticeEdit.tiles1");
                  }

                  return mav;
               }
               
               
               //공지사항 수정을 완료하는 메서드 
               @RequestMapping(value ="/noticeEditEnd.os" , method= {RequestMethod.POST})
               public ModelAndView noticeEditEnd(NoticeVO noticevo, HttpServletRequest request, ModelAndView mav) {
                  
                  int n = service.noticeEdit(noticevo);
                  if(n==1) {
                     
                     mav.addObject("message", "글 수정 성공!!");
                     
                  }else {
                     
                     mav.addObject("message", "글 수정이 불가합니다.");
                  }
                  
                  mav.addObject("loc", request.getContextPath()+"/noticeView.os?seq="+noticevo.getSeq());    
                  mav.setViewName("msg");
                  
                  return mav;
               }
               
               //공지사항 삭제
               //글 삭제 페이지를 요청한다.
               @RequestMapping(value="/noticeDel.os")
               public ModelAndView noticeDel(ModelAndView mav, HttpServletResponse response ,HttpServletRequest request) {
                  
                  String seq = request.getParameter("seq");//지울 글 번호를 가져온다. 
                
                   NoticeVO noticevo = service.noticeViewWithNoAddCount(seq);
                  //조회수 증가 없이 글 1개를 조회한다.
                  
                    
                    HttpSession session = request.getSession();
                  
                  EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
                  //세션에 저장된 로그인 정보를 불러온다. 
                  
                  if(!String.valueOf(loginemp.getEmp_no()).equals(noticevo.getFk_emp_no())) {
                     String message = "다른 사용자의 글은 삭제가 불가능 합니다!!";
                     String loc      = "javascript:history.back()";
                     
                     mav.addObject("message", message);
                     mav.addObject("loc", loc);
                     mav.setViewName("msg");
                  }else {
                     mav.addObject("seq",seq);
                     mav.setViewName("hoyeon/notice/noticeDel.tiles1");
                  }
             
                  return mav;
               }
               
               
               //글 삭제 완료 페이지
               @RequestMapping(value ="/noticeDelEnd.os", method = {RequestMethod.POST})
               public ModelAndView noticeDelEnd (HttpServletRequest request,ModelAndView mav) {
                  
                  String seq = request.getParameter("seq");
               
                  Map<String,String>paraMap = new HashMap<>();
                  paraMap.put("seq", seq);
                  
                  //첨부파일부터 삭제해준다.
                   NoticeVO noticevo = service.noticeViewWithNoAddCount(seq);
                  //조회수 증가 없이 글 1개를 조회한다.
                  String fileName = noticevo.getFileName();
                  //System.out.println("fileName>>>"+fileName);
                  
                  //만일 삭제하려는 글에 첨부파일이 존재한다면 
                  if(fileName!=null || !"".equals(fileName)) {
                     
                     HttpSession session = request.getSession();
                     String root = session.getServletContext().getRealPath("/");
                     String path = root + "resources"+File.separator+"files";
                     
                     paraMap.put("path",path); //삭제할 파일의 경로를 얻어 맵에 넣는다.
                  }
                  
                  
                  int n = service.noticeDel(paraMap);
                  
                  
                  if(n==1) {
                     mav.addObject("message","글 삭제가 완료되었습니다.");
                  
                     mav.addObject("loc",request.getContextPath()+"/noticeList.os?seq="+seq+"&goBackURL=noticeList.os");
                  }else {
                     mav.addObject("message","글 삭제가 불가능합니다.");
                     mav.addObject("loc",request.getContextPath()+"/noticeView.os");
                  }
                  
                  mav.setViewName("msg");
                  
                  return mav;
               }
               
               
               
               
               // === #84. 댓글쓰기(Ajax 로 처리) === // 
               @ResponseBody
               @RequestMapping(value="/noticeAddComment.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
               public String requiredLogin_noticeAddComment(HttpServletRequest request, HttpServletResponse response, NoticeCommentVO commentvo) {
         
                  int n = 0;
                  
                  try {
                     n = service.noticeAddComment(commentvo);//덧글쓰기
                  } catch (Throwable e) {
                     
                  } 
                  // 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
                  JSONObject jsonObj = new JSONObject();
                  jsonObj.put("n", n);
                  jsonObj.put("name", commentvo.getName());
                  
                  return jsonObj.toString();
               }
               
               
               
               //원게시물에 딸린 댓글들을 페이징처리해서 조회해오기(Ajax 로 처리) === //
               @ResponseBody
               @RequestMapping(value="/noticeCommentList.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
               public String noticeCommentList(HttpServletRequest request) {
                  
                  String parentSeq = request.getParameter("parentSeq");//댓글을 달 글의 번호. 
                  String currentShowPageNo = request.getParameter("currentShowPageNo");//현재 보고있는 페이지
                  
                  if(currentShowPageNo == null) {
                     currentShowPageNo = "1";
                  }
                  
                  int sizePerPage = 10; 
                  
                  //가져올 게시글의 범위를 구하기
                  int startRno = (( Integer.parseInt(currentShowPageNo) - 1 ) * sizePerPage) + 1;
                  int endRno = startRno + sizePerPage - 1; 
                  
                  Map<String,String> paraMap = new HashMap<>();
                  paraMap.put("parentSeq", parentSeq);
                  paraMap.put("startRno", String.valueOf(startRno));
                  paraMap.put("endRno", String.valueOf(endRno));
                  
                  List<NoticeCommentVO> commentList = service.getNoticeCommentListPaging(paraMap); //총 덧글의 리스트를 페이징처리해서 가져오기
                  
                  JSONArray jsonArr = new JSONArray();  // []
                  
                  if(commentList != null) {
                     for(NoticeCommentVO cmtvo : commentList) {
                        JSONObject jsonObj = new JSONObject();
                        
                        jsonObj.put("content", cmtvo.getContent());
                        jsonObj.put("name", cmtvo.getName());
                        jsonObj.put("writeDay", cmtvo.getWriteDay());
                        
                        jsonArr.put(jsonObj);
                     }
                  }
                  
                  return jsonArr.toString();
               }
               
               
               //원게시물에 딸린 댓글 totalPage 알아오기 (Ajax 로 처리) === //
               @ResponseBody
               @RequestMapping(value="/getNoticeCommentTotalPage.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
               public String getNoticeCommentTotalPage(HttpServletRequest request) {
                  
                  String parentSeq = request.getParameter("parentSeq");
                  String sizePerPage = request.getParameter("sizePerPage");
                  
                  Map<String,String> paraMap = new HashMap<>();
                  paraMap.put("parentSeq", parentSeq);
                  
                  // 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기 
                  int totalCount = service.getNoticeCommentTotalCount(paraMap);
                  
                  // === 총페이지수(totalPage)구하기 === 
                  int totalPage = (int) Math.ceil((double)totalCount/Integer.parseInt(sizePerPage)); 
                  // (double)14/5 ==> 2.8 ==> Math.ceil(2.8) ==> 3.0 ==> (int)3.0 ==> 3  
                    
                  JSONObject jsonObj = new JSONObject();
                  jsonObj.put("totalPage", totalPage);  // {"totalPage":3}
                        
                  return jsonObj.toString();
               }
               
               
               
            
               
               
               
               
               
               
               //공지게시판의 파일 다운로드 메서드 
               @RequestMapping(value="/noticedownload.os") 
               public void requiredLogin_noticedownload(HttpServletRequest request, HttpServletResponse response) {
                  
                  String seq = request.getParameter("seq");
                  // 첨부파일이 있는 글번호 
            
                  response.setContentType("text/html; charset=UTF-8");
                  PrintWriter writer = null;
                  
                  try {
                     Integer.parseInt(seq);
                     
                     NoticeVO noticevo = service.noticeViewWithNoAddCount(seq);
                     String fileName = noticevo.getFileName(); // 20201209142730107400829530700.jpg  이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다. 
                     String orgFilename = noticevo.getOrgFilename(); // berkelekle디스트리뷰트06.jpg  다운로드시 보여줄 파일명.
                     
                     // 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
                     // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
                     // WAS 의 webapp 의 절대경로를 알아와야 한다.
                     HttpSession session = request.getSession();
                     String root = session.getServletContext().getRealPath("/");
                     
                     System.out.println("~~~~ webapp 의 절대경로 => " + root);
                     
                     String path = root+"resources"+ File.separator +"files";
                      
                     
                     // **** file 다운로드 하기 **** // 
                     boolean flag = false; // file 다운로드의 성공,실패를 알려주는 용도 
                     flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
                     // file 다운로드 성공시 flag 는 true, 
                     // file 다운로드 실패시 flag 는 false 를 가진다.
                     
                     if(!flag) {
                        // 다운로드가 실패할 경우 메시지를 띄워준다.
                        try {
                           writer = response.getWriter();
                           // 웹브라우저상에 메시지를 쓰기 위한 객체생성.
                           
                           writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다!!'); history.back();</script>"); 
                        } catch (IOException e) { }
                     }
                     
                  } catch(NumberFormatException e) {
                     try {
                        writer = response.getWriter();
                        // 웹브라우저상에 메시지를 쓰기 위한 객체생성.
                        
                        writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다!!'); history.back();</script>");     
                     } catch (IOException e1) {
                        
                     }
                  }
                        
               }//end of 공지게시판 파일 다운로드 메서드 
}