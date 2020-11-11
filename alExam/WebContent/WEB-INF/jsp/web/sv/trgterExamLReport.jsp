<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	var P_R_NUMBER = "${P_R_NUMBER}";
	var P_EXAM_NO  = "${P_EXAM_NO}";	
	var P_EXAM_SN  = "${P_EXAM_SN}";	

	$(document).ready(function(){
		$("#R_NUMBER").val(P_R_NUMBER);
		$("#EXAM_NO").val(P_EXAM_NO);	
		$("#EXAM_SN").val(P_EXAM_SN);			
		
		fn_search();	

	});

	function fn_search(){
		cfn.ajax({
				  "url"			:	"/sv/trgterExamLReportContentsList.do"
				, "data"		:	{
										"R_NUMBER"			: $("#R_NUMBER").val()
									  , "EXAM_NO"         : $("#EXAM_NO").val()
									  , "EXAM_SN"         : $("#EXAM_SN").val() 
  				}
			 	, "dataType"	:	"json"
			 	, "method"		:	"POST"
			 	, "success"		:	searchList
		});
	}

	function searchList(data){
		
		//대상자정보
		fn_rsTrgt(data);
		//비문해여부
		fn_rsIll(data);
		//인지영역 그래프 조회
		fn_rsGrp1(data);
		//기억력 그래프 조회
		fn_rsGrp2(data);
		//인지영역 결과표 조회
		fn_rsTb1(data);
		//세부검사결과표 조회
		fn_rsTb2(data);
		//누적검사 결과표 조회
		fn_rsTb3(data);
	}
	
	//대상자정보조회
	function fn_rsTrgt(data){
		var rsTrgt = data.rsTrgt;	
		if(rsTrgt == null || rsTrgt== ''){
			$("#userNm").text(rsTrgt.USER_NM);
			$("#rNumber").text(rsTrgt.C_NUMBER);
			$("#gender").text(rsTrgt.GENDER);
			$("#birth").text(rsTrgt.BIRTH);
			$("#orgPart").text(rsTrgt.ORG_PART);
			$("#examCmpDate").text(rsTrgt.EXAM_CMP_DATE);
			$("#examSn").text(rsTrgt.EXAM_SN);
			$("#inmate").text(rsTrgt.INMATE);
			$("#name").text(rsTrgt.NAME);		
			$("#orgNm").text(rsTrgt.ORG_NM);
			$("#eduYear").text(rsTrgt.EDU_YEAR);
			$("#handCd").text(rsTrgt.HAND_CD);
			$('#textAreaComment').val(rsTrgt.EXAM_OPIN.split('&lt;br/&gt;').join("\r\n"));
		}
		else{
			$("#userNm").text(rsTrgt.USER_NM);
			$("#rNumber").text(rsTrgt.C_NUMBER);
			$("#gender").text(rsTrgt.GENDER);
			$("#birth").text(rsTrgt.BIRTH);
			$("#orgPart").text(rsTrgt.ORG_PART);
			$("#examCmpDate").text(rsTrgt.EXAM_CMP_DATE);
			$("#examSn").text(rsTrgt.EXAM_SN);
			$("#inmate").text(rsTrgt.INMATE);
			$("#name").text(rsTrgt.NAME);		
			$("#orgNm").text(rsTrgt.ORG_NM);
			$("#eduYear").text(rsTrgt.EDU_YEAR);
			$("#handCd").text(rsTrgt.HAND_CD);
			$('#textAreaComment').val(rsTrgt.EXAM_OPIN);
		}
		
	}
	
	//비문해판정
	function fn_rsIll(data){
		var rsIll = data.rsIll;	

		if(rsIll != null || rsIll != ''){
			$("#inWrite").text(rsIll.IN_WRITE);
			$("#inRead").text(rsIll.IN_READ);
			$("#paWrite").text(rsIll.PA_WRITE);
			$("#paRead").text(rsIll.PA_READ);
			$("#divYn").text(rsIll.DIV_YN);
		}
	}	

	//인지영역 그래프 조회	
	function fn_rsGrp1(data){
		
		var rsGrp1 = data.rsGrp1;		
		var charStr        = new StringBuffer();
		var charStrColor = new StringBuffer(); 
		var obj = $("#divRsGrp1");

		if(rsGrp1 !=  null || rsGrp1 != ''){
			if(rsGrp1.length > 0){
				for(var i=0; i<rsGrp1.length; i++){
					charStr.append('<li>');
					charStr.append('	<div class="title_value">');
					charStr.append('		<span>'+rsGrp1[i].AREA_NM+'</span>');
					charStr.append('		<span>'+rsGrp1[i].VAL+'</span>');			
					charStr.append('	</div>');
					
					charStr.append('	<div class="stack_graph">');
					charStr.append('		<ul>');
					if(rsGrp1[i].Z_POINT_DIR == 'R'){
						charStr.append('			<li>');		
						//charStr.append('				<div class="ri_g bg_sky"  style=""></div>');
						charStr.append('				<div class="ri_g grp_blue" style=""></div>');
						charStr.append('			</li>');						
						charStr.append('			<li>');		
						//charStr.append('				<div class="le_g bg_sky" style="width:'+rsGrp1[i].Z_PER+'%"></div>');
						charStr.append('				<div class="le_g grp_blue" style="width:'+rsGrp1[i].Z_PER+'%"></div>');
						charStr.append('			</li>');
					}else if(rsGrp1[i].Z_POINT_DIR == 'L'){
						charStr.append('			<li>');		
						//charStr.append('				<div class="ri_g bg_sky"  style="width:'+rsGrp1[i].Z_PER+'%"></div>');
						charStr.append('				<div class="ri_g grp_blue" style="width:'+rsGrp1[i].Z_PER+'%"></div>');
						charStr.append('			</li>');						
						charStr.append('			<li>');		
						//charStr.append('				<div class="le_g bg_sky" style=""></div>');
						charStr.append('				<div class="le_g grp_blue" style=""></div>');
						charStr.append('			</li>');											
					}
					charStr.append('		</ul>');
					charStr.append('	</div>');							
				}			
			}			
			$("#divRsGrp1Color").text($("#EXAM_SN").val()+"차수");
		}

		obj.append(charStr.toString());		
	}
	
	//기억력 그래프 조회
	function fn_rsGrp2(data){
			
		var rsGrp2 = data.rsGrp2;		
		var charStr        = new StringBuffer();
		var charStrColor = new StringBuffer(); 
		var obj = $("#divRsGrp2");

		if(rsGrp2 !=  null || rsGrp2 != ''){
			if(rsGrp2.length > 0){
				for(var i=0; i<rsGrp2.length; i++){
					charStr.append('<li>');
					charStr.append('	<div class="title_value">');
					charStr.append('		<span>'+rsGrp2[i].EXAM_KEY_WORD+'</span>');
					charStr.append('		<span>'+rsGrp2[i].VAL+'</span>');			
					charStr.append('	</div>');
					
					charStr.append('	<div class="stack_graph">');
					charStr.append('		<ul>');
					if(rsGrp2[i].Z_POINT_DIR == 'R'){
						charStr.append('			<li>');		
						//charStr.append('				<div class="ri_g bg_sky"  style=""></div>');
						charStr.append('				<div class="ri_g grp_blue" style=""></div>');
						charStr.append('			</li>');						
						charStr.append('			<li>');		
						//charStr.append('				<div class="le_g bg_sky" style="width:'+rsGrp1[i].Z_PER+'%"></div>');
						charStr.append('				<div class="le_g grp_blue" style="width:'+rsGrp2[i].Z_PER+'%"></div>');
						charStr.append('			</li>');
					}else if(rsGrp2[i].Z_POINT_DIR == 'L'){
						charStr.append('			<li>');		
						//charStr.append('				<div class="ri_g bg_sky"  style="width:'+rsGrp1[i].Z_PER+'%"></div>');
						charStr.append('				<div class="ri_g grp_blue" style="width:'+rsGrp2[i].Z_PER+'%"></div>');
						charStr.append('			</li>');						
						charStr.append('			<li>');		
						//charStr.append('				<div class="le_g bg_sky" style=""></div>');
						charStr.append('				<div class="le_g grp_blue" style=""></div>');
						charStr.append('			</li>');											
					}
					charStr.append('		</ul>');
					charStr.append('	</div>');							
				}			
			}			
			$("#divRsGrp2Color").text($("#EXAM_SN").val()+"차수");
		}
		obj.append(charStr.toString());		
	};
	
	//인지영역 결과표 조회
	function fn_rsTb1(data){
		
		var rsTb1 = data.rsTb1;		
		var charStr        = new StringBuffer();
		var obj = $("#tbodyRsTb1");
		var transGetPoint = 0;
		var transGetStdScore = 0;
		var transAllStdScore = 0;
		var transZPoint = 0;
		
		if(rsTb1 !=  null || rsTb1 != ''){
			if(rsTb1.length > 0){
				for(var i=0; i<rsTb1.length; i++){
					charStr.append('<tr>');
					charStr.append('	<td scope="row">'+rsTb1[i].AREA_NM+'</td>');
					charStr.append('	<td scope="row">'+rsTb1[i].TRANS_GET_POINT+'</td>');
					charStr.append('	<td scope="row">'+rsTb1[i].TRANS_GET_STD_SCORE+'/'+rsTb1[i].TRANS_ALL_STD_SCORE+'</td>');
					charStr.append('	<td scope="row">'+rsTb1[i].Z_POINT+'</td>');						
					charStr.append('</tr>');	
					
					transGetPoint       += rsTb1[i].TRANS_GET_POINT;
					transGetStdScore += rsTb1[i].TRANS_GET_STD_SCORE;
					transAllStdScore   += rsTb1[i].TRANS_ALL_STD_SCORE; 
					transZPoint          += rsTb1[i].Z_POINT; 

				}
			}
			obj.append(charStr.toString());	
			
			transZPoint = (transZPoint / rsTb1.length).toFixed(2);
			$("#rsGrp2GetPoint").text(transGetPoint);
			$("#rsGrp2StdPoint").text(transGetStdScore +'/'+ transAllStdScore);
			$("#rsGrp2ZPoint").text(transZPoint);			

		}	
	};
	
	//세부검사결과표 조회
	function fn_rsTb2(data){
		var rsTb2 = data.rsTb2;		
		var charStr        = new StringBuffer();
		var obj = $("#tbodyRsTb2");
		
		if(rsTb2 !=  null || rsTb2 != ''){
			if(rsTb2.length > 0){				
				for(var i=0; i<rsTb2.length; i++){
					charStr.append('<tr>');
					
					if(rsTb2[i].AREA_DTLS_NM != null){
						charStr.append('	<th scope="row" class="rsTb2First le_line" >'+rsTb2[i].AREA_NM+'</th>');						
						charStr.append('	<th scope="row" class="rsTb2Second le_line">'+rsTb2[i].AREA_DTLS_NM+'</th>');	
					}else{
						charStr.append('	<th scope="row" colspan="2" class="rsTb2First le_line" >'+rsTb2[i].AREA_NM+'</th>');								
						//charStr.append('	<th scope="row" class="rsTb2Second le_line"></th>');					
					}		
					
					if(rsTb2[i].RMK != null){
						charStr.append('	<td scope="row" class="le_line">'+rsTb2[i].EXAM_KEY_WORD+'<br/>'+rsTb2[i].RMK+'</td>');
					}else{
						charStr.append('	<td scope="row" class="le_line">'+rsTb2[i].EXAM_KEY_WORD+'</td>');						
					}	
					
					if(rsTb2[i].ORI_GET_DTLS_POINT != null){
						charStr.append('	<td scope="row" class="le_line">'+rsTb2[i].ORI_GET_POINT+'<br> '+rsTb2[i].ORI_GET_DTLS_POINT+ '</td>');
					}else{
						charStr.append('	<td scope="row" class="le_line">'+rsTb2[i].ORI_GET_POINT+ '</td>');	
					}					
					charStr.append('	<td scope="row">'+rsTb2[i].Z_POINT+'</td>');		
					charStr.append('	<td scope="row">'+rsTb2[i].TRANS_GET_POINT+'</td>');							
					charStr.append('</tr>');					
				}
			}
			obj.append(charStr.toString());	
		}	

		$(".rsTb2First").each(function() {
			  var rows = $(".rsTb2First:contains('" + $(this).text() + "')");
			  if (rows.length > 1) {
			    rows.eq(0).attr("rowspan", rows.length);
			    rows.not(":eq(0)").remove();
			  }
		});

		$(".rsTb2Second").each(function() {
			  var rows = $(".rsTb2Second:contains('" + $(this).text() + "')");

			  if (rows.length > 1) {
			    rows.eq(0).attr("rowspan", rows.length);
			    rows.not(":eq(0)").remove();
			  }
		});	
	};
	
	//누적검사 결과표 조회
	function fn_rsTb3(data){
		var rsTb3   = data.rsTb3;		
		var charStr = new StringBuffer();
		var obj = $("#tbodyRsTb3");
		
		if(rsTb3 !=  null || rsTb3 != ''){
			if(rsTb3.length > 0){				
				for(var i=0; i<rsTb3.length; i++){
					
					$("#tbodyRsTb3Dt1").text(YMDFormatter(rsTb3[0].EXAM_CMP_DATE_1));

					charStr.append('<tr>');
					charStr.append('	<th scope="row" class="rsTb3First">'+rsTb3[i].AREA_NM+'</th>');
					
					if(rsTb3[i].RMK != null){
						charStr.append('	<td class="le_line">'+rsTb3[i].EXAM_KEY_WORD_SHORT+'<br/>'+rsTb3[i].RMK+'</td>');
					}else{
						charStr.append('	<td class="le_line">'+rsTb3[i].EXAM_KEY_WORD_SHORT+'</td>');						
					}	
			
					charStr.append('	<td>'+rsTb3[i].POINT_1+'</td>');

					if(rsTb3[0].EXAM_YN_2 == 'Y' ){
						$("#tbodyRsTb3Dt2").text(YMDFormatter(rsTb3[0].EXAM_CMP_DATE_2));						
						charStr.append('	<td scope="row">'+rsTb3[i].POINT_2+'</td>');							
					}else{
						$("#tbodyRsTb3Dt3").text(YMDFormatter(rsTb3[0].EXAM_CMP_DATE_3));						
						charStr.append('	<td scope="row"></td>');									
					}
					
					if(rsTb3[0].EXAM_YN_3 == 'Y' ){
						charStr.append('	<td scope="row">'+rsTb3[i].POINT_3+'</td>');							
					}else{
						charStr.append('	<td scope="row"></td>');									
					}									
					charStr.append('</tr>');					
				}
			}
			obj.append(charStr.toString());	
		}	


		$(".rsTb3First").each(function() {
			  var rows = $(".rsTb3First:contains('" + $(this).text() + "')");
			  if (rows.length > 1) {
			    rows.eq(0).attr("rowspan", rows.length);
			    rows.not(":eq(0)").remove();
			  }
		});
	};
	
	$(document).on("click","#btnSaveComment",function(){
		saveComment();
	});	
	
	//상담 내용 저장
	function saveComment(){		
		var textAreaComment = $("#textAreaComment").val();
		
		//줄바꿈저장
		var EXAM_OPIN = $('#textAreaComment').val();
		EXAM_OPIN = EXAM_OPIN.replace(/(?:\r\n|\r|\n)/g, '<br/>');
		
		if(isNullToString(EXAM_OPIN)!=""){
			if(confirm("저장 하시겠습니까?")){
				cfn.ajax({
					  "url"			:	"/sv/updateTrgterExamLReportComment.do" 
					, "data"		:	{
										  "EXAM_OPIN"		: EXAM_OPIN
	 									, "EXAM_NO"		    : $("#EXAM_NO").val()
										, "R_NUMBER"		: $("#R_NUMBER").val()
										}
					, "dataType"	: 	"json"
					, "method"		:	"POST"
					, "success"		: 	successSave
					});
			}	
		}else{
			alert("평가내용을 입력해주세요");
			return false;
		}
	}
	
	//저장성공 시
	function successSave(){
		alert("저장되었습니다.");
		location.reload();		
	}

	//인쇄버튼 클릭 시 인쇄 팝업 호출
	function callPrintPop(){		
		var strFeature = "width=600,height=400";
		objWin = window.open("./sv/trgterExamLReportPrint.do?R_NUMBER="+$("#R_NUMBER").val()+"&EXAM_SN="+$("#EXAM_SN").val()+"&EXAM_DIV="+$("#EXAM_DIV").val()+"&EXAM_NO="+$("#EXAM_NO").val()+"", "출력", strFeature);
	}
	
</script>
	<form>
		<input type="hidden" id="R_NUMBER" name="R_NUMBER"/>
		<input type="hidden" id="EXAM_SN" name="EXAM_SN" />
		<input type="hidden" id="EXAM_DIV" name="EXAM_DIV" />		
		<input type="hidden" id="EXAM_NO" name="EXAM_NO" />	
		<input type="hidden" id="menuCd" name="menuCd" />
		<input type="hidden" id="MENU_URL" name="MENU_URL" />	
	</form>

	<div class="page">
		<section>
			<ul class="title_align">
				<li><h1>LINDA검사결과지(문맹에도 적용 가능한  치매인지기능검사)</h1></li>
				<li><a href="#" class="btn_all blue btn_print" onclick="callPrintPop();">인쇄</a></li>
			</ul>
			<table class="table_type print topb mt15">
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="20%">
					<col width="30%">
				</colgroup>
				<tbody id="tbodyRsTrgt">
					<tr>
						<th scope="col">이름</th>
						<td id="name"></td>
						<th scope="col">차트번호</th>
						<td id="rNumber"></td>
					</tr>
					<tr>
						<th scope="col">만 나이(생일)</th>
						<td id="birth"></td>
						<th scope="col">검사기관</th>
						<td id="orgNm"></td>
					</tr>
					<tr>
						<th scope="col">성별</th>
						<td id="gender"></td>
						<th scope="col">의뢰의(과)</th>
						<td id="orgPart"></td>
					</tr>
					<tr>
						<th scope="col">교육년수</th>
						<td id="eduYear"></td>
						<th scope="col">검사일</th>
						<td id="examCmpDate"></td>
					</tr>
					<tr>
						<th scope="col">손잡이</th>
						<td id="handCd"></td>
						<th scope="col">검사차수</th>
						<td id="examSn"></td>
					</tr>
					<tr>
						<th scope="col">보호자(동거여부)</th>
						<td id="inmate"></td>
						<th scope="col">검사자</th>
						<td id="userNm"></td>
					</tr>
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
				<tbody id="tbodyIll">
					<tr>
						<td class="le_line">쓰기</td>
						<td id="inWrite"></td>
						<td id="inRead"></td>
						<td rowspan = 2 id="divYn"></td>
					</tr>
					<tr>
						<td class="le_line">읽기</td>
						<td id="paWrite">7(1.34)</td>
						<td id="paRead"></td>
					</tr>										
				</tbody>
			</table>
		</section>						

		<section class="mt35">
			<h2>종합결과</h2>
			<h3 class="mt10">- 인지 영역 그래프</h3>
			<div class="greap_board_box">			
				<div class="graph_area lica">
					<ul class="bar_graph_box"  id="divRsGrp1">
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
						<li id="divRsGrp1Color">
						</li>
					</ul>					
				</div>					
			</div>
		</section>

		<section class="mt10">
			<h3>- 기억력 그래프</h3>
			<div class="greap_board_box" style="height:380px;">
				
				<div class="graph_area">
					<ul class="bar_graph_box" id="divRsGrp2" style="height:300px;">
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
						<li id="divRsGrp2Color"></li>
					</ul>
				</div>

			</div>
		</section>

		<section class="mt10">
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
				<tbody id="tbodyRsTb1">
				</tbody>
					
				<tfoot>
					<tr>
						<th scope="row">총점</th>
						<td id="rsGrp2GetPoint"></td>
						<td id="rsGrp2StdPoint"></td>
						<td id="rsGrp2ZPoint"></td>
					</tr>
				</tfoot>
			</table>
		</section>

		

		<section class="mt35">
			<h2> 세부 검사 결과표</h2>
			<table class="table_type print topb mt15">
				<colgroup>
					<col width="12%">
					<col width="15%">					
					<col width="*%">
					<col width="17%">
					<col width="12%">
					<col width="14%">
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
				<tbody id="tbodyRsTb2">					
				</tbody>
			</table>
		</section>
		
		<section class="mt35">
			<h2> 누적 검사 결과표</h2>
			<table class="table_type print topb mt15">
				<colgroup>
					<col width="20%">
					<col width="*%">
					<col width="16%">
					<col width="16%">
					<col width="16%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">인지영역</th>
						<th scope="col">검사(총점)</th>
						<th scope="col" id="tbodyRsTb3Dt1"></th>
						<th scope="col" id="tbodyRsTb3Dt2"></th>
						<th scope="col" id="tbodyRsTb3Dt3"></th>
					</tr>
				</thead>
				<tbody id="tbodyRsTb3">			
				</tbody>
			</table>
		</section>
		
		<section class="mt35">
			<h2>평가 종합 소견</h2>
			<textarea placeholder="종합 평가 소견 내용 작성" style="height:300px" class="mt10 ChkByte" id="textAreaComment" onkeyup="fnChkByte(this);"></textarea>
		</section>
		<div class="btnright mt10">
			<a href="#" class="btn_all col01"  id="btnSaveComment">저장</a>
		</div>
	</div>
