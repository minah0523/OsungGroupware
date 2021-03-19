<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
 <style>
 
	#table, #table2 {border-collapse: collapse;
	 		         width: 100%;}
	hr{
	color: gray;
	margin:10px;
	}
	.header{
	display: flex;
	}
	div#smallHeader{
	width: 40%;
	text-align: left;
	 
	}
	div#smallHeader_right{
	display: inline-block; 
	width: 40%;
	text-align: right;
	 
	}
	
	div#smallHeader{
	width: 50%;
	}
	
	
	div#smallHeader>span{
	/* border:solid 1px red; */
	 margin-left: 10px;
	}
	div#smallHeader_right>span{
	/* border:solid 1px red; */
	 margin-left: 10px;
	}
	
	
	div#boardContentAll{
	margin: 10px;
	}
	  
	  
	thead#tbl_header{
	
	margin:0 0 0 20px;
	
	}  
	th{
	margin-left: 2px;
	}
	 
	button{
	border: none;
	width: 90px;
	height:25px;
	border-radius:3px;
	}
	
	button#btnComment{
	background-color:#0F4C81;
	color:white;
	}	  
	input{
	width:80%;
	}  
	
	commentFrm{
	margin-left:10px;
	}
	td.commentContent{
	text-align: center;
	align-content: center;

	}
	td.comment{
	display: block;
	width:200px;
	}	 
	
	tbody#commentDisplay{
	display: block;
	}
	
	tr#comment{
	margin-bottom: 10px;
	display: block;
	} 
	
	
	td#commentContent{
	display: flex;
	
	}
	
 </style>
 <script>
 $(document).ready(function(){
		
	 // goReadComment();  // 페이징처리 안한 댓글 읽어오기 
	     goViewComment(1); // 페이징처리 한 댓글 읽어오기 
		
		$("span.move").hover(function(){
			                   $(this).addClass("moveColor");
		                    }
		                    ,function(){
		                       $(this).removeClass("moveColor");
		                    });

	}); // end of $(document).ready(function(){})----------------
	
	
	// == 댓글쓰기 == //
	function goAddWrite() {
		
		var contentVal = $("input#commentContent").val().trim();
		if(contentVal == "") {
			alert("댓글 내용을 입력하세요!!");
			return;
		}
				
		var form_data = $("form[name=addWriteFrm]").serialize();
		$.ajax({
			url:"<%= request.getContextPath()%>/noticeAddComment.os",
			data:form_data,
			type:"POST",
			dataType:"JSON",
			success:function(json){  // {"n", 1} OR {"n", 0}
				var n = json.n;
				
				if(n == 0) {
					alert(json.name+"님은 댓글작성을 실패하셨습니다!");
				}
				else {
				 
					goViewComment(1); // 페이징처리 한 댓글 읽어오기 
				}
				
				$("input#commentContent").val("");
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}// end of function goAddWrite(){}---------------------------
	
	 
	
	// === #127. Ajax로 불러온 댓글내용을 페이징처리 하기 === // 
	function goViewComment(currentShowPageNo) {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/noticeCommentList.os",
			data:{"parentSeq":"${noticevo.seq}",
				  "currentShowPageNo":currentShowPageNo},
			dataType:"JSON",
			success:function(json){
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						 
						html += "<tr id='comment' style='padding:10px; border:solid 0px gray; width:90%; background-color:#F2F2F2'>";
						html += "<td class='comment' style='font-size:15px; font-weight:bold;'>"+item.name+"</td>";
						html += "<td class='comment' style='font-size:8pt; color:gray;'>"+item.writeDay+"</td>";
						html += "<td class='commentContent' style='padding-left:20px;padding-top:12px;'>"+item.content+"</td>";
						 
						html += "</tr>";
						 	 
					});
				}
				else {
					html += "<tr>";
					html += "<td colspan='4' class='comment' style='padding-left:20px;'>댓글이 없습니다.</td>";
					html += "</tr>";
				}
				
				$("tbody#commentDisplay").html(html);
				
				// 페이지바 함수 호출
				makeCommentPageBar(currentShowPageNo);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}// end of function goReadComment(){}------------------------
	
	
	// ==== 댓글내용 페이지바 Ajax로 만들기 ==== //
	function makeCommentPageBar(currentShowPageNo) {
	
		<%-- 원글에 대한 댓글의 totalPage 수를 알아오려고 한다. --%> 
		$.ajax({
			url:"<%= request.getContextPath()%>/getNoticeCommentTotalPage.os", 
			data:{"parentSeq":"${noticevo.seq}",
				  "sizePerPage":"5"},
			type:"GET",
			dataType:"JSON",
			success:function(json){
			//	console.log("전체페이지수 : " + json.totalPage);
				
				if(json.totalPage > 0) {
					// 댓글이 있는 경우
					
					var totalPage = json.totalPage;
					
					var pageBarHTML = "<ul style='list-style: none;'>";
					
					var blockSize = 2;
					
					var loop = 1;
				
				    if(typeof currentShowPageNo == "string") {
				    	currentShowPageNo = Number(currentShowPageNo);
				    }
				    
				    // 현재페이지로 PageNo를 알아오는 공식//
				    var pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
					
					// === [맨처음][이전] 만들기 === 
					if(pageNo != 1) {
						pageBarHTML += "<li style='display:inline-block; width:60px; font-size:12pt;'><a href='javascript:goViewComment(\"1\")'>[맨처음]</a></li>"; 
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:11pt;'><a href='javascript:goViewComment(\""+(pageNo-1)+"\")'>[이전]</a></li>";
					}
						
					while( !(loop > blockSize || pageNo > totalPage) ) {
						
						if(pageNo == currentShowPageNo) {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt; border:solid 0px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
						}
						else {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>";
						}
						
						loop++;
						pageNo++;
						
					}// end of while------------------------------
						
						
					// === [다음][마지막] 만들기 ===
					if( !(pageNo > totalPage) ) {
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:11pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>[다음]</a></li>";
						pageBarHTML += "<li style='display:inline-block; width:60px; font-size:11pt;'><a href='javascript:goViewComment(\""+totalPage+"\")'>[마지막]</a></li>";
					}
					
					pageBarHTML += "</ul>";
						
					$("div#pageBar").html(pageBarHTML);
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}// end of function makeCommentPageBar(currentShowPageNo){}----------
	
 </script>
 
 <div style="padding-left: 5%;">
 
		<h2>게시판</h2> 
		
	<hr>
	  <div class="header">
		<div id="smallHeader">
		 	<span onclick="javascript:location.href='<%= request.getContextPath()%>/noticeAdd.os'">공지쓰기</span>
		 	<span onclick="javascript:location.href='<%=request.getContextPath()%>/noticeDel.os?seq=${noticevo.seq}'">삭제하기</span>
		 	<span onclick="javascript:location.href='<%=request.getContextPath()%>/noticeEdit.os?seq=${noticevo.seq}'">수정하기</span>
		</div>
		
		<div id="smallHeader_right">
		 	<span onclick="javascript:location.href='<%= request.getContextPath()%>/noticeList.os'">목록</span>
		</div>
	</div>
	 
		
	 <hr>
	 
	 <!-- 게시글 내용 시작-------------------------------------------- -->
	 <div>
	 	<h2 style="margin:10px;">${noticevo.title}</h2>
	 </div>
	 		
	 <div id="boardContentAll">		
	 
	 	<table>
	 		<thead style="font-size: 12pt;">
	 			 <tr >
	 			  	<th>${noticevo.name}</th>
	 			</tr>
	 			<tr>
	 				<th style="font-size:9pt;color:#BDBDBD; font-weight:lighter;">${noticevo.writeDay}</th>
	 			</tr>
	 			
	 	<!-- 첨부파일이 있다면 보여준다. -->		
	 	  <c:if test="${noticevo.orgFilename != null}">
	 		<tr>
				<th style="font-size:9pt;">첨부파일</th>
				<td style="font-size:9pt;">
				
					<c:if test="${sessionScope.loginemp != null}">
						<a href="<%= request.getContextPath()%>/noticedownload.os?seq=${noticevo.seq}">${noticevo.orgFilename}</a> 
					<span style="font-size:10pt;color:#BDBDBD;">
					<fmt:formatNumber value="${noticevo.fileSize}" pattern="#,###" />bytes
					</span>	
					</c:if>
					
					<c:if test="${sessionScope.loginemp == null}">
						${noticevo.orgFilename}
						<fmt:formatNumber value="${noticevo.fileSize}" pattern="#,###" />bytes
					</c:if>
				</td>
			</tr>
	 	  </c:if>
	 	<!-- 첨부파일이 있다면 보여주기 끝  -->		
	 	
	 	   
	 		</thead>
	 		 
	 		<tbody id="content">
	 			<tr >
	 				<td style="padding-bottom:40px; padding-top:40px;">
						<p  style="word-break: break-all;">${noticevo.content}</p>
					</td>
	 			</tr>	 
	 		</tbody>
	 	</table>
	 </div>
	 <!-- 게시글 내용 시작끝-------------------------------------------- -->
	 <div style="font-size: 9pt; margin-left: 10px;">
		 <span>댓글 ${noticevo.commentCount}개   | </span>
		 <span>조회수 ${noticevo.readCount} </span>
	 </div >
	 
	 <hr>
	 <!-- 아래부터 댓글------------------------------->
	 
	 
	 <!-- =====  댓글 내용 보여주기 ===== -->
	<table id="table2" style="margin-top: 2%; margin-bottom: 3%;">
		<thead>
		<tr>
		    
		</tr>
		</thead> 
		<tbody id="commentDisplay"></tbody>
	</table>
	 <!-- ===== 댓글 내용 보여주기 끝===== -->
	
	<!-- 댓글 작성 폼 ---------------------------------------------------------------------->	
	  <div id="commentFrm">
	  <span></span>
			<form name="addWriteFrm" style="margin-top: 20px;">
				      <input type="hidden" name="fk_emp_no" value="${sessionScope.loginemp.emp_no}" /> 
				      <input type="hidden" name="name" value="${sessionScope.loginemp.emp_name}" /> 
				
				<input id="commentContent" type="text" name="content" class="long" /> 
				
				<%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) --%>
				<input type="hidden" name="parentSeq" value="${noticevo.seq}" />
				<button id="btnComment" type="button" onclick="goAddWrite()">댓글 작성</button> 
			</form>
	 </div>
		<!-- 댓글 작성 폼끝 ---------------------------------------------------------------------->	

	
	<%-- ==== #136. 댓글 페이지바 ==== --%>
	<div id="pageBar" style="border:solid 0px gray; width: 90%; margin: 10px auto; text-align: center;"></div>
 
 </div>