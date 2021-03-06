<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>    
<link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">

<style type="text/css">
   #containerBox {
   		margin: 50px 120px;
   		
   }
	
	#titleInBox {
		margin: 50px 30px;
	}
	
	#parent {
		display: flex;
		justify-content: space-between;
	}
	
	.child {
	 	flex-grow: 1;
	}
		
	#btnNewAppr{
		margin: 0 0 30px 30px;

	}
	
	#waitingDoc {
		font-size: 14px;
		margin: 0 0 20px 0;
	}
	
	.docListTitle {
		font-weight: bold; 
		font-size: 13pt;
		margin: 50px 0 30px 0;
	}
	
	.docListTitle2 {
		font-weight: bold; 
		font-size: 13pt;
		margin: 80px 0 20px 0;
	}
	
	.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
		vertical-align: middle;
		align-items: center;
		padding: 0;
	}
	
	.tblElecApprInfoSm {
		border: 1px solid #c5ccd3;
		height: 20px;
		text-align: center; 
		vertical-align: middle;
		align-items: center;
	}
	
	
	.tblElecApprInfo {
		border: 1px solid #c5ccd3;
		height: 50px;
		text-align: center; 
		vertical-align: middle;
		align-items: center;
	}
	
	
	th.tblElecApprInfo {
		color: white;
		background-color: #c5ccd3; 
		width: 50%; 
		text-align: center; 
		vertical-align: middle;
	}

	td.tblElecApprInfo {
		width: 50%; 
		text-align: center; 
		vertical-align: middle;
		align-items: center;
	}
	
	div.divElecApprInfo{
		display: inline-block;
		float: left;
		align-items: center;
	}
	

	.tblElecApprLineInfo {
		text-align: center;
		height: 35px;
		width: 450px;
	}
	
	tr.tblElecApprLineInfo > th{
		width: 250px;
		text-align: center;
		color: white;
		background-color: #c5ccd3;
	}


#opinion{
	width: 100%;
	height: 30px;
	margin-right: 20px;
}

/***** slider *****/	
.switch {
  vertical-align: middle;
  position: relative;
  display: inline-block;
  width: 50px;
  height: 25px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 20px;
  width: 20px;
  left: 4px;
  margin: 2.5px 0;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #cbb2ae;
}

input:focus + .slider {
  box-shadow: 0;
}

input:checked + .slider:before {
  -webkit-transform: translateX(22px);
  -ms-transform: translateX(22x);
  transform: translateX(22px);
}


/* Rounded sliders */
.slider.round {
  border-radius: 22px;
}

.slider.round:before {
  border-radius: 50%;
}

#submitArea {
	text-align: center;
	margin: 40px 0;
}
#submitArea > button {
	width: 100px;
}

</style>

<script type="text/javascript">
$(document).ready(function(){
	 
		// ????????????
		$("button#btnDelete").click(function(){
			// ???(form)??? ??????(submit)
			var frm = document.delFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/attendance/delProcessing.os";
			frm.submit();
		});
	 
}); // end of ready()-------------------------------------------

</script>


<div id="titleInBox" style="font-weight: bold; font-size: 19px;">??????????????? ????????????</div>
	<form name="delFrm">
	<div id="containerBox">

	<div id="parent">
		
		<div class="child" >
	
			<div class="divElecApprInfo table-responsive" >
			<div class="docListTitle" >??????</div>
				<table class="table table-bordered table-sm tblElecApprLineInfo" style="font-size: 14px">
					<tr class="tblElecApprLineInfo">
						<th class="tblElecApprLineInfo">????????????</th>
						<td class="tblElecApprLineInfo" style="align-items: center;">
							<c:if test="${attvo.fk_attendance_sort_no eq 1}">
								<span id="docSortTitle">?????? ?????????</span>
							</c:if>
							<c:if test="${attvo.fk_attendance_sort_no eq 2}">
								<span id="docSortTitle">?????? ?????????</span>
							</c:if>
							<c:if test="${attvo.fk_attendance_sort_no eq 3}">
								<span id="docSortTitle">?????? ?????????</span>
							</c:if>
							<c:if test="${attvo.fk_attendance_sort_no eq 4}">
								<span id="docSortTitle">?????? ?????????</span>
							</c:if>
						</td>
					</tr>
					<tr class="tblElecApprLineInfo">
						<th class="tblElecApprLineInfo">?????????</th>
						<td class="tblElecApprLineInfo" style="align-items: center;">
							${attvo.emp_name}
						</td>
					</tr>
					<tr class="tblElecApprLineInfo">
						<th class="tblElecApprLineInfo">??????</th>
						<td class="tblElecApprLineInfo" style="align-items: center;">
							${attvo.empvo.dept_name}???
						</td>
					</tr>
					<tr class="tblElecApprLineInfo">
						<th class="tblElecApprLineInfo">???????????????</th>
						<td class="tblElecApprLineInfo" style="align-items: center;">
							${attvo.writeday}
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="child" >
		
			<div class="divElecApprInfo table-responsive" style="float: right; align-items: flex-end; margin-right: 10px;">
			<div class="docListTitle">?????????</div>
				<table class="table table-bordered tblElecApprLineInfo" style="float: right;">
					<tbody>
						<tr class="tblElecApprLineInfo">
							<th>??????</th>
							<c:if test="${not empty attvo.midapprvo}">
								<th>?????? ?????????</th>
							</c:if>
							<th>?????? ?????????</th>
						</tr>
						<tr class="tblElecApprLineInfo">
							<th>??????</th>
							<c:if test="${not empty attvo.midapprvo}">
								<td>${attvo.midapprvo.position_name}</td>
							</c:if>
							<td>${attvo.finapprvo.position_name}</td>
						</tr>
						<tr class="tblElecApprLineInfo">
							<th>??????</th>
							<c:if test="${not empty attvo.midapprvo}">
								<td>${attvo.midapprvo.emp_name}</td>
							</c:if>
							<td>${attvo.finapprvo.emp_name}</td>
						</tr>
						<tr class="tblElecApprLineInfo">
							<th>????????????</th>
							<td>
								<c:if test="${attvo.mid_approval_ok == 1}">
									<i class="fa fa-check-circle"></i>
								</c:if>
								 <c:if test="${attvo.mid_approval_ok == 2}">
									<i class="fa fa-times-circle"></i>
								</c:if>
							</td>
							<td>
								<c:if test="${attvo.fin_approval_ok == 1}">
									<i class="fa fa-check-circle"></i>
								</c:if>
								<c:if test="${attvo.fin_approval_ok == 2}">
									<i class="fa fa-times-circle"></i>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
			
		</div>	
	
		<div>
			<div class="docListTitle2">????????????</div>
	<!-- ------------------------------------------------------------------------------------------------------------------------- -->
			
			<!-- ?????? ?????? ??????-->
			<%-- ????????????, ??????????????? ????????? --%>
			<div id="docHeader1">
				<table
				style='width: 100%; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 187px;'>
				<colgroup>
					<col style='width: 90px;'>
					<col style='width: 180px;'>
					<col style='width: 90px;'>
					<col style='width: 250px;'>
					<col style='width: 90px;'>
					<col style=''>
				</colgroup>
	
				<tbody>
					<tr>
						<td
							style='padding: 3px; border: 1px solid black; font-size: 27px; font-weight: bold; text-align: center; vertical-align: middle; height: 113px;'
							colspan='2'>
							<c:if test="${attvo.fk_attendance_sort_no eq 1}">
								<span id="docSortTitle">?????? ?????????</span>
							</c:if>
							<c:if test="${attvo.fk_attendance_sort_no eq 2}">
								<span id="docSortTitle">?????? ?????????</span>
							</c:if>
							<c:if test="${attvo.fk_attendance_sort_no eq 3}">
								<span id="docSortTitle">?????? ?????????</span>
							</c:if>
							<c:if test="${attvo.fk_attendance_sort_no eq 4}">
								<span id="docSortTitle">?????? ?????????</span>
							</c:if>
								
							</td>
						<td
							style='padding: 3px; height: 113px; vertical-align: middle; border: 1px solid black; text-align: right;'
							colspan='4'><br></td>
					</tr>
					<tr>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							????????????</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.empvo.dept_name}</span>
						</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							??? ??? ???</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.writeday}</span>
						</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							????????????</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left; font-size: 12px;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.attendance_apply_no}</span>
						</td>
					</tr>
				</tbody>
			</table>  
			</div>
					<!-- ???????????????????????? -->
					<c:if test="${attvo.fk_attendance_sort_no eq 1}">
						 <table    
						style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>    
						<colgroup>    
							<col style='width: 90px;'>    
							<col style='width: 180px;'>    
							<col style='width: 90px;'>    
							<col style='width: 250px;'>    
							<col style='width: 90px;'>    
						</colgroup>    
			    
						<tbody>    
							<tr>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>    
									???   ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.attendance_start_date}</span>    
								</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>    
									??????/??????</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.contents3}</span>    
								</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>    
									???    ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.contents4}</span>    
								</td>    
								    
							</tr>    
						</tbody>    
					</table> 
					</c:if>
					
					<!-- ???????????????????????? -->
					<c:if test="${attvo.fk_attendance_sort_no eq 2}">
						  <table    
						style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>    
						<colgroup>    
							<col style='width: 90px;'>    
							<col style='width: 180px;'>    
							<col style='width: 90px;'>    
							<col style='width: 250px;'>    
							<col style='width: 90px;'>    
						</colgroup>    
			    
						<tbody>    
							<tr>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>    
									???   ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.attendance_start_date}</span>    
								</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>    
									??? ??? ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.contents3}</span>    
								</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>    
									???   ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.contents4}</span>    
								</td>    
								    
							</tr>    
						</tbody>    
					</table> 
			 		
					</c:if>
					
					<!-- ?????????????????? ?????? -->
					<c:if test="${attvo.fk_attendance_sort_no eq 3}">
						 <table    
						style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>    
						<colgroup>    
							<col style='width: 90px;'>    
							<col style='width: 180px;'>    
							<col style='width: 90px;'>    
							<col style='width: 250px;'>    
							<col style='width: 90px;'>    
						</colgroup>    
			    
						<tbody>    
							<tr>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>    
									??? ??? ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.attendance_start_date}</span>    
								</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>    
									??? ??? ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.attendance_finish_date}</span>    
								</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>    
									??????????????????</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.vacation_days} &nbsp; ???</span>    
								</td>    
								    
							</tr>    
						</tbody>    
					</table> 

					</c:if>
					
					<!-- ?????????????????? ?????? -->
					<c:if test="${attvo.fk_attendance_sort_no eq 4}">
					 <table    
						style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>    
						<colgroup>    
							<col style='width: 90px;'>    
							<col style='width: 180px;'>    
							<col style='width: 90px;'>    
							<col style='width: 250px;'>    
							<col style='width: 90px;'>    
						</colgroup>    
			    
						<tbody>    
							<tr>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>    
									??? ??? ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.attendance_start_date}</span>    
								</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>    
									??? ??? ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.attendance_finish_date}</span>    
								</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>    
									??? ??? ???</td>    
								<td    
									style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black;  text-align: left;'>    
									<span    
									style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${attvo.contents4}</span>    
								</td>    
								    
							</tr>    
						</tbody>    
					</table> 
					</c:if>
					


					<!-- ?????? ??? ?????? ?????? -->
	
					<table style="width: 99.85%; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
						<colgroup>
							<col style="width: 90px;">
							<col style="width: 710px;">
						</colgroup>
	
						<tbody>
							<tr>
								<td
									style="padding: 3px; height: 30px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;">
	
									??? &nbsp;&nbsp;&nbsp; ???</td>
								<td style="padding: 0 3px;">
									${attvo.title}
								</td>
							</tr>
							<tr>
								<td
									style="padding: 20px; height: 540px; vertical-align: top; border: 1px solid black;"
									colspan="2">${attvo.content}</td>
							</tr>
							<%-- === #162. ???????????? ?????? ??? ??????????????? ???????????? ??????????????? ???????????? ????????? ????????? === --%>
									<c:if test="${attvo.org_file_name != null}">
										<tr>
											<th style="height: 25px; font-weight: bold; border: solid 1px black; text-align: center;">????????????</th>
											<td style="padding 0 10px;">
												<a href="<%= request.getContextPath()%>/attendance/download.os?attendance_apply_no=${attvo.attendance_apply_no}">${attvo.org_file_name}</a> 
											</td>
										</tr>
									</c:if>
							</tbody>
					</table> <!-- ?????? ??? ?????? ??? --> 
					<!-- ??????-->
	
					<table style="padding: 20px; width: 100%;; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
						<tbody>
							<tr>
							</tr>
						</tbody>
					</table> <!-- ?????? ???-->
				
			<!-- -------------------------------------------------------------------------------------------------	------------------------ -->
		</div>
	
		<!-- ??????????????? ???????????? ??????????????? ????????? ?????? ???????????? ???????????? ?????? -->
		<c:if test="${not empty attvo.mid_approval_opinion}">
			<div class="docListTitle2">??????????????? ??????</div>
			<span>${attvo.mid_approval_opinion}</span>
		</c:if>
		
		<!-- ?????? ????????? ???????????? ?????? ????????? ?????? ????????? ????????? -->
		<c:if test="${not empty 	attvo.fin_approval_opinion}">
			<div class="docListTitle2">??????????????? ??????</div>
			<span>${attvo.fin_approval_opinion}</span>
		</c:if>

	<input type="hidden" name="attendance_apply_no" value="${attvo.attendance_apply_no}"/>
  	<p id="submitArea" >
		<button id="btnDelete" class="btn btn-danger m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light" style="width: 130px">????????????(??????)</button>
		<a id="submit" href="javascript:history.back()" class="btn btn-info m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light" style="width: 100px">????????????</a>
	</p>
</div>
</form>