<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

  #miniHeader {
  	 display: inline-block;
  }
  
  #btnGoList {
  	 border: 0;
  	 background-color: white; 
  }
  
  ul#titleSendReceiveGroup, .detailList {
  	 list-style-type: none;
  }
  
  .detailList {
  	 margin-right: 15px; 
  	 padding-left: 10px;
  }
  
  #btnGoList:hover {
  	 background-color: #EEEEEE;
  }
  
  #note_searchType, #searchWord, 
  #note_serachWord, #note_search,
  #btnSearch {
  	 display: inline-block;
  }
  
  #note_searchType {
  	 margin-left: 49%;
  }

</style>

<div class="row bg-title"  style="border-bottom: solid .025em gray;">
	<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
	    <h4 class="page-title" style="color:#233B49;  padding-left: 25px;">예약 쪽지함</h4>
	</div>
	
    <div class="input-group" id="goList"> 
       <button type="button" id="btnGoList" onclick="javascript:location.href='${goBackURL}'" style="height: 35px; margin-left: 835px;">
       		<i class="fa fa-reorder"></i>
       		목록
       </button>
    </div>
        	
</div> 

<div class="noteDetailWrap" style="margin-top: 20px; width:100%;">
	<div class="noteTitleSendReceiveInfo" style="margin-top: 20px;">
		<ul class="titleSendReceiveGroup" style="margin-top: 20px; padding-left: 10px;">
			<li id="title" class="detailList" style="margin-top: 20px;">
				<h4 style="font-weight: bold;">${noteReservationTempvo.note_title}</h4>
			</li>
			<li id="sender" class="detailList" style="margin-top: 20px;">
				<span>보낸사람:</span>
				<span class="receiveOneDetailData">${noteReservationTempvo.emp_name} &#60;${noteReservationTempvo.fk_emp_no_send}
					<c:if test="${not empty noteReservationTempvo.dept_name_send}">
						/ ${noteReservationTempvo.dept_name_send}&#62; 
					</c:if>
					<c:if test="${empty noteReservationTempvo.dept_name_send}">
						&#62; 
					</c:if>
				</span>
			</li>
			<li id="receiver" class="detailList" style="margin-top: 20px;">
				<span>받는사람:</span>
				<span class="receiveOneDetailData">${noteReservationTempvo.fk_emp_name} &#60;${noteReservationTempvo.fk_emp_no_receive}
					<c:if test="${not empty noteReservationTempvo.dept_name_receive}">
						/ ${noteReservationTempvo.dept_name_receive}&#62; 
					</c:if>
					<c:if test="${empty noteReservationTempvo.dept_name_receive}">
						&#62; 
					</c:if>		
				</span>
								
			</li>
			<li class="detailList" style="margin-top: 20px;">
				<span>보낸날짜:</span>
				<span class="receiveOneDetailData">${noteReservationTempvo.note_write_date}</span>
			</li>
		</ul>
	</div>
	
	<div class="noteFileInfo" style="width:1360px; margin-left: -25px; margin-top: 20px; padding-bottom: 20px; border-bottom: solid .025em gray; height: 30px;"> 
		<span style="padding-left: 44px;">첨부파일:</span>
		<c:if test="${not empty noteReservationTempvo.note_orgfilename}">   
			<span><a href = "<%= request.getContextPath()%>/jieun/note/download.os?note_no=${noteReservationTempvo.note_no}" >${noteReservationTempvo.note_orgfilename}</a></span>			
      	</c:if>
      	<c:if test="${empty noteReservationTempvo.note_orgfilename}">
			<span> 첨부파일이 없습니다. </span>                            
      	</c:if>
	</div>
	
	<div class= "noteContentInfo">
		<div style="width: 100%; height: 200px; padding-left: 20px; margin-top: 20px;">
			${noteReservationTempvo.note_content}
		</div>
	</div>

</div>    