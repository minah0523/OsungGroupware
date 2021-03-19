package com.spring.groupware.subin.controller;

import java.util.List;
import java.util.Map;

import javax.mail.Session;
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

import com.spring.groupware.subin.model.CalendarVO;
import com.spring.groupware.subin.model.ScheduleVO;
import com.spring.groupware.subin.service.InterScheduleService;
import com.spring.groupware.yongjin.model.EmployeeVO;

@Controller
public class CalendarController {

	@Autowired
	private InterScheduleService service;
	
	@RequestMapping(value = "/goCalendar.os")
	public ModelAndView requiredLogin_goCalendar(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("subin/calendar/calendar.tiles1");
		
		return mav;
	}

	///////////////////////지은언니 주소록 Modal////////////////////////////////
	// === 쪽지함의 쪽지쓰기의 주소록에서 조직 클릭한 경우(ajax) === //
	   @ResponseBody
	   @RequestMapping(value="/subin/writeAddAddress.os", produces="text/plain; charset=UTF-8")
	   public String writeAddAddress(HttpServletRequest request) { 
	      
	      String fk_dept_no = request.getParameter("fk_dept_no");
	      //System.out.println("모달창에서 클릭한 부서 번호 ==> " + fk_dept_no);
	      
	      Map<String, String> paraMap = new HashedMap<>();
	      paraMap.put("fk_dept_no", fk_dept_no);
	      
	      // 부서에 따른 사원조회
	      List<EmployeeVO> empList = service.findEmpList(paraMap);

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
	   
	   // === 쪽지쓰기의 주소록 내에서 검색(ajax)  === //
	   @ResponseBody
	   @RequestMapping(value="/subin/writeAddressSearch.os", produces="text/plain; charset=UTF-8")
	   public String writeAddressSearch(HttpServletRequest request) {
	      
	      String searchWord = request.getParameter("searchWord");
	      
	      // System.out.println("검색어는 ? ==> " + searchWord);
	      
	      Map<String, String> paraMap = new HashedMap<>();
	      paraMap.put("searchWord", searchWord);
	      
	      List<EmployeeVO> empSearchList = service.empSearchList(paraMap);
	      
	      JSONArray jsonArr = new JSONArray();
	      
	      if(empSearchList != null) {
	         for(EmployeeVO vo : empSearchList) {
	            JSONObject jsonObj = new JSONObject();
	            jsonObj.put("emp_name", vo.getEmp_name());       
	            jsonObj.put("position_name", vo.getPosition_name());    
	            jsonObj.put("dept_name", vo.getDept_name());
	            jsonObj.put("emp_no", vo.getEmp_no());
	            
	            jsonArr.put(jsonObj);
	         }
	         
	      }
	      
	      // System.out.println("jsonArr.toString() ========>" + jsonArr.toString());
	      
	      return jsonArr.toString();
	   }

	
	 ///////////////////////지은언니 주소록 Modal////////////////////////////////
	
	@RequestMapping(value = "/editCal.os")
	public ModelAndView requiredLogin_editCal(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("subin/calendar/editCal.tiles1");
		
		return mav;
	}
	
	// 일정 불러오기
	@ResponseBody
	@RequestMapping(value="/selectSchList.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String selectSchList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		String sCalNo = request.getParameter("sCalNo");
		String[] calNoArr = sCalNo.split(",");
		
		Map<String, Object> paraMap = new HashedMap<String, Object>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("calNoArr", calNoArr);
		
		List<ScheduleVO> schList = service.selectSchList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		for (ScheduleVO schvo : schList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("schedule_no", schvo.getSchedule_no());
			jsonObj.put("fk_emp_no", schvo.getFk_emp_no());
			jsonObj.put("fk_calendar_no", schvo.getFk_calendar_no());
			jsonObj.put("title", schvo.getTitle());
			jsonObj.put("startday", schvo.getStartday());
			jsonObj.put("endday", schvo.getEndday());
			jsonObj.put("content", schvo.getContent());
			jsonObj.put("color", schvo.getColor());

			jsonArr.put(jsonObj);
		}
		
		// -9999를 초대받은 일정 캘린더로 설정하고 -9999를 받으면 내 캘린더와 비교해서 없는 캘린더를 받아서 list에 넣어주기
		
		// 사용자가 초대받은 일정을 체크했는지 확인
		// 0: 미체크, 1: 체크
		int isInvite = 0;
		for (String calNo : calNoArr) {
			if ("-9999".equalsIgnoreCase(calNo)) {
				isInvite = 1;
			}
		}
		
		// 초대받은 일정에 체크했을 시
		if (isInvite == 1) {
			// 로그인한 사원의 내 캘린더 번호를 배열로 받아옴
			List<CalendarVO> calList = service.readCalList(fk_emp_no);
			
			String[] noInvitecalArr = null;
			if (calList != null) {
				noInvitecalArr = new String[calList.size()];
				for (int i = 0; i < calList.size(); i++) {
					noInvitecalArr[i] = calList.get(i).getCalendar_no();
				}
			}

			paraMap.put("noInvitecalArr", noInvitecalArr);

			// 받아온 배열로 not in(받아온 배열)을 사용해서 내 캘린더에 없는 일정 받아오기
			List<ScheduleVO> noCalschList = service.selectNoCalSchList(paraMap);

			// 받아온 초대받은 일정을 view단으로 보내줄 jsonArr에 담기
			if (noCalschList != null) {
				for (ScheduleVO schvo : noCalschList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("schedule_no", schvo.getSchedule_no());
					jsonObj.put("fk_emp_no", schvo.getFk_emp_no());
					jsonObj.put("fk_calendar_no", schvo.getFk_calendar_no());
					jsonObj.put("title", schvo.getTitle());
					jsonObj.put("startday", schvo.getStartday());
					jsonObj.put("endday", schvo.getEndday());
					jsonObj.put("content", schvo.getContent());
					jsonObj.put("color", "violet");

					jsonArr.put(jsonObj);
				}
			}
			
			
			
		}
		
		
		return jsonArr.toString();
	}
	
	// 캘린더(내일정)를 읽어오기
	@ResponseBody
	@RequestMapping(value="/readCalList.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String readCalList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		
		List<CalendarVO> calList = service.readCalList(fk_emp_no);
		
		JSONArray jsonArr = new JSONArray();
		
		for (CalendarVO calvo : calList) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("calendar_no", calvo.getCalendar_no());
			jsonObj.put("fk_emp_no", calvo.getFk_emp_no());
			jsonObj.put("name", calvo.getName());
			jsonObj.put("color", calvo.getColor());
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	// 캘린더(내일정)를 추가하기
	@ResponseBody
	@RequestMapping(value="/addCal.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String addCal(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		String name = request.getParameter("name");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("name", name);
		
		int n = service.addCal(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 캘린더(내일정)의 색상 변경하기
	@ResponseBody
	@RequestMapping(value="/editCalColor.os", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String editCalColor(HttpServletRequest request) {
		
		// 변경
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		String calendar_no = request.getParameter("calendar_no");
		String color = request.getParameter("color");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("calendar_no", calendar_no);
		paraMap.put("color", color);
		
		int n = service.editCalColor(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 캘린더(내일정) 삭제하기
	@ResponseBody
	@RequestMapping(value="/delCal.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String delCal(HttpServletRequest request) {
		
		String sDelCalNo = request.getParameter("sDelCalNo");
		
		String[] delCalNoArr = sDelCalNo.split(",");
		
		Map<String, Object> paraMap = new HashedMap<String, Object>();
		paraMap.put("delCalNoArr", delCalNoArr);
		
		int n = service.delCal(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 캘린더(내일정)의 이름 변경하기
	@ResponseBody
	@RequestMapping(value="/editCalName.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String editCalName(HttpServletRequest request) {
		
		String calendar_no = request.getParameter("calendar_no");
		String name = request.getParameter("name");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("calendar_no", calendar_no);
		paraMap.put("name", name);
		
		int n = service.editCalName(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// (Modal) 일정 추가하기
	@ResponseBody
	@RequestMapping(value="/addModalSch.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String addModalSch(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		String fk_calendar_no = request.getParameter("fk_calendar_no");
		String title = request.getParameter("title");
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		String content = request.getParameter("content");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("fk_calendar_no", fk_calendar_no);
		paraMap.put("title", title);
		paraMap.put("startday", startday);
		paraMap.put("endday", endday);
		paraMap.put("content", content);
		
		int n = 0;
		try {
			n = service.addModalSch(paraMap);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 일정 상세 추가 페이지로 이동(참가자는 로그인한유저)
	@RequestMapping(value = "/goAddDetailSch.os")
	public ModelAndView requiredLogin_goAddDetailSch(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String title = request.getParameter("title");
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		String bAllday = request.getParameter("bAllday");
		String fk_calendar_no = request.getParameter("fk_calendar_no");
		String content = request.getParameter("content");
		
		request.setAttribute("title", title);
		request.setAttribute("startday", startday);
		request.setAttribute("endday", endday);
		request.setAttribute("bAllday", bAllday);
		request.setAttribute("fk_calendar_no", fk_calendar_no);
		request.setAttribute("content", content);

		mav.setViewName("subin/calendar/addDetailSch.tiles1");
		
		return mav;
	}
	
	// 일정 상세 추가하기(다수의 참가자)
	@ResponseBody
	@RequestMapping(value="/addDetailSch.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String addDetailSch(HttpServletRequest request) {
		
		String title = request.getParameter("title");
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		String fk_calendar_no = request.getParameter("fk_calendar_no");
		String content = request.getParameter("content");
		String fk_emp_no_receive = request.getParameter("fk_emp_no_receive");
		
		String[] fk_emp_noArr = fk_emp_no_receive.split(",");
		
		Map<String, Object> paraMap = new HashedMap<String, Object>();
		paraMap.put("title", title);
		paraMap.put("startday", startday);
		paraMap.put("endday", endday);
		paraMap.put("fk_calendar_no", fk_calendar_no);
		paraMap.put("content", content);
		
		// 같은 일정일 시 묶어줄 groupid를 받음
		String groupId = service.selectGroupId();
		paraMap.put("groupId", groupId);
		
		int n = 0;
		int cnt = 0;	// for문을 사용했기 때문에 n값을 제대로 측정할 수 없으므로 cnt 라는 변수 선언
		
		for (String emp_no : fk_emp_noArr) {
			
			paraMap.put("fk_emp_no", emp_no);
			try {
				n = service.addDetailSch(paraMap);
				
				if (n == 1) cnt++;
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
		
		// 모든 것들이 insert 됐을 때
		if (fk_emp_noArr.length == cnt) {
			n = 1;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 일정 상세보기 페이지로 이동
	@RequestMapping(value = "/editSch.os")
	public ModelAndView requiredLogin_editSch(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String schedule_no = request.getParameter("schedule_no");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("schedule_no", schedule_no);
		
		ScheduleVO schvo = service.selectOneSch(paraMap);
		
		String start = schvo.getStartday().substring(0, 10);
		String end = schvo.getEndday().substring(0, 10);
		
		// 불러온 일정이 종일일 경우
		if (start.equals(end) && schvo.getEndday().substring(11).equals("23:59:59")) {
			mav.addObject("bAllday", 1);	// 뷰단의 체크박스를 위해 넘겨줌
		}
		
		mav.addObject("schvo", schvo);

		mav.setViewName("subin/calendar/editSch.tiles1");
		
		return mav;
	}
	
	// 참가자(이름) 불러오기
	@ResponseBody
	@RequestMapping(value="/selectAtd.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String selectAtd(HttpServletRequest request) {

		String schedule_no = request.getParameter("schedule_no");

		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("schedule_no", schedule_no);
		
		List<EmployeeVO> empList = service.selectAtd(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		for (EmployeeVO empvo : empList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("fk_emp_no", empvo.getEmp_no());
			jsonObj.put("emp_name", empvo.getEmp_name());

			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}

	
	// 일정 삭제하기(참석자로 묶인 일정들도 전부 함께 삭제)
	@ResponseBody
	@RequestMapping(value="/delSch.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String delSch(HttpServletRequest request) {
		
		String fk_schedule_no = request.getParameter("fk_schedule_no");
		
		Map<String, Object> paraMap = new HashedMap<String, Object>();
		paraMap.put("fk_schedule_no", fk_schedule_no);
		
		// 삭제할 일정 번호 받아오기
		List<String> fk_schedule_noArr = service.findDelSchNo(paraMap);
		String[] fk_schArr = new String[fk_schedule_noArr.size()];
		
		for (int i = 0; i < fk_schedule_noArr.size(); i++) {
			fk_schArr[i] = fk_schedule_noArr.get(i);
		}
		
		
		paraMap.put("fk_schArr", fk_schArr);

		JSONObject jsonObj = new JSONObject();
		
		// 위에서 받은 일정번호를 삭제하기
		int n = service.delSch(paraMap);
		
		if (n == fk_schedule_noArr.size()) {
			jsonObj.put("n", 1);
		}

		return jsonObj.toString();
	}
	
	// 일정을 수정하는 함수(참석자로 묶인 일정들도 전부 함께 수정)
	@ResponseBody
	@RequestMapping(value="/doEditSch.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String doEditSch(HttpServletRequest request) {
		
		String schedule_no = request.getParameter("schedule_no");
		String title = request.getParameter("title");
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		String fk_calendar_no = request.getParameter("fk_calendar_no");
		String content = request.getParameter("content");
		String fk_emp_no_receive = request.getParameter("fk_emp_no_receive");

		String[] fk_emp_noArr = fk_emp_no_receive.split(",");
		
		Map<String, Object> paraMap = new HashedMap<String, Object>();
		paraMap.put("fk_schedule_no", schedule_no);	// 같음
		paraMap.put("title", title);
		paraMap.put("startday", startday);
		paraMap.put("endday", endday);
		paraMap.put("fk_calendar_no", fk_calendar_no);
		paraMap.put("content", content);


		
		// 삭제할 일정번호 문자열로 받아오기
		List<String> delSchNoList = service.findDelSchNo(paraMap);
		
		String[] fk_schArr = new String[delSchNoList.size()]; 
		for (int i = 0; i < delSchNoList.size(); i++) {
			fk_schArr[i] = delSchNoList.get(i);
		}
		paraMap.put("fk_schArr", fk_schArr);
		
		// 해당하는 일정 삭제(참가자도 자동으로 삭제됨)
		service.delSch(paraMap);
		
		// 수정할 내용으로 새로운 일정들 생성
		String groupId = service.selectGroupId();
		paraMap.put("groupId", groupId);
		
		int n = 0;
		int cnt = 0;	// for문을 사용했기 때문에 n값을 제대로 측정할 수 없으므로 cnt 라는 변수 선언
		
		for (String emp_no : fk_emp_noArr) {
			
			paraMap.put("fk_emp_no", emp_no);
			try {
				n = service.addDetailSch(paraMap);
				
				if (n == 1) cnt++;
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
		
		/*
		// 삭제할 참가자 groupid 받아오기
		List<String> groupidList = service.findDelGroupid(schedule_no);
		String delGroupid = groupidList.get(0);
		paraMap.put("delGroupid", delGroupid);
		
		// 기존 참가자 데이터 전부 삭제
		int n = service.delGroupid(paraMap);
		
		// 같은 일정일 시 묶어줄 groupid를 받음
		String groupId = service.selectGroupId(); 
		paraMap.put("groupId", groupId);
		
		// 참가자 데이터 추가
		int n1 = 0;
		int cnt = 0;
		for (String emp_no : fk_emp_noArr) {
			
			paraMap.put("fk_emp_no", emp_no);
			try {
				n1 = service.updateAtd(paraMap);
				
				if (n1 == 1) cnt++;
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}

		
		// 기존 일정 전부 수정
		
		
		
		JSONArray jsonArr = new JSONArray();
		
		for (EmployeeVO empvo : empList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("fk_emp_no", empvo.getEmp_no());
			jsonObj.put("emp_name", empvo.getEmp_name());
			
			jsonArr.put(jsonObj);
		}*/
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", cnt);
		
		return jsonObj.toString();
	}
	
	// 삭제할 일정이 초대받은 일정인지 검사
	@ResponseBody
	@RequestMapping(value="/checkDelInviteSch.os", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String checkDelInviteSch(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginManager = (EmployeeVO)session.getAttribute("loginemp");
		
		String fk_emp_no = String.valueOf(loginManager.getEmp_no());
		String fk_schedule_no = request.getParameter("fk_schedule_no");
		String fk_calendar_no = request.getParameter("fk_calendar_no");
		
		Map<String, String> paraMap = new HashedMap<String, String>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("fk_schedule_no", fk_schedule_no);
		
		// 로그인한 사원의 내 캘린더 번호를 배열로 받아옴
		List<CalendarVO> calList = service.readCalList(fk_emp_no);
		
		// 받아온 글번호의 
		
		int n = 0;
		if (calList != null) {
			for (int i = 0; i < calList.size(); i++) {
				if (calList.get(i).getCalendar_no().equalsIgnoreCase(fk_calendar_no)) {
					// 불러온 캘린더와 겹치는 것이 있을 시 => 자신의 캘린더(삭제 가능)
					System.out.println("겹쳤음");
					n = 1;
					break;
				}else {
					// 불러온 캘린더와 겹치는 것이 없을 시 => 자신의 캘린더(삭제 불가)
					System.out.println("겹치는게 없을 때");
					n = 0;
				}
				
			}
		}else {
			// 자신의 캘린더가 아예 생성되지 않았을 경우 초대받은 캘린더만 있음(전부 삭제 불가)
			System.out.println("캘린더 없을 때");
			n = 0;
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}

	
	
}
