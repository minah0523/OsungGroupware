package com.spring.groupware.common.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	
	// @@@ ? 다음의  데이터까지 포함한 현재 URL 주소를 알려주는 메소드 생성하기 @@@ //
	public static String getCurrentURL(HttpServletRequest request) {
		String currentURL = request.getRequestURL().toString();  // URL 주소를 가져와 String 타입으로 만든다.
		// http://localhost:9090/MyMVC/member/memberList.up
		// ? 다음의 데이터는 포함하지 않는다.
		
		String queryString = request.getQueryString();
		// currentShowPageNo=15&sizePerPage=5&searchType=name&searchWord=승의
		// URL 주소에서 ? 다음의 데이터를 가져온다.
		
		// -- 데이터가 없을 경우에도 queryString 을 가져온다면 null 값이 붙기 때문에 조건절로 나눈다.
		if(queryString != null) {
			currentURL += "?"+queryString;  // ? 를 제외하고 가져오기 때문에 ? 를 결합한다.
			// http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=15&sizePerPage=5&searchType=name&searchWord=승의
		}
		
		String ctxPath = request.getContextPath();  // /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		// 21(ctxPath 의 시작인 /의 인덱스) + 6 == ctxPath 뒤 URL 의 시작 인덱스
				
	//	currentURL = currentURL.substring(beginIndex);
		// /member/memberList.up?currentShowPageNo=15&sizePerPage=5&searchType=name&searchWord=승의
		
		currentURL = currentURL.substring(beginIndex + 1);
		// member/memberList.up?currentShowPageNo=15&sizePerPage=5&searchType=name&searchWord=승의
		
		return currentURL;
	}// end of public static String getCurrentURL(HttpServletRequest request) {}---------------------
	
	
	// ---- 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 ---- //
	public static String secureCode(String str) {
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		
		return str;
	}// end of public static String secureCode(String str) {}--------------------------------

}
