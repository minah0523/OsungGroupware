package com.spring.groupware.mina.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.common.common.FileManager;
import com.spring.groupware.common.common.MyUtil;
import com.spring.groupware.mina.model.ElecApprovalVO;
import com.spring.groupware.mina.service.InterElecApprovalService;
import com.spring.groupware.yongjin.model.EmployeeVO;

//=== 컨트롤러 선언 === 
@SuppressWarnings("serial")
@Component
/*
 * XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 그리고
 * bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 즉, 여기서 bean의 이름은 elecApprovalController 이
 * 된다. 여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도
 * ElecApprovalController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다.
 */
@Controller
public class ElecApprovalController extends HttpServlet{
	// === 의존객체 주입하기(DI: Dependency Injection) ===
	// ※ 의존객체주입(DI : Dependency Injection)
	// ==> 스프링 프레임워크는 객체를 관리해주는 컨테이너를 제공해주고 있다.
	// 스프링 컨테이너는 bean으로 등록되어진 ElecApprovalController 클래스 객체가 사용되어질때,
	// ElecApprovalController 클래스의 인스턴스 객체변수(의존객체)인 ElecApprovalService service 에
	// 자동적으로 bean 으로 등록되어 생성되어진 InterElecApprovalService service 객체를
	// BoardController 클래스의 인스턴스 변수 객체로 사용되어지게끔 넣어주는 것을 의존객체주입(DI : Dependency
	// Injection)이라고 부른다.
	// 이것이 바로 IoC(Inversion of Control == 제어의 역전) 인 것이다.
	// 즉, 개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것에서 탈피하여 스프링은 컨테이너에 객체를 담아 두고,
	// 필요할 때에 컨테이너로부터 객체를 가져와 사용할 수 있도록 하고 있다.
	// 스프링은 객체의 생성 및 생명주기를 관리할 수 있는 기능을 제공하고 있으므로, 더이상 개발자에 의해 객체를 생성 및 소멸하도록 하지 않고
	// 객체 생성 및 관리를 스프링 프레임워크가 가지고 있는 객체 관리기능을 사용하므로 Inversion of Control == 제어의 역전
	// 이라고 부른다.
	// 그래서 스프링 컨테이너를 IoC 컨테이너라고도 부른다.

	// IOC(Inversion of Control) 란 ?
	// ==> 스프링 프레임워크는 사용하고자 하는 객체를 빈형태로 이미 만들어 두고서 컨테이너(Container)에 넣어둔후
	// 필요한 객체사용시 컨테이너(Container)에서 꺼내어 사용하도록 되어있다.
	// 이와 같이 객체 생성 및 소멸에 대한 제어권을 개발자가 하는것이 아니라 스프링 Container 가 하게됨으로써
	// 객체에 대한 제어역할이 개발자에게서 스프링 Container로 넘어가게 됨을 뜻하는 의미가 제어의 역전
	// 즉, IOC(Inversion of Control) 이라고 부른다.

	// === 느슨한 결합 ===
	// 스프링 컨테이너가 ElecApprovalService 클래스 객체에서 ElecApprovalService 클래스 객체를 사용할 수 있도록
	// 만들어주는 것을 "느슨한 결합" 이라고 부른다.
	// 느슨한 결합은 ElecApprovalService 객체가 메모리에서 삭제되더라도 ElecApprovalService service 객체는
	// 메모리에서 동시에 삭제되는 것이 아니라 남아 있다.

	// ===> 단단한 결합(개발자가 인스턴스 변수 객체를 필요에 의해서 생성해주던 것)
	// private InterElecApprovalService service = new ElecApprovalService();
	// ===> ElecApprovalService 객체가 메모리에서 삭제 되어지면 ElecApprovalService service 객체는
	// 멤버변수(필드)이므로 메모리에서 자동적으로 삭제되어진다.

	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private InterElecApprovalService service;

	// === 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;

	// ============= ***** 시작 ***** ============= //

	@RequestMapping(value = "/elecapproval/main.os")
	public ModelAndView requiredLogin_elecApprovalMain(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		List<ElecApprovalVO> elecapprvoWaitingList = null;
		List<ElecApprovalVO> elecapprvoProcessingList = null;
		List<ElecApprovalVO> elecapprvoFinishedList = null;
		
		Map<String,String> paraMap = new HashMap<>();
		
		  
		// ** 로그인 사번 알아와야함 //
		
		HttpSession session = request.getSession();
		EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
		
		String login_emp_no = String.valueOf(loginemp.getEmp_no());
		//String login_emp_no = "2019001";
		
		paraMap.put("login_emp_no", login_emp_no);
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
		int totalWaitingCount = 0;         // 총 대기중 게시물 건수
		
		// 각 메뉴별 다섯개씩만 보여줄 것
		int startRno = 1;           // 시작 행번호 : 1
		int endRno = 5;             // 끝 행번호 : 5
		
		// 총 대기중 게시물 건수(totalWaitingCount)
		totalWaitingCount = service.getTotalWaitingCount(paraMap);
		
		mav.addObject("totalWaitingCount", totalWaitingCount);
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 결재대기중 목록 가져오기 (최종 5개씩)
		elecapprvoWaitingList = service.waitingApprList(paraMap);
		elecapprvoProcessingList = service.processingApprList(paraMap);
		elecapprvoFinishedList = service.finishedApprList(paraMap);
		
	
		// === 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		//     사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		//     현재 페이지 주소를 뷰단으로 넘겨준다.
		String gobackURL = MyUtil.getCurrentURL(request);
		//	System.out.println("~~~~ 확인용 gobackURL : " + gobackURL);
		
		mav.addObject("gobackURL", gobackURL);
		
		mav.addObject("elecapprvoWaitingList", elecapprvoWaitingList);
		mav.addObject("elecapprvoProcessingList", elecapprvoProcessingList);
		mav.addObject("elecapprvoFinishedList", elecapprvoFinishedList);
		
		mav.setViewName("mina/elec_approval/main.tiles1");
		// /WEB-INF/views/tiles1/mina/elec_aproval/main.jsp 파일

		return mav;
	}

	// 새결재쓰기
	@RequestMapping(value = "/elecapproval/write.os")
	public ModelAndView requiredLogin_elecApprWrite(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		mav.setViewName("mina/elec_approval/write.tiles1");
		// /WEB-INF/views/tiles1/mina/elec_aproval/write.jsp 파일
		

		return mav;
	}
	
	// === 새결재쓰기 완료 요청 === // 
	@RequestMapping(value="/elecapproval/writeEnd.os", method= {RequestMethod.POST})
	public ModelAndView writeEnd(Map<String,String> paraMap, ElecApprovalVO elecapprvo, MultipartHttpServletRequest mrequest, ModelAndView mav) {	
		
		/*
		   웹페이지에 요청 form이 enctype="multipart/form-data" 으로 되어있어서 Multipart 요청(파일처리 요청)이 들어올때 
		   컨트롤러에서는 HttpServletRequest 대신 MultipartHttpServletRequest 인터페이스를 사용해야 한다.
		  MultipartHttpServletRequest 인터페이스는 HttpServletRequest 인터페이스와  MultipartRequest 인터페이스를 상속받고있다.
		   즉, 웹 요청 정보를 얻기 위한 getParameter()와 같은 메소드와 Multipart(파일처리) 관련 메소드를 모두 사용가능하다.  	
		*/
		
		// === 사용자가 쓴 글에 파일이 첨부되어 있는 것인지, 아니면 파일첨부가 안된것인지 구분을 지어주어야 한다. === 
		
		// === !!! 첨부파일이 있는 경우 작업 시작 !!! ===
		MultipartFile attach = elecapprvo.getAttach();
		
		
		if( !attach.isEmpty() ) {
			// attach(첨부파일)가 비어있지 않으면(즉, 첨부파일이 있는 경우라면) 
			
			/*
			   1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
			   >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
			              우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
			              조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
			 */
			// WAS의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			System.out.println("~~~~ webapp 의 절대경로 => " + root);
			// ~~~~ webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
			
			String path = root+"resources"+ File.separator +"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		              운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		              운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
		    */
			
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			System.out.println("~~~~ path => " + path);
			// ~~~~ path => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files  
			
		/*
		    2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일올리기   
		*/
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명 
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것  
			
			//long fileSize = 0;
			// 첨부파일의 크기 
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것 
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); 
				// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
				// attach.getOriginalFilename() 은 첨부파일의 파일명(예: 강아지.png)이다.
				
				System.out.println(">>> 확인용  newFileName => " + newFileName);
				// >>> 확인용  newFileName => 2020120910381893648363550700.png 
				
				/*
				    3. ElecApprovalVO ElecApprovalVO 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기   
				*/
				elecapprvo.setServer_file_name(newFileName);
				// WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png) 
				
				elecapprvo.setOrg_file_name(attach.getOriginalFilename());
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
				// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
				//fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				//elecapprvo에는 size 항목을 만들지 않았다.
			
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		// === !!! 첨부파일이 있는 경우 작업 끝  !!! ===
		
		
	//  === #156. 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service 호출하기 === // 
	//  먼저 위의  int n = service.add(ElecApprovalVO); 부분을 주석처리 하고서 아래와 같이 한다.
		int n = 0;
		
		// 첨부파일이 없는 경우라면
		if(attach.isEmpty()) {
			n = service.write(elecapprvo);
		}
		else {
		// 첨부파일이 있는 경우라면 
			n = service.write_withFile(elecapprvo);
		}
			
		if(n==1) {
			String message = "결재 상신에 성공하였습니다.";
			String loc = mrequest.getContextPath()+"/elecapproval/main.os";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("tiles1/mina/minaMsg");	
			//   list.action 페이지로 redirect(페이지이동)하라는 말이다.
		}
		else {
			String message = "결재 상신을 실패하였습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("tiles1/mina/minaMsg");	
			//   add.action 페이지로 redirect(페이지이동)하라는 말이다.
		}
		
		return mav;
	}

	
		
		
		
		// ==== #168. 스마트에디터. 드래그앤드롭을 사용한 다중사진 파일업로드 ====
	   @RequestMapping(value="/elecapproval/image/multiplePhotoUpload.os", method={RequestMethod.POST})
	   public void multiplePhotoUpload(HttpServletRequest req, HttpServletResponse res) {
		    
		/*
		   1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		   >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		        우리는 WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
		 */
			
		// WAS 의 webapp 의 절대경로를 알아와야 한다. 
		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/"); 
		String path = root + "resources"+File.separator+"photo_upload";
		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. 
			
		// System.out.println(">>>> 확인용 path ==> " + path); 
		// >>>> 확인용 path ==> C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload    
			
		File dir = new File(path);
		if(!dir.exists())
		    dir.mkdirs();
			
		String strURL = "";
			
		try {
			if(!"OPTIONS".equals(req.getMethod().toUpperCase())) {
			       String filename = req.getHeader("file-name"); //파일명을 받는다 - 일반 원본파일명
		    		
			    // System.out.println(">>>> 확인용 filename ==> " + filename); 
			    // >>>> 확인용 filename ==> berkelekle%ED%8A%B8%EB%9E%9C%EB%94%9405.jpg
		    		
		    	   InputStream is = req.getInputStream();
		    	/*
		          	요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때,
		          	혹은 이름 없이 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. 
		          	이러한 형태의 값을 'payload body'라고 하는데 요청 바디에 직접 쓰여진다 하여 'request body post data'라고도 한다.

	               	서블릿에서 payload body는 Request.getParameter()가 아니라 
	            	Request.getInputStream() 혹은 Request.getReader()를 통해 body를 직접 읽는 방식으로 가져온다. 	
		    	*/
		    	   String newFilename = fileManager.doFileUpload(is, filename, path);
		    	
			       int width = fileManager.getImageWidth(path+File.separator+newFilename);
				
			       if(width > 600)
			          width = 600;
					
				// System.out.println(">>>> 확인용 width ==> " + width);
				// >>>> 확인용 width ==> 600
				// >>>> 확인용 width ==> 121
		    	
				   String CP = req.getContextPath(); // board
					
				   strURL += "&bNewLine=true&sFileName="; 
		           strURL += newFilename;
		           strURL += "&sWidth="+width;
		           strURL += "&sFileURL="+CP+"/resources/photo_upload/"+newFilename;
		    	}
			
		    	/// 웹브라우저상에 사진 이미지를 쓰기 ///
			   PrintWriter out = res.getWriter();
			   out.print(strURL);
			   
		} catch(Exception e){
			e.printStackTrace();
		}
	   
	  }	
	   	
		
		
		
		
	// == 페이징 처리를 한 결재대기중 목록 보여주기 == //
	@RequestMapping(value = "/elecapproval/waiting.os") 
	public ModelAndView requiredLogin_elecApprWaiting(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
		
		List<ElecApprovalVO> elecapprvoList = null;
		
		Map<String,String> paraMap = new HashMap<>();
		  
		// ** 로그인 사번 알아와야함 //
		HttpSession session = request.getSession();
		EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
		
		String login_emp_no = String.valueOf(loginemp.getEmp_no());
		
		paraMap.put("login_emp_no", login_emp_no);
		
		
		// 현재 페이지
	    String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		  
		
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
		int totalCount = 0;         // 총 게시물 건수
		int sizePerPage = 15;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;          // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		
		int startRno = 0;           // 시작 행번호
		int endRno = 0;             // 끝 행번호 
		
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalWaitingCount(paraMap);
		
		mav.addObject("totalCount", totalCount);
		
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
		
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
		/*
		     currentShowPageNo      startRno     endRno
		    --------------------------------------------
		         1 page        ===>    1           10
		         2 page        ===>    11          20
		         3 page        ===>    21          30
		         4 page        ===>    31          40
		         ......                ...         ...
		 */
			
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		elecapprvoList = service.waitingApprList(paraMap);
		// 페이징 처리한 결재대기중 목록 가져오기
		
		
		
		// === #121. 페이지바 만들기 === //
		String pageBar = "<ul style='list-style: none;'>";
		
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
		/*
		      1 2 3 4 5 6 7 8 9 10  다음                   -- 1개블럭
		   이전  11 12 13 14 15 16 17 18 19 20  다음   -- 1개블럭
		   이전  21 22 23
		*/
		
		int loop = 1;
		/*
	    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	    */
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
		/*
		    1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
		    11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
		    21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
		    
		    currentShowPageNo         pageNo
		   ----------------------------------
		         1                      1 = ((1 - 1)/10) * 10 + 1
		         2                      1 = ((2 - 1)/10) * 10 + 1
		         3                      1 = ((3 - 1)/10) * 10 + 1
		         4                      1
		         5                      1
		         6                      1
		         7                      1 
		         8                      1
		         9                      1
		         10                     1 = ((10 - 1)/10) * 10 + 1
		        
		         11                    11 = ((11 - 1)/10) * 10 + 1
		         12                    11 = ((12 - 1)/10) * 10 + 1
		         13                    11 = ((13 - 1)/10) * 10 + 1
		         14                    11
		         15                    11
		         16                    11
		         17                    11
		         18                    11 
		         19                    11 
		         20                    11 = ((20 - 1)/10) * 10 + 1
		         
		         21                    21 = ((21 - 1)/10) * 10 + 1
		         22                    21 = ((22 - 1)/10) * 10 + 1
		         23                    21 = ((23 - 1)/10) * 10 + 1
		         ..                    ..
		         29                    21
		         30                    21 = ((30 - 1)/10) * 10 + 1
		*/
			
		String url = "waiting.os";
		
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
		
		
		// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		//           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		//           현재 페이지 주소를 뷰단으로 넘겨준다.
		String gobackURL = MyUtil.getCurrentURL(request);
		//	System.out.println("~~~~ 확인용 gobackURL : " + gobackURL);
		
		mav.addObject("gobackURL", gobackURL);
		
		mav.addObject("elecapprvoList", elecapprvoList);
		
		mav.setViewName("mina/elec_approval/waiting.tiles1");
		// /WEB-INF/views/tiles1/mina/elec_aproval/waiting.jsp 파일
		
		return mav;
	}

	
	// == 페이징 처리를 한 결재진행중 목록 보여주기 == //
	@RequestMapping(value = "/elecapproval/processing.os")
	public ModelAndView requiredLogin_elecApprProcessing(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		List<ElecApprovalVO> elecapprvoList = null;
		
		Map<String,String> paraMap = new HashMap<>();
		
		  
		// ** 로그인 사번 알아와야함 //
		HttpSession session = request.getSession();
		EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
		
		String login_emp_no = String.valueOf(loginemp.getEmp_no());
		
		paraMap.put("login_emp_no", login_emp_no);
		
		
		// 현재 페이지
	    String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		  
		
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
		int totalCount = 0;         // 총 게시물 건수
		int sizePerPage = 15;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;          // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		
		int startRno = 0;           // 시작 행번호
		int endRno = 0;             // 끝 행번호 
		
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalProcessingCount(paraMap);
		
		mav.addObject("totalCount", totalCount);
		
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
		
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
			
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		elecapprvoList = service.processingApprList(paraMap);
		// 페이징 처리한 결재대기중 목록 가져오기
		
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
		
		
			
		String url = "processing.os";
		
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
		
		// === 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		//     사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		//     현재 페이지 주소를 뷰단으로 넘겨준다.
		String gobackURL = MyUtil.getCurrentURL(request);
		//	System.out.println("~~~~ 확인용 gobackURL : " + gobackURL);
		
		mav.addObject("gobackURL", gobackURL);
		
		mav.addObject("elecapprvoList", elecapprvoList);
		
		
		mav.setViewName("mina/elec_approval/processing.tiles1");
		// /WEB-INF/views/tiles1/mina/elec_aproval/processing.jsp 파일

		return mav;
	}

	
	
	// == 페이징 처리를 한 결재완료 목록 보여주기 == //
	@RequestMapping(value = "/elecapproval/finished.os")
	public ModelAndView requiredLogin_elecApprFinished(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		List<ElecApprovalVO> elecapprvoList = null;
		
		Map<String,String> paraMap = new HashMap<>();
		
		  
		// ** 로그인 사번 알아와야함 //
		HttpSession session = request.getSession();
		EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
		
		String login_emp_no = String.valueOf(loginemp.getEmp_no());
		
		paraMap.put("login_emp_no", login_emp_no);
		
		
		// 현재 페이지
	    String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		  
		
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
		int totalCount = 0;         // 총 게시물 건수
		int sizePerPage = 15;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;          // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		
		int startRno = 0;           // 시작 행번호
		int endRno = 0;             // 끝 행번호 
		
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalFinishedCount(paraMap);
		
		mav.addObject("totalCount", totalCount);
		
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
		
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
			
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		elecapprvoList = service.finishedApprList(paraMap);
		// 페이징 처리한 결재대기중 목록 가져오기
		
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
		
		
			
		String url = "finished.os";
		
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
		
		// === 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		//     사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		//     현재 페이지 주소를 뷰단으로 넘겨준다.
		String gobackURL = MyUtil.getCurrentURL(request);
		//	System.out.println("~~~~ 확인용 gobackURL : " + gobackURL);
		
		mav.addObject("gobackURL", gobackURL);
		
		mav.addObject("elecapprvoList", elecapprvoList);
		
		
		mav.setViewName("mina/elec_approval/finished.tiles1");
		// /WEB-INF/views/tiles1/mina/elec_aproval/finished.jsp 파일

		return mav;
	}

	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 결재대기중 상세보기
	@RequestMapping(value = "/elecapproval/waitingDetail.os")
	public ModelAndView requiredLogin_elecApprWaitingDetail(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
			
			 // 조회하고자 하는 글번호 받아오기
			 String approval_no = request.getParameter("approval_no");
			 
			 // === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
			 //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
			 //           현재 페이지 주소를 뷰단으로 넘겨준다.
			 String gobackURL = request.getParameter("gobackURL"); 
			 
			 String login_userid = null;
			 
			 if(gobackURL != null) {
				 gobackURL = gobackURL.replaceAll(" ", "&"); // 이전글, 다음글을 클릭해서 넘어온 것임.
				 mav.addObject("gobackURL", gobackURL);
			 }
			 
			 try {
					Integer.parseInt(approval_no);
					// 로그인 유저 알아와야함
					// ElecApprovalVO loginuser = (ElecApprovalVO) session.getAttribute("loginuser");
					
					HttpSession session = request.getSession();
					EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
					
					login_userid = String.valueOf(loginemp.getEmp_no());
					
					/*
					 * if(loginuser != null) { login_userid = loginuser.getUserid(); // login_userid
					 * 는 로그인 되어진 사용자의 userid 이다. }
					 */
						
					
					ElecApprovalVO elecapprvo = null;
					
					// 글1개를 조회를 해주는 것
					elecapprvo = service.elecApprView(approval_no);
					
					
					// 중간결재자와 최종결재자의 사번을 받아서 각각의 EmployeeVO를 ElecApprovalVO에 추가해준다
					String	fk_mid_approver_no = null;
					String	fk_fin_approver_no = null;

					EmployeeVO empvo = null;
					EmployeeVO midapprvo = null;
					EmployeeVO finapprvo = null;
					
					int fk_emp_no = elecapprvo.getFk_emp_no();
					empvo = service.findEmp(String.valueOf(fk_emp_no));
					elecapprvo.setEmpvo(empvo);
					
					if(elecapprvo.getFk_mid_approver_no()!=null && !"".equals(elecapprvo.getFk_mid_approver_no())){
						fk_mid_approver_no = elecapprvo.getFk_mid_approver_no();
						midapprvo = service.findEmp(fk_mid_approver_no);
						elecapprvo.setMidapprvo(midapprvo);
					}
					
					if(elecapprvo.getFk_fin_approver_no()!=null && !"".equals(elecapprvo.getFk_fin_approver_no())){
						fk_fin_approver_no = elecapprvo.getFk_fin_approver_no();
						finapprvo = service.findEmp(fk_fin_approver_no);
						elecapprvo.setFinapprvo(finapprvo);
					}
					
					mav.addObject("login_userid", login_userid);
					mav.addObject("elecapprvo", elecapprvo);
					
			  	} catch(NumberFormatException e) {
			  		
			  	}

		mav.setViewName("mina/elec_approval/waitingDetail.tiles1");
		// /WEB-INF/views/tiles1/mina/elec_aproval/waitingDetail.jsp 파일

		return mav;
	}
	
	//결재진행중 상세보기
	@RequestMapping(value = "/elecapproval/processingDetail.os")
	public ModelAndView requiredLogin_elecApprProcessingDetail(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {


		 // 조회하고자 하는 글번호 받아오기
		 String approval_no = request.getParameter("approval_no");
		 
		 // === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		 //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		 //           현재 페이지 주소를 뷰단으로 넘겨준다.
		 String gobackURL = request.getParameter("gobackURL"); 
		 
		 String login_userid = null;
		 
		 if(gobackURL != null) {
			 gobackURL = gobackURL.replaceAll(" ", "&"); // 이전글, 다음글을 클릭해서 넘어온 것임.
			 mav.addObject("gobackURL", gobackURL);
		 }
		 
		 try {
				Integer.parseInt(approval_no);
				HttpSession session = request.getSession();
				EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
				
				login_userid = String.valueOf(loginemp.getEmp_no());
				/*
				 * if(loginuser != null) { login_userid = loginuser.getUserid(); // login_userid
				 * 는 로그인 되어진 사용자의 userid 이다. }
				 */
					
				ElecApprovalVO elecapprvo = null;
				
				// 글1개를 조회를 해주는 것
				elecapprvo = service.elecApprView(approval_no);
				
				
				// 중간결재자와 최종결재자의 사번을 받아서 각각의 EmployeeVO를 ElecApprovalVO에 추가해준다
				String	fk_mid_approver_no = null;
				String	fk_fin_approver_no = null;

				EmployeeVO empvo = null;
				EmployeeVO midapprvo = null;
				EmployeeVO finapprvo = null;
				
				int fk_emp_no = elecapprvo.getFk_emp_no();
				empvo = service.findEmp(String.valueOf(fk_emp_no));
				elecapprvo.setEmpvo(empvo);
				
				if(elecapprvo.getFk_mid_approver_no()!=null && !"".equals(elecapprvo.getFk_mid_approver_no())){
					fk_mid_approver_no = elecapprvo.getFk_mid_approver_no();
					midapprvo = service.findEmp(fk_mid_approver_no);
					elecapprvo.setMidapprvo(midapprvo);
				}
				
				if(elecapprvo.getFk_fin_approver_no()!=null && !"".equals(elecapprvo.getFk_fin_approver_no())){
					fk_fin_approver_no = elecapprvo.getFk_fin_approver_no();
					finapprvo = service.findEmp(fk_fin_approver_no);
					elecapprvo.setFinapprvo(finapprvo);
				}
				
				mav.addObject("login_userid", login_userid);
				mav.addObject("elecapprvo", elecapprvo);
				
		  	} catch(NumberFormatException e) {
		  		
		  	}
		
		mav.setViewName("mina/elec_approval/processingDetail.tiles1");
		// /WEB-INF/views/tiles1/mina/elec_aproval/processingDetail.jsp 파일

		return mav;
	}

	
	
	
	
	// 결재완료 상세보기	
	@RequestMapping(value = "/elecapproval/finishedDetail.os")
	public ModelAndView requiredLogin_elecAppFinishedDetail(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
		

		 // 조회하고자 하는 글번호 받아오기
		 String approval_no = request.getParameter("approval_no");
		 
		 // === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		 //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		 //           현재 페이지 주소를 뷰단으로 넘겨준다.
		 String gobackURL = request.getParameter("gobackURL"); 
		 
		 String login_userid = null;
		 
		 if(gobackURL != null) {
			 gobackURL = gobackURL.replaceAll(" ", "&"); // 이전글, 다음글을 클릭해서 넘어온 것임.
			 mav.addObject("gobackURL", gobackURL);
		 }
		 
		 try {
				Integer.parseInt(approval_no);
				HttpSession session = request.getSession();
				EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
				
				login_userid = String.valueOf(loginemp.getEmp_no());
				
				/*
				 * if(loginuser != null) { login_userid = loginuser.getUserid(); // login_userid
				 * 는 로그인 되어진 사용자의 userid 이다. }
				 */
					
				
				ElecApprovalVO elecapprvo = null;
				
				// 글1개를 조회를 해주는 것
				elecapprvo = service.elecApprView(approval_no);
				
				
				// 중간결재자와 최종결재자의 사번을 받아서 각각의 EmployeeVO를 ElecApprovalVO에 추가해준다
				String	fk_mid_approver_no = null;
				String	fk_fin_approver_no = null;

				EmployeeVO empvo = null;
				EmployeeVO midapprvo = null;
				EmployeeVO finapprvo = null;
				
				int fk_emp_no = elecapprvo.getFk_emp_no();
				empvo = service.findEmp(String.valueOf(fk_emp_no));
				elecapprvo.setEmpvo(empvo);
				
				if(elecapprvo.getFk_mid_approver_no()!=null && !"".equals(elecapprvo.getFk_mid_approver_no())){
					fk_mid_approver_no = elecapprvo.getFk_mid_approver_no();
					midapprvo = service.findEmp(fk_mid_approver_no);
					elecapprvo.setMidapprvo(midapprvo);
				}
				
				if(elecapprvo.getFk_fin_approver_no()!=null && !"".equals(elecapprvo.getFk_fin_approver_no())){
					fk_fin_approver_no = elecapprvo.getFk_fin_approver_no();
					finapprvo = service.findEmp(fk_fin_approver_no);
					elecapprvo.setFinapprvo(finapprvo);
				}
				
				mav.addObject("login_userid", login_userid);
				mav.addObject("elecapprvo", elecapprvo);
				
		  	} catch(NumberFormatException e) {
		  		
		  	}
		
		mav.setViewName("mina/elec_approval/finishedDetail.tiles1");
		// /WEB-INF/views/tiles1/mina/elec_aproval/finishedDetail.jsp 파일

		return mav;
	}

	

	// === #163. 첨부파일 다운로드 받기 === //
	@RequestMapping(value="/elecapproval/download.os") 
	public void download(HttpServletRequest request, HttpServletResponse response) {
		
		// 첨부파일이 있는 글번호 
		String approval_no = request.getParameter("approval_no");
		
		/*
		   첨부파일이 있는 글번호에서
		 20201209142730107400829530700.jpg 처럼
		  이러한 fileName 값을 DB에서 가져와야 한다.
		  또한 orgFilename 값도 DB에서 가져와야 한다.       
		*/
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = null;
		
		try {
			Integer.parseInt(approval_no);
			
			ElecApprovalVO elecapprvo = service.elecApprView(approval_no);
			String server_file_name = elecapprvo.getServer_file_name(); // 20201209142730107400829530700.jpg  이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다. 
			String org_file_name = elecapprvo.getOrg_file_name(); 		// berkelekle디스트리뷰트06.jpg  다운로드시 보여줄 파일명.
			
			// 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
			// 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			System.out.println("~~~~ webapp 의 절대경로 => " + root);
			// ~~~~ webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
			
			String path = root+"resources"+ File.separator +"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		              운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		              운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
		    */
			
			// **** file 다운로드 하기 **** // 
			boolean flag = false; // file 다운로드의 성공,실패를 알려주는 용도 
			flag = fileManager.doFileDownload(server_file_name, org_file_name, path, response);
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
				
	}
	
	
	
	// === 주소록에서 조직 클릭한 경우(ajax) ===findEmpList //
   @ResponseBody
   @RequestMapping(value="/elecapproval/writeAddAddress.os", produces="text/plain; charset=UTF-8")
   public String writeAddAddress(HttpServletRequest request) {
      
      String fk_dept_no = request.getParameter("fk_dept_no");
      
      Map<String, String> paraMap = new HashedMap<>();
      paraMap.put("fk_dept_no", fk_dept_no);
      
      // 부서에 따른 사원조회
      List<EmployeeVO> empList = service.findEmpList(paraMap);
      
      for (EmployeeVO emp : empList) {
         System.out.println("사원이름==>" + emp.getEmp_name());
         System.out.println("직위명==>" + emp.getPosition_name());
         System.out.println("부서명==>" + emp.getDept_name());
         System.out.println("사원번호==>" + emp.getEmp_no());
      }
      
      JSONArray jsonArr = new JSONArray();
      
      if(empList != null) {
         for(EmployeeVO vo : empList) {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("emp_name", vo.getEmp_name());       
            jsonObj.put("position_name", vo.getPosition_name());    
            jsonObj.put("dept_name", vo.getDept_name());
            jsonObj.put("emp_no", vo.getEmp_no());
            
            // {"no":101, "name":"이순신", "writeday":"2020-11-24 16:20:30"}  {"no":1004, "name":"신호연", "writeday":"2020-11-24 16:20:30"}
            
            jsonArr.put(jsonObj);
         }
         
      }
      
      return jsonArr.toString();
   }   

   
   // 결재대기중 문서에 의견 넣기, 결재 (글수정, update)
	@RequestMapping(value="/elecapproval/confirmApproval.os", method= {RequestMethod.POST})
	public ModelAndView confirmApproval(ElecApprovalVO elecapprvo, HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		  // 중간결재자의 승인인지 최종결재자의 승인인지를 파악하기 위하여 아래와 같이 한다.
		  String approvalType = "";
		  
		  
		  // 결과값은 "mid" 또는 "fin"으로 나올 것
		  if(request.getParameter("approvalType")!=null) { 
			  approvalType = request.getParameter("approvalType"); 
		  }
		  
		  
		  // 이미 vo에 각각의 의견값은 들어가 있다. 
		  int n = 0;
		
		  if("mid".equalsIgnoreCase(approvalType)) { 
			  n = service.confirmMidApproval(elecapprvo); 
		  }
		  
		  if("fin".equalsIgnoreCase(approvalType)) { 
			  n = service.confirmFinApproval(elecapprvo); 
		  }
		 
		// n 이 1 이라면 정상적으로 변경됨.
		
		if(n == 0) {
			mav.addObject("message", "승인 실패!!");
			mav.addObject("loc", request.getContextPath()+"/elecapproval/waitingDetail.os?approval_no="+elecapprvo.getApproval_no());    
		}
		else {
			mav.addObject("message", "승인 성공!!");
			mav.addObject("loc", request.getContextPath()+"/elecapproval/waiting.os");    
		}
		
		mav.setViewName("tiles1/mina/minaMsg");
		
		return mav;
	}
	
	
	////////////////////////////////////////////////////////반려////////////////////////////////////////////////////////////
	// 결재대기중 문서에 의견 넣기, 반려 (글수정, update)
		@RequestMapping(value="/elecapproval/rejectApproval.os", method= {RequestMethod.POST})
		public ModelAndView rejectApproval(ElecApprovalVO elecapprvo, HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			// 중간결재자의 승인인지 최종결재자의 승인인지를 파악하기 위하여 아래와 같이 한다.
			  String approvalType = "";
			  
			  
			  // 결과값은 "mid" 또는 "fin"으로 나올 것
			  if(request.getParameter("approvalType")!=null) { 
				  approvalType = request.getParameter("approvalType"); 
			  }
			  
			  
			  // 이미 vo에 각각의 의견값은 들어가 있다. 
			  int n = 0;
			
			  if("mid".equalsIgnoreCase(approvalType)) { 
				  n = service.rejectMidApproval(elecapprvo); 
			  }
			  
			  if("fin".equalsIgnoreCase(approvalType)) { 
				  n = service.rejectFinApproval(elecapprvo); 
			  }
			 
			// n 이 1 이라면 정상적으로 변경됨.
			
			if(n == 0) {
				mav.addObject("message", "반려 실패!!");
				mav.addObject("loc", request.getContextPath()+"/elecapproval/waitingDetail.os?approval_no="+elecapprvo.getApproval_no());    
			}
			else {
				mav.addObject("message", "반려 성공!!");
				mav.addObject("loc", request.getContextPath()+"/elecapproval/waiting.os");    
			}
			
			mav.setViewName("tiles1/mina/minaMsg");
			
			return mav;
		}
	
		// === 결재취소 (글삭제) === //
		@RequestMapping(value="/elecapproval/delProcessing.os", method= {RequestMethod.POST})
		public ModelAndView delProcessing(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			String approval_no = request.getParameter("approval_no");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("approval_no", approval_no);
			
			// === #164. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. === //
			ElecApprovalVO elecapprvo = service.elecApprView(approval_no);
			String fileName = elecapprvo.getServer_file_name();
			
			if( fileName != null || !"".equals(fileName) ) {
				paraMap.put("fileName", fileName); // 삭제해야할 파일명
			
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+ File.separator +"files"; 
				
				paraMap.put("path", path); // 삭제해야할 파일이 저장된 경로
			}
			//////////////////////////////////////////////////////////////////////
			
			int n = service.delProcessing(paraMap); 
			// n 이 1 이라면 정상적으로 삭제됨.
			// n 이 0 이라면 글삭제에 필요한 글암호가 틀린경우  
			
			if(n == 0) {
				mav.addObject("message", "상신 취소(삭제)가 불가합니다.");
				
			//  === #166. 글삭제 실패시 글1개를 보여주면서 목록보기 버튼 클릭시 올바르게 가기 위해서 gobackURL=list.action 을 추가해줌. === //
				mav.addObject("loc", request.getContextPath()+"/elecapproval/processingDetail.os?approval_no="+approval_no+"&gobackURL=elecapproval/processing.os");
			}
			else {
				mav.addObject("message", "상신 취소(삭제) 성공!!");
				mav.addObject("loc", request.getContextPath()+"/elecapproval/processing.os");
			}
			 
			mav.setViewName("tiles1/mina/minaMsg");
			
			return mav;
		}
		
		
}
