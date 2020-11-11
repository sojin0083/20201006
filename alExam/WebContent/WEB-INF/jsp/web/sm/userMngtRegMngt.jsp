<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	var paging;
	var pagingnext;
	var user_id;
	var org_cd;
	var org_nm;
	var birth;
	var orgCd = "";
	var sessOrgCd = "${SESS_ORG_CD}";

	$(document).ready(function() {
		searchCmmnCd(".DIAGNOSIS_PART", "CM009", "", "", "전체|null"); //공통함 수 콤보박스 값 들고오기
		searchCmmnCd(".CHARGE_PART", "CM010", "", "", "전체|null");
		searchCmmnCd(".use_yn", "CM007", "", "", "선택|null");
		search();
		usersearch();

		// 		if("^T001".indexOf(sessOrgCd) > 0){
		// 			searchCmmnCd(".ORG_NM","TC_CM_ORG","",orgCd,"전체","",false);      
		// 		}else{
		// 			searchCmmnCd(".ORG_NM","TC_CM_ORG","","","","in|"+sessOrgCd,false);
		// 		}

		if ("${SESS_AUTH_CD}" != "HLTH001") {//슈퍼관리자 or 일반관리자 접속에 따라 기관목록/기관상세 show or hide
			$(".btn_regit").hide();//기관등록버튼
			$("#smView").hide();
		} else {
			$("#smView").show();
			$(".btn_regit").show();
		}

	});

	//현재 날짜 불러오기
	function getRecentDate() {
		var dt = new Date();
		var recentYear = dt.getFullYear();
		var recentMonth = dt.getMonth() + 1;
		var recentDay = dt.getDate();

		if (recentMonth < 10)
			recentMonth = "0" + recentMonth;
		if (recentDay < 10)
			recentDay = "0" + recentDay;

		return recentYear + "-" + recentMonth + "-" + recentDay;
	}

	//검색 버튼 클릭 이벤트
	$(document).on("click", "#SEARCH", function() {
		search();
		usersearch();
	});

	//조회
	function search() {//rarara
		cfn.ajax({
			"url" : "/sm/userMngtRegMngtList.do",
			"data" : {
				"ORG_NM" : $(".ORG_NM").val()
			},
			"dataType" : "json",
			"method" : "POST",
			"success" : orgListfn
		});
		$(".userInfo").remove();
		reset();
	}

	//조회 후 기관목록 테이블 생성
	function orgListfn(data) {
		$(".orgList").remove();
		var orgTb = new StringBuffer();
		var orgListlength = data.rsList;
		for (var i = 0; i < orgListlength.length; i++) {
			orgTb.append("<tr class='orgList' style='cursor:pointer;'>");
			orgTb.append("<td class='org_List'>" + data.rsList[i].ORG_NM + "</td>");
			orgTb.append("<td class='org_List'>" + data.rsList[i].ORG_TEL + "</td>");
			orgTb.append("<td class='org_List'>" + data.rsList[i].USER_COUNT + "</td>");
			orgTb.append("<td class='org_List'>" + data.rsList[i].USE_YN + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].ADDR + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].ORG_TEL_NO_1 + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].ORG_TEL_NO_2 + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].ORG_TEL_NO_3 + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].REG_DML_DT + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].ORG_CD + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].USE_YN_YN + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].ZIP_CD + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].FLOOR + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].ADDR2 + "</td>");
 			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].SIDO + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].SIGUNGU + "</td>");
			orgTb.append("<td class='org_List' style='display:none;'>" + data.rsList[i].BNAME + "</td>");
			orgTb.append("</tr>");
		}
		$("#orgList").append(orgTb.toString());
		$(".orgnm").val($(".asd > tbody > tr:eq(1) > td:eq(0)").text());
		$(".addr").val($(".asd > tbody > tr:eq(1) > td:eq(4)").text());
		$("#phone_num").val($(".asd > tbody > tr:eq(1) > td:eq(5)").text());
		$("#phone_num2").val($(".asd > tbody > tr:eq(1) > td:eq(6)").text());
		$("#phone_num3").val($(".asd > tbody > tr:eq(1) > td:eq(7)").text());
		$("#reg_dml_dt").val($(".asd > tbody > tr:eq(1) > td:eq(8)").text());
		$("#orgcd").val($(".asd > tbody > tr:eq(1) > td:eq(9)").text());
		$(".use_yn").val($(".asd > tbody > tr:eq(1) > td:eq(10)").text());
		$("#zip_cd").val($(".asd > tbody > tr:eq(1) > td:eq(11)").text());
		$("#floor").val($(".asd > tbody > tr:eq(1) > td:eq(12)").text());
		$("#addr2").val($(".asd > tbody > tr:eq(1) > td:eq(13)").text());
  		$("#sido").val($(".asd > tbody > tr:eq(1) > td:eq(14)").text());
		$("#sigungu").val($(".asd > tbody > tr:eq(1) > td:eq(15)").text());
		$("#bname").val($(".asd > tbody > tr:eq(1) > td:eq(16)").text());
		fn_commonPagination(".orgList", ".pageOne", 6, 1);
	}

	//기관목록 테이블 클릭시 기관상세 쪽 데이터 출력	
	$(document).on("click", ".orgList", function() {
		var orglist = $(this);
		var td_orglist = orglist.children();
		var orgnm = td_orglist.eq(0).text();
		var useyn = td_orglist.eq(10).text();
		var addr = td_orglist.eq(4).text();
		var tel_no_1 = td_orglist.eq(5).text();
		var tel_no_2 = td_orglist.eq(6).text();
		var tel_no_3 = td_orglist.eq(7).text();
		var reg_dml_dt = td_orglist.eq(8).text();
		var orgcd = td_orglist.eq(9).text();
		var zip_cd = td_orglist.eq(11).text();
		var floor = td_orglist.eq(12).text();
		var addr2 = td_orglist.eq(13).text();
  		var sido = td_orglist.eq(14).text();
		var sigungu = td_orglist.eq(15).text(); 
		var bname = td_orglist.eq(16).text(); 

		org_cd = orgcd;
		$(".orgnm").val(orgnm);
		$("#orgcd").val(orgcd);
		$(".use_yn").val(useyn);
		$(".addr").val(addr);
		$("#phone_num").val(tel_no_1);
		$("#phone_num2").val(tel_no_2);
		$("#phone_num3").val(tel_no_3);
		$("#reg_dml_dt").val(reg_dml_dt);
		$("#zip_cd").val(zip_cd);
		$("#floor").val(floor);
		$("#addr2").val(addr2);
  		$("#sido").val(sido);
		$("#sigungu").val(sigungu);
		$("#bname").val(bname);
		usersearch(orgcd);
	});

	//사용자목록 조회
	function usersearch(org_cd_data) {
		var search_type = ""
		if (org_cd_data == undefined) {//검색했을경우 사용자목록 조회조건
			search_type = {
				"JOB_CLF" : $(".CHARGE_PART").val(),
				"ORG_PART" : $(".DIAGNOSIS_PART").val(),
				"ORG_NM" : $(".ORG_NM").val()
			}
		} else {//기관목록 선택시 사용자목록 조회조건
			search_type = {
				"ORG_CD" : org_cd_data
			}
		}
		cfn.ajax({
			"url" : "/sm/orgMngtUserRegList.do",
			"data" : search_type,
			"dataType" : "json",
			"method" : "POST",
			"success" : orgMngtUserRegList
		});
	}

	//사용자 목록 조회 출력
	function orgMngtUserRegList(data) {
		$(".userInfo").remove();
		$(".userNotInfo").remove();
		var userTb = new StringBuffer();
		var userPb = new StringBuffer();
		var userlist = data.rsList.length;
		if (userlist == 0) {
			userTb.append("<tr class='userNotInfo '>");
			userTb.append("<td colspan='10' class='userlist'>등록된 사용자가 없습니다.</td>");
			userTb.append("</tr>");
		} else {
			for (var i = 0; i < userlist; i++) {
				userTb.append("<tr class='userInfo  userInfoList' style='cursor:pointer;'>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].ORG_NM + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].ORG_PART + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].JOB_CLF + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].USER_NM + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].GENDER + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].BIRTH + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].TEL_NO + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].LOGIN_ID + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].USE_YN + "</td>");
				userTb.append("<td style='text-align:center;' class='userInfo'>" + data.rsList[i].REG_DML_DT + "</td>");
				userTb.append("<td class='userInfo' style='display:none;'>" + data.rsList[i].USE_YN_1 + "</td>");
				userTb.append("<td class='userInfo' style='display:none;'>" + data.rsList[i].ORG_PART_1 + "</td>");
				userTb.append("<td class='userInfo' style='display:none;'>" + data.rsList[i].JOB_CLF_1 + "</td>");
				userTb.append("<td class='userInfo' style='display:none;'>" + data.rsList[i].USER_ID + "</td>");
				userTb.append("<td class='userInfo' style='display:none;'>" + data.rsList[i].BIRTH_1 + "</td>");
				userTb.append("<td class='userInfo' style='display:none;'>" + data.rsList[i].ORG_CD + "</td>");
				userTb.append("</tr>");
			}
		}
		$("#userList").append(userTb.toString());
		fn_commonPagination(".userInfoList", ".paaag", 5, 2);
	}

	//기관등록 이벤트
	$(document).on("click", ".btn_regit", function() {
		reset();
		var sysdate = getRecentDate();
		$("#reg_dml_dt").val(sysdate);
	});

	// 기관 저장 이벤트
	$(document).on(
			"click",
			".btn_save",
			function() {
				var org_cd = $("#orgcd").val();
				var org_nm = $(".orgnm").val();
				var addr = $(".addr").val();
				var use_yn = $(".use_yn").val();
				var phone_num = $("#phone_num").val();
				var phone_num2 = $("#phone_num2").val();
				var phone_num3 = $("#phone_num3").val();
				var zip_cd = $("#zip_cd").val();
				var floor = $("#floor").val();
				var addr2 = $("#addr2").val();
   				var sido = $("#sido").val();
				var sigungu = $("#sigungu").val();
				var bname = $("#bname").val();
				if (isNullToString(org_nm) == "") {
					alert("기관명을 입력해 주세요.");
					return;
				}
				if (isNullToString(zip_cd) == "") {
					alert("우편번호를 입력해 주세요.");
					return;
				}
  				if (isNullToString(sido) == "") {
					alert("시도를 입력해 주세요.");
					return;
				}
				if (isNullToString(sigungu) == "") {
					alert("시군구를 입력해 주세요.");
					return;
				}
				if (isNullToString(bname) == "") {
					alert("동을 입력해 주세요.");
					return;
				}  
				if (isNullToString(addr) == "") {
					alert("주소를 입력해 주세요.");
					return;
				}
				if (isNullToString(addr2) == "") {
					alert("주소상세를 입력해 주세요.");
					return;
				}
				if (isNullToString(floor) == "") {
					alert("층수를 입력해 주세요.");
					return;
				}
				if (isNullToString(use_yn) == "") {
					alert("사용여부를 선택해 주세요.");
					return;
				}
				if (isNullToString(phone_num) == ""
						|| isNullToString(phone_num2) == ""
						|| isNullToString(phone_num3) == "") {
					alert("전화번호를 입력해 주세요.");
					return;
				}
				if (use_yn == "N") {
					alert("기관을 미사용으로 설정할 경우\n해당기관의 사용자는 사용자 목록에서 확인할 수 없습니다.");
				}
				if (isNullToString(org_cd) == "") {
					if (confirm("등록하시겠습니까?")) {
						cfn.ajax({
							"url" : "/sm/userMngtRegMngtRegInsert.do",
							"data" : {
								"ORG_NM" : org_nm,
								"ORG_TEL_NO_1" : phone_num,
								"ORG_TEL_NO_2" : phone_num2,
								"ORG_TEL_NO_3" : phone_num3,
								"ADDR" 		   : addr,
								"USE_YN" 	   : use_yn,
								"ORG_CD" 	   : org_cd,
								"ZIP_CD" 	   : zip_cd,
								"FLOOR" 	   : floor,
								"ADDR2" 	   : addr2,
								"SIDO"  	   : sido,
								"SIGUNGU" 	   : sigungu,
								"BNAME"		   : bname
							},
							"dataType" : "json",
							"method"   : "POST",
							"success"  : succ
													});
					}
				} else {
					if (confirm("수정하시겠습니까?")) {
						cfn.ajax({
							"url" : "/sm/userMngtRegMngtRegUpd.do",
							"data" : {
								"ORG_NM" : org_nm,
								"ORG_TEL_NO_1" : phone_num,
								"ORG_TEL_NO_2" : phone_num2,
								"ORG_TEL_NO_3" : phone_num3,
								"ADDR" 		   : addr,
								"USE_YN" 	   : use_yn,
								"ORG_CD" 	   : org_cd,
								"ZIP_CD" 	   : zip_cd,
								"FLOOR" 	   : floor,
								"ADDR2" 	   : addr2, 
   								"SIDO"  	   : sido,
								"SIGUNGU" 	   : sigungu,
								"BNAME"		   : bname
							},
							"dataType" : "json",
							"method" : "POST",
							"success" : succ
						});
					}
				}
			});

	function succ() {
		alert("저장 되었습니다.");
		reset();
		search();
		usersearch();
	}

	//기관명 중복 체크 이벤트
	$(document).on("change", ".orgnm", function() {
		orgChk();
	});

	function orgChk() {
		cfn.ajax({
			"url" : "/sm/selectOrgRegChk.do",
			"data" : {
				"ORG_NM" : $(".orgnm").val()
			},
			"dataType" : "json",
			"method" : "POST",
			"success" : orgChkResult
		});
	}

	function orgChkResult(data) {
		if (data.OrgRegChk != null
				&& data.OrgRegChk.ORG_NM == $(".orgnm").val()) {
			alert("중복된 기관명입니다.");
			$(".orgnm").focus();
			$(".orgnm").val("");
		}
	}

	// 팝업 이벤트 
	//사용자목록쪽 테이블 더블 클릭시 팝업 호출 이벤트
	$(document).on("dblclick", "tr.userInfo", function() {
		user_id = $(this).children().eq(13).text();
		birth = $(this).children().eq(14).text();
		org_cd = $(this).children().eq(15).text();
		org_nm = $(this).children().eq(0).text();
		var popUrl = "/alExam/sm/userRegInfoChgPop.do";
		modalView(popUrl + "?USER_ID=" + user_id + "&BIRTH=" + birth);
	});

	//사용자목록 쪽 신규등록 클릭시 팝업 호출 이벤트
	$(document).on("click", ".btn_userReg", function() {
		var popUrl = "/alExam/sm/userRegInfoChgPop.do";
		modalView(popUrl);
	});

	//팝업 닫기
	$(document).on("click", ".btn-layerClose", function() {
		popUpReset();
		modalHide();
	});

	//팝업 닫기
	$(document).on("click", ".btn_cancle", function() {
		popUpReset();
		modalHide();
	});

	//팝업 저장 이벤트
	$(document).on(
			"click",
			".btn_saves",
			function() {
				var orgnm = $(".user_org_nm").val();
				var usernm = $(".user_nm").val();
				var userorgpart = $(".user_org_part").val();
				var jobclf = $(".user_job_clf").val();
				var usergender = $(".user_gender").val();
				var usertel1 = $(".user_tel_1").val();
				var usertel2 = $(".user_tel_2").val();
				var usertel3 = $(".user_tel_3").val();
				var useruseyn = $(".user_use_yn").val();
				var userbirth = $(".user_birth").val();
				if (isNullToString(orgnm) == "") {
					alert("기관명을 선택해주세요.");
					return false;
				}
				if (isNullToString(userorgpart) == "") {
					alert("진료과를 선택해주세요.");
					return false;
				}
				if (isNullToString(jobclf) == "") {
					alert("담당업무를 선택해주세요.");
					return false;
				}
				if (isNullToString(usernm) == "") {
					alert("사용자명을 입력해주세요.");
					return false;
				}
				if (isNullToString(usergender) == "") {
					alert("성별을 선택해주세요.");
					return false;
				}
				if (isNullToString(userbirth) == "" || userbirth.length != 10) {
					alert("생년월일을  정확히 입력해주세요.");
					return false;
				}
				if (isNullToString(useruseyn) == "") {
					alert("사용여부를 선택해주세요.");
					return false;
				}
				if (isNullToString(usertel1) == ""
						|| isNullToString(usertel2) == ""
						|| isNullToString(usertel3) == "") {
					alert("전화번호를 입력해주세요.");
					return false;
				}
				if (isNullToString(usergender) == "") {
					alert("성별을 선택해주세요.");
					return false;
				}
				if (confirm("저장하시겠습니까?")) { //사용자 등록 중복 조회
					cfn.ajax({
								"url" : "/sm/selectUserRegChk.do",
								"data" : {
									"USER_NM" : $(".user_nm").val(),
									"BIRTH" : $(".user_birth").val().replace(/\-/g, ""),
									"TEL_NO_1" : $(".user_tel_1").val(),
									"TEL_NO_2" : $(".user_tel_2").val(),
									"TEL_NO_3" : $(".user_tel_3").val(),
									"ORG_CD" : $(".user_org_nm").val()
								},
								"dataType" : "json",
								"method" : "POST",
								"success" : userRegChk2
							})

				}
			});

	//중복 아닐시 등록
	function userRegChk2(data) {
		if (change == "Y") {
			cfn.ajax({
				"url" : "/sm/UserRegUpd.do",
				"data" : {
					"USER_NM" : $(".user_nm").val(),
					"GENDER" : $(".user_gender").val(),
					"BIRTH" : $(".user_birth").val().replace(/\-/g, ""),
					"ORG_PART" : $(".user_org_part").val(),
					"JOB_CLF" : $(".user_job_clf").val(),
					"TEL_NO_1" : $(".user_tel_1").val(),
					"TEL_NO_2" : $(".user_tel_2").val(),
					"TEL_NO_3" : $(".user_tel_3").val(),
					"LOGIN_ID" : $(".user_login_id").val().trim(),
					"USER_ID" : $(".user_id_reg").val(),
					"PW" : $(".user_pw").val().trim(),
					"USE_YN" : $(".user_use_yn").val(),
					"ORG_CD" : $(".user_org_nm").val()
				},
				"dataType" : "json",
				"method" : "POST",
				"success" : savePop
			});
		} else if (change == "N") {
			if (data.rsList.COUNT == 0) {
				cfn.ajax({
					"url" : "/sm/UserRegUpd.do",
					"data" : {
						"USER_NM" : $(".user_nm").val(),
						"GENDER" : $(".user_gender").val(),
						"BIRTH" : $(".user_birth").val().replace(/\-/g, ""),
						"ORG_PART" : $(".user_org_part").val(),
						"JOB_CLF" : $(".user_job_clf").val(),
						"TEL_NO_1" : $(".user_tel_1").val(),
						"TEL_NO_2" : $(".user_tel_2").val(),
						"TEL_NO_3" : $(".user_tel_3").val(),
						"LOGIN_ID" : $(".user_login_id").val().trim(),
						"USER_ID" : $(".user_id_reg").val(),
						"PW" : $(".user_pw").val().trim(),
						"USE_YN" : $(".user_use_yn").val(),
						"ORG_CD" : $(".user_org_nm").val()
					},
					"dataType" : "json",
					"method" : "POST",
					"success" : savePop
				});
			} else {
				alert("이미 등록된 사용자입니다.");
				return false;
			}
		}
	}

	function savePop() {
		alert("저장되었습니다.");
		modalHide();
		popUpReset();
		location.reload();
	}

	//팝업 전화번호 숫자 만 체크 이벤트
	$(document).on("keyup", ".user_tel_2", function(event) {
		var prev = $(this).val();
		var numChk = prev.replace(/[^0-9]/g, "");
		var inputVal = numChk;
		$(".user_tel_2").val(inputVal);
	});

	//팝업 전화번호 숫자 만 체크 이벤트
	$(document).on("keyup", ".user_tel_3", function(event) {
		var prev = $(this).val();
		var numChk = prev.replace(/[^0-9]/g, "");
		var inputVal = numChk;
		$(".user_tel_3").val(inputVal);
	});
	//팝업 저장 이벤트 종료

	//생년월일 키 이벤트  - 붙이기
	$(document).on(
			"keyup",
			".user_birth",
			function(event) {
				var prev = $(this).val();
				var numChk = prev.replace(/[^0-9]/g, "");
				var numChkLength = numChk.length;
				var inputVal = numChk;
				if (event.keyCode === 8) {
					return false;
				} else if (numChkLength == 4) {
					inputVal = numChk + "-";
				} else if (numChkLength == 5) {
					inputVal = numChk.substr(0, 4) + "-" + numChk.substr(4, 1);
				} else if (numChkLength == 6) {
					inputVal = numChk.substr(0, 4) + "-" + numChk.substr(4, 2)
							+ "-";
				} else if (numChkLength == 7) {
					inputVal = numChk.substr(0, 4) + "-" + numChk.substr(4, 2)
							+ "-" + numChk.substr(6, 1);
				} else if (numChkLength == 8) {
					inputVal = numChk.substr(0, 4) + "-" + numChk.substr(4, 2)
							+ "-" + numChk.substr(6, 2);
				}
				$(".user_birth").val(inputVal);
			});

	//기관 상세 등록 전화번호 숫자만 입력 이벤트
	$(document).on("keyup", "#phone_num2", function(event) {
		var prev = $(this).val();
		var numChk = prev.replace(/[^0-9]/g, "");
		var inputVal = numChk;
		$("#phone_num2").val(inputVal);
	});

	//기관 상세 등록 전화번호 숫자만 입력 이벤트
	$(document).on("keyup", "#phone_num3", function(event) {
		var prev = $(this).val();
		var numChk = prev.replace(/[^0-9]/g, "");
		var inputVal = numChk;
		$("#phone_num3").val(inputVal);
	});
	
	//기관 상세 등록 층수 숫자만 입력 이벤트
	$(document).on("keyup", "#floor", function(event) {
		var prev = $(this).val();
		var numChk = prev.replace(/[^0-9]/g, "");
		var inputVal = numChk;
		$("#floor").val(inputVal);
	});

	//로그인 중복 체크 이벤트
	$(document).on("change", ".user_login_id", function() {
		loginChk();
	});

	function loginChk() {
		cfn.ajax({
			"url" : "/sm/selectLoginRegChk.do",
			"data" : {
				"LOGIN_ID" : $(".user_login_id").val()
			},
			"dataType" : "JSON",
			"method" : "POST",
			"success" : loginChkResult
		});
	}

	function loginChkResult(data) {

		if (data.LoginRegChk != null
				&& data.LoginRegChk.LOGIN_ID == $(".user_login_id").val()
						.trim()) {
			alert("로그인 아이디가 중복입니다.");
			$(".user_login_id").focus();
			$(".user_login_id").val("");
			return;
		} else if (data.LoginRegChk == null) {
			alert("사용가능한 아이디 입니다.");
		}
	}

	//초기화 이벤트
	function reset() {
		$(".orgnm").val("");
		$("#orgcd").val("");
		$(".use_yn").val("");
		$(".addr").val("");
		$("#phone_num").val("");
		$("#phone_num2").val("");
		$("#phone_num3").val("");
		$("#reg_dml_dt").val("");
		$("#zip_cd").val("");
		$("#addr2").val("");
		$("#floor").val("");
  		$("#sido").val("");
		$("#sigungu").val(""); 
		$("#bname").val("");
		
		
	}
	function popUpReset() {
		$(".user_org_nm").text("");
		$(".user_org_part").val("");
		$("user_job_clf").val("");
		$(".user_use_yn").val("");
		$(".user_gender").val("");
		$(".user_birth").val("");
		$(".user_tel_1").val("");
		$(".user_tel_2").val("");
		$(".user_tel_3").val("");
		$(".user_login_id").val("");
		$(".user_pw").val("");
		$(".user_regdit").val("");
		user_id = "";
		birth = "";
		org_cd = "";
	}
	//검색 엔터
	function passwdKeypress(e) {
		if (e.keyCode == 13) {
			search();
			usersearch();
		}
	}
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수
						var sido = ''; //시도
						var sigungu = '';	//시군구
						var bname = ''; //동

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zip_cd').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('addr').value = fullAddr;
						document.getElementById('sido').value = data.sido;
						document.getElementById('sigungu').value = data.sigungu;
						document.getElementById('bname').value = data.bname;

						// 커서를 상세주소 필드로 이동한다.
						//document.getElementById('addr2').focus();
					}
				}).open();
	}
</script>

<div class="schbox">
	<ul>
		<li><label for="sel01" style="width: auto"> 기관명:</label> 
			<!--<select class="ORG_NM" id="sel01"></select> -->
			<input type="text" class="ORG_NM" id="ORG_NM" onkeypress="passwdKeypress(event);" /> 
			<label for="sel02" class="ml20">진료과:</label> 
			<select class="DIAGNOSIS_PART" id="sel02"></select>
			<label for="sel03" class="ml20">담당업무:</label> 
			<select class="CHARGE_PART" id="sel03"></select>
			</li>
	</ul>
	<a href="#" class="schbox_sch" id="SEARCH"><em class="btn_sch">검색</em></a>
</div>
<section class="mt35 section_div_set01" id="smView"
	style='display: none;'>
	<div>
		<h2 class="mt8">기관목록</h2>
		<table class="boardlist topb mt15 asd">
			<colgroup>
				<col width="*%">
				<col width="30%">
				<col width="15%">
				<col width="18%">
			</colgroup>
			<tbody id="orgList">
				<tr>
					<th scope="col">기관명</th>
					<th scope="col">전화번호</th>
					<th scope="col">사용자수</th>
					<th scope="col">사용여부</th>
				</tr>
			</tbody>
		</table>
		<div class="paginate pageOne"></div>
	</div>

	<div>
		<ul class="title_align">
			<li><h2>기관상세</h2></li>
			<li><a href="#" class="btn_all btn_regit">기관등록</a> <a href="#" class="btn_all btn_save">저장</a></li>
		</ul>
		<table class="table_type topb bg_grey">
			<colgroup>
				<col width="40%">
				<col width="60%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">기관명</th>
					<td><input type="text" class="orgnm" /></td>
					<td><input type="hidden" id="orgcd"></td>
				</tr>
				<tr>
					<th scope="col">우편번호</th>
					<td><input type="button" name="zip_cd" class="zip_cd" onclick="sample6_execDaumPostcode()" id="zip_cd" style="text-align: left" readonly /></td>
				</tr>
				<tr style="display: none;">
					<th scope="col">시도</th>
					<td><input type="text" name="sido" id="sido" class="sido"></td>
				</tr>
				<tr style="display: none;">
					<th scope="col">시군구</th>
					<td><input type="text" name="sigungu" id="sigungu" class="sigungu"></td>
				</tr>
				<tr style="display: none;">
					<th scope="col">동</th>
					<td><input type="text" name="bname" id="bname" class="bname"></td>
				</tr>
				<tr>
					<th scope="col">주소</th>
					<td><input type="text" name="address1" class="addr" id="addr" readonly /></td>
				</tr>
				<tr>
					<th scope="col">주소상세</th>
					<td><input type="text" name="address2" class="addr2" id="addr2" /></td>
				</tr>
				<tr>
					<th scope="col">층수</th>
					<td><input type="text" class="floor" id="floor" name="floor" /></td>
				</tr>
				<tr>
					<th scope="col">전화번호</th>
					<td><select id="phone_num" style="width: 70px;">
							<option value="">전체</option>
							<option value="02">02</option>
							<option value="051">051</option>
							<option value="053">053</option>
							<option value="032">032</option>
							<option value="062">062</option>
							<option value="042">042</option>
							<option value="052">052</option>
							<option value="044">044</option>
							<option value="031">031</option>
							<option value="033">033</option>
							<option value="043">043</option>
							<option value="041">041</option>
							<option value="063">063</option>
							<option value="061">061</option>
							<option value="054">054</option>
							<option value="055">055</option>
							<option value="064">064</option>
					</select>-<input type="text" id="phone_num2" style="width: 60px"maxlength="4">-<input type="text" id="phone_num3" style="width: 60px" maxlength="4"></td>
				</tr>
				<tr>
					<th scope="col">사용여부</th>
					<td><select class="use_yn" id="">
					</select></td>
				</tr>
				<tr>
					<th>등록일</th>
					<td><input type="text" id="reg_dml_dt" disabled="disabled"></td>
				</tr>
			</tbody>
		</table>
	</div>
</section>

<section class="mt35">
	<ul class="title_align">
		<li><h2>사용자목록</h2></li>
		<li><a href="#" class="btn_all new btn-layer btn_userReg">신규등록</a></li>
	</ul>
	<table class="boardlist topb">
		<caption>검사결과목록</caption>
		<colgroup>
			<col width="*">
			<col width="8%">
			<col width="8%">
			<col width="8%">
			<col width="8%">
			<col width="15%">
			<col width="15%">
			<col width="8%">
			<col width="8%">
			<col width="12%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">기관명</th>
				<th scope="col">진료과</th>
				<th scope="col">담당업무</th>
				<th scope="col">사용자명</th>
				<th scope="col">성별</th>
				<th scope="col">생년월일</th>
				<th scope="col">전화번호</th>
				<th scope="col">로그인 ID</th>
				<th scope="col">사용여부</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody id="userList">
		</tbody>
	</table>
</section>
<div class="bb">
	<div class="paginate paaag"></div>
</div>