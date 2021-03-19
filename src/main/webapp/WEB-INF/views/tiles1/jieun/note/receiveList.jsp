<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

  #miniHeader {
  	 display: inline-block;
  }
  
  #trash, #btnReload, #readReceive, #btnOrder{
  	 border: 0;
  	 background-color: white; 
  }
  
  ul#miniHeaderGroup, .miniHeaderList {
  	 list-style-type: none;
  	 display: inline-block;
  }
  
  .miniHeaderList {
  	 margin-right: 15px; 
  }
  
  #trash:hover , #btnReload:hover, #readReceive:hover
  , #btnOrder:hover{
  	 background-color: #EEEEEE;
  }
  
  #note_searchType, #searchWord, 
  #note_serachWord, #note_search,
  #btnSearch {
  	 display: inline-block;
  }
  
  #note_searchType {
  	 margin-left: 49%;
  }

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// ===== 검색타입과 검색어 유지 시키기 ===== //
		
	    if(${searchWord != null} ) { // 또는 if(${not empty paraMap}) 도 가능
		    // 넘어온 paraMap이 null이 아니라면(값이 있다면)
		    $("select#searchType").val("${searchType}");
		    $("input#searchWord").val("${searchWord}");
	    }
		
	    if(${searchWord == null}) {
		    $("select#searchType").val("note_title");
		    $("input#searchWord").val("");
	    }
	    
	    // ===== 페이징 처리 ===== //
	    $("select#sizePerPage").change(function(){
	    	
			var frm = document.pagingFrm;
			frm.method = "GET";
		    frm.action = "<%= ctxPath%>/jieun/note/receiveList.os";
		    frm.submit();				
	    	
	    });	    
		
		// 전체선택 및 해제
		$("input#checkAll").click(function(){
			if($(this).prop("checked")) {
				$("input[name='chkBox']").prop("checked", true);				
			}
			else {
				$("input[name='chkBox']").prop("checked", false);
			}
		});	    
		
		// ===== 새로고침 기능 ===== // 
		$("li#fiveMin").click(function(){
			window.setTimeout('window.location.reload()', 300000); 
		});
		
		$("li#tenMin").click(function(){
			window.setTimeout('window.location.reload()', 600000);
		});
		
		$("li#fifteenMin").click(function(){
			window.setTimeout('window.location.reload()', 900000);
		});
		
		// ===== 정렬 기능 ===== //
		
		$("ul#orderList li").click(function(){
			var orderType = $(this).attr('id');
			location.href="<%=request.getContextPath() %>/jieun/note/receiveList.os?orderType="+orderType;
			
		});
		
	});
	
	// 제목 클릭 시 쪽지 상세 페이지 보여주기
	function goReceiveOneDetail(note_no) {
		
    	var frm = document.goReceiveOneDetailFrm;
	    frm.note_no.value = note_no;
	    
	    frm.method = "GET";
	    frm.action = "<%= ctxPath%>/jieun/note/receiveOneDetail.os";
	    frm.submit();		
	}
	
	// ===== 검색 버튼 눌렀을 경우 ===== //
	function goNoteSearch() {
		
		var searchWord = $("input#searchWord").val().trim();
		if(searchWord == "") {
			alert("검색어를 입력하세요!");
			return false;
		}
		
		var frm = document.goReceiveListSelectFrm;
		frm.method = "GET";
		// frm.selectType.value = selectType;
		// frm.searchWord.value = searchWord;
	    frm.action = "<%= ctxPath%>/jieun/note/receiveList.os";
	    frm.submit();		
	    
	}
	
	// ===== 삭제 버튼 눌렀을때  ===== //
	function goNoteTrashDelete() { // 휴지통으로 이동
		
		// 체크된 갯수 세기
		var chkCnt = $("input[name='chkBox']:checked").length;
		
		// 배열에 체크된 행의 note_no를 넣자
		var arrChk = new Array();
		
		$("input[name='chkBox']:checked").each(function(){
			
			var note_no = $(this).attr('id');
			arrChk.push(note_no);
		});
		
		if(chkCnt == 0) {
			alert("선택된 쪽지가 없습니다!");
		}
		else{
			
			$.ajax({
		                url : "<%=request.getContextPath() %>/jieun/note/moveToTrashcanReceive.os",
		                type: "GET",
		                data: {"str_note_no" : JSON.stringify(arrChk),  // 배열을 문자열로 바꿔서 Controller 에 전달하기
		                	   "cnt": chkCnt,
		                	   "login_emp_no":${login_emp_no} },
		                dataType:"JSON",
		                success: function(json){
		                    
		     			    var result = json.result;
		                	
		                	if(result != 1) {
		                        alert("쪽지테이블에서 삭제 실패했습니다!");
		                        window.location.reload();
		                    }
		                    else{
		                        alert("쪽지테이블에서 삭제 성공했습니다!");
		                        window.location.reload();
		                    }
		                	
		                },
				        error: function(request, status, error){
						       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
			});
        }					
		
	}
	
	// ===== 읽음 버튼 눌렀을때 ===== // 
	function goReadReceive() {
		
		// 체크된 갯수 세기
		var chkCnt = $("input[name='chkBox']:checked").length;
		
		// 배열에 체크된 행의 note_no를 넣자
		var arrChk = new Array();
		
		$("input[name='chkBox']:checked").each(function(){
			
			var note_no = $(this).attr('id');
			arrChk.push(note_no);
			
		});		
		
		if(chkCnt == 0) {
			alert("선택된 쪽지가 없습니다!");
		}
		else{
			
			$.ajax({
		                url : "<%=request.getContextPath() %>/jieun/note/changeReadStatus.os",
		                type: "GET",
		                data: {"str_note_no" : JSON.stringify(arrChk),  // 배열을 문자열로 바꿔서 Controller 에 전달하기
		                	   "cnt": chkCnt},
		                dataType:"JSON",
		                success: function(json){
		                    
		     			    var n = json.n;
		                	
		                	if(n == 1) {
		                		console.log("읽음 상태 변경 성공!!");
		                		alert("읽었습니다!");
		                	}
		                	
		                },
				        error: function(request, status, error){
						       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
				});
        }					
		
	}

</script>


<div class="row bg-title"  style="border-bottom: solid .025em gray;">
	<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
	    <h4 class="page-title" style="color:#233B49; padding-left: 25px;">받은 쪽지함</h4>
	</div>
	
	<form name="goReceiveListSelectFrm" >
	
    <div id="note_searchType" style="display: inline-block;">
        <select class="form-control" id="searchType" name="searchType" data-placeholder="Choose a Category" tabindex="1">
	    	<option value="note_title" selected="selected">제목</option>
	    	<option value="emp_name">사원명</option>			
        </select>  
    </div>	 
    
    <div id="note_serachWord">
        <input id="searchWord" name="searchWord" type="text" class="form-control" placeholder="John doe">
    </div>        
    
    <div class="input-group" id="note_search"> 
    	<!-- <span class="input-group-btn"> -->
        <button type="button" id="btnSearch" onclick="goNoteSearch()" class="btn waves-effect waves-light btn-info" style="height: 35px;">
        	<i class="fa fa-search"></i>
        </button>
        <!-- </span> -->
    </div>
    
    </form>
        	
</div> 

<div class="row">
    <div class="col-sm-12">
        <div class="white-box" style="padding-top:5px;">
			<div id="miniHeader">
				<ul id="mimiHeaderGroup" style="padding: 0px; margin-bottom: -15px;">
					<li class="miniHeaderList">
						<button type="button" id="trash" onclick="goNoteTrashDelete()">
							<i class="fa fa-trash-o fa-fw" aria-hidden="true"></i>
							삭제
						</button>
					</li>
					<li class="miniHeaderList">
						<button type="button" id="readReceive" onclick="goReadReceive()" >
							<i class="fa fa-envelope-o fa-fw" aria-hidden="true"></i>
							읽음
						</button>
					</li>
					
					<li class="miniHeaderList dropdown " style="margin-left: 740px; " data-toggle="tooltip" data-placement="top" title="내림차순 정렬">
						<button type="button" id="btnOrder" class="dropdown-toggle " data-toggle="dropdown" >
							<i class="fa fa-sort-amount-desc fa-fw" aria-hidden="true"></i>
							정렬
							<span class="fa fa-angle-down fa-fw"></span>
						</button>
					    <ul class= "dropdown-menu" id="orderList">
					      <li id="emp_name"><a href="#">보낸사람</a></li>
					      <li id="note_title"><a href="#">제목</a></li>
					      <li id="note_write_date"><a href="#">받은날짜</a></li>
					    </ul>							
					</li>
					
					<li class="miniHeaderList dropdown">
						<button type="button" id="btnReload" class="dropdown-toggle " data-toggle="dropdown" > <!-- style="background: white; border: white;" -->
							<i class="fa fa-repeat fa-fw" aria-hidden="true"></i>
							새로고침
						</button>
						<ul class= "dropdown-menu" id="ReloadTimeList">
					      <li id="fiveMin"><a href="#">5분</a></li>
					      <li id="tenMin"><a href="#">10분</a></li>
					      <li id="fifteenMin"><a href="#">15분</a></li>
					    </ul>
					</li>
					<!-- 페이징처리 -->
					<li class="miniHeaderList" style="margin-top: 5px; margin-right: 0px;">
					<form name="pagingFrm">
						<select class="form-control" id="sizePerPage" name="sizePerPage" style="height: 32px;">
								<option value="20" selected="selected">20</option>
								<option value="40">40</option>			
								<option value="60">60</option>
						</select>
					</form>
					</li>
				</ul>
			</div>
			
            <div class="table-responsive" style="margin-top: 20px;">
                <table class="table">
                     
                    <thead>
                        <tr>
                            <th style="width: 40px;">
								<input type="checkbox" id="checkAll">
							</th>
                            <th  style="width: 40px;">
                            	<span class="fa fa-star-o"></span>
                            </th>
                            <th  style="width: 40px;">
                            	<span class= "fa fa-paperclip"></span>
                            </th>
                            <th  style="width: 70px;">보낸사원ID</th>
                            <th  style="width: 70px;">사원명</th>
                            <th  style="width: 500px;">제목</th>
                            <th  style="width: 120px;">날짜</th>
                            <!-- <th  style="width: 40px;">크기</th> -->
                        </tr>
                    </thead>
                    
                    <tbody>
                    	<c:if test="${not empty noteReceiveList}">
	                    	<c:forEach var="receivelist" items="${noteReceiveList}" varStatus="status">
		                        <tr>
		                            <td style="width: 40px;"> 
		                            	<input type="checkbox" name="chkBox" id="${receivelist.note_no}">
		                            </td>
		                            <td style="width: 40px;">
		                            	<span class="fa fa-star-o"></span>
		                            </td>  
		                            
		                            <c:if test="${not empty receivelist.note_orgfilename}">                          
			                            <td style="width: 40px;">
			                            	<span class= "fa fa-paperclip"></span> 	
			                            </td>
		                            </c:if>
		                            <c:if test="${empty receivelist.note_orgfilename}">
		                            	<td style="width: 40px;">
		                            	</td>		                            
		                            </c:if>
		                            <td style="width: 70px;">${receivelist.fk_emp_no_send}</td>
		                            <td style="width: 70px;">${receivelist.emp_name}</td>
		                            <td style="width: 500px;" onclick="goReceiveOneDetail('${receivelist.note_no}')">
		                            	${receivelist.note_title}
		                            </td>
		                            <td style="width: 120px;">${receivelist.note_write_date}</td>
		                            <!-- <td style="width: 40px;">크기</td> -->
		                        </tr>                    		
	                    	</c:forEach>
                    	</c:if>
                    	<c:if test="${empty noteReceiveList}">
                    		<tr>
                    			<td colspan="8" style="text-align: center;">데이터가 없습니다.</td>
                    		</tr>
                    	</c:if>
                    </tbody>
                </table>
            </div>
            
			<%-- === 페이지 바 보여주기 === --%>
			<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto">
			   		${pageBar}
			</div>              
            
        </div>
    </div>
</div>
<!-- /.row -->        
   
<form name = "goReceiveOneDetailFrm">
	<input type="hidden" name="note_no" />
	<input type="hidden" name="goBackURL" value="${goBackURL}" />  
</form>