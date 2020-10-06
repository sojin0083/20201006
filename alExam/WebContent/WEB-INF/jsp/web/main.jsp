<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
</script>

<form id="mrMoveForm" method="get">
	<input type="hidden" name="MENU_URL" id="MENU_URL">	
	<input type="hidden" name="menuCd" id="menuCd">
	<input type="hidden" name="mainYn" id="mainYn">
	<input type="hidden" name="mainCnslClf" id="mainCnslClf">
	<input type="hidden" name="mainTodayYn" id="mainTodayYn">
	<input type="hidden" name="mainTotalYn" id="mainTotalYn">
	<input type="hidden" name="mainTotalBgnDe" id="mainTotalBgnDe">
	<input type="hidden" name="mainSchYn" id="mainSchYn">
	<input type="hidden" name="mainTrgtYY" id="mainTrgtYY">
</form>
<form id="noticeForm" method="post">
	<input type="hidden" name="MENU_URL" id="notice_MENU_URL">	
	<input type="hidden" name="menuCd" id="notice_menuCd">	
	<input type="hidden" id="CNFM_YN" name="CNFM_YN"/>
	<input type="hidden" id="NOTICE_SN" name="NOTICE_SN"/>
</form>
	<!-- main_cont01 S -->
	<div >
		메인페이지
	</div>

<div class="lding" style="display: none;">
	<img src='../images/web/contents/loading.gif'/>
</div>
