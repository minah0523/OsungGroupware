<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% String ctxPath = request.getContextPath(); %>    

<style type="text/css">
   #containerBox {
   		margin: 50px;
   }
	
	#titleInBox{
		margin: 50px 30px;
	}
	
	#btnNewAppr{
		margin: 0 0 30px 30px;

	}
	
	#waitingDoc {
		font-size: 14px;
		margin: 0 0 50px 20px;
	}
	
	.docListTitle {
		font-weight: bold; 
		font-size: 14px;
		margin: 50px 0;
	}
	
	th{
		text-align: center;
		color: white;
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
		
		 <%-- === #107. 검색어 입력시 자동글 완성하기 2 === --%>
		 <%--$("div#displayList").hide();
		
		$("input#searchWord").keyup(function(){
			
			var wordLength = $(this).val().length;
			// 검색어의 길이를 알아온다.
			
			if(wordLength == 0) {
				$("div#displayList").hide();
				// 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
			}
			else {
				$.ajax({
					url:"<%= request.getContextPath()%>/wordSearchShow.action", 
					type:"GET",
					data:{"searchType":$("select#searchType").val()
						 ,"searchWord":$("input#searchWord").val()},
					dataType:"JSON",
					success:function(json){
						=== #112. 검색어 입력시 자동글 완성하기 7 ===
						if(json.length > 0) {
							// 검색된 데이터가 있는 경우임.
							
							var html = "";
							
							$.each(json, function(index, item){
								var word = item.word;
								// word ==> 프로그램은 JAVA 가 쉬운가요?
								
								var index = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase()); 
								//          프로그램은 java 가 쉬운가요?
								// 검색어(JAVA)가 나오는 index   6 
								
								var len = $("input#searchWord").val().length;
								//  len = 4
										
							//	console.log(word.substr(0, index));   // 검색어 앞까지의 글자  "프로그램은 "
							//	console.log(word.substr(index, len)); // 검색어 글자     "JAVA"
							//	console.log(word.substr(index+len));  // 검색어 뒤부터 끝까지의 글자    " 가 쉬운가요?"
								
								var result = "<span style='color:blue;'>"+word.substr(0, index)+"</span><span style='color:red;'>"+word.substr(index, len)+"</span><span style='color:blue;'>"+word.substr(index+len)+"</span>";
										
								html += "<span style='cursor:pointer;' class='result'>"+result+"</span><br>";
							});
							
							$("div#displayList").html(html);
							$("div#displayList").show();
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
				});
			}
			
		});// end of $("input#searchWord").keyup()-----------------
		 --%>
		
		 <%--=== #113. 검색어 입력시 자동글 완성하기 8 === --%>
		 <%-- $(document).on("click",".result",function(){
			var word = $(this).text();
			$("input#searchWord").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			$("div#displayList").hide();
			goSearch();
		});
		
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if( ${not empty paraMap} ) {  // 또는 if( ${paraMap != null} ) { 
			$("select#searchType").val("${paraMap.searchType}");
			$("input#searchWord").val("${paraMap.searchWord}");
		}  --%>
		
	});// end of $(document).ready(function(){})-------------------
	
	<%-- function goSearch() {
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/list.action";
		frm.submit();
	} --%>// end of function goSearch() {}-----------------------
	
</script>


<div id="titleInBox" style="font-weight: bold; font-size: 19px;">결재 대기중 문서</div>

	<div id="containerBox">
		
		<div id="waitingDoc">
			<c:if test="${totalCount eq 0}">
			결재할 문서가 없습니다.
			</c:if>
			<c:if test="${totalCount ne 0}">
			결재할 문서가 <span style="font-weight: bold">${totalCount}</span> 건 있습니다.
			</c:if>
		</div>

		<table class="table table-hover tblElecAppr" style="font-size: 14px; text-align: center;">
		    <thead>
				<tr>
					<th>문서번호</th>
					<th>기안일</th>
					<th>결재양식</th>
					<th>긴급</th>
					<th>기안자</th>
					<th style="width: 57%;">제목</th>
					<th>첨부</th>
				</tr>
		    </thead>
			<tbody>
				<c:forEach var="elecapprvo" items="${elecapprvoList}" varStatus="status">
				<tr> 
					<td>${elecapprvo.approval_no}</td>
					<td>${elecapprvo.writeday}</td>
					<td>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 1}">
							품의서
						</c:if>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 2}">
							비용품의서
						</c:if>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 3}">
							증명서신청
						</c:if>
					</td>
					<td>
						<c:if test="${elecapprvo.emergency eq 1}">
							<i class="fa fa-exclamation-circle"></i>
						</c:if>
					</td>
					<td>${elecapprvo.emp_name}</td>
					<td style="width: 30%;"><span class="subject" onclick="location.href='waitingDetail.os?approval_no=${elecapprvo.approval_no}'">${elecapprvo.title}</span></td>
					<td>
						<c:if test="${not empty elecapprvo.org_file_name}">
							<i class="fa fa-file"></i>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		
	<%-- === 페이지바 보여주기 === --%>
	<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">        
		${pageBar}
	</div>
	


</div>