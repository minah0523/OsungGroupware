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


</style>

<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>

<script type="text/javascript">
  $(document).ready(function () {
       
       // ====== 주소록 모달창 js 시작 ====== // 
       
       // ====== 주소록 상단 탭 클릭 한 요소 CSS 적용시키기 ====== //
      $(".tab_nav li").click(function(event){
         
         alert($(this).attr('value'));
         
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
      
      // ====== 조직도에서 팀이름 클릭 했을때 ====== //
      $("li.orgName").each(function(){
         $(this).click(function(){
            
            // 검색어 비우기 
             $("input#searchWord").val("");
            
            var fk_dept_no = $(this).val();
            alert("클릭한 조직 이름의 value 값은? ==> " + fk_dept_no);
            
            // sessionStorage.setItem("fk_dept_no", fk_dept_no);
            // var fk_dept_noVal = sessionStorage.getItem("fk_dept_no");
            
            console.log("타입" + typeof(fk_dept_no)); // number 
            
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
         console.log("length: "+$("input[name=chkbox]:checked").length);
         
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
                 
               // console.log("$.each의 empList 결과는무엇?==? " + item.emp_name);
               // console.log("$.each의 empList 결과는무엇?==? " + item.position_name);
               // console.log("$.each의 empList 결과는무엇?==? " + item.dept_name);
               // console.log("$.each의 empList 결과는무엇?==? " + item.emp_no);
               
               // 사원 리스트 중복 값 체크를 위한 temp 변수(체크한 내용이 다 들어가있는 변수)
               resultEmpListTemp = item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
               
               // 누적값과 temp와 비교
               if(resultEmpList.indexOf(resultEmpListTemp) == -1 ) {
               
                  if(index == 0) { 
                     resultEmpList += item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
                  }
                  else { // 첫번째 요소가 아닐때만 사원명 앞에 엔터값 추가
                     resultEmpList += "\n" + item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;;
                  }
               }
                 
            });
            
            console.log("결과 resultresultresult =======>" + resultEmpList );
            
            console.log("타입result" + typeof(resultEmpList)); // string
            
         }); // 체크박스 반복
         
         
         // 첫번째 행에 문자열 넣기 (결과값)
         $(".empAddLists").eq(0).text(resultEmpList);
         
      }); // 버튼 클릭 끝

  });
  
  // ====== 주소록에서 확인 버튼 눌렀을때 ====== //  
  function findEmpOk() {
     
     // 넣은 문자열 추출
     var data = $(".empAddLists").eq(0).text();
     
     console.log("ul 태그에서 읽어온 data 값 ==> " + data);
   
     // 엔터를 구분자를 기준으로 잘라서 배열 만들기 
     var arrData = data.split("\n");
     
     console.log("\n를 기준으로 자른결과 ==> " + arrData);
     // console.log("타입" + typeof(arrData)); // Object 
     
     // 사원번호 얻기
     var empnoExtract = "";
     var arrEmpno = [];
     
     // 사원명 얻기
     var empNameExtract = ""; 
     var arrEmpName = [];     
     
     // 배열 반복문 출력
     arrData.forEach(function(item, index, arr){
          
        // 사원번호
        console.log("배열 요소 ===> " + item);
        empnoExtract = arr[index].lastIndexOf('/'); // 배열[index]의 마지막 /의 위치를 구한다. 
        console.log("배열 요소 empnoExtract ===> " + empnoExtract);
        // arrDeptno += arr[index].slice(deptnoExtract+1) + ","; // 마지막 / 의 다음부터 끝까지 추출해서 새로운 arrDeptno 배열에 담는다.
        // console.log("배열 요소 arrEmpno ===> " + arrEmpno); 
        // 2020012,2020007,
        
        arrEmpno.push(arr[index].slice(empnoExtract+1));
        
        console.log("배열 요소 arrEmpno ===> " + arrEmpno); 
        
        // 사원명
        empNameExtract = arr[index].indexOf('/');
        arrEmpName.push(arr[index].slice(0, empNameExtract)); // slice : 0번째부터 empNameExtract 앞까지 추출
        
     });
     
     console.log("마지막 arrEmpno 추출 =====> " + arrEmpno);
     console.log("마지막 arrEmpName 추출 =====> " + arrEmpName);
     
     for(var i=0; i<arrEmpName.length; i++) {
        console.log("배열 " + i + "=> " + arrEmpName[i]);
        
     }
     
     for(var i=0; i<arrEmpno.length; i++) {
        console.log("배열 " + i + "=> " + arrEmpno[i]);
        
     }     
     
     // 배열을 문자열로 바꾸기
     var strEmpno = arrEmpno.join(",");
     
     var strEmpName = arrEmpName.join(",");
     
     console.log("마지막 arrEmpno 추출을 문자열로 만들기  =====> " + strEmpno);
     // 2020013,2020019
     
     console.log("마지막 arrEmpName 추출을 문자열로 만들기  =====> " + strEmpName);
     // 강과장,남과장
     
     // 빋는 사람 태그 내에 value 넣기
     $("input#fk_emp_no_receive").val(strEmpno); // 사원번호
     $("input#fk_emp_no_receive_name").val(strEmpName); // 사원명
          
     $('.modal').modal('hide'); // 확인버튼 누르자 마자 모달창 숨기기
  }
  
</script>

      <table id="table">
         <tr>
            <th width="14%" style="background-color: #526875; ">받는사람</th>
            <td width="96%">
               <input type="text" name="fk_emp_no_receive" id="fk_emp_no_receive" style="width:89%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
               <%-- 주소록 모달 불러오기  --%>
               <button type="button" id="empList" class="btn btn-primary" style="background-color:#397294; border: 0px;" data-toggle="modal" data-target="#findEmpListModal"> 주소록</button>
               <input type="hidden" name="fk_emp_name" id="fk_emp_no_receive_name">       
            </td>
         </tr>
      </table>
   

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
                     <ul class="tab_nav nav_layer" style="margin-bottom: 22px;">
                        <%--
                        <li value="user">
                           <a>개인 주소록</a>
                        </li>
                        <li value="company">
                           <a>공용 주소록</a>
                        </li>
                        <li value="org">
                           <a>조직도</a>
                        </li>
                         --%>
                     </ul>
                  </div>
                  
                  <div class="tabWrap father" style="margin-left : -1px; height: 400px;"> <!-- border: solid 5px yellow;"> -->
                     <div class="father" style=" border : solid 1px #999; overflow-y:auto;">
                     <%-- 조직도 시작--%>
                     <div class="container" style="padding-top:10px; width: 200px; border-right: solid 1px #999; "> <%-- border: solid 2px navy; " --%>
                         <div class="row box" style="width: 200px; "> <%--border: solid 2px pink;" --%>
                             <div class="col-md-4">
                                 <ul id="tree1">
                                     <li style="width:130px;">
                                        <a href="#">오성그룹</a>         
                                         <ul>
                                             <li class="orgName" style="width:120px;" value="1">전략기획팀</li>
                                             
                                             <li class="orgName" style="width:120px;" value="2">경영지원팀
                                                 <%-- 
                                                 <ul>
                                                     <li style="width:120px;">Reports
                                                         <ul>
                                                             <li>Report1</li>
                                                             <li>Report2</li>
                                                             <li>Report3</li>
                                                         </ul>
                                                     </li>
                                                 </ul>
                                                 --%>
                                             </li>
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
                        <form class="emp_search">
                           <input id="searchWord" class="search" type="text" placeholder="이름,부서">
                            <button type="button" class="btn btn-primary btnSearch" style="background-color: #00a1b9; border: solid 1px #00a1b9; border-radius: 3px; color: white;">검색</button>   
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
