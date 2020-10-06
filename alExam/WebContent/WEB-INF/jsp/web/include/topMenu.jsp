<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>

	<script>
		$(function() {
			$('ul.tab li').click(function() {
				var activeTab = $(this).attr('data-tab');
				$('ul.tab li').removeClass('current');
				$('.tabcontent').removeClass('current');
				$(this).addClass('current');
				$('#' + activeTab).addClass('current');
			})
		});
	</script>


<!-- header S -->
<div id="header">
	<div class="header_inner">
			<h1>
				<a href="/alExam/pageNavi.do?menuCd=NTG100">치매관리프로그램</a>
			</h1>	
			<ul>
				<c:if test="${SESS_AUTH_CD eq 'HLTH001'}">	
					<li class="utmn01">${SESS_USER_NM } [SuperAdmin]</li>
				</c:if>
				<c:if test="${SESS_AUTH_CD ne 'HLTH001'}">
					<li class="utmn01">${SESS_USER_NM } [${SESS_JOB_CLF_NM }]</li>
				</c:if>								
				<li class="utmn03"><a href="/alExam/login/loginOut.do">로그아웃</a></li>
			</ul>			
	</div>
	<div class="gmb_wid">
		<ul>
		<c:forEach items="${menuList}" var="item">
			<c:if test="${item.MENU_LVL eq 1}">			
				<c:if test="${item.MENU_CD eq 'NTG100'}">
					<li id="${item.MENU_CD}"><a href="./pageNavi.do?menuCd=${item.MENU_CD}" class="top_mn0${item.MENU_ORD} first" class="one_d">${item.MENU_NM}</a></li>
				</c:if>
				<c:if test="${item.MENU_CD ne 'NTG100'}">				
					<li id="${item.MENU_CD}"><a href="./pageNavi.do?menuCd=${item.MENU_CD}" class="top_mn0${item.MENU_ORD}" class="one_d">${item.MENU_NM}</a></li>
				</c:if>						
			</c:if>
		</c:forEach>
		</ul>
	</div>	
</div>
<!-- header E -->
