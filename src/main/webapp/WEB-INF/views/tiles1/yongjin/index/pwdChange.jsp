<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<% String ctxPath = request.getContextPath(); %>

<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">
div, span {
	/* border: solid 1px gray; */
}

div#side, div#content {
	display: inline-block;
}

div#side {
	width: 250px;
	border-right-color: #999;
}

div#content {
	width: 800px;
}

li.info {
	font-size: 14px;
	padding: 20px 24px;
}

div#side {
	float: left;
}

span#title {
	font-size: 22px;
	margin: 0 3px 0 0;
}

tr {
	line-height: 42px;
}

ul#ulMenu {
	list-style: none;
	padding-left: 0;
}

a {
	color: black;
}

a#basis {
	color: #02A1C0;
}

td.tdPwd {
	position: relative;
    padding: 20px;
}

input.pwdChange {
	width: 300px;
    height: 30px;
    border: 0;
    border-bottom: solid 1px #E0E0E0;
}

i.fa-eye-styleClass {
    position: absolute;
    left: 88%;
    top: 32px;
    cursor: pointer;
}

.require {
	/* border: solid 1px gray; */
	padding-bottom: 10px;
	padding-left: 10px;
	color: red;
	font-size: 9pt;
}

a#saveModify {
	width: 65px;
	height: 36px;
	background-color: #00A1B9;
	margin: 0px 4px;
	padding: 0 20px;
}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("div.require").hide();
		
		// 비밀번호 보기/숨기기
		$('i').on('click', function(){
	        $('input').toggleClass('active');
	        
	        if($('input').hasClass('active')) {
	            $(this).attr('class',"fa fa-eye-slash fa-lg fa-eye-styleClass")
	            .prev('input').attr('type', "text");
	        } else{
	            $(this).attr('class',"fa fa-eye fa-lg fa-eye-styleClass")
	            .prev('input').attr('type', 'password');
	        }// end of if($('input').hasClass('active')) {}--------------------
	    });// end of $('i').on('click', function(){})--------------------
		
	});// end of $(document).ready(function(){})------------------------
	
	
	function pwdRevise() {
		
		// 현재 비밀번호
		var before_pwd = $("input#before_pwd").val();
		
		if(before_pwd == "") {
			$("div#requireBefore_pwd").show();
			$("input#before_pwd").empty();
			return;
		} else {
			$("div#requireBefore_pwd").hide();
		}// end of if(!test) {}----------------------
		
		// 새 비밀번호
		var emp_pwd = $("input#emp_pwd").val();
		
		var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		var test = regExp.test(emp_pwd);
		
		if(!test) {
			$("div#requireEmp_pwd").show();
			$("input#emp_pwd").empty();
			return;
		} else {
			$("div#requireEmp_pwd").hide();
		}// end of if(!test) {}----------------------
		
		// 새 비밀번호
		var emp_pwd_check = $("input#emp_pwd_check").val();
		
		if(emp_pwd != emp_pwd_check) {
			$("div#requireEmp_pwd_check").show();
			$("input#emp_pwd_check").empty();
			return;
		} else {
			$("div#requireEmp_pwd_check").hide();
		}// end of if(!test) {}----------------------
		
		var frm = document.formContactCreate;
		frm.action = "<%= ctxPath%>/pwdChangeEnd.os";
		frm.method = "POST";
		frm.submit();
		
	}// end of function pwdRevise() {}--------------------------

</script>

<div id="bodyProfile">
	<div class="go_side" id="side" style="padding-bottom: 0px;">
		<nav class="side_menu">
		    <ul id="ulMenu">
		        <li class="info  on "><a href="<%= ctxPath%>/profile.os">기본정보</a></li>
		        <li class="info "><a href="<%= ctxPath%>/pwdChange.os" id="basis">비밀번호변경</a></li>
		    </ul>
		</nav>
	</div>
	
	<div id="content">
		<header>
			<h1>   
				<span id="title">비밀번호변경</span>	
			</h1>	
		</header>
			
		<div class="content_page">
			<form id="contactCreateId" name="formContactCreate">
				<fieldset>
					<table class="form_type">
						<colgroup>
							<col width="130px">
							<col width="*">
						</colgroup>
						<tbody>
						<tr>
							<th>
								<span>현재 비밀번호</span>
							</th>
							<td class="tdPwd">
								<input name="before_pwd" id="before_pwd" class="input wfix_large pwdChange" type="password" />
								<i class="fa fa-eye fa-lg fa-eye-styleClass"></i>
								<div class="require" id="requireBefore_pwd">올바른 비밀번호를 입력해주세요.</div>
								<input type="hidden" name="emp_no" value="${sessionScope.loginemp.emp_no}" />
							</td>
						</tr>
						<tr>
							<th>
								<span>새 비밀번호</span>
							</th>
							<td class="tdPwd">
								<input name="emp_pwd" id="emp_pwd" class="input wfix_large pwdChange" type="password" />
								<i class="fa fa-eye fa-lg fa-eye-styleClass"></i>
								<div class="require" id="requireEmp_pwd">형식에 맞지 않습니다.</div>
							</td>
						</tr>
						<tr>
							<th>
								<span>새 비밀번호 확인</span>
							</th>
							<td class="tdPwd">
								<input name="emp_pwd_check" id="emp_pwd_check" class="input wfix_large pwdChange" type="password" />
								<i class="fa fa-eye fa-lg fa-eye-styleClass"></i>
								<div class="require" id="requireEmp_pwd_check">일치하지 않습니다.</div>
							</td>
						</tr>
						
						<tr class="line"><td colspan="2"><hr></td></tr>						
						</tbody>
					</table>
				</fieldset>
			</form>
			
			<div>
				· 8~15자의 영문 대/소문자, 숫자, 특수기호 조합을 사용할 수 있습니다.<br>
				· 생년월일, 전화번호 등 개인정보와 관련된 숫자, 연속된 키보드배열과 같이 쉬운 비밀번호는 타인이 쉽게 알아낼 수 있으니 사용을 자제해 주세요.<br>
				· 이전에 사용했던 비밀번호나 타 사이트와 다른 비밀번호를 사용하고 비밀번호는 주기적으로 변경해 주세요.
			</div>
			<br><br>
			<div class="page_action_wrap">
				<a onclick="pwdRevise();" id="saveModify"><span>저장</span></a>
			</div>
		</div>
	</div>
</div>