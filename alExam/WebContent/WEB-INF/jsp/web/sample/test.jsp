<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

		$(document).ready(function(){
			//성별
			searchCmmnCd("#GENDER","CM002","","","성별전체|all");
			//연령
	  		searchCmmnCd("#AGE_GROUP","CM008","","",'연령전체|null');  	
			//달력
			//datePickerFn();					
	  		actCallback();
			
		});
		
		
	  //return { "group":cnt, "column":group, "date":d.date, "dy":d.dy, "totCnt":d.totCnt, "excsCnt":d.excsCnt };

		
		//활동량 차트 그리기
		function actCallback(){
			chartActData=[];
			chartTitle = "";
			var minVal = 0;
			var maxVal = 100;

			$("#chart1").empty();
			chartActData.push({
											"item"		  : 'A' ,
											"point"	  : 1
										}
			                          ,{
											"item"		  : 'B' ,
												"point" : 2
										}
			                          ,{
											"item"		  : 'C' ,
											"point"     : -1
										}		
			                          ,{
											"item"		  : 'D' ,
											"point"     : -2
										}				                          
			)
			;			
			chartTitle = [ 'AA', 'BB', 'CC', 'DD' ];
			
			
			var horizonBarChart = new HorizonBarChart({
					"div"		: "#chart1"
 				,   "data"    : chartActData
			});

		}	
		
		function dtlsPage() {
  		    $("#menuCd").val("${menuInfo.MENU_CD}");
		    $("#MENU_URL").val("/aa/sampleDtls.do");	    
		    $("#detailForm").attr("action", "/pageNavi.do");		    
		    $("#detailForm").submit();
		}		
		
		function popup() {
			 modalView("/sv/publicHealthMissonSelPop.do");
		}			
		
	</script>	
	<div class="graphArea">
		<div id="chart1" style="width:100%;height:100%;border:0px;"></div>
	    <div class="link_wrap" id="actDtls"></div>
	</div>	
	
	<a href="#" class="schbox_sch">
		<em class="btn_sch" onclick="javascript:dtlsPage(); return false;" >상세</em>
	</a>	
	
	<a href="#" class="schbox_sch">
		<em class="btn_sch" onclick="javascript:popup(); return false;" >팝업</em>
	</a>		
	
	<form id="detailForm" method="POST">
		<input type="hidden" id="USER_ID" name="USER_ID" />
		<input type="hidden" id="menuCd" name="menuCd" />
		<input type="hidden" id="MENU_URL" name="MENU_URL" />
	</form>	

		