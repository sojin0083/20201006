<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

var EXAM_NO = "${EXAM_NO}";
var R_NUMBER = "${R_NUMBER}";


	$(document).ready(function(){
		getTrgterExamMReport();
	});
	
	//검사결과지 가저오기
	function getTrgterExamMReport(){

		cfn.ajax({
			   "url" : "/sv/getTrgterExamMReport.do"
			 , "data" : {
				 			 "EXAM_NO" 		: EXAM_NO
				 			,"R_NUMBER"		: R_NUMBER
			 } 
			 , "method" : "POST"
			 , "dataType" : "JSON"
			 , "success" : function(data){
				setTrgterMExamInfo(data.rsInfo);
				setTrgterMExamReport(data.rsList);
			 }
			 , "error" : function(data){
				alert("통신실패");
			 }
		});
	}
	
	//인적사항
	function setTrgterMExamInfo(data){
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
		$("#trgterMExamInfo").append(str);
	}
	//검사내용
	function setTrgterMExamReport(data){
		
		for(var i=0; i<data.length; i++){
			var id = data[i].EXAM_ITEM_CD + data[i].EXAM_ITEM_CD_DTLS
			$("#" + id).html(data[i].POINT);
		}
		$("#totPoint").html(data[0].TOT_POINT + "/30");
	}
	
	function callPrintPop(){
		var strFeature = "width=600,height=400";
		objWin = window.open("./sv/trgterExamMReportPrint.do?R_NUMBER="+R_NUMBER+"&EXAM_NO="+EXAM_NO+"", "출력", strFeature);
	}
	
</script>

<div class="page">
	<div class="subpage">
		<section>
			<ul class="title_align">
				<li><h1>MMSE-DS 결과지</h1></li>
				<li><a href="#" class="btn_all blue btn_print" onclick="callPrintPop();">인쇄</a></li>
			</ul>
			<table class="table_type print topb mt15">
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="20%">
					<col width="30%">
				</colgroup>
				<tbody id="trgterMExamInfo">				
				</tbody>
			</table>
		</section>

		<section class="mt35">
			<h2> 세부 검사 결과표</h2>		
			<table class="boardlist td_left topb">
				<caption>항목별 세부정보안내</caption>
				<colgroup>
					<col width="18%">
					<col width="10%">
					<col width="18%">
					<col width="*">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">대분류</th>
						<th scope="col">점수</th>
						<th scope="col">소분류</th>
						<th scope="col">문항</th>
						<th scope="col">점수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="10">지남력</td>
						<td class="t_al_ct">1</td>
						<td rowspan="5">시간</td>
						<td>올해는 몇년도 입니까?</td>
						<td id="M011101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>지금은 무슨 계절 입니까?</td>
						<td id="M021101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>오늘은 며칠 입니까?</td>
						<td id="M031101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>오늘은 무슨 요일 입니까?</td>
						<td id="M041101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>지금은 몇 월 입니까?</td>
						<td id="M051101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td rowspan="5">장소</td>
						<td>우리가 있는 이곳은 무슨 광역시 입니까?</td>
						<td id="M061101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>여기는 무슨 구 입니까?</td>
						<td id="M071101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>여기는 무슨 동 입니까?</td>
						<td id="M081101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>우리는 지금 이 건물의 몇 층에 있습니까?</td>
						<td id="M091101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>이 장소의 이름은 무엇입니까?</td>
						<td id="M101101"></td>
					</tr>
					<tr>
						<td rowspan="6">기억력</td>
						<td  class="t_al_ct">1</td>
						<td rowspan="3">기억등록</td>
						<td>세 가지 단어 즉시 기억하기(나무)</td>
						<td id="M111101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>세 가지 단어 즉시 기억하기(자동차)</td>
						<td id="M111102"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>세 가지 단어 즉시 기억하기(모자)</td>
						<td id="M111103"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td rowspan="3">기억회상</td>
						<td>조금전에 말했던 단어를 다시 말해주세요.(나무)</td>
						<td id="M121101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>조금전에 말했던 단어를 다시 말해주세요.(자동차)</td>
						<td id="M121102"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						
						<td>조금전에 말했던 단어를 다시 말해주세요.(모자)</td>
						<td id="M121103"></td>
					</tr>
					<tr>
						<td rowspan="5">주위집중 및 계산</td>
						<td class="t_al_ct">1</td>
						<td rowspan="5">수리력</td>
						<td>"100에서 7을 빼면 얼마가 됩니까?(1회)"</td>
						<td id="M131101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>"거기에서 7을 빼면 얼마가 됩니까?(2회)"</td>
						<td id="M131102"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>"거기에서 7을 빼면 얼마가 됩니까?(3회)"</td>
						<td id="M131103"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>"거기에서 7을 빼면 얼마가 됩니까?(4회)"</td>
						<td id="M131104"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>"거기에서 7을 빼면 얼마가 됩니까?(5회)"</td>
						<td id="M131105"></td>
					</tr>			
					<tr>
						<td rowspan="7">언어기능</td>
						<td class="t_al_ct">1</td>
						<td rowspan="2">이름 맞추기</td>
						<td>이것을 무엇이라고 합니까?(시계)</td>
						<td id="M141101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>이것을 무엇이라고 합니까?(연필)</td>
						<td id="M141102"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td rowspan="3">3단계 명령</td>
						<td>"제가 지금 말하는걸 말씀드린대로 해보세요"<br>"오른손으로 종이를받아서"</td>
						<td id="M151101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>"제가 지금 말하는걸 말씀드린대로 해보세요"<br>"반으로 접어서"</td>
						<td id="M151102"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>"제가 지금 말하는걸 말씀드린대로 해보세요"<br>"무릎 위에 올려주세요."</td>
						<td id="M151103"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>복사</td>
						<td>오각형 두개 겹쳐 그리기</td>
						<td id="M161101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>반복</td>
						<td>"간장 공장 공장장" 따라하기</td>
						<td id="M171101"></td>
					</tr>
					<tr>
						<td rowspan="2">이해 및 판단</td>
						<td  class="t_al_ct">1</td>
						<td>이해</td>
						<td>"옷을 왜 빨아서 입습니까?"</td>
						<td id="M181101"></td>
					</tr>
					<tr>
						<td class="bll_d">1</td>
						<td>판단</td>
						<td>"티끌 모아 태산은 무슨 뜻입니까?"</td>
						<td id="M191101"></td>
					</tr>
					<tr style="color:#7a7a7a;background:#fdfdfd;font-weight: bold;box-sizing: border-box;">
						<td>전체 총점</td>
						<td colspan="4" id="totPoint"></td>
					</tr>
				</tbody>
			</table>
		</section>					
	</div>
</div>				