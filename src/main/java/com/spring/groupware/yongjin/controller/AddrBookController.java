package com.spring.groupware.yongjin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.common.common.FileManager;
import com.spring.groupware.common.common.MyUtil;
import com.spring.groupware.yongjin.model.EmployeeVO;
import com.spring.groupware.yongjin.model.LoginHistoryVO;
import com.spring.groupware.yongjin.model.PersonalBookVO;
import com.spring.groupware.yongjin.service.InterAddrBookService;

@Controller
public class AddrBookController {
   
   @Autowired
   private InterAddrBookService service;
   
   @Autowired
   private FileManager fileManager;
   
   
   // === 주소록 페이지 요청하기 === //
   @RequestMapping(value = "/employee/addressbook.os")
   public ModelAndView addressbook(HttpServletRequest request, ModelAndView mav) {
      
      /////////////////////////////////////////////////////////////////////////////////////
      
      String contactInput = request.getParameter("contactInput");
      
      String range = request.getParameter("range");
      String range1 = request.getParameter("range1");
      String range2 = request.getParameter("range2");
      
      String data = request.getParameter("data");
      String sort = request.getParameter("sort");
      
      if(data == null || data.trim().isEmpty()) {
         data = "emp_name";
      }
      
      if(sort == null || sort.trim().isEmpty()) {
         sort = "asc";
      }
      
      String str_currentShowPageNo = request.getParameter("currentShowPageNo");
      String str_sizePerPage = request.getParameter("sizePerPage");
      
      if(contactInput == null || contactInput.trim().isEmpty()) {
         contactInput = "";
      }// end of if(searchWord == null || searchWord.trim().isEmpty()) {}---------------------
      
      if(range == null) {
         range = "전체";
      }// end of if(range == null) {}-------------------
      
      if(range1 == null) {
         range1 = "";
      }// end of if(range1 == null) {}-------------------
      
      if(range2 == null) {
         range2 = "";
      }// end of if(range2 == null) {}-------------------
      
      Map<String, String> paraMap = new HashMap<String, String>();
      paraMap.put("contactInput", contactInput);
      paraMap.put("range1", range1);
      paraMap.put("range2", range2);
      paraMap.put("data", data);
      paraMap.put("sort", sort);
      
      int sizePerPage = 0;       // 한 페이지에 보일 주소록 수
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
      
      // 가져올 주소록의 범위 
      startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
      endRno = startRno + sizePerPage - 1;
      
      paraMap.put("startRno", String.valueOf(startRno));
      paraMap.put("endRno", String.valueOf(endRno));
      
      // 사원 수 count
      int count = service.empNumber(paraMap);
      
      totalPage = (int)Math.ceil((double)count / sizePerPage);
      
      // 사원 목록
      List<EmployeeVO> empList = service.empList(paraMap);
      
      String pageBar = "<ul style='list-style: none;'>";
      
      int blockSize = 5;
      int loop = 1;
      
      int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
       
      String url = "addressbook.os";
         
      // [처음][이전] 만들기 
      if(pageNo != 1) {
         pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo=1'><i class='fa fa-angle-double-left'></i></a></li>";
         pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo="+(pageNo-1)+"'><i class='fa fa-angle-left'></i></a></li>";
      }
      
      while(!(loop > blockSize || pageNo > totalPage)) {
           
         if(pageNo == currentShowPageNo) {
            pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; color: #e6e6e6; background-color: #6666ff; border-radius: 50%;'>"+pageNo+"</li>";
         } else {
            pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
         }
              
         loop++;
         pageNo++;
           
      }// end of while(!(loop > blockSize || pageNo > totalPage)) {}----------------------------
        
      // [다음][마지막] 만들기
      if(!(pageNo > totalPage)) {
         pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo="+pageNo+"'><i class='fa fa-angle-right'></i></a></li>";
         pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo="+totalPage+"'><i class='fa fa-angle-double-right'></i></a></li>";
      }

      pageBar += "</ul>";
      
      mav.addObject("pageBar", pageBar);
      
      String goBackURL = MyUtil.getCurrentURL(request);
      
      mav.addObject("goBackURL", goBackURL);
      
      /////////////////////////////////////////////////////////////////////////////////////
      // Controller
      // 필드 설정 보내기
      String[] fieldtype = request.getParameterValues("fieldtype");
      
      if(fieldtype == null) {
         // 필드 설정 없이 첫 화면 진입 시 모든 필드를 선택한 것으로 초기화
         String[] initArr = {"emp_name", "position_name", "mobile", "email", "dept_name", "company", "corp_phone", "basicAddress"};
         fieldtype = initArr;
      }// end of if(fieldtype == null) {}---------------------
      mav.addObject("fieldtype", fieldtype);
      
      mav.addObject("count", count);
      mav.addObject("empList", empList);
      
      mav.addObject("sizePerPage", sizePerPage);  // view 단에서 선택한 필드 설정 값을 유지하기 위해 다시 view 단으로 보낸다.
      mav.addObject("range", range);
      
      mav.addObject("data", data);
      mav.addObject("sort", sort);
      
      // 전체 주소록 목록과 검색 결과 목록의 경우를 나눠 다른 view 단을 호출한다.
      if(contactInput == "") {
         mav.setViewName("yongjin/employee/addressbook.tiles1");
      } else {
         mav.addObject("contactInput", contactInput);
         mav.setViewName("yongjin/employee/addressbookSearch.tiles1");
      }
      
      return mav;
   }// end of public ModelAndView addressbook(ModelAndView mav) {}-----------------------
   
/*   
   // === 전체 사원 수 가져오기 === //
   @ResponseBody
   @RequestMapping(value = "/empNumber.os", produces = "text/plain;charset=UTF-8")
   public String ajax_empNumber() {
      
      int count = service.empNumber();
      
      JSONObject jsonObj = new JSONObject();
      jsonObj.put("count", count);
      
      return jsonObj.toString();
   }// end of public String empNumber() {}-----------------------
   
   
   // === 사원 목록 가져오기 === //
   @ResponseBody
   @RequestMapping(value = "/empList.os", produces = "text/plain;charset=UTF-8")
   public String ajax_empList() {
      
      List<EmployeeVO> empList = service.empList();
      
      JSONArray jsonArr = new JSONArray();
      
      if(empList != null && empList.size() > 0) {
         
         for(EmployeeVO empvo : empList) {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("emp_no", empvo.getEmp_no());
            jsonObj.put("emp_name", empvo.getEmp_name());
            jsonObj.put("corp_phone", empvo.getCorp_phone());
            jsonObj.put("postcode", empvo.getPostcode());
            jsonObj.put("address", empvo.getAddress());
            jsonObj.put("detail_address", empvo.getDetail_address());
            jsonObj.put("extra_address", empvo.getExtra_address());
            jsonObj.put("mobile", empvo.getMobile());
            jsonObj.put("email", empvo.getEmail());
            jsonObj.put("firstday", empvo.getFirstday());
            jsonObj.put("photo_route", empvo.getPhoto_route());
            jsonObj.put("photo_name", empvo.getPhoto_name());
            jsonObj.put("status", empvo.getStatus());
            jsonObj.put("dept_name", empvo.getDept_name());
            jsonObj.put("position_name", empvo.getPosition_name());
            jsonObj.put("board_grant_name", empvo.getBoard_grant_name());
            jsonObj.put("site_grant_name", empvo.getSite_grant_name());
            
            jsonArr.put(jsonObj);
         }// end of for(EmployeeVO empvo : empList) {}---------------------
         
      }// end of if(empList != null && empList.size() > 0) {}---------------------
      
      return jsonArr.toString();
   }// end of public String ajax_empList() {}-----------------------
*/   
   
   // === Excel 파일로 다운받기 === //
   @RequestMapping(value = "/excel/exportExcelFile.os", method = {RequestMethod.POST})
   public String exportExcelFile(HttpServletRequest request, Model model) {
      
      String range1 = "";
      String startRno = "";
      
      String contactInput = request.getParameter("contactInput");
      
      if(contactInput == null || contactInput.trim().isEmpty()) {
         contactInput = "";
      }// end of if(searchWord == null || searchWord.trim().isEmpty()) {}---------------------
      
      Map<String, String> paraMap = new HashMap<String, String>();
      paraMap.put("range1", range1);
      paraMap.put("contactInput", contactInput);
      paraMap.put("startRno", startRno);
      
      List<EmployeeVO> empList = service.empList(paraMap);
      
      // == 조회결과물인 empList 를 가지고 엑셀 시트 생성하기 == //
      // 시트 생성 > 행 생성 > 셀 생성 > 셀 안에 내용을 넣어주는 과정을 거친다.
      SXSSFWorkbook workbook = new SXSSFWorkbook();  // Excel 파일 생성
      
      // 시트 생성
      SXSSFSheet sheet = workbook.createSheet("주소록 Excel");
      
      // 시트 열 너비 설정
      sheet.setColumnWidth(0, 4000);  // 사원번호
      sheet.setColumnWidth(1, 4000);  // 이름
      sheet.setColumnWidth(2, 4000);  // 직위
      sheet.setColumnWidth(3, 6000);  // 휴대폰
      sheet.setColumnWidth(4, 7000);  // 이메일
      sheet.setColumnWidth(5, 4000);  // 부서
      sheet.setColumnWidth(6, 6000);  // 회사전화
      sheet.setColumnWidth(7, 35000); // 주소
      sheet.setColumnWidth(8, 6000);  // 입사일
      
      // 행의 위치를 나타내는 변수
      int rowLocation = 0;
      
      ////////////////////////////////////////////////////////////////////////////////////////
      // CellStyle 정렬하기(Alignment)
      // CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
      // 아래는 HorizontalAlignment(가로)와 VerticalAlignment(세로)를 모두 가운데 정렬 시켰다.
      CellStyle mergeRowStyle = workbook.createCellStyle();
      mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
      mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
      
      CellStyle headerStyle = workbook.createCellStyle();
      headerStyle.setAlignment(HorizontalAlignment.CENTER);
      headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
      
      // CellStyle 배경색(ForegroundColor)만들기
        // setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다.
        // setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
        mergeRowStyle.setFillForegroundColor(IndexedColors.WHITE.getIndex());  
        mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        headerStyle.setFillForegroundColor(IndexedColors.BLACK.getIndex());  
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        // Cell 폰트(Font) 설정하기
        // 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
        // 해당 객체의 세터를 사용해 폰트를 설정해준다. 대표적으로 글씨체, 크기, 색상, 굵기만 설정한다.
        // 이후 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
        Font mergeRowFont = workbook.createFont();
        mergeRowFont.setFontName("나눔고딕");
        mergeRowFont.setFontHeight((short)500);
        mergeRowFont.setColor(IndexedColors.BLACK.getIndex());
        mergeRowFont.setBold(true);
                
        mergeRowStyle.setFont(mergeRowFont);
        
        Font headerFont = workbook.createFont();
        headerFont.setColor(IndexedColors.WHITE.getIndex());
        
        headerStyle.setFont(headerFont);
        
        // CellStyle 테두리 Border
        // 테두리는 각 셀마다 상하좌우 모두 설정해준다.
        // setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 적용한다.
        mergeRowStyle.setBorderBottom(BorderStyle.THICK);
        
        headerStyle.setBorderTop(BorderStyle.MEDIUM);
        headerStyle.setBorderBottom(BorderStyle.MEDIUM);
        headerStyle.setBorderLeft(BorderStyle.MEDIUM);
        headerStyle.setBorderRight(BorderStyle.MEDIUM);
        
        // Cell Merge 셀 병합시키기
        /*
           셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
           CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0부터이다.  
        */
        // 병합할 행 만들기
        Row mergeRow = sheet.createRow(rowLocation);  // Excel 에서 행의 시작은 0 부터 시작한다.
        
        // 병합할 행에 "우리회사 사원정보" 로 셀을 만들어 셀에 스타일 주기
        for(int i = 0; i < 9; i++) {
           Cell cell = mergeRow.createCell(i);
           cell.setCellStyle(mergeRowStyle);
           cell.setCellValue("주소록 가져오기");
        }// end of for(int i = 0; i < 9; i++) {}------------------------
        
        // 셀 병합하기
        sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 8));  // 시작 행, 끝 행, 시작 열, 끝 열의 범위를 지정한다.
        
        rowLocation += 2;
        
        // 헤더 행 생성
        Row headerRow = sheet.createRow(rowLocation);
        
        // 해당 행의 첫번째 열 셀 생성
        Cell headerCell = headerRow.createCell(0);
        headerCell.setCellValue("사원번호");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 두번째 열 셀 생성
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("이름");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 세번째 열 셀 생성
        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("직위");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 네번째 열 셀 생성
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("휴대폰");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 다섯번째 열 셀 생성
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("이메일");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 여섯번째 열 셀 생성
        headerCell = headerRow.createCell(5);
        headerCell.setCellValue("부서");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 일곱번째 열 셀 생성
        headerCell = headerRow.createCell(6);
        headerCell.setCellValue("회사전화");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 여덟번째 열 셀 생성
        headerCell = headerRow.createCell(7);
        headerCell.setCellValue("주소");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 아홉번째 열 셀 생성
        headerCell = headerRow.createCell(8);
        headerCell.setCellValue("입사일");
        headerCell.setCellStyle(headerStyle);
        
        // HR사원정보 내용에 해당하는 행 및 셀 생성하기
        Row bodyRow = null;
        Cell bodyCell = null;
        
        for(int i = 0; i < empList.size(); i++) {
           
           EmployeeVO empvo = empList.get(i);
           
           // 행 생성
           bodyRow = sheet.createRow((rowLocation+1) + i);
           
           // 데이터 사원번호 표시
           bodyCell = bodyRow.createCell(0);
           bodyCell.setCellValue(empvo.getEmp_no());
           
           // 데이터 이름 표시
           bodyCell = bodyRow.createCell(1);
           bodyCell.setCellValue(empvo.getEmp_name());
           
           // 데이터 직위 표시
           bodyCell = bodyRow.createCell(2);
           bodyCell.setCellValue(empvo.getPosition_name());
           
           // 데이터 휴대폰 표시
           bodyCell = bodyRow.createCell(3);
           bodyCell.setCellValue(empvo.getMobile());
           
           // 데이터 이메일 표시
           bodyCell = bodyRow.createCell(4);
           bodyCell.setCellValue(empvo.getEmail());
           
           // 데이터 부서 표시
           bodyCell = bodyRow.createCell(5);
           bodyCell.setCellValue(empvo.getDept_name());
           
           // 데이터 회사전화 표시
           bodyCell = bodyRow.createCell(6);
           bodyCell.setCellValue(empvo.getCorp_phone());
           
           // 데이터 주소 표시
           bodyCell = bodyRow.createCell(7);
           bodyCell.setCellValue(empvo.getPostcode() + " " + empvo.getAddress() + " " + empvo.getDetail_address() + " " + empvo.getExtra_address());
           
           // 데이터 입사일 표시
           bodyCell = bodyRow.createCell(8);
           bodyCell.setCellValue(empvo.getFirstday());
           
        }// end of for(int i = 0; i < empList.size(); i++) {}----------------------
        
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "주소록 Excel");  // 파일명
      
      return "excelDownloadView";
   }// end of public String exportExcelFile() {}--------------------
   
   
   // === 전사 주소록에서 사원 정보 상세보기 === //
   @RequestMapping(value = "/employee/detailContact.os")
   public ModelAndView requiredLogin_detailContact(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
      String emp_no = request.getParameter("emp_no");
      
      EmployeeVO empvo = service.detailContact(emp_no);
      
      String goBackURL = request.getParameter("goBackURL");
      
      if(goBackURL != null) {
         goBackURL = goBackURL.replaceAll("   ", "&");
         
         mav.addObject("goBackURL", goBackURL);
      }// end of if(goBackURL != null) {}-------------------------------
      
      mav.addObject("empvo", empvo);
      mav.setViewName("yongjin/employee/addressbookDetail.tiles1");
      
      return mav;
   }// end of public ModelAndView requiredLogin_detailContact() {}----------------------
   
   
   // === 개인 주소록 페이지 요청하기 === //
   @RequestMapping(value = "/employee/idv_addressbook.os")
   public ModelAndView requiredLogin_idv_addressbook(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
      /////////////////////////////////////////////////////////////////////////////////////
      
      String idxBook = request.getParameter("idxBook");
      String temp = idxBook;      
      
      if(idxBook == null || idxBook.trim().isEmpty()) {
         idxBook = "1";
      }
      
      if(Integer.parseInt(idxBook) < 10) {
         idxBook = "0" + idxBook;
      }
      
      String contactInput = request.getParameter("contactInput");
      
      String range = request.getParameter("range");
      String range1 = request.getParameter("range1");
      String range2 = request.getParameter("range2");
      
      String data = request.getParameter("data");
      String sort = request.getParameter("sort");
      
      if(data == null || data.trim().isEmpty()) {
         data = "name";
      }
      
      if(sort == null || sort.trim().isEmpty()) {
         sort = "asc";
      }
      
      String str_currentShowPageNo = request.getParameter("currentShowPageNo");
      String str_sizePerPage = request.getParameter("sizePerPage");
      
      if(contactInput == null || contactInput.trim().isEmpty()) {
         contactInput = "";
      }// end of if(searchWord == null || searchWord.trim().isEmpty()) {}---------------------
      
      if(range == null) {
         range = "전체";
      }// end of if(range == null) {}-------------------
      
      if(range1 == null) {
         range1 = "";
      }// end of if(range1 == null) {}-------------------
      
      if(range2 == null) {
         range2 = "";
      }// end of if(range2 == null) {}-------------------
      
      Map<String, String> paraMap = new HashMap<String, String>();
      paraMap.put("idxBook", idxBook);
      paraMap.put("contactInput", contactInput);
      paraMap.put("range1", range1);
      paraMap.put("range2", range2);
      paraMap.put("data", data);
      paraMap.put("sort", sort);
      
      // 로그인 사원번호
      HttpSession session = request.getSession();
      EmployeeVO loginemp = (EmployeeVO)session.getAttribute("loginemp");
      paraMap.put("fk_emp_no", String.valueOf(loginemp.getEmp_no()));
      
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
      
      // 가져올 주소록의 범위 
      startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
      endRno = startRno + sizePerPage - 1;
      
      paraMap.put("startRno", String.valueOf(startRno));
      paraMap.put("endRno", String.valueOf(endRno));
      
      // 개인 주소록 count
      int count = service.idv_contactsNumber(paraMap);
      
      totalPage = (int)Math.ceil((double)count / sizePerPage);
      
      // 개인 주소록 목록
      List<PersonalBookVO> pbList = service.idv_contactsList(paraMap);
      
      String pageBar = "<ul style='list-style: none;'>";
      
      int blockSize = 5;
      int loop = 1;
      
      int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
       
      String url = "idv_addressbook.os";
         
      // [처음][이전] 만들기 
      if(pageNo != 1) {
         pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo=1'><i class='fa fa-angle-double-left'></i></a></li>";
         pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo="+(pageNo-1)+"'><i class='fa fa-angle-left'></i></a></li>";
      }
      
      while(!(loop > blockSize || pageNo > totalPage)) {
           
         if(pageNo == currentShowPageNo) {
            pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; color: #e6e6e6; background-color: #6666ff; border-radius: 50%;'>"+pageNo+"</li>";
         } else {
            pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
         }
              
         loop++;
         pageNo++;
           
      }// end of while(!(loop > blockSize || pageNo > totalPage)) {}----------------------------
        
      // [다음][마지막] 만들기
      if(!(pageNo > totalPage)) {
         pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo="+pageNo+"'><i class='fa fa-angle-right'></i></a></li>";
         pageBar += "<li style='display:inline-block; width:25px; font-size:12pt; margin: 7px; background-color: #dadada; border-radius: 50%;'><a href='"+url+"?contactInput="+contactInput+"&currentShowPageNo="+totalPage+"'><i class='fa fa-angle-double-right'></i></a></li>";
      }

      pageBar += "</ul>";
      
      mav.addObject("pageBar", pageBar);
      
      String goBackURL = MyUtil.getCurrentURL(request);
      
      mav.addObject("goBackURL", goBackURL);
      
      /////////////////////////////////////////////////////////////////////////////////////
      
      // 필드 설정 보내기
      String[] fieldtype = request.getParameterValues("fieldtype");
      
      if(fieldtype == null) {
         // 필드 설정 없이 첫 화면 진입 시 모든 필드를 선택한 것으로 초기화
         String[] initArr = {"name", "position_name", "mobile", "email", "dept_name", "company", "corp_phone", "basicAddress"};
         fieldtype = initArr;
      }// end of if(fieldtype == null) {}---------------------
      mav.addObject("fieldtype", fieldtype);
      
      // 개인 주소록 목록 가져오기
      List<Map<String, String>> bookList = service.idvBookList(paraMap);
      
      mav.addObject("bookList", bookList);
      mav.addObject("bookSize", bookList.size());
      
      // 주소록 이름 가져오기
      if(temp == null || temp.trim().isEmpty()) {
         temp = "1";
      }
      
      String book_part_no = bookList.get(Integer.parseInt(temp)-1).get("book_part_no");
      String book_part_name = bookList.get(Integer.parseInt(temp)-1).get("book_part_name");
      mav.addObject("book_part_no", book_part_no);
      mav.addObject("book_part_name", book_part_name);
      
      mav.addObject("count", count);
      mav.addObject("pbList", pbList);
      
      mav.addObject("sizePerPage", sizePerPage);  // view 단에서 선택한 필드 설정 값을 유지하기 위해 다시 view 단으로 보낸다.
      mav.addObject("range", range);
      
      mav.addObject("data", data);
      mav.addObject("sort", sort);
      
      // 전체 주소록 목록과 검색 결과 목록의 경우를 나눠 다른 view 단을 호출한다.
      if(contactInput == "") {
         mav.setViewName("yongjin/employee/idv_addressbook.tiles1");
      } else {
         mav.addObject("contactInput", contactInput);
         mav.setViewName("yongjin/employee/idv_addressbookSearch.tiles1");
      }
      
      return mav;
   }// end of public ModelAndView requiredLogin_idv_addressbook(ModelAndView mav) {}
   
   
   // === Excel 파일로 다운받기(개인 주소록) === //
   @RequestMapping(value = "/excel/exportExcelFilePersonal.os", method = {RequestMethod.POST})
   public String requiredLogin_exportExcelFileInPersonal(HttpServletRequest request, HttpServletResponse response, Model model) {
      
      String range1 = "";
      String startRno = "";
      
      String contactInput = request.getParameter("contactInput");
      
      if(contactInput == null || contactInput.trim().isEmpty()) {
         contactInput = "";
      }// end of if(searchWord == null || searchWord.trim().isEmpty()) {}---------------------
      
      Map<String, String> paraMap = new HashMap<String, String>();
      paraMap.put("range1", range1);
      paraMap.put("contactInput", contactInput);
      paraMap.put("startRno", startRno);
      
      List<PersonalBookVO> pbList = service.idv_contactsList(paraMap);
      
      // == 조회결과물인 empList 를 가지고 엑셀 시트 생성하기 == //
      // 시트 생성 > 행 생성 > 셀 생성 > 셀 안에 내용을 넣어주는 과정을 거친다.
      SXSSFWorkbook workbook = new SXSSFWorkbook();  // Excel 파일 생성
      
      // 시트 생성
      SXSSFSheet sheet = workbook.createSheet("주소록 Excel");
      
      // 시트 열 너비 설정
      sheet.setColumnWidth(0, 7000);  // 주소록 구분
      sheet.setColumnWidth(1, 4000);  // 이름
      sheet.setColumnWidth(2, 4000);  // 직위
      sheet.setColumnWidth(3, 6000);  // 휴대폰
      sheet.setColumnWidth(4, 7000);  // 이메일
      sheet.setColumnWidth(5, 4000);  // 부서
      sheet.setColumnWidth(6, 6000);  // 회사
      sheet.setColumnWidth(7, 6000);  // 회사전화
      sheet.setColumnWidth(8, 35000); // 주소
      sheet.setColumnWidth(9, 35000); // 메모
      
      // 행의 위치를 나타내는 변수
      int rowLocation = 0;
      
      ////////////////////////////////////////////////////////////////////////////////////////
      // CellStyle 정렬하기(Alignment)
      // CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
      // 아래는 HorizontalAlignment(가로)와 VerticalAlignment(세로)를 모두 가운데 정렬 시켰다.
      CellStyle mergeRowStyle = workbook.createCellStyle();
      mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
      mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
      
      CellStyle headerStyle = workbook.createCellStyle();
      headerStyle.setAlignment(HorizontalAlignment.CENTER);
      headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
      
      // CellStyle 배경색(ForegroundColor)만들기
        // setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다.
        // setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
        mergeRowStyle.setFillForegroundColor(IndexedColors.WHITE.getIndex());  
        mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        headerStyle.setFillForegroundColor(IndexedColors.BLACK.getIndex());  
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        // Cell 폰트(Font) 설정하기
        // 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
        // 해당 객체의 세터를 사용해 폰트를 설정해준다. 대표적으로 글씨체, 크기, 색상, 굵기만 설정한다.
        // 이후 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
        Font mergeRowFont = workbook.createFont();
        mergeRowFont.setFontName("나눔고딕");
        mergeRowFont.setFontHeight((short)500);
        mergeRowFont.setColor(IndexedColors.BLACK.getIndex());
        mergeRowFont.setBold(true);
                
        mergeRowStyle.setFont(mergeRowFont);
        
        Font headerFont = workbook.createFont();
        headerFont.setColor(IndexedColors.WHITE.getIndex());
        
        headerStyle.setFont(headerFont);
        
        // CellStyle 테두리 Border
        // 테두리는 각 셀마다 상하좌우 모두 설정해준다.
        // setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 적용한다.
        mergeRowStyle.setBorderBottom(BorderStyle.THICK);
        
        headerStyle.setBorderTop(BorderStyle.MEDIUM);
        headerStyle.setBorderBottom(BorderStyle.MEDIUM);
        headerStyle.setBorderLeft(BorderStyle.MEDIUM);
        headerStyle.setBorderRight(BorderStyle.MEDIUM);
        
        // Cell Merge 셀 병합시키기
        /*
           셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
           CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0부터이다.  
        */
        // 병합할 행 만들기
        Row mergeRow = sheet.createRow(rowLocation);  // Excel 에서 행의 시작은 0 부터 시작한다.
        
        // 병합할 행에 "우리회사 사원정보" 로 셀을 만들어 셀에 스타일 주기
        for(int i = 0; i < 10; i++) {
           Cell cell = mergeRow.createCell(i);
           cell.setCellStyle(mergeRowStyle);
           cell.setCellValue("주소록 가져오기");
        }// end of for(int i = 0; i < 10; i++) {}------------------------
        
        // 셀 병합하기
        sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 9));  // 시작 행, 끝 행, 시작 열, 끝 열의 범위를 지정한다.
        
        rowLocation += 2;
        
        // 헤더 행 생성
        Row headerRow = sheet.createRow(rowLocation);
        
        // 해당 행의 첫번째 열 셀 생성
        Cell headerCell = headerRow.createCell(0);
        headerCell.setCellValue("주소록 구분");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 두번째 열 셀 생성
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("이름");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 세번째 열 셀 생성
        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("직위");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 네번째 열 셀 생성
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("휴대폰");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 다섯번째 열 셀 생성
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("이메일");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 여섯번째 열 셀 생성
        headerCell = headerRow.createCell(5);
        headerCell.setCellValue("부서");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 일곱번째 열 셀 생성
        headerCell = headerRow.createCell(6);
        headerCell.setCellValue("회사");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 일곱번째 열 셀 생성
        headerCell = headerRow.createCell(7);
        headerCell.setCellValue("회사전화");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 여덟번째 열 셀 생성
        headerCell = headerRow.createCell(8);
        headerCell.setCellValue("주소");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 아홉번째 열 셀 생성
        headerCell = headerRow.createCell(9);
        headerCell.setCellValue("매모");
        headerCell.setCellStyle(headerStyle);
        
        // HR사원정보 내용에 해당하는 행 및 셀 생성하기
        Row bodyRow = null;
        Cell bodyCell = null;
        
        for(int i = 0; i < pbList.size(); i++) {
           
           PersonalBookVO pbvo = pbList.get(i);
           
           // 행 생성
           bodyRow = sheet.createRow((rowLocation+1) + i);
           
           // 데이터 사원번호 표시
           bodyCell = bodyRow.createCell(0);
           bodyCell.setCellValue(pbvo.getBook_part_name());
           
           // 데이터 이름 표시
           bodyCell = bodyRow.createCell(1);
           bodyCell.setCellValue(pbvo.getName());
           
           // 데이터 직위 표시
           bodyCell = bodyRow.createCell(2);
           bodyCell.setCellValue(pbvo.getPosition_name());
           
           // 데이터 휴대폰 표시
           bodyCell = bodyRow.createCell(3);
           bodyCell.setCellValue(pbvo.getMobile());
           
           // 데이터 이메일 표시
           bodyCell = bodyRow.createCell(4);
           bodyCell.setCellValue(pbvo.getEmail());
           
           // 데이터 부서 표시
           bodyCell = bodyRow.createCell(5);
           bodyCell.setCellValue(pbvo.getDept_name());
           
           // 데이터 회사 표시
           bodyCell = bodyRow.createCell(6);
           bodyCell.setCellValue(pbvo.getCompany_name());
           
           // 데이터 회사전화 표시
           bodyCell = bodyRow.createCell(7);
           bodyCell.setCellValue(pbvo.getCorp_phone());
           
           // 데이터 주소 표시
           bodyCell = bodyRow.createCell(8);
           bodyCell.setCellValue(pbvo.getPostcode() + " " + pbvo.getAddress() + " " + pbvo.getDetail_address() + " " + pbvo.getExtra_address());
           
           // 데이터 메모 표시
           bodyCell = bodyRow.createCell(9);
           bodyCell.setCellValue(pbvo.getMemo());
           
        }// end of for(int i = 0; i < pbList.size(); i++) {}----------------------
        
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "주소록 Excel");  // 파일명
      
      return "excelDownloadView";
   }// end of public String exportExcelFile() {}--------------------
   
   
   // === 개인 주소록에서 정보 상세보기 === //
   @RequestMapping(value = "/employee/idv_detailContact.os")
   public ModelAndView requiredLogin_idv_detailContact(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
      String book_no = request.getParameter("book_no");
      
      PersonalBookVO pbvo = service.idv_detailContact(book_no);
      
      String goBackURL = request.getParameter("goBackURL");
      
      if(goBackURL != null) {
         goBackURL = goBackURL.replaceAll("   ", "&");
         
         mav.addObject("goBackURL", goBackURL);
      }// end of if(goBackURL != null) {}-------------------------------
      
      mav.addObject("pbvo", pbvo);
      mav.setViewName("yongjin/employee/idv_addressbookDetail.tiles1");
      
      return mav;
   }// end of public ModelAndView requiredLogin_idv_detailContact() {}----------------------
   
   
   // === 개인 주소록 상세 정보 수정하기 === //
   @RequestMapping(value = "/employee/idv_detailContactRevise.os", method = {RequestMethod.POST})
   public ModelAndView requiredLogin_idv_detailContactRevise(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, PersonalBookVO pbvo, MultipartHttpServletRequest mrequest) {
      
      MultipartFile attach = pbvo.getAttach();
      
      if(attach != null && !attach.isEmpty()) {
         // 업로드 경로 지정
         HttpSession session = mrequest.getSession();
         String root = session.getServletContext().getRealPath("/");
         
         String path = root+"resources"+File.separator+"files";
         
         // 파일첨부를 위한 변수 설정 및 초기화 후 파일올리기
         String newFileName = "";  // WAS(톰캣)의 디스크에 저장될 파일명
         byte[] bytes = null;      // 첨부파일의 내용물을 담을 변수
         long fileSize = 0;         // 첨부파일의 크기
         
         try {
            bytes = attach.getBytes();  // 첨부파일의 내용물을 읽어온다.
            
            newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
            
            // PersonalBookVO pbvo 에 photo_name, attachPhoto_name, attachPhoto_size 값 넣어주기
            pbvo.setAttachPhoto_name(newFileName);
            pbvo.setPhoto_name(attach.getOriginalFilename());
            
            fileSize = attach.getSize();
            pbvo.setAttachPhoto_size(String.valueOf(fileSize));
         } catch (Exception e) {
            e.printStackTrace();
         }// end of try ~ catch() ---------------------
      }// end of if(!attach.isEmpty()) {}----------------------
      
      // 크로스사이트 스크립트 공격에 대비하여 시큐어 코드 작성
      pbvo.setMemo(MyUtil.secureCode(pbvo.getMemo()));
      
      int result = 0;
      
      if(attach == null) {
         result = service.idv_detailContactRevise(pbvo);
      } else {
         result = service.idv_detailContactReviseWithFile(pbvo);
      }// end of if(attach.isEmpty()) {}-----------------------
            
      if(result == 0) {
         mav.addObject("message", "수정할 수 없습니다.");
      } else {
         mav.addObject("message", "수정되었습니다.");
      }// end of if(result == 0) {}----------------------
      
      mav.addObject("loc", request.getContextPath()+"/employee/idv_addressbook.os");
      mav.setViewName("msg");
      
      return mav;
   }// end of public ModelAndView requiredLogin_idv_detailContactRevise() {}-------------------------
   
/*   
   // === 조직도 불러오기 === //
   @ResponseBody
   @RequestMapping(value = "/getOrganization.os", produces = "text/plain;charset=UTF-8")
   public String requiredLogin_ajax_getOrganization(HttpServletRequest request, HttpServletResponse response) {
      
      String range1 = "";
      String startRno = "";
      
      String contactInput = request.getParameter("contactInput");
      
      if(contactInput == null || contactInput.trim().isEmpty()) {
         contactInput = "";
      }// end of if(searchWord == null || searchWord.trim().isEmpty()) {}---------------------
      
      Map<String, String> paraMap = new HashMap<String, String>();
      paraMap.put("range1", range1);
      paraMap.put("contactInput", contactInput);
      paraMap.put("startRno", startRno);
      
      List<EmployeeVO> empList = service.empList(paraMap);
      
      JSONArray jsonArr = new JSONArray();
      
      if(empList != null && empList.size() > 0) {
         
         for(EmployeeVO empvo : empList) {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("emp_name", empvo.getEmp_name());
            jsonObj.put("position_name", empvo.getPosition_name());
            
            jsonArr.put(jsonObj);
         }// end of for(EmployeeVO empvo : empList) {}-----------------------
         
      }// end of if(empList != null && empList.size() > 0) {}-----------------------
      
      return jsonArr.toString();
   }// end of public String requiredLogin_ajax_getOrganization(HttpServletRequest request, HttpServletResponse response) {}
*/
   
   
   // 개인 주소록 추가
   @ResponseBody
   @RequestMapping(value = "/idv_addIdvBook.os", produces = "text/plain;charset=UTF-8")
   public String requiredLogin_ajax_idv_addIdvBook(HttpServletRequest request, HttpServletResponse response) {
      
      String book_part_count = request.getParameter("book_part_count");
      
      if(Integer.parseInt(book_part_count) < 10) {
         book_part_count = "0" + book_part_count;
      }
      
      String book_part_name = request.getParameter("book_part_name");
      String emp_no = request.getParameter("emp_no");
      
      Map<String, String> paraMap = new HashMap<String, String>();
      paraMap.put("book_part_count", book_part_count);
      paraMap.put("book_part_name", book_part_name);
      paraMap.put("emp_no", emp_no);
      
      int result = service.addIdvBook(paraMap);
      
      JSONObject jsonObj = new JSONObject();
      jsonObj.put("result", result);
      
      return jsonObj.toString();
   }// end of public String requiredLogin_ajax_getOrganization(HttpServletRequest request, HttpServletResponse response) {}
   
   
   // 개인 주소록 빠른 등록
   @RequestMapping(value = "/employee/idv_quickCreateContact.os", method = {RequestMethod.POST})
   public ModelAndView requiredLogin_idv_quickCreateContact(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, PersonalBookVO pbvo) {
      
      int result = service.idv_quickCreateContact(pbvo);
            
      if(result == 0) {
         mav.addObject("message", "등록할 수 없습니다.");
      } else {
         mav.addObject("message", "등록되었습니다.");
      }// end of if(result == 0) {}----------------------
      
      mav.addObject("loc", request.getContextPath()+"/employee/idv_addressbook.os");
      mav.setViewName("msg");
      
      return mav;
   }// end of public ModelAndView requiredLogin_idv_quickCreateContact() {}-------------------------
   
   
   // 개인 주소록 삭제
   @RequestMapping(value = "/employee/idv_detailContactDelete.os", method = {RequestMethod.POST})
   public ModelAndView requiredLogin_idv_detailContactDelete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
	  String book_no = request.getParameter("book_no"); 
	   
      int result = service.idv_detailContactDelete(book_no);
            
      if(result == 0) {
         mav.addObject("message", "삭제할 수 없습니다.");
      } else {
         mav.addObject("message", "삭제되었습니다.");
      }// end of if(result == 0) {}----------------------
      
      mav.addObject("loc", request.getContextPath()+"/employee/idv_addressbook.os");
      mav.setViewName("msg");
      
      return mav;
   }
   
}