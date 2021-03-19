<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="annual_personal">
	<header class="content_top">
		<div>
			<h1>
				<span>연차 내역 (apple-tester)</span>
			</h1>
		</div>
	</header>
	
	<div class="content_page">
    	<div>
	        <div class="current_date">
	            <span class="date" id="baseDate">2020.12.09</span>
	        </div>
    	</div>
    	<!-- tool bar -->
    	<!-- ehr statistics -->
	    <div class="wrap_statistics">
	        <div>
	            <div>
	                <span class="member">
	                    <a href="">
	                        <img alt="apple-tester " src="/resources/images/photo_profile_large.jpg">
	                    </a>
	                    <a href="">
	                        <span>apple-tester</span>
	                    </a>
	                </span>
	            </div>
	            <span></span>
	            <div>
	                <p>발생 연차</p>
	                <p>0</p>
	            </div>
	            <span></span>
	            <div>
	                <p>발생 월차
	                    <span class="help">
	                        <span>1년 미만 발생 월차<i class="tail_left"></i></span>
	                    </span>
	                </p>
	                <p>0</p>
	            </div>
	            <span></span>
	            <div>
	                <p>이월 월차
	                    <span class="help">
	                        <span>1년 미만 이월 월차<i class="tail_left"></i></span>
	                    </span>
	                </p>
	                <p>0</p>
	            </div>
	            <span></span>
	            <div>
	                <p>조정 연차</p>
	                <p>0</p>
	            </div>
	            <span></span>
	            <div>
	                <p>총 연차</p>
	                <p>0</p>
	            </div>
	            <span></span>
	            <div>
	                <p>사용 연차</p>
	                <p>0</p>
	            </div>
	            <span></span>
	            <div>
	                <p>잔여 연차</p>
	                <p>0</p>
	            </div>
	        </div>
	    </div>
	    <!-- //ehr statistics -->
	    <!-- ehr datatable -->
	    <div class="wrap_tb_list">
	    	<div>
	            <div>
	                <ul>
	                    <li>
	                        <span>연차 사용기간 :</span>
	                        <select id="vacation_term_list">
	                        	<option value="2020-12-31">2020-11-18 ~ 2020-12-31</option>
	                        </select>
	                    </li>
	                </ul>
	            </div>
	        </div>
	
	        <div class="wrap_tb_box">
	            <h1>사용내역</h1>
	            <div class="wrap_tb_shadow">
	                <div id="vacation_histories_list_wrapper">
	                	<div id="vacation_histories_list_processing" style="visibility: hidden;">Loading...</div>
	                	
	                	<table id="vacation_histories_list" style="width: 100%; margin-bottom: 0px;">
		                    <thead>
		                    	<tr role="row">
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>이름<ins class="ic"></ins><span></span></span>
		                    		</th>
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>부서명<ins class="ic"></ins></span>
		                    		</th>
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>휴가종류<ins class="ic"></ins></span></th>
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>연차 사용기간<ins class="ic"></ins></span>
		                    		</th>
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>사용 연차<ins class="ic"></ins></span>
		                    		</th>
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>내용<ins class="ic"></ins></span>
		                    		</th>
		                    	</tr>
		                    </thead>
	                    
	                		<tbody>
	                			<tr>
	                				<td colspan="6">
	                					<p><span></span><span>목록이 없습니다.</span></p>
	                				</td>
	                			</tr>
	                		</tbody>
	                	</table>
	                </div>
	            </div>
	        </div>
	        
	        <div class="wrap_tb_box">
	            <h1>생성내역</h1>
	            <div class="wrap_tb_shadow">
	                <div id="vacation_issued_list_wrapper">
	                	<div id="vacation_issued_list_processing" style="visibility: hidden;">Loading...</div>
	                	
	                	<table id="vacation_issued_list" style="width: 100%; margin-bottom: 0px;">
		                    <thead>
		                    	<tr role="row">
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>등록일<ins class="ic"></ins><span></span></span>
		                    		</th>
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>사용 기간<ins class="ic"></ins></span>
		                    		</th>
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>발생일수<ins class="ic"></ins></span>
		                    		</th>
		                    		<th role="columnheader" rowspan="1" colspan="1" style="width: 0px;">
		                    			<span>내용<ins class="ic"></ins></span>
		                    		</th>
		                    	</tr>
		                    </thead>
	                    
	                		<tbody>
	                			<tr>
	                				<td>2020-11-18</td>
	                				<td>2020-12-31</td>
	                				<td>0</td>
	                				<td></td>
	                			</tr>
	                			<tr>
	                				<td>2020-11-18</td>
	                				<td>2021-12-30</td>
	                				<td>0</td>
	                				<td></td>
	                			</tr>
	                		</tbody>
	                	</table>
	                </div>
	                <!-- 연차관리 End //-->
	            </div>
	        </div>
	    </div>
	</div>
</div>