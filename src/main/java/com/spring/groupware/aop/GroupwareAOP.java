package com.spring.groupware.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.groupware.common.common.MyUtil;

@Aspect
@Component
public class GroupwareAOP {
	
	// ===== Before Advice 만들기 ====== // 
	/*
		주업무(<예: 글쓰기, 글수정, 댓글쓰기 등등>)를 실행하기 앞서서  
		이러한 주업무들은 먼저 로그인을 해야만 사용가능한 작업이므로
		주업무에 대한 보조업무<예: 로그인 유무검사> 객체로 로그인 여부를 체크하는
		관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
		동작하도록 만들겠다.
	*/
	
	// === Pointcut 설정하기 === //
	// Pointcut 이란 공통 관심사를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..))")
	// 공통 관심사를 필요로 하는 메소드를 가져와야 한다.
	// Pointcut("execution(메소드 접근제한자 *(모든 반환타입) 패키지..(공통 패키지 아래 패키지는 모든 패키지를 포함)*Controller(Controller 로 끝나는 클래스명).requiredLogin_(requiredLogin_ 로 시작하는 메소드명)*(..))") (..) 마지막 . 두 개는 모든 파라미터 종류 포함을 의미(있든 없든)
	// 메소드 접근제한자는 기본이 public 으로 생략하면 public 으로 인식한다(외부에서 메소드에 접근하기 위해서는 기본적으로 public 이어야 가능하기 때문에 기본으로 인식).
	public void requiredLogin() {}
	
	// === Before Advice(공통 관심사) 구현 === //
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinPoint) {  // Pointcut 전에 로그인 유무를 검사하는 메소드 작성
		// JoinPoint joinPoint 는 포인트컷된 주업무의 메소드를 말한다.
		
		// 로그인 유무를 확인하기 위해서는 request 를 통해 session 을 가져와야 한다.
		HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[0];  // getArgs() 는 주 업무 메소드의 모든 파라미터를 배열로 가져오는 것이다. [0] 인덱스는 첫 번째 파라미터 객체를 반환한다.
		HttpServletResponse response = (HttpServletResponse)joinPoint.getArgs()[1];
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginemp") == null) {
			String message = "로그인이 필요합니다.";
			String loc = request.getContextPath()+"/login.os";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// === 로그인 성공 후 로그인 하기 전 페이지로 돌아가는 작업 만들기 === //
			// === 현재 페이지의 주소(URL) 알아오기 === //
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url);  // 세션에 URL 정보를 저장한다.
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");  // Controller 가 아니기 때문에 뷰 리졸버를 이용할 수 없다. 따라서 dispatcher 로 직접 이동시킨다.
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// ===== After Advice 만들기 ====== // 
	/*
		주업무(<예: 글쓰기, 글수정, 댓글쓰기 등등>)를 실행한 다음에
		회원의 포인트를 특정 점수만큼(예: 100점, 200점, 300점) 증가시키는 것이 공통의 관심사(보조업무)라고 보자.
		관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
		동작하도록 만들겠다.
	*/

}
