package com.spring.groupware.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.groupware.common.service.InterCommonService;

@Controller
public class CommonController {
	
	@Autowired
	private InterCommonService service;

}
