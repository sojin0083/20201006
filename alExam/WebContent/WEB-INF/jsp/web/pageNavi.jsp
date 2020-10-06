<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" />
<html lang="ko">
<head>
	<title>${menuInfo.MENU_NM}</title>
	<c:import url="/cmmn/importResourceFile.do" var="jsimport" charEncoding="utf-8">
	</c:import>
	<c:out value="${jsimport}" escapeXml="false"/>	
</head>

<body>
	<div id="wrap">
		<!-- 스킵네비 S -->
		<ul id="skipnav">
			<li><a href="#conts">본문 바로가기</a></li>
		</ul>
		<!-- 스킵네비 E -->
		<div id="mid_wrap">			
			<jsp:include page="./include/topMenu.jsp" flush="false">
				<jsp:param value="${menulist}" name="menulist"/>
			</jsp:include>
			<div id="wrap_content">
				<div id="contents">
					<c:choose>
					<c:when test="${menuInfo.MENU_URL != null }"> 
						<c:set var="menuCd" value="${menuInfo.MENU_CD}" scope="session"/>
						<c:import url="${menuInfo.MENU_URL}" var="curPage" charEncoding="utf-8">
							<c:param value="${fm}" name="fm"/>
						</c:import>
						<c:out value="${curPage}" escapeXml="false"/>
					</c:when>
					</c:choose>
					<!-- 동적 Contents 가져오기  끝-->
				</div>
			</div>
			<div id="footer">
			</div>
		</div>
	</div>	
</body>
</html>
