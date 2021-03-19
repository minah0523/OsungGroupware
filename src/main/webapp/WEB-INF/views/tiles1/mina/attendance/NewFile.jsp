<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath();%>

<style type="text/css">
 
   #table th{margin:0 10 5 0px;}
   #table th{padding: 5px;
   width: 40px;
   }
   
   
   #table td{padding: 5px;
   
   }
   #table {border-collapse: collapse;
           width: 100%;
           }
             
/*    input#title{
   width:60%;
   height:30px;
   }          */ 
   /* select{
   width:20%;
   height:30px;
   
   }    */       
   td#boardButton{
   text-align: center;
    border:solid 1px red;  
   padding-top: 20px;
   }
   
   button{
   border: none;
   width: 90px;
   height:50px;
   border-radius:5px;
   }
   
   button#fileUpload{
   background-color:#0F4C81;
   color:white;
   }
   button#save{
   background-color:#D8D8D8;
   }

   
    /*input file의 기본 모습을 제거*/
    #board_fileupload {
      width: 0.1px;
      height: 0.1px;
      opacity: 0;
      overflow: hidden;
      position: absolute;
      z-index: -1;   
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
   
</style>

<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>  
<script type="text/javascript">
 $(document).ready(function(){
 
       
       // 선택된  파일에서 파일명만 추출
      var fileTarget = $('#board_fileupload'); 
      fileTarget.on('change', function(){ // 값이 변경되면 
      
          alert("파일 선택 완료");   
         if(window.FileReader){ //window에 읽을 파일이 있다면. 
            var filename = $(this)[0].files[0].name;  // 첫번째 파일명
         } 
         else { // old IE 
            var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
         } // 추출한 파일명 삽입 
         
         $("input.upload-name").val(filename);  
          //#board_fileupload 아래에 있는 upload-name의 값에 filename을 추출한것을 넣어준다. 
       });  
      
       /////////////////////////////////////////////////////
       $("button#fileUpload").click(function(){
          

        var frm = document.fileAddFrm;
       frm.method="POST";
       frm.action="<%=ctxPath%>/fileAddEnd.os";
       frm.submit(); 
       });//파일 업로드 등록버튼 끝---------------------------------------------------------------
       
 });// $(document).ready(function(){}----------------------------------------------
</script>

<div style="padding-left: 5%;">
   <h2>파일업로드</h2>
      <form name="fileAddFrm" enctype="multipart/form-data">
         <table id="table">
            <thead></thead>
            <tbody>
               <tr>
                  <td class="filehead" style="width:80px">자료실</td>
                  
                     <td>
                        <select id="selectBoard" name="fk_dept_no">
                         <option selected disabled>전사자료실</option> 
                        </select>	
                     </td>                  
               </tr>
               <tr>
               	 <td class="filehead" style="width:40px;">파일첨부</td>
                   <td>
                       
                    	<input type="file" name="file" id="board_fileupload"/> 
                       <label for='board_fileupload'
                       style="text-align:center;padding-top:5px; width:100px; height:30px; background-color: #0174DF;color:white; border:0px; border-radius: 2px;">
                         <i class="fa fa-file-o"></i>&nbsp;파일선택</label>
                   </td>
               </tr>
               </tbody>
         </table>
         <table>
           <tbody> 
       
         <tr style="background-color: #F2F2F2;">
            <td style="width: 140px;  text-align: left; padding-left: 120px;">이름</td>
            <td style="width: 70px; text-align:  right; padding-right: 50px;">크기</td>
            <td style="width: 50px;  text-align: right; padding-right: 50px;">확장자</td>
    
         </tr>
       
   
         
     
          <tr>
              
             <td style="width: 140px;  text-align: left; padding-left: 120px;">
             <input class="upload-name" value="선택된 파일이 없습니다." disabled="disabled" /></td>         
             <td style="width: 70px;  text-align: right; padding-right: 50px;" > 크기</td>
             <td style="width: 70px;  text-align: right; padding-right: 50px;" > 확장자</td>
             
          </tr>
          </tbody>
         </table> 
 
          <button type="button" id=fileUpload>업로드</button>
          <button type="button" onclick="javacript:history.back();">취소</button>

             
      </form>
</div>