<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	/**
	 * @Page Name : importResource.jsp
	 * @Description : Javascript & Css import 공통화면
	 *				#필수사항 - c:param으로 넘기는 값으로 
	 *				- clientMode : CommonController.java의 importResourceFile()에서 app인지 web인지 구분하기 위한 구분 값.
	 *							단, 화면에서 사용안함.(예:web이 화면이 많기 때문에 구분 값을 설정 안하고 app에서 호출되는 구분 값으로 'APP' 정의)
	 * @Modification Information
	 *
	 *	수정일			수정자		수정내용
	 *	----------	----	-------------------------------
	 *	2020.05.07	오샘이		최초 생성
	 *
	 */
%>
<!-- 공통 적용 S -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript">
	/* 필수 변수 선언 */
	var ABSOLUTE_URL	= '${pageContext.request.scheme}' + '://' + '${pageContext.request.serverName}' + ':' + '${pageContext.request.serverPort}' + '${pageContext.request.contextPath}';
</script>
<c:set var="userAgent" value="${header['User-Agent']}" scope="request"/>
<c:set var="ABSOLUTE_URL" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" scope="request"/>



<!-- 전체 공통 CSS 파일 -->
<link rel="stylesheet" type="text/css" href="${ABSOLUTE_URL}/css/web/base.css" />
<link rel="stylesheet" type="text/css" href="${ABSOLUTE_URL}/css/web/common.css" />
<link rel="stylesheet" type="text/css" href="${ABSOLUTE_URL}/css/web/layout.css" />
<link rel="stylesheet" type="text/css" href="${ABSOLUTE_URL}/css/web/print.css" />


<script type="text/javascript" charset="utf-8" src="${ABSOLUTE_URL}/js/jquery/jquery-3.5.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${ABSOLUTE_URL}/js/jquery/jquery.placeholder.js"></script>

<!-- // jQuery UI 라이브러리 js파일 -->
<script type="text/javascript" charset="utf-8" src="${ABSOLUTE_URL}/js/jquery/jquery-ui.min.js"></script>

<script type="text/javascript" charset="utf-8" src="${ABSOLUTE_URL}/js/jquery/jquery.form.js"></script>

<!-- 전체 공통 JS 파일 -->
<script type="text/javascript" charset="utf-8" src="${ABSOLUTE_URL}/js/common/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${ABSOLUTE_URL}/js/common/date.js"></script>

<!-- 차트 JS 파일 -->
<script type="text/javascript" charset="utf-8" src="${ABSOLUTE_URL}/js/chart/d3.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${ABSOLUTE_URL}/js/chart/custom/horizonBarChart.js"></script>		

