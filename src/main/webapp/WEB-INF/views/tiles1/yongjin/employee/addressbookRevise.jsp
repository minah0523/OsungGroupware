<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="content">
	<header>
		<h1>   
			<span>연락처 추가</span>	
		</h1>	
	</header>
		
	<div class="content_page">
		<form id="contactCreateId" name="formContactCreate">
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
								<span>
									<span style="text-align: center;">
										<span class="button text">
											<span class="buttonText">사진 올리기</span>
										</span>
										<input type="file" name="file" title="파일 첨부">
									</span>
									<div class="progress" style="display:none; margin-top:5px"></div>
								</span>
								<img src="/resources/images/photo_profile_large.jpg" alt="" id="thumbnail_image">
							</span>
							<span id="del_photo">삭제</span>
	                       	<div><span class="desc">※ 사진은 자동으로 150x150 사이즈로 적용 됩니다.</span></div>
						</td>
					</tr>
					<tr>
						<th><span>이름</span>
							<ins class="asterisk">*</ins>
						</th>
						<td>
							<span>
								<input name="name" value="" type="text">
							</span>
						</td>
					</tr>
					<tr>
						<th><span>회사</span>
						</th>
						<td><span><input name="companyName" type="text"></span></td>
					</tr>
					<tr>
						<th><span>부서</span>
						</th>
						<td><span><input name="departmentName" type="text"></span></td>
					</tr>
					<tr>
						<th><span>직위</span>
						</th>
						<td><span><input name="positionName" type="text"></span></td>
					</tr>
					<tr class="line">
						<th><span>그룹</span></th>
						<td>
							<ul id="groupNameTag" class="name_tag">
								<li id="groupCreate">
									<span><span></span><span>그룹추가</span></span>
								</li>
							</ul>																		
						</td>
					</tr>
					<tr>
						<th><span>이메일</span>
						</th>
						<td><span><input name="email" type="text"></span></td>
					</tr>
					<tr>
						<th>
	                        <span>휴대폰</span>
	                        <span class="help"><span class="tool_tip">해외 전화번호인 경우, 아래 4가지 방식으로 입력해 주세요. <br><br> (국가번호:82) (지역번호:02) (전화번호:123-4567) 인 경우, <br>  1. +8221234567<br> 2. +82021234567<br>  3. +82-2-123-4567<br> 4. +82-02-123-4567<br><br>※ 번호 앞에 '+' 는 반드시 붙여야 합니다.<i class="tail_left"></i></span></span>
						</th>
						<td><span><input name="mobileNo" type="text"></span></td>
					</tr>
					<tr>
						<th>
	                        <span>회사전화</span>
	                        <span class="help"><span class="tool_tip">해외 전화번호인 경우, 아래 4가지 방식으로 입력해 주세요. <br><br> (국가번호:82) (지역번호:02) (전화번호:123-4567) 인 경우, <br>  1. +8221234567<br> 2. +82021234567<br>  3. +82-2-123-4567<br> 4. +82-02-123-4567<br><br>※ 번호 앞에 '+' 는 반드시 붙여야 합니다.<i class="tail_left"></i></span></span>
						</th>
						<td><span><input name="company_tel" type="text"></span></td>
					</tr>
					<tr>
						<th><span>회사주소</span></th>
						<td>
							<span id="officeDetail">
								<input name="company_basicAddress" type="text" readonly="readonly">
								<input name="company_country" type="hidden">
								<input name="company_postalCode" type="hidden">
								<input name="company_state" type="hidden">
								<input name="company_city" type="hidden">
								<input name="company_extAddress" type="hidden">
								<span title="상세주소입력"></span>
							</span>
						</td>
					</tr>
					<tr>
						<th><span>메모</span></th>
						<td>
							<span>
								<textarea name="description"></textarea>									
							</span>
						</td>
					</tr>
					<!--  hidden  -->
					<tr style="display:none">
						<th>
							<span>애칭</span>
						</th>
						<td>
							<span><input name="nickName" type="text"></span>
						</td>
					</tr>
					<tr style="display:none">
						<th>
							<span>생일</span>
						</th>
						<td>
							<span>
								<input name="birthday" type="text" id="birthdayDate">
								<span id="birthdayDateIcon"></span>
							</span>
						</td>
					</tr>
					<tr style="display:none">
						<th>
							<span>기념일</span>
						</th>
						<td>
							<span>
								<input name="anniversary" type="text" id="anniversaryDate">
								<span id="anniversaryDateIcon"></span>
							</span>
						</td>
					</tr>
					<tr style="display:none">
						<th>
							<span>집 전화</span>
	                        <span class="help"><span class="tool_tip">해외 전화번호인 경우, 아래 4가지 방식으로 입력해 주세요. <br><br> (국가번호:82) (지역번호:02) (전화번호:123-4567) 인 경우, <br>  1. +8221234567<br> 2. +82021234567<br>  3. +82-2-123-4567<br> 4. +82-02-123-4567<br><br>※ 번호 앞에 '+' 는 반드시 붙여야 합니다.<i class="tail_left"></i></span></span>
						</th>
						<td>
							<span><input name="home_tel" type="text"></span>
						</td>
					</tr>
					<tr style="display:none">
						<th>
							<span>집 주소</span>
						</th>
						<td>
							<span id="homeDetail">
								<input name="home_basicAddress" type="text" readonly="readonly">
								<input name="home_country" type="hidden">
								<input name="home_postalCode" type="hidden">
								<input name="home_state" type="hidden">
								<input name="home_city" type="hidden">
								<input name="home_extAddress" type="hidden">
								<span title="상세주소입력"></span>
							</span>
						</td>
					</tr>
					<tr style="display:none">
						<th>
							<span>집 팩스</span>
	                        <span class="help"><span class="tool_tip">해외 전화번호인 경우, 아래 4가지 방식으로 입력해 주세요. <br><br> (국가번호:82) (지역번호:02) (전화번호:123-4567) 인 경우, <br>  1. +8221234567<br> 2. +82021234567<br>  3. +82-2-123-4567<br> 4. +82-02-123-4567<br><br>※ 번호 앞에 '+' 는 반드시 붙여야 합니다.<i class="tail_left"></i></span></span>
						</th>
						<td>
							<span><input name="home_fax" type="text"></span>
						</td>
					</tr>
					<tr style="display:none">
						<th><span>집 홈페이지</span>
						</th>
						<td><span><input name="home_homepage" type="text"></span></td>
					</tr>
					<tr style="display:none">
						<th>
	                        <span>회사 팩스</span>
	                        <span class="help"><span class="tool_tip">해외 전화번호인 경우, 아래 4가지 방식으로 입력해 주세요. <br><br> (국가번호:82) (지역번호:02) (전화번호:123-4567) 인 경우, <br>  1. +8221234567<br> 2. +82021234567<br>  3. +82-2-123-4567<br> 4. +82-02-123-4567<br><br>※ 번호 앞에 '+' 는 반드시 붙여야 합니다.<i class="tail_left"></i></span></span>
						</th>
						<td><span><input name="company_fax" type="text"></span></td>
					</tr>
					<tr style="display:none">
						<th><span>회사 홈페이지</span>
						</th>
						<td><span><input name="company_homepage" type="text"></span></td>
					</tr>
					<!--  hidden  -->
					
					<tr class="line"><td colspan="2"><hr></td></tr>						
					</tbody>
				</table>
			</fieldset>
		</form>
		<div class="page_action_wrap">
			<a id="returnList"><span>목록으로 이동</span></a>
			<a id="contactDelete"><span>삭제</span></a>				
		</div>
	</div>
</div>