<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<style type="text/css">
span.item {
	color: blue;
	font-size: 12pt;
}

.require {
	/* border: solid 1px gray; */
	padding-bottom: 10px;
	padding-left: 10px;
	color: red;
	font-size: 9pt;
}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("div#requireEmpno").hide();
		$("div#requireEmail").hide();
		
		$("button#btnFind").click(function(){
			// 사원번호 입력 검사
			var emp_no = $("input#emp_no").val().trim();
			
			if(emp_no == "") {
				$("div#requireEmpno").show();
				
				return;
			} else {
				$("div#requireEmpno").hide();
			}
			
			// 이메일 입력 및 유효성 검사
			var email = $("input#email").val().trim();
			
			var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
			var pass = regExp.test(email);
			
			if(!pass) {
				$("div#requireEmail").show();
				
				return;
			} else {
				$("div#requireEmail").hide();
			}// end of if(!pass) {}---------------------
			
			$.ajax({
				url:"<%= ctxPath%>/pwdFindEnd.os",
				data:{"emp_no":$("input#emp_no").val(),
					  "email":$("input#email").val()},
				type:"POST",
				dataType:"JSON",
				success:function(json){
					
					var html = "";
					
					if(json.count == 1 && json.sendMailSuccess == true) {
						html = '<span style="font-size: 10pt;">인증키가 발송되었습니다.</span><br>' +
							   '<span style="font-size: 10pt;">인증키를 입력해주세요.</span><br>' +
							   '<input type="text" name="input_confirmCode" id="input_confirmCode" required />' +
							   '<br><br>' +
							   '<button type="button" class="btn btn-info" id="btnConfirmCode">인증하기</button>';
					} else if(json.count == 1 && json.sendMailSuccess == false) {
						html = '<span style="color: red;">메일 발송에 실패했습니다.</span>';
					} else {
						html = '<span style="color: red;">사원 정보가 없습니다.</span>';
					}// end of if(json.count == 1 && json.sendMailSuccess == true) {}
					
					$("div#div_findResult").html(html);
					
					// 입력 정보 유지 및 인증 결과 보이기
					$("input#emp_no").val(json.emp_no);
					$("input#email").val(json.email);
					$("div#findResult").show();
					
					if(json.sendMailSuccess == true) $("div#div_btnFind").hide();
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax({})----------------------
		});// end of $("button#btnFind").click(function(){})-----------------------
		
		// 인증키로 인증하기
		$(document).on("click", "button#btnConfirmCode", function(){
			var frm = document.verifyCertificationFrm;
			frm.emp_no.value = $("input#emp_no").val();
			frm.email.value = $("input#email").val();
			frm.empCertificationCode.value = $("input#input_confirmCode").val();
			frm.action = "<%= ctxPath%>/verifyCertification.os";
			frm.method = "POST";
			frm.submit();
		});// end of $(document).on("click", "button#btnConfirmCode", function(){})--------------------
		
	});// end of $(document).ready(function(){}------------------------

</script>

</head>
<body>

<form name="pwdFindFrm">
	<div id="divEmp_no" align="center">
		<span class="item">사원번호</span><br/>
		<input type="text" name="emp_no" id="emp_no" size="15" placeholder="사원번호" autocomplete="off" required />
	</div>
	<div class="require" id="requireEmpno">사원번호를 입력해주세요.</div>

	<div id="divEmail" align="center">
		<span class="item">이메일</span><br/>
		<input type="text" name="email" id="email" size="15" placeholder="abc@osung.com" autocomplete="off" required />
	</div>
	<div class="require" id="requireEmail">이메일을 입력해주세요.</div>

	<div id="div_findResult" align="center">
	</div>

	<div id="div_btnFind" align="center">
		<button type="button" class="btn btn-success" id="btnFind">찾기</button>
	</div>
</form>

<form name="verifyCertificationFrm">
	<input type="hidden" name="emp_no" />
	<input type="hidden" name="email" />
	<input type="hidden" name="empCertificationCode" />
</form>

</body>
</html>