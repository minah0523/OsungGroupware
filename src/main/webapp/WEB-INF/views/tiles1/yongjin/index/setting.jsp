<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content_page profile">
    <div class="portlet_warp profile_wrap" style="height:px">
        <section class="list_item list_item_alarm">
            <header>
                <h1>
                    <span class="ic_gnb ic_profile3_h"></span>
                    <span class="title">환경설정</span>
                </h1>
            </header>
        </section>    
    </div>
    <form id="configForm">
        <fieldset>
            <table class="form_type">
                <colgroup>
                    <col width="150px">
                    <col width="*">
                </colgroup>
                <tbody>
                <tr style="display: none">
                    <th><span class="title">스킨 설정</span></th>
                    <td>
                        <select name="style">
                                <option value="basic" selected="">기본</option>
                                <option value="blue">BLUE</option>
                                <option value="orange">ORANGE</option>
                                <option value="red">RED</option>
                                <option value="yellow">YELLOW</option>
                                <option value="green">GREEN</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><span class="title">메뉴 테마 설정</span></th>
                    <td>
                        <span class="column_wrap">
                            <span class="option_wrap">
                                <input type="radio" name="theme" value="THEME_CLASSIC" id="theme_classic">
                                <label for="theme_classic"><strong>Classic</strong><br>기본형 메뉴입니다.<br>메뉴들이 상단에 차례대로 나열됩니다.</label>
                                <br><span class="img_theme classic"></span>
                            </span>
                        </span>
                        <span class="column_wrap">
                            <span class="option_wrap">
                                <input type="radio" name="theme" value="THEME_ADVANCED" checked="" id="theme_advanced">
                                <label for="theme_advanced"><strong>Advanced</strong><br>메뉴가 왼쪽으로 세로 정렬됩니다. <br>워크스페이스가 와이드 스크린에 최적화되었습니다.</label>
                                <br><span class="img_theme advanced"></span>
                            </span>
                        </span>
                    </td>
                </tr>
                <tr class="line"><td colspan="2"><hr></td></tr>
                </tbody>
            </table>
        </fieldset>
    </form>
    <div class="page_action_wrap">
        <a class="btn_major" data-role="button" id="save"><span class="txt">저장</span></a>             
    </div>
</div>