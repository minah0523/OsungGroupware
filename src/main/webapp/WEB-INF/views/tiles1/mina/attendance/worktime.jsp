<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<% String ctxPath = request.getContextPath(); %>    


<style type="text/css">
   #containerBox {
   		margin: 50px 10%;
   		align-content: center;
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
		font-weight: bold; -
		font-size: 14px;
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

		
</script>	

<div id="titleInBox" style="font-weight: bold; font-size: 19px;">출퇴근현황 
</div>

<div id="containerBox">
		<div class="docListTitle">내 출퇴근 내역</div>
		
		 <table class="table table-bordered tblElecAppr" id="tblWorktime" style="font-size: 14px; text-align: center;">
		    <thead>
				<tr>
					<th>업무일자</th>
					<th>출근시간</th>
					<th>퇴근시간</th>
					<th>총근무시간</th>
				</tr>
		    </thead>
			<tbody>
				<c:forEach var="wtvo" items="${wtvoList}" varStatus="status">
				<tr> 
					<td>${wtvo.regdate}</td>
					<td>${wtvo.in_time}</td>
					<td>${wtvo.out_time}</td>
					<td>${wtvo.total_worktime}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
				
		
</div>

