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
span#title {
   font-size: 22px;
   margin: 0 3px 0 0;
   padding: 8px 8px 8px 24px;
}

tr {
   line-height: 42px;
}

th {
   padding: 8px 8px 8px 24px;
}

img#thumbnail_image {
   width: 100px;
   height: 100px;
   border-radius: 5px;
}

span#buttonWrap {
   width: 40%;
   margin: 0px auto;
   position: relative;
}

span#buttonText {
   display: inline-block;
   width: 100px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   padding: 5px 10px;
   color: white;
   background-color: #595959;
   opacity: 0.5;
   text-align: center;
   position: absolute;
   top: 175%;
   line-height: 20px;
}

span#buttonText:hover {
   background-color: black;
   cursor: pointer;
}

span.requirement {
   color: red;
}

.require {
   /* border: solid 1px gray; */
   padding-bottom: 10px;
   padding-left: 10px;
   color: red;
   font-size: 9pt;
}

i.fa {
   cursor: pointer;
}

.modal-backdrop {
   z-index: -1;
}

a#saveModify {
   width: 65px;
   height: 36px;
   background-color: #00A1B9;
   margin: 0px 4px;
   padding: 0 20px;
}

a#modifyCancel, a#returnList, a#contactDelete {
   border: solid 1px gray;
   width: 65px;
   height: 36px;
   background-color: #F4F4F4;
   margin: 0px 4px;
   padding: 0 20px;
}

header#headerModal {
   font-size: 13px;
   padding: 24px;
}

header#headerModal > h1 {
   font-size: 18px;
   padding: 0 32px 0 0;
}

div#contentModal {
   padding: 16px 24px;
}

tbody#tbodyModal > tr {
   width: 102px;
   height: 32px;
}

span.spanModal {
   font-size: 13px;
}

a#modalSave {
   width: 41px;
   height: 34px;
   background-color: #00A1B9;
   margin: 0 5px 0 4px;
   padding: 0 8px;
   cursor: pointer;
}

a#modalCancel {
   width: 41px;
   height: 34px;
   background-color: #fff;
   margin: 0 5px 0 4px;
   padding: 0 8px;
   cursor: pointer;
}
</style>

<script type="text/javascript">

   $(document).ready(function(){
      
      $("span.require").hide();
      
      $('[data-toggle="tooltip"]').tooltip();
      
      // 수정
      // 회사명
      $("i#fa_company").click(function(){
         $("span#spanCompany").hide();
         $("span#company_name").css("display", "inline-block");
      });// end of $("i#fa_company").click(function(){})--------------------
      
      // 부서
      $("i#fa_dept").click(function(){
         $("span#spanDept").hide();
         $("span#dept_name").css("display", "inline-block");
      });// end of $("i#fa_dept").click(function(){})--------------------
      
      // 직위
      $("i#fa_position").click(function(){
         $("span#spanPosition").hide();
         $("span#position_name").css("display", "inline-block");
      });// end of $("i#fa_position").click(function(){})--------------------
      
      // 이메일
      $("i#fa_email").click(function(){
         $("span#spanEmail").hide();
         $("span#email").css("display", "inline-block");
      });// end of $("i#fa_email").click(function(){})--------------------
      
      // 휴대폰
      $("i#fa_mobile").click(function(){
         $("span#spanMobile").hide();
         $("span#mobile").css("display", "inline-block");
      });// end of $("i#fa_mobile").click(function(){})--------------------
      
      // 회사전화
      $("i#fa_corp_phone").click(function(){
         $("span#spanCorp_phone").hide();
         $("span#corp_phone").css("display", "inline-block");
      });// end of $("i#fa_corp_phone").click(function(){})--------------------
      
      
      // 우편번호 찾기
      $("button#postcodeSearch").click(function(){
         new daum.Postcode({
               oncomplete: function(data) {
                   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                   // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                   // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                   var addr = ''; // 주소 변수
                   var extraAddr = ''; // 참고항목 변수

                   // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                   if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                       addr = data.roadAddress;
                   } else { // 사용자가 지번 주소를 선택했을 경우(J)
                       addr = data.jibunAddress;
                   }

                   // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                   if(data.userSelectedType === 'R'){
                       // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                       // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                           extraAddr += data.bname;
                       }
                       // 건물명이 있고, 공동주택일 경우 추가한다.
                       if(data.buildingName !== '' && data.apartment === 'Y'){
                           extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                       }
                       // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                       if(extraAddr !== ''){
                           extraAddr = ' (' + extraAddr + ')';
                       }
                       // 조합된 참고항목을 해당 필드에 넣는다.
                       document.getElementById("modalExtra_address").value = extraAddr;
                   } else {
                       document.getElementById("modalExtra_address").value = '';
                   }

                   // 우편번호와 주소 정보를 해당 필드에 넣는다.
                   document.getElementById("modalPostcode").value = data.zonecode;
                   document.getElementById("modalAddress").value = addr;
                   // 커서를 상세주소 필드로 이동한다.
                   document.getElementById("modalDetail_address").focus();
               }
           }).open();
      });// end of #("button#postcodeSearch").click(function(){})-----------------------
      
      // 주소 저장
      $("a#modalSave").click(function(){
         // 우편번호
         var modalPostcode = $("input#modalPostcode").val();
         
         if(modalPostcode == "") {
            return;
         }// end of if(modalPostcode == "") {}--------------------
         
         $("input#postcode").val(modalPostcode);
         
         var strAddress = "";
         strAddress += "(" + modalPostcode + ") ";
         
         // 주소
         var modalAddress = $("input#modalAddress").val();
         $("input#address").val(modalAddress);
         
         strAddress += modalAddress + " ";
         
         // 상세주소
         var modalDetail_address = $("input#modalDetail_address").val();
         $("input#detail_address").val(modalDetail_address);
         
         strAddress += modalDetail_address + " ";
         
         // 주소 참고항목
         var modalExtra_address = $("input#modalExtra_address").val();
         $("input#extra_address").val(modalExtra_address);
         
         strAddress += modalExtra_address;
         $("input#addressDetail").val(strAddress);
      });// end of $("a#modalSave").click(function(){})-----------------------
   });// end of $(document).ready(function(){})------------------------
   
   
   // 수정 취소하기
   function contactReviseCancel() {
      
      // 이름
      $("input#name").val("${name}");
      
      // 회사명
      $("span#spanCompany").show();
      $("input#company_name").val("${company_name}");
      $("span#company_name").css("display", "none");
      
      // 부서
      $("span#spanDept").show();
      $("input#dept_name").val("${dept_name}");
      $("span#dept_name").css("display", "none");
      
      // 직위
      $("span#spanPosition").show();
      $("input#position_name").val("${position_name}");
      $("span#position_name").css("display", "none");
      
      // 이메일
      $("span#spanEmail").show();
      $("input#email").val("${email}");
      $("span#email").css("display", "none");
      
      // 휴대폰
      $("span#spanMobile").show();
      $("input#mobile").val("${mobile}");
      $("span#mobile").css("display", "none");
      
      // 회사전화
      $("span#spanCorp_phone").show();
      $("input#corp_phone").val("${corp_phone}");
      $("span#corp_phone").css("display", "none");
      
      // 주소
      if("${pbvo.postcode}" == "") {
         $("input#addressDetail").empty();
      } else {
         $("input#addressDetail").val("(${pbvo.postcode}) ${pbvo.address} ${pbvo.detail_address} ${pbvo.extra_address}");
      }// end of if("${pbvo.postcode}" == "") {}----------------------
      
      // 메모
      $("textarea#memo").val("${memo}");
      
   }// end of function contactReviseCancel() {}----------------------
   
   
   function detailContactRevise() {
      
      // 이름
      var nameVal = $("input#name").val().trim();
      
      if(nameVal == "") {
         $("span#requireName").show();
         return;
      } else {
         $("span#requireName").hide();
      }// end of if(nameVal == "") {}-------------------
      
      // 이메일
      var emailVal = $("input#email").val().trim();
      
      var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
      var test = regExp.test(emailVal);
      
      if(!test) {
         // 정규표현식에 위배한 경우
         $("span#requireEmail").show();
         $("input#email").empty();
         return;
      } else {
         $("span#requireEmail").hide();
      }// end of if(emailVal != "" && !test) {}----------------------
      
      // 휴대폰
      var mobileVal = $("input#mobile").val().trim();
      
      regExp = new RegExp(/^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/);
      test = regExp.test(mobileVal);
      
      if(!test) {
         $("span#requireMobile").show();   
         $("input#mobile").empty();
         return;
      } else {
         $("span#requireMobile").hide();
      }// end of if(!test) {}-------------------
      
      var frm = document.formContactCreate;
      frm.action = "<%= ctxPath%>/employee/idv_detailContactRevise.os";
      frm.method = "POST";
      frm.submit();
      
   }// end of function detailContactRevise() {}--------------------------
   
   // 주소록 삭제
   function detailContactDelete() {
	  
      var frm = document.formContactCreate;
      frm.action = "<%= ctxPath%>/employee/idv_detailContactDelete.os";
      frm.method = "POST";
      frm.submit();
      
   }

</script>

<div id="content">
   <header>
      <h1>   
         <span id="title">주소록 수정</span>   
      </h1>   
   </header>
      
   <div class="content_page">
      <form id="contactCreateId" name="formContactCreate" enctype="multipart/form-data">
         <fieldset>
            <table class="form_type">
               <colgroup>
                  <col width="130px">
                  <col width="*">
               </colgroup>
               <tbody>
               <tr>
                  <th><span class="title">사진</span></th>
                  <td>
                     <span class="img_profile" style="overflow:hidden">
                        <span class="wrap_btn wrap_file_upload">
                           <span class="btn_file_form fileinput-button" id="buttonWrap" style="text-align: center;">
                              <!-- <span class="button text" id="buttonText">   
                                 <span class="buttonText" onclick="onclick=document.all.file.click()">사진 올리기</span>
                              </span> -->
                              <input type="file" name="file" title="파일 첨부" accept="undefined" style="display: none;">
                           </span>
                           <div class="progress" style="display:none; margin-top:5px"></div>
                        </span>
                        <c:choose>
                           <c:when test="${not empty pbvo.photo_route}"><img src="<%= ctxPath%>/resources/images/${pbvo.photo_route}" alt="" id="thumbnail_image"></c:when>
                           <c:otherwise><img src="<%= ctxPath%>/resources/images/photo_profile_large.jpg" alt="" id="thumbnail_image"></c:otherwise>
                        </c:choose>
                     </span>
                     <!-- <span class="btn_fn7" id="del_photo" data-role="button">삭제</span>
                           <div class="wrap_desc"><span class="desc">※ 사진은 자동으로 100x100 사이즈로 적용 됩니다.</span></div> -->
                     <input type="hidden" name="book_no" value="${pbvo.book_no}" />
                  </td>
               </tr>
               <tr>
                  <th>
                     <span>이름</span>
                     <span class="requirement">*</span>
                  </th>
                  <td>
                     <input type="text" id="name" name="name" value="${pbvo.name}" required="required" />&nbsp;
                     <span class="require" id="requireName">2자 이상, 10자 이하를 입력해야 합니다.</span>
                  </td>
               </tr>
               <tr>
                  <th><span class="title">회사</span></th>
                  <td>
                     <span class="txt_edit" id="company_name" style="display:none">
                        <input name="company_name" id="company_name" class="input wfix_large" type="text" value="${pbvo.company_name}" />
                     </span>
                     <span class="txt_form contact_item_modify" id="spanCompany">${pbvo.company_name}&nbsp;
                        <span class="ui_edit btn_wrap">
                           <i class="fa fa-edit" id="fa_company"></i>
                        </span>
                     </span>
                  </td>
               </tr>
               <tr>
                  <th><span class="title">부서</span></th>
                  <td>
                     <span class="txt_edit" id="dept_name" style="display:none">
                        <input name="dept_name" id="dept_name" class="input wfix_large" type="text" value="${pbvo.dept_name}" />
                     </span>
                     <span class="txt_form contact_item_modify" id="spanDept">${pbvo.dept_name}&nbsp;
                        <span class="ui_edit btn_wrap">
                           <i class="fa fa-edit" id="fa_dept"></i>
                        </span>
                     </span>
                  </td>
               </tr>
               <tr>
                  <th><span class="title">직위</span></th>
                  <td>
                     <span class="txt_edit" id="position_name" style="display:none">
                        <input name="position_name" id="position_name" class="input wfix_large" type="text" value="${pbvo.position_name}" />
                     </span>
                     <span class="txt_form contact_item_modify" id="spanPosition">${pbvo.position_name}&nbsp;
                        <span class="ui_edit btn_wrap">
                           <i class="fa fa-edit" id="fa_position"></i>
                        </span>
                     </span>
                  </td>
               </tr>
               <tr>
                  <th>
                     <span class="title">이메일</span>
                     <span class="requirement">*</span>
                  </th>
                  <td>
                     <span class="txt_edit" id="email" style="display:none">
                        <input id="email" name="email" class="input wfix_large" type="text" value="${pbvo.email}" required="required" />
                     </span>
                     <span class="txt_form contact_item_modify" id="spanEmail">${pbvo.email}&nbsp;
                        <span class="ui_edit btn_wrap">
                           <i class="fa fa-edit" id="fa_email"></i>
                        </span>
                     </span>
                     <span class="require" id="requireEmail">이메일 형식이 올바르지 않습니다.</span>
                  </td>
               </tr>
               <tr>
                  <th>
                     <span class="title">휴대폰</span>
                     <span class="requirement">*</span>
                     <span class="help">
                        <a href="#" data-toggle="tooltip" data-placement="right" data-html="true" title="휴대폰의 경우, 아래 방식으로 입력해 주세요. <br><br> (휴대폰:010-1234-5678) 인 경우, '-' 를 포함한 <br>  010-1234-5678<br><br>"><i class="fa fa-info-circle"></i></a>
                     </span>
                  </th>
                  <td>
                     <span class="txt_edit" id="mobile" style="display:none">
                        <input id="mobile" name="mobile" type="text" value="${pbvo.mobile}" required="required" />
                     </span>
                     <span class="txt_form contact_item_modify" id="spanMobile">${pbvo.mobile}&nbsp;
                        <span class="ui_edit btn_wrap">
                           <i class="fa fa-edit" id="fa_mobile"></i>
                        </span>
                     </span>
                     <span class="require" id="requireMobile">올바른 방식으로 입력해주세요.</span>
                  </td>
               </tr>
               <tr>
                  <th>
                     <span class="title">회사전화</span>
                     <span class="help">
                        <a href="#" data-toggle="tooltip" data-placement="right" data-html="true" title="해외 전화번호인 경우, 아래 4가지 방식으로 입력해 주세요. <br><br> (국가번호:82) (지역번호:02) (전화번호:123-4567) 인 경우, <br>  1. 8221234567<br> 2. 82021234567<br>  3. 82-2-123-4567<br> 4. 82-02-123-4567<br><br>"><i class="fa fa-info-circle"></i></a>
                     </span>
                  </th>
                  <td>
                     <span class="txt_edit" id="corp_phone" style="display:none">
                        <input name="corp_phone" id="corp_phone" class="input wfix_large" type="text" value="${pbvo.corp_phone}" />
                     </span>
                     <span class="txt_form contact_item_modify" id="spanCorp_phone">${pbvo.corp_phone}&nbsp;
                        <span class="ui_edit btn_wrap">
                           <i class="fa fa-edit" id="fa_corp_phone"></i>
                        </span>
                     </span>
                  </td>
               </tr>
               <tr>
                  <th>
                     <span class="title">주소</span>
                  </th>
                  <td>
                     <span id="officeDetail" class="txt_edit">
                        <c:choose>
                           <c:when test="${empty pbvo.postcode}">
                              <input type="text" id="addressDetail" value="" size="41" />&nbsp;
                           </c:when>
                           <c:otherwise>
                              <input type="text" id="addressDetail" value="(${pbvo.postcode}) ${pbvo.address} ${pbvo.detail_address} ${pbvo.extra_address}" size="41" />&nbsp;
                           </c:otherwise>
                        </c:choose>
                         <input name="postcode" id="postcode" class="input wfix_max" type="hidden" value="${pbvo.postcode}">
                        <input name="address" id="address" class="input wfix_max" type="hidden" value="${pbvo.address}">
                        <input name="detail_address" id="detail_address" class="input wfix_max" type="hidden" value="${pbvo.detail_address}">
                        <input name="extra_address" id="extra_address" class="input wfix_max" type="hidden" value="${pbvo.extra_address}">
                     </span>
                     <span title="" class="ic_con ic_detail" data-toggle="modal" data-target="#gpopupLayer" data-dismiss="modal" data-backdrop="static" style="cursor: pointer;"><i class="fa fa-chevron-circle-right"></i></span>
                  </td>
               </tr>
               <tr>
                  <th>
                     <span class="title">메모</span>
                  </th>
                  <td>
                     <textarea rows="5" cols="40" name="memo">${pbvo.memo}</textarea>
                  </td>
               </tr>
               
               <tr class="line"><td colspan="2"><hr></td></tr>                  
               </tbody>
            </table>
         </fieldset>
      </form>
      <div class="page_action_wrap">
         <a onclick="detailContactRevise();" id="saveModify"><span>수정</span></a>
         <a onclick="contactReviseCancel();" id="modifyCancel"><span>취소</span></a>
         <c:set var="goBackURL" value='${fn:replace(goBackURL, "   ", "&")}' />
         <a href="javascript:location.href='<%= ctxPath%>/${goBackURL}'" id="returnList"><span>목록으로 이동</span></a>
         <a onclick="detailContactDelete();" id="contactDelete"><span>삭제</span></a>
      </div>
   </div>
</div>

<!-- ===== 주소 등록 Modal ===== -->
<div class="modal fade" id="gpopupLayer" role="dialog" data-id="1f8c4968-a7f8-4597-8e6e-b70da685aa3c" data-close="false" style="min-width: 300px; top: 106px; position: fixed; left: 369px;" data-layer="">
   <div class="modal-dialog">
      <div class="modal-content">
         <header id="headerModal">    
            <h1>주소 상세입력</h1>        
            <a id="go_popup_close_icon" class="btn_layer_x" style="" data-bypass="" title="닫기">
               <span class="ic"></span>
               <span class="txt"></span>
            </a>
         </header>
         
         <div class="content" id="contentModal">
            <span id="popupContent">
               <form name="formAddrDetail">
                  <table class="table_form_mini">
                     <tbody id="tbodyModal">
                        <tr>
                           <td><button type="button" id="postcodeSearch" style="width: 122px; height: 48px;">우편번호 찾기</button></td>         
                        </tr>
                        <tr>
                           <th><span class="txt spanModal">우편번호</span></th>
                           <td><input name="postcode" id="modalPostcode" class="txt_mini" type="text" value="${pbvo.postcode}" size="40" readonly="readonly"></td>         
                        </tr>
                        <tr>
                           <th><span class="txt spanModal">주소</span></th>
                           <td><input name="address" id="modalAddress" class="txt_mini" type="text" value="${pbvo.address}" size="40" readonly="readonly"></td>         
                        </tr>
                        <tr>
                           <th><span class="txt spanModal">상세주소</span></th>
                           <td><input name="detail_address" id="modalDetail_address" class="txt_mini" type="text" value="${pbvo.detail_address}" size="40"></td>         
                        </tr>
                        <tr>
                           <th><span class="txt spanModal">주소 참고항목</span></th>
                           <td><input name="extra_address" id="modalExtra_address" class="txt_mini" type="text" value="${pbvo.extra_address}" size="40" readonly="readonly"></td>         
                        </tr>
                     </tbody>
                  </table>
               </form>   
            </span>
         </div>
         
         <footer class="btn_layer_wrap">
            <a class="btn_major_s" id="modalSave" data-dismiss="modal" data-bypass="" style="margin-right:5px" title="저장">
               <span class="ic"></span>
               <span class="txt">저장</span>
            </a>
            <a class="btn_minor_s" id="modalCancel" data-dismiss="modal" data-bypass="" style="margin-right:5px" title="취소">
               <span class="ic"></span>
               <span class="txt">취소</span>
            </a>
         </footer>
      </div>
   </div>
</div>