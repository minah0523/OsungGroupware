package com.spring.groupware.common.common;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {
	
	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		// GMail의 경우 @gmail.com 을 제외한 아이디만 입력한다.
		
		// 업로드시 삭제!!
		return new PasswordAuthentication("","");
	}// end of public PasswordAuthentication getPasswordAuthentication() {}

}
