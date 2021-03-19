<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/login.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<style type="text/css">
label#labelRemember {
	margin: 0 10px;
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

$('.js-tilt').tilt({
	scale: 1.1
})

(function ($) {
"use strict";


/*==================================================================
[ Validate ]*/
var input = $('.validate-input .input100');

$('.validate-form').on('submit',function(){
var check = true;

for(var i=0; i<input.length; i++) {
    if(validate(input[i]) == false){
        showValidate(input[i]);
        check=false;
    }
}

return check;
});


$('.validate-form .input100').each(function(){
$(this).focus(function(){
   hideValidate(this);
});
});

function validate (input) {
if($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
    if($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
        return false;
    }
}
else {
    if($(input).val().trim() == ''){
        return false;
    }
}
}

function showValidate(input) {
var thisAlert = $(input).parent();

$(thisAlert).addClass('alert-validate');
}

function hideValidate(input) {
var thisAlert = $(input).parent();

$(thisAlert).removeClass('alert-validate');
}

})(jQuery);

/*==================================================================*/

</script>
</head>
<body>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 로컬스토리지에 저장한 사원번호 넣어주기
		var loginEmp_no = localStorage.getItem('saveEmp_no');
		if(loginEmp_no != null) {
			$("input#emp_no").val(loginEmp_no);
			$("input:checkbox[id=remember]").prop("checked", true);
		}// end of if(loginEmp_no != null) {}-------------------------
	
		$("div#requireEmpno").hide();
		$("div#requireEmppwd").hide();
		
		$("button#btnLogin").click(function(){
			login();
		});//end of $("button#btnLogin").click(function(){})----------------------
		
		$("input#emp_pwd").keyup(function(event){
			if(event.keyCode == 13) {
				login();
			}// end of if(event.keyCode == 13){}-----------------
		});// end of $("input#emp_pwd").keyup(function(){})----------------------
	
	});// end of $(document).ready(function(){})------------------------
	
	function sendForm() {
		
		var frm = document.loginFrm;
		frm.action = "<%= ctxPath%>/loginEnd.os";
		frm.method = "POST";
		frm.submit();
		
	}// end of function sendForm() {}----------------------
	
	function login() {
		// 사원번호 입력 검사
		var emp_no = $("input#emp_no").val().trim();
		
		if(emp_no == "") {
			$("div#requireEmpno").show();
			
			return;
		} else {
			$("div#requireEmpno").hide();
		}
		
		// 비밀번호 입력 검사
		var emp_pwd = $("input#emp_pwd").val().trim();
		
		if(emp_pwd == "") {
			$("div#requireEmppwd").show();
			
			return;
		} else {
			$("div#requireEmppwd").hide();
		}
		
		// 사원번호 저장
		if($("input:checkbox[id=remember]").prop("checked")) {
			localStorage.setItem('saveEmp_no', $("input#emp_no").val());
		} else {
			localStorage.removeItem('saveEmp_no');
		}// if($("input:checkbox[id=remember]").prop("checked")) {}------------------
		
		sendForm();
	}// end of function login() {}----------------------

</script>

<div class="limiter">
	<div class="container-login100">
		<div class="wrap-login100">
			<div class="login100-pic js-tilt" data-tilt>
				<img src="https://colorlib.com/etc/lf/Login_v1/images/img-01.png" alt="IMG">
			</div>

			<form class="login100-form validate-form" name="loginFrm">
				<span class="login100-form-title">
					OSUNG Office
				</span>

				<div class="wrap-input100 validate-input" data-validate = "사원번호를 입력하세요.">
					<input class="input100" id="emp_no" type="text" name="emp_no" placeholder="사원번호">
					<span class="focus-input100"></span>
					<span class="symbol-input100">
						<i class="fa fa-envelope" aria-hidden="true"></i>
					</span>
				</div>
				<div class="require" id="requireEmpno">사원번호를 입력해주세요.</div>

				<div class="wrap-input100 validate-input" data-validate = "비밀번호를 입력하세요.">
					<input class="input100" id="emp_pwd" type="password" name="emp_pwd" placeholder="비밀번호">
					<span class="focus-input100"></span>
					<span class="symbol-input100">
						<i class="fa fa-lock" aria-hidden="true"></i>
					</span>
				</div>
				<div class="require" id="requireEmppwd">비밀번호를 입력해주세요.</div>

				<div class="container-login100-form-btn">
					<button type="button" class="login100-form-btn" id="btnLogin">
						접속
					</button>
				</div>

				<div class="text-center p-t-12">
					<span class="txt1">
						<input type="checkbox" id="remember" /><label for="remember" id="labelRemember">사원번호 저장</label>
					</span>
					
					<a class="txt2" data-toggle="modal" data-target="#pwdFind" data-dismiss="modal" data-backdrop="static" style="cursor: pointer;">
						비밀번호 찾기
					</a>
				</div>

				<div class="text-center p-t-136"></div>
			</form>
		</div>
	</div>
</div>

<%-- ===== 비밀번호 찾기 Modal ===== --%>
<div class="modal fade" id="pwdFind" role="dialog">
	<div class="modal-dialog">
    
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">비밀번호 찾기</h4>
			</div>
			<div class="modal-body">
				<div id="pwFind">
					<iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath()%>/pwdFind.os">  
					</iframe>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
			</div>
		</div>
      
	</div>
</div>

</body>
</html>