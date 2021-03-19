<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<style type="text/css">
	.sendLabel{
		margin-right: 15px;
	}
	.form-wrap {
		margin-bottom: 30px;
	}
	.form-sendDate {
		padding-top: 20px;
	}
</style>

<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>
<script type="text/javascript">
  $(document).ready(function () {
	  
	  // 년, 월
	  var year_month = document.getElementById('selectSendDate').value = new Date().toISOString().substring(0, 10);
	  
	  // 시간
	  var date = new Date();
	  var hour = date.getHours();
	  $("#selectSendTimeHour").val(hour);
	  
	  // 분 
	  var minute = date.getMinutes();
	  $("#selectSendTimeMinute").val(minute);
	  
	  $("#selectSendTimeHour option").filter(function() { // option 중의 text가 minute과 있으면 select 해라
		    //may want to use $.trim in here
		    return $(this).text() == hour;
	  }).attr('selected', true);
	  
	  /*
	  $("#selectSendTimeMinute option").filter(function() { 
		    //may want to use $.trim in here
	  		return $(this).text() == minute;
	  }).attr('selected', true);	  
	  */
	  
	  $("#selectSendTimeMinute option").eq(0).attr('selected', true);
	  
  });
  
  
</script>

<div class="reservation_Content">

	<form>
		<div class="form-group form-wrap form-sendDate">
			<label for="selectSendDate" class="sendLabel">발송날짜</label>
			<input type="date" id='selectSendDate'/>
		</div>
		
		<div class="form-group form-wrap">
		  <label for="selectSendTime" class="sendLabel">발송시간</label>
		  <select class="form-control" id="selectSendTimeHour" >
		  	<c:forEach begin="0" end="9" varStatus="loop">
		  		 <option>0${loop.index}</option>
		  	</c:forEach>
		  	<c:forEach begin="0" end="9" varStatus="loop">
		  		 <option>1${loop.index}</option>
		  	</c:forEach>	
		  	<c:forEach begin="0" end="3" varStatus="loop">
		  		 <option>2${loop.index}</option>
		  	</c:forEach>		  		  	
		  </select>
		  <span>시</span>
		  <select  class="form-control" id="selectSendTimeMinute">
		  		<option>00</option>
		  	<c:forEach begin="10" end="50" varStatus="loop" step="10">
		  		 <option>${loop.index}</option>
		  	</c:forEach>
		  </select>
		  <span>분</span>
		</div>
	</form>

	 
</div>
