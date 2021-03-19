<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<% String ctxPath = request.getContextPath(); %>    


<style type="text/css">
   #containerBox {
   		margin: 50px ;
   }
	
	#titleInBox{
		margin: 50px 30px 0 30px;
		display:inline-block;
	}
	
	#btnNewAppr{
		display:inline-block;
		
	}
	
	#waitingDoc {
		font-size: 14px;
		margin: 0 0 20px 0;
	}
	
	.docListTitle {
		font-weight: bold;
		font-size: 15px;
		margin: 50px 0 30px 0;
	}
	
	th{
		text-align: center;
		color: white;
	}
	
	.tblElecAppr {
		height: 35px;
	}
	
	.tblElecAppr > thead {
		background-color: #c5ccd3;
	}

	.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
	    padding: 8px;
	}
	
	.subjectStyle {font-weight: bold;
                   cursor: pointer;} 

</style>

<script type="text/javascript">

	$(document).ready(function(){

		$("span.subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
		
		$("span.subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
		
		getDate();
		getWorktimeno();
		
		
		/* 출퇴근입력 */
		$("button#btnSubmit").click(function(){
			
			// 폼(form)을 전송(submit)
			var frm = document.worktimeForm;

			frm.method = "POST";
			frm.action = "<%= ctxPath%>/attendance/submitWorktime.os";
			frm.submit();
		});
		
		
	});// end of $(document).ready(function(){})-------------------
	
	function goView(attendance_apply_no) {
			// === #124. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
			//           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
			//           현재 페이지 주소를 뷰단으로 넘겨준다.
			var frm = document.goViewFrm;
			frm.attendance_apply_no.value = attendance_apply_no;
			
			frm.method = "GET";
			frm.action = "<%= ctxPath%>/processingDetail.os";
			frm.submit();
		}// end of function goView(seq){}----------------------------------------------
	
		
		/* 오늘 날짜를 구하는 함수 */
		function getDate(){
			var d = new Date();
			
			var mm; 
			if( (d.getMonth() + 1) < 10 ) {
				mm = '0'+(d.getMonth() + 1);
			}else {
				mm = (d.getMonth() + 1) 
			}
			
			var dd;
			if( d.getDate() < 10 ) {
				dd = '0'+ d.getDate();
			}else {
				dd = d.getDate();
			}
			
			var dateText = d.getFullYear() + '-' + mm + '-' +  dd;
			$("#date").text(dateText);
		}
		
		/* worktime 테이블의 no값(오늘날짜yymmdd+사원번호: 6+7 13자리 )을 구하는 함수 */
		function getWorktimeno() {
			
			var d = new Date();
			
			var yy = d.getYear().toString().substr(-2);
			
			var mm; 
			if( (d.getMonth() + 1) < 10 ) {
				mm = '0'+(d.getMonth() + 1);
			}else {
				mm = (d.getMonth() + 1) 
			}
			
			var dd;	
			if( d.getDate() < 10 ) {
				dd = '0'+ d.getDate();
			}else {
				dd = d.getDate();
			}
			
			var worktimeno = Number(yy + mm + dd + "${empvo.emp_no}");
			
			$("#worktime_no").val(worktimeno);
			
		}
		
		function getWorktimehours() {
			
			var in_time = $("#in_time").val();
			var out_time = $("#out_time").val();
			
			var in_time_arr = in_time.split(':');
			var out_time_arr = out_time.split(':');
			
			hh = (out_time_arr[0] - in_time_arr[0]) ;
			mm = (out_time_arr[1] - in_time_arr[1])/60 ;
		
			var worktimehours = Math.round((Number(hh)+Number(mm))*10)/10;
			
			if(in_time && out_time ){
				$("#total_worktime").val(String(worktimehours));
			}
		
		}
		
		
		
</script>	

<div id="titleInBox" style="font-weight: bold; font-size: 19px;">근태관리홈 

</div>
	
	<div id="containerBox" >
		
		<div style="border-top: 1px dashed #c9c9c9; margin-top: 50px;"></div>
			
		<div class="docListTitle" style="display: flex; flex-direction: row; justify-content: flex-start; vertical-align: middle;"><span style="vertical-align: middle; display: flex; flex-direction: column; justify-content: center; ">출퇴근입력</span>
		</div>
		<input type="hidden" name="emp_no" value="${sessionScope.loginemp.emp_no}" />
        <input type="hidden" name="name" value="${sessionScope.loginuser.name}" class="short" readonly />
		
		<form name="worktimeForm">
		
			<input name="worktime_no" id="worktime_no" type="hidden" />
			<input name="fk_emp_no" id="fk_emp_no" type="hidden" value='${empvo.emp_no}' />

			<div id="titleParent" style="display: flex; flex-direction: row; justify-content: center; vertical-align: middle;">
				<div style="margin-right: 50px;  margin-top:3px;"><span style="font-weight: bold;">입력일&nbsp;:&nbsp;</span> <span id="date"></span></div>
				<div style="margin-right: 50px"><span style="margin-right: 20px; font-weight: bold;">출근시간입력</span>
					<input name="in_time" id="in_time" type="time" onChange="javascript:getWorktimehours()" />
				</div>
				<div style="margin-right: 50px"><span style="margin-right: 20px; font-weight: bold;">퇴근시간입력</span>
					<input name="out_time" id="out_time" type="time" onChange="javascript:getWorktimehours()" />
				</div>
				<div style="margin-right: 30px"><label style="margin-right: 20px; font-weight: bold;">총 업무시간</label>
					<input name="total_worktime" id="total_worktime" type="text" style="width: 50px" readonly/>&nbsp;&nbsp;시간</div>
				<button id="btnSubmit" class="btn btn-danger pull-right m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">출퇴근제출</button>
			</div>
		</form>
		
		<div style="border-top: 1px dashed #c9c9c9; margin-top: 50px;"></div>
	
		<div class="docListTitle" style="display: flex; flex-direction: row; justify-content: flex-start; vertical-align: middle;"><span style="vertical-align: middle; display: flex; flex-direction: column; justify-content: center; ">내 연차 내역</span>
		<a href="<%=ctxPath%>/attendance/write.os" class="btn btn-danger pull-right m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">연차신청하기</a>
		</div>
		
		
		<div id="titleParent" style="display: flex; flex-direction: row; justify-content: center;">
			<div style="margin-right: 50px; text-align: center; vertical-align: middle; display: flex; flex-direction: column; justify-content: center;">
				<p style="font-weight: bold;">${empvo.emp_name} ${empvo.position_name}</p> 
				<p style="font-weight: bold;">${empvo.dept_name}팀</p>
				
			</div>
			<div>
				<table class="table-bordered" style="text-align: center; vertical-align: middle; width: 900px;">
				<colgroup>
					<col width="*" />
		            <col width="33%" />
		            <col width="33%" />
				</colgroup>
				<tr>
				<td style="padding-top: 15px; vertical-align: middle;"><p style="font-weight: bold">총연차</p><p style="font-size: 15pt ">${vdvo.total_vacation_days}일</p></td>
				<td style="padding-top: 15px; vertical-align: middle;"><p style="font-weight: bold">사용연차 </p><p style="font-size: 15pt">${vdvo.use_vacation_days}일</p></td>
				<td style="padding-top: 15px; vertical-align: middle;"><p style="font-weight: bold">잔여연차</p><p style="font-size: 15pt">${vdvo.rest_vacation_days}일</p></td>
				</tr>
				</table>
			</div>
		</div>


		<div style="border-top: 1px dashed #c9c9c9; margin-top: 50px;"></div>
		
		<div class="docListTitle">승인 대기중 문서</div>
		
			<c:if test="${totalWaitingCount eq 0}">
				<div id="waitingDoc">
					승인할 문서가 없습니다.
				</div>
			</c:if>
			<c:if test="${totalWaitingCount ne 0}">
				<div id="waitingDoc">
					승인할 문서가 <span style="font-weight: bold">${totalWaitingCount}</span> 건 있습니다.
				</div>
				<table class="table table-hover tblElecAppr" style="font-size: 14px; text-align: center;">
				    <thead>
						<tr>
							<th>문서번호</th>
							<th>기안일</th>
							<th>결재양식</th>
							<th>기안자</th>
							<th style="width: 57%;">제목</th>
							<th>첨부</th>
						</tr>
				    </thead>
			<tbody>
				<c:forEach var="attvo" items="${attvoWaitingList}" varStatus="status">
				<tr> 
					<td>${attvo.attendance_apply_no}</td>
					<td>${attvo.writeday}</td>
					<td>
						<c:if test="${attvo.fk_attendance_sort_no eq 1}">
							<span id="docSortTitle">반차 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 2}">
							<span id="docSortTitle">연차 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 3}">
							<span id="docSortTitle">휴가 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 4}">
							<span id="docSortTitle">출장 신청서</span>
						</c:if>
					</td>
					<td>${attvo.emp_name}</td>
					<td style="width: 30%;"><span class="subject" onclick="location.href='waitingDetail.os?attendance_apply_no=${attvo.attendance_apply_no}'">${attvo.title}</span></td>
					<td>
						<c:if test="${not empty attvo.org_file_name}">
							<i class="fa fa-file"></i>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>		
		
		<div style="border-top: 1px dashed #c9c9c9; margin-top: 50px;"></div>
		
		<div class="docListTitle table-responsive">기안 진행 문서</div>
		<table class="table table-hover tblElecAppr" style="font-size: 14px; text-align: center;">
		   <thead>
				<tr>
					<th>문서번호</th>
					<th>기안일</th>
					<th>결재양식</th>
					<th style="width: 57%;">제목</th>
					<th>첨부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="attvo" items="${attvoProcessingList}" varStatus="status">
				<tr>
					<td>${attvo.attendance_apply_no}</td>
					<td>${attvo.writeday}</td>
					<td>
						<c:if test="${attvo.fk_attendance_sort_no eq 1}">
							<span id="docSortTitle">반차 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 2}">
							<span id="docSortTitle">연차 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 3}">
							<span id="docSortTitle">휴가 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 4}">
							<span id="docSortTitle">출장 신청서</span>
						</c:if>
					</td>
					<td style="width: 57%;"><span class="subject" onclick="location.href='processingDetail.os?attendance_apply_no=${attvo.attendance_apply_no}'">${attvo.title}</span></td>
					<td>
						<c:if test="${not empty attvo.org_file_name}">
							<i class="fa fa-file"></i>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div style="border-top: 1px dashed #c9c9c9; margin-top: 50px;"></div>
	
		<div class="docListTitle table-responsive">완료 문서</div>

		<table class="table table-hover tblElecAppr" data-text-content="true" class="" style="font-size: 14px; text-align: center;">
			<thead>
				<tr>
					<th>문서번호</th>
					<th>기안일</th>
					<th>결재양식</th>
					<th style="width: 57%;">제목</th>
					<th>첨부</th>
					<th>결재상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="attvo" items="${attvoFinishedList}" varStatus="status">
				<tr>
					<td>${attvo.attendance_apply_no}</td>
					<td>${attvo.writeday}</td>
					<td>
						<c:if test="${attvo.fk_attendance_sort_no eq 1}">
							<span id="docSortTitle">반차 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 2}">
							<span id="docSortTitle">연차 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 3}">
							<span id="docSortTitle">휴가 신청서</span>
						</c:if>
						<c:if test="${attvo.fk_attendance_sort_no eq 4}">
							<span id="docSortTitle">출장 신청서</span>
						</c:if>
					</td>
					
					<td style="width: 57%;"><span class="subject" onclick="location.href='finishedDetail.os?attendance_apply_no=${attvo.attendance_apply_no}'">${attvo.title}</span></td>
					<td>
						<c:if test="${not empty attvo.org_file_name}">
							<i class="fa fa-file"></i>
						</c:if>
					</td>
					<td>
						<c:if test="${attvo.approval_status eq 1}">
							승인
						</c:if>
						<c:if test="${attvo.approval_status eq 2}">
							반려
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	
	
	<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
          페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	  사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
	  현재 페이지 주소를 뷰단으로 넘겨준다. --%>
	<form name="goViewFrm">
		<input type="hidden" name="attendance_apply_no" />
		<input type="hidden" name="gobackURL" value="${gobackURL}" />
	</form>
</div>