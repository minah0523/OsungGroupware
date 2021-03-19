package com.spring.groupware.yongjin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.mina.model.AttendanceVO;

@Repository
public class HolidayDAO implements InterHolidayDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	
	// 휴가 내역 count //
	@Override
	public int historyNumber(Map<String, String> paraMap) {
		int count = sqlsession.selectOne("yongjin2.historyNumber", paraMap);
		return count;
	}// end of public int historyNumber(Map<String, String> paraMap) {}-----------------------


	// 휴가 내역 목록 //
	@Override
	public List<AttendanceVO> historyList(Map<String, String> paraMap) {
		List<AttendanceVO> attendList = sqlsession.selectList("yongjin2.historyList", paraMap);
		return attendList;
	}// end of public List<AttendanceVO> historyList(Map<String, String> paraMap) {}--------------------

}
