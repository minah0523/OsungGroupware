<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<style type="text/css">

   table, th, td, input, textarea {border: solid #a0a0a0 1px;}
   
   #table {border-collapse: collapse;
          width: 1175px;
          }
   #table th, #table td{padding: 5px;}
   #table th{ 
   		background-color: #6F808A; 
   		color: white;
   }
   
   .buttonList {
   		display: inline-block;
   		list-style-type: none;
   		margin-right: 15px;
   }
   #buttonGroup {
   		padding: 0px;
   }
   
   button {
   		border-radius: 3px !important;
   }
   /*input file의 기본 모습을 제거*/
   #note_filename_upload {
	    width: 0.1px;
		height: 0.1px;
		opacity: 0;
		overflow: hidden;
		position: absolute;
		z-index: -1;   
   }
   
   #note_filename_upload + label {
	    border: 1px solid gray; /*1px solid #d9e1e8;*/
	    background-color: #fff;
	    color: black; /*#2b90d9;*/
	    padding: 6px 12px 0px 12px;
	    font-weight: 400;
	    font-size: 14px;
	    box-shadow: 1px 2px 3px 0px #f2f2f2;
	    outline: none;
	    margin-left: 10px;
	    margin-bottom: 0px;
	    height: 30px;
   }
 
   #note_filename_upload:focus + label,
   #note_filename_upload + label:hover {
    	cursor: pointer;
   }
   
   /* named upload */ 
   .upload-name { 
   		display: inline-block; 
   		padding: .5em .75em;
   		font-size: inherit; 
   		font-family: inherit; 
   		line-height: normal; 
   		vertical-align: middle; 
   		background-color: #f5f5f5; 
   		border: 1px solid #ebebeb; 
   		border-bottom-color: #e2e2e2; 
   		-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
   		-moz-appearance: none; 
   		appearance: none; 
   		height: 30px;
   		margin-bottom: .30em;
   		width: 250px;
   	}
   	
   	/* 주소록 CSS 시작 */
   	.content_layout_address {
   		width: 980px;
   		background-color:#fff;
   
   }
   
   .nav_layer{
   		width:100%;
   		height: 25px;
   		display: block;
   		float: left;
   }
   
   .tab_nav li {
	    float: left;
	    margin: 0 0 -1px 24px;
	    padding: 0;
	    cursor: pointer;
	    height: 40px;
	    line-height: 40px;
	    font-size: 13px;
	    color: #999;   
	    
   		list-style-type: none;		
   }
   
   .tab_nav li:first-child {
   		margin: 0;
   }
   
   .ul_state_active {
   
   	    border-bottom: 1px solid #000;
   } 
   
   .tab_wrap {
   		width: 550px;
   		display: inline-block;
   }
	.tree, .tree ul {
	    margin:0;
	    padding:0;
	    list-style:none
	}
	.tree ul {
	    margin-left:1em;
	    position:relative
	}
	.tree ul ul {
	    margin-left:.5em
	}
	.tree ul:before {
	    content:"";
	    display:block;
	    width:0;
	    position:absolute;
	    top:0;
	    bottom:0;
	    left:0;
	    border-left:1px solid
	}
	.tree li {
	    margin:0;
	    padding:0 1em;
	    line-height:2em;
	    color:#369;
	    font-weight:700;
	    position:relative
	}
	.tree ul li:before {
	    content:"";
	    display:block;
	    width:10px;
	    height:0;
	    border-top:1px solid;
	    margin-top:-1px;
	    position:absolute;
	    top:1em;
	    left:0
	}
	.tree ul li:last-child:before {
	    background:#fff;
	    height:auto;
	    top:1em;
	    bottom:0
	}
	.indicator {
	    margin-right:5px;
	}
	.tree li a {
	    text-decoration: none;
	    color:#369;
	}
	.tree li button, .tree li button:active, .tree li button:focus {
	    text-decoration: none;
	    color:#369;
	    border:none;
	    background:transparent;
	    margin:0px 0px 0px 0px;
	    padding:0px 0px 0px 0px;
	    outline: 0;
	}   
   .father {
   		display: flex;
   }
   .search {
   		width: 338px;
   		border-radius: 3px;
   		border: 2px solid #adb5bd;
   }
   .emp_search {
   		margin-bottom: 0; 
   }
   .search, .btnSearch {
   		height: 32px;   
   } 
   span.btn_bg {
        position: relative;
	    cursor: pointer;
	    padding: 4px 4px 6px;
	    background-color: #fff;
	    border: 1px solid #ddd;
	    text-align: left;
	    margin-bottom: 10px;
   }
   .addArea {
   		margin-top: 147px;
   }
   .addList, li {
   		list-style-type: none;
   }
   div.receive_wrap div.receive_list ul {
	    border: 1px solid #666;
	    height: 105px;
	    overflow-x: hidden;
	    background: #f9f9f9;
	    padding: 0 4px;
   } 
   div.receive_wrap div.receive_list {
	    display: inline-block;
	    margin: 10px 0 0 0;
	    width: 270px;
	    height: 135px;
   }
   	/* 주소록 CSS 끝 */

    /* 예약발송 CSS 시작*/
	.sendLabel{
		margin-right: 15px;
	}
	.form-wrap {
		margin-bottom: 30px;
	}
	.form-sendDate {
		padding-top: 20px;
	}    
    /* 예약발송 CSS 끝*/

</style>

<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>

<script type="text/javascript">

  //전체 모달 닫기(전역함수인듯)
  window.closeModal = function(){
      $('.modal').modal('hide');
      // javascript:history.go(0);
  };

  $(document).ready(function () {
	  
	    // 글 작성 들어왔을때 받는사람은 무조건 모달창에서 선택하기(비활성화)
	    $("input#fk_emp_no_receive").attr("disabled", true);
  	
	  	// ====== 선택된  파일에서 파일명만 추출 ====== // 
		var fileTarget = $('#note_filename_upload'); 
		fileTarget.on('change', function(){ // 값이 변경되면 
		
			// alert("파일 선택 완료");	
			if(window.FileReader){ // modern browser 
				var filename = $(this)[0].files[0].name;  // 첫번째 파일명
			} 
			else { // old IE 
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
			} // 추출한 파일명 삽입 
			
			$(this).siblings('.upload-name').val(filename);  
	    });   
		
		// ====== 다시쓰기 버튼 이벤트 ====== // 
		$("#reset").click(function(){
			
			CKEDITOR.instances.note_content.setData("");	
			
			var inputTextVal = $("input[type=text]").val("");
			// var textareaVal = $("textarea#note_content").val("");
			
			$("input#fk_emp_no_send").val("${sessionScope.loginemp.emp_no}");	
			
			$("input#fk_emp_no_receive").attr("disabled", true);			

			if( $("input[type=checkbox]").is(":checked") == true ) {
				// 체크 되어 있다면
				$("input[type=checkbox]").prop("checked", false);
			}
			
			$('.upload-name').val("선택된 파일이 없습니다.");  
			
		}); 
		
		// 작성 중 새로고침이나 뒤로가기 버튼 눌렀을때 alert 띄우기 
		/*
		var checkUnload = true;
	    $(window).on("beforeunload", function(){
	        if(checkUnload) return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
	    });
	    */
	    
	    // 쓰기 버튼을 클릭해서 글을 저장한 후 페이지를 이동할때도 저런 메시지가 뜨기 때문에, 고럴땐 checkUnload 값을 false 로 바꿔준 후 submit 이나 페이지를 이동해야 한다~
		
	    // ====== 보내기 버튼 클릭 이벤트 ====== // 
	    $("button#send").click(function(){
	    	
			// ====== 유효성 검사 ====== //
		    // 받는사람
		    var fk_emp_no_receiveVal = $("input#fk_emp_no_receive").val().trim();
		    if(fk_emp_no_receiveVal == "") {
		    	alert("받는사람을 선택해주세요!");
		    	return false;
		    }
		    
		    // 제목
		    var note_titleVal = $("input#note_title").val().trim();
		    if(note_titleVal == "") {
		    	alert("제목을 입력해주세요!");
		    	return false;
		    }	    
		    
		    // 작성자
		    var fk_emp_no_sendVal = $("input#fk_emp_no_send").val().trim();
		    if(fk_emp_no_sendVal == "") {
		    	alert("작성자를 입력해주세요!");
		    	return false;
		    }	    
		    
		    // 작성내용(Ckeditor 유효성 검사)
		    if(CKEDITOR.instances.note_content.getData() == '' 
		    		|| CKEDITOR.instances.note_content.getData().length == 0) {
		    	alert("보낼내용을 입력하세요!");
		    	return false;
		    }
		    
		    // 중요! 체크박스가 선택되어있는지 아닌지 확인하자
		    var note_importantVal = 0;
		    
		    if($("input[name=note_important]").prop("checked")) {
		    	// 중요 체크박스가 체크되어 있으면 
		    	note_importantVal = 1;
		    }
	    	
	    	var frm = document.noteWriteFrm;
	    	frm.note_importantVal.value = note_importantVal;
	    	frm.method = "POST";
	    	frm.action = "<%= ctxPath%>/jieun/note/writeEnd.os";
	    	frm.submit();
	    	
	    	
	    	// 예약 발송에 값이 있는 경우에는 예약 임시 저장 테이블로 보낸다. // 
	    	if($("span#reservationTime").text() != "") {
	    		
	    		var reservationSetTime = $("span#reservationTime").text();
		    	var frm = document.noteWriteFrm;
		    	frm.note_importantVal.value = note_importantVal;
		    	frm.note_reservation_date.value = reservationSetTime;
		    	frm.method = "POST";
		    	frm.action = "<%= ctxPath%>/jieun/note/writeReservationEnd.os";
		    	frm.submit();	    		
	    		
	    	}	    	
	    	else {
	    		return false;
	    	}
	    	
	    });
	    
	    // ====== 임시저장 버튼 클릭 이벤트 ====== // 
	    $("button#tempSave").click(function(){
	    	
		    // 중요! 체크박스가 선택되어있는지 아닌지 확인하자
		    var note_importantVal = 0;
		    
		    if($("input[name=note_important]").prop("checked")) {
		    	// 중요 체크박스가 체크되어 있으면 
		    	note_importantVal = 1;
		    }
	    	
		    // 임시보관 테이블로 insert 하자
	    	var frm = document.noteWriteFrm;
	    	frm.note_importantVal.value = note_importantVal;
	    	frm.method = "POST";
	    	frm.action = "<%= ctxPath%>/jieun/note/writeTempEnd.os";
	    	frm.submit();
	    	
	    });
	    
	    // ====== 주소록 모달창 js 시작 ====== // 
	    
	    // ====== 주소록 상단 탭 클릭 한 요소 CSS 적용시키기 ====== //
		$(".tab_nav li").click(function(event){
			
			$(this).addClass("ul_state_active");
			$(".tab_nav li").not($(this)).removeClass("ul_state_active");
			
		});
		
	    // ====== 조직도 js ====== //
		$.fn.extend({
			    treed: function (o) {
			      
			      var openedClass = 'glyphicon-minus-sign';
			      var closedClass = 'glyphicon-plus-sign';
			      
			      if (typeof o != 'undefined'){
			        if (typeof o.openedClass != 'undefined'){
			        openedClass = o.openedClass;
			        }
			        if (typeof o.closedClass != 'undefined'){
			        closedClass = o.closedClass;
			        }
			      };
			      
			        //initialize each of the top levels
			        var tree = $(this);
			        tree.addClass("tree");
			        tree.find('li').has("ul").each(function () {
			            var branch = $(this); //li with children ul
			            branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
			            branch.addClass('branch');
			            branch.on('click', function (e) {
			                if (this == e.target) {
			                    var icon = $(this).children('i:first');
			                    icon.toggleClass(openedClass + " " + closedClass);
			                    $(this).children().children().toggle();
			                }
			            })
			            branch.children().children().toggle();
			        });
			        //fire event from the dynamically added icon
			      tree.find('.branch .indicator').each(function(){
			        $(this).on('click', function () {
			            $(this).closest('li').click();
			        });
			      });
			        //fire event to open branch if the li contains an anchor instead of text
			        tree.find('.branch>a').each(function () {
			            $(this).on('click', function (e) {
			                $(this).closest('li').click();
			                e.preventDefault();
			            });
			        });
			        //fire event to open branch if the li contains a button instead of text
			        tree.find('.branch>button').each(function () {
			            $(this).on('click', function (e) {
			                $(this).closest('li').click();
			                e.preventDefault();
			            });
			        });
			    }
			});

		//Initialization of treeviews

		$('#tree1').treed();

		$('#tree2').treed({openedClass:'glyphicon-folder-open', closedClass:'glyphicon-folder-close'});

		$('#tree3').treed({openedClass:'glyphicon-chevron-right', closedClass:'glyphicon-chevron-down'});    

		// ====== 주소록 모달창 js 끝 ====== //
		
		
		// ====== 예약발송 모달창 js 시작 ====== // 
		
		// 현재 년, 월 구하기
		var today = new Date();
		var year = today.getFullYear();			// 년
		var month = (today.getMonth() + 1);		// 월
		var date = today.getDate();				// 일
		
	    if (month < 10) 
	        month = "0" + month;
	    if (date < 10) 
	    	date = "0" + date;
	    
	    var dateToday = year + '-' + month + '-' + date;
	    $('#selectSendDate').val(dateToday);		    
		
		// 현재 시간 구하기
		var date = new Date();
		var hour = date.getHours();
		
		hour = hour + 1;
		
		$("#selectSendTimeHour").val(hour);
		 
		// 분 구하기
		var minute = date.getMinutes();
		$("#selectSendTimeMinute").val(minute);
		  
		$("#selectSendTimeHour option").filter(function() { // option 중의 text가 minute과 있으면 select 해라
			    //may want to use $.trim in here
			    return $(this).text() == hour;
		}).attr('selected', true);
		 
		$("#selectSendTimeMinute option").eq(0).attr('selected', true);		
		
		// ====== 예약발송 모달창 js 끝 ====== //
		
		// ====== 조직도에서 팀이름 클릭 했을때 ====== //
		$("li.orgName").each(function(){
			$(this).click(function(){
				
				// 검색어 비우기 
				 $("input#searchWord").val("");
				
				var fk_dept_no = $(this).val();
				
				$.ajax({ 
					url:"<%= ctxPath %>/jieun/note/writeAddAddress.os",
					// data: {"fk_dept_no" : fk_dept_noVal},
					data: {"fk_dept_no" : fk_dept_no},
					dataType:"json",
					success:function(json) {
						
						var html = "";
			            if(json.length > 0) {
			               $.each(json, function(index, item){
			            	
			            	html += "<tr>";	
		                    html += "<td style='width: 40px; height: 10px; padding-left:2px;'> ";
		                    html += "<input type='checkbox' name='chkbox' class='"+ index + "'>";
		                    html += "</td>";
	                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='emp_name'>";
	                        html += item.emp_name;
	                        html += "</td>";
	                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='position_name'>";
	                        html += item.position_name;
	                        html += "</td>";	
	                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='dept_name'>";
	                        html += item.dept_name;
	                        html += "</td>";	 
	                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='emp_no'>";
	                        html += item.emp_no;
	                        html += "</td>";	
	                        html += "</tr>";	

			               });
			               
		            	   $("tbody#empListTbody").html(html);
		            	   
			            }
					},
			        error: function(request, status, error){
				       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				    }
					
				});		
				
			});
		});	
		
		// ====== 주소록 모달창 내에서 사원 검색하는 버튼 클릭(사원명 또는 부서 검색) ====== // 
		$(document).on("click", "button#btnEmpSearchOk", function(){
			
			// 입력되어있는 검색어 구하기 
			var searchWord = $("input#searchWord").val().trim();
			
			if(searchWord == "") {
				alert("검색어를 입력하세요!");
				return false;
			}
			
	        $.ajax({
	            url : '<%= ctxPath %>/jieun/note/writeAddressSearch.os',
	            data : {"searchWord" : searchWord},
	            dataType : 'JSON',
	            success : function(json){
	            	var html = "";
		            if(json.length > 0) {
		               $.each(json, function(index, item){
		            	
		            	console.log(item.emp_name + " & " + item.emp_no);
		            	   
		            	html += "<tr>";	
	                    html += "<td style='width: 40px; height: 10px; padding-left:2px;'> ";
	                    html += "<input type='checkbox' name='chkbox' class='"+ index + "'>";
	                    html += "</td>";
                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' >";
                        html += item.emp_name;
                        html += "</td>";
                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' >";
                        html += item.position_name;
                        html += "</td>";	
                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' >";
                        html += item.dept_name;
                        html += "</td>";	 
                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' >";
                        html += item.emp_no;
                        html += "</td>";	
                        html += "</tr>";	
						
		               });
		               
	            	   
	            	   $("tbody#empListTbody").html(html);
	            	   
		            }	    
		            else {
		            	
		            	
		            	html += "<tr>";	
		            	html += "<td colspan='5' style='height: 20px; text-align: center;'> 검색어와 일치한 사원이 없습니다. </td>"
		            	html += "</tr>";
		            	
		            	$("tbody#empListTbody").html(html);
		            }
	            },
		        error: function(request, status, error){
				       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
	        });

		});		
		
		// ====== 주소록에서 사원목록 전체 선택 or 해제 했을때 하위 사윈 전체 선택 or 해제 ====== //
		$(document).on("click", "input#checkAll", function() {
						
			if($(this).prop("checked")) {
				$("input[name=chkbox]").prop("checked", true);
			}
			else {
				$("input[name=chkbox]").prop("checked", false);
			}
		});
		
		
		// ====== 주소록에서 사원버튼 클릭했을 때 ====== // 
		$(document).on("click","span.addUser",function() {			
			
			//체크된 체크박스의 갯수를 구할 수 있음.
			var chkCount = $("input[name=chkbox]:checked").length;
			
			
			// 체크된 Row의 값을 가져온다.
			var rowData = new Array();
			var tdArr = new Array();
			var checkbox = $("input[name=chkbox]:checked");

			var empList = new Array();
			
			var resultEmpList = "";
			
			var resultEmpListTemp = "";
			
			// 체크된 체크박스 값을 가져온다
			checkbox.each(function(i) {
	
				// checkbox.parent() : checkbox의 부모는 <td>이다.
				// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				
				// 체크된 row의 모든 값을 배열에 담는다.
				rowData.push(tr.text().trim());
				
				// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
				var emp_name = td.eq(1).text().trim();
				var position_name = td.eq(2).text().trim();
				var dept_name = td.eq(3).text().trim();
				var emp_no = td.eq(4).text().trim(); //  + "\n"; // 엔터 추가
				
				// 가져온 값을 배열에 담는다.(객체 형태로 담는다. [{} ,{}] 형태 )
				empList.push({emp_name: emp_name
							  ,position_name: position_name
							  ,dept_name: dept_name
							  ,emp_no: emp_no
				});
				
				// 배열 반복문, 사원 리스트 중복 값 체크 및 두번재 요소부터 엔터 값 적용하기
				$.each(empList, function(index, item){

					// 사원 리스트 중복 값 체크를 위한 temp 변수(체크한 내용이 다 들어가있는 변수)
					resultEmpListTemp = item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;

					// 누적값과 temp와 비교(indexOf는 해당 문자열을 찾는데 찾는 값이 없으면 -1 반환)
					if(resultEmpList.indexOf(resultEmpListTemp) == -1 ) {

						if(index == 0) { // 첫번째 요소
							resultEmpList += item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
						}
						else { // 첫번째 요소가 아닐때만 사원명 앞에 엔터값 추가
							resultEmpList += "\n" + item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;;
						}
					}
				});

			}); // 체크박스 반복
			
			// 첫번째 행에 문자열 넣기 (결과값)
			$(".empAddLists").eq(0).text(resultEmpList);
			$("input#chkCount").val(chkCount);
			
			
		}); // 버튼 클릭 끝
  });
  
  // ====== 주소록에서 확인 버튼 눌렀을때 ====== //  
  function findEmpOk() {
	  
	  // 넣은 문자열 추출
	  var data = $(".empAddLists").eq(0).text();
	
	  // 엔터를 구분자를 기준으로 잘라서 배열 만들기 
	  var arrData = data.split("\n");

	  // 사원번호 얻기
	  var empnoExtract = "";
	  var arrEmpno = [];
	  
	  // 사원명 얻기
	  var empNameExtract = ""; 
	  var arrEmpName = [];	  
	  
	  // 배열 반복문 출력
	  arrData.forEach(function(item, index, arr){
		  
		  // 사원번호
		  empnoExtract = arr[index].lastIndexOf('/'); // 배열[index]의 마지막 /의 위치를 구한다. 
		  arrEmpno.push(arr[index].slice(empnoExtract+1)); // 마지막 / 의 다음부터 끝까지 추출해서 새로운 arrDeptno 배열에 담는다. (사원번호 추출)
		  
		  // 사원명
		  empNameExtract = arr[index].indexOf('/');
		  arrEmpName.push(arr[index].slice(0, empNameExtract)); // slice : 0번째부터 empNameExtract 앞까지 추출
		  
	  });
	  	  
	  // 배열을 문자열로 바꾸기
	  var strEmpno = arrEmpno.join(",");     // 사원번호
	  var strEmpName = arrEmpName.join(","); // 사원명

	  // 빋는 사람 태그 내에 value 넣기
	  $("input#fk_emp_no_receive").val(strEmpno); // 사원번호
	  $("input#fk_emp_no_receive_name").val(strEmpName); // 사원명
	  	  
	  $('.modal').modal('hide'); // 확인버튼 누르자 마자 모달창 숨기기
	  
	  // 글 작성 들어왔을때 받는사람은 무조건 모달창에서 선택하기(비활성화 해제)
	  $("input#fk_emp_no_receive").removeAttr("disabled");

  }
  
  
  // ===== 예약 확인 모달창에서 날짜 및 시간 선택 후 확인 버튼 눌렀을때 ===== //
  function reservationOk() {
	  
	  // 선택한 날짜 받아오기
	  var selectDateVal = $("input#selectSendDate").val();
	  
	  // 선택한 몇시 받아오기 
	  var selectHourVal = $("#selectSendTimeHour option:selected").val();
	  
	  // 선택한 몇분 받아오기 
	  var selectMinVal = $("#selectSendTimeMinute option:selected").val();
	  
	  var reservationDate = selectDateVal + " " + selectHourVal + ":" + selectMinVal;
	  
	  $("span#reservationTime").text(reservationDate);
	  
	  $('.modal').modal('hide'); // 확인버튼 누르자 마자 모달창 숨기기
	  
  }
  
</script>

<div class="row bg-title" style="border-bottom: solid .025em gray;">
	<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
	    <h4 class="page-title" style="color:#233B49; padding-left: 25px;">쪽지 쓰기</h4>
	</div>
	
</div>

<div class="row" style="padding-left: 4%;">
 <div style="width: 1175px; " >  
 <div>	

 <ul id="buttonGroup">
 	<li class="buttonList">
 		<button type="button" id="send" class="btn btn-primary" style="background-color:#397294; border: 0px; width: 100px;" onclick="goSend();">
 			<i class="fa fa-send-o fa-fw" aria-hidden="true"></i>
 		보내기</button>
 	</li>
 	<li class="buttonList">
 		<button type="button" id="tempSave" value="1" class="btn btn-primary" style="background-color:#397294; border: 0px; width: 110px;">
 			<i class="fa fa-pencil-square-o fa-fw" aria-hidden="true"></i>
 		임시저장</button>
 	</li>
 	<li class="buttonList">
 		<button type="button" id="reset" class="btn waves-effect waves-light btn-info" style=" background-color:#397294; border: 0px; width: 110px;" onclick="goReset();">
 			<i class="fa fa-refresh fa-fw" aria-hidden="true"></i>
 		다시쓰기</button>
 	</li>  	
 </ul>
 
 <form name="noteWriteFrm" enctype="multipart/form-data" class="form-horizontal" style="margin-top:20px;"> 
 
      <table id="table">
         
         <tr>
            <th width="14%" style="background-color: #526875; ">받는사람</th>
            <td width="96%" data-toggle="tooltip" data-placement="top" title="주소록을 이용해서 선택해주세요!">
               <c:if test="${not empty noteTempvo}">
               		<input type="text" name="fk_emp_no_receive" id="fk_emp_no_receive" value="${noteTempvo.fk_emp_no_receive}" 
               			   style="width:89%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd;"
               		/>
               		<%-- 주소록 모달 불러오기  --%>
               		<button type="button" id="empList" class="btn btn-primary" style="background-color:#397294; border: 0px;" data-toggle="modal" data-target="#findEmpListModal"> 주소록</button>
               		
               		<input type="hidden" name="fk_emp_name" id="fk_emp_no_receive_name" value="${noteTempvo.fk_emp_name}">
               		<input type="hidden" name="chkCount" id="chkCount" /> 
               </c:if>	
               
               <c:if test="${empty noteTempvo}">
               		<input type="text" name="fk_emp_no_receive" id="fk_emp_no_receive" 
               			   style="width:89%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd;" 
               	    />
               		<%-- 주소록 모달 불러오기  --%>
               		<button type="button" id="empList" class="btn btn-primary" style="background-color:#397294; border: 0px;" data-toggle="modal" data-target="#findEmpListModal"> 주소록</button>
               		<input type="hidden" name="fk_emp_name" id="fk_emp_no_receive_name">
               		<input type="hidden" name="chkCount" id="chkCount" />  
               </c:if>
               
               <!-- 임시보관함에서 가져온 noteTempvo의 note_no 값을 보내기 버튼 눌렀을때 넘겨 받는다. 
               		note_no를 session에 저장 시킨다. session에서 가져온 번호를 임시보관함에서 삭제 시킨다.  
               -->
               <input type="hidden" name="note_temp_no" id="note_temp_no" value="${noteTempvo.note_no}"/>
               <input type="hidden" name="temp_fk_emp_no_receive" id="temp_fk_emp_no_receive" value="${temp_fk_emp_no_receive}"/>
               <input type="hidden" name="temp_fk_emp_name" id="temp_fk_emp_name" value="${temp_fk_emp_name}"/>
               <input type="hidden" name="temp_status" id="temp_status" value="${temp_status}"/>  
            </td>
         </tr>
              
         <tr>
            <th width="14%" style="background-color: #526875; " >
            	 <span style="margin-right: 58px;">제목</span>
            	 <c:if test="${not empty noteTempvo && noteTempvo.note_important == 1}">
               		<input type="checkbox" name="note_important" id="note_important" checked="checked" />&nbsp;&nbsp;중요!
                 </c:if>	
           		 <input type="checkbox" name="note_important" id="note_important" />&nbsp;&nbsp;중요!
           		 <input type="hidden" name="note_importantVal">
            </th>
            <td width="96%">
               <c:if test="${not empty noteTempvo}">
               		<input type="text" name="note_title" id="note_title"  value="${noteTempvo.note_title}" style="width:89%; margin-left:10px; margin-top: 3px; margin-bottom: 3px; border-radius:3px; border: 1px solid #adb5bd;" />
               </c:if>	            
               
               <c:if test="${empty noteTempvo}">
               		<input type="text" name="note_title" id="note_title" style="width:89%; margin-left:10px; margin-top: 3px; margin-bottom: 3px; border-radius:3px; border: 1px solid #adb5bd;"/>
               </c:if>       
            </td>
         </tr>
         
         <tr>
            <th width="14%" style="background-color: #526875; " >작성자</th>
            <td width="96%">
               <input type="text" name="fk_emp_no_send" id="fk_emp_no_send" readonly="readonly"
               		 value="${sessionScope.loginemp.emp_no}" style="width:89%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
            </td>
         </tr>  
         
         <tr>
            <th width="14%" style="background-color: #526875; ">첨부파일</th>
            <td width="96%" style="padding-top : 9px;">
            	   <%-- 첨부파일 업로드 --%>
            	   
	               <c:if test="${not empty noteTempvo && noteTempvo.note_filename != null}">
	               		<input type="file" name="attach" value="${noteTempvo.note_filename}" id="note_filename_upload" style="width:97%; margin-left:10px; border-radius:3px; border: 1px solid #adb5bd;" />
	               		<label for='note_filename_upload'>
	               		<i class="fa fa-file-o"></i>&nbsp;파일선택</label>
	               		<input class="upload-name" value="${noteTempvo.note_orgfilename}" disabled="disabled" style="border-radius:3px;  "/>
	               		
	               		<input type="hidden" name="note_filename" id="note_filename" value="${noteTempvo.note_filename}" />
	               		<input type="hidden" name="note_orgfilename" id="note_orgfilename"  value="${noteTempvo.note_orgfilename}" />
	               		<input type="hidden" name="note_filesize" id="note_filesize" value="${noteTempvo.note_filesize}" />
	               </c:if>	   
            	   
            	   <c:if test="${empty noteTempvo || noteTempvo.note_filename == null}">
		               <input type="file" name="attach" id="note_filename_upload" style="width:97%; margin-left:10px; border-radius:3px; border: 1px solid #adb5bd;" />
		               <label for='note_filename_upload'>
		               <i class="fa fa-file-o"></i>&nbsp;파일선택</label>
		               <input  class="upload-name" value="선택된 파일이 없습니다." disabled="disabled" style="border-radius:3px;  "/>
	               </c:if>
	               <!-- <input type="file" name="attach" style="width:30%; margin-left:10px; border-radius:3px; border: 1px solid #adb5bd;"> --> 
            </td>
         </tr>   
                
      </table>
       
       <br>
       
       <%-- 쪽지 내용 --%>
       <table style="border: 0; width:1175px;">
         <tr style="border: 0;">
            <td width="1230px;" style="border: 0;">
            
               <c:if test="${not empty noteTempvo}">
               		<textarea rows="20" cols="100" style=" width: 1175px; height: 412px;" name="note_content" id="note_content">
               			${noteTempvo.note_content}
               		</textarea>
               		<script>CKEDITOR.replace('note_content');</script>     
               </c:if>	
               
               <c:if test="${empty noteTempvo}">
	               <textarea rows="20" cols="100" style=" width: 1175px; height: 412px;" name="note_content" id="note_content"></textarea>
	               <script>CKEDITOR.replace('note_content');</script>
               </c:if>        
            </td>
         </tr>       
       </table>
       
       <!-- 예약 시간 설정하기  -->
       <input type="hidden" name="note_reservation_date" id="note_reservation_date"/>
       
   </form>
   
   <ul id="buttonGroup" style="margin-top:20px;">
   	 <li class="buttonList">
   	 	<%-- 예약발송 모달 불러오기  --%>
 		<button type="button" id="reservation" name="note_reservation_status" class="btn btn-primary" 
 				data-toggle="modal" data-target="#reservationSendModal"
 				style="background-color:#397294; border: 0px; width: 110px;">
 			<i class="fa fa-clock-o fa-fw" aria-hidden="true"></i>
 				예약발송
 		</button>
 		<span id="reservationTime" style="margin-left: 20px;"></span>
 	 </li> 
 	
   </ul>
   
   
   </div>
   </div>
   
</div>    

<%-- 주소록 모달 --%>
<!-- Modal -->
<div id="findEmpListModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
 <div class="modal-dialog" style="width: 1070px;">
 
   <!-- Modal content-->
   <div class="modal-content">
     <div class="modal-header" style="height: 60px;">
       <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()"><span style="font-size: 26pt;">&times;</span></button>
       <h3 class="modal-title" style="font-weight: bold">주소록</h3>
     </div>
     <div class="modal-body">
       <div id="employeeList" style="border: none; width: 100%; height: 470px;"><!-- style="border: none; width: 100%; height: 470px;"> -->
       		<%-- findEmpList.jsp --%>
			<div class="empList_Popup" style="overflow-x:hidden;">
				 
				<div class="content" >
					
					
					<div class="content_layout_address" style="margin-left : 60px;">
						<div id="tabArea" style="margin-left : -40px;">
							<ul class="tab_nav nav_layer" style="margin-bottom: 22px;"></ul>
						</div>
						 
						 <!-- -1px -->
						<div class="tabWrap father" style="margin-left : -1px; height: 400px;"> <!-- border: solid 5px yellow;"> -->
							<div class="father" style=" border : solid 1px #999; overflow-y:auto;">
							<%-- 조직도 시작--%>
							<div class="container" style="padding-top:10px;  width: 200px; border-right: solid 1px #999; "> <%-- border: solid 2px navy; " --%>
							    <div class="row box" style="width: 200px; "> <%--border: solid 2px pink;" --%>
							        <div class="col-md-4">
							            <ul id="tree1">
							                <li style="width:130px;">
							                	<a href="#">오성그룹</a>			
							                    <ul>
							                        <li class="orgName" style="width:120px;" value="1">전략기획팀</li>
							                        <li class="orgName" style="width:120px;" value="2">경영지원팀</li>
							                        <li class="orgName" value="3">인사팀</li>
							                        <li class="orgName" value="4">회계팀</li>
							                        <li class="orgName" value="5">영업팀</li>
							                        <li class="orgName" value="6">마케팅팀</li>
							                        <li class="orgName" value="7">IT팀</li>
							                        
							                    </ul>
							                </li>
							            </ul>
							        </div>
							</div>
						</div>
						<%-- 조직도 끝--%>
						
						<%-- 사원리스트 시작--%>
						<div class="content_list box">
							<div class="search_wrap">
								<form class="emp_search" name="">
									<input id="searchWord" class="search" type="text" placeholder="이름">
							 		<button type="button" id="btnEmpSearchOk" class="btn btn-primary btnSearch" style="background-color: #00a1b9; border: solid 1px #00a1b9; border-radius: 3px; color: white;">검색</button>	
								</form>  
							</div>
							<div class="scroll_wrap" style="height: 360px;">
								<table style="width: 396px; height: 366px; border: 0px; overflow-y:auto;">
									<thead style="padding:0;">
										<tr style="text-align: left; background: #efefef; font-weight: normal;">
									        <th style="padding-left:2px;">
									        	<input type="checkbox" name="checkAll" id="checkAll">
									        </th>
									        <th style="padding-left:2px;">이름</th>
									        <th style="padding-left:2px;">직위</th>
									        <th style="padding-left:2px;">부서</th>
									        <th style="padding-left:2px;">사원ID</th>
									    </tr>
									</thead>
				
									<tbody style="height: 300px; " id="empListTbody">				                       
									   <c:forEach var="emp" items="${empAllList}" varStatus="status">
					                        <tr style="height: 20px;" id="empRow" class="${status.index}">
					                            <td style="width: 40px; height: 10px; padding-left:2px;"> 
					                            	<input type="checkbox" name="chkbox" class="check${status.index}">
					                            </td>
					                            <td style="width: 80px; height: 10px; padding-left:2px;" id="emp_name">
					                            	${emp.emp_name}
					                            </td>
					                            <td style="width: 50px; height: 10px; padding-left:2px;" id="position_name">
					                            	${emp.position_name}
					                            </td>
					                            <td style="width: 80px; height: 10px; padding-left:2px;" id="dept_name">
					                            	${emp.dept_name}
					                            </td>
					                            <td style="width: 120px; height: 10px; padding-left:2px;" id="emp_no">
					                            	${emp.emp_no}
					                            </td>
					                        </tr>                    		
				                    	</c:forEach>				                        
								    </tbody>					
								</table>
							</div>
						
						</div>
						<%-- 사원리스트 끝--%>
						
						</div>
						
						<%-- 추가 시작--%>
						<div class="addArea">
							<div>
								<div class="move_wrap">
									<ul class="addListGroup" style="padding-left: 10px;">
										<%-- 
										<li class="addList">
											<span class="btn_bg addGroup" style="display: inline-block; margin-bottom: 10px; width: 50px; font-size: 10pt;">
												그룹
											</span>
										</li>
										--%>
										<li class="addList">
											<span class="btn_bg addUser" style="display: inline-block; width: 50px; font-size: 10pt; ">
												사용자
											</span>				
										</li>							
									</ul>
								</div>
							</div>
						</div>	
						<%-- 추가 끝--%>
						
						<%-- 받는 사람 시작--%>  
						<div class="receive_wrap" style="margin-left: 15px; margin-top: 80px;">
						    <div id="mailReceive" class="receive_list">
						        <span class="title">받는사람</span>
						        <ul id="empAddListGroup">
						            <!-- 비어있는 li 네개 지우면 안됨 -->
						            <li class="empAddLists" value="1"></li>
						            <li class="empAddLists"></li>
						            <li class="empAddLists"></li>
						            <li class="empAddLists"></li>
						        </ul>
						    </div>
						</div>
						<%-- 받는 사람 끝--%> 					
					
				</div>
				
				
				</div>
				</div>
			</div>	   			
	   <%-- findEmpList.jsp --%>	   			
       </div>
     </div>
     <%-- modal-body 끝 --%>
     <div class="modal-footer">
        <button type="button" class="btn btn-primary" 
                style="background-color: #00a1b9; border-color: #00a1b9;" onclick="findEmpOk()">확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="
            window.location.reload()">취소</button>
      </div>
   </div>

 </div>
</div>


<%-- 예약발송 모달 --%>
<div id="reservationSendModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
 <div class="modal-dialog" style="width: 350px;">
 
   <!-- Modal content-->
   <div class="modal-content">
     <div class="modal-header" style="height: 60px;">
       <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()"><span style="font-size: 26pt;">&times;</span></button>
       <h3 class="modal-title" style="font-weight: bold">예약발송</h3>
     </div>
     <div class="modal-body">
       <div id="reservationSend">
	   <%-- reservation.jsp 시작 --%>
			<div class="reservation_Content">
			
				<form>
					<div class="form-group form-wrap form-sendDate">
						<label for="selectSendDate" class="sendLabel">발송날짜</label>
						<input type="date" id='selectSendDate'/>
					</div>
					
					<div class="form-group form-wrap">
					  <label for="selectSendTime" class="sendLabel">발송시간</label>
					  <select class="form-control" id="selectSendTimeHour"  style="display:inline-block; height: 30px; width: 70px;">
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
					  <select  class="form-control" id="selectSendTimeMinute" style="display:inline-block; height: 30px; width: 70px;">
					  		<option>00</option>
					  		<option>05</option>
					  		<option>10</option>
					  		<option>15</option>
					  		<option>20</option>
					  		<option>25</option>
					  		<option>30</option>
					  		<option>35</option>
					  		<option>40</option>
					  		<option>45</option>
					  		<option>50</option>
					  		<option>55</option>
					  	<%-- <c:forEach begin="10" end="50" varStatus="loop" step="10">  
					  	<c:forEach begin="5" end="55" varStatus="loop" step="5">
					  		 <option>${loop.index}</option>
					  	</c:forEach>
					  	 --%>
					  </select>
					  <span>분</span>
					</div>
				</form>
			
				 
			</div>	   
	   <%-- reservation.jsp 끝 --%>
       </div>
     </div>
     <div class="modal-footer">
        <button type="button" class="btn btn-primary" 
        	    style="background-color: #00a1b9; border-color: #00a1b9;" onclick="reservationOk()">확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
   </div>

 </div>
</div>
