<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<% String ctxPath = request.getContextPath(); %>
    
<style type="text/css">
div, span, ul, li, table, tr, th, td, h1 {
	/* border: solid 1px gray; */
}

header {
	padding: 18px 24px;
}

header > h1 {
	/* width: 50%; */
	display: inline-block;
}

span#groupInfoName {
	font-size: 22px;
	margin: 0 8px 0 0;
}

span#contactCount {
	color: #999;
	font-size: 13px;
}

a.btnAdditional {
	width: 67px;
	height: 32px;
	color: #333;
	font-size: 13px;
	margin: 0 4px 0 0;
	padding: 0 8px;
	cursor: pointer;
}

section#search {
	display: inline-block;
	float: right;
}

li {
	display: inline-block;
}

div#contacts_length {
	float: right;
}

div#optional {
	float: right;
}

select {
	width: 44px;
	height: 32px;
}

tbody > tr:hover {
	background-color: #e6ffe6;
}

td {
	line-height: 61px;
}

.checkCol {
	padding: 0 0 0 24px;
}

td.tdAction {
	cursor: pointer;
}

img.emp_photo {
	width: 32px;
	height: 32px;
	border-radius: 50%;
}

.searchHighlight {
	background-color: #b3e6ff;
}

div#contacts_paginate {
	text-align: center;
}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 필드 설정 값 유지
		$("select#sizePerPage").val("${sizePerPage}").prop("selected", true);
		
		// 페이지 당 보일 사원 수 필드 설정
		$("select#sizePerPage").change(function(){
			sendForm();
		});// end of $("select#sizePerPage").change(function(){})----------------------
		
		// 검색어 유지
		var contactInput = "${contactInput}";  // 검색어
		
		if(contactInput != null && contactInput != "") {
			$("input#simpleContactInput").val(contactInput);
		}// end of if(contactInput != null && contactInput != "") {}------------------
		
		// 검색결과 하이라이트 시작 //
		// 사원명
		$("span.name").each(function(){
			var emp_name = $(this).text();
			
			if(emp_name.indexOf(contactInput) != -1) {
				// 검색어를 포함하는 경우
				$(this).addClass("searchHighlight");
			} else {
				$(this).removeClass("searchHighlight");
			}// end of if(emp_name.indexOf(contactInput) != -1) {}-------------------
		});// end of $("span.name").each(function(){})--------------------
		
		// 직급
		$("span.positionName").each(function(){
			var position_name = $(this).text();
			
			if(position_name.indexOf(contactInput) != -1) {
				// 검색어를 포함하는 경우
				$(this).addClass("searchHighlight");
			} else {
				$(this).removeClass("searchHighlight");
			}// end of if(position_name.indexOf(contactInput) != -1) {}-------------------
		});// end of $("span.positionName").each(function(){})--------------------
		
		// 부서
		$("span.department").each(function(){
			var department_name = $(this).text();
			
			if(department_name.indexOf(contactInput) != -1) {
				// 검색어를 포함하는 경우
				$(this).addClass("searchHighlight");
			} else {
				$(this).removeClass("searchHighlight");
			}// end of if(department_name.indexOf(contactInput) != -1) {}-------------------
		});// end of $("span.department").each(function(){})--------------------
		// 검색결과 하이라이트 끝 //
		
	});// end of $(document).ready(function(){})-----------------------
	
	
	function sendForm() {
		
		var frm = document.formContacts;
		frm.action = "<%= ctxPath%>/employee/addressbook.os";
		frm.method = "POST";
		frm.submit();
		
	}// end of function sendForm() {}----------------------
	
	
	// 주소록 검색
	function searchContact() {
		
		var frm = document.searchContacts
		frm.action = "<%= ctxPath%>/employee/addressbook.os";
		frm.submit();
		
	}// end of function searchContacts() {}-----------------------
	
	
	// EXCEL 다운
	function exportExcelFile() {
		
		var frm = document.formContacts;
		frm.action = "<%= ctxPath%>/excel/exportExcelFile.os";
		frm.method = "POST";
		frm.submit();
		
	}// end of function exportExcelFile() {}----------------------
	
	
	// 사원 정보 상세보기
	function goDetailContact() {
		
		var frm = document.formContacts;
		frm.action = "<%= ctxPath%>/employee/detailContact.os";
		frm.submit();
		
	}// end of function sendForm() {}----------------------

</script>
    
<div id="content">
	<header>
		<h1>
			<span id="groupInfoName">검색결과
				<span id="contactCount">(총<strong>${count}</strong>건)</span>
			</span>
		</h1>
<!-- <section id="search" class="search">
	<select id="searchType">
		<option value="appSearch">앱검색</option>
		<option value="totalSearch">통합검색</option>
	</select>
	<div class="search_wrap">
		<input class="search" type="text" id="simpleContactInput" placeholder="검색">
		<a class="btn_detail" id="detailContactSearch" title="상세검색" data-bypass></a>
		<input class="btn_search" id="simpleContactSearch" value="" title="검색">
		<input type="hidden" name="hiddenInput"/>
	</div>
</section> -->

		<form name="searchContacts">
			<section id="search">
				<div><!--focus되면 "search_focus" multi class로 추가해주세요.-->
					<input class="c_search" type="text" id="simpleContactInput" name="contactInput" placeholder="검색">
					<i class="fa fa-search" id="simpleContactSearch" title="검색" onclick="searchContact();"></i>
					<input type="hidden" name="hiddenInput">
				</div>
			</section>
		</form>
	</header>

	<div>
		<section>
			<ul>
				<li>
					<a class=" btnAdditional" id="contactExcelExport" onclick="exportExcelFile();">
						<!-- <span class="ic_toolbar more"></span> -->
						<span class="txt">EXCEL로 내보내기</span>
					</a>
				</li>
			</ul>
		</section>
	
		<form name="formContacts">
			<div>
				<div id="contacts_wrapper">
					<div>
						<div>
							<div id="toolBar">
								<input type="hidden" name="contactInput" value="${contactInput}" />
							</div>
						</div>
						
						<div id="contacts_length" style="margin-top: 15px;">
							<label>
								<select size="1" name="sizePerPage" id="sizePerPage">
									<option value="20" selected="selected">20</option>
									<option value="40">40</option>
									<option value="60">60</option>
									<option value="80">80</option>
								</select>
							</label>
						</div>
						
					</div>
					
					<!-- <div id="contacts_processing" style="visibility: hidden;">Loading...</div> -->
					<table id="contacts" style="width: 100%; margin-bottom: 0px;">
						<thead style="border-top: solid 1px #999; border-bottom: solid 1px #999;">
							<tr>
								<!-- <th rowspan="1" colspan="1" class="checkCol" style="width: 20px;">
									<input type="checkbox" id="checkedAll">
								</th> -->
								<th class="checkCol" style="min-width: 100px; width: 100px;" rowspan="1" colspan="1">
									<span class="title_sort">이름(표시명)<ins class="ic"></ins><span class="selected"></span></span>
								</th>
								<th style="min-width: 50px; width: 50px;" rowspan="1" colspan="1">
									<span class="title_sort">직위<ins class="ic"></ins></span>
								</th>
								<th style="min-width: 80px; width: 80px;" rowspan="1" colspan="1">
									<span class="title_sort">휴대폰<ins class="ic"></ins></span>
								</th>
								<th style="min-width: 90px; width: 90px;" rowspan="1" colspan="1">
									<span class="title_sort">이메일<ins class="ic"></ins><span class="selected"></span></span>
								</th>
								<th style="min-width: 50px; width: 50px;" rowspan="1" colspan="1">
									<span class="title_sort">부서<ins class="ic"></ins></span>
								</th>
								<th style="min-width: 55px; width: 55px;" rowspan="1" colspan="1">
									<span class="title_sort">회사<ins class="ic"></ins><span class="selected"></span></span>
								</th>
								<th style="min-width: 80px; width: 80px;" rowspan="1" colspan="1">
									<span class="title_sort">회사전화<ins class="ic"></ins></span>
								</th>
								<th style="min-width: 100px; width: 100px;" rowspan="1" colspan="1">
									<span class="title_sort">회사주소<ins class="ic"></ins></span>
								</th>
								<!-- <th style="min-width: 100px; width: 100px;" rowspan="1" colspan="1">
									<span class="title_sort">메모<ins class="ic"></ins></span>
								</th>
								<th style="min-width: 110px; width: 110px;" rowspan="1" colspan="1">
								    <span class="title_sort">그룹<ins class="ic"></ins></span>
								</th> -->
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="empvo" items="${empList}">
								<tr>
									<!-- <td class="checkCol">
										<input name="id" type="checkbox" data-row="0">
										
									</td> -->
									<td class="tdAction checkCol" onclick="goDetailContact();">
										<span class="photo">
											<c:choose>
												<c:when test="${not empty empvo.photo_route}"><img src="<%= ctxPath%>/resources/images/${empvo.photo_route}" class="emp_photo" title="${empvo.emp_name}"></c:when>
												<c:otherwise><img src="<%= ctxPath%>/resources/images/photo_profile_small.jpg" class="emp_photo" title="${empvo.emp_name}"></c:otherwise>
											</c:choose>
										</span>
										<a><span class="name" id="emp_name">${empvo.emp_name}</span></a>
										<input type="hidden" name="emp_no" id="emp_no" value="${empvo.emp_no}" />
										<input type="hidden" name="goBackURL" value="${goBackURL}" />
									</td>
									<td><span class="positionName" id="position_name">${empvo.position_name}</span></td>
									<td><span class="hp" id="mobile">${empvo.mobile}</span></td>
									<td><a><span class="email" id="email">${empvo.email}</span></a></td>
									<td><span class="department" id="dept_name">${empvo.dept_name}</span></td>
									<td><span class="company" id="company">(주)오성</span></td>
									<td><span class="tel" id="corp_phone">${empvo.corp_phone}</span></td>
									<td><span class="basicAddress"><span class="postcode" id="postcode">${empvo.postcode}</span>&nbsp;<span class="address" id="address">${empvo.address}</span>&nbsp;<span class="detail_address" id="detail_address">${empvo.detail_address}</span>&nbsp;<span class="extra_address" id="extra_address">${empvo.extra_address}</span>&nbsp;</span></td>
									<!-- <td class="memo"></td>
									<td><span class="group" title="전사 주소록">전사&nbsp;주소록</span></td> -->
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div>
						<div id="contacts_paginate">${pageBar}</div>
					</div>
				</div>
			</div>
		</form>
		<iframe name="printIframe" id="printIframe" style="display:none"></iframe>
	</div>
</div>