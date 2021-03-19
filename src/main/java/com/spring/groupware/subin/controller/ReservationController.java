package com.spring.groupware.subin.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.subin.model.ReservationVO;
import com.spring.groupware.subin.model.Reservation_resourceVO;
import com.spring.groupware.subin.service.InterReservationService;
import com.spring.groupware.yongjin.model.EmployeeVO;


@Controller
public class ReservationController {

	@Autowired
	private InterReservationService service;

	
	// 나의 예약 목록으로 이동
	@RequestMapping(value = "/goMyRsvList.os")
	public ModelAndView requiredLogin_myRsvList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("subin/reservation/myRsvList.tiles1");
		
		return mav;
	}
	
	// 나의 예약 목록을 읽어오기
	@ResponseBody
	@RequestMapping(value="/readRsvList.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String readRsvList(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		if (loginManager != null) {
			
			String fk_emp_no = String.valueOf(loginManager.getEmp_no());
			
			Map<String, String> paraMap = new HashedMap<String, String>();
			paraMap.put("fk_emp_no", fk_emp_no);
			
			List<ReservationVO> rsvList = service.readRsvList(paraMap);
			
			JSONArray jsonArr = new JSONArray();
			
			for (ReservationVO rsv : rsvList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("reservation_no", rsv.getReservation_no());
				jsonObj.put("fk_resource_no", rsv.getFk_resource_no());
				jsonObj.put("fk_reservation_resource_no", rsv.getFk_reservation_resource_no());
				jsonObj.put("fk_emp_no", rsv.getFk_emp_no());
				jsonObj.put("Rname", rsv.getRname());
				jsonObj.put("RSname", rsv.getRSname());
				jsonObj.put("startday", rsv.getStartday());
				jsonObj.put("endday", rsv.getEndday());
				jsonObj.put("reason", rsv.getReason());
				
				jsonArr.put(jsonObj);
			}
			
			
			return jsonArr.toString();
			
		}
		
		JSONObject jsonObj = new JSONObject();
		
		return jsonObj.toString();
	}
	
	
	// 예약 상세보기 불러오기
	@ResponseBody
	@RequestMapping(value="/readDetailRsvList.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String readDetailRsvList(HttpServletRequest request) {

		String reservation_no = request.getParameter("reservation_no");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("reservation_no", reservation_no);
		
		ReservationVO rsvvo = service.readDetailRsvList(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("reservation_no", rsvvo.getReservation_no());
		jsonObj.put("fk_resource_no", rsvvo.getFk_resource_no());
		jsonObj.put("fk_reservation_resource_no", rsvvo.getFk_reservation_resource_no());
		jsonObj.put("fk_emp_no", rsvvo.getFk_emp_no());
		jsonObj.put("emp_name", rsvvo.getEmp_name());
		jsonObj.put("Rname", rsvvo.getRname());
		jsonObj.put("RSname", rsvvo.getRSname());
		jsonObj.put("info", rsvvo.getInfo());
		jsonObj.put("startday", rsvvo.getStartday());
		jsonObj.put("endday", rsvvo.getEndday());
		jsonObj.put("reason", rsvvo.getReason());
		
		return jsonObj.toString();
	}
	
	
	// 예약 취소하기
	@ResponseBody
	@RequestMapping(value="/rsvCancel.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String rsvCancel(HttpServletRequest request) {

		String reservation_no = request.getParameter("reservation_no");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("reservation_no", reservation_no);
		
		int n = service.rsvCancel(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 회의실 예약 페이지로 이동
	@RequestMapping(value = "/goRsv.os")
	public ModelAndView requiredLogin_goRsv(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		mav.addObject("loginManager", loginManager);
		mav.setViewName("subin/reservation/doRsv.tiles1");
		
		return mav;
	}
	
	// 예약정보 불러오기(회원번호, 자원번호로 검색)
	@ResponseBody
	@RequestMapping(value="/selectRsvList.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String selectRsvList(HttpServletRequest request) {

		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		String fk_reservation_resource_no = request.getParameter("fk_reservation_resource_no");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("fk_reservation_resource_no", fk_reservation_resource_no);
		
		List<ReservationVO> rsvList = service.selectRsvList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		for (ReservationVO rsvvo : rsvList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("reservation_no", rsvvo.getReservation_no());
			jsonObj.put("fk_resource_no", rsvvo.getFk_resource_no());
			jsonObj.put("fk_reservation_resource_no", rsvvo.getFk_reservation_resource_no());
			jsonObj.put("fk_emp_no", rsvvo.getFk_emp_no());
			jsonObj.put("emp_name", rsvvo.getEmp_name());
			jsonObj.put("Rname", rsvvo.getRname());
			jsonObj.put("RSname", rsvvo.getRSname());
			jsonObj.put("info", rsvvo.getInfo());
			jsonObj.put("startday", rsvvo.getStartday());
			jsonObj.put("endday", rsvvo.getEndday());
			jsonObj.put("reason", rsvvo.getReason());
			
			jsonArr.put(jsonObj);
		}
		
		
		
		return jsonArr.toString();
	}
	
	// (modal) 예약하기 모달에 이용가능한 자원명 리스트를 select 해옴
	@ResponseBody
	@RequestMapping(value="/readRsList.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String readRsList(HttpServletRequest request) {

		List<Reservation_resourceVO> rsList = service.readRsList();
		
		JSONArray jsonArr = new JSONArray();
		
		for (Reservation_resourceVO rsvo : rsList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("reservation_resource_no", rsvo.getReservation_resource_no());
			jsonObj.put("fk_resource_no", rsvo.getFk_resource_no());
			jsonObj.put("name", rsvo.getName());
			jsonObj.put("info", rsvo.getInfo());
			
			jsonArr.put(jsonObj);
		}
		
		
		
		return jsonArr.toString();
	}
	
	
	// (modal) 예약 테이블에 예약한 값 넣어주기
	@ResponseBody
	@RequestMapping(value="/addModalRsv.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String addModalRsv(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_reservation_resource_no = request.getParameter("fk_reservation_resource_no");
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		String reason = request.getParameter("reason");
		
		// 예약 테이블에 넣어줄 fk_resource_no 구해오기
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("fk_reservation_resource_no", fk_reservation_resource_no);
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("startday", startday);
		paraMap.put("endday", endday);
		paraMap.put("reason", reason);

		String fk_resource_no = service.findFk_resource_no(paraMap);
		paraMap.put("fk_resource_no", fk_resource_no);
		
		// 입력받은 일시가 중복된 날짜인지 검사
		int overlap = service.checkOverlapRsv(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		if (overlap != 0) {
			// 사용자가 선택한 시간대에 이미 예약이 있을 경우
			jsonObj.put("n", -1);
			
			return jsonObj.toString();
			
		}else {
			// 예약이 가능한 경우 예약테이블에 데이터 insert 진행
			int n = service.addModalRsv(paraMap);
			jsonObj.put("n", n);
			
			return jsonObj.toString();
		}
		

		
		
	}
	
	
}
