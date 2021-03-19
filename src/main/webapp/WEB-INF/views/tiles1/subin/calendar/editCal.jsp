<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style type="text/css">

	body.stop-dragging
	{
	  -ms-user-select: none; 
	  -moz-user-select: -moz-none;
	  -khtml-user-select: none;
	  -webkit-user-select: none;
	  user-select: none;
	}
	
	.titleBox{
		background-color: white;
		padding: 15px;
		margin-left: 1%;
	}
	
	.titleBox h2{
		margin: 0;
		font-weight: bold;
		color: #6a6a69;
	}
	
	.add_cal_Box{
		float: right;
	}
	
	.delBtn{
		float: left;
	}
	
	.container{
		background-color: white;
		margin: 0 auto;
		margin-top: 2%;
		width: 97%;
	}
	
	.table > tbody > tr > td {
     vertical-align: middle;
	}
	
	.oneRow{
		background-color: none;
	}
	
	.oneRow:hover{
		background-color: #fffafa;
	}
	
	.editImg{
		margin-left: 1%;
		color: gray;
		cursor: pointer;
	}
	
	.dot {
	  height: 12px;
	  width: 12px;
	  background-color: #bbb;
	  border-radius: 50%;
	  display: inline-block;
	  cursor: pointer;
	}
	
	.table-borderless > tbody > tr > td,
	.table-borderless > tbody > tr > th,
	.table-borderless > tfoot > tr > td,
	.table-borderless > tfoot > tr > th,
	.table-borderless > thead > tr > td,
	.table-borderless > thead > tr > th {
	    border: none;
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
	
	.calPlueBtn{
		border-radius: 4px;
		background-color: #0F4C81;
		color: white;
		height: 30px;
	}

</style>

<script type="text/javascript">

	var listLength;
	
	//전체 모달 닫기(전역함수인듯)
	window.closeModal = function(){
	    $('.modal').modal('hide');
	    //javascript:history.go(0);
	};

	$(document).ready(function() {
		
		readCalList();
		
		// 전체동의 체크박스 컨트롤(전체선택/해제)
		$("input.checkAll").click(function() {
			$("input.checkAgree").prop("checked", this.checked);		
		});
		
		// 전체동의 체크박스 컨트롤(개별선택시 전체동의 상태 변화)
		$(document).on("click","input.checkAgree",function() {

			if ($("input.checkAgree:checked").length == listLength) {
				$("input.checkAll").prop("checked", true);
			}else{
				$("input.checkAll").prop("checked", false);
			}
		});
		
		// 색상 변경 컨트롤
		$(document).on("change","select.colorSelect",function() {

			var calendar_no = $(this).prev().val();
			var color = $(this).val();
			
			$.ajax({
				url:"<%= request.getContextPath() %>/editCalColor.os",
				data: {calendar_no:calendar_no, color:color},
				type:"GET",
				dataType:"JSON",
				success:function(json){
					var html = "";
					if (json.n == 1) {
						readCalList();
						
						$("input.checkAll").prop("checked", false);
					}else{
						alert("DB오류");
					}
					
					$("ul.nav_ul").html(html);
					var name = $("input[name=cal_name]").val("");
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});

		});
		
		// 할일 수정 모달 연결 함수(해당 todo_no 모달로 전달)
		$(document).on("click",".editImg",function() {
			var calendar_no = $(this).data('cal_no');
			var name = $(this).data('name');

			$("input[name=calendar_no]").val( calendar_no );
			$("input#modal_cal_name").val( name );
		});
		
	});
	
	// 새 캘린더 추가 함수
	  function addCal() {
		  var name = $("input[name=cal_name]").val();
		  
		  if (name.trim() == "") {
			  alert("캘린더명을 입력해주세요.");
			  return false;
		  }
		  
		  $.ajax({
				url:"<%= request.getContextPath() %>/addCal.os",
				data: {name:name},
				type:"POST",
				dataType:"JSON",
				success:function(json){
					var html = "";
					if (json.n == 1) {
						readCalList();
						
						$("input.checkAll").prop("checked", false);
					}else{
						alert("DB오류");
					}
					
					$("ul.nav_ul").html(html);
					var name = $("input[name=cal_name]").val("");
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});
		  
	  }
	
	// 캘린더명 변경 함수
	function editCalNameBtn() {

		if ($("input#modal_cal_name").val().trim() == "") {
			alert("캘린더명을 입력해주세요.");
			$("input#modal_cal_name").val("");
			$("input#modal_cal_name").focus();
			
			return false;
		}
		
		var form_data = $("form[name=editCalNameFrm]").serialize();
		$.ajax({
			url:"<%= request.getContextPath() %>/editCalName.os",
			data: form_data,
			type:"POST",
			dataType:"JSON",
			success:function(json){

				if (json.n == 1) {
					readCalList();
					
					$("input.checkAll").prop("checked", false);
					window.closeModal();
				}else{
					alert("DB오류");
				}

				$("input#modal_cal_name").val("");
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
		
	}
	
	// 체크박스를 통해 캘린더 삭제하기
	function delCal(){
		  
		// 체크된 체크박스 수  
		var totalLength = $("input.checkAgree:checked").length;
		  
		  // 체크했는지 검사
		  if(totalLength == 0){
			  alert("삭제할 캘린더를 선택하지 않았습니다.");
			  return false;
		  }
		  
		  var sDelCalNo = "";
		  var delCalNoArr = [];
		  
		  $("input.checkAgree:checked").each(function(index) {

			  if (index+1 == totalLength) {
				  // 마지막에는 , 추가하지 않음
				  sDelCalNo += $(this).parent().next().val();
			  }else{
				  sDelCalNo += $(this).parent().next().val() + ",";
			  }
			  
		  });
		  
		  $.ajax({
				url:"<%= request.getContextPath() %>/delCal.os",
				data: {sDelCalNo:sDelCalNo},
				type:"POST",
				dataType:"JSON",
				success:function(json){
					var html = "";
					if (json.n == totalLength) {
						readCalList();
						
						$("input.checkAll").prop("checked", false);
					}else{
						alert("DB오류");
					}
					
					$("ul.nav_ul").html(html);
					var name = $("input[name=cal_name]").val("");
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});

	  }
	
	
	// 캘린더(내일정)를 읽어오는 함수
	  function readCalList(){
		  
		  $.ajax({
				url:"<%= request.getContextPath() %>/readCalList.os",
				type:"get",
				dataType:"JSON",
				success:function(json){
					var html = "";
					if (json.length > 0) {
						$.each(json, function(index, item){
							html += "<tr class='oneRow'>";
								html += "<td><input type='checkbox' class='checkAgree' /></td>";
								html += "<input type='hidden' value='" + item.calendar_no + "'>";
								html += "<td>" + item.name + 
								"<i class='fa fa-edit editImg' data-toggle='modal' data-target='#editCalNameModal'" + 
								" data-cal_no='" + item.calendar_no + "' data-name='" + item.name + "'></i></td>";
								html += "<td>";
									html += "<input type='hidden' value='" + item.calendar_no + "'>";
									html += '<select class="form-control colorSelect" style="width: 50%; height: 36px;">';
										// db color 값으로 select 색상 바로 변경....ㅠ
										if ('skyblue'.indexOf(item.color) > -1) {
											html += '<option value="skyblue" selected>하늘색</option>'
										}else{
											html += '<option value="skyblue">하늘색</option>'
										}
										
										if ('blue'.indexOf(item.color) > -1) {
											html += '<option value="blue" selected>파랑색</option>';
										}else{
											html += '<option value="blue">파랑색</option>';
										}
										
										if ('black'.indexOf(item.color) > -1) {
											html += '<option value="black" selected>검정색</option>';
										}else{
											html += '<option value="black">검정색</option>';
										}
										
										if ('green'.indexOf(item.color) > -1) {
											html += '<option value="green" selected>초록색</option>';
										}else{
											html += '<option value="green">초록색</option>';
										}

								html += '</select>';
								html += "</td>";
								html += "<td>";
								html += "<span class='dot' style='float: left; background-color: " + item.color + "'></span>";
								html += "</td>";
							html += "</tr>";
						});
					}else{
						html += "<tr class='oneRow'>";
						html += "<td colspan='4' style='text-align: center;'>리스트가 존재하지 않습니다.</td>";
						html += "</tr>";
					}
					
					$("tbody.calList").html(html);
					listLength = json.length;
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});
		  
	  }
	
	function backCal() {
		location.href="<%= request.getContextPath() %>/goCalendar.os";
	}
	
	
</script>

</head>
<body class="stop-dragging">

	<div class="titleBox">
		<h2><i class="fa fa-cog" style="padding-right: 10px;"></i> 내 캘린더 관리</h2>
	</div>
	<hr style="margin: 0; color: #9d9d9d;">
	
	<div class="container">   
	
	  <div class="add_cal_Box">
	  	<label style="font-weight: bold;">캘린더 이름&nbsp;&nbsp;&nbsp;</label>
	  	<input type="text" maxlength="16" name="cal_name" id="addCalInput"/>
	  	<button type="button" class="btn calPlueBtn" onclick="addCal()">추가</button>
	  </div>  
	  <label class="delBtn" style="cursor: pointer;" onclick="delCal()"><i class= "fa fa-trash-o fa-fw" aria-hidden="true"></i>삭제</label>
	  
	  <table class="table edit_cal_table">
	    <thead>
	      <tr>
	        <th class="col-sm-1"><input type="checkbox" class="checkAll" /></th>
	        <th class="col-sm-9">캘린더</th>
	        <th class="col-sm-2">색상</th>
	      </tr>
	    </thead>
	    <tbody class="calList">
	      
	    </tbody>
	  </table>
	  
	</div>
	
	<div style="text-align: center;">
		<button class="btn grayBtn" onclick="backCal()">캘린더로</button>
	</div>
	
	
	<%-- ---------------- 모달 ---------------- --%>
	
	<%-- 캘린더명 변경 모달 --%>
	<div id="editCalNameModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog">
	   <!-- Modal content-->
	   <div class="modal-content">
	     <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
	       <h4 class="modal-title" style="font-weight: bold;">캘린더명 변경</h4>
	     </div>
	     <div class="modal-body">
	       <div class="container">
	       	  <form name="editCalNameFrm">
	       	  	 <input type="hidden" name="calendar_no" />
				 <table class="table table-borderless">
			      <tbody>
			        <tr>
			          <th style="border: solid 0px red; font-size: 12pt;">캘린더명</th>
			          <td><input class="form-control title" maxlength="16" id="modal_cal_name" name="name" type="text" /></td>
			        </tr>
			      </tbody>
			    </table>
			
				<button class="btn grayBtn" style="float: right;" type="button" onclick="window.closeModal()">취소</button>
				<button class="btn blueBtn" style="float: right; margin-right: 3px;" type="button" onclick="editCalNameBtn()">수정</button>
			   </form>
			</div>
	     </div>
	   </div>
	 </div>
	</div>

</body>
</html>