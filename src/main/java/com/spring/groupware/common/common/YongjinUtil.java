package com.spring.groupware.common.common;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class YongjinUtil {
	
	// 인증번호 보내기
	public static boolean sendCertificationCode(String email, HttpServletRequest request) {
		
		boolean sendMailSuccess = true;
		
		// 인증키를 생성한다.
		int certCharLength = 12;
	    char[] characterTable = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 
	                              'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 
	                              'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
	                              'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
	                              'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
	    
        Random random = new Random(System.currentTimeMillis());
        int tableLength = characterTable.length;
        StringBuffer buf = new StringBuffer();
        
        for(int i = 0; i < certCharLength; i++) {
            buf.append(characterTable[random.nextInt(tableLength)]);
        }
        
        String strBuf = buf.toString();
        
        GoogleMail mail = new GoogleMail();
		
		try {
			mail.sendCertificationCode(email, strBuf);
			
			// 세션 불러오기
			HttpSession session = request.getSession();
			session.setAttribute("certificationCode", strBuf);  // 발급한 인증키를 세션에 저장한다.
		} catch(Exception e) {
			// 메일 전송이 실패한 경우
			e.printStackTrace();
			sendMailSuccess = false;  // 메일 전송 실패를 기록한다.
		}// end of try~catch {}-----------------------
		
		return sendMailSuccess;
	}// end of public static boolean sendCertificationCode(String email) {}
	
	
	// 임시 비밀번호 생성하기
	public static String generateCertPassword(String email, HttpServletRequest request) {
		int pwdLength = 8;
		char[] passwordTable = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 
								 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
								 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
								 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 
								 'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&', '*',
								 '(', ')', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
		
		Random random = new Random(System.currentTimeMillis());
        int tablelength = passwordTable.length;
        StringBuffer buf = new StringBuffer();
        
        for(int i = 0; i < pwdLength; i++) {
            buf.append(passwordTable[random.nextInt(tablelength)]);
        }// end of for(int i = 0; i < pwdLength; i++) {}-------------------------
        
        String strBuf = buf.toString();
        
        GoogleMail mail = new GoogleMail();
		
		try {
			mail.sendPassword(email, strBuf);
		} catch(Exception e) {}// end of try~catch {}-----------------------
        
        return strBuf;
	}// end of public static String generateCertPassword() {}---------------------------

}
