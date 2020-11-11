<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>

	$(document).ready(function(){
		mkSelect_insExamId();
				
		//달력 오늘값 셋팅
		$("#reqExamDate").val(new Date().toISOString().substring(0, 10));
		
		var count = (RNUMS.match(/,/g) || []).length + 0;
		var infoCount = ""
		if(count == 0){
			infoCount = "검사대상자 : " + NAME + " 님";
		}else{
			infoCount = "검사대상자 : " + NAME + " 님 외 " + count + "명";
		}
		$("#infoCount").append(infoCount);
	});
	
	//검사자 셀렉트박스 생성
	function mkSelect_insExamId(){
		cfn.ajax({
			   "url" : "/tg/selectInsExamInfo.do"
			 , "method" : "POST"
			 , "data" : {
				 			"orgCd" : "${SESS_ORG_CD}"
			 } 
			 , "dataType" : "JSON"
			 , "success" : function(data){
				//콤보박스 제작
				var oCmb = $("#insExamId")
				oCmb.empty();
				for (var i = 0; i < data.rsList.length; i++){
					oCmb.append("<option value='" + isNullToString(""+data.rsList[i].USER_ID) + "'>" + data.rsList[i].USER_NM + "(" + data.rsList[i].TEL_NO_1 + "-" + data.rsList[i].TEL_NO_2 + "-" + data.rsList[i].TEL_NO_3 + ")</option>");
				}
			 }
			 , "error" : function(data){
				alert("통신실패");
			 }
		});
	}
	
</script>

<!-- 검사의뢰 -->
<div id="reqExamPopup" class="layer-wrap" style="display:inline;">
	<div class="pop-layer wid800" style="margin-left:35%;">
		<ul class="pop_title_ul_box">
			<li><h2>검사의뢰</h2></li>
			<li>
				<a href="#" class="btn-layerClose modalHide">Close</a>
			</li>
		</ul>
		<div class="pop_input_box01">
			<table class="table_type dis topb">
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="20%">
					<col width="30%">
				</colgroup>
				<tbody>
					<tr>			
						<th scope="col">검사종류</th>
						<td colspan="3">
							<input type="radio" name="examDiv" id="LINDA" value="L"><label for="L">LINDA</label>
							<input type="radio" name="examDiv" id="SLINDA" value="S"><label for="S">S-LINDA</label>
							<input type="radio" name="examDiv" id="MMSEDS" value="M"><label for="M">MMSE-DS</label>
						</td>
					</tr>
					<tr>			
						<th scope="col">검사기관</th>
						<td><input type="text" id="examOrgNm" value=${SESS_ORG_NM} style="width:100%" disabled></td>
						<input type="hidden" id="examOrgCd" value=${SESS_ORG_CD} disabled>
						<th scope="col">검사의뢰자</th>
						<td><input type="text" value=${SESS_USER_NM} id="reqExamNm" style="width:100%" disabled></td>
						<input type="hidden" id="reqExamId" value=${SESS_USER_ID} disabled>
					</tr>
					<tr>			
						<th scope="col">검사요청일</th>
						<td><input type="text" id="reqExamDate" style="width:100%" readonly></td>
						<th scope="col">검사자</th>
						<td><select id="insExamId" style="width:100%"></select></td>
					</tr>
					<tr>
						<th>검사 구분</th>
						<td><select id="onoff" style="width:100%"><option value="온라인 검사" selected>온라인 검사</option><option value="오프라인 검사">오프라인 검사</option></select></td>
						<th>데이터</th>
						<td><select id="testcheck" style="width:100%"><option value="진짜 데이터" selected>진짜 데이터</option><option value="테스트 데이터">테스트 데이터</option></select></td>
					</tr>
					<tr>			
						<th scope="col">메모</th>
						<td colspan="3"><textarea id="memo"></textarea></td>
					</tr>
				</tbody>
			</table>

			<div class="pop_group_box">
				<span id="infoCount"></span>
			</div>

			<div class="btncenter">
				<a href="#" class="btn_all col01" onclick="reqExam();">검사의뢰</a> <a href="#" class="btn_all modalHide">취소</a>  
			</div>
		</div>
	</div>
</div>