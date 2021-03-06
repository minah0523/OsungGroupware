
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   


<style type="text/css">
#containerBox {
	margin: 50px 120px;
}

#titleInBox {
	margin: 50px 30px;
}

#btnNewAppr {
	margin: 0 0 30px 30px;
}

#waitingDoc {
	font-size: 14px;
	margin: 0 0 20px 0;
}

.docListTitle {
	font-weight: bold;
	font-size: 13pt;
	margin: 50px 0 30px 0;
}

.docListTitle2 {
	font-weight: bold;
	font-size: 13pt;
	margin: 80px 0 20px 0;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th,
	.table>thead>tr>td, .table>thead>tr>th {
	vertical-align: middle;
	align-items: center;
	padding: 0;
}

.tblElecApprInfo {
	border: 1px solid #c5ccd3;
	height: 50px;
	text-align: center;
	vertical-align: middle;
	align-items: center;
}

th.tblElecApprInfo {
	color: white;
	background-color: #c5ccd3;
	width: 50%;
	text-align: center;
	vertical-align: middle;
}

td.tblElecApprInfo {
	width: 50%;
	text-align: center;
	vertical-align: middle;
	align-items: center;
}

div.divElecApprInfo {
	display: inline-block;
	float: left;
	align-items: center;
}

.tblElecApprLineInfo {
	text-align: center;
	height: 35px;
}

tr.tblElecApprLineInfo>th {
	text-align: center;
	color: white;
	background-color: #c5ccd3;
}

#title {
	width: 99.8%;
	height: 30px;
	margin-right: 20px;
}

/***** slider *****/
.switch {
	vertical-align: middle;
	position: relative;
	display: inline-block;
	width: 50px;
	height: 25px;
}

.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	-webkit-transition: .4s;
	transition: .4s;
}

.slider:before {
	position: absolute;
	content: "";
	height: 20px;
	width: 20px;
	left: 4px;
	margin: 2.5px 0;
	background-color: white;
	-webkit-transition: .4s;
	transition: .4s;
}

input:checked+.slider {
	background-color: #cbb2ae;
}

input:focus+.slider {
	box-shadow: 0;
}

input:checked+.slider:before {
	-webkit-transform: translateX(22px);
	-ms-transform: translateX(22x);
	transform: translateX(22px);
}

/* Rounded sliders */
.slider.round {
	border-radius: 22px;
}

.slider.round:before {
	border-radius: 50%;
}

#submitArea {
	text-align: center;
	margin: 40px 0;
}

#submitArea>a {
	width: 100px;
}

      /* ????????? CSS ?????? */
      .content_layout_address {
         width: 1200px;
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
       height: 40px;
       line-height: 40px;
       font-size: 13px;
       color: #999;   
       
         list-style-type: none;      
   }
   
   .tab_nav li:first-child {
         margin: 0;
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
   span.addGroup {
         
   }
   span.addFinApprover {
         
   }
   .addArea {
   		display: flex;
        flex-direction: column;
		justify-content: center;
        vertical-align: middle;
        margin: 0 20px;
   }
   .addList, li {
         list-style-type: none;
   }
   div.approver_wrap div.approver_list ul {
       border: 1px solid #666;
       height: 105px;
       overflow-x: hidden;
       background: #f9f9f9;
       padding: 0 4px;
   } 
   div.approver_wrap div.approver_list {
       display: inline-block;
       margin: 10px 0 0 0;
       width: 270px;
   }
   
   li.orgName {
          cursor: pointer;
   
   }
      /* ????????? CSS ??? */


</style>


<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 



<script type="text/javascript">

	//?????? ?????? ??????(??????????????????)
	window.closeModal = function(){
	    $('.modal').modal('hide');
	    // javascript:history.go(0);
	};
	
	$(document).ready(function(){
		
		
		//????????? ???????????? ???????????? ???????????? ?????? ?????????
	    $('input[name=chkbox]').click(function(){
	        //?????? ????????? ????????? ????????? ?????? ????????? ??????
	        if ($(this).prop('checked')) {
	            //???????????? ????????? ?????? ????????? ?????? ????????? ????????? ?????? ?????? ????????????
	            $('input[name=chkbox]').prop('checked', false);
	            $(this).prop('checked', true);
	        }
	    });
	  
	    getDate();
	
	// ?????????????????? ??????????????? ????????? ??????????????? ???????????? ?????????
	$("select#attendanceSort").bind("change", function() {
		// func_choice($(this).val()); 
		// $(this).val()??? "1" ?????? "2" ?????? "3" ??????.
		var docSortTitle="";
		var html=""
		
		if ($(this).val()==1) {
			docSortTitle += "?????? ?????????";
			html += "<table  " + 
			"			style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>  " + 
			"			<colgroup>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 180px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 250px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"			</colgroup>  " + 
			"  " + 
			"			<tbody>  " + 
			"				<tr>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>  " + 
			"						???   ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='date' name='attendance_start_date' style='width: 99%;'/></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						??????/??????</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><select name='contents3' style='width: 99%;'>" + 
			"    																																<option value='??????'>??????</option>"+
			"    																																<option value='??????'>??????</option></select></span>"+
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						???    ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='contents4' style='width: 99%;' /></span>  " + 
			"					</td>  " + 
			"					  " + 
			"				</tr>  " + 
			"			</tbody>  " + 
			"		</table>" +
			" 		<input type='hidden' id='contents2' name='contents2' value=' '/> " +
			" 		<input type='hidden' id='attendance_finish_date' name='attendance_finish_date' value='9999-12-31'/> " +
			" 		<input type='hidden' id='vacation_days' name='vacation_days' value='0.5'/> ";
		}
		
		else if ($(this).val()== 2) {
			docSortTitle += "?????? ?????????";
			html += "<table  " + 
			"			style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>  " + 
			"			<colgroup>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 180px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 250px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"			</colgroup>  " + 
			"  " + 
			"			<tbody>  " + 
			"				<tr>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>  " + 
			"						???   ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='date' name='attendance_start_date' style='width: 99%;'/></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						??? ??? ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='contents3' style='width: 99%;' /></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						???   ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='contents4' style='width: 99%;' /></span>  " + 
			"					</td>  " + 
			"					  " + 
			"				</tr>  " + 
			"			</tbody>  " + 
			"		</table>" +
			" 		<input type='hidden' id='contents2' name='contents2' value=' '/> " +
			" 		<input type='hidden' id='attendance_finish_date' name='attendance_finish_date' value='9999-12-31'/> " +
			" 		<input type='hidden' id='vacation_days' name='vacation_days' value='1'/> ";
			
		}
		else if ($(this).val()== 3){
			docSortTitle += "?????? ?????????";
			html += "<table  " + 
			"			style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>  " + 
			"			<colgroup>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 180px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 250px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"			</colgroup>  " + 
			"  " + 
			"			<tbody>  " + 
			"				<tr>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>  " + 
			"						??? ??? ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='date' name='attendance_start_date' style='width: 99%;'/></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						??? ??? ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='date' name='attendance_finish_date' style='width: 99%;' /></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						??????????????????</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='vacation_days' style='width: 80%;' /> &nbsp;&nbsp;&nbsp; ???</span>  " + 
			"					</td>  " + 
			"					  " + 
			"				</tr>  " + 
			"			</tbody>  " + 
			"		</table>" +
			" 		<input type='hidden' id='contents2' name='contents2' value=' '/> " +
			" 		<input type='hidden' id='contents3' name='contents3' value=' '/> " +
			" 		<input type='hidden' id='contents4' name='contents4' value=' '/> ";
		}
		else if ($(this).val()== 4){
			docSortTitle += "?????? ?????????";
			html += "<table  " + 
			"			style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>  " + 
			"			<colgroup>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 180px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 250px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"			</colgroup>  " + 
			"  " + 
			"			<tbody>  " + 
			"				<tr>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>  " + 
			"						??? ??? ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='date' name='attendance_start_date' style='width: 99%;'/></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						??? ??? ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='date' name='attendance_finish_date' style='width: 99%;' /></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						??? ??? ???</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='contents4' style='width: 99%;' /></span>  " + 
			"					</td>  " + 
			"					  " + 
			"				</tr>  " + 
			"			</tbody>  " + 
			"		</table>" +
			" 		<input type='hidden' id='contents2' name='contents2' value=' '/> " +
			" 		<input type='hidden' id='contents3' name='contents3' value=' '/> " +
			" 		<input type='hidden' id='vacation_days' name='vacation_days' value='0'/> ";
		}
			
			$("span#docSortTitle").text(docSortTitle);
		
			$("div#docHeader2").html(html);
			$("div#docHeader2").show();
	}); 
	
	
	
	
	<%-- === ????????? ????????? ?????? ?????? === --%>
    //????????????
    var obj = [];
    
    //?????????????????? ???????????????
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "content",
        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
        htParams : {
            // ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
            bUseToolbar : true,            
            // ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
            bUseVerticalResizer : true,    
            // ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
            bUseModeChanger : true,
        }
    });
    <%-- === ????????? ????????? ?????? ??? === --%>
    

	   $("button#btnWrite").click(function(){
		
		<%-- === ????????? ????????? ?????? ?????? === --%>
        //id??? content??? textarea??? ??????????????? ??????
        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
        <%-- === ????????? ????????? ?????? ??? === --%>

        var selectVal = $("select#attendanceSort").val().trim();
        if(selectVal == null || selectVal == "") {
			alert("??????????????? ???????????????!!");
        	return;
        }
        
        var finApprVal =  $("#fk_fin_approver_no").val().trim();
        if(finApprVal == null || finApprVal == ""){
			alert("?????????????????? ???????????? ?????????????????? ??????????????????.");
        	return;
        }
        
	    // ????????? ????????? ??????
		var titleVal = $("input#title").val().trim();
		if(titleVal == "") {
			alert("???????????? ???????????????!!");
			return;
		}
        
		
		<%-- === ?????????????????? ?????? ?????? === --%>
        //?????????????????? ????????? ??????????????? ????????? p?????? ??????
        var contentval = $("#content").val();
	        
        // === ????????? ===
        // alert(contentval); // content??? ????????? ???????????? ????????? ?????? ????????? ?????? ???????????????.
        // "<p>&nbsp;</p>" ????????? ?????????.
        
        // ?????????????????? ????????? ??????????????? ????????? p?????? ?????????????????? ?????? ????????? ????????? ????????? ??????.
        // ????????? ????????? ?????? 
        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
        	alert("???????????? ???????????????!!");
        	return;
        }
        
        // ?????????????????? ????????? ??????????????? ????????? p?????? ????????????
        contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>??? ??????
    /*    
              ???????????????.replace(/?????? ?????????/gi, "????????? ?????????");
        ==> ????????? ??? ????????? ??? ?????? ?????????(/)???????????? ?????? ?????? ???????????? ???????????? ????????? ????????? ????????????. 
                     ????????? ?????? gi??? ????????? ???????????????.

        	g : ?????? ?????? ???????????? ?????? global
        	i : ?????? ??????????????? ??????, ?????? ???????????? ?????? ?????? ignore
    */    
    	contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>??? ??????  
    	contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>??? ?????? 
    	contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> ?????? </p> ?????? ?????????
    
        $("textarea#content").val(contentval);
     	// alert(contentval); 	        
        <%-- === ?????????????????? ?????? ??? === --%>
        
    	// ???(form) ??? ??????(submit)
		var frm = document.addFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/attendance/writeEnd.os";
		frm.submit();   
    }); 
	
    
    ////////////???????????????//////////////
   	
    
       // ====== ????????? js ====== //
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
       
      // ====== ????????? ????????? js ??? ====== // 
     
      
      // ====== ??????????????? ????????? ?????? ????????? ====== //
      $("li.orgName").each(function(){
         $(this).click(function(){
            var fk_dept_no = $(this).val();
            // alert("????????? ?????? ????????? value ??????? ==> " + fk_dept_no);
            
            // sessionStorage.setItem("fk_dept_no", fk_dept_no);
            // var fk_dept_noVal = sessionStorage.getItem("fk_dept_no");
            
            console.log("??????" + typeof(fk_dept_no)); // number 
            
            $.ajax({ 
               url:"<%= ctxPath %>/elecapproval/writeAddAddress.os",
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
            
            
            var emp_name = $(".emp_name").text();
            var position_name = $(".position_name").text();
            var dept_name = $(".dept_name").text();
            var emp_no = $(".emp_no").text();
            
            console.log("????????? ==> " + emp_name);
            console.log("????????? ==> " + position_name);
            console.log("????????? ==> " + dept_name);
            console.log("???????????? ==> " + emp_no);
                                    
            
         });
         
         
         
      });   
      
      
      
      
      // ====== ??????????????? ???????????????, ??????????????? ?????? ???????????? ??? ====== // 
      
      
      
      /////////////////////??????????????? ?????? ??????////////////////////////////
       $(document).on("click","span.addMidApprover",function() {      
    	   
    	 //????????? ??????????????? ????????? ?????? ??? ??????.      
           console.log("length: "+$("input[name=chkbox]:checked").length);
           
           var chkCount = $("input[name=chkbox]:checked").length;
           
           // ????????? Row??? ?????? ????????????.
           var rowData = new Array();
           var tdArr = new Array();
           var checkbox = $("input[name=chkbox]:checked");

           var empList = new Array();
           
           var resultEmpList = "";
           
           var resultEmpListTemp = "";
           
           // ????????? ???????????? ?????? ????????????
           checkbox.each(function(i) {
     
              // checkbox.parent() : checkbox??? ????????? <td>??????.
              // checkbox.parent().parent() : <td>??? ??????????????? <tr>??????.
              var tr = checkbox.parent().parent().eq(i);
              var td = tr.children();
              
              // ????????? row??? ?????? ?????? ????????? ?????????.
              rowData.push(tr.text().trim());
              
              // td.eq(0)??? ???????????? ?????????  td.eq(1)??? ????????? ????????????.
              var emp_name = td.eq(1).text().trim();
              var position_name = td.eq(2).text().trim();
              var dept_name = td.eq(3).text().trim();
              var emp_no = td.eq(4).text().trim(); //  + "\n"; // ?????? ??????
              
              // ????????? ?????? ????????? ?????????.(?????? ????????? ?????????. [{} ,{}] ?????? )
              empList.push({emp_name: emp_name
                         ,position_name: position_name
                         ,dept_name: dept_name
                         ,emp_no: emp_no
              });
              
              // ?????? ?????????, ?????? ????????? ?????? ??? ?????? ??? ????????? ???????????? ?????? ??? ????????????
              $.each(empList, function(index, item){
                   
                 // console.log("$.each??? empList ????????????????==? " + item.emp_name);
                 // console.log("$.each??? empList ????????????????==? " + item.position_name);
                 // console.log("$.each??? empList ????????????????==? " + item.dept_name);
                 // console.log("$.each??? empList ????????????????==? " + item.emp_no);
                 
                 // ?????? ????????? ?????? ??? ????????? ?????? temp ??????(????????? ????????? ??? ??????????????? ??????)
                 resultEmpListTemp = item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
                 
                 // ???????????? temp??? ??????
                 if(resultEmpList.indexOf(resultEmpListTemp) == -1 ) {
                 
                    if(index == 0) { 
                       resultEmpList += item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
                    }
                    else { // ????????? ????????? ???????????? ????????? ?????? ????????? ??????
                       resultEmpList += "\n" + item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;;
                    }
                 }
                   
              });
              
           }); // ???????????? ??????
           
           
           // ????????? ?????? ????????? ?????? (?????????)
           $(".midApprLists").eq(0).text(resultEmpList);
           
         
      }); //??????????????? ???????????? ???
      
      
      
      
      ////////////////??????????????? ?????? ??????/////////////////////
      $(document).on("click","span.addFinApprover",function() {         
    	  
         //????????? ??????????????? ????????? ?????? ??? ??????.      
         console.log("length: "+$("input[name=chkbox]:checked").length);
         
         var chkCount = $("input[name=chkbox]:checked").length;
         
         // ????????? Row??? ?????? ????????????.
         var rowData = new Array();
         var tdArr = new Array();
         var checkbox = $("input[name=chkbox]:checked");

         var empList = new Array();
         
         var resultEmpList = "";
         
         var resultEmpListTemp = "";
         
         // ????????? ???????????? ?????? ????????????
         checkbox.each(function(i) {
   
            // checkbox.parent() : checkbox??? ????????? <td>??????.
            // checkbox.parent().parent() : <td>??? ??????????????? <tr>??????.
            var tr = checkbox.parent().parent().eq(i);
            var td = tr.children();
            
            // ????????? row??? ?????? ?????? ????????? ?????????.
            rowData.push(tr.text().trim());
            
            // td.eq(0)??? ???????????? ?????????  td.eq(1)??? ????????? ????????????.
            var emp_name = td.eq(1).text().trim();
            var position_name = td.eq(2).text().trim();
            var dept_name = td.eq(3).text().trim();
            var emp_no = td.eq(4).text().trim(); //  + "\n"; // ?????? ??????
            
            // ????????? ?????? ????????? ?????????.(?????? ????????? ?????????. [{} ,{}] ?????? )
            empList.push({emp_name: emp_name
                       ,position_name: position_name
                       ,dept_name: dept_name
                       ,emp_no: emp_no
            });
            
            // ?????? ?????????, ?????? ????????? ?????? ??? ?????? ??? ????????? ???????????? ?????? ??? ????????????
            $.each(empList, function(index, item){
                 
               // console.log("$.each??? empList ????????????????==? " + item.emp_name);
               // console.log("$.each??? empList ????????????????==? " + item.position_name);
               // console.log("$.each??? empList ????????????????==? " + item.dept_name);
               // console.log("$.each??? empList ????????????????==? " + item.emp_no);
               
               // ?????? ????????? ?????? ??? ????????? ?????? temp ??????(????????? ????????? ??? ??????????????? ??????)
               resultEmpListTemp = item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
               
               // ???????????? temp??? ??????
               if(resultEmpList.indexOf(resultEmpListTemp) == -1 ) {
               
                  if(index == 0) { 
                     resultEmpList += item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
                  }
                  else { // ????????? ????????? ???????????? ????????? ?????? ????????? ??????
                     resultEmpList += "\n" + item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;;
                  }
               }
                 
            });
            
         }); // ???????????? ??????
         
         
         // ????????? ?????? ????????? ?????? (?????????)
         $(".finApprLists").eq(0).text(resultEmpList);
         
      }); // ??????????????? ?????? ?????? ???

    
    ////////////????????????//////////////
    
    
    
	}); // end of $(document).ready(function(){})----------------
   


// ====== ??????????????? ?????? ?????? ???????????? ====== //  
   function findEmpOk() {
      
	///////////////////////???????????????????????????//////////////////////////////////
	// ?????? ????????? ??????
      var data_mid = $(".midApprLists").eq(0).text();
      
      // ????????? ???????????? ???????????? ????????? ?????? ????????? 
      var arrData_mid = data_mid.split("\n");
      
      // ???????????? ??????
      var empnoExtract_mid = "";
      var arrEmpno_mid = [];
      
      var empPositionExtract_mid = "";
      var arrEmpPosition_mid = [];
      
      var empDeptExtract_mid = "";
      var arrEmpDept_mid = [];
      
      // ????????? ??????
      var empNameExtract_mid = ""; 
      var arrEmpName_mid = [];     
      
      // ?????? ????????? ??????
      arrData_mid.forEach(function(item, index, arr){
          //?????????/??????/??????/2019003 
	    	  
	       // ?????????
	       empNameExtract_mid = arr[index].indexOf('/'); // ??????[index]??? ????????? /??? ????????? ?????????. 
	       arrEmpName_mid.push(arr[index].slice(0, empNameExtract_mid)); // slice : 0???????????? empNameExtract ????????? ??????
	
	       // ??????
	       empPositionExtract_mid = arr[index].indexOf('/',empNameExtract_mid+1);
	       arrEmpPosition_mid.push(arr[index].slice(empNameExtract_mid+1, empPositionExtract_mid)); // slice : empNameExtract+1???????????? empPositionExtract ????????? ??????
	
	       // ?????????
	       empDeptExtract_mid = arr[index].indexOf('/', empPositionExtract_mid+1);
	       arrEmpDept_mid.push(arr[index].slice(empPositionExtract_mid+1, empDeptExtract_mid)); // slice : empPositionExtract+1???????????? empDeptExtract ????????? ??????
	
	       // ????????????
	       empnoExtract_mid = arr[index].lastIndexOf('/'); // ??????[index]??? ????????? /??? ????????? ?????????. 
	       arrEmpno_mid.push(arr[index].slice(empnoExtract_mid+1));
	         
         
      });
      
      
   	  // ?????????
      for(var i=0; i<arrEmpName_mid.length; i++) {
         console.log("?????? " + i + "=> " + arrEmpName_mid[i]);
         
      }
      
      // ??????
      for(var i=0; i<arrEmpPosition_mid.length; i++) {
         console.log("?????? " + i + "=> " + arrEmpPosition_mid[i]);
         
      } 
      
   	  // ?????????
      for(var i=0; i<arrEmpDept_mid.length; i++) {
          console.log("?????? " + i + "=> " + arrEmpDept_mid[i]);
          
       }    
   	  
      // ????????????
      for(var i=0; i<arrEmpno_mid.length; i++) {
          console.log("?????? " + i + "=> " + arrEmpno_mid[i]);
          
       }    
      
      // ????????? ???????????? ?????????
      
      var strEmpName_mid = arrEmpName_mid.join(",");
      var strEmpPosition_mid = arrEmpPosition_mid.join(",");
      var strEmpDept_mid = arrEmpDept_mid.join(",");
      var strEmpno_mid = arrEmpno_mid.join(",");
      
      console.log("????????? arrEmpName_mid ????????? ???????????? ?????????  =====> " + strEmpName_mid);
      // ?????????,?????????

      console.log("????????? strEmpPosition_mid ????????? ???????????? ?????????  =====> " + strEmpPosition_mid);

      console.log("????????? strEmpDept_mid ????????? ???????????? ?????????  =====> " + strEmpDept_mid);

      console.log("????????? arrEmpno_mid ????????? ???????????? ?????????  =====> " + strEmpno_mid);
      // 2020013,2020019
      
    
      // ?????? ?????? ?????? ?????? value ??????
      $("input#fk_fin_approver_no_name_mid").val(strEmpName_mid); // ?????????
      $("input#fk_fin_approver_no_dept_mid").val(strEmpDept_mid); // ??????
      $("input#fk_fin_approver_no_position_mid").val(strEmpPosition_mid); // ??????
      $("input#fk_mid_approver_no").val(strEmpno_mid); // ????????????
	
	///////////////////////???????????????????????????//////////////////////////////////
      // ?????? ????????? ??????
      var data = $(".finApprLists").eq(0).text();
      
      console.log("ul ???????????? ????????? data ??? ==> " + data);
    
      // ????????? ???????????? ???????????? ????????? ?????? ????????? 
      var arrData = data.split("\n");
      
      console.log("\n??? ???????????? ???????????? ==> " + arrData);
      // console.log("??????" + typeof(arrData)); // Object 
      
      // ???????????? ??????
      var empnoExtract = "";
      var arrEmpno = [];
      
      var empPositionExtract = "";
      var arrEmpPosition = [];
      
      var empDeptExtract = "";
      var arrEmpDept = [];
      
      // ????????? ??????
      var empNameExtract = ""; 
      var arrEmpName = [];     
      
      // ?????? ????????? ??????
      arrData.forEach(function(item, index, arr){
          //?????????/??????/??????/2019003 
    	  
         // ?????????
         empNameExtract = arr[index].indexOf('/'); // ??????[index]??? ????????? /??? ????????? ?????????. 
         arrEmpName.push(arr[index].slice(0, empNameExtract)); // slice : 0???????????? empNameExtract ????????? ??????

         // ??????
         empPositionExtract = arr[index].indexOf('/',empNameExtract+1);
         arrEmpPosition.push(arr[index].slice(empNameExtract+1, empPositionExtract)); // slice : empNameExtract+1???????????? empPositionExtract ????????? ??????

         // ?????????
         empDeptExtract = arr[index].indexOf('/', empPositionExtract+1);
         arrEmpDept.push(arr[index].slice(empPositionExtract+1, empDeptExtract)); // slice : empPositionExtract+1???????????? empDeptExtract ????????? ??????

         // ????????????
         empnoExtract = arr[index].lastIndexOf('/'); // ??????[index]??? ????????? /??? ????????? ?????????. 
         arrEmpno.push(arr[index].slice(empnoExtract+1));
         
         
         
      });
      
      
   	  // ?????????
      for(var i=0; i<arrEmpName.length; i++) {
         console.log("?????? " + i + "=> " + arrEmpName[i]);
         
      }
      
      // ??????
      for(var i=0; i<arrEmpPosition.length; i++) {
         console.log("?????? " + i + "=> " + arrEmpPosition[i]);
         
      } 
      
   	  // ?????????
      for(var i=0; i<arrEmpDept.length; i++) {
          console.log("?????? " + i + "=> " + arrEmpDept[i]);
          
       }    
   	  
      // ????????????
      for(var i=0; i<arrEmpno.length; i++) {
          console.log("?????? " + i + "=> " + arrEmpno[i]);
          
       }    
      
      // ????????? ???????????? ?????????
      
      var strEmpName = arrEmpName.join(",");
      var strEmpPosition = arrEmpPosition.join(",");
      var strEmpDept = arrEmpDept.join(",");
      var strEmpno = arrEmpno.join(",");
      
      console.log("????????? arrEmpName ????????? ???????????? ?????????  =====> " + strEmpName);
      // ?????????,?????????

      console.log("????????? strEmpPosition ????????? ???????????? ?????????  =====> " + strEmpPosition);

      console.log("????????? strEmpDept ????????? ???????????? ?????????  =====> " + strEmpDept);

      
      console.log("????????? arrEmpno ????????? ???????????? ?????????  =====> " + strEmpno);
      // 2020013,2020019
      
    
      // ?????? ?????? ?????? ?????? value ??????
      $("input#fk_fin_approver_no_name").val(strEmpName); // ?????????
      $("input#fk_fin_approver_no_dept").val(strEmpDept); // ??????
      $("input#fk_fin_approver_no_position").val(strEmpPosition); // ??????
      $("input#fk_fin_approver_no").val(strEmpno); // ????????????
           
      $('.modal').modal('hide'); // ???????????? ????????? ?????? ????????? ?????????
   }
   
	function getDate(){
		var d = new Date();
		
		var mm; 
		if( (d.getMonth() + 1) < 10 ) {
			mm = '0'+(d.getMonth() + 1);
		}else {
			mm = (d.getMonth() + 1) 
		}
		
		var dd;
		if( d.getDate() < 10 ) {
			dd = '0'+ d.getDate();
		}else {
			dd = d.getDate();
		}
		
		var dateText = d.getFullYear() + '-' + mm + '-' +  dd;
		$("#date").text(dateText);
	}
	
</script>

<div id="titleInBox" style="font-weight: bold; font-size: 19px;">?????? ?????? ??????</div>
<div id="containerBox">

	<form name="addFrm"  enctype="multipart/form-data">
	<div class="docListTitle">????????????</div>
	
	<div style="display: inline-block; width: 100%">

		<div class="divElecApprInfo table-responsive"
			style="float: left; width: 45%">
			<table class="table table-bordered tblElecApprInfo"
				style="font-size: 14px;">
				<tr class="tblElecApprInfo">
					<th class="tblElecApprInfo">????????????</th>
					<td class="tblElecApprInfo" style="align-items: center;">
						<div class="box" style="width: 93%; align-items: center;">
							<select name="fk_attendance_sort_no" id="attendanceSort" class="form-control pull-right row b-none"
								style="align-items: center;">
								<option value="">?????? ??????</option>
								<option value="1">??????</option>
								<option value="2">??????</option>
								<option value="3">??????</option>	
								<option value="4">??????</option>
							</select>
							<input type="hidden" id="selectedSort" name="selectedSort" />
						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</div>

		<div class="divElecApprInfo table-responsive"
			style="float: right; width: 45%">
			<table class="table table-bordered tblElecApprInfo"
				style="font-size: 14px;">
				<tr class="tblElecApprInfo">
					<th class="tblElecApprInfo">???????????????</th>
					<!-- *** session?????? ?????????????????? ????????? ?????????*** -->
					<%-- "${sessionScope.loginuser.name}" --%>
					<td class="tblElecApprInfo">${sessionScope.loginemp.emp_name}</td>
				</tr>
				</tbody>
			</table>
			<!-- *** session?????? ?????????????????? ????????? ?????????*** -->
			<%-- <input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.userid}" /> --%>
			<input type="hidden" name="fk_emp_no" value="${sessionScope.loginemp.emp_no}" />
		</div>

	</div>

	<div class="docListTitle">
	????????? ??????
    <%-- ????????? ?????? ????????????  --%>
	<button type="button" id="empList" class="btn btn-info" style="margin-left: 20px; border-radius: 3px;" data-toggle="modal" data-target="#findEmpListModal">???????????????</button>
	</div> 
	
	<div class="table-responsive"
		style="display: inline-block; width: 100%">
		<table class="table table-bordered tblElecApprLineInfo">
			<tbody>
				<tr class="tblElecApprLineInfo">
					<th style="width: 22%;">??????</th>
					<th>?????? ?????????</th>
					<th>?????? ????????? <span style="">*</span></th>
				</tr>
				<tr class="tblElecApprLineInfo">
					<th style="width: 22%;">??????</th>
					<td>
						<input type="text" name="fk_fin_approver_no_name_mid" id="fk_fin_approver_no_name_mid" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="fk_fin_approver_no_name" id="fk_fin_approver_no_name"  style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
				</tr>
				<tr class="tblElecApprLineInfo">
					<th style="width: 22%;">??????</th>
					<td>
						<input type="text" name="fk_fin_approver_no_dept_mid" id="fk_fin_approver_no_dept_mid" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="fk_fin_approver_no_dept" id="fk_fin_approver_no_dept" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
				</tr>
				<tr class="tblElecApprLineInfo">
					<th style="width: 22%;">??????</th>
					<td>
						<input type="text" name="fk_fin_approver_no_position_mid" id="fk_fin_approver_no_position_mid" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="fk_fin_approver_no_position" id="fk_fin_approver_no_position" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
				</tr>
			</tbody>
		</table>
		<%-- ??????????????? ?????? ????????? ????????? --%>
		<input type="hidden" name="fk_mid_approver_no" id="fk_mid_approver_no" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
		<input type="hidden" name="fk_fin_approver_no" id="fk_fin_approver_no" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
	</div>

	<div class="docListTitle2">????????????</div>

	<!-- ------------------------------------------------------------------------------------------------------------------------- -->

	<!-- ?????? ?????? ??????-->
		<%-- ????????????, ??????????????? ????????? --%>

			<div id="docHeader1">
				<table
				style='width: 100%; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 187px;'>
				<colgroup>
					<col style='width: 90px;'>
					<col style='width: 180px;'>
					<col style='width: 90px;'>
					<col style='width: 250px;'>
					<col style='width: 90px;'>
					<col style=''>
				</colgroup>
	
				<tbody>
					<tr>
						<td
							style='padding: 3px; border: 1px solid black; font-size: 27px; font-weight: bold; text-align: center; vertical-align: middle; height: 113px;'
							colspan='2'><span id="docSortTitle">????????????</span></td>
						<td
							style='padding: 3px; height: 113px; vertical-align: middle; border: 1px solid black; text-align: right;'
							colspan='4'><br></td>
					</tr>
					<tr>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							????????????</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${sessionScope.loginemp.dept_name}</span>
						</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							??? ??? ???</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
							<span id="date"
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;' ></span>
						</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							????????????</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left; font-size: 12px;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>????????????</span>
						</td>
					</tr>
				</tbody>
			</table> 
			</div>
			
			
			<%-- ?????? ??????, ???????????? contents2??? ????????? --%>
			<div id="docHeader2"> 
			
			</div>
		
	
	
		<!-- ?????? ?????? ???--> 
			
			<!-- ?????? ?????? -->
	
			<table
				style="width: 99.85%; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
				<colgroup>
					<col style="width: 90px;">
					<col style="width: 710px;">
				</colgroup>
			
			
				<tbody>
					<tr>
						<td
							style="padding: 3px; height: 25px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;">
							??? &nbsp;&nbsp;&nbsp; ???</td>
					<td style="vertical-align: middle; padding: 3px;">
						<input type="text" id="title" name="title" style="font-size: 11pt; vertical-align: middle;">
					</td>
					</tr>
					<!-- ?????? ??? -->
	
					<!-- ?????? ?????? -->
	
					<!-- content ?????? -->
					<tr>
						<td
							style="padding: 3px; height: 350px; vertical-align: top; border: 1px solid black;"
							colspan="2">
							<textarea name="content" id="content" rows="30"
								cols="100" style="width: 100%; height: 412px;">
									
							</textarea>
						</td>
					</tr>
					<!-- content ?????? -->
					<%-- === ???????????? ?????? ???????????? === --%>
			         <tr>
			            <th style="padding: 3px; height: 30px; text-align: center; border: 1px solid black; font-weight: bold">????????????</th>
			            <td style="padding: 0 10px">
			               <input type="file" name="attach" />       
			            </td>
			         </tr>
			         
				</tbody>
			</table> <!-- ?????? ??? -->
			
			
			
		</form>
		<!-- ------------------------------------------------------------------------------------------------------------------------- -->


		<p id="submitArea">
       		<button id="cancel" type="button" onclick="javascript:history.back()" style="width: 100px" class="btn btn-danger m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">
       			??????</button>		
			 <button id="btnWrite" type="button" id="btnWrite" style="width: 100px" class="btn btn-info m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">
			 	??????</button>
		</p>
   </div>

		<!-- ----------------------------------------------------------------?????????????????????--------------------------------------------------------- -->


	<%-- ????????? ?????? --%>
	<!-- Modal -->
	<div id="findEmpListModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog" style="width: 1200px;">
	 
	   <!-- Modal content-->
	   <div class="modal-content">
	     <div class="modal-header" style="height: 60px;">
	       <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()"><span style="font-size: 26pt;">&times;</span></button>
	       <h3 class="modal-title" style="font-weight: bold">????????? ??????</h3>
	     </div>
	     <div class="modal-body">
	       <div id="employeeList" style="border: none; width: 100%; height: 470px;"><!-- style="border: none; width: 100%; height: 470px;"> -->
	             <%-- findEmpList.jsp --%>
	         <div class="empList_Popup" style="overflow-x:hidden;">
	             
	            <div class="content" >
	            
	               <div class="content_layout_address" style="margin-left : 40px;">
	                  <div id="tabArea" style="margin-left : -40px;">
	                     <ul class="tab_nav nav_layer" style="margin-bottom: 22px;">
	                        <li value="org">
	                           <span style="font-size: 12pt; font-weight: bold;">?????????</span>
	                        </li>
	                     </ul>
	                  </div>
	                  
	                  <div class="tabWrap father" style="margin-left : -1px; height: 400px;"> <!-- border: solid 5px yellow;"> -->
	                     <div class="father" style=" border : solid 1px #999; overflow-y:auto; width: 600px">
	                     <%-- ????????? ??????--%>
	                     <div class="container" style="padding-top:10px; width: 200px; border-right: solid 1px #999; "> <%-- border: solid 2px navy; " --%>
	                         <div class="row box" style="width: 200px; "> <%--border: solid 2px pink;" --%>
	                             <div class="col-md-4">
	                                 <ul id="tree1">
	                                     <li style="width:130px;">
	                                        <a href="#">????????????</a>         
	                                         <ul>
	                                             <li class="orgName" style="width:120px;" value="1">???????????????</li>
	                                             
	                                             <li class="orgName" style="width:120px;" value="2">???????????????
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
	                                             <li class="orgName" value="3">?????????</li>
	                                             <li class="orgName" value="4">?????????</li>
	                                             <li class="orgName" value="5">?????????</li>
	                                             <li class="orgName" value="6">????????????</li>
	                                             <li class="orgName" value="7">IT???</li>
	                                             
	                                         </ul>
	                                     </li>
	                                 </ul>
	                             </div>
	                     </div>
	                  </div>
	                  <%-- ????????? ???--%>
	                  
	                  <%-- ??????????????? ??????--%>
	                  <div class="content_list box">
	                     <div class="search_wrap">
	                        <form class="emp_search">
	                           <input id="searchWord" class="search" type="text" placeholder="??????,??????">
	                            <button type="button" class="btn btn-info btnSearch" style="border-radius: 3px; color: white;">??????</button>   
	                        </form>  
	                     </div>
	                     <div class="scroll_wrap" style="height: 360px;">
	                        <table style="width: 396px; height: 366px; border: 0px; overflow-y:auto;">
	                           <thead style="padding:0;">
	                              <tr style="text-align: left; background: #efefef; font-weight: normal;">
	                                   <th style="padding-left:2px;">
	                                      <input type="checkbox" name="checkAll" id="checkAll">
	                                   </th>
	                                   <th style="padding-left:2px;">??????</th>
	                                   <th style="padding-left:2px;">??????</th>
	                                   <th style="padding-left:2px;">??????</th>
	                                   <th style="padding-left:2px;">??????ID</th>
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
	                  <%-- ??????????????? ???--%>
	                  
	                  </div>
	                  
	                  <%-- ?????? ??????--%>
	                  <div class="addArea">
	                     <div>
	                        <div class="move_wrap">
	                           <ul class="addListGroup" style="padding-left: 10px;">
	                              <li class="addList">
	                                 <span class="btn_bg addMidApprover" style="display: inline-block; margin: 50px 0; width: 80px; font-size: 10pt; text-align: center;">
	                                    ???????????????
	                                 </span>
	                              </li>
	                              <li class="addList">
	                                 <span class="btn_bg addFinApprover" style="display: inline-block; margin: 50px 0; width: 80px; font-size: 10pt; text-align: center;">
	                                    ???????????????
	                                 </span>            
	                              </li>                     
	                           </ul>
	                        </div>
	                     </div>
	                  </div>   
	                  <%-- ?????? ???--%>
	                  
	                  <%-- ????????? ??????--%>  
	                  <div id="approvers" style="width: 300px; padding: 30px 0 ;display: flex; flex-direction: column; flex: auto;">
	                  
		                  <div class="approver_wrap" style="margin-left: 15px; display: inline-block; flex:auto;">
		                      <div id="midApprover" class="approver_list">
		                          <span class="title">?????? ?????????</span>
		                          <ul id="midApprListGroup">
		                              <!-- ???????????? li ?????? ????????? ?????? -->
		                              <li class="midApprLists" value="1"></li>
		                              <li class="midApprLists"></li>
		                              <li class="midApprLists"></li>
		                              <li class="midApprLists"></li>
		                          </ul>
		                      </div>
		                  </div>
		                  <%-- ?????? ?????? ???--%>                
		               
		                <%-- ?????? ?????? ??????--%>  
		                  <div class="approver_wrap" style="margin-left: 15px; display: inline-block;">
		                      <div id="finApprover" class="approver_list">
		                          <span class="title">?????? ?????????</span><span style="color: red">*</span>
		                          <ul id="finApprListGroup">
		                              <!-- ???????????? li ?????? ????????? ?????? -->
		                              <li class="finApprLists" value="1"></li>
		                              <li class="finApprLists"></li>
		                              <li class="finApprLists"></li>
		                              <li class="finApprLists"></li>
		                          </ul>
		                      </div>
		                  </div>
	                  </div>
	                  <%-- ????????? ???--%>          
	               
	            </div>
	            
	         
	            
	            </div>
	            </div>
	         </div>               
	      <%-- findEmpList.jsp --%>               
	       </div>
	     </div>
	     <%-- modal-body ??? --%>
	     <div class="modal-footer">
	        <button type="button" class="btn btn-info" style="border-radius: 3px;"
	                onclick="findEmpOk()">??????</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="border-radius: 3px;" onclick="
	            window.location.reload()">??????</button>
	      </div>
	   </div>
	
	 </div>
	</div>
