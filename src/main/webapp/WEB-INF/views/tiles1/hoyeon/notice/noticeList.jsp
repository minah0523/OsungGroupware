<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<% String ctxPath = request.getContextPath(); %>

<style>
option{
color:black;
}
div#searchDiv{
    text-align: center;
    margin-bottom: 25px;
    margin-top: 10px;
}

form#searchFrm{
 margin-bottom: 25px;
    margin-top: 10px;
}
#table {border-collapse: collapse;
        width: 100%;
        }
table{
    border-spacing: 2px;
    width: 100%;
    border-top: 1px solid #BDBDBD;
    border-collapse: collapse;
}
thead{
    
    border-color: inherit;
    vertical-align: middle;
}

 th{
    border-bottom: 1px solid #BDBDBD;
    padding: 10px;
 }
  td {
    border-bottom: 1px solid #E6E6E6;
    padding: 5px;
  }
  
  
.titleStyle {font-weight: bold;
             color: gray;
             cursor: pointer;} 
             
span#head{
color:blue;
margin-right: 20px;
}             

span#write:hover{
font-weight: bold;

}
span#write{
/* border: solid 1px #BDBDBD;
border-radius: 5px; */
margin: 10px;

}
             
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("span.title").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("titleStyle");
		});
		
		$("span.title").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("titleStyle");
		});
		
		$("input#searchWord").keyup(function(event){
			if(event.keyCode == 13) {
				// 엔터를 했을 경우 
				goSearch();
			}
		});
		
		//검색시 검색조건 및 검색어 값 유지시키기
		if( ${not empty paraMap} ) {  // 또는 if( ${paraMap != null} ) { 
			$("select#searchType").val("${paraMap.searchType}");
			$("input#searchWord").val("${paraMap.searchWord}");
		}
		
	});//end of $(document).ready(function(){}

	
	function goView(seq) {
			// 현재 페이지 주소를 뷰단으로 넘겨준다.
			var frm = document.goViewFrm;
			frm.seq.value = seq;
			
			
			frm.method = "GET";
			frm.action = "<%= ctxPath%>/noticeView.os";
			frm.submit();
		}// end of function goView(seq){}----------------------------------------------
		
		
		function goSearch() {
			var frm = document.searchFrm;
			frm.method = "GET";
			frm.action = "<%= request.getContextPath()%>/noticeList.os";
			frm.submit();
		}// end of function goSearch() {}-----------------------
	
</script>

<div style="padding-left: 5%;">
	<h2 style="margin-bottom: 30px;">공지사항</h2>
		<span id = "write" onclick="javascript:location.href='<%= request.getContextPath()%>/noticeAdd.os'">공지작성
			<i class= "fa  fa-edit" aria-hidden="true"></i>
		</span>
		
		<table id="board_table">
		 
			<thead id="board_table_header">
			<tr>
				<th style="width: 70px;  text-align: center;">글번호</th>
				<th style="width: 340px; text-align: center;">제목</th>
				<th style="width: 70px;  text-align: center;">작성자</th>
				<th style="width: 150px; text-align: center;">작성일</th>
				<th style="width: 70px;  text-align: center;">조회수</th>
			</tr>
			</thead>
	
			
	 	<c:forEach var="board" items="${noticeList}" varStatus="status">
			 <tr>
			 	<td style="width: 70px;  text-align: center;">${board.seq}  
			 </td>
			
			 	 <td style="width: 40px;  text-align: left; padding-left: 20px;">
			  
			  <%-- 파일첨부가 없을때 --%>
			    <c:if test="${empty board.fileName}"> 
			 	
					   <c:if test="${board.commentCount > 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span>${board.title} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${board.commentCount}</span>]</span> </span> 
					   </c:if>
					   
					   <c:if test="${board.commentCount == 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span> ${board.title}</span>  
					   </c:if>
				  
				</c:if>   
		
			 <%--파일첨부 없을때 끝 --%>	 
			 	 
			 	 <%-- 첨부파일이 있는 경우 --%>
			 <c:if test="${not empty board.fileName}">
					   <c:if test="${board.commentCount > 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span> ${board.title} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${board.commentCount}</span>]</span> </span> &nbsp;<i class="fa fa-file-o"></i>
					   </c:if>
					   
					   <c:if test="${board.commentCount == 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span> ${board.title}</span> &nbsp;<i class="fa fa-file-o"></i>
					   </c:if>			   
			 </c:if>		
		    <%-- 파일첨부가 있을때끝 --%> 			 
					</td> 
				  
			 	<td style="width: 70px;  text-align: center;">${board.name}</td>			
			 	<td style="width: 70px;  text-align: center;" > ${board.writeDay}</td>
			 	<td style="width: 70px;  text-align: center;" >${board.readCount}</td>
			 	
			 </tr>

		</c:forEach>	 
			
		</table>
		
		<%--페이지 바  --%>
		<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">        
		${pageBar}
	    </div>
		
	<%--검색 폼--%>
 <div id="searchDiv">
	<form name="searchFrm" id="searchFrm">
	
		<select name="searchType" id="searchType" style="height: 26px;">
			<option value="title">글제목</option>
			<option value="name">작성자</option>
		</select>
		
		<input type="text" placeholder="검색" name="searchWord" id="searchWord" size="20" autocomplete="off" /> 
		<button type="button" style="width: 30px" onclick="goSearch()">
		<i class="fa fa-search fa-fw" aria-hidden="true"></i>
		</button>
	</form>
	
	
	<%--글제목 클릭후 상세보기를 한 다음에 목록보기를 봤을때
	 돌아갈 페이지를 알려주기 위해서 현재 페이지 주소를 뷰단으로 넘겨준다. --%>
 </div>	
		<form name="goViewFrm">
		   <input type="hidden" name="seq" />
		   <input type="hidden" name="gobackURL" value="${gobackURL}" />
	    </form>
		
</div>	