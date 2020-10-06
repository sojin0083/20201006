<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
	
$(document).ready(function(){
	
	searchCmmnCd("#trgterEduYear","CM011","","","");//성별
	
	reqExamLoad();
}); 
 
function reqExamLoad(){
	
	var R_NUM = "${R_NUMBER}";
	
	cfn.ajax({
		   "url" : "/sv/reqExamSet.do"
		 , "data" : {
		 	"R_NUMBER" : R_NUM
		 }
		 , "method" : "POST"
		 , "dataType" : "JSON"
		 , "success" : function(data){
			 trgterInfo(data.rsInfo);
			 reqExamInfo(data.rsVal);
			 cntExam(data.rsCnt)
			 examRecList(data.rsList);
		 }
		 , "error" : function(data){
			alert("통신실패");
		 }
	});
}

//대상자 정보
function trgterInfo(result){
	$("#trgterName").val(result.NAME);
	$("#bTrgterBirth").val(result.BIRTH);
	$('input:radio[name=trgterDivBirth]:input[value=' + result.DIV_BIRTH + ']').attr("checked", true);
	$("#age").val(result.AGE);
	$("#Rnumber").val(result.C_NUMBER);
	$('input:radio[name=trgterGender]:input[value=' + result.GENDER + ']').attr("checked", true);
	$("#trgterEduYear").val(result.EDU_YEAR);
	$('input:radio[name=trgterHandCd]:input[value=' + result.HAND_CD + ']').attr("checked", true);
	$("#trgterInmateName").val(result.INMATE_NAME);
	$('input:radio[name=trgterInmateYn]:input[value=' + result.INMATE_YN + ']').attr("checked", true);
}

//검사의뢰내역
function reqExamInfo(result){

	var str = "";
	
	for(var i=0; i<result.length; i++){
		str += "<tr>"
		str += "<th scope='col'>검사진행현황</th>"
		str += "<th scope='col'>검사요청일</th>"
		str += "<td>" + result[i].EXAM_REQ_DATE + "</td>"
		str += "<th scope='col'>검사차수</th>"
		str += "<td>" + result[i].EXAM_SN + "차</td>"
		str += "</tr>"
		str += "<tr>"
		str += "<td rowspan='3' class='td_center'>" + result[i].EXAM_DIV_NM + " " + result[i].EXAM_STTUS + "중</td>"
		str += "<th scope='col'>검사기관</th>"
		str += "<td>" + result[i].ORG_NM + "</td>"
		str += "<th scope='col'>검사의뢰자</th>"
		str += "<td>" + result[i].EXAM_REQ_NM + "</td>"
		str += "</tr>"
		str += "<tr>"
		str += "<th scope='col' class='line'>검사자</th>"
		str += "<td>" + result[i].EXAM_INS_NM + "</td>"
		str += "<th scope='col'></th>"
		str += "<td></td>"
		str += "</tr>"
		str += "<tr>"
		str += "<th scope='col' class='line'>메모</th>"
		str += "<td colspan='3'>" + isNullToString(result[i].MEMO) + "</td>"
		str += "</tr>"
	}		
	
	$("#reqExamInfo").append(str);
}
	
//검사횟수
function cntExam(result){
	$("#cntL").html("LINDA : " + result.L);
	$("#cntS").html("SLINDA : " + result.S);
	$("#cntM").html("MMSE : " + result.M);
}

//검사이력리스트
function examRecList(result){
	
	var lExamStr = "";
	var sExamStr = "";
	var mExamStr = "";
	
	for(var i=0; i<result.length; i++){
		if(result[i].EXAM_DIV == "L"){
			lExamStr += "<tr>";
			lExamStr += "<td scope='row'>"+ result[i].EXAM_CMP_DATE +"</td>";
			lExamStr += "<td>"+ result[i].EXAM_SN +"</td>";
			lExamStr += "<td>"+ result[i].TOT_POINT +"</td>";
			lExamStr += "<td>"+ result[i].L01 +"</td>";
			lExamStr += "<td>"+ result[i].L02 +"</td>";
			lExamStr += "<td>"+ result[i].L03 +"</td>";
			lExamStr += "<td>"+ result[i].L04 +"</td>";
			lExamStr += "<td>"+ result[i].L05 +"</td>";
			lExamStr += "<td>"+ result[i].L06 +"</td>";
			lExamStr += "<td>"+ result[i].L07 +"</td>";
			lExamStr += "<td>"+ result[i].L08 +"</td>";
			lExamStr += "<td>"+ result[i].L09 +"</td>";
			lExamStr += "<td>"+ result[i].L10 +"</td>";
			lExamStr += "<td>"+ result[i].L11 +"</td>";
			lExamStr += "<td>"+ result[i].L12 +"</td>";
			lExamStr += "<td>"+ result[i].L13 +"</td>";
			lExamStr += "<td>"+ result[i].L14 +"</td>";
			lExamStr += "</tr>";
		}else if(result[i].EXAM_DIV == "S"){
			sExamStr += "<tr>";
			sExamStr += "<td scope='row'>"+ result[i].EXAM_CMP_DATE +"</td>";
			sExamStr += "<td>"+ result[i].EXAM_SN +"</td>";
			sExamStr += "<td>"+ result[i].TOT_POINT +"</td>";
			sExamStr += "<td>"+ result[i].S01 +"</td>";
			sExamStr += "<td>"+ result[i].S02 +"</td>";
			sExamStr += "<td>"+ result[i].S03 +"</td>";
			sExamStr += "<td>"+ result[i].S04 +"</td>";
			sExamStr += "<td>"+ result[i].S05 +"</td>";
			sExamStr += "<td>"+ result[i].S06 +"</td>";
			sExamStr += "<td>"+ result[i].S07 +"</td>";
			sExamStr += "<td>"+ result[i].S08 +"</td>";
			sExamStr += "<td>"+ result[i].S09 +"</td>";
			sExamStr += "</tr>";
		}else if(result[i].EXAM_DIV == "M"){
			mExamStr += "<tr>";
			mExamStr += "<td scope='row'>"+ result[i].EXAM_CMP_DATE +"</td>";
			mExamStr += "<td>"+ result[i].EXAM_SN +"</td>";
			mExamStr += "<td>"+ result[i].TOT_POINT +"</td>";
			mExamStr += "<td>"+ result[i].M01 +"</td>";
			mExamStr += "<td>"+ result[i].M02 +"</td>";
			mExamStr += "<td>"+ result[i].M03 +"</td>";
			mExamStr += "<td>"+ result[i].M04 +"</td>";
			mExamStr += "<td>"+ result[i].M05 +"</td>";
			mExamStr += "<td>"+ result[i].M06 +"</td>";
			mExamStr += "<td>"+ result[i].M07 +"</td>";
			mExamStr += "<td>"+ result[i].M08 +"</td>";
			mExamStr += "<td>"+ result[i].M09 +"</td>";
			mExamStr += "<td>"+ result[i].M10 +"</td>";
			mExamStr += "<td>"+ result[i].M11 +"</td>";
			mExamStr += "<td>"+ result[i].M12 +"</td>";
			mExamStr += "<td>"+ result[i].M13 +"</td>";
			mExamStr += "<td>"+ result[i].M14 +"</td>";
			mExamStr += "<td>"+ result[i].M15 +"</td>";
			mExamStr += "<td>"+ result[i].M16 +"</td>";
			mExamStr += "<td>"+ result[i].M17 +"</td>";
			mExamStr += "<td>"+ result[i].M18 +"</td>";
			mExamStr += "<td>"+ result[i].M19 +"</td>";
			mExamStr += "</tr>";
		}
	}
	
	if(lExamStr == ""){
		lExamStr += "<tr>"
		lExamStr += "<td colspan='17'>진행된 검사이력이 존재하지 않습니다.</td>"
		lExamStr += "</tr>"
	}
	
	if(sExamStr == ""){
		sExamStr += "<tr>"
		sExamStr += "<td colspan='12'>진행된 검사이력이 존재하지 않습니다.</td>"
		sExamStr += "</tr>"
	}
	
	if(mExamStr == ""){
		mExamStr += "<tr>"
		mExamStr += "<td colspan='23'>진행된 검사이력이 존재하지 않습니다.</td>"
		mExamStr += "</tr>"
	}
	
	$("#ExamRecLList").append(lExamStr);
	$("#ExamRecSList").append(sExamStr);
	$("#ExamRecMList").append(mExamStr);
}

//검사의뢰 목록으로 이동
function fn_reqExamPage(){
	window.location.href = "/alExam/pageNavi.do?menuCd=NSV100";
}


//탭변환
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
<!-- 인적사항 -->
<section>
	<div class="btnright"><a href="#" onclick="fn_reqExamPage()" class="btn_all col01">목록</a></div>
	<h2>인적사항</h2>
	<input type="hidden" id="TrgterBirth" name="TrgterBirth" />
	<table class="table_type dis topb">
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="20%">
			<col width="30%">
		</colgroup>
		<tbody>
			<tr>			
				<th scope="col">이름</th>
				<td><input type="text" value="" id="trgterName" style="width:100%" disabled></td>
				<th scope="col">차트번호</th>
				<td><input type="text" value="" id="Rnumber" style="width:100%" disabled></td>
			</tr>
			<tr>			
				<th scope="col">생년월일</th>
				<td colspan="3">
					<ul>
						<li><input type="text" value="" id="bTrgterBirth" style="width:150px" disabled></li>
						<li>
							<input type="radio" name="trgterDivBirth" value="1" disabled><label for="ar1">양력</label> 
							<input type="radio" name="trgterDivBirth" value="2" disabled><label for="ar2">음력</label>
						</li>
						<li>만 <input type="text" value="" id="age" style="width:30px" disabled> 세</li>
					</ul>
				</td>
			</tr>
			<tr>			
				<th scope="col">성별</th>
				<td colspan="3">
					<input type="radio" name="trgterGender" value="M" disabled><label for="m">남</label>
					<input type="radio" name="trgterGender" value="F" disabled><label for="f">여</label>
				</td>
			</tr>
			<tr>			
				<th scope="col">손잡이</th>
				<td>
					<input type="radio" name="trgterHandCd" value="R" disabled><label for="r">오른손</label> 
					<input type="radio" name="trgterHandCd" value="L" disabled><label for="l">왼손</label>
					<input type="radio" name="trgterHandCd" value="B" disabled><label for="rl">양손</label>
				</td>
				<th scope="col">교육년수</th>
				<td>
					<select id="trgterEduYear" style="width:100%" disabled>
					</select>
				</td>
			</tr>
			<tr>			
				<th scope="col">보호자명</th>
				<td><input type="text" id="trgterInmateName" style="width:100%" disabled></td>
				<th scope="col">보호자동거여부</th>
				<td>
					<input type="radio" name="trgterInmateYn" value="Y" disabled><label for="o">동거</label>
					<input type="radio" name="trgterInmateYn" value="N" disabled><label for="n">비동거</label>
				</td>
			</tr>
		</tbody>
	</table>
</section>
<!-- //인적사항 -->


<!-- 검사의뢰내역 -->
<section class="mt35">
	<h2>검사의뢰내역</h2>
	<table class="table_type topb bg_grey">
		<colgroup>
			<col width="*">
			<col width="16%">
			<col width="16%">
			<col width="16%">
			<col width="*">
		</colgroup>
		<tbody id="reqExamInfo">
			
		</tbody>
	</table>
</section>
<!-- //검사의뢰내역 -->
	
<!-- 검사이력 -->
<section class="mt35">
	<h2>검사이력</h2>
	<div class="tab_box">
		<ul class="tab">
			<li class="current" data-tab="tab1"><a href="#" id="cntL"></a></li>
			<li data-tab="tab2"><a href="#" id="cntS"></a></li>
			<li data-tab="tab3"><a href="#" id="cntM"></a></li>
		</ul>

		<div id="tab1" class="tabcontent current">
			<table class="boardlist topb">
				<caption>검사결과목록</caption>
				<colgroup>
					<col width="10%">
					<col width="8%">
					<col width="7%">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">검사완료일</th>
						<th scope="col">검사차수</th>
						<th scope="col">총 점수</th>
						<th scope="col">비문해</th>
						<th scope="col">1번</th>
						<th scope="col">2번</th>
						<th scope="col">3번</th>
						<th scope="col">4번</th>
						<th scope="col">5번</th>
						<th scope="col">6번</th>
						<th scope="col">7번</th>
						<th scope="col">8번</th>
						<th scope="col">9번</th>
						<th scope="col">10번</th>
						<th scope="col">11번</th>
						<th scope="col">12번</th>
						<th scope="col">13번</th>
					</tr>
				</thead>
				<tbody id = "ExamRecLList">
				</tbody>
			</table>
		</div>

		<div id="tab2" class="tabcontent">
			<table class="boardlist topb">
				<caption>검사결과목록</caption>
				<colgroup>
					<col width="10%">
					<col width="8%">
					<col width="7%">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">검사완료일</th>
						<th scope="col">검사차수</th>
						<th scope="col">총 점수</th>
						<th scope="col">비문해</th>
						<th scope="col">1번</th>
						<th scope="col">2번</th>
						<th scope="col">3번</th>
						<th scope="col">4번</th>
						<th scope="col">5번</th>
						<th scope="col">6번</th>
						<th scope="col">7번</th>
						<th scope="col">8번</th>
					</tr>
				</thead>
				<tbody id = "ExamRecSList">
				</tbody>
			</table>
		</div>

		<div id="tab3" class="tabcontent">
			<table class="boardlist topb">
				<caption>검사결과목록</caption>
				<colgroup>
					<col width="10%">
					<col width="8%">
					<col width="7%">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">검사완료일</th>
						<th scope="col">검사차수</th>
						<th scope="col">총 점수</th>
						<th scope="col">1번</th>
						<th scope="col">2번</th>
						<th scope="col">3번</th>
						<th scope="col">4번</th>
						<th scope="col">5번</th>
						<th scope="col">6번</th>
						<th scope="col">7번</th>
						<th scope="col">8번</th>
						<th scope="col">9번</th>
						<th scope="col">10번</th>
						<th scope="col">11번</th>
						<th scope="col">12번</th>
						<th scope="col">13번</th>
						<th scope="col">14번</th>
						<th scope="col">15번</th>
						<th scope="col">16번</th>
						<th scope="col">17번</th>
						<th scope="col">18번</th>
						<th scope="col">19번</th>
					</tr>
				</thead>
				<tbody id="ExamRecMList">
				</tbody>
			</table>
		</div>
	</div>
</section>
<!-- //검사이력 -->
</html>