package com.spring.groupware.yongjin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.mina.model.AttendanceVO;
import com.spring.groupware.yongjin.model.InterHolidayDAO;

@Service
public class HolidayService implements InterHolidayService {
	
	@Autowired
	private InterHolidayDAO dao;

	
	// 휴가 내역 count //
	@Override
	public int historyNumber(Map<String, String> paraMap) {
		int count = dao.historyNumber(paraMap);
		return count;
	}// end of public int historyNumber(Map<String, String> paraMap) {}--------------------


	// 휴가 내역 목록 //
	@Override
	public List<AttendanceVO> historyList(Map<String, String> paraMap) {
		List<AttendanceVO> attendList = dao.historyList(paraMap);
		return attendList;
	}// end of public List<AttendanceVO> historyList(Map<String, String> paraMap) {}----------------------

}
