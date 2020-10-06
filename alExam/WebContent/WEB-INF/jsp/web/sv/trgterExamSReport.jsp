<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	var EXAM_NO = "${EXAM_NO}";
	var R_NUMBER = "${R_NUMBER}"
	var EXAM_SN = "${EXAM_SN}";
	var EXAM_DIV = "${EXAM_DIV}"


	$(document).ready(function(){
		getTrgterExamSReport();
	});
	
	//검사결과지 가저오기
	function getTrgterExamSReport(){
		cfn.ajax({
			   "url" : "/sv/getTrgterExamSReport.do"
			 , "data" : {
				 			 "EXAM_NO" 		: EXAM_NO
				 			,"R_NUMBER"		: R_NUMBER
				 			,"EXAM_SN"		: EXAM_SN
				 			,"EXAM_DIV"		: EXAM_DIV
			 } 
			 , "method" : "POST"
			 , "dataType" : "JSON"
			 , "success" : function(data){
				//대상자정보
				setTrgterSExamInfo(data.rsInfo);
				//인지영역 결과표
				setTrgterSExamArea(data.rsArea)
				//인지영역그래프
				setTrgterSExamGrpO(data.grpO);
				//기억력그래프
				setTrgterSExamGrpM(data.grpM);
				//세부검사 결과표
				setTrgterSExamReportDtls(data.rsDtls);
				//누적검사결과표
				setTrgterSExamReportRec(data.rsRec)
				//비문해검사표
				setTrgterSExamrsLiteracy(data.rsLiteracy)
			 }
			 , "error" : function(data){
				alert("통신실패");
			 }
		});
	}
	//대상자정보
	function setTrgterSExamInfo(data){
		var str =""
			
		str += "<tr>"
		str += "<th scope='col'>이름</th>"
		str += "<td>"+ data.NAME +"</td>"
		str += "<th scope='col'>차트번호</th>"
		str += "<td>"+ data.C_NUMBER +"</td>"
		str += "</tr>"
		str += "<tr>"
		str += "<th scope='col'>만 나이(생일)</th>"
		str += "<td>만 "+ data.AGE + "세(" + data.BIRTH + ")</td>"
		str += "<th scope='col'>검사기관</th>"
		str += "<td>"+ data.ORG_NM +"</td>"
		str += "</tr>"
		str += "<tr>"
		str += "<th scope='col'>성별</th>"
		str += "<td>" + data.GENDER + "</td>"
		str += "<th scope='col'>의뢰의(과)</th>"
		str += "<td>" + data.ORG_PART_NM + "</td>"
		str += "</tr>"
		str += "<tr>"
		str += "<th scope='col'>교육년수</th>"
		str += "<td>" + data.EDU_YEAR + " 년</td>" 
		str += "<th scope='col'>검사일</th>"
		str += "<td>" + data.EXAM_CMP_DATE +"</td>"
		str += "</tr>"
		str += "<tr>"
		str += "<th scope='col'>손잡이</th>"
		str += "<td>" + data.HAND_CD + "</td>"
		str += "<th scope='col'>검사차수</th>"
		str += "<td>" + data.EXAM_SN + "차</td>"
		str += "</tr>"
		str += "<tr>"
		str += "<th scope='col'>보호자(동거여부)</th>"
		str += "<td>" + data.INMATE_NAME + "(" + data.INMATE_YN + ")</td>"
		str += "<th scope='col'>검사자</th>"
		str += "<td>"+ data.EXAM_INS_NM +"</td>"
		str += "</tr>"
		$("#trgterSExamInfo").append(str);
		
		$('#examOpin').val(data.EXAM_OPIN.split('&lt;br/&gt;').join("\r\n"));
		
		$(".grpSN").html(data.EXAM_SN + "차");
	}
	
	//의견등록
	function updateExamOpin(){
		
		var EXAM_NO = "${EXAM_NO}";
				
		var EXAM_OPIN = $('#examOpin').val();
		EXAM_OPIN = EXAM_OPIN.replace(/(?:\r\n|\r|\n)/g, '<br/>');
		
		if(isNullToString(EXAM_OPIN)!=""){
			if(confirm("저장 하시겠습니까?")){
				cfn.ajax({
					   "url" : "/sv/examOpin.do"
					 , "data" : {
						 			"EXAM_NO"		: EXAM_NO
						 			,"EXAM_OPIN" 	: EXAM_OPIN
						 			
					 } 
					 , "method" : "POST"
					 , "dataType" : "JSON"
					 , "success" : function(data){
						 alert("저장되었습니다.");
						 location.reload();	
					 }
					 , "error" : function(data){
						alert("통신실패");
					 }
				});
			}
		}else{
			alert("평가내용을 입력해주세요");
			return false;
		}
	}
	
	//인지영역 그래프
	function setTrgterSExamGrpO(data){
		
		var str = "";
		
		for(var i=0; i<data.length; i++){
			
			var bar = 0;
			
			if(data[i].Z_PER > 100){
				bar = 100;
			}else{
				bar = data[i].Z_PER;
			}
			
			str += "<li>";
			str += "<div class='title_value'><span>" + data[i].AREA_NM + "</span><span>" + data[i].VAL + "</span></div>";
			str += "<div class='stack_graph'>";
			str += "<ul>";
			if(data[i].Z_POINT_DIR == "R"){
				str += "<li>";
				str += "<div class='ri_g grp_blue'></div>";
				str += "</li>";
				str += "<li>";
				str += "<div class='le_g grp_blue' style='width:" + bar + "%'></div>";
				str += "</li>";
			}else if(data[i].Z_POINT_DIR == "L"){
				str += "<li>";
				str += "<div class='ri_g grp_blue' style='width:" + bar + "%'></div>";
				str += "</li>";
				str += "<li>";
				str += "<div class='le_g grp_blue'></div>";
				str += "</li>";
			}
			str += "</ul>";
			str += "</div>";
			str += "</li>";
		}
		$("#grpO").append(str);
	}
	
	//기억력그래프
	function setTrgterSExamGrpM(data){
		var str = "";
		
		for(var i=0; i<data.length; i++){
			
			var bar = 0;
			
			if(data[i].Z_PER > 100){
				bar = 100;
			}else{
				bar = data[i].Z_PER;
			}
			
			str += "<li>";
			str += "<div class='title_value'><span>" + data[i].EXAM_KEY_WORD + "</span><span>" + data[i].VAL + "</span></div>";
			str += "<div class='stack_graph'>";
			str += "<ul>";
			if(data[i].Z_POINT_DIR == "R"){
				str += "<li>";
				str += "<div class='ri_g grp_blue'></div>";
				str += "</li>";
				str += "<li>";
				str += "<div class='le_g grp_blue' style='width:" + bar + "%'></div>";
				str += "</li>";
			}else if(data[i].Z_POINT_DIR == "L"){
				str += "<li>";
				str += "<div class='ri_g grp_blue' style='width:" + bar + "%'></div>";
				str += "</li>";
				str += "<li>";
				str += "<div class='le_g grp_blue'></div>";
				str += "</li>";
			}
			str += "</ul>";
			str += "</div>";
			str += "</li>";
		}
		$("#grpM").append(str);
	}
	
	//인지영역 결과표
	function setTrgterSExamArea(data){
		
		var str = "";
		var str2 = "";
		var AREA_POINT = 0;
		var AREA_TRS_POINT1 = 0;
		var AREA_TRS_POINT2 = 0;
		var AREA_Z_POINT = 0;
		
		for(var i=0; i<data.length; i++){
			str += "<tr>"
			str += "<td scope='row'>" + data[i].AREA_NM + "</td>"
			str += "<td>" + data[i].TRANS_GET_POINT + "</td>"
			str += "<td>" + data[i].TRANS_SCORE + "</td>"
			str += "<td>" + data[i].Z_POINT + "</td>"
			str += "</tr>"
	
			AREA_POINT += data[i].TRANS_GET_POINT;
			AREA_TRS_POINT1 += parseFloat(data[i].TRANS_SCORE.substr(0,2));
			AREA_TRS_POINT2 += parseFloat(data[i].TRANS_SCORE.substr(3,2));
			
			AREA_Z_POINT += parseFloat(data[i].Z_POINT);
		}
		
		$("#examAreaPoint").append(str);
		
		str2 += "<tr>"
		str2 += "<th scope='row'>총점</th>"
		str2 += "<td>" + AREA_POINT + "</td>"
		str2 += "<td>" + AREA_TRS_POINT1 + "/" + AREA_TRS_POINT2 + "</td>"
		str2 += "<td>" + (Math.round(AREA_Z_POINT * 1e12)/1e12 / data.length).toFixed(2) + "</td>"
		str2 += "</tr>"
		
		$("#examAreaTotPoint").append(str2);
	
	}
	
	function setTrgterSExamReportDtls(data){
		
		var str = "";
		
		for(var i=0; i<data.length; i++){
			str += "<tr>"
			str += "<th scope='row'"
			if(data[i].AREA_DTLS_NM == undefined){
				str += " colspan='2'"		
			}
			str += " class='" + data[i].AREA_NM + "_NM'>" + data[i].AREA_NM + "</th>"
			str += "<th scope='colgroup' class='line " + data[i].AREA_DTLS_NM + "_DTLS_NM'>" + data[i].AREA_DTLS_NM + "</th>"
			str += "<td class='le_line'>" + data[i].EXAM_KEY_WORD
			if(data[i].RMK != undefined){
				str += "<br>" + data[i].RMK
			}
			str += "</td>"
			str += "<td>" + data[i].ORI_GET_POINT
			if(data[i].ORI_GET_DTLS_POINT != undefined){
				str += "<br>" + data[i].ORI_GET_DTLS_POINT
			}
			str += "</td>"
			str += "<td>" + data[i].Z_POINT + "</td>"
			str += "<td>" + data[i].TRANS_GET_POINT + "</td>"
			str += "</tr>"
		}
		$("#ExamReportDtls").append(str);
		
		//대분류 row 합치기
		for(var i=0; i<data.length; i++){
			genRowspan(data[i].AREA_NM + "_NM");	
		}
		//소분류 row 합치기
		for(var i=0; i<data.length; i++){
			genRowspan(data[i].AREA_DTLS_NM + "_DTLS_NM");	
		}
		//소분류 row 합쳐진 것들중 값이 없는것들 삭제
		$(".undefined_DTLS_NM").remove();
	}
	
	//누적검사결과표
	function setTrgterSExamReportRec(data){
		
		var strH = "";
		
		strH += "<tr>"
		strH += "<th scope='col'>인지영역</th>"
		strH += "<th scope='col'>검사(총점)</th>"
		strH += "<th scope='col'>" + data[0].EXAM_CMP_DATE_1 + "</th>"
		strH += "<th scope='col'>"
		if(data[0].EXAM_CMP_DATE_2 != undefined){
			strH += data[0].EXAM_CMP_DATE_2	
		}
		strH += "</th>"
		strH += "<th scope='col'>"
		if(data[0].EXAM_CMP_DATE_3 != undefined){
			strH += data[0].EXAM_CMP_DATE_3	
		}
		strH += "</th>"
		strH += "</tr>"	
		
		$("#ExamReportRecHeader").append(strH);
		
		
		
		var str = "";
		
		for(var i=0; i<data.length; i++){
			str += "<tr>"
			str += "<th scope='row' style='text-align:center' class='" + data[i].AREA_NM + "_Name'>" + data[i].AREA_NM + "</th>"
			str += "<td class='le_line'>" + data[i].EXAM_KEY_WORD + "<br>"
			if(data[i].RMK != undefined){
				str += data[i].RMK
			}
			str += "</td>" 
			str += "<td>" + data[i].POINT_1 + "</td>"
			str += "<td>"
			if(data[i].POINT_2 != " ()"){
				str += data[i].POINT_2
			}
			str += "</td>"
			str += "<td>"
			if(data[i].POINT_3 != " ()"){
				str += data[i].POINT_3
			}
	        str += "</td>"
			str += "</tr>"
		}
		
		$("#ExamReportRec").append(str);
		
		for(var i=0; i<data.length; i++){
			genRowspan(data[i].AREA_NM + "_Name");	
		}
	}
	
	//비문해검사표
	function setTrgterSExamrsLiteracy(data){
		if(data != null || data != ''){
			$("#inWrite").text(data.IN_WRITE);
			$("#inRead").text(data.IN_READ);
			$("#paWrite").text(data.PA_WRITE);
			$("#paRead").text(data.PA_READ);
			$("#divYn").text(data.DIV_YN);
		}
	}
	
	
	//같은 row끼리 묶기
	function genRowspan(className){
	    $("." + className).each(function() {
	        var rows = $("." + className + ":contains('" + $(this).text() + "')");
	        if (rows.length > 1) {
	            rows.eq(0).attr("rowspan", rows.length);
	            rows.not(":eq(0)").remove();
	        }
	    });
	}
	
	//인쇄버튼 클릭 시 인쇄 팝업 호출
	function callPrintPop(){		
		var strFeature = "width=600,height=400";
		objWin = window.open("./sv/trgterExamSReportPrint.do?R_NUMBER="+R_NUMBER+"&EXAM_SN="+EXAM_SN+"&EXAM_DIV="+EXAM_DIV+"&EXAM_NO="+EXAM_NO+"", "출력", strFeature);
	}		

</script>


<div class="page">
	<section>
		<ul class="title_align">
			<li><h1>S-LINDA검사결과지(문맹에도 적용 가능한  치매인지기능검사 단축형)</h1></li>
			<li><a href="#" class="btn_all blue btn_print" onclick="callPrintPop();">인쇄</a></li>
		</ul>
		<table class="table_type print topb mt15">
			<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="20%">
				<col width="30%">
			</colgroup>
			<tbody id="trgterSExamInfo">
			</tbody>
		</table>
	</section>
		
	<section class="mt35">
		<h2>비문해 판정</h2>		
		<table class="boardlist topb mt10">
			<colgroup>
				<col width="25%">
				<col width="25%">
				<col width="25%">
				<col width="25%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">검사영역</th>
					<th scope="col">병전기능 보호자보고</th>
					<th scope="col">환자검사</th>
					<th scope="col">비문해 여부</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="le_line">쓰기</td>
					<td id="inWrite"></td>
					<td id="inRead"></td>
					<td rowspan = 2 id="divYn"></td>
				</tr>
				<tr>
					<td class="le_line">읽기</td>
					<td id="paWrite"></td>
					<td id="paRead"></td>
				</tr>										
			</tbody>
		</table>
	</section>

	<section class="mt35">
		<h2>종합결과</h2>
		<h3 class="mt10">-인지 영역 그래프</h3>
		<div class="greap_board_box">
			
			<div class="graph_area s_lica01">
				<ul class="bar_graph_box" id="grpO">
				</ul>
				<ul class="number">
					<li><span></span><span>-3</span></li>
					<li><span></span><span>-2</span></li>
					<li><span></span><span>-1</span></li>
					<li><span></span><span>0</span></li>
					<li><span></span><span>1</span></li>
					<li><span></span><span>2</span></li>
					<li><span></span><span>3</span></li>
				</ul>
			</div>

			<div class="symbol_color">
				<ul>
					<li class="grpSN"></li>
				</ul>
			</div>

		</div>
	</section>

	<section class="mt35">
		<h3>-기억 영역 그래프</h3>
		<div class="greap_board_box">
			
			<div class="graph_area s_lica02">
				<ul class="bar_graph_box" id="grpM">
					
				</ul>
				<ul class="number">
					<li><span></span><span>-3</span></li>
					<li><span></span><span>-2</span></li>
					<li><span></span><span>-1</span></li>
					<li><span></span><span>0</span></li>
					<li><span></span><span>1</span></li>
					<li><span></span><span>2</span></li>
					<li><span></span><span>3</span></li>
				</ul>
			</div>

			<div class="symbol_color">
				<ul>
					<li class="grpSN"></li>
				</ul>
			</div>

		</div>
	</section>	

	<section class="mt35">
		<h3>-인지 영역 결과표</h3>
		<table class="boardlist topb mt10">
			<colgroup>
				<col width="*">
				<col width="23%">
				<col width="23%">
				<col width="23%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">인지영역</th>
					<th scope="col">점수</th>
					<th scope="col">실시된 총점/총점</th>
					<th scope="col">Z점수</th>
				</tr>
			</thead>
			<tbody id="examAreaPoint">
				
			</tbody>
			<tfoot id="examAreaTotPoint">
				
			</tfoot>
		</table>
	</section>

	<section class="mt35">
		<h2>세부 검사 결과표</h2>
		<table class="table_type print topb mt15">
			<colgroup>
				<col width="14%">
				<col width="13%">
				<col width="*">
				<col width="13%">
				<col width="13%">
				<col width="13%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">인지영역</th>
					<th scope="col" colspan="2">검사</th>
					<th scope="col">원점수</th>
					<th scope="col">Z점수</th>
					<th scope="col">총점산출용<br>변환점수</th>
				</tr>
			</thead>
			<tbody id="ExamReportDtls">
				
			</tbody>
		</table>
		</section>
		
	<section class="mt35">
		<h2 class="mt35">누적 검사 결과표</h2>
		<table class="table_type print topb mt15">
			<colgroup>
				<col width="20%">
				<col width="*%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
			</colgroup>
			<thead id="ExamReportRecHeader">
			</thead>
			<tbody id="ExamReportRec">
			</tbody>
		</table>		
	</section>
	<section class="mt35">
		<h2>평가 종합 소견</h2>
		<textarea placeholder="종합 평가 소견 내용 작성" class="mt10 ChkByte" style="height:300px" id="examOpin" onkeyup="fnChkByte(this);"></textarea>
	</section>
	<div class="btnright mt10" onclick="updateExamOpin();"><a href="#" class="btn_all col01 btn_save">저장</a></div>	
</div>
