<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div>
	<header class="content_top">
		<div>
			<h1>
				<span>전사 연차 사용내역</span>
			</h1>
		</div>
	</header>

	<div><!--annualvacation_depart 멀티클래스 추가-->
    <!-- tool bar -->
    <!-- //tool bar -->
	    <form>
	        <fieldset>
	            <div class="wrap_tb_box">
	                <div>조건별 상세검색</div>
	                <div>
	                    <div>
	                        <span>
	                            <label for="">기간</label>
	                        </span>
	                        <!-- 날짜 선택 박스 -->
	                        <span class="wrap_dateselect">
	                            <span class="wrap_date" id="startHireDateCal">
	                                <input class="hasDatepicker" type="text" id="searchStartDate" readonly="">
	                                <span class="ic ic_calendar"></span>
	                            </span>
	                            <span class="date_wave">~</span>
	                            <span class="wrap_date" id="endHireDateCal">
	                                <input class="hasDatepicker" type="text" id="searchEndDate" readonly="">
	                                <span class="ic ic_calendar">
	                                </span>
	                            </span>
	                        </span>
	                    </div>
	                    <div class="search_item">
	                        <span>
	                            <label for="">이름</label>
	                        </span>
	                        <span>
	                            <input id="userName" type="text" value="">
	                        </span>
	                    </div>
	                    <div class="search_item">
	                        <span>
	                            <label for="">부서명</label>
	                        </span>
	                        <span>
	                            <input id="deptName" type="text" value="">
	                        </span>
	                    </div>
	                    <div>
	                        <a id="searchBtn"><span>검색</span></a>
	                        <a id="searchReset"><span>검색 조건 초기화</span></a>
	                        <!-- 초기화 버튼은 검색값이 있을 경우만 노출 : 멀티 클래스명 active 추가. 초기화 시 active 클래스명 제거 -->
	                    </div>
	                </div>
	            </div>
			</fieldset>
	    </form>

	    <div class="critical" id="descendant_area" style="margin-bottom:0;display: none">
	    </div>

	    <!-- // Start -->
	    <div class="wrap_tb_box" id="table_area">
	        <div id="vacation_list_wrapper">
	        	<div>
	        		<div id="excel_download_area" style="margin-left: 5px;">
				        <div>
				            <a id="xlsxDownBtn">
				                <span></span>
				                <span>목록 다운로드</span>
				            </a>
				        </div>
	    			</div>
	    			<div style="display: none;"></div>
	    			<div id="vacation_list_length">
	    				<label> 
	    					<select size="1" name="vacation_list_length">
	    						<option value="20" selected="selected">20</option>
	    						<option value="40">40</option>
	    						<option value="60">60</option>
	    						<option value="80">80</option>
	    					</select> 
	    				</label>
	    			</div>
	    		</div>
	    		<div id="vacation_list_processing" style="visibility: hidden;">Loading...</div>
	    		<table id="vacation_list" style="width: 100%; margin-bottom: 0px;">
		            <thead>
		            	<tr role="row">
		            		<th role="columnheader" rowspan="1" colspan="1" style="width: 130px;">
		            			<span>이름<ins class="ic"></ins><span></span></span>
		            		</th>
		            		<th role="columnheader" rowspan="1" colspan="1" style="width: 130px;">
		            			<span>부서명<ins class="ic"></ins></span>
		            		</th>
		            		<th role="columnheader" rowspan="1" colspan="1" style="width: 130px;">
		            			<span>기간<ins class="ic"></ins></span>
		            		</th>
		            		<th role="columnheader" rowspan="1" colspan="1" style="width: 130px;">
		            			<span>사용일수<ins class="ic"></ins></span>
		            		</th>
		            		<th role="columnheader" rowspan="1" colspan="1" style="width: 130px;">
		            			<span>분류<ins class="ic"></ins></span>
		            		</th>
		            	</tr>
		            </thead>
	            
	        		<tbody>
	        			<c:forEach var="attendvo" items="${attendList}">
	        				<tr style="cursor: default;">
	        					<td>${attendvo.emp_name}</td>
	        					<td>${attendvo.dept_name}</td>
	        					<td>${attendvo.attendance_start_date} ~ ${attendvo.attendance_finish_date}</td>
	        					<td>${attendvo.vacation_days}</td>
	        					<c:choose>
	        						<c:when test="${attendvo.fk_attendance_sort_no == 1}"><td>반차</td></c:when>
	        						<c:when test="${attendvo.fk_attendance_sort_no == 2}"><td>연차</td></c:when>
	        						<c:when test="${attendvo.fk_attendance_sort_no == 3}"><td>휴가</td></c:when>
	        						<c:otherwise><td>출장</td></c:otherwise>
	        					</c:choose>
	        			</c:forEach>
	        			<!-- <tr style="cursor: default;">
	        				<td colspan="5">
	        					<p> <span></span><span>등록된 연차 정보가 없습니다.</span></p>
	        				</td>
	        			</tr> -->
	        		</tbody>
	        	</table>
	        	<div>
	        		<div style="height: 1px;"></div>
	        		<div>
	        			<label> 
	        				<select size="1" name="vacation_list_length">
	        					<option value="20" selected="selected">20</option>
	        					<option value="40">40</option>
	        					<option value="60">60</option>
	        					<option value="80">80</option>
	        				</select> 
	        			</label>
	        		</div>
	        		<div id="vacation_list_paginate">
	        			${pageBar}
	        		</div>
	        	</div>
	        </div>
	    </div>
	    <!-- End //-->
	</div>

<!--
<header class="content_top"></header>
<div class="current_date" id="dateBtns" style="display:none;">
    <span class="btn_ic_prev2 btn_border" title="" id="preDate" data-date="2020-11"><span
            class="ic ic_prev2"></span></span>
    <span class="date" id="searchDate" data-date="2020-12">2020.12</span>
    <span class="btn_ic_next2 btn_border" title="" id="nextDate" data-date="2021-01"><span
            class="ic ic_next2"></span></span>
    <span class="btn_tool" alt="" id="calArea">
        <span class="ic_gnb ic_cal_mini"><input type="text" id="calBtn" style="border:0px;width:1px;height:1px"/></span>
    </span>
</div>
<div class="critical" id="descendant_area" style="margin-bottom:0;display: none">
</div>
<div id="excel_download_area" style="display:none;margin-left: 5px">
    <div class="btn_down">
        <a class="btn_tool" id="xlsxDownBtn">
            <span class="txt">목록 다운로드</span>
        </a>
    </div>
</div>

<div class="go_body ">
    <table class="type_normal tb_agenda tb_attend" id="vacation_list">
        <thead>
        <tr>
            <th class="name" style="text-align: center !important;">
					<span class="title_sort">
						이름
					</span>
            </th>
            <th class="go">
					<span class="title_sort">
						부서명
					</span>
            </th>
            <th class="go_ip">
					<span class="title_sort">
						기간
					</span>
            </th>
            <th class="leave">
					<span class="title_sort">
						사용일수
					</span>
            </th>
            <th class="leave_ip">
					<span class="title_sort">
						분류
					</span>
            </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div class="table_search table_new_search" style="text-align: center; margin-top: 0px">
        <span class="wrap_dateselect">
            <span class="noti_date_wrap wrap_date">
                <input class="input wfix_medium" type="text" id="searchStartDate" readonly="">
                <span class="ic ic_calendar"></span>
            </span>
            <span class="date_wave">~</span>
            <span class="noti_date_wrap wrap_date">
                <input class="input wfix_medium" type="text" id="searchEndDate" readonly="">
                <span class="ic ic_calendar"></span>
            </span>
        </span>
        <select id="searchTypes" style="vertical-align: top; margin-top: 1px;">
            <option value="user">이름</option>
            <option value="dept">부서명</option>
        </select>
        <section class="search2" id="keyword_section" style="vertical-align: top; margin-top: 1px;">
            <div class="search_wrap">
                <input id="searchKeyword" class="search2" type="text" placeholder="">
                <span id="searchBtn" class="btn_search2"></span>
            </div>
        </section>
    </div>
</div>-->
</div>