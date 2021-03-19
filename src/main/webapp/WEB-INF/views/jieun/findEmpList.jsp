<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<style type="text/css">
  
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
   span.addGroup {
   		
   }
   span.addUser {
   		
   }
   .addArea {
   		margin-top: 130px;
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
</style>

<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>
<script type="text/javascript">
  $(document).ready(function () {
		
	    // 
		$(".tab_nav li").click(function(event){
			
			alert($(this).attr('value'));
			
			$(this).addClass("ul_state_active");
			$(".tab_nav li").not($(this)).removeClass("ul_state_active");
			
			
		});
		
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
		  		
		
  });
  
  

  
</script>

<div class="empList_Popup" style="overflow-x:hidden;">
	 
	<div class="content">
	
		<div class="content_layout_address" style="margin-left : 60px;">
			<div id="tabArea" style="margin-left : -40px;">
				<ul class="tab_nav nav_layer" style="margin-bottom: 22px;">
					<li value="user">
						<a>개인 주소록</a>
					</li>
					<li value="company">
						<a>공용 주소록</a>
					</li>
					<li value="org">
						<a>조직도</a>
					</li>
				</ul>
			</div>
			
			<div class="tabWrap father" style="margin-left : -1px;"> <!-- border: solid 5px yellow;"> -->
				<div class="father" style=" border : solid 1px #999;">
				<%-- 조직도 시작--%>
				<div class="container" style="padding-top:10px; width: 200px; border-right: solid 1px #999; "> <!-- border: solid 2px navy; "> -->
				    <div class="row box" style="width: 200px;"> <!-- border: solid 2px pink;"> -->
				        <div class="col-md-4">
				            <ul id="tree1">
				                <li>
				                	<a href="#">오성그룹</a>			
				                    <ul>
				                        <li>전략기획팀</li>
				                        <li>경영지원팀
				                            <ul>
				                                <li>Reports
				                                    <ul>
				                                        <li>Report1</li>
				                                        <li>Report2</li>
				                                        <li>Report3</li>
				                                    </ul>
				                                </li>
				                                <li>Employee Maint.</li>
				                            </ul>
				                        </li>
				                        <li>인사팀</li>
				                        <li>회계팀</li>
				                        <li>영업팀</li>
				                        <li>마케팅팀</li>
				                        <li>IT팀</li>
				                        
				                    </ul>
				                </li>
				            </ul>
				        </div>
				</div>
			</div>
			<%-- 조직도 끝--%>
			
			<%-- 사원리스트 시작--%>
			<div class="content_list box" style="">
				<div class="search_wrap">
					<form class="emp_search">
						<input id="searchWord" class="search" type="text" placeholder="이름,부서">
				 		<button type="button" class="btn btn-primary btnSearch" style="background-color: #00a1b9; border: solid 1px #00a1b9; border-radius: 3px; color: white;">검색</button>	
					</form>   
				</div>
				<div class="scroll_wrap">
					<table class="table">
						<thead style="padding:0;">
							<tr style="text-align: left; background: #efefef; font-weight: normal;">
						        <th style="padding:0;">
						        	<input type="checkbox">
						        </th>
						        <th style="padding:0;">이름</th>
						        <th style="padding:0;">직위</th>
						        <th style="padding:0;">부서</th>
						        <th style="padding:0;">사원ID</th>
						    </tr>
						</thead>
	
						<tbody>
						   <c:forEach begin="0" end="10" varStatus="loop">
		                        <tr>
		                            <td style="width: 40px;"> 
		                            	<input type="checkbox" class="check${loop.index}">
		                            </td>
		                            <td style="width: 80px;" class="name">
		                            	bts
		                            </td>
		                            <td style="width: 50px;" class="postion">
		                            	사원	
		                            </td>
		                            <td style="width: 80px;" class="dept">
		                            	IT
		                            </td>
		                            <td style="width: 120px;" class="userid">
		                            	20121204
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
							<li class="addList">
								<span class="btn_bg addGroup" style="display: inline-block; margin-bottom: 10px; width: 50px; font-size: 10pt;">
									그룹
								</span>
							</li>
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
			        <ul>
			            <!-- 비어있는 li 네개 지우면 안됨 -->
			            <li></li>
			            <li></li>
			            <li></li>
			            <li></li>
			        </ul>
			    </div>
			</div>
			<%-- 받는 사람 끝--%> 					
		
	</div>
	

	
	</div>
	</div>
</div>


