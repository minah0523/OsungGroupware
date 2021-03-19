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
   }
   
   .titleBox h2{
      margin: 0;
      font-weight: bold;
      color: #6a6a69;
   }
   
   .table > tbody > tr > td {
     vertical-align: middle;
   }
   
   .table-borderless > tbody > tr > td,
   .table-borderless > tbody > tr > th,
   .table-borderless > tfoot > tr > td,
   .table-borderless > tfoot > tr > th,
   .table-borderless > thead > tr > td,
   .table-borderless > thead > tr > th {
       border: none;
   }
   
   <%-- ----------------------- --%>
   
   .smallTitleBox > h4{
      font-size: 12pt;
      font-weight: bold;
      color: #6a6a69;
   }
   
   .detailBtn{
      margin-right: 3%;
   }
   
   .detailTbody th tr{
      font-size: 12pt;
   }
   
   .container{
      background-color: white;
      margin: 0 auto;
      margin-top: 2%;
      width: 97%;
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

</style>

<script type="text/javascript">

   //전체 모달 닫기(전역함수인듯)
   window.closeModal = function(){
       $('.modal').modal('hide');
       //javascript:history.go(0);
   };

   $(document).ready(function() {
      
      readRsvList();
      
   });
      
   
   // 나의 예약 목록을 읽어오는 함수
     function readRsvList(){
        
        $.ajax({
            url:"<%= request.getContextPath() %>/readRsvList.os",
            type:"get",
            dataType:"JSON",
            success:function(json){
               var html = "";
               if (json.length > 0) {
                  $.each(json, function(index, item){
                     html += "<tr class='oneRow'>";
                        html += "<td>"+ item.Rname + "</td>";
                        html += "<td>" + item.RSname + "</td>";
                        html += "<td>";
                           html += item.startday + " ~ " + item.endday;
                        html += "</td>";
                        html += "<td>";
                        html += "<button class='btn grayBtn detailBtn' type='button' onclick='rsvDetailBtn(" + item.reservation_no + ")'>상세보기</button>";
                        html += "<button class='btn redBtn' type='button' onclick='rsvCancelBtn(" + item.reservation_no + ")'>취소</button>";
                        html += "</td>";
                     html += "</tr>";
                  });
               }else{
                  html += "<tr class='oneRow'>";
                  html += "<td colspan='4' style='text-align: center;'>리스트가 존재하지 않습니다.</td>";
                  html += "</tr>";
               }
               
               $("tbody.RsvList").html(html);

            },
            error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
             }
         });
        
     }
   
   // 예약 상세보기 버튼을 클릭시 실행하는 함수
   function rsvDetailBtn(reservation_no) {
      
      $.ajax({
         url:"<%= request.getContextPath() %>/readDetailRsvList.os",
         type:"get",
         data: {reservation_no:reservation_no},
         dataType:"JSON",
         success:function(json){
            var html = "";
            
            html += "<tr>";
               html += "<th>분류명</th>";
               html += "<td>" + json.Rname + "</td>";
            html += "</tr>";
            html += "<tr>";
               html += "<th>자원명</th>";
               html += "<td>" + json.RSname + "</td>";
            html += "</tr>";
            html += "<tr>";
               html += "<th>자원정보</th>";
               html += "<td>" + json.info + "</td>";
            html += "</tr>";
            html += "<tr>";
               html += "<th>시작시간</th>";
               html += "<td>" + json.startday + "</td>";
            html += "</tr>";
            html += "<tr>";
               html += "<th>종료시간</th>";
               html += "<td>" + json.endday + "</td>";
            html += "</tr>";
            html += "<tr>";
               html += "<th>등록자</th>";
               html += "<td>" + json.emp_name + "</td>";
            html += "</tr>";
            html += "<tr>";
               html += "<th>사용용도</th>";
               html += "<td>" + json.reason+ "</td>";
            html += "</tr>";
            
            $("tbody.detailTbody").html(html);
         },
         error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
      });
      
      $('#showDetailRsvModal').modal('show');
   }
   
   // 예약 취소하기 버튼을 클릭시 실행하는 함수(모달을 띄워주기만 함)
   function rsvCancelBtn(reservation_no) {
      $("input.hidden_reservation_no").val(reservation_no);
      $('#cancelRsvCheckModal').modal('show');
   }
   
   // 예약 취소를 DB에서 처리해주는 함수
   function rsvCancel() {
      var reservation_no = $("input.hidden_reservation_no").val();
      
      $.ajax({
         url:"<%= request.getContextPath() %>/rsvCancel.os",
         type:"get",
         data: {reservation_no:reservation_no},
         dataType:"JSON",
         success:function(json){
            
            if (json.n == 1) {
               readRsvList();
               window.closeModal();
            }else{
               alert("DB오류");
            }
            
         },
         error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
      });
   }
   
</script>

</head>
<body class="stop-dragging">

   <div class="titleBox">
      <h2><i class="fa fa-clock-o fa-fw" aria-hidden="true"></i>&nbsp;&nbsp;나의 예약 목록</h2>
   </div>
   <hr style="margin: 0; color: #9d9d9d;">
   
   <div class="container">   
   
     <div class="smallTitleBox">
        <h4>예약목록</h4>
     </div>
     
     <table class="table">
       <thead>
         <tr>
           <th class="col-sm-2">분류</th>
           <th class="col-sm-3">자원명</th>
           <th class="col-sm-5">예약 시간</th>
           <th class="col-sm-2"></th>
         </tr>
       </thead>
       <tbody class="RsvList">
         
       </tbody>
     </table>
     
   </div>
   
   
   <%-- ---------------- 모달 ---------------- --%>
   
   <%-- 예약 상세정보 보여주기 모달 --%>
   <div id="showDetailRsvModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
          <h4 class="modal-title" style="font-weight: bold;">예약정보</h4>
        </div>
        <div class="modal-body">
          <div class="container">
               <form name="editCalNameFrm">
             <table class="table table-borderless">
               <tbody class="detailTbody">
                 
               </tbody>
             </table>
         
            <button class="btn grayBtn" style="float: right;" type="button" onclick="window.closeModal()">확인</button>
            </form>
         </div>
        </div>
      </div>
    </div>
   </div>
   
   <%-- 취소 버튼 클릭 시 정말 취소할 것인지 묻는 모달 --%>
   <div class="modal fade" id="cancelRsvCheckModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
          <h4 class="modal-title">예약 삭제</h4>
        </div>
        <div class="modal-body">
          <label>정말 예약을 취소하시겠습니까?</label>
          <input class="hidden_reservation_no" type="hidden">
        </div>
        <div class="modal-footer">
          <button type="button" class="btn blueBtn" onclick="rsvCancel()">예</button>
          <button type="button" class="btn grayBtn"onclick="window.closeModal()">아니오</button>
        </div>
      </div>
    </div>
  </div>

</body>
</html>