package com.spring.groupware.yongjin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.common.common.MyUtil;
import com.spring.groupware.mina.model.AttendanceVO;
import com.spring.groupware.yongjin.model.EmployeeVO;
import com.spring.groupware.yongjin.service.InterHolidayService;

@Controller
public class HolidayController {
	
	@Autowired
	private InterHolidayService service;
	
	
	// === 연차 내역 요청하기 === //
	@RequestMapping(value = "/holiday/holidayHistory.os")
	public ModelAndView requiredLogin_holidayHistory(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		/////////////////////////////////////////////////////////////////////////////////////
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String str_sizePerPage = request.getParameter("sizePerPage");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		
		int sizePerPage = 0;        // 한 페이지에 보일 주소록 수
		int currentShowPageNo = 0;  // 현재 페이지 번호로, 초기치는 1페이지로 설정
		int totalPage = 0;          // 총 페이지 수
		
		int startRno = 0;           // 시작 행번호
		int endRno = 0;             // 끝 행번호
		
		if(str_sizePerPage == null) {
			// 게시판 목록보기에 들어갔을 때의 초기화면인 경우
			sizePerPage = 20;
		} else {
			
			try {
				// GET 방식으로 잘못된 값이 넘어오는 것을 막는다.
				sizePerPage = Integer.parseInt(str_sizePerPage);
				
				if(sizePerPage != 20 && sizePerPage != 40 && sizePerPage != 60 && sizePerPage != 80) {
					sizePerPage = 20;
				}// end of if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {}
			} catch (NumberFormatException e) {
				sizePerPage = 20;
			}
			
		}// end of if(str_sizePerPage == null) {}----------------------
		
		if(str_currentShowPageNo == null) {
			// 게시판 목록보기에 들어갔을 때의 초기화면인 경우
			currentShowPageNo = 1;
		} else {
			
			try {
				// GET 방식으로 잘못된 값이 넘어오는 것을 막는다.
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}// end of if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
			
		}// end of if(str_currentShowPageNo == null) {}----------------------
		
		// 가져올 내역의 범위 
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 휴가 내역 count
		int count = service.historyNumber(paraMap);
		
		totalPage = (int)Math.ceil((double)count / sizePerPage);
		
		// 휴가 내역 목록
		List<AttendanceVO> attendList = service.historyList(paraMap);
		
		String pageBar = "<ul style='list-style: none;'>";
		
		int blockSize = 5;
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	    
		String url = "holidayHistory.os";
	      
		// [처음][이전] 만들기 
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?currentShowPageNo=1'><i class='fa fa-angle-double-left'></i></a></li>";
			pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'><i class='fa fa-angle-left'></i></a></li>";
		}
		
		while(!(loop > blockSize || pageNo > totalPage)) {
		     
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; color: #e6e6e6; background-color: #6666ff; border-radius: 50%;'>"+pageNo+"</li>";
			} else {
				pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			     
			loop++;
			pageNo++;
		     
		}// end of while(!(loop > blockSize || pageNo > totalPage)) {}----------------------------
		  
		// [다음][마지막] 만들기
		if(!(pageNo > totalPage)) {
			pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?currentShowPageNo="+pageNo+"'><i class='fa fa-angle-right'></i></a></li>";
			pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?currentShowPageNo="+totalPage+"'><i class='fa fa-angle-double-right'></i></a></li>";
		}

		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		String goBackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("goBackURL", goBackURL);
		
		/////////////////////////////////////////////////////////////////////////////////////
		
		mav.addObject("count", count);
		mav.addObject("attendList", attendList);
		
		mav.addObject("sizePerPage", sizePerPage);  // view 단에서 선택한 필드 설정 값을 유지하기 위해 다시 view 단으로 보낸다.
		
		// 전체 주소록 목록과 검색 결과 목록의 경우를 나눠 다른 view 단을 호출한다.
/*		if(contactInput == "") {
			mav.setViewName("yongjin/employee/addressbook.tiles1");
		} else {
			mav.addObject("contactInput", contactInput);
			mav.setViewName("yongjin/employee/addressbookSearch.tiles1");
		}
*/		
		mav.setViewName("yongjin/holiday/holidayHistory.tiles1");
		
		return mav;
	}// end of public ModelAndView requiredLogin_holidayHistory() {}-----------------------

}
