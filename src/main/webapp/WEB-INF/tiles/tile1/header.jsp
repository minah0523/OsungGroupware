<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<!-- 조직도 -->
<link rel="stylesheet" href="<%= ctxPath%>/resources/jstree/dist/themes/default/style.min.css" />

<style type="text/css">
li.navbar-liStyle {
   margin: 0 10px;
}

img.emp_photo_thumbnail {
   width: 32px;
   height: 32px;
   border-radius: 50%;
}

ul.dropdown-menu {
   border-radius: 5px;
}

#side-menu2 > li > a {
    padding: 15px 30px 15px 15px;
}

#side-menu2 li a {
    color: #c8d1d6;
    border-left: 0 solid #516673;
}

#side-menu2 > li > a:hover, #side-menu2 > li > a:focus {
    background: rgba(0,0,0,0.07);
}

aside {
    display: block;
}

article, aside, figure, footer, header, hgroup, nav, section {
    display: block;
}

aside.go_organogram {
   z-index: 90;
    position: fixed;
    left: 230px;
    bottom: 10px;
    width: 250px;
    padding: 10px 0px;
    background: #434343 url(<%= ctxPath%>/resources/images/bg_darkgray.png?v2.6.0.0) no-repeat -50px 0;
}

aside.go_organogram {
    z-index: 60;
}

.go_skin_advanced aside.go_organogram {
    bottom: 16px;
    background: #fff;
    border-radius: 4px;
    box-shadow: 0 0 16px 0 rgba(0,0,0,0.4);
    padding: 0;
    left: 64px;
    position: fixed;
}

body.go_skin_home_w.go_skin_advanced .go_footer {
    display: none;
}
</style>



<%-- 지은 추가한 부분 시작--%>
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>   

<script type="text/javascript">

   $(document).ready(function(){
      
      // 조직도 숨기기
      $("aside.go_organogram").css("display","none");
      
   });// end of $(document).ready(function(){})--------------------
   
   
   function goTrashClear() {
      // 휴지통 비우기 기능
      
      location.href = "<%= ctxPath%>/groupware/jieun/note/trashClear.os";
   }
   
   
   // 조직도
   function lookOrganizationChart() {
      $(".go_skin_home_w.go_skin_advanced").css("display","block");
      $(".go_footer").css("display","block");
      $("aside.go_organogram").css("display","block");
   }
   
   // 조직도 닫기
   function closeOrganizationChart() {
      $(".go_skin_home_w.go_skin_advanced").css("display","none");
      $(".go_footer").css("display","none");
      $("aside.go_organogram").css("display","none");
   }

</script>   
<%-- 지은 추가한 부분 끝--%>

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top m-b-0">
            <div class="navbar-header"> 
               <a class="navbar-toggle hidden-sm hidden-md hidden-lg " href="javascript:void(0)" data-toggle="collapse" data-target=".navbar-collapse">
                  <i class="fa fa-bars"></i>
               </a>
                <div class="top-left-part" style="text-align: center; height: 60px; padding: 7px">
                   <a class="logo" href="<%= ctxPath%>/login.os" >
                      <img src="<%= ctxPath%>/resources/images/osunglogo3.png" width="145px" alt="home" />
                   </a>   
                </div>
                <!-- <ul class="nav navbar-top-links navbar-left m-l-20 hidden-xs">
                   <li class="navbar-liStyle">
                      <i class="fa fa-navicon fa-2x" style="margin: 17px auto;"></i>
                   </li>
                    <li class="navbar-liStyle">
                        <form role="search" class="app-search hidden-xs">
                            <input type="text" placeholder="Search..." class="form-control" /> 
                               <a href=""><i class="fa fa-search"></i></a>
                        </form>
                    </li>
                </ul> -->
                <ul class="nav navbar-top-links navbar-right pull-right">
                    <li class="dropdown">
                        <a class="profile-pic" href="#" data-toggle="dropdown"> 
                           <c:choose>
                        <c:when test="${not empty sessionScope.loginemp.photo_route}"><img src="<%= ctxPath%>/resources/images/${sessionScope.loginemp.photo_route}" class="emp_photo_thumbnail" title="${sessionScope.loginemp.emp_name}"></c:when>
                        <c:otherwise><img src="<%= ctxPath%>/resources/images/photo_profile_small.jpg" class="emp_photo_thumbnail" title="${sessionScope.loginemp.emp_name}"></c:otherwise>
                     </c:choose>
                        </a>
                        <ul class="dropdown-menu">
                     <li><a href="<%= ctxPath%>/profile.os">기본정보</a></li>
                     <li><a href="<%= ctxPath%>/logout.os">로그아웃</a></li>
                  </ul>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-header -->
            <!-- /.navbar-top-links -->
            <!-- /.navbar-static-side -->
        </nav>
        <!-- Left navbar-header -->
        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse slimscrollsidebar">
                <ul class="nav" id="side-menu">
                    <li style="padding: 10px 0 0;">
                        <a href="<%= ctxPath%>/login.os" class="waves-effect">
                           <i class="fa fa-home fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">홈</span>
                        </a>
                    </li>
                    <%-- 지은 header 추가 시작 --%>
                    <li>
                        <a href="blank.html" class="waves-effect" id="note">
                           <i class="fa fa-envelope-o fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">쪽지</span>
                           <span class="fa arrow"></span>
                        </a>                     
                        <ul class="nav nav-third-level">
                        <li><a href="/groupware/jieun/note/write.os">쪽지쓰기</a></li>
                        <li><a href="/groupware/jieun/note/sendList.os">보낸쪽지함</a></li>
                        <li><a href="/groupware/jieun/note/receiveList.os">받은쪽지함</a></li>
                        <li><a href="/groupware/jieun/note/importantList.os">중요쪽지함</a></li>
                        <li><a href="/groupware/jieun/note/tempList.os">임시보관함</a></li>
                        <li><a href="/groupware/jieun/note/reservationList.os">예약쪽지함</a></li>
                        <li>
                           <a style="width: 130px; display:inline-block; " href="/groupware/jieun/note/trash.os">휴지통
                           </a>
                           <button type="button" onclick="goTrashClear();" style="width: 0px; display:inline-block; background-color: #516673; border: 0; margin-left: 40px; color:#ffffff;" data-toggle="tooltip" data-placement="top" title="비우기">
                              <i class= "fa fa-trash-o fa-fw" aria-hidden="true"></i>
                           </button>
                        </li>
                        </ul>
                    </li>
                    <%-- 지은 header 추가 끝 --%>
                    <%-- 김민아 시작 --%>
                    <li>
                        <a href="/groupware/elecapproval/main.os" class="waves-effect" id="elecapproval">
                           <i class="fa fa-book fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">전자결재</span>
                           <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-third-level">
                           <li><a href="/groupware/elecapproval/main.os">전자결재홈</a></li>
                           <li><a href="/groupware/elecapproval/write.os">새결재진행</a></li>
                           <li><a href="/groupware/elecapproval/waiting.os">결재대기중</a></li>
                           <li><a href="/groupware/elecapproval/processing.os">진행중문서</a></li>
                           <li><a href="/groupware/elecapproval/finished.os">완료문서</a></li>
                        </ul>                  
                    </li> 
                    <li>
                        <a href="/groupware/attendance/main.os" class="waves-effect" id="attendance">
                           <i class="fa fa-plane fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">근태관리</span>
                           <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-third-level">
                           <li><a href="/groupware/attendance/main.os">근태관리홈</a></li>
                           <li><a href="/groupware/attendance/write.os">연차신청하기</a></li>
                           <li><a href="/groupware/attendance/waiting.os">승인대기중</a></li>
                           <li><a href="/groupware/attendance/processing.os">진행중문서</a></li>
                           <li><a href="/groupware/attendance/finished.os">완료문서</a></li>
                           <li><a href="/groupware/attendance/worktime.os">출퇴근현황</a></li>
                        </ul>                  
                    </li> 
                    <%-- 김민아 끝 --%>
                    <%-- 수빈 header 시작 --%>
                    <li>
                        <a href="<%= request.getContextPath() %>/goTodo.os" class="waves-effect">
                           <i class="fa fa-edit fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">ToDo+</span>
                        </a>
                    </li>
                    <li>
                        <a href="blank.html" class="waves-effect">
                           <i class="fa fa-calendar fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">일정</span>
                           <span class="fa arrow"></span>
                        </a>                     
                        <ul class="nav nav-third-level">
                           <li><a href="<%= request.getContextPath() %>/goCalendar.os">캘린더</a></li>
                           <li><a href="<%= request.getContextPath() %>/editCal.os">내 캘린더 관리</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="blank.html" class="waves-effect">
                           <i class="fa fa-clock-o fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">예약</span>
                           <span class="fa arrow"></span>
                        </a>                     
                        <ul class="nav nav-third-level">
                           <li><a href="<%= request.getContextPath() %>/goRsv.os">예약하기</a></li>
                           <li><a href="<%= request.getContextPath() %>/goMyRsvList.os">나의 예약 목록</a></li>
                        </ul>
                    </li>
                    <%-- 수빈 header 끝 --%>
                    <%-- 호연 header 추가 시작 --%>
                    <li>
                        <a href="map-google.html" class="waves-effect">
                           <i class="fa fa-list fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">게시글</span>
                           <span class="fa arrow"></span>
                        </a>
                         <ul class="nav nav-third-level">
                        <li><a href="/groupware/noticeList.os">공지게시판</a></li>
                        
                        <li>
                        <a href="map-google.html" class="waves-effect"> <i aria-hidden="true"></i>
                        <span id="boardList" class="hide-menu">일반 게시판</span>
                        <span class="fa arrow"></span>
                        </a>

                         <ul class="nav nav-third-level">
                         <li><a href="/groupware/boardList.os?fk_dept_no=1">전략기획</a></li>
                         <li><a href="/groupware/boardList.os?fk_dept_no=2">경영지원</a></li>
                         <li><a href="/groupware/boardList.os?fk_dept_no=3">인사</a></li>
                         <li><a href="/groupware/boardList.os?fk_dept_no=4">회계</a></li>
                         <li><a href="/groupware/boardList.os?fk_dept_no=5">영업</a></li>
                         <li><a href="/groupware/boardList.os?fk_dept_no=6">마케팅</a></li>
                         <li><a href="/groupware/boardList.os?fk_dept_no=7">IT</a></li>   
                 
                       </ul>
                        </li>
                   
                        <li><a href="/groupware/fileBoardList.os">자료실</a></li>
            
                        </ul>
                    </li>
                     <%-- 호연 header 추가 시작 끝--%>
                     <%-- 용진 header 추가 시작 --%>
                    <li>
                       <a href="blank.html" class="waves-effect">
                           <i class="fa fa-users fa-fw" aria-hidden="true"></i>
                           <span class="hide-menu">주소록</span>
                           <span class="fa arrow"></span>
                        </a>                     
                        <ul class="nav nav-third-level">
                        <li><a href="<%= ctxPath%>/employee/addressbook.os">전사 주소록</a></li>
                        <li><a href="<%= ctxPath%>/employee/idv_addressbook.os">개인 주소록</a></li>
                        </ul>
                    </li>
                    <%-- 용진 header 추가 끝 --%>
                </ul>
                <div>
                    <ul class="nav" id="side-menu2">
                  <li id="organization">
                     <a class="waves-effect" onclick="lookOrganizationChart();">
                          <i class="fa fa-sitemap fa-fw" aria-hidden="true"></i>
                          <span class="hide-menu">조직도</span>
                     </a>
                  </li>
               </ul>
                </div>
            </div>
        </div>
        
        <!-- 조직도 -->
        <aside class="go_organogram" id="organogram" style="height: 438px; display: block; width: 250px; overflow: auto;">
           <!-- <h1>
              <ins class="ic"></ins>
              <span class="txt">조직도</span>
              <span class="btn_wrap" id="orgToggleWrap">
                 <span id="orgToggle" class="ic_gnb ic_show_down2" data-slide="true" title="닫기"></span>
              </span>
           </h1> -->
           <div class="search_wrap" style="text-align: right;">
              <form name="orgSearch" onsubmit="return false;">
                 <!-- <input class="search" type="text" placeholder="이름/아이디/부서/직위/직책/전화" title="이름/아이디/부서/직위/직책/전화" style="margin-left: 10px;" /> -->
                 <!-- <input class="btn_search" type="submit" value="검색" title="검색" /> -->
              </form>
              <i class="fa fa-times" style="color: white; padding-right: 10px;" onclick="closeOrganizationChart();"></i>
           </div>
           <hr style="color: white;">
           <div class="tab_wrap">
              <div id="tabOrgTree" class="content_tab_wrap" style="height:400px">
                 <!-- <div id="orgSideTree" class="jstree jstree-0 jstree-focused jstree-default jstree_depth" style="min-height: 375px; max-height: 375px;">
                    <ul style="list-style: none; padding: 10px 0;">
                       <li rel="company" nodeid="10" id="company_10" class="jstree-open jstree-last jstree-company depth0">
                          <ins class="jstree-icon">&nbsp;</ins>
                          <a title="" rel="company" nodeid="10" id="company_10" href="#" data-bypass="1" style="color: white;">
                             <ins class="jstree-icon company"></ins>
                             (주)오성
                          </a>
                          <ul>
                             <li title="구정모 사장" rel="MEMBER" nodeid="260" id="MEMBER_260" class="jstree-leaf">
                                <ins class="jstree-icon">&nbsp;</ins>
                                <a title="" rel="MEMBER" nodeid="260" id="MEMBER_260" href="#" data-bypass="1" class="" style="color: white;">
                                   <ins class="jstree-icon worker"></ins>
                                   ├구정모 사장
                                </a>
                             </li>
                             <li title="이재오 전무" rel="MEMBER" nodeid="481" id="MEMBER_481" class="jstree-leaf">
                                <ins class="jstree-icon">&nbsp;</ins>
                                <a title="" rel="MEMBER" nodeid="481" id="MEMBER_481" href="#" data-bypass="1" class="">
                                   <ins class="jstree-icon worker"></ins>
                                   이재오 전무
                                </a>
                             </li>
                             <li title="영업본부" rel="org" nodeid="123" id="org_123" class="jstree-open">
                                <ins class="jstree-icon">&nbsp;</ins>
                                <a title="" rel="org" nodeid="123" id="org_123" href="#" data-bypass="1">
                                   <ins class="jstree-icon">&nbsp;</ins>
                                   영업본부
                                </a>
                                <ul>
                                   <li title="김상후 대표이사" rel="MASTER" nodeid="503" id="MASTER_503" class="jstree-leaf">
                                      <ins class="jstree-icon">&nbsp;</ins>
                                      <a title="" rel="MASTER" nodeid="503" id="MASTER_503" href="#" data-bypass="1" class="">
                                         <ins class="jstree-icon worker"></ins>
                                         김상후 대표이사
                                      </a>
                                   </li>
                                   <li title="허각 이사" rel="MEMBER" nodeid="181" id="MEMBER_181" class="jstree-leaf">
                                      <ins class="jstree-icon">&nbsp;</ins>
                                      <a title="" rel="MEMBER" nodeid="181" id="MEMBER_181" href="#" data-bypass="1">
                                         <ins class="jstree-icon worker"></ins>
                                         허각 이사
                                      </a>
                                   </li>
                                   <li title="김다우 과장" rel="MEMBER" nodeid="454" id="MEMBER_454" class="jstree-leaf">
                                      <ins class="jstree-icon">&nbsp;</ins>
                                      <a title="" rel="MEMBER" nodeid="454" id="MEMBER_454" href="#" data-bypass="1">
                                         <ins class="jstree-icon worker"></ins>
                                         김다우 과장
                                      </a>
                                   </li>
                                   <li title="고단비 대리" rel="MEMBER" nodeid="471" id="MEMBER_471" class="jstree-leaf">
                                      <ins class="jstree-icon">&nbsp;</ins>
                                      <a title="" rel="MEMBER" nodeid="471" id="MEMBER_471" href="#" data-bypass="1">
                                         <ins class="jstree-icon worker"></ins>
                                         고단비 대리
                                      </a>
                                   </li>
                                   <li title="김지연 부장" rel="MEMBER" nodeid="505" id="MEMBER_505" class="jstree-leaf">
                                      <ins class="jstree-icon">&nbsp;</ins>
                                      <a title="" rel="MEMBER" nodeid="505" id="MEMBER_505" href="#" data-bypass="1">
                                         <ins class="jstree-icon worker"></ins>
                                         김지연 부장
                                      </a>
                                   </li>
                                   <li title="apple-tester " rel="MEMBER" nodeid="490" id="MEMBER_490" class="jstree-leaf">
                                      <ins class="jstree-icon">&nbsp;</ins>
                                      <a title="" rel="MEMBER" nodeid="490" id="MEMBER_490" href="#" data-bypass="1">
                                         <ins class="jstree-icon worker"></ins>
                                         apple-tester 
                                      </a>
                                   </li>
                                   <li title="영업팀" rel="org" nodeid="130" id="org_130" class="jstree-closed">
                                      <ins class="jstree-icon">&nbsp;</ins>
                                      <a title="" rel="org" nodeid="130" id="org_130" href="#" data-bypass="1">
                                         <ins class="jstree-icon">&nbsp;</ins>
                                         영업팀
                                      </a>
                                   </li>
                                   <li title="마케팅팀" rel="org" nodeid="131" id="org_131" class="jstree-closed jstree-last">
                                      <ins class="jstree-icon">&nbsp;</ins>
                                      <a title="" rel="org" nodeid="131" id="org_131" href="#" data-bypass="1">
                                         <ins class="jstree-icon">&nbsp;</ins>
                                         마케팅팀
                                      </a>
                                   </li>
                                </ul>
                             </li>
                             <li title="경영지원본부" rel="org" nodeid="124" id="org_124" class="jstree-closed">
                                <ins class="jstree-icon">&nbsp;</ins>
                                <a title="" rel="org" nodeid="124" id="org_124" href="#" data-bypass="1">
                                   <ins class="jstree-icon">&nbsp;</ins>
                                   경영지원본부
                                </a>
                             </li>
                             <li title="개발본부" rel="org" nodeid="178" id="org_178" class="jstree-closed">
                                <ins class="jstree-icon">&nbsp;</ins>
                                <a title="" rel="org" nodeid="178" id="org_178" href="#" data-bypass="1" class="">
                                   <ins class="jstree-icon">&nbsp;</ins>
                                   개발본부
                                </a>
                             </li>
                             <li title="서비스본부" rel="org" nodeid="182" id="org_182" class="jstree-closed">
                                <ins class="jstree-icon">&nbsp;</ins>
                                <a title="" rel="org" nodeid="182" id="org_182" href="#" data-bypass="1">
                                   <ins class="jstree-icon">&nbsp;</ins>
                                   서비스본부
                                </a>
                             </li>
                             <li title="미래본부" rel="org" nodeid="221" id="org_221" class="jstree-closed jstree-last">
                                <ins class="jstree-icon">&nbsp;</ins>
                                <a title="" rel="org" nodeid="221" id="org_221" href="#" data-bypass="1">
                                   <ins class="jstree-icon">&nbsp;</ins>
                                   미래본부
                                </a>
                             </li>
                          </ul>
                       </li>
                    </ul>
                 </div> -->
                 
                 <!-- 3 setup a container element -->
               <div id="html1">
                    <ul>
                        <li>(주)오성
                            <ul>
                               <c:forEach var="empvo" items="${empList}">
                                  <c:if test="${empvo.position_name == '사장'}">
                                     <li>${empvo.emp_name}&nbsp;${empvo.position_name}</li>
                                  </c:if>
                                  
                                  <c:if test="${empvo.position_name == '이사'}">
                                     <li>${empvo.emp_name}&nbsp;${empvo.position_name}</li>
                                  </c:if>
                               </c:forEach>
                               
                               <c:forEach var="dept_name" items="${deptList}">
                                  <li>
                                     ${dept_name}
                                     <ul>
                                        <c:forEach var="empvo" items="${empList}">
                                           <c:if test="${dept_name == empvo.dept_name}">
                                              <li>${empvo.emp_name}&nbsp;${empvo.position_name}</li>
                                           </c:if>
                                        </c:forEach>
                                     </ul>
                                  </li>
                               </c:forEach>
                            </ul>
                        </li>
                    </ul>
                </div>
              </div>
              <div id="tabOrgMembers" class="content_tab_wrap" style="display:none;height:400px"></div>
           </div>
        </aside>
        
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="<%= ctxPath%>/resources/jstree/dist/jstree.min.js"></script>
<script>
$('#html1').jstree({
   'plugins': ["wholerow","types"],
        
    'themes' : {            
        'responsive' : true
    },
    "types" : {
        "default": {
            "icon" :"/images/OrganTree_cross/fldr.gif"
        }
    }
});
<%-- 
$(document).ready(function(){
   // 조직도 불러오기
   $.ajax({
      url:"<%= ctxPath%>/getOrganization.os",
      dataType:"JSON",
      success:function(data){
         
           /* if(json.length > 0) {
              var data = new Array();
               $.each(data, function(idx, item){
                   data[idx] = {id:item.id, parent:item.text, type:item.type, data:{a:item.a, b:item.b, ...}}; 
               });
        
               $("#tree").jstree({
                   core: {
                       data: data    //데이터 연결
                   },
                   types: {
                       'default': {
                           'icon': 'jstree-folder'
                       }
                   },
                   plugins: ['wholerow', 'types']
               })
               .bind('loaded.jstree', function(event, data){
                   //트리 로딩 롼료 이벤트
               })
               .bind('select_node.jstree', function(event, data){
                   //노드 선택 이벤트
               })
          } */
           
      },
      error:function(request, status, error){
         alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
      }
   });
}); --%>
</script>