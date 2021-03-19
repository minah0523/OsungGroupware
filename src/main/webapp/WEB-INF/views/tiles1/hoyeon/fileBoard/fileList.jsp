<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<% String ctxPath = request.getContextPath(); %>

<style>
option{
color:black;
}

div#fileheader{
margin-top: 10px;
margin-bottom:10px;
padding-bottom:10px;
display: flex;
width: 1200px;
height:30px;
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
             
   form#searchFrm{
   border:1px red solid;
      text-align: center;
    margin-bottom: 40px;
    margin-top: 10px;
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
		 
		
		//파일 업로드 버튼을 눌렀을때
		$("button#fileUpload").click(function(){
			
		 var frm = document.filefrm
			
		 frm.method="GET";
		 frm.action="<%=ctxPath%>/fileAdd.os";
		 frm.submit();
		 
		});//end of $("button#fileUpload").click(function(){}
		
		
	    $("button#fileDel").click(function(){
		 
	    	  //삭제할 파일을 선택하지 않았을때의 유효성 검사.
			 if (!$("input:checked[name='seq']").is(":checked")){ alert("삭제할 파일을 선택해주세요! ");  return false; }

				var frm = document.filefrm;
				frm.method="POST";
				frm.action="<%= request.getContextPath()%>/fileboardDel.os";
				
			
		});//end of $("button#fileDel").click(function(){}
		
		
	});//end of $(document).ready(function(){}

</script>

<div style="padding-left: 5%;">
	<h2 style="margin-bottom: 30px;">자료실</h2>
		
	<form name="filefrm">
		<div id=fileheader> 

		   <div id=fileButton style="margin-right: 20px;">
		   		<input type="checkbox" class="check" style="margin-right: 15px; ">
		 
				<button id="fileUpload"style="width:100; height:30px; background-color: #0174DF;color:white; border:0px; border-radius: 2px;">파일 업로드
				<i class="fa fa-file-o" aria-hidden="true"></i></button>
				<button id="fileDel" style="width:70px; height:30px; background-color: white; border:solid 1px #D8D8D8;border-radius: 2px; ">삭제
				<i class="fa fa-trash-o" aria-hidden="true"></i></button>
		   </div>

		</div>
		
				
		<table id="board_table">
		 
			<thead id="board_table_header">
			<tr>
                 <th style="width: 40px;">
				   <input type="checkbox">
				</th>
				<th style="width: 150px;  text-align: center;padding-left: 10px;">파일이름</th>
				<th style="width: 50px; text-align: right;">크기</th>
				<th style="width: 50px; text-align: right;">작성자</th>
				<th style="width: 50px; text-align: center;">작성일</th>
				<th style="width: 50px;  text-align: right;padding-right: 30px;">다운로드 수</th>
				 
			</tr>
			</thead>
	
			
	 	<c:forEach var="board" items="${fileList}" varStatus="status">
				 
			 <tr>
				
			 	<td style="  width: 40px;">
			 	<input style="width: 40px;" type="checkBox" id="seqCk" name="seq" class="seq" value="${board.seq}"></input>
			 	</td>
			 	 <td style="width: 200px;  text-align: center; padding-left: 20px;">${board.orgFilename}
			 	<span style="margin-left:10px;"><a href="<%= request.getContextPath()%>/filedownload.os?seq=${board.seq}">다운로드</a></span> 
			 	</td> 
			 	<td style="width: 50px;  text-align: right; padding-left: 20px;">${board.fileSize}</td> 	
			 				  
			 	<td style="width: 55px;  text-align: right;">${board.name}</td>			
			 	<td style="width: 50px;  text-align: right;" > ${board.writeDay}</td>
			 	<td style="width: 50px;  text-align: center;" >${board.download_count}</td>
			 	 			
			 </tr>
			 
			 
		</c:forEach>	 
			
		</table>
		
		
		
		<%--페이지 바  --%>
		<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">        
		${pageBar}
	    </div>
		

	</form>		
	 
</div>	