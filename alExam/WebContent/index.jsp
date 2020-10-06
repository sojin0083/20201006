<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>${menuInfo.MENU_NM}</title>
	<c:import url="/cmmn/importResourceFile.do" var="jsimport" charEncoding="utf-8">
		<c:param name="pageMode">grid</c:param>
	</c:import>
	<c:out value="${jsimport}" escapeXml="false"/>
<script type="text/javascript" src="${ABSOLUTE_URL}/js/jquery/jquery.placeholder.js"></script>
	<script type="text/javascript">
	</script>
</head>
<jsp:forward page="/login/loginPage.do"></jsp:forward>
