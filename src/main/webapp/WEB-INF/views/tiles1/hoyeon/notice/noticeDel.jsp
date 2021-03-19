 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath();%>

<style type="text/css">
 
 div#frmDiv{
 display:inline-block;
 text-align: center;
 margin:auto;
 margin-top:100px;
 } 
 
 
	#table th{margin:10 10 5 0px;}
	#table th, #table td{padding:70px;}
	
	#table {border-collapse: collapse;
	      
	        }
	          
	input#title{
	width:60%;
	height:30px;
	}          
	select{
	width:11%;
	height:30px;
	
	}          
	td#boardButton{
	text-align: center;
	/* border:solid 1px red; */
	padding: 20px;
	}
	
	button{
	border: none;
	width: 90px;
	height:50px;
	border-radius:5px;
	}
	
	button#boardDel{
	background-color:#0F4C81;
	color:white;
	}
	button#no{
	background-color:#D8D8D8;
	}
	
	th#yesORno{
	text-align: center;
 
	}
	thead{
	padding-top: 150px;
	padding-bottom: 50px;

	background: white;
	border:solid 2px #D8D8D8;
	
	}
 
</style>
<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>  
<script type="text/javascript">
 $(document).ready(function(){
	 
	  $("button#boardDel").click(function(){
		 
		  var frm= document.boardDelFrm;
		  frm.method="POST";
		  frm.action= "<%=ctxPath%>/noticeDelEnd.os";
		  frm.submit(); 
	  });
	  
	  
 });// $(document).ready(function(){}----------------------------------------------
</script>
<center>
	<div id= frmDiv style="padding-left: 5%;">
		<h2></h2>
			<form name="boardDelFrm" enctype="multipart/form-data">
				<table id="table">
					<thead>
						<tr>
							<th id="yesORno">정말로 삭제하시겠습니까?</th> 
	      			    <tr>
					</thead>
					<tbody>
      			 	   <tr>
	      			    	<td id="boardButton">
	      			    		<button type="button" id="boardDel">삭제</button>
	      			    		<button type="button" id="no" onclick="javascript:history.back()">취소</button>
	      			    		  <input type="hidden" name="seq" id="seq" value="${seq}" />
	      			    	 
	      			    	</td>
	      			    </tr>
					 </tbody>
				</table>
			</form>
	</div>

</center>