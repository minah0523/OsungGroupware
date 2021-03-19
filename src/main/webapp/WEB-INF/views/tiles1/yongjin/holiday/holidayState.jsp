<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<header>
		<div>
			<h1>
				<span>전사 연차현황</span>
			</h1>
		</div>
	</header>

    <div>
    	<!-- tool bar -->
	    <div>
	        <div>
	            <span title="" id="prevMonth"><span id="preDate"></span></span>
	            <span class="date" id="baseDate">2020.12.09</span>
	            <span title="" id="nextMonth"><span id="nextDate"></span></span>
	            <input type="text" id="baseDatePicker" style="border:0px; width:1px; height:0px" class="hasDatepicker">
	        </div>
	    </div>
    	<!-- //tool bar -->
	    <form>
	        <fieldset>
	            <div>
	                <div>조건별 상세검색</div>
	                <div>
	                    <div>
	                        <span>
	                            <label for="">입사일</label>
	                        </span>
	                        <!-- 날짜 선택 박스 -->
	                        <span>
	                            <span id="startHireDateCal">
	                                <input type="text" id="startHireDate" readonly="readonly">
	                                <span>
	                                    <input type="text" id="startHireDatePicker" style="border:0px; width:1px; height:1px" class="hasDatepicker">
	                                </span>
	                            </span>
	                            <span>~</span>
	                            <span id="endHireDateCal">
	                                <input class="hasDatepicker" id="endHireDate" type="text" readonly="readonly">
	                                <span>
	                                    <input type="text" id="endHireDatePicker" style="border:0px; width:1px; height:1px" class="hasDatepicker">
	                                </span>
	                            </span>
	                        </span>
	                    </div>
	                    <div>
	                        <span>
	                            <label for="">이름</label>
	                        </span>
	                        <span>
	                            <input type="text" id="userName" value="">
	                        </span>
	                    </div>
	                    <div>
	                        <span>
	                            <label for="">부서명</label>
	                        </span>
	                        <span>
	                            <input type="text" id="deptName" value="">
	                        </span>
	                    </div>
	                    <div>
	                        <span>
	                            <label for="">상태</label>
	                        </span>
	                        <span id="">
	                            <select name="" id="status">
	                                <option value="" selected="">전체</option>
	                                <option value="online">정상</option>
	                                <option value="dormant">메일휴면</option>
	                                <option value="stop">중지</option>
	                            </select>
	                        </span>
	                    </div>
	                    <div>
	                        <a id="searchBtn"><span>검색</span></a>
	                        <a id="resetSearchBtn"><span>검색 조건 초기화</span></a>
	                        <!-- 초기화 버튼은 검색값이 있을 경우만 노출 : 멀티 클래스명 active 추가. 초기화 시 active 클래스명 제거 -->
	                    </div>
	                </div>
	            </div>
			</fieldset>
	    </form>

    	<div>
        	<div id="middle_tool_bar">
        		<div>
        			<a id="showUploadPopup"><span></span><span>연차 초기 설정</span></a>
        			<div>    <span></span>    <span id="vacation_description_icon">        <span title="">            <span id="vacation_description" style="display:none;">                <i class="ic ic_tail"></i>                <div><p><span></span> 연차 현황을 위한 꿀팁 가이드</p><ol><li>상단 <span>[연차 초기설정]</span>을 통해 사용자에 따른 입사일자, 발생 연차, 사용 연차를 csv 파일로 먼저 설정해주시기 바랍니다.</li><li><span>전사 연차 현황 설정 → 휴가 부여 기준에서 [연차 시작하기]</span>를 클릭해야 자동으로 연차가 생성됩니다.</li><li>입사일자 미 입력 시, 연차는 자동생성 되지 않습니다. </li><li>그 외 이월연차 및 조정연차는 <span>[연차 조정]</span> 기능을 통해 처리해주시기 바랍니다. </li></ol><p>더 자세한 내용은 <span>도움말</span>을 이용해주시기 바랍니다.</p>                </div>            </span>        </span>    </span></div>
        		</div>
        		<div>
        			<div id="vacationManage">    <a><span></span><span>연차 조정</span></a><span id="mangeSubMenu"><span></span></span>    <div id="submenu" style="display: none;">        <ul id="toolbar_delete">            <li><span>연차 조정</span></li>            <li><span>연차 일괄 조정</span></li>        </ul>    </div></div><a id="downloadList"><span></span><span>목록 다운로드</span></a>
					<form id="download_vacation_form" method="POST" target="ifm_download_vacation_form" style="display: none;"></form>
					<iframe name="ifm_download_vacation_form" id="ifm_download_vacation_form" style="border:0px; width:0px; height:0px;"></iframe>
					<div id="vacation_list_length">
						<label> 
							<select size="1" name="vacation_list_length">
								<option value="20" selected="selected">20</option>
								<option value="40">40</option>
								<option value="60">60</option>
								<option value="80">80</option>
							</select> 
						</label>
					</div>
				</div>
			</div>
	        <div>
	            <div id="vacation_list_wrapper">
	            	<div style="display:none">
	            		<div></div>
	            	</div>
	            	<div id="vacation_list_processing" style="visibility: hidden;">Loading...</div>
	            	<table id="vacation_list" style="width: 100%; margin-bottom: 0px;">
		                <thead>
		                	<tr role="row">
		                		<th role="columnheader" rowspan="1" colspan="1" style="width: 35px;">
		                        	<span><input id="ehr_checkbox1" type="checkbox" name="" placeholder=""><label for="ehr_checkbox1"><div></div></label></span>
		                        </th>
		                        <th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                        	<span>이름 <ins class="ic"></ins><span></span></span>
		                        </th>
		                        <th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                       		<span>부서명<ins class="ic"></ins></span>
		                       	</th>
		                       	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                       		<span>입사일<ins class="ic"></ins></span>
		                       	</th>
		                       	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                       		<span>퇴사일<ins class="ic"></ins></span>
		                       	</th>
		                       	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                       		<span>근속연수<ins class="ic"></ins></span>
		                       	</th>
		                       	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                       		<span>발생 연차<ins class="ic"></ins></span>
		                       	</th>
		                       	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                        	<span>발생 월차<span class="help"><span>1년 미만 발생 월차<i class="tail_left"></i></span></span><ins class="ic"></ins></span>
		                    	</th>
		                    	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                        	<span>이월 월차<span class="help"><span>1년 미만 이월 월차<i class="tail_left"></i></span></span><ins class="ic"></ins></span>
		                    	</th>
		                    	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    		<span>조정 연차<ins class="ic"></ins></span>
		                    	</th>
		                    	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    		<span>총 연차<ins class="ic"></ins></span>
		                    	</th>
		                    	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    		<span>사용 연차<ins class="ic"></ins></span>
		                    	</th>
		                    	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    		<span>잔여 연차<ins class="ic"></ins></span>
		                    	</th>
		                    	<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    		<span>상태<ins class="ic"></ins></span>
		                    	</th>
		                    </tr>
		                </thead>
	                
	            		<tbody>
	            			<tr>
	            				<td><input name="userId" type="checkbox" value="270"></td>
	            				<td><a>juyeon12 차장</a></td>
	            				<td>마케팅팀</td>
	            				<td>-</td>
	            				<td>-</td>
	            				<td>0</td>
	            				<td>0</td>
	            				<td>0</td>
	            				<td>0</td>
	            				<td>0</td>
	            				<td>0</td>
	            				<td>0</td>
	            				<td>0</td>
	            				<td>정상</td>
	            			</tr>
	            		</tbody>
	            	</table>
	            	<div>
	            		<div></div>
	            		<div>
	            			<label> 
	            				<select size="1" name="vacation_list_length">
	            					<option value="20" selected="selected">20</option>
	            					<option value="40">40</option>
	            					<option value="60">60</option>
	            					<option value="80">80</option>
	            				</select> 
	            			</label>
	            		</div>
	            		<div id="vacation_list_paginate">
	            			<a title="맨앞" id="vacation_list_first"></a>
	            			<a title="이전" id="vacation_list_previous"></a>
	            			<span>
	            				<a>1</a>
	            				<a>2</a>
	            				<a>3</a>
	            				<a>4</a>
	            			</span>
	            			<a title="다음" id="vacation_list_next"></a>
	            			<a title="맨뒤" id="vacation_list_last"></a>
	            		</div>
	            	</div>
	            </div>
	        </div>
    	</div>

	    <div>
	        <p>
	            <span></span> 연차 현황을 위한 꿀팁 가이드
	        </p>
	        <ul>
	            <li>1. 상단 [연차 초기설정]을 통해 사용자에 따른 입사일자, 발생 연차, 사용 연차를 csv 파일로 먼저 설정해주시기 바랍니다.</li>
	            <li>2. 전사 연차 현황 설정 → 휴가 부여 기준에서 [연차 시작하기]를 클릭해야 자동으로 연차가 생성됩니다.</li>
	            <li>3. 입사일자 미 입력 시, 연차는 자동생성 되지 않습니다.</li>
	            <li>4. 그 외 이월연차 및 조정연차는 [연차 일괄 조정] 기능을 통해 처리해주시기 바랍니다.</li>
	            <li>&nbsp;&nbsp;* 더 자세한 내용은 도움말을 이용해주시기 바랍니다.</li>
	        </ul>
	    </div>
	</div>
</div>