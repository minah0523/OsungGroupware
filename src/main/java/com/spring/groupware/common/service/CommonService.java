package com.spring.groupware.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.common.model.InterCommonDAO;

@Service
public class CommonService implements InterCommonService {
	
	@Autowired
	private InterCommonDAO dao;

}
