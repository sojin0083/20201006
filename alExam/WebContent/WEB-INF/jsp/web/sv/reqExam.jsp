<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var pageStatus = "new"//페이지 처음불러올때 검색조건입력을 위한 변수

	$(document).ready(function() {

		//달력
		$('.sDate').val(getDateShift("", 'M', -5, "YYYY-MM-DD"));
		$('.eDate').val(setDateFormat("", "YYYY-MM-DD"));
		datePickerFn();

		//셀렉트박스
		searchCmmnCd("#gender", "CM002", "", "", "전체|null");//성별
		searchCmmnCd("#ageGroup", "CM008", "", "", "전체|null");//연령대
		searchCmmnCd("#examDiv", "SV001", "", "", "전체|null");//성별
		searchCmmnCd("#examSttus", "SV002", "", "01", "전체|null");//진행상태
		searchCmmnCd("#examSn", "SV005", "", "", "전체|null");//검사차수
		searchCmmnCd(".trgter_exam","SV001","","","전체|null");//검사종류

		//리스트 불러오기
		reqExamList();
	});

	function passwdKeypress(e) {
		if (e.keyCode == 13) {
			reqExamList();
		}
	}

	//리스트조회
	function reqExamList() {
		$("#reqExamList").empty();
		var examSttus = ""

		if (pageStatus == "new") {
			examSttus = "01"
		} else {
			examSttus = $("#examSttus").val()
		}

		cfn.ajax({
			"url" : "/sv/reqExamList.do",
			"data" : {
				"sDate" : $("#sDate").val().replace(/-/gi, ""),
				"eDate" : $("#eDate").val().replace(/-/gi, ""),
				"examSn" : $("#examSn").val(),
				"idValue" : $("#idValue").val(),
				"gender" : $("#gender").val(),
				"ageGroup" : $("#ageGroup").val(),
				"examDiv" : $("#examDiv").val(),
				"examSttus" : examSttus
			},
			"method" : "POST",
			"dataType" : "JSON",
			"success" : function(data) {
				loadRegExamList(data);
			},
			"error" : function(data) {
				alert("통신실패");
			}
		});

		pageStatus = "old"
	}

	//불러온리스트 그리기
	function loadRegExamList(data) {

		var str = "";

		if (data.rsList.length == 0) {
			str += "<tr class='regExamList2'>";
			str += "<td colspan='8'>등록된 대상자가 없습니다.</td>";
			str += "</tr>";
		}

		if (isNullToString(data.rsList) != "") {

			var examSttusColor = ""

			for (var i = 0; i < data.rsList.length; i++) {
				if (data.rsList[i].EXAM_STTUS == "01") {
					examSttusColor = "orange";
				} else if (data.rsList[i].EXAM_STTUS == "02") {
					examSttusColor = "green";
				} else {
					examSttusColor = "grey";
				}

				/* str += "<tr class='regExamList' onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>"; */
				str += "<tr class='regExamList'>";
				str += "<td style='display:none;' onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].R_NUMBER + "</td>";
				str += "<td onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].EXAM_REQ_DATE + "</td>";
				str += "<td onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].NAME + "</td>";
				str += "<td onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].EXAM_SN + "</td>";
				if (data.rsList[i].C_NUMBER == undefined) {str += "<td onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>-</td>";
				} else { str += "<td onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].C_NUMBER + "</td>";}
				str += "<td onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].GENDER + "</td>";
				str += "<td onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].AGE + "</td>";
				str += "<td onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].EXAM_DIV_NM + "</td>";
				str += "<td style='display:none;' onclick='fn_ReqExamDetail(\"" + data.rsList[i].R_NUMBER + "\")'>" + data.rsList[i].EXAM_DIVV + "</td>";
				str += "<td class='"+ examSttusColor +"'>" + data.rsList[i].EXAM_STTUS_NM + "</td>";
				str += "<td style='text-algin:center;   display:none;' class='userReq'>" + data.rsList[i].EXAM_NO + "</td>";
				if (data.rsList[i].EXAM_STTUS == "01") {str += "<td style='cursor:Default;' onclick='event.cancelBubble=true'><a class='btn_style cursor:pointer;' onclick='fn_DeleteExam(\""+ data.rsList[i].R_NUMBER+ "\",\""+ data.rsList[i].NAME+ "\",\""+ data.rsList[i].EXAM_SN+ "\",\""+ data.rsList[i].EXAM_DIV_NM+ "\",\""+ data.rsList[i].EXAM_NO + "\")'>의뢰취소</a></td>";
				} else {str += "<td style='cursor:Default;padding:13px 0;color:red;font-size:12px' onclick='event.cancelBubble=true'>취소불가</td>";}
				str += "<td class = 'fn_InsertExam'><a class='btn_style'>결과입력</a></td>";
				str += "</tr>";
			}
		}

		$("#reqExamList").append(str);
		fn_commonPagination(".regExamList", ".paginate", 10, "regExamPageOp");
	}

	
	$(document).on("click","td.fn_InsertExam",function(){
		var R_Number  = $(this).parent().children().eq(0).text();
		var Exam_Sn   = $(this).parent().children().eq(3).text();
		var Exam_DIVV = $(this).parent().children().eq(8).text();
		var Exam_No   = $(this).parent().children().eq(10).text();
		$("#EXAM_NO").val(Exam_No);
		$("#R_NUMBER").val(R_Number);
		$("#EXAM_SN").val(Exam_Sn);
		$("#EXAM_DIV").val(Exam_DIVV); 
		$("#menuCd").val("${menuInfo.MENU_CD}");
	    $("#MENU_URL").val("/sv/trgterExamLReportResultInsertPage.do");
		$("#userInfoForm").attr("action", "/alExam/pageNavi.do");	
		$("#userInfoForm").submit();
	});	
	

 	//상세이동
	function fn_ReqExamDetail(RNUM) {
		var Exam_No   = $(this).parent().children().eq(10).text();
		var Exam_Sn   = $(this).parent().children().eq(3).text();
		var Exam_DIVV = $(this).parent().children().eq(8).text();
		$("#EXAM_NO").val(Exam_No);
		$("#R_NUMBER").val(RNUM);
		$("#EXAM_SN").val(Exam_Sn);
		$("#EXAM_DIV").val(Exam_DIVV);
		$("#menuCd").val("${menuInfo.MENU_CD}");
		$("#MENU_URL").val("/sv/reqExamDetailPage.do");
		$("#userInfoForm").attr("action", "/alExam/pageNavi.do");
		$("#userInfoForm").submit();
	}


	//검사의뢰취소(삭제)
	function fn_DeleteExam(RNUM, NAME, SN, DIVNM, EXAM_NO) {
		var deleteConfirm = confirm(NAME + " 님의 " + SN + "차 " + DIVNM
				+ " 검사의뢰를 취소하시겠습니까?");
		if (deleteConfirm) {
			cfn.ajax({
				"url" : "/sv/deleteExam.do",
				"data" : {
					"EXAM_NO" : EXAM_NO
				},
				"method" : "POST",
				"dataType" : "JSON",
				"success" : function(data) {
					if (data.rsInt != 0) {
						alert("삭제되었습니다.");
						reqExamList();
					} else {
						alert("검사의뢰취소중 문제가 발생하였습니다.\n관리자에게 문의하세요");
					}
				},
				"error" : function(data) {
					alert("통신실패");
				}
			});
		} else {
			return;
		}
	}
</script>

<form id="userInfoForm" method="POST" style="">
	<input type="hidden" id="R_NUMBER" name="R_NUMBER" />
	<input type="hidden" id="EXAM_SN" name="EXAM_SN" />
	<input type="hidden" id="EXAM_DIV" name="EXAM_DIV" /> 
	<input type="hidden" id="EXAM_NO" name="EXAM_NO" />
	<input type="hidden" id="menuCd" name="menuCd" />
	<input type="hidden" id="MENU_URL" name="MENU_URL" />
</form>

<div class="schbox">
	<ul>
		<li><label for="date01">의뢰일자:</label> <input type="text"
			class="datepicker sDate" id="sDate" /> ~ <input type="text"
			class="datepicker eDate" id="eDate" /> <label for="sel01"
			class="ml20">검사차수:</label> <select id="examSn">
		</select></li>
		<li><label for="name">이름(차트번호):</label> <input type="text"
			class="" id="idValue" onkeypress="passwdKeypress(event);" /> <label
			for="sel02" class="ml20">성별:</label> <select id="gender">
		</select> <label for="sel03" class="ml20">연령대:</label> <select id="ageGroup">
		</select></li>
		<li><label for="name">검사종류:</label> <select id="examDiv">
		</select> <label for="sel02" class="ml20">진행상태:</label> <select id="examSttus">
		</select></li>
	</ul>
	<a href="#" onclick="reqExamList();" class="schbox_sch"><em
		class="btn_sch">조회</em></a>
</div>

<section class="mt35">
	<h2>검사의뢰목록</h2>
	<table class="boardlist topb">
		<caption>검사의뢰목록</caption>
		<colgroup>
			<col width="14%">
			<col width="10%">
			<col width="9%">
			<col width="*">
			<col width="9%">
			<col width="9%">
			<col width="12%">
			<col width="12%">
			<col width="12%">
			<col width="12%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">의뢰일자</th>
				<th scope="col">이름</th>
				<th scope="col">검사차수</th>
				<th scope="col">차트번호</th>
				<th scope="col">성별</th>
				<th scope="col">나이</th>
				<th scope="col">검사종류</th>
				<th scope="col">진행상태</th>
				<th scope="col">의뢰취소</th>
				<th scope="col">검사결과입력</th>
			</tr>
		</thead>
		<tbody id="reqExamList">

		</tbody>
	</table>
	<div class="paginate"></div>
</section>
