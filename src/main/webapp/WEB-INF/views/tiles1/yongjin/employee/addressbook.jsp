<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<% String ctxPath = request.getContextPath(); %>

<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

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

span#meta {
	color: #999;
	font-size: 13px;
}

a#sendMailGroup {
	color: #fff;
	font-size: 12px;
	background-color: #A9A9A9;
	padding: 0 4px;
	cursor: pointer;
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

span.lastName {
	margin: 7px;
	cursor: pointer;
}

.selectName {
	font-size: 12pt;
	font-weight: bolder;
	text-decoration: underline;
	color: black;
}

a#popupFieldSetting {
	color: #333;
	font-size: 13px;
	margin: 0 4px 0 0;
	padding: 0 8px;
	cursor: pointer;
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

div#contacts_paginate {
	text-align: center;
}

.modal-backdrop {
	z-index: -1;
}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.data").hide();
		$("span.sort").hide();
		
		// 정렬 아이콘 표시
		if("${data}" == "emp_name") {
			$("span#nameicon").html("<i class='fa fa-sort-${sort}'></i>");
		} else if("${data}" == "position_name") {
			$("span#positionicon").html("<i class='fa fa-sort-${sort}'></i>");
		} else {
			$("span#depticon").html("<i class='fa fa-sort-${sort}'></i>");
		}
		
		// sizePerPage 값 유지
		$("select#sizePerPage").val("${sizePerPage}").prop("selected", true);
		
		// 초성 검색 값 유지
		$("span.lastName").each(function(){
			var lastName = $(this).text();
			
			if(lastName == "${range}") {
				$(this).addClass("selectName");
				return;
			} else {
				$(this).removeClass("selectName");
			}// end of if(lastName == "${range}") {}-------------------
		});// end of $("span.lastName").each(function(){})--------------------
		
		// 필드 설정 값 유지
		$("input.fieldtype").prop("checked", false);
		$("input.fieldtypeRq").each(function(){
			var fieldtypeVal = $(this).val()
			
			$("input.fieldtype").each(function(){
				if($(this).val() == fieldtypeVal) {
					$(this).prop("checked", true);
					return;
				}
			});
		});
		
		
		// 페이지 당 보일 사원 수 설정
		$("select#sizePerPage").change(function(){
			sendForm();
		});// end of $("select#sizePerPage").change(function(){})----------------------
		
		
		// 필드 설정
		$("a#fieldCheck").click(function(){
			
			var frm = document.fieldContacts;
			frm.action = "<%= ctxPath%>/employee/addressbook.os";
			frm.submit();
		});
		
		
		// 정렬
		// 이름순
		$("span#nameicon").click(function(){
			var data = $(this).prev().html();
			var sort = $(this).next().html();
			
			if(sort == "asc") {
				sort = "desc";
			} else {
				sort = "asc";
			}
			
			location.href = "<%= ctxPath%>/employee/addressbook.os?data="+data+"&sort="+sort;
		});
		
		// 직위순
		$("span#positionicon").click(function(){
			var data = $(this).prev().html();
			var sort = $(this).next().html();
			
			if(sort == "asc") {
				sort = "desc";
			} else {
				sort = "asc";
			}
			
			location.href = "<%= ctxPath%>/employee/addressbook.os?data="+data+"&sort="+sort;
		});
		
		// 부서순
		$("span#depticon").click(function(){
			var data = $(this).prev().html();
			var sort = $(this).next().html();
			
			if(sort == "asc") {
				sort = "desc";
			} else {
				sort = "asc";
			}
			
			location.href = "<%= ctxPath%>/employee/addressbook.os?data="+data+"&sort="+sort;
		});
	});// end of $(document).ready(function(){})-----------------------
	
	
	function sendForm() {
		
		var frm = document.formContacts;
		frm.action = "<%= ctxPath%>/employee/addressbook.os";
		frm.method = "POST";
		frm.submit();
		
	}// end of function sendForm() {}----------------------
	
	
	// 주소록 초성 검색
	function lookConsonant(range, range1, range2) {
		
		document.formContacts.range.value = range;
		document.formContacts.range1.value = range1;
		document.formContacts.range2.value = range2;
		
		sendForm();
		
	}// end of function lookConsonant(range1, range2) {}-----------------------
	
	
	// 주소록 검색
	function searchContact() {
		
		var frm = document.searchContacts;
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
		
	}// end of function goDetailContact() {}----------------------

</script>
    
<div id="content">
	<header>
		<h1>
			<span id="groupInfoName">전사 주소록</span>
	
			<span id="meta">in 공용 주소록
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
				<!-- <li id="exposeCopyBtn">
					<a class="btnAdditional" id="copyContact">
						<span class="ic_toolbar copy"></span>
						<span class="txt_caution">주소록 복사</span>
					</a>
				</li> -->
	
				<li>
					<a class="btnAdditional" id="contactExcelExport" onclick="exportExcelFile();">
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
								<ul>
									<li><span class="lastName" onclick="lookConsonant('전체', '', '');">전체</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㄱ', '가', '나');">ㄱ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㄴ', '나', '다');">ㄴ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㄷ', '다', '라');">ㄷ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㄹ', '라', '마');">ㄹ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅁ', '마', '바');">ㅁ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅂ', '바', '사');">ㅂ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅅ', '사', '아');">ㅅ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅇ', '아', '자');">ㅇ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅈ', '자', '차');">ㅈ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅊ', '차', '카');">ㅊ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅋ', '카', '타');">ㅋ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅌ', '타', '파');">ㅌ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅍ', '파', '하');">ㅍ</span></li>
									<li><span class="lastName" onclick="lookConsonant('ㅎ', '하', '');">ㅎ</span></li>
									<li><span class="lastName" onclick="lookConsonant('a-z', 'a', 'Z');">a-z</span></li>
								</ul>
								<input type="hidden" name="range" />
								<input type="hidden" name="range1" />
								<input type="hidden" name="range2" />
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
						
						<div id="optional" style="margin-top: 15px;">
							<a id="popupFieldSetting" class="txt2" data-toggle="modal" data-target="#fieldSetting" data-dismiss="modal" data-backdrop="static" style="cursor: pointer;">
								<i class="fa fa-gear"></i>
								<span>필드 설정</span>
							</a>
						</div>
					</div>
					
					<!-- <div id="contacts_processing" style="visibility: hidden;">Loading...</div> -->
					<table id="contacts" style="width: 100%; margin-bottom: 0px;">
						<thead style="border-top: solid 1px #999; border-bottom: solid 1px #999;">
							<tr>
								<!-- <th rowspan="1" colspan="1" class="checkCol" style="width: 20px;">
									<input type="checkbox" id="checkedAll">
								</th> -->
								<c:forEach var="strFieldtype" items="${fieldtype}">
									<c:if test="${strFieldtype == 'emp_name'}">
										<th class="checkCol" style="min-width: 100px; width: 100px;" rowspan="1" colspan="1">
											<span class="title_sort">이름(표시명)<ins class="ic"></ins><span class="selected"></span></span>
											<span class="data">emp_name</span>
											<span id="nameicon" style="cursor: pointer;"><i class="fa fa-sort"></i></span>
											<span class="sort">${sort}</span>
										</th>
									</c:if>
									<c:if test="${strFieldtype == 'position_name'}">
										<th style="min-width: 50px; width: 50px;" rowspan="1" colspan="1">
											<span class="title_sort">직위<ins class="ic"></ins></span>
											<span class="data">position_name</span>
											<span id="positionicon" style="cursor: pointer;"><i class="fa fa-sort"></i></span>
											<span class="sort">${sort}</span>
										</th>
									</c:if>
									<c:if test="${strFieldtype == 'mobile'}">
										<th style="min-width: 80px; width: 80px;" rowspan="1" colspan="1">
											<span class="title_sort">휴대폰<ins class="ic"></ins></span>
										</th>
									</c:if>
									<c:if test="${strFieldtype == 'email'}">
										<th style="min-width: 90px; width: 90px;" rowspan="1" colspan="1">
											<span class="title_sort">이메일<ins class="ic"></ins><span class="selected"></span></span>
										</th>
									</c:if>
									<c:if test="${strFieldtype == 'dept_name'}">
										<th style="min-width: 50px; width: 50px;" rowspan="1" colspan="1">
											<span class="title_sort">부서<ins class="ic"></ins></span>
											<span class="data">dept_name</span>
											<span id="depticon" style="cursor: pointer;"><i class="fa fa-sort"></i></span>
											<span class="sort">${sort}</span>
										</th>
									</c:if>
									<c:if test="${strFieldtype == 'company'}">
										<th style="min-width: 55px; width: 55px;" rowspan="1" colspan="1">
											<span class="title_sort">회사<ins class="ic"></ins><span class="selected"></span></span>
										</th>
									</c:if>
									<c:if test="${strFieldtype == 'corp_phone'}">
										<th style="min-width: 80px; width: 80px;" rowspan="1" colspan="1">
											<span class="title_sort">회사전화<ins class="ic"></ins></span>
										</th>
									</c:if>
									<c:if test="${strFieldtype == 'basicAddress'}">
										<th style="min-width: 100px; width: 100px;" rowspan="1" colspan="1">
											<span class="title_sort">주소<ins class="ic"></ins></span>
										</th>
									</c:if>
								</c:forEach>
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
									<c:forEach var="strFieldtype" items="${fieldtype}">
										<input type="hidden" name="fieldtypeRq" class="fieldtypeRq" value="${strFieldtype}" />
										<c:if test="${strFieldtype == 'emp_name'}">
											<td class="tdAction checkCol" onclick="goDetailContact();">
												<span class="photo">
													<c:choose>
														<c:when test="${not empty empvo.photo_route}"><img src="<%= ctxPath%>/resources/images/${empvo.photo_route}" class="emp_photo" title="${empvo.emp_name}"></c:when>
														<c:otherwise><img src="<%= ctxPath%>/resources/images/photo_profile_small.jpg" class="emp_photo" title="${empvo.emp_name}"></c:otherwise>
													</c:choose>
												</span>
												<span class="name" id="emp_name">${empvo.emp_name}</span>
												<input type="hidden" name="emp_no" id="emp_no" value="${empvo.emp_no}" />
												<input type="hidden" name="goBackURL" value="${goBackURL}" />
											</td>
										</c:if>
										<c:if test="${strFieldtype == 'position_name'}">
											<td><span class="positionName" id="position_name">${empvo.position_name}</span></td>
										</c:if>
										<c:if test="${strFieldtype == 'mobile'}">
											<td><span class="hp" id="mobile">${empvo.mobile}</span></td>
										</c:if>
										<c:if test="${strFieldtype == 'email'}">
											<td class="tdAction"><a><span class="email" id="email">${empvo.email}</span></a></td>
										</c:if>
										<c:if test="${strFieldtype == 'dept_name'}">
											<td class="department" id="dept_name">${empvo.dept_name}</td>
										</c:if>
										<c:if test="${strFieldtype == 'company'}">
											<td><span class="company" id="company">(주)오성</span></td>
										</c:if>
										<c:if test="${strFieldtype == 'corp_phone'}">
											<td><span class="tel" id="corp_phone">${empvo.corp_phone}</span></td>
										</c:if>
										<c:if test="${strFieldtype == 'basicAddress'}">
											<td><span class="basicAddress"><span class="postcode" id="postcode">${empvo.postcode}</span>&nbsp;<span class="address" id="address">${empvo.address}</span>&nbsp;<span class="detail_address" id="detail_address">${empvo.detail_address}</span>&nbsp;<span class="extra_address" id="extra_address">${empvo.extra_address}</span>&nbsp;</span></td>
										</c:if>
									</c:forEach>
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

<%-- ===== 필드 설정 Modal ===== --%>
<form name="fieldContacts">
<div class="modal fade" id="fieldSetting" role="dialog" data-close="false" data-backdrop="false" style="background-color: rgba(0, 0, 0, 0.5); width: 300px; top: 78.5px; left: 404px;">
	<div class="modal-dialog">
		
		<div class="modal-content">
			<header>    
				<h1>필드 설정</h1>        
				<a id="go_popup_close_icon" class="btn_layer_x" style="" data-bypass="" title="닫기">
					<span class="ic"></span>
					<span class="txt"></span>
				</a>
			</header>
			
			<div class="modal-body">
				<span id="popupContent"></span>
				<div>
					<div id="fieldSettingTbody">
				        <div class="vertical_wrap_s">
				            	<input name="fieldtype" class="fieldtype clickFalse" id="NAME" type="checkbox" value="emp_name" contacttype="NAME" fieldcode="NAME" checked="checked" onclick="return false;">
				            	<label for="NAME">이름(표시명)</label>
				        </div>
				        <div class="vertical_wrap_s">
				            	<input name="fieldtype" class="fieldtype" id="POSITION" type="checkbox" value="position_name" contacttype="POSITION" fieldcode="POSITION" checked="checked">
				            	<label for="POSITION">직위</label>
				        </div>
				        <div class="vertical_wrap_s">
				            	<input name="fieldtype" class="fieldtype clickFalse" id="MOBILE" type="checkbox" value="mobile" contacttype="MOBILE" fieldcode="MOBILE" checked="checked" onclick="return false;">
				            	<label for="MOBILE">휴대폰</label>
				        </div>
				        <div class="vertical_wrap_s">
				            	<input name="fieldtype" class="fieldtype" id="EMAIL" type="checkbox" value="email" contacttype="EMAIL" fieldcode="EMAIL" checked="checked">
				            	<label for="EMAIL">이메일</label>
				        </div>
				        <div class="vertical_wrap_s">
				            	<input name="fieldtype" class="fieldtype" id="DEPARTMENT" type="checkbox" value="dept_name" contacttype="DEPARTMENT" fieldcode="DEPARTMENT" checked="checked">
				            	<label for="DEPARTMENT">부서</label>
				        </div>
				        <div class="vertical_wrap_s">
				            	<input name="fieldtype" class="fieldtype" id="COMPANY" type="checkbox" value="company" contacttype="COMPANY" fieldcode="COMPANY" checked="checked">
				            	<label for="COMPANY">회사</label>
				        </div>
				        <div class="vertical_wrap_s">
				            	<input name="fieldtype" class="fieldtype" id="COMPANY_PHONE" type="checkbox" value="corp_phone" contacttype="COMPANY_PHONE" fieldcode="COMPANY_PHONE" checked="checked">
				            	<label for="COMPANY_PHONE">회사전화</label>
				        </div>
				        <div class="vertical_wrap_s">
				            	<input name="fieldtype" class="fieldtype" id="COMPANY_ADDRESS" type="checkbox" value="basicAddress" contacttype="COMPANY_ADDRESS" fieldcode="COMPANY_ADDRESS" checked="checked">
				            	<label for="COMPANY_ADDRESS">주소</label>
				        </div>
					</div>
				</div>
			</div>
			
			<footer class="btn_layer_wrap">
				<a class="btn_major_s" id="fieldCheck" data-bypass="" style="margin-right:5px" title="확인">
					<span class="ic"></span>
					<span class="txt">확인</span>
				</a>
				<a class="btn_minor_s" data-dismiss="modal" data-bypass="" style="margin-right:5px" title="취소">
					<span class="ic"></span>
					<span class="txt">취소</span>
				</a>
			</footer>
		</div>
		
	</div>
</div>
</form>

