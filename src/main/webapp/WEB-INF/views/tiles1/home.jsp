<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
<style type="text/css">
/* div, span {
	border: solid 1px gray;
} */

div.go-gadget-content {
	display: inline-block;
	border: solid 1px #c9c9c9;
	border-radius: 5px;
	margin-top: 20px;
}

div.left_section {
	width: 320px;
}

div.profile {
	padding: 40px 40px 10px;
}

img.emp_photo {
	display: block;
	width: 82px;
	height: 82px;
	border-radius: 50%;
	margin: 0 auto;
}

span.info {
	display: block;
	text-align: center;
	margin: 0 auto;
}

span.profileInfo {
	text-align: center;
	font-size: 18px;
	font-weight: bold;
}

span.company {
	display: inline-block;
	width: 100px;
	text-align: center;
	color: #919191;
}

li.today_list {
	line-height: 30px;
}

span.mybadge {
	margin-left: 130px;
}

ul#btn_list_block {
	margin-right: 0;
}

li.btn_list_li {
	border: solid 1px #c9c9c9;
	width: 144px;
	height: 52px;
	margin: 0 auto;
	padding: 10px 15px;
}

li.odd {
	margin-right: 22px;
}

ul {
	list-style: none;
}

ul.type_btn_list_block {
	padding-left: 0;
}

li.odd, li.even {
	display: inline-block;
}

div.go-gadget-header, div.go_gadget_header {
	padding: 16px 21px 4px;
}

span.title {
	padding: 0px 2px 0px 0px;
	font-size: 16px;
	font-weight: bold;
}

p.txt {
	font-size: 13px;
	padding: 10px 21px 5px;
}

div.content-section-2 {
	width: 702px;
}

ul.dashboard_tab.gadget_tab {
	padding: 0px 24px;
}

ul.dashboard_tab.gadget_tab > li {
	display: inline-block;
}

ul.dashboard_tab.gadget_tab > li > a {
	font-size: 13px;
	padding: 0px 10px;
}

hr {
	margin: 0;
}

li.integrated {
	padding: 6px 36px 6px 21px;
}

li.board_menu, li.note_menu {
	cursor: pointer;
}

.whereBoard, .whereNote {
	border-bottom: solid 1px #000;
}

.whereBoard a, .whereNote a {
	color: #000;
	font-weight: bold;
}

ul.mailList {
	padding: 20px 0;
}

div.content-section-3 {
	width: 230px;
}

img.ic_dashboard {
	width: 30px;
	height: 28px;
}

div#section_1, div#section_2 {
	display: inline-block;
}

div#section_1 {
	float: left;
}

div#section_2_1, div#section_2_2 {
	display: inline-block;
}

div#section_2_2 {
	float: right;
}

div.ehr_stat_data.summary {
	position: relative;
	color: #333;
	font-size: 13px;
	padding: 0 21px 45px;
}

p#workTime {
	color: #000;
	font-size: 28px;
}

b {
	font-size: 20px;
	margin: 0 0 0 2px;
}

div#timemin {
	position: absolute;
	font-size: 13px;
	margin: 0 0 0 -40px;
	top: 60%;
}

div#bar {
	position: absolute;
	border: dotted 1px red;
	width: 2px;
	height: 30px;
	margin: -10px 0 0;
	/* top: 55%; */
}

div#timemax {
	position: absolute;
	font-size: 13px;
	right: 10%;
	top: 20%;
}

div.board_card.cardItem {
	width: 200px;
	height: 45px;
	color: #333;
	font-size: 13px;
	background-color: #F0F5FC;
	padding: 0 10px 10px;
	margin: 5px 0 5px 15px;
}

div.board_card.cardItem > div.title {
	padding: 16px 0 4px;
	cursor: pointer;
}
</style>

<script>

	$(document).ready(function(){
		
		loopshowNowTime();
		
		// 기본으로 전체게시판 글 목록 불러오기
		integratedBoard();
		
		// 기본으로 받은 쪽지함 불러오기
		receivedAndSendNote(1);
		
		// 로그인 기록
		$.ajax({
			url:"<%= ctxPath%>/index/getLoginHistory.os",
			data:{"fk_emp_no":"${sessionScope.loginemp.emp_no}"},
			dataType:"JSON",
			success:function(json){
				
		        if(json.length > 0) {
					var html = "";
					
					$.each(json, function(index, item){
						html += "<tr>" +
									"<td class='time' style='color: #333; font-size: 11px; padding: 8px 5px 8px 21px;'>"+item.logindate+"</td>" +
									"<td class='ip' style='#999;'>"+item.emp_ip+"</td>" +
								"</tr>";
					});
					
					$("tbody#loginHistory").html(html);
			    }
		        
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax({})-----------------------
		
		
		// 결제할 문서 수
		$.ajax({
			url:"<%= ctxPath%>/index/getElecApprovalCount.os",
			data:{"fk_emp_no":"${sessionScope.loginemp.emp_no}"},
			dataType:"JSON",
			success:function(json){
				$("span#approvalBadge").html(json.count);
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
		// 오늘 일정 수
		$.ajax({
			url:"<%= ctxPath%>/index/getScheduleCount.os",
			data:{"fk_emp_no":"${sessionScope.loginemp.emp_no}"},
			dataType:"JSON",
			success:function(json){
				$("span#calendarBadge").html(json.count);
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
		
		// 근무 시간
		$.ajax({
			url:"<%= ctxPath%>/index/getThisWeekWorkTime.os",
			data:{"fk_emp_no":"${sessionScope.loginemp.emp_no}"},
			dataType:"JSON",
			success:function(json){
				var hour = parseInt(json.total);
				var minute = (Number(json.total) - hour) * 60;
				
				$("span#workHour").html(hour);
				$("span#workMinute").html(minute);
				
				$("div#progress-bar").css("width", Number(json.total) / 52 * 100 + "%");
				$("div#progress-bar").prop("aria-valuenow", Number(json.total) / 52 * 100);
				
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
		
		// ToDo
		$.ajax({
			url:"<%= ctxPath%>/index/getToDoList.os",
			data:{"fk_emp_no":"${sessionScope.loginemp.emp_no}"},
			dataType:"JSON",
			success:function(json){
				
				if(json.length > 0) {
					var html = "";
					
					$.each(json, function(index, item){
						html += "<div class='board_card cardItem'>" +
									"<div class='title'><span class='txt'>"+item.subject+"</span></div>" +
								"</div>";
					});// end of $.each(json, function(){})--------------------
					
					$("div#card_todo_card").html(html);
				}// end of if(json.length > 0) {}----------------------
				
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	});// end of $(document).ready(function(){})----------------------
	
	// 현재 시간
	function showNowTime() {
		
		var now = new Date();
		
		var month = now.getMonth() + 1;
		
		if(month < 10) {
			month = "0" + month;
		}// end of if(month < 10) {}----------------------
		
		var date = now.getDate();
		
		if(date < 10) {
			date = "0" + date;
		}// end of if(date < 10) {}--------------------
		
		var week = new Array('일', '월', '화', '수', '목', '금', '토');
		var dayOfWeek = now.getDay();
		
		var strNow = now.getFullYear() + "년" + month + "월" + date + "일" + "(" + week[dayOfWeek] + ")";
		$("span#timelineGadgetDate").html(strNow);
		
		var hour = "";
		
		if(now.getHours() < 10) {
			hour = "0" + now.getHours();
		} else {
			hour = now.getHours();
		}// end of if(now.getHours() < 10) {}----------------------
		
		var minute = "";
		
		if(now.getMinutes() < 10) {
			minute = "0" + now.getMinutes();
		} else {
			minute = now.getMinutes();
		}// end of if(now.getMinutes() < 10) {}----------------------
		
		var second = "";
		
		if(now.getSeconds() < 10) {
			second = "0" + now.getSeconds();
		} else {
			second = now.getSeconds();
		}// end of if(now.getSeconds < 10) {} --------------------
		
		var strTime = hour + ":" + minute + ":" + second;
		$("span#timelineGadgetTime").html(strTime);
	   
	}// end of function showNowTime() -----------------------------
	
	// 반복
	function loopshowNowTime() {
		
		showNowTime();
		
		var timejugi = 1000;
		
		setTimeout(function(){
			loopshowNowTime();
		}, timejugi);
	      
	}// end of function loopshowNowTime() {} --------------------------
	
	
	// 게시판
	// 전체 게시판
	function integratedBoard() {
		
		$.ajax({
			url:"<%= ctxPath%>/index/getIntegratedBoard.os",
			dataType:"JSON",
			success:function(json){
				
				if(json.length > 0) {
					var html = "";
					
					$.each(json, function(index, item){
						html += "<li class='info board integrated'>" +
									"<div class='info'>" +
										"<p class='subject article'>" +
											"<input type='hidden' name='seq' value='"+item.seq+"' />";
											if(item.tblname == "일반게시판") {
												html += "<a href='<%= ctxPath%>/boardView.os?seq="+item.seq+"&gobackURL='";
											} else {
												html += "<a href='<%= ctxPath%>/noticeView.os?seq="+item.seq+"&gobackURL='";
											}
						html +=				" style='color: #333; font-size: 14px; cursor: pointer;'>"+item.title+"</a>" +
										"</p>" +
										"<span class='date' style='color: #919191; font-size: 12px; margin: 0 7px 0 0;'>"+item.writeday+"</span> " +
										"<span class='name' style='color: #919191; font-size: 12px; margin: 0 4px 0 0;'>"+item.writer+"</span>" +
										"<span class='category'>" +
											"<span style='color: #EBEBEB; font-size: 13px;'>|</span>" +
											"<a class='board_link' data-bypass='true' style='color: #999; font-size: 12px; margin: 0 0 0 2px;'>"+item.tblname+"</a>" +
										"</span>" +
									"</div>" +
								"</li>";
					});// end of $.each(json, function(){})--------------------
					
					$("ul#postList").html(html);
				} else {
					$("ul#postList").html("<span style='color: #333; font-size: 14px;'>게시글이 없습니다.</span>");
				}// end of if(json.length > 0) {}----------------------

				// 선택한 게시판을 표시한다.
				$("li.board_menu").removeClass("whereBoard");
				$("li#board_1").addClass("whereBoard");
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax({})----------------------
		
	}// end of function integratedBoard() {}-------------------------
	
	// 공지 게시판
	function noticeBoard() {
		
		$.ajax({
			url:"<%= ctxPath%>/index/getNoticeBoard.os",
			dataType:"JSON",
			success:function(json){
				
				if(json.length > 0) {
					var html = "";
					
					$.each(json, function(index, item){
						html += "<li class='info board integrated'>" +
									"<div class='info'>" +
										"<p class='subject article'>" +
											"<input type='hidden' name='seq' value='"+item.seq+"' />" +
											"<a href='<%= ctxPath%>/noticeView.os?seq="+item.seq+"&gobackURL=' data-type='preview' data-link='goPost' preview-data='"+item.content+"' style='color: #333; font-size: 14px; cursor: pointer;'>"+item.title+"</a>" +
										"</p>" +
										"<span class='date' style='color: #919191; font-size: 12px; margin: 0 7px 0 0;'>"+item.writeday+"</span> " +
										"<span class='name' style='color: #919191; font-size: 12px; margin: 0 4px 0 0;'>"+item.writer+"</span>" +
									"</div>" +
								"</li>";
					});// end of $.each(json, function(){})--------------------
					
					$("ul#postList").html(html);
				} else {
					$("ul#postList").html("<span style='color: #333; font-size: 14px;'>게시글이 없습니다.</span>");
				}// end of if(json.length > 0) {}----------------------
				
				// 선택한 게시판을 표시한다.
				$("li.board_menu").removeClass("whereBoard");
				$("li#board_2").addClass("whereBoard");
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax({})----------------------
		
	}// end of function generalBoard() {}------------------------
	
	// 일반 게시판
	function generalBoard() {
		
		$.ajax({
			url:"<%= ctxPath%>/index/getGeneralBoard.os",
			dataType:"JSON",
			success:function(json){
				
				if(json.length > 0) {
					var html = "";
					
					$.each(json, function(index, item){
						html += "<li class='info board integrated'>" +
									"<div class='info'>" +
										"<p class='subject article'>" +
											"<input type='hidden' name='seq' value='"+item.seq+"' />" +
											"<a href='<%= ctxPath%>/boardView.os?seq="+item.seq+"&gobackURL=' data-type='preview' data-link='goPost' preview-data='"+item.content+"' style='color: #333; font-size: 14px; cursor: pointer;'>"+item.title+"</a>" +
										"</p>" +
										"<span class='date' style='color: #919191; font-size: 12px; margin: 0 7px 0 0;'>"+item.writeday+"</span> " +
										"<span class='name' style='color: #919191; font-size: 12px; margin: 0 4px 0 0;'>"+item.writer+"</span>" +
									"</div>" +
								"</li>";
					});// end of $.each(json, function(){})--------------------
					
					$("ul#postList").html(html);
				} else {
					$("ul#postList").html("<span style='color: #333; font-size: 14px;'>게시글이 없습니다.</span>");
				}// end of if(json.length > 0) {}----------------------
				
				// 선택한 게시판을 표시한다.
				$("li.board_menu").removeClass("whereBoard");
				$("li#board_3").addClass("whereBoard");
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax({})----------------------
		
	}// end of function generalBoard() {}------------------------
	
	// 자료 게시판
	function fileBoard() {
		
		$.ajax({
			url:"<%= ctxPath%>/index/getFileBoard.os",
			dataType:"JSON",
			success:function(json){
				
				if(json.length > 0) {
					var html = "";
					
					$.each(json, function(index, item){
						html += "<li class='info board integrated'>" +
									"<div class='info'>" +
										"<p class='subject article'>" +
											"<input type='hidden' name='seq' value='"+item.seq+"' />" +
											"<a href='<%= ctxPath%>/filedownload.os?seq="+item.seq+"' data-type='preview' data-link='goPost' preview-data='"+item.filename+"' style='color: #333; font-size: 14px; cursor: pointer;'>"+item.filename+"</a>" +
										"</p>" +
										"<span class='date' style='color: #919191; font-size: 12px; margin: 0 7px 0 0;'>"+item.writeday+"</span> " +
										"<span class='name' style='color: #919191; font-size: 12px; margin: 0 4px 0 0;'>"+item.writer+"</span>" +
									"</div>" +
								"</li>";
					});// end of $.each(json, function(){})--------------------
					
					$("ul#postList").html(html);
				} else {
					$("ul#postList").html("<span style='color: #333; font-size: 14px;'>게시글이 없습니다.</span>");
				}// end of if(json.length > 0) {}----------------------
				
				// 선택한 게시판을 표시한다.
				$("li.board_menu").removeClass("whereBoard");
				$("li#board_4").addClass("whereBoard");
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax({})----------------------
		
	}
	
	
	// 쪽지
	// 받은 쪽지함 & 보낸 쪽지함 & 중요 쪽지함 & 임시 쪽지함
	function receivedAndSendNote(index) {
		$.ajax({
			url:"<%= ctxPath%>/index/getReceivedAndSendNote.os",
			data:{"fk_emp_no":"${sessionScope.loginemp.emp_no}",
				  "index":index},
			dataType:"JSON",
			success:function(json){
				
				if(json.length > 0) {
					var html = "";
					
					$.each(json, function(idx, item){
						html += "<li class='integrated' folder='Inbox' uid='132'>" +
									"<input type='hidden' name='note_no' value='"+item.note_no+"' />" +
									"<p class='name' style='display: inline-block;'><span>"+item.fk_emp_name_send+"</span></p>&nbsp;&nbsp;&nbsp;" +
									"<div class='info' style='display: inline-block;'>" +
										"<p class='' style='display: inline-block;'> ";
										if(index == 1) {
											html += "<a href='<%= ctxPath%>/jieun/note/receiveOneDetail.os?note_no="+item.note_no+"&goBackURL=jieun%2Fnote%2FreceiveList.os'";
										} else if(index == 2) {
											html += "<a href='<%= ctxPath%>/jieun/note/sendOneDetail.os?note_no="+item.note_no+"&goBackURL=jieun%2Fnote%2FsendList.os'";
										} else if(index == 3) {
											html += "<a href='<%= ctxPath%>/jieun/note/importantOneDetail.os?note_no="+item.note_no+"&goBackURL=jieun%2Fnote%2FimportantList.os'";
										} else {
											html += "<a href='<%= ctxPath%>/jieun/note/writeModify.os?note_no="+item.note_no+"'";
										}
						html +=			" data-bypass='true' data-type='preview' preview-data='"+item.note_content+"' style='cursor: pointer;'>"+item.note_title+"</a></p>" +
									"</div>" +
									"<span class='date' style='float: right; font-size: 12px;'>"+item.note_write_date+"</span>" +
								"</li>";
					});// end of $.each(json, function(){})--------------------
					
					$("ul#noteList").html(html);
				} else {
					$("ul#noteList").html("<p class='' style='display: inline-block; padding: 6px 36px 6px 21px;'>메일이 없습니다.</p>");
				}// end of if(json.length > 0) {}----------------------
				
				// 선택한 게시판을 표시한다.
				$("li.note_menu").removeClass("whereNote");
				$("li#note_"+index).addClass("whereNote");
			},
			error:function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}// end of function receivedAndSendNote() {}-----------------------

</script>

<div id="go-dashboard-10" class="go-dashboard go_dashboard_5_1">
	<!-- 1 block -->
	<div class="col-lg-3 go-gadget-column gadget-col-1 gadget_section1 layout_fixed" id="section_1" data-columnid="1">
		<div class="go-gadget go-gadget-17">
			<!-- <div class="go-gadget-header go_gadget_header">
				<div class="gadget_h1">
					<span class="title">투데이 프로필</span>
					<span class="btn-mgmt btn_side_wrap">
						<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
						<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
					</span>
				</div>
			</div> -->
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<div class="go-gadget-content">
				<div class="gadget_design_wrap left_section">
					<div class="profile">
						<span class="photo">
							<c:choose>
								<c:when test="${not empty sessionScope.loginemp.photo_route}"><img src="<%= ctxPath%>/resources/images/${sessionScope.loginemp.photo_route}" class="emp_photo" title="${sessionScope.loginemp.emp_name}"></c:when>
								<c:otherwise><img src="<%= ctxPath%>/resources/images/photo_profile_small.jpg" class="emp_photo" title="${sessionScope.loginemp.emp_name}"></c:otherwise>
							</c:choose>
						</span>
						<br>
						<span class="info">
							<span class="profileInfo emp_name" title="${sessionScope.loginemp.emp_name}">${sessionScope.loginemp.emp_name}</span>
							<span class="profileInfo position_name">${sessionScope.loginemp.position_name}</span>
							<br>
							<span class="company">(주)오성</span>
						</span>
					</div>
					<ul class="type_simple_list today_list">
						<li class="summary-approval today_list">
							<a href="<%=ctxPath %>/elecapproval/waiting.os" data-bypass="true">
								<span class="type">
									<span class="ic_dashboard2 ic_type_approval" title="approval"></span>
								</span>
								<span class="txt">결재할 문서</span>
								<span class="badge badge_zero mybadge" id="approvalBadge">0</span>
							</a>
						</li>
						<li class="summary-calendar today_list">
							<a href="<%=ctxPath %>/goCalendar.os" data-bypass="true">
								<span class="type">
									<span class="ic_dashboard2 ic_type_cal" title="calendar"></span>
								</span>
								<span class="txt">오늘의 일정</span>
								<span class="badge mybadge" id="calendarBadge">8</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="go-gadget go-gadget-21">
			<!-- <div class="go-gadget-header go_gadget_header">
				<div class="gadget_h1">
					<span class="title">Quick Menu</span>
					<span class="btn-mgmt btn_side_wrap">
						<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
						<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
					</span>
				</div>
			</div> -->
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<div class="go-gadget-content" style="border: none;">
				<div class="gadget_design_wrap left_section">
					<ul class="type_btn_list_block" id="btn_list_block">
						<li class="odd btn_list_li" style="border-top-left-radius: 5px;">
							<a href="<%= ctxPath%>/jieun/note/write.os" data-bypass="true" data-popup="width=1024,height=790,scrollbars=yes,resizable=yes">
								<span class="type">
									<img src="<%= ctxPath%>/resources/images/030-envelope.png" class="ic_dashboard" />
								</span>
								<span class="txt">쪽지쓰기</span>
							</a>
						</li>
						<li class="even btn_list_li" style="border-top-right-radius: 5px;">
							<a href="<%= ctxPath%>/employee/idv_addressbook.os" data-bypass="true">
								<span class="type">
									<img src="<%= ctxPath%>/resources/images/009-phone book.png" class="ic_dashboard" />
								</span>
								<span class="txt">연락처 추가</span>
							</a>
						</li>
						<br><br>
						<li class="odd btn_list_li" style="border-bottom-left-radius: 5px;">
							<a href="<%= ctxPath%>/goCalendar.os" data-bypass="true">
								<span class="type">
									<img src="<%= ctxPath%>/resources/images/040-inbox.png" class="ic_dashboard" />
								</span>
								<span class="txt">일정등록</span>
							</a>
						</li>
						<li class="even btn_list_li" style="border-bottom-right-radius: 5px;">
							<a href="<%= ctxPath%>/boardList.os?fk_dept_no=${sessionScope.loginemp.fk_dept_no}" data-bypass="true">
								<span class="type">
									<img src="<%= ctxPath%>/resources/images/049-check list.png" class="ic_dashboard" />
								</span>
								<span class="txt">게시글작성</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="go-gadget go-gadget-30">
			<!-- <div class="go-gadget-header go_gadget_header">
				<div class="gadget_h1">
					<span class="title">근태관리</span>
					<span class="btn-mgmt btn_side_wrap">
						<span class="btn-edit btn_wrap">
							<span class="ic_dashboard2 ic_d_mgmt" title="편집"></span>
						</span>
						<span class="btn-remove btn_wrap">
							<span class="ic_dashboard2 ic_d_delete" title="삭제"></span>
						</span>
					</span>
				</div>
			</div> -->
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<div class="go-gadget-content timeline_contents_wrap">
				<div class="gadget_design_wrap left_section" id="attendTable">						
					<div class="go-gadget-header go_gadget_header">							
						<div class="gadget_h1">								
							<span class="type">
								<span class="ic_dashboard2 ic_type_attend" title="근태관리"></span>
							</span>								
							<span class="title">근태관리</span>							
						</div>						
					</div>						
					<div class="attend_contents_wrap2">								
						<p class="txt"> 
							<span id="timelineGadgetDate"></span>&nbsp;
							<span class="time" id="timelineGadgetTime"></span>
						</p>	                                                  
						<div class="ehr_stat_data summary">                             
							<p class="stat_tit" id="workTime"><span id="workHour"></span><b>h</b> <span id="workMinute"></span><b>m</b></p>                             
							<div class="type_flexible_summary">                                 
								<div class="wrap_progress" id="wrap_progress">                                     
									<div class="time min" id="timemin" title="주간 근무시간은 40h입니다." style="left:76%">최소 40h</div>                                     
									<div class="bar" id="bar" style="left:70%"></div>                                     
									<div class="time max" id="timemax" title="최대 근무시간은 52h입니다.">최대 52h</div>  
									<div class="progress" style="background-color: #E9E9E9; width: 269px; height: 10px;">                                   
										<div class="progress-bar" id="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="background-color: #44D1A5;">                                         
											<div class="part_default" title="선택근무" style="width:0%"></div>                                         
											<div class="part_overtime" title="초과근무(연장)" style="width:0%"></div>                                     
										</div>              
									</div>                   
								</div>                             
							</div>                         
						</div>                                                  							
						<!-- <div class="log_view_wrap">								
							<ul class="log_view">									
								<li>                                     
									<dl>                                         
										<dt>출근시간</dt>                                         
										<dd id="workInTime">10:07:54</dd>                                     
									</dl>									
								</li>									
								<li>                                     
									<dl>                                         
										<dt>퇴근시간</dt>                                         
										<dd id="workOutTime">10:07:57</dd>                                     
										<dl>									</dl>
									</dl>
								</li>                                 								
							</ul>							
						</div> -->							
						<!-- <div class="vertical_bar"></div>								
						<section class="function function_attend">							    
							<div class="function_btn_wrap">								    
								<a id="workIn" class="btn_function btn_function_s off" data-bypass="true">									    
									<span class="txt">출근하기</span>								    
								</a>								    
								<a id="workOut" class="btn_function btn_function_s off" data-bypass="true">									    
									<span class="txt">퇴근하기</span>								    
								</a>							    
							</div>							    
							<div class="works_state">                                 
								<a class="btn_function" id="changeStatus" data-bypass="true">                                     
									<span class="txt" id="myStatus">업무&nbsp;&nbsp;
										<span class="ic_side ic_show_down"></span>
									</span>                                 
								</a>							    
							</div>									
							<div class="layer_transition" id="layer_transition" style="z-index: 100;display: none;">									
								<div class="ui-menu-container container">										
									<div class="content">											
										<div class="row_wrap menuitem my-todo-list foldable">												
											<ul class="submenu-list statusList">
												<li class="timelineStatus">
													<span class="txt " data-code="3">업무</span>
												</li>
												<li class="timelineStatus">
													<span class="txt " data-code="4">업무종료</span>
												</li>
												<li class="timelineStatus">
													<span class="txt " data-code="5">외근</span>
												</li>
												<li class="timelineStatus">
													<span class="txt " data-code="6">출장</span>
												</li>
												<li class="timelineStatus">
													<span class="txt " data-code="30">반차</span>
												</li>
											</ul>											
										</div>											
										<hr>										
									</div>									
								</div>                                 
							</div>							
						</section> -->							
					</div>					
				</div>
			</div>
		</div>
		<div class="go-gadget go-gadget-15">
			<!-- <div class="go-gadget-header go_gadget_header">
				<div class="gadget_h1">
					<span class="title">캘린더</span>
					<span class="btn-mgmt btn_side_wrap">
						<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
						<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
					</span>
				</div>
			</div> -->
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<!-- <div class="go-gadget-content">
		
				<div class="gadget_design_wrap">
					<div class="layer_normal layer_calendar">
						<header>
						    <div id="prev_month" class="critical">
						        <span class="btn_wrap">
						            <span class="ic ic_prev2" data-role="button" title="이전"></span>
						        </span>
						    </div>
	    					<h1 class="date">2020. 12</h1>
						    <div id="next_month" class="optional">
						        <span class="btn_wrap">
						            <span class="ic ic_next2" data-role="button" title="다음"></span>
						        </span>
						    </div>
							<span id="go_to_event_create" class="btn_formal">
								<span title="추가" class="ic_con ic_create_calendar"></span>
						    </span>
						</header>
						<table class="tb_calendar_mini">
						    <thead>
						        <tr>
						            <th class="sun">일</th>
						            <th>월</th>
						            <th>화</th>
						            <th>수</th>
						            <th>목</th>
						            <th>금</th>
						            <th>토</th>
						        </tr>
						    </thead>
						    <tbody>
						    <tr><td class="sun other_month past "><span id="2020-11-29T00:00:00.000+09:00">29</span></td><td class="other_month past "><span id="2020-11-30T00:00:00.000+09:00">30</span></td><td class="past "><span id="2020-12-01T00:00:00.000+09:00">1<span class="badge">1</span></span></td><td class="past "><span id="2020-12-02T00:00:00.000+09:00">2</span></td><td class="past "><span id="2020-12-03T00:00:00.000+09:00">3<span class="badge">1</span></span></td><td class="past "><span id="2020-12-04T00:00:00.000+09:00">4</span></td><td class="past "><span id="2020-12-05T00:00:00.000+09:00">5</span></td></tr><tr><td class="sun past "><span id="2020-12-06T00:00:00.000+09:00">6</span></td><td class="past "><span id="2020-12-07T00:00:00.000+09:00">7</span></td><td class="past "><span id="2020-12-08T00:00:00.000+09:00">8</span></td><td class="past "><span id="2020-12-09T00:00:00.000+09:00">9<span class="badge">1</span></span></td><td class="past "><span id="2020-12-10T00:00:00.000+09:00">10<span class="badge">1</span></span></td><td class="past "><span id="2020-12-11T00:00:00.000+09:00">11</span></td><td class="past "><span id="2020-12-12T00:00:00.000+09:00">12</span></td></tr><tr><td class="sun past "><span id="2020-12-13T00:00:00.000+09:00">13</span></td><td class="past "><span id="2020-12-14T00:00:00.000+09:00">14</span></td><td class="past "><span id="2020-12-15T00:00:00.000+09:00">15</span></td><td class="past "><span id="2020-12-16T00:00:00.000+09:00">16</span></td><td class="past "><span id="2020-12-17T00:00:00.000+09:00">17<span class="badge">1</span></span></td><td class="past "><span id="2020-12-18T00:00:00.000+09:00">18</span></td><td class="past "><span id="2020-12-19T00:00:00.000+09:00">19</span></td></tr><tr><td class="sun past "><span id="2020-12-20T00:00:00.000+09:00">20</span></td><td class="past "><span id="2020-12-21T00:00:00.000+09:00">21</span></td><td class="on "><span id="2020-12-22T00:00:00.000+09:00">22<span class="badge">8</span></span></td><td class=""><span id="2020-12-23T00:00:00.000+09:00">23<span class="badge">6</span></span></td><td class=""><span id="2020-12-24T00:00:00.000+09:00">24<span class="badge">5</span></span></td><td class="holiday_on "><span id="2020-12-25T00:00:00.000+09:00">25<span class="badge">4</span></span></td><td class=""><span id="2020-12-26T00:00:00.000+09:00">26<span class="badge">4</span></span></td></tr><tr><td class="sun "><span id="2020-12-27T00:00:00.000+09:00">27<span class="badge">4</span></span></td><td class=""><span id="2020-12-28T00:00:00.000+09:00">28<span class="badge">6</span></span></td><td class=""><span id="2020-12-29T00:00:00.000+09:00">29<span class="badge">4</span></span></td><td class=""><span id="2020-12-30T00:00:00.000+09:00">30<span class="badge">3</span></span></td><td class=""><span id="2020-12-31T00:00:00.000+09:00">31<span class="badge">4</span></span></td><td class="other_month holiday_on "><span id="2021-01-01T00:00:00.000+09:00">1<span class="badge">3</span></span></td><td class="other_month "><span id="2021-01-02T00:00:00.000+09:00">2<span class="badge">3</span></span></td></tr></tbody>
						</table>
					</div>
					<ul class="briefing_list">
						<li class=" today">
							<span class="ic_side ic_today" title="today"></span>
							<div class="title">
								<p class="date">22</p>
								<p class="day">화요일</p>
							</div>
							<ul class="item ">
							    <li>
							        <a class="event" data-calendarid="560" data-eventid="820" data-bypass="true">
							            <p class="subject">SSG 행사</p>
							            <p class="time">12:00 ~ 계속</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="818" data-bypass="true">
							            <p class="subject">쿠팡 거래명세서, 세금계산서 확인 및 승인</p>
							            <p class="time">09:30 ~ 10:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="811" data-bypass="true">
							            <p class="subject">연봉테이블 폼 정리</p>
							            <p class="time">10:00 ~ 12:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="819" data-bypass="true">
							            <p class="subject">개인, 개별 입금확인 및 지출건 결제</p>
							            <p class="time">13:00 ~ 14:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="812" data-bypass="true">
							            <p class="subject">연봉테이블 폼 정리</p>
							            <p class="time">14:00 ~ 16:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="814" data-bypass="true">
							            <p class="subject">정책자금 확인/ 컨설팅 지원금 해당기업확인</p>
							            <p class="time">16:00 ~ 17:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="815" data-bypass="true">
							            <p class="subject">2021년 매출채권/매출현황 폼 정리</p>
							            <p class="time">17:00 ~ 18:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="816_1608627600000" data-bypass="true">
							            <p class="subject">자금일보 마감</p>
							            <p class="time">18:00 ~ 18:30</p>
							        </a>
							    </li>
							</ul>
						</li>
						<li class="">
							<div class="title">
								<p class="date">23</p>
								<p class="day">수요일</p>
							</div>
							<ul class="item ">
							    <li>
							        <a class="event" data-calendarid="560" data-eventid="820" data-bypass="true">
							            <p class="subject">SSG 행사</p>
							            <p class="time">계속 ~ 계속</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="810_1608683400000" data-bypass="true">
							            <p class="subject">쿠팡 거래명세서, 세금계산서 확인 및 승인</p>
							            <p class="time">09:30 ~ 10:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="813_1608696000000" data-bypass="true">
							            <p class="subject">개인, 개별 입금확인 및 지출건 결제</p>
							            <p class="time">13:00 ~ 14:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="621_1608705000000" data-bypass="true">
							            <p class="subject">DO사용자 월간세미나</p>
							            <p class="time">15:30 ~ 16:30</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="630_1608712200000" data-bypass="true">
							            <p class="subject">경영지원본부 팀커뮤니케이션</p>
							            <p class="time">17:30 ~ 18:30</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="816_1608714000000" data-bypass="true">
							            <p class="subject">자금일보 마감</p>
							            <p class="time">18:00 ~ 18:30</p>
							        </a>
							    </li>
							</ul>
						</li>
						<li class="">
							<div class="title">
								<p class="date">24</p>
								<p class="day">목요일</p>
							</div>
							<ul class="item ">
							    <li>
							        <a class="event" data-calendarid="560" data-eventid="820" data-bypass="true">
							            <p class="subject">SSG 행사</p>
							            <p class="time">계속 ~ 계속</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="810_1608769800000" data-bypass="true">
							            <p class="subject">쿠팡 거래명세서, 세금계산서 확인 및 승인</p>
							            <p class="time">09:30 ~ 10:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="813_1608782400000" data-bypass="true">
							            <p class="subject">개인, 개별 입금확인 및 지출건 결제</p>
							            <p class="time">13:00 ~ 14:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="202" data-eventid="752_1608786000000" data-bypass="true">
							            <p class="subject">임원 정기 회의</p>
							            <p class="time">14:00 ~ 15:00</p>
							        </a>
							    </li>
							    <li>
							        <a class="event" data-calendarid="342" data-eventid="816_1608800400000" data-bypass="true">
							            <p class="subject">자금일보 마감</p>
							            <p class="time">18:00 ~ 18:30</p>
							        </a>
							    </li>
							</ul>
						</li>
					</ul>
				</div>
			</div> -->
		</div>
	</div>

	<div class="col-lg-9 gadget_layout_wrapper" id="section_2">
		<!-- 2 block -->
		<div class="col-lg-9 gadget_layout_wrapper2" id="section_2_1">
			<div class="gadget_layout_wrapper3">
				<div class="go-gadget-column gadget-col-2 gadget_section2" data-columnid="2">
					<div class="go-gadget go-gadget-19">
						<!-- <div class="go-gadget-header go_gadget_header">
							<div class="gadget_h1">
								<span class="title">전사게시판 최근글</span>
								<span class="btn-mgmt btn_side_wrap">
									<span class="btn-edit btn_wrap">
										<span class="ic_dashboard2 ic_d_mgmt" title="편집"></span>
									</span>
									<span class="btn-remove btn_wrap">
										<span class="ic_dashboard2 ic_d_delete" title="삭제"></span>
									</span>
								</span>
							</div>
						</div> -->
						<div class="go-gadget-config gadget_edit" style="display:none">
							<p class="desc">
								<span class="txt_caution error-msg-wrapper"></span>
							</p>
							<form name="gadget_options" class="gadget-options-form"></form>
							<footer class="btn_layer_wrap">
								<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
								<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
							</footer>
						</div>
						<div class="go-gadget-content content-section-2">
							<div data-cid="view73">
								<div class="gadget_design_wrap gadget_board_wrap">
									<div class="go_gadget_header">
						    			<div class="gadget_h1">
						        			<span class="type">
						        				<span class="ic_dashboard2 ic_type_bbs" title="전사게시판 최근글"></span>
						        			</span>
						        			<span class="title">전사게시판 최근글</span>
						    			</div>
									</div>
									<div class="design_content_header">
										<div class="tab_control tab_btn_prev tab_disabled">
											<span class="btn_wrap">
												<span class="ic_prev" title="이전"></span>
											</span>
										</div>
										<div id="gadget_tabs" class="swipe gadget_tab_wrap" style="visibility: visible;">
											<div class="swipe-wrap" style="width: 596px;">
												<div data-index="0" style="width: 596px; left: 0px; transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
													<ul class="dashboard_tab gadget_tab">
														<li class="on board_menu" id="board_1" data-type="250">
															<a data-bypass="" title="전체" onclick="integratedBoard();">전체</a>
														</li>
														<li class="on board_menu" id="board_2" data-type="250">
															<a data-bypass="" title="전사 공지" onclick="noticeBoard();">전사 공지</a>
														</li>
														<li class="on board_menu" id="board_3" data-type="250">
															<a data-bypass="" title="일반 게시판" onclick="generalBoard();">일반 게시판</a>
														</li>
														<li class="on board_menu" id="board_4" data-type="250">
															<a data-bypass="" title="자료 게시판" onclick="fileBoard();">자료 게시판</a>
														</li>
													</ul>
													<hr>
												</div>
											</div>
										</div>
									</div>
									<ul class="type_simple_list simple_list_notice" id="postList">
									</ul>
									<div class="tool_bar tool_absolute" id="pageControl">
										<div class="dataTables_paginate paging_full_numbers">
											<a class="previous paginate_button_disabled" data-value="-1" data-type="prev" id="prev" data-bypass="true"></a>
											<a class="next paginate_button_disabled" data-value="1" data-type="next" id="next" data-bypass="true"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="go-gadget go-gadget-51 gadget_design_border">
						<!-- <div class="go-gadget-header go_gadget_header">
							<div class="gadget_h1">
								<span class="title">Works app - 차트형</span>
								<span class="btn-mgmt btn_side_wrap">
									<span class="btn-edit btn_wrap">
										<span class="ic_dashboard2 ic_d_mgmt" title="편집"></span>
									</span>
									<span class="btn-remove btn_wrap">
										<span class="ic_dashboard2 ic_d_delete" title="삭제"></span>
									</span>
								</span>
							</div>
						</div> -->
						<div class="go-gadget-config gadget_edit" style="display:none">
							<p class="desc">
								<span class="txt_caution error-msg-wrapper"></span>
							</p>
							<form name="gadget_options" class="gadget-options-form"></form>
							<footer class="btn_layer_wrap">
								<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
								<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
							</footer>
						</div>
						<%-- <div class="go-gadget-content">
							<div class="gadget_design_wrap">
								<div class="go-gadget-header go_gadget_header">
									<div class="gadget_h1">
									<span class="type"><span class="ic_dashboard2 ic_type_todo" title=""></span></span>
									<span class="title">마케팅 비용 집행 현황판</span>
									</div>
								</div>
								<div class="dashboard_box dashboard_works" el-chart-wrapper="">
									<div class="bx-wrapper" style="max-width: 100%; margin: 0px auto;">
										<div class="" style="width: 100%; overflow: hidden; position: relative; height: 350px;">
											<div class="card_item_wrapper" style="width: 615%; position: relative; transition-duration: 0s; transform: translate3d(0px, 0px, 0px);">
												<section style="padding: 0px; float: left; list-style: none; position: relative; width: 552px;" class="card_item">
													<div class="card_wrapper" el-chart="" style="padding: 0px; height: 100%; -webkit-tap-highlight-color: transparent; user-select: none; position: relative;" _echarts_instance_="ec_1608615570191">
														<div style="position: relative; width: 552px; height: 350px; padding: 0px; margin: 0px; border-width: 0px;">
															<canvas data-zr-dom-id="zr_0" width="552" height="350" style="position: absolute; left: 0px; top: 0px; width: 552px; height: 350px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas>
														</div>
														<div></div>
													</div>
												</section>
												<section style="padding: 0px; float: left; list-style: none; position: relative; width: 552px;" class="card_item">
													<div class="card_wrapper" el-chart="" style="padding: 0px; height: 100%; -webkit-tap-highlight-color: transparent; user-select: none; position: relative;" _echarts_instance_="ec_1608615570190">
														<div style="position: relative; width: 552px; height: 350px; padding: 0px; margin: 0px; border-width: 0px;">
															<canvas data-zr-dom-id="zr_0" width="552" height="350" style="position: absolute; left: 0px; top: 0px; width: 552px; height: 350px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas>
														</div>
														<div></div>
													</div>
												</section>
												<section style="padding: 0px; float: left; list-style: none; position: relative; width: 552px;" class="card_item">
													<div class="card_wrapper" el-chart="" style="padding: 0px; height: 100%; -webkit-tap-highlight-color: transparent; user-select: none; position: relative;" _echarts_instance_="ec_1608615570192">
														<div style="position: relative; width: 552px; height: 350px; padding: 0px; margin: 0px; border-width: 0px;">
															<canvas data-zr-dom-id="zr_0" width="552" height="350" style="position: absolute; left: 0px; top: 0px; width: 552px; height: 350px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas>
														</div>
														<div></div>
													</div>
												</section>
												<section style="padding: 0px; float: left; list-style: none; position: relative; width: 552px;" class="card_item">
													<div class="card_wrapper" el-chart="" style="padding: 0px; height: 100%; -webkit-tap-highlight-color: transparent; user-select: none; position: relative;" _echarts_instance_="ec_1608615570189">
														<div style="position: relative; width: 552px; height: 350px; padding: 0px; margin: 0px; border-width: 0px;">
															<canvas data-zr-dom-id="zr_0" width="552" height="350" style="position: absolute; left: 0px; top: 0px; width: 552px; height: 350px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas>
														</div>
														<div></div>
													</div>
												</section>
											</div>
										</div>
										<div class="bx-controls bx-has-controls-direction" style="background-color: transparent;">
											<div class="bx-controls-direction">
												<a class="bx-prev disabled" href="javascript:void(0);" style="margin-top: -215px;">Prev</a>
												<a class="bx-next" href="javascript:void(0);" style="margin-top: -215px;">Next</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div> --%>
					</div>
					
					<div class="go-gadget go-gadget-25">
						<!-- <div class="go-gadget-header go_gadget_header">
							<div class="gadget_h1">
								<span class="title">메일 리스트</span>
								<span class="btn-mgmt btn_side_wrap">
									<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
									<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
								</span>
							</div>
						</div> -->
						<div class="go-gadget-config gadget_edit" style="display:none">
							<p class="desc">
								<span class="txt_caution error-msg-wrapper"></span>
							</p>
							<form name="gadget_options" class="gadget-options-form"></form>
							<footer class="btn_layer_wrap">
								<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
								<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
							</footer>
						</div>
						<div class="go-gadget-content content-section-2">
							<div class="gadget_design_wrap gadget_board_wrap">
								<div class="go_gadget_header">
									<div class="gadget_h1">
										<span class="type">
											<span class="ic_dashboard2 ic_type_mail" title="메일함"></span>
										</span>
										<span class="title">쪽지함</span>
									</div>
								</div>
								<div id="tab">
									<div class="design_content_header">
										<div class="tab_control tab_btn_prev tab_disabled">
											<span class="btn_wrap">
												<span class="ic_prev" title="이전"></span>
											</span>
										</div>
										<div id="gadget_tabs" class="swipe gadget_tab_wrap" style="visibility: visible;">
											<div class="swipe-wrap" style="width: 596px;">
												<div data-index="0" style="width: 596px; left: 0px; transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
													<ul class="dashboard_tab gadget_tab">
														<li class="on note_menu" id="note_1" data-type="folder/Inbox">
															<a data-bypass="" title="받은쪽지함" onclick="receivedAndSendNote(1);">받은쪽지함</a>
														</li>
														<li class="on note_menu" id="note_2" data-type="folder/Sent">
															<a data-bypass="" title="보낸쪽지함" onclick="receivedAndSendNote(2);">보낸쪽지함</a>
														</li>
														<li class="on note_menu" id="note_3" data-type="folder/Reserved">
															<a data-bypass="" title="중요쪽지함" onclick="receivedAndSendNote(3);">중요쪽지함</a>
														</li>
														<li class="on note_menu" id="note_4" data-type="quick/flaged">
															<a data-bypass="" title="임시쪽지함" onclick="receivedAndSendNote(4);">임시쪽지함</a>
														</li>
													</ul>
													<hr>
												</div>
											</div>
										</div>
										<div class="tab_control tab_btn_next tab_disabled">
											<span class="btn_wrap">
												<span class="ic_next" title="다음"></span>
											</span>
										</div>
									</div>
								</div>
								<div id="items">
									<div data-cid="view66">
										<ul class="mailList type_simple_list simple_list_mail" id="noteList">
										</ul>
										<div class="tool_bar tool_absolute">
											<div class="dataTables_paginate paging_full_numbers">
												<a data-bypass="true" class="previous paginate_button  paginate_button_disabled " title="이전"></a>
												<a data-bypass="true" class="next paginate_button  paginate_button_disabled " title="다음"></a>
											</div>
										</div>
									</div>
								</div>
								<div></div>
							</div>
						</div>
					</div>
					
					<div class="go-gadget go-gadget-27">
						<!-- <div class="go-gadget-header go_gadget_header">
							<div class="gadget_h1">
								<span class="title">최근 알림</span>
								<span class="btn-mgmt btn_side_wrap">
									<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
									<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
								</span>
							</div>
						</div> -->
						<div class="go-gadget-config gadget_edit" style="display:none">
							<p class="desc">
								<span class="txt_caution error-msg-wrapper"></span>
							</p>
							<form name="gadget_options" class="gadget-options-form"></form>
							<footer class="btn_layer_wrap">
								<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
								<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
							</footer>
						</div>
						<!-- <div class="go-gadget-content content-section-2">
							<div class="gadget_design_wrap">
								<div class="gadget_design_wrap">
									<div class="go_gadget_header">
										<div class="gadget_h1">
											<span class="type">
												<span class="ic_dashboard2 ic_type_alarm"></span>
											</span>
											<span class="title">최근 알림</span>
										</div>
									</div>
									<ul class="type_simple_list simple_list_alarm">
										<li>
											<p class="type">
												<span class="ic_gnb ic_type2_approval" title=""></span>
											</p>
											<p class="photo">
												<img src="/thumb/user/small/3493-17799" title="김지연 부장">
											</p>
											<div class="info">
											    <p class="subject">
											        <a href="https://master.daouoffice.com/tokenlogin?token=d048f829-e7c8-4d8d-b4a3-6c6d3d63b896&amp;companyId=&amp;returnUrl=%2Flink%2Fnoti%2F2272882" data-bypass="true">[참조자 등록] '김지연 부장'이(가) 작성한 '테스트'의 참조자로 등록되었습니다.</a>
											    </p>
											    <span class="date">1시간 전</span>
											    <p class="name">김지연 부장</p>
											</div>
											<span class="btn_wrap">
											    <span class="ic_con ic_list_more_n" title=""></span>
											</span>
										</li>
										<li>
											<p class="type">
												<span class="ic_gnb ic_type2_approval" title=""></span>
											</p>
											<p class="photo"><img src="/thumb/user/small/3493-17799" title="김지연 부장"></p>
											<div class="info">
											    <p class="">
											        <a href="https://master.daouoffice.com/tokenlogin?token=d048f829-e7c8-4d8d-b4a3-6c6d3d63b896&amp;companyId=&amp;returnUrl=%2Flink%2Fnoti%2F2272879" data-bypass="true">[참조자 등록] '김지연 부장'이(가) 작성한 'TEST'의 참조자로 등록되었습니다.</a>
											    </p>
											    <span class="date">1시간 전</span>
											    <p class="name">김지연 부장</p>
											</div>
											<span class="btn_wrap">
											    <span class="ic_con ic_list_more_n" title=""></span>
											</span>
										</li>
										<li>
											<p class="type"><span class="ic_gnb ic_type2_ehr" title=""></span></p>
											<p class="photo"><img src="/thumb/user/small/4301-212117" title="김상후 대표이사"></p>
											<div class="info">
											    <p class="">
											        <a href="https://master.daouoffice.com/tokenlogin?token=d048f829-e7c8-4d8d-b4a3-6c6d3d63b896&amp;companyId=&amp;returnUrl=%2Flink%2Fnoti%2F2272870" data-bypass="true">[알림] 운영자 확인이 필요한 근태 정보가 있습니다. 근태관리에서 확인하세요.</a>
											    </p>
											    <span class="date">4시간 전</span>
											    <p class="name">김상후 대표이사</p>
											</div>
											<span class="btn_wrap">
											    <span class="ic_con ic_list_more_n" title=""></span>
											</span>
										</li>
										<li>
											<p class="type"><span class="ic_gnb ic_type2_cal" title=""></span></p>
											<p class="photo"><img src="/thumb/user/small/4301-212117" title="김상후 대표이사"></p>
											<div class="info">
											    <p class="subject">
											        <a href="https://master.daouoffice.com/tokenlogin?token=d048f829-e7c8-4d8d-b4a3-6c6d3d63b896&amp;companyId=&amp;returnUrl=%2Flink%2Fnoti%2F2214337" data-bypass="true">[일정 알림] '주간피드백 미팅' 일정 알림입니다.</a>
											    </p>
											    <span class="date">12-01 11:30</span>
											    <p class="name">김상후 대표이사</p>
											</div>
											<span class="btn_wrap">
											    <span class="ic_con ic_list_more_n" title=""></span>
											</span>
										</li>
										<li>
											<p class="type"><span class="ic_gnb ic_type2_comm" title=""></span></p>
											<p class="photo"><img src="/thumb/user/small/4301-212117" title="김상후 대표이사"></p>
											<div class="info">
											    <p class="subject">
											        <a href="https://master.daouoffice.com/tokenlogin?token=d048f829-e7c8-4d8d-b4a3-6c6d3d63b896&amp;companyId=&amp;returnUrl=%2Flink%2Fnoti%2F2212340" data-bypass="true">[커뮤니티 생성] '독서합시다' 생성이 완료되었습니다.</a>
											    </p>
											    <span class="date">11-30 19:05</span>
											    <p class="name">김상후 대표이사</p>
											</div>
											<span class="btn_wrap">
											    <span class="ic_con ic_list_more_n" title=""></span>
											</span>
										</li>
									</ul>
								</div>
							</div>
						</div> -->
					</div>
				</div>
			</div>
			
			<div class="gadget_layout_wrapper4">
				<div class="go-gadget-column gadget-col-4 gadget_section2" data-columnid="4"></div>
				<div class="go-gadget-column gadget-col-5 gadget_section2" data-columnid="5"></div>
			</div>
		</div>
			
		<!-- 3 block -->
		<div class="col-lg-3 go-gadget-column gadget-col-3 gadget_section3 layout_fixed" id="section_2_2" data-columnid="3">
			<div class="go-gadget go-gadget-24 gadget_design_border">
				<!-- <div class="go-gadget-header go_gadget_header">
				<div class="gadget_h1">
					<span class="title">ToDO+</span>
					<span class="btn-mgmt btn_side_wrap">
						<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
						<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
					</span>
				</div>
			</div> -->
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<div class="go-gadget-content content-section-3">
				<div class="gadget_design_wrap">
					<div class="go-gadget-header go_gadget_header">
						<div class="gadget_h1">
						<span class="type"><span class="ic_dashboard2 ic_type_todo" title="예약"></span></span>
						<span class="title">ToDO+ 카드 목록</span>
						</div>
					</div>
					<div class="board_card_wrap">
						<div class="layout_left_wrap" id="card_todo_card">
							<!-- <div class="board_card cardItem" value="36">
								<div class="title"><span class="txt">그룹웨어 설문조사 eDM</span></div>
								<div class="meta_data">
									<span class="ic_wrap"> <span class="ic_board ic_comment_s"></span> <span class="txt">0</span> </span>
									<span class="ic_wrap"> <span class="ic_board ic_attach_s"></span> <span class="txt">2</span> </span>
								</div>
							</div>
							<div class="board_card cardItem" value="174">
								<div class="card_label">
										<span class="chip" style="background: #ee3b72"></span>
								</div>
								<div class="title"><span class="txt">2017년 2회 (2017.06.07)</span></div>
								<div class="meta_data">
									<span class="ic_wrap"> <span class="ic_board ic_comment_s"></span> <span class="txt">0</span> </span>
									<span class="ic_wrap"> <span class="ic_board ic_attach_s"></span> <span class="txt">5</span> </span>
								</div>
							</div>
							<div class="board_card cardItem" value="19">
								<div class="title"><span class="txt">기획담당자 인터뷰</span></div>
								<div class="meta_data">
									<span class="ic_wrap"> <span class="ic_board ic_comment_s"></span> <span class="txt">0</span> </span>
									<span class="ic_wrap"> <span class="ic_board ic_attach_s"></span> <span class="txt">1</span> </span>
								</div>
							</div> -->
						</div>
					</div>
					<div class="tool_bar tool_absolute">
					    <div class="dataTables_paginate paging_full_numbers">
					        <a data-bypass="true" class="previous paginate_button paginate_button_disabled btnDisable" title="이전"></a>
					        <a data-bypass="true" class="next paginate_button " title="다음"></a>
					    </div>
					</div>
				</div>
			</div>
		</div>
		<div class="go-gadget go-gadget-24">
			<!-- <div class="go-gadget-header go_gadget_header">
				<div class="gadget_h1">
					<span class="title">가입 커뮤니티 바로가기</span>
					<span class="btn-mgmt btn_side_wrap">
						<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
						<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
					</span>
				</div>
			</div> -->
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<!-- <div class="go-gadget-content content-section-3">	
				<div class="gadget_design_wrap">
					<div class="go_gadget_header">
					    <div class="gadget_h1">
					        <span class="type"><span class="ic_dashboard2 ic_type_comm" title="가입 커뮤니티 바로가기"></span></span>
					        <span class="title">가입 커뮤니티 바로가기</span>
					    </div>
					</div>
					<ul class="side_depth">
					    <li class="community" data-id="80" data-status="ONLINE" data-publicflag="true" data-memberstatus="ONLINE">
					        <p class="title">
					        <a data-bypass="true"><ins class="ic"></ins>
					        <span class="txt" title="YOLO DAOU">YOLO DAOU</span>
					        </a>
					        <span class="num">0/13</span>
					        </p>
					    </li>
					    <li class="community" data-id="60" data-status="ONLINE" data-publicflag="true" data-memberstatus="WAIT">
					        <p class="title">
					        <a data-bypass="true"><ins class="ic"></ins>
					        <span class="btn_state_disable"><span class="txt">가입대기</span></span><span class="txt" title="아이디어 공유">아이디어 공유</span>
					        </a>
					        <span class="num">0/1</span>
					        </p>
					    </li>
					    <li class="community" data-id="100" data-status="ONLINE" data-publicflag="true" data-memberstatus="ONLINE">
					        <p class="title">
					        <a data-bypass="true"><ins class="ic"></ins>
					        <span class="txt" title="독서합시다">독서합시다</span>
					        </a>
					        <span class="num">0/1</span>
					        </p>
					    </li>
					    <li class="community" data-id="11" data-status="ONLINE" data-publicflag="true" data-memberstatus="WAIT">
					        <p class="title">
					        <a data-bypass="true"><ins class="ic"></ins>
					        <span class="btn_state_disable"><span class="txt">가입대기</span></span><span class="txt" title="TRAVEL BAG">TRAVEL BAG</span>
					        </a>
					        <span class="num">0/34</span>
					        </p>
					    </li>
					    <li class="community" data-id="51" data-status="ONLINE" data-publicflag="false" data-memberstatus="WAIT">
					        <p class="title">
					        <a data-bypass="true"><ins class="ic"></ins>
					        <span class="btn_state_disable"><span class="txt">가입대기</span></span><span class="ic_side ic_private"></span><span class="txt" title="A-팀 프로젝트">A-팀 프로젝트</span>
					        </a>
					        <span class="num">0/44</span>
					        </p>
					    </li>
					    <li class="community" data-id="40" data-status="ONLINE" data-publicflag="false" data-memberstatus="WAIT">
					        <p class="title">
					        <a data-bypass="true"><ins class="ic"></ins>
					        <span class="btn_state_disable"><span class="txt">가입대기</span></span><span class="ic_side ic_private"></span><span class="txt" title="운동합시다">운동합시다</span>
					        </a>
					        <span class="num">0/0</span>
					        </p>
					    </li>
					</ul>
				</div>
			</div> -->
		</div>
			
			<div class="go-gadget go-gadget-24">
				<!-- <div class="go-gadget-header go_gadget_header">
					<div class="gadget_h1">
						<span class="title">가입 커뮤니티 바로가기</span>
						<span class="btn-mgmt btn_side_wrap">
							<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
							<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
						</span>
					</div>
				</div> -->
				<div class="go-gadget-config gadget_edit" style="display:none">
					<p class="desc">
						<span class="txt_caution error-msg-wrapper"></span>
					</p>
					<form name="gadget_options" class="gadget-options-form"></form>
					<footer class="btn_layer_wrap">
						<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
						<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
					</footer>
				</div>
				<div class="go-gadget-content content-section-3">
					<div class="gadget_design_wrap">
						<div class="go_gadget_header">
							<div class="gadget_h1">
							    <span class="type"><span class="ic_dashboard2 ic_type_login"></span></span>
							    <span class="title">최근 로그인 정보</span>
							</div>
						</div>
						<table class="type_normal table_fix gadget_login_info">
							<thead>
							    <tr>
							        <th class="time sorting_disabled" style="padding: 0 0 0 21px;"><span class="title_sort">일시</span></th>
							        <th class="ip sorting_disabled"><span class="title_sort">IP</span></th>
							    </tr>
							</thead>
							<tbody id="loginHistory">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>