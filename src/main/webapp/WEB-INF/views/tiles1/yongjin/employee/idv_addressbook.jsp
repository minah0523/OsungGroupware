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

div#side, div#innerContent {
	display: inline-block;
}

div#side {
	width: 20%;
	border-right-color: #999;
}

div#innerContent {
	width: 80%;
}

ul#ulMenu {
	padding-left: 0;
}

span#book1 {
	color: #02A1C0;
}

li.info {
	font-size: 14px;
	padding: 20px 24px 20px 6px;
	display: block;
}

p.title {
	height: 25px;
	color: #333;
	font-size: 14px;
	padding: 2px 24px 2px 40px;
}

div#side {
	float: left;
}

tr {
	line-height: 42px;
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

img.pb_photo {
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

span#quickCreate {
	cursor: pointer;
}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("p#editBookPart").hide();
		$("span#countBook").hide();
		
		$("span.data").hide();
		$("span.sort").hide();
		
		// ?????? ????????? ??????
		if("${data}" == "name") {
			$("span#nameicon").html("<i class='fa fa-sort-${sort}'></i>");
		} else if("${data}" == "position_name") {
			$("span#positionicon").html("<i class='fa fa-sort-${sort}'></i>");
		} else {
			$("span#depticon").html("<i class='fa fa-sort-${sort}'></i>");
		}
		
		// sizePerPage ??? ??????
		$("select#sizePerPage").val("${sizePerPage}").prop("selected", true);
		
		// ?????? ?????? ??? ??????
		$("span.lastName").each(function(){
			var lastName = $(this).text();
			
			if(lastName == "${range}") {
				$(this).addClass("selectName");
				return;
			} else {
				$(this).removeClass("selectName");
			}// end of if(lastName == "${range}") {}-------------------
		});// end of $("span.lastName").each(function(){})--------------------
		
		// ?????? ?????? ??? ??????
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
		
		
		// ????????? ??? ?????? ?????? ??? ??????
		$("select#sizePerPage").change(function(){
			sendForm();
		});// end of $("select#sizePerPage").change(function(){})----------------------
		
		
		// ?????? ??????
		$("a#fieldCheck").click(function(){
			
			var frm = document.fieldContacts;
			frm.action = "<%= ctxPath%>/employee/idv_addressbook.os";
			frm.submit();
		});
		
		// ??????
		// ?????????
		$("span#nameicon").click(function(){
			var data = $(this).prev().html();
			var sort = $(this).next().html();
			
			if(sort == "asc") {
				sort = "desc";
			} else {
				sort = "asc";
			}
			
			location.href = "<%= ctxPath%>/employee/idv_addressbook.os?data="+data+"&sort="+sort;
		});
		
		// ?????????
		$("span#positionicon").click(function(){
			var data = $(this).prev().html();
			var sort = $(this).next().html();
			
			if(sort == "asc") {
				sort = "desc";
			} else {
				sort = "asc";
			}
			
			location.href = "<%= ctxPath%>/employee/idv_addressbook.os?data="+data+"&sort="+sort;
		});
		
		// ?????????
		$("span#depticon").click(function(){
			var data = $(this).prev().html();
			var sort = $(this).next().html();
			
			if(sort == "asc") {
				sort = "desc";
			} else {
				sort = "asc";
			}
			
			location.href = "<%= ctxPath%>/employee/idv_addressbook.os?data="+data+"&sort="+sort;
		});
		
		
		// ?????? ????????? ?????? ??????
		$("td.nameCol").click(function(){
			var book_no = $(this).find("#book_no").val();
			
			location.href = "<%= ctxPath%>/employee/idv_detailContact.os?book_no="+book_no+"&goBackURL=${goBackURL}";
		});
	});// end of $(document).ready(function(){})-----------------------
	
	
	function sendForm() {
		
		var frm = document.formContacts;
		frm.action = "<%= ctxPath%>/employee/idv_addressbook.os";
		frm.method = "POST";
		frm.submit();
		
	}// end of function sendForm() {}----------------------
	
	
	// ????????? ?????? ??????
	function lookConsonant(range, range1, range2) {
		
		document.formContacts.range.value = range;
		document.formContacts.range1.value = range1;
		document.formContacts.range2.value = range2;
		
		sendForm();
		
	}// end of function lookConsonant(range1, range2) {}-----------------------
	
	
	// ????????? ??????
	function searchContact() {
		
		var frm = document.searchContacts;
		frm.action = "<%= ctxPath%>/employee/idv_addressbook.os";
		frm.submit();
		
	}// end of function searchContacts() {}-----------------------
	
	
	// EXCEL ??????
	function exportExcelFile() {
		
		var frm = document.formContacts;
		frm.action = "<%= ctxPath%>/excel/exportExcelFilePersonal.os";
		frm.method = "POST";
		frm.submit();
		
	}// end of function exportExcelFile() {}----------------------
	
	
	// ????????? ??????
	function addIdvBook() {
		$("p#editBookPart").show();
		
		$("i#checkBook").click(function(){
			var bookVal = $("input#editBook").val();
			
			if(bookVal == "") {
				alert("????????? ????????? ???????????????.");
				return
			} else {
				var count = Number($("span#countBook").html());
				
				$.ajax({
					url:"<%= ctxPath%>/idv_addIdvBook.os",
					async:false,
					data:{"book_part_count":++count,
						  "book_part_name":bookVal,
						  "emp_no":"${sessionScope.loginemp.emp_no}"},
					type:"POST",
					dataType:"JSON",
					success:function(json){
						if(json.result == 1) {
							$("p#editBookPart").hide();
							$("span#addedBook").html(bookVal);
							
							// ????????? ??????
							$("span#countBook").html(count);
							
							location.href="javascript:location.reload(true)";
						}
						
					},
					error:function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
			}
		});
	}
	
	
	// ?????? ????????? ?????? ??????
	function quickCreateIdvContact() {
		var frm = document.quickCreateForm;
		frm.action = "<%= ctxPath%>/employee/idv_quickCreateContact.os";
		frm.method = "POST";
		frm.submit();
	}

</script>
    
<div id="content">
	<div class="go_side" id="side" style="padding-bottom: 0px;">
		<nav class="side_menu">
		    <ul id="ulMenu">
		    	<c:forEach var="bookMap" items="${bookList}" varStatus="status">
		    		<li class="info  on ">
				        <p class="title on">
				            <a style="cursor: pointer;" onclick="location.href='<%= ctxPath%>/employee/idv_addressbook.os?idxBook=${status.count}'">
				                <ins class="ic"></ins>
				                <span class="contactTag" id="book${status.count}">${bookMap.book_part_name}</span>
				            </a>
				        </p>
				    </li>
		    	</c:forEach>
			    <li class="info  on ">
			        <p class="title" id="editBookPart">
					    <ins class="ic"></ins>
					    <input class="edit" id="editBook" type="text" placeholder="????????? ?????? ??????">
					    <span class="submit_wrap">
					        <i class="fa fa-check" id="checkBook"></i>
					    </span>
					    <span class="submit_wrap">
					        <i class="fa fa-refresh"></i>
					    </span>
					</p>
					<span id="addedBook"></span>
					<span id="countBook">${bookSize}</span>
			    </li>
				<li class="info  on ">
					<p class="title">
						<i class="fa fa-plus"></i>
						<span data-event="addGroup" id="idvBook" class="txt" onclick="addIdvBook();" style="color: #999; cursor: pointer;">????????? ????????? ??????</span>
					</p>
				</li>
			</ul>
		</nav>
	</div>

	<div id="innerContent">
		<header>
			<h1>
				<span id="groupInfoName">${book_part_name}</span>
		
				<span id="contactCount">in ?????? ?????????
					<span>(???<strong>${count}</strong>???)</span>
				</span>
			</h1>
	<!-- <section id="search" class="search">
		<select id="searchType">
			<option value="appSearch">?????????</option>
			<option value="totalSearch">????????????</option>
		</select>
		<div class="search_wrap">
			<input class="search" type="text" id="simpleContactInput" placeholder="??????">
			<a class="btn_detail" id="detailContactSearch" title="????????????" data-bypass></a>
			<input class="btn_search" id="simpleContactSearch" value="" title="??????">
			<input type="hidden" name="hiddenInput"/>
		</div>
	</section> -->
	
			<!-- <form name="searchContacts">
				<section id="search">
					<div>focus?????? "search_focus" multi class??? ??????????????????.
						<input class="c_search" type="text" id="simpleContactInput" name="contactInput" placeholder="??????">
						<i class="fa fa-search" id="simpleContactSearch" title="??????" onclick="searchContact();"></i>
						<input type="hidden" name="hiddenInput">
					</div>
				</section>
			</form> -->
		</header>
	
		<div>
			<section>
				<ul>
					<!-- <li>
		                <a class="btnAdditional" id="contactDelete">
		                    <span class="ic_toolbar del"></span>
		                    <span class="txt_caution">??????</span>
		                </a>
		            </li>
		
					<li id="exposeCopyBtn">
						<a class="btnAdditional" id="copyContact">
							<span class="ic_toolbar copy"></span>
							<span class="txt_caution">????????? ??????</span>
						</a>
					</li>
		
					<li>
		                <a class="btnAdditional" id="manage_company">
		                    <span class="ic_toolbar group_setting"></span>
		                    <span class="txt">????????????</span>
		                </a>
		            </li> -->
		
					<li>
						<a class="btnAdditional" id="contactExcelExport" onclick="exportExcelFile();">
							<!-- <span class="ic_toolbar more"></span> -->
							<span class="txt">EXCEL??? ????????????</span>
						</a>
					</li>
				</ul>
			</section>
		
			<form id="quickCreateForm" name="quickCreateForm">
				<fieldset>
					<div>
						<input id="quickName" type="text" name="name" placeholder="??????(?????????)" class="input w_small">
						<input id="quickEmail" type="text" name="email" placeholder="?????????" class="input w_small">
						<input id="quickPhone" type="text" name="mobile" placeholder="?????????" class="input w_small">
						<input type="hidden" name="fk_emp_no" value="${sessionScope.loginemp.emp_no}" />
						<input type="hidden" name="fk_book_part_no" value="${book_part_no}" />
						<span class="btn_minor_s2">
							&nbsp;<span id="quickCreate" class="ic_toolbar fast" onclick="quickCreateIdvContact();"><i class="fa fa-plus-square fa-2x"></i></span>
						</span>
						<!-- <span class="btn_minor_s3">
							<span id="detailCreate" class="txt">???????????? ??????</span>
						</span> -->
					</div>
				</fieldset>
			</form>
			<br>
			<form name="formContacts">
				<div>
					<div id="contacts_wrapper">
						<div>
							<div>
								<div id="toolBar">
									<ul>
										<li><span class="lastName" onclick="lookConsonant('??????', '', '');">??????</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '???');">???</span></li>
										<li><span class="lastName" onclick="lookConsonant('???', '???', '');">???</span></li>
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
									<span>?????? ??????</span>
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
										<c:if test="${strFieldtype == 'name'}">
											<th class="checkCol" style="min-width: 100px; width: 100px;" rowspan="1" colspan="1">
												<span class="title_sort">??????(?????????)<ins class="ic"></ins><span class="selected"></span></span>
												<span class="data">name</span>
												<span id="nameicon" style="cursor: pointer;"><i class="fa fa-sort"></i></span>
												<span class="sort">${sort}</span>
											</th>
										</c:if>
										<c:if test="${strFieldtype == 'position_name'}">
											<th style="min-width: 50px; width: 50px;" rowspan="1" colspan="1">
												<span class="title_sort">??????<ins class="ic"></ins></span>
												<span class="data">position_name</span>
												<span id="positionicon" style="cursor: pointer;"><i class="fa fa-sort"></i></span>
												<span class="sort">${sort}</span>
											</th>
										</c:if>
										<c:if test="${strFieldtype == 'mobile'}">
											<th style="min-width: 80px; width: 80px;" rowspan="1" colspan="1">
												<span class="title_sort">?????????<ins class="ic"></ins></span>
											</th>
										</c:if>
										<c:if test="${strFieldtype == 'email'}">
											<th style="min-width: 90px; width: 90px;" rowspan="1" colspan="1">
												<span class="title_sort">?????????<ins class="ic"></ins><span class="selected"></span></span>
											</th>
										</c:if>
										<c:if test="${strFieldtype == 'dept_name'}">
											<th style="min-width: 50px; width: 50px;" rowspan="1" colspan="1">
												<span class="title_sort">??????<ins class="ic"></ins></span>
												<span class="data">dept_name</span>
												<span id="depticon" style="cursor: pointer;"><i class="fa fa-sort"></i></span>
												<span class="sort">${sort}</span>
											</th>
										</c:if>
										<c:if test="${strFieldtype == 'company'}">
											<th style="min-width: 55px; width: 55px;" rowspan="1" colspan="1">
												<span class="title_sort">??????<ins class="ic"></ins><span class="selected"></span></span>
											</th>
										</c:if>
										<c:if test="${strFieldtype == 'corp_phone'}">
											<th style="min-width: 80px; width: 80px;" rowspan="1" colspan="1">
												<span class="title_sort">????????????<ins class="ic"></ins></span>
											</th>
										</c:if>
										<c:if test="${strFieldtype == 'basicAddress'}">
											<th style="min-width: 100px; width: 100px;" rowspan="1" colspan="1">
												<span class="title_sort">??????<ins class="ic"></ins></span>
											</th>
										</c:if>
									</c:forEach>
									<!-- <th style="min-width: 100px; width: 100px;" rowspan="1" colspan="1">
										<span class="title_sort">??????<ins class="ic"></ins></span>
									</th>
									<th style="min-width: 110px; width: 110px;" rowspan="1" colspan="1">
									    <span class="title_sort">??????<ins class="ic"></ins></span>
									</th> -->
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="pbvo" items="${pbList}">
									<tr>
										<!-- <td class="checkCol">
											<input name="id" type="checkbox" data-row="0">
										</td> -->
										<c:forEach var="strFieldtype" items="${fieldtype}">
											<input type="hidden" name="fieldtypeRq" class="fieldtypeRq" value="${strFieldtype}" />
											<c:if test="${strFieldtype == 'name'}">
												<td class="tdAction checkCol nameCol">
													<span class="photo">
														<c:choose>
															<c:when test="${not empty pbvo.photo_route}"><img src="<%= ctxPath%>/resources/images/${pbvo.photo_route}" class="pb_photo" title="${pbvo.name}"></c:when>
															<c:otherwise><img src="<%= ctxPath%>/resources/images/photo_profile_small.jpg" class="pb_photo" title="${pbvo.name}"></c:otherwise>
														</c:choose>
													</span>
													<span class="name" id="name">${pbvo.name}</span>
													<input type="hidden" name="book_no" id="book_no" value="${pbvo.book_no}" />
													<input type="hidden" name="goBackURL" value="${goBackURL}" />
												</td>
											</c:if>
											<c:if test="${strFieldtype == 'position_name'}">
												<td><span class="positionName" id="position_name">${pbvo.position_name}</span></td>
											</c:if>
											<c:if test="${strFieldtype == 'mobile'}">
												<td><span class="hp" id="mobile">${pbvo.mobile}</span></td>
											</c:if>
											<c:if test="${strFieldtype == 'email'}">
												<td class="tdAction"><a><span class="email" id="email">${pbvo.email}</span></a></td>
											</c:if>
											<c:if test="${strFieldtype == 'dept_name'}">
												<td class="department" id="dept_name">${pbvo.dept_name}</td>
											</c:if>
											<c:if test="${strFieldtype == 'company'}">
												<td><span class="company" id="company">${pbvo.company_name}</span></td>
											</c:if>
											<c:if test="${strFieldtype == 'corp_phone'}">
												<td><span class="tel" id="corp_phone">${pbvo.corp_phone}</span></td>
											</c:if>
											<c:if test="${strFieldtype == 'basicAddress'}">
												<td><span class="basicAddress"><span class="postcode" id="postcode">${pbvo.postcode}</span>&nbsp;<span class="address" id="address">${pbvo.address}</span>&nbsp;<span class="detail_address" id="detail_address">${pbvo.detail_address}</span>&nbsp;<span class="extra_address" id="extra_address">${pbvo.extra_address}</span>&nbsp;</span></td>
											</c:if>
										</c:forEach>
										<!-- <td class="memo"></td>
										<td><span class="group" title="?????? ?????????">??????&nbsp;?????????</span></td> -->
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
</div>

<%-- ===== ?????? ?????? Modal ===== --%>
<form name="fieldContacts">
	<div class="modal fade" id="fieldSetting" role="dialog" data-close="false" data-backdrop="false" style="background-color: rgba(0, 0, 0, 0.5); width: 300px; top: 78.5px; left: 404px;">
		<div class="modal-dialog">
			
			<div class="modal-content">
				<header>    
					<h1>?????? ??????</h1>        
					<a id="go_popup_close_icon" class="btn_layer_x" style="" data-bypass="" title="??????">
						<span class="ic"></span>
						<span class="txt"></span>
					</a>
				</header>
				
				<div class="modal-body">
					<span id="popupContent"></span>
					<div>
						<div id="fieldSettingTbody">
					        <div class="vertical_wrap_s">
					            	<input name="fieldtype" class="fieldtype clickFalse" id="NAME" type="checkbox" value="name" contacttype="NAME" fieldcode="NAME" checked="checked" onclick="return false;">
					            	<label for="NAME">??????(?????????)</label>
					        </div>
					        <div class="vertical_wrap_s">
					            	<input name="fieldtype" class="fieldtype" id="POSITION" type="checkbox" value="position_name" contacttype="POSITION" fieldcode="POSITION" checked="checked">
					            	<label for="POSITION">??????</label>
					        </div>
					        <div class="vertical_wrap_s">
					            	<input name="fieldtype" class="fieldtype clickFalse" id="MOBILE" type="checkbox" value="mobile" contacttype="MOBILE" fieldcode="MOBILE" checked="checked" onclick="return false;">
					            	<label for="MOBILE">?????????</label>
					        </div>
					        <div class="vertical_wrap_s">
					            	<input name="fieldtype" class="fieldtype" id="EMAIL" type="checkbox" value="email" contacttype="EMAIL" fieldcode="EMAIL" checked="checked">
					            	<label for="EMAIL">?????????</label>
					        </div>
					        <div class="vertical_wrap_s">
					            	<input name="fieldtype" class="fieldtype" id="DEPARTMENT" type="checkbox" value="dept_name" contacttype="DEPARTMENT" fieldcode="DEPARTMENT" checked="checked">
					            	<label for="DEPARTMENT">??????</label>
					        </div>
					        <div class="vertical_wrap_s">
					            	<input name="fieldtype" class="fieldtype" id="COMPANY" type="checkbox" value="company" contacttype="COMPANY" fieldcode="COMPANY" checked="checked">
					            	<label for="COMPANY">??????</label>
					        </div>
					        <div class="vertical_wrap_s">
					            	<input name="fieldtype" class="fieldtype" id="COMPANY_PHONE" type="checkbox" value="corp_phone" contacttype="COMPANY_PHONE" fieldcode="COMPANY_PHONE" checked="checked">
					            	<label for="COMPANY_PHONE">????????????</label>
					        </div>
					        <div class="vertical_wrap_s">
					            	<input name="fieldtype" class="fieldtype" id="COMPANY_ADDRESS" type="checkbox" value="basicAddress" contacttype="COMPANY_ADDRESS" fieldcode="COMPANY_ADDRESS" checked="checked">
					            	<label for="COMPANY_ADDRESS">??????</label>
					        </div>
						</div>
					</div>
				</div>
				
				<footer class="btn_layer_wrap">
					<a class="btn_major_s" id="fieldCheck" data-bypass="" style="margin-right:5px" title="??????">
						<span class="ic"></span>
						<span class="txt">??????</span>
					</a>
					<a class="btn_minor_s" data-dismiss="modal" data-bypass="" style="margin-right:5px" title="??????">
						<span class="ic"></span>
						<span class="txt">??????</span>
					</a>
				</footer>
			</div>
			
		</div>
	</div>
</form>

