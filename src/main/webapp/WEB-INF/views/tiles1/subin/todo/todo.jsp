<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ToDO</title>

<style type="text/css">

	.titleBox{
		background-color: white;
		padding: 15px;
		padding-left: 30px;
	}
	
	.titleBox h2{
		margin: 0;
		font-weight: bold;
		color: #6a6a69;
	}
	
	.container{
		background-color: white;
		margin-top: 2%;
		width: 97%;
	}
	
	ul{
		padding: 0;
		margin: 0;
	}
	
	h5.titleText{
		font-weight: bold;
		padding-bottom: 2%;
		font-size: 12pt;
		color: #6e757b;
	}
	
	.secondTitle{
		padding-top: 5%;
	}
	
	#bookmark{
		margin-bottom: 5%;
	}
	
	.star_box{
		float: right;
		font-size: 13pt;
	}
	
	<%-- 클릭시, 별 색상 css --%>
	.star_color_pink{
		color: orange;
	}
	
	.each_todo{
		border: solid 1px gray;
		display: inline-block;
		width: 250px;
		height: 150px;
		cursor: pointer;
		border-radius: 8px;
		margin: 0 20px;
		margin-bottom: 30px;
		float: left;
	}
	
	.content_box{
		border: solid 0px red;
		word-break:break-all;
		min-height: 80px;
		max-height: 80px;
		padding: 0 20px;
		overflow: hidden;
	    display: -webkit-box;
	    -webkit-line-clamp: 4;
	    -webkit-box-orient: vertical;
	}

	div#board .each_todo{
		float: left;
	}
	
	.add_each_todo{
		border: dashed 1px gray;
		display: table;
	}
	
	.each_todo_box{
		padding: 20px;
	}
	
	.each_todo:hover{
		background-color: #edf1f5;
	}
	
	.add_todo_box{
		text-align: center;
	}
		
	
	
	<!-- todo 추가 modal -->
	.container{
		width: 97%;
		margin: 0 auto;
	}
	
	.table-borderless > tbody > tr > td,
	.table-borderless > tbody > tr > th,
	.table-borderless > tfoot > tr > td,
	.table-borderless > tfoot > tr > th,
	.table-borderless > thead > tr > td,
	.table-borderless > thead > tr > th {
	    border: none;
	}
	
	th{
		font-size: 12pt;
	}
	
	.content{
		resize: none;
	}
	
	.todo_text{
		font-weight: bold;
	}
	
	.blueBtn{
		border-radius: 4px;
		background-color: #0F4C81;
		color: white;
	}
	
	.grayBtn{
		border-radius: 4px;
		background-color: #D8D8D8;
		color: gray;
	}
	
	.redBtn{
		border-radius: 4px;
		background-color: #d53641;
		color: white;
	}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script type="text/javascript">
	// todo 별 눌렀을 때 즐겨찾기 구현 
	
	//전체 모달 닫기(전역함수인듯)
	window.closeModal = function(){
	    $('.modal').modal('hide');
	    javascript:history.go(0);
	};

	$(document).ready(function() {
		
		readBookmark();

		// 할일 수정 모달 연결 함수(해당 todo_no 모달로 전달)
		$(document).on("click","li.edit_todo",function() {
			var todo_no = $(this).data('seq');
			
			$("input[name=todo_no]").val( todo_no );
			
			$.ajax({
				url:"<%= request.getContextPath() %>/readOneTodo.os",
				data:{"todo_no":todo_no},
				type:"GET",
				dataType:"JSON",
				success:function(json){
					
					$("input[name=todo_no]").val( json.todo_no );
					$("input[name=subject]").val( json.subject );
					$("textArea[name=content]").val( json.content );
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});
			
		});
		
	});
	
	// 즐겨찾기 버튼을 클릭했을 시(DB변경)
	function bookmark(todo_no) {
		
		$.ajax({
			url:"<%= request.getContextPath() %>/switchBookmark.os",
			data:{"todo_no":todo_no},
			type:"POST",
			dataType:"JSON",
			success:function(json){
				var n = json.n;

				if(n == 0) {
					alert("DB오류");
				}
				else {
					javascript:history.go(0);
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});

	}
	
	// 즐겨찾기 할일 불러오기(로그인시 수정!!)
	function readBookmark() {
		
		$.ajax({
			url:"<%= request.getContextPath() %>/readBookmark.os",
			type:"GET",
			dataType:"JSON",
			success:function(json){
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						
						html += "<li class='each_todo edit_todo' data-toggle='modal' data-target='#editTodoModal'";
						html += "data-seq=" + item.todo_no + ">";
						html += "<div class='each_todo_box'>";
						html += "<span class='todo_text'>" + item.subject + "</span>";
						html += "<span class='star_box' onclick='javascript:event.cancelBubble=true; bookmark(" + item.todo_no + ")'>";
						html += "<i class='fa fa-star star_color_pink'></i> ";
						html += "</span>";
						html += "</div>";
						html += "<div class='content_box'>" + item.content + "</div>";
						html += "</li>";
					});
				}
				else {
					html += "";
				}
				
				$("ul.bookmarkUl").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}
	
	
	// (modal)할일 추가 버튼 클릭 시 
	function submitBtn() { 

		if ($("input#subject").val().trim() == "") {
			alert("제목을 입력해주세요.");
			$("input#subject").focus();
			
			return false;
		}
		if ($("textArea#content").val().trim() == "") {
			alert("내용을 입력해주세요.");
			$("textArea#content").focus();
			
			return false;
		}
		
		var form_data = $("form[name=addTodoFrm]").serialize();
		$.ajax({
			url:"<%= request.getContextPath() %>/addEndTodo.os",
			data:form_data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				var n = json.n;

				if(n == 0) {
					alert("DB오류");
				}
				else {
					javascript:history.go(0);
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
	}
	
	// (modal)할일 수정 버튼 클릭 시 
	function editTodoBtn() {
		
		if ($("input[name=subject]").val().trim() == "") {
			alert("제목을 입력해주세요.");
			$("input[name=subject]").focus();
			
			return false;
		}
		if ($("textArea[name=content]").val().trim() == "") {
			alert("내용을 입력해주세요.");
			$("textArea[name=content]").focus();
			
			return false;
		}
		
		editTodoEndBtn();
	}
	
	// (modal)할일 수정 ajax
	function editTodoEndBtn() {
		var form_data = $("form[name=editTodoFrm]").serialize();
		$.ajax({
			url:"<%= request.getContextPath() %>/editTodo.os",
			data:form_data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				var n = json.n;

				if(n == 0) {
					alert("DB오류");
				}
				else {
					javascript:history.go(0);
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
	}
	
	// (modal)할일 삭제 버튼 클릭 시 
	function deleteBtn() {
		
		var form_data = $("form[name=editTodoFrm]").serialize();
		$.ajax({
			url:"<%= request.getContextPath() %>/deleteTodo.os",
			data:form_data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				var n = json.n;

				if(n == 0) {
					alert("DB오류");
				}
				else {
					javascript:history.go(0);
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
	}
	
	// 모달창 취소 버튼
	function cancelBtn() {
		window.closeModal();
	}
	

</script>

</head>
<body>

	<div class="titleBox">
		<h2><i class="fa fa-edit fa-fw" aria-hidden="true"></i>&nbsp;&nbsp;Todo+</h2>
	</div>
	<hr style="margin: 0; color: #9d9d9d;">
	
	<div class="container">
	
		<div id="bookmark">
			<h5 class="titleText">즐겨찾는 보드</h5>
			<ul class="bookmarkUl">
			
			</ul>
		</div>
		
		
		<div id="board" style="clear: both;">
			<h5 class="titleText secondTitle">내 보드</h5>
			<ul style="padding:0; margin: 0;">
				<c:if test="${ not empty todoList }">
					<c:forEach var="todovo" items="${todoList}">
						<li class="each_todo edit_todo" data-toggle="modal" data-target="#editTodoModal"
						data-seq="${ todovo.todo_no }" data-subject="${ todovo.subject }" data-content="${ todovo.content }">
							<div class="each_todo_box">
								<span class="todo_text">${ todovo.subject }</span>
								<span class="star_box" onclick="javascript:event.cancelBubble=true; bookmark('${ todovo.todo_no }')">
									<c:if test="${ todovo.bookmark == 1 }">
										<i class="fa fa-star star_color_pink"></i> 
									</c:if>
									<c:if test="${ todovo.bookmark == 0 }">
										<i class="fa fa-star"></i> 
									</c:if>
								</span>
							</div>
							<div class="content_box">${ todovo.content }</div>
						</li>
					</c:forEach>
				</c:if>
				<%-- 할일 추가 --%>
				<li class="each_todo add_each_todo" data-toggle="modal" data-target="#addTodoModal">
					<div class="add_todo_box" style="display: table-cell; vertical-align: middle;">
						<i class="fa fa-plus" style="color: gray; font-size: 25px;"></i>
					</div>
				</li>

			</ul>
		</div>
		
	</div>
	
	
	
	
	
	<%-- ---------------- 모달 ---------------- --%>
	
	<%-- 할일 수정 모달 --%>
	<div id="editTodoModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	   <!-- Modal content-->
	   <div class="modal-content">
	     <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
	       <h4 class="modal-title" style="font-weight: bold;">할일 수정</h4>
	     </div>
	     <div class="modal-body">
	       <div class="container">
	       	  <form name="editTodoFrm">
	       	  	 <input type="hidden" name="todo_no" />
				 <table class="table table-borderless">
			      <tbody>
			        <tr>
			          <th>제목</th>
			          <td><input class="form-control title" maxlength="13" name="subject" type="text" /></td>
			        </tr>
			        <tr>
			          <th>내용</th>
			          <td><textarea cols="30" rows="10" name="content" maxlength="160" class="form-control content"></textarea></td>
			        </tr>
			      </tbody>
			    </table>
			
				<button class="btn blueBtn" style="float: right;" type="button" onclick="editTodoBtn()">수정</button>
				<button class="btn redBtn" style="float: right; margin-right: 3px;" type="button" onclick="deleteBtn()">일정 삭제</button>
			   </form>
			</div>
	     </div>
	   </div>
	 </div>
	</div>
	
	<%-- 할일 추가 모달 --%>
	<div id="addTodoModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	   <!-- Modal content-->
	   <div class="modal-content">
	     <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
	       <h4 class="modal-title" style="font-weight: bold;">할일 등록</h4>
	     </div>
	     <div class="modal-body">
            <div class="container">
				<form name="addTodoFrm">
					<%-- 임시 회원번호 --%>
					<input type="hidden" name="fk_emp_no" />
					 <table class="table table-borderless">
				      <tbody>
				        <tr>
				          <th>제목</th>
				          <td><input class="form-control title" maxlength="13" name="subject" id="subject" type="text" /></td>
				        </tr>
				        <tr>
				          <th>내용</th>
				          <td><textarea cols="30" rows="10" name="content" maxlength="320" class="form-control content" id="content"></textarea></td>
				        </tr>
				      </tbody>
				    </table>
					
					<button class="btn grayBtn" style="float: right;" type="button" onclick="cancelBtn()">취소</button>
					<button class="btn blueBtn" style="float: right; margin-right: 5px;" type="button" onclick="submitBtn()">등록</button>
				</form>
			</div>
	     </div>
	   </div>
	 </div>
	</div>
	
</body>
</html>