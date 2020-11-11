<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="jquery.tablesorter.js"></script>
<script>
    $(document).ready(function(){
        $("#tbsort").tablesorter();
    });
</script>

<script type="text/javascript">

var modalModRnum;
var RNUMS="";
var NAME = "";

$(document).ready(function(){
	//셀렉트박스
	searchCmmnCd("#gender","CM002","","","전체|null");//성별
	searchCmmnCd("#ageGroup","CM008","","","전체|null");//연령대
	searchCmmnCd("#examSn","SV005","","","전체|null");//검사차수
	
	$('.sDate').val(getDateShift("",'M',-3,"YYYY-MM-DD"));			
	$('.eDate').val(setDateFormat("","YYYY-MM-DD"));
	datePickerFn();

	//리스트 불러오기
	trgterList();	
	
	$('.schbox_sch').on('click', function(){		
		trgterList();
	});
});

function passwdKeypress(e){
	if(e.keyCode == 13){
		trgterList();
	}
}

//리스트조회
function trgterList(){
	$("#list").empty(); 
	
	cfn.ajax({
		   "url" : "/tg/trgterList.do"
		 , "data" : {
						 "sDate" 		: $("#sDate").val().replace(/-/gi,"")
	 					,"eDate" 		: $("#eDate").val().replace(/-/gi,"") 
			 			,"examSn" 		: $("#examSn").val()
			 			,"idValue"		: $("#idValue").val()
			 			,"gender" 		: $("#gender").val()
			 			,"ageGroup" 	: $("#ageGroup").val()
		 } 
		 , "method" : "POST"
		 , "dataType" : "JSON"
		 , "success" : function(data){
			loadTrgterList(data);
		 }
		 , "error" : function(data){
			alert("통신실패");
		 }
	});
}

//불러온리스트 그리기
function loadTrgterList(data){			
	var str = "";
	if(isNullToString(data.rsList)==""){
		str += "<tr class='TrgterList2'>";
		str += "<td colspan='9'>등록된 대상자가 없습니다</td>";
		str += "</tr>";
	}
	
	if(isNullToString(data.rsList) != ""){
		for(var i=0; i<data.rsList.length; i++){
			str += "<tr class='TrgterList' style='cursor:pointer;' onclick='fn_TrgterDetail(\"" + data.rsList[i].R_NUMBER + "\")'>";
			str += "<td style='cursor:Default;' onclick='event.cancelBubble=true'><input type='checkbox' id='checkbox_" + i + "' name='chk' class='ck_cmd board' value='" + data.rsList[i].R_NUMBER + "'><label for='checkbox_" + i + "'><span></span></label></td>";
			str += "<td>" + data.rsList[i].NAME + "</td>";
			if(data.rsList[i].C_NUMBER == undefined){
				str += "<td>-</td>";
			}else{
				str += "<td>" + data.rsList[i].C_NUMBER + "</td>";	
			}
			str += "<td>" + data.rsList[i].GENDER + "</td>";
			str += "<td>" + data.rsList[i].AGE + "</td>";
			if(data.rsList[i].EXAM_DIV == undefined){
				str +=  "<td>-</td>"
			}else{
				str += "<td>" + data.rsList[i].EXAM_DIV + "</td>";
			}
			if(data.rsList[i].EXAM_DIV == undefined){
				str +=  "<td>-</td>"
			}else{
				str += "<td>" + data.rsList[i].EXAM_SN + " 차</td>";
			} 
			if(data.rsList[i].EXAM_DIV == undefined){
				str +=  "<td>-</td>"
			}else{
				str += "<td>" + data.rsList[i].EXAM_CMP_DATE + "</td>";
			}
			str += "<td>" + data.rsList[i].REG_DML_DT + "</td>";
			str += "<td style='display:none;'>" + data.rsList[i].PROC + "</td>";			
			str += "</tr>";
		}
	}
	
	$("#list").append(str);
	fn_commonPagination(".TrgterList",".paginate", 10, "pageOp");
}


//대상자등록 팝업
function regTrgterInfoPage(){
	modalView("/alExam/tg/regTrgterInfoPage.do");
}
//대상자등록 유효성검사
function fn_regTrgterInfoForm(){
	
	if(isNullToString($("#trgterName").val()) == ""){
		alert("대상자 이름을 입력해주세요.");
 		return;
	}
	if(isNullToString($("#C_NUMBER").val()) == ""){
		alert("대상자 차트번호를 입력해주세요.");
 		return;
	}
	if($("#C_NUMBER").val().length != 5){
		alert("차트번호는 5자리 숫자만 가능합니다.");
 		return;
	}
	if(isNullToString($("#bTrgterBirth").val()) == ""){
		alert("대상자 생년월일을 입력해주세요.");
 		return;
	}
	if(isNullToString($("input[name=trgterDivBirth]:checked").val()) == ""){
		alert("대상자 생년월일의 양/음력을 선택해주세요.");
 		return;
	}
	if(isNullToString($("input[name=trgterGender]:checked").val()) == ""){
		alert("대상자의 성별을 선택해주세요.");
 		return;
	}
	if(isNullToString($("input[name=trgterHandCd]:checked").val()) == ""){
		alert("대상자의 주로 사용하는 손을 선택해주세요.");
 		return;
	}
	if(isNullToString($("#trgterEduYear").val()) == ""){
		alert("대상자의 교육년수를 입력해주세요.");
 		return;
	}
/* 	if(isNullToString($("#trgterInmateName").val()) == ""){
		alert("대상자의 동거자명을 입력해주세요.");
 		return;
	}
	if(isNullToString($("input[name=trgterInmateYn]:checked").val()) == ""){
		alert("대상자와 동거자의 동거여부를 선택해 주세요.");
 		return;
	} */
	/* if(isNullToString($("#telNo1").val()) == "" || isNullToString($("#telNo2").val()) == "" || isNullToString($("#telNo3").val()) == ""){
		alert("대상자의 전화번호를 입력해주세요.");
		return;
	} */
	/* if(isNullToString($("#email").val()) == ""){
		alert("대상자의 EMAIL을 입력해주세요.");
		return;
	}*/
	
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	if(isNullToString($("#email").val()) != ""){
		if(exptext.test($("#email").val())==false){
			alert("이메일형식이 올바르지 않습니다.");
			return false;
		}
	}
	if(isNullToString($("#inmateEmail").val()) != ""){
		if(exptext.test($("#inmateEmail").val())==false){
			alert("보호자 이메일형식이 올바르지 않습니다.");
			return false;
		}
	}
	
	$("#trgterBirth").val($("#bTrgterBirth").val().replace(/-/gi,""));
	//차트번호 중복확인
	cfn.ajax({
		   "url" : "/tg/modTrgterNumChk.do"
		 , "data" : {
						 "C_NUMBER"			: $("#C_NUMBER").val()
						,"ORG_CD"			: "${SESS_ORG_CD}"
		 } 
		 , "method" : "POST"
		 , "dataType" : "JSON"
		 , "success" : function(data){
			 if(data.rsChk.C_NUMBER_YN == "N"){
				 fn_regTrgterInfoInsert()
			 }else{
				 alert("존재하는 차트번호 입니다.\n다른 차트번호를 입력해주세요.");	 
			 }
		 }
		 , "error" : function(data){
			alert("통신실패");
		 }
	});
}
//대상자 등록
function fn_regTrgterInfoInsert(){
	cfn.ajax({
		   "url" : "/tg/regTrgterInfo.do"
		 , "data" : {
						 "trgterName" 		: $("#trgterName").val()
						,"cNumber" 			: $("#C_NUMBER").val()
	 					,"trgterBirth" 		: $("#trgterBirth").val() 
			 			,"trgterDivBirth" 	: $("input[name=trgterDivBirth]:checked").val()
			 			,"trgterGender"		: $("input[name=trgterGender]:checked").val()
			 			,"trgterHandCd" 	: $("input[name=trgterHandCd]:checked").val()
			 			,"trgterEduYear" 	: $("#trgterEduYear").val()
			 			,"trgterInmateName" : $("#trgterInmateName").val()
			 			,"trgterInmateYn" 	: $("input[name=trgterInmateYn]:checked").val()
			 			,"telNo1" 			: $("#telNo1").val()
			 			,"telNo2" 			: $("#telNo2").val()
			 			,"telNo3" 			: $("#telNo3").val()
			 			,"email" 			: $("#email").val()
			 			,"inmateTelNo1" 	: $("#inmateTelNo1").val()
			 			,"inmateTelNo2" 	: $("#inmateTelNo2").val()
			 			,"inmateTelNo3" 	: $("#inmateTelNo3").val()
			 			,"inmateEmail" 		: $("#inmateEmail").val()
			 			,"sido"				: $("#sido").val()
			 			,"sigungu"			: $("#sigungu").val()
			 			,"bname"			: $("#bname").val()
			 			,"zip_cd"			: $("#zip_cd").val()
			 			,"addr"				: $("#addr").val()
			 			,"addr2"			: $("#addr2").val()
		 } 
		 , "method" : "POST"
		 , "dataType" : "JSON"
		 , "success" : function(data){
				alert("등록되었습니다");
				modalHide();
				location.reload();
		 }
		 , "error" : function(data){
			alert("통신실패");
		 }
	});
}


//대상자정보수정 팝업
function fn_TrgterDetail(RNUM){
	modalModRnum = RNUM
	modalView("/alExam/tg/modTrgterInfoPage.do");
}
//대상자정보수정 유효성검사
function fn_modTrgterInfoForm(){

	if(isNullToString($("#trgterName").val()) == ""){
		alert("대상자 이름을 입력해주세요.");
 		return;
	}
	if(isNullToString($("#C_NUMBER").val()) == ""){
		alert("대상자 차트번호를 입력해주세요.");
 		return;
	}
	if($("#C_NUMBER").val().length != 5){
		alert("차트번호는 5자리 숫자만 가능합니다.");
 		return;
	}
	if(isNullToString($("#bTrgterBirth").val()) == ""){
		alert("대상자 생년월일을 입력해주세요.");
 		return;
	}
	if(isNullToString($("input[name=trgterDivBirth]:checked").val()) == ""){
		alert("대상자 생년월일의 양/음력을 선택해주세요.");
 		return;
	}
	if(isNullToString($("input[name=trgterGender]:checked").val()) == ""){
		alert("대상자의 성별을 선택해주세요.");
 		return;
	}
	if(isNullToString($("input[name=trgterHandCd]:checked").val()) == ""){
		alert("대상자의 주로 사용하는 손을 선택해주세요.");
 		return;
	}
/* 	if(isNullToString($("#trgterEduYear").val()) == ""){
		alert("대상자의 교육년수를 입력해주세요.");
 		return;
	} *//* 
	if(isNullToString($("#trgterInmateName").val()) == ""){
		alert("대상자의 동거자명을 입력해주세요.");
 		return;
	} */
/* 	if(isNullToString($("input[name=trgterInmateYn]:checked").val()) == ""){
		alert("대상자와 동거자의 동거여부를 선택해 주세요.");
 		return;
	} */
	/* if(isNullToString($("#telNo1").val()) == "" || isNullToString($("#telNo2").val()) == "" || isNullToString($("#telNo3").val()) == ""){
		alert("대상자의 전화번호를 입력해주세요.");
		return;
	} */
	/* if(isNullToString($("#email").val()) == ""){
		alert("대상자의 EMAIL을 입력해주세요.");
		return;
	}*/
	
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	if(isNullToString($("#email").val()) != ""){
		if(exptext.test($("#email").val())==false){
			alert("이메일형식이 올바르지 않습니다.");
			return false;
		}
	}
	if(isNullToString($("#inmateEmail").val()) != ""){
		if(exptext.test($("#inmateEmail").val())==false){
			alert("보호자 이메일형식이 올바르지 않습니다.");
			return false;
		}
	}
	
	$("#trgterBirth").val($("#bTrgterBirth").val().replace(/-/gi,""));
	//차트번호 중복확인
	cfn.ajax({
		   "url" : "/tg/modTrgterNumChk.do"
		 , "data" : {
						 "C_NUMBER"			: $("#C_NUMBER").val()
						,"ORG_CD"			: "${SESS_ORG_CD}"
		 } 
		 , "method" : "POST"
		 , "dataType" : "JSON"
		 , "success" : function(data){
			 if(data.rsChk.C_NUMBER_YN == $("#ASIS_C_NUMBER").val()||data.rsChk.C_NUMBER_YN == "N"){
				 fn_modTrgterInfoUpdate()
			 }else{
				 alert("존재하는 차트번호 입니다.\n다른 차트번호를 입력해주세요.");	 
			 }
		 }
		 , "error" : function(data){
			alert("통신실패");
		 }
	});
}

//대상자정보수정
function fn_modTrgterInfoUpdate(){
	cfn.ajax({
		   "url" : "/tg/modTrgterInfo.do"
		 , "data" : {
						 "R_NUMBER"			: modalModRnum
						,"C_NUMBER"			: $("#C_NUMBER").val()
			 			,"trgterName" 		: $("#trgterName").val()
	 					,"trgterBirth" 		: $("#trgterBirth").val() 
			 			,"trgterDivBirth" 	: $("input[name=trgterDivBirth]:checked").val()
			 			,"trgterGender"		: $("input[name=trgterGender]:checked").val()
			 			,"trgterHandCd" 	: $("input[name=trgterHandCd]:checked").val()
			 			,"trgterEduYear" 	: $("#trgterEduYear").val()
			 			,"trgterInmateName" : $("#trgterInmateName").val()
			 			,"trgterInmateYn" 	: $("input[name=trgterInmateYn]:checked").val()
			 			,"telNo1" 			: $("#telNo1").val()
			 			,"telNo2" 			: $("#telNo2").val()
			 			,"telNo3" 			: $("#telNo3").val()
			 			,"email" 			: $("#email").val()
			 			,"inmateTelNo1" 	: $("#inmateTelNo1").val()
			 			,"inmateTelNo2" 	: $("#inmateTelNo2").val()
			 			,"inmateTelNo3" 	: $("#inmateTelNo3").val()
			 			,"inmateEmail" 		: $("#inmateEmail").val()
			 			,"sido"				: $("#sido").val()
			 			,"sigungu"			: $("#sigungu").val()
			 			,"bname"			: $("#bname").val()
			 			,"zip_cd"			: $("#zip_cd").val()
			 			,"addr"				: $("#addr").val()
			 			,"addr2"			: $("#addr2").val()
		 } 
		 , "method" : "POST"
		 , "dataType" : "JSON"
		 , "success" : function(data){
				alert("수정되었습니다");
				modalHide();
				location.reload();
		 }
		 , "error" : function(data){
			alert("통신실패");
		 }
	});
}

//검사의뢰
function reqExamPage(){
	RNUMS = "";
	NAME = "";
	var PROC_NM = "";
	var PROC_CHK = "";
	if($("input[name=chk]:checked").length == 0){
		alert("대상자를 선택해주세요.");
		return;
	}
	$("input[name=chk]:checked").each(function(index,item){//선택한 체크박스의 차트번호와 검사진행여부(검사의뢰내역이있는지)확인
		var tr = $("input[name=chk]:checked").parent().parent().eq(index);
		var td =tr.children();
		var PROC = td.eq(9).text();
		NAME = td.eq(1).text();
		
		//차트번호
	    if(index!=0){
	    	RNUMS += ',';
		}
	    RNUMS += $(this).val();
	    
	    //검사진행여부
	    if(PROC == 'Y'){
	    	PROC_CHK = "Y"
	    	if(index!=0){
	    		PROC_NM += ', ';
	    		PROC_NM += NAME;
	    	}else{
	    		PROC_NM += NAME;
	    	}
	    }
	});
	
	if(PROC_CHK == "Y"){
		PROC_NM
		if(PROC_NM.substring(0,1) == ","){
			PROC_NM = PROC_NM.substring(2,PROC_NM.length)
		}
		alert(PROC_NM + " 님은 이미 검사의뢰 되어 있습니다.\n검사취소/완료 후 검사의뢰가 가능합니다.");
		return;
	}
	
	modalView("/alExam/tg/reqExamPopup.do");
}

//검사의뢰
function reqExam(){

	if(isNullToString($("input[name=examDiv]:checked").val()) == ""){
		alert("검사종류를 선택해주세요.");
 		return;
	}
	if(isNullToString($("#insExamId").val()) == ""){
		alert("검사자를 선택해주세요.");
 		return;
	}

	cfn.ajax({
		   "url" : "/tg/reqExam.do"
		 , "data" : {
			 			"RNUMS"			: RNUMS
			 			,"examDiv" 		: $("input[name=examDiv]:checked").val()
			 			,"examOrgCd" 	: $("#examOrgCd").val()
			 			,"reqExamId" 	: $("#reqExamId").val()
			 			,"reqExamDate" 	: $("#reqExamDate").val().replace(/-/gi,"")
			 			,"insExamId" 	: $("#insExamId").val()
			 			,"memo" 		: $("#memo").val()
			 			,"onoff"		: $("#onoff").val()
			 			,"testcheck"	: $("#testcheck").val()
			 			
		 } 
		 , "method" : "POST"
		 , "dataType" : "JSON"
		 , "success" : function(data){
			alert("검사의뢰 되었습니다");
			modalHide();
			location.reload();
		 }
		 , "error" : function(data){
			alert("통신실패");
		 }
	});
}

//modal닫기
$(document).on("click",".modalHide",function(){
	modalHide();
});

//checkbox 전체 선택 및 해제
function fn_checkAll(){
       if($("#checkAll").prop("checked")){
           //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
           $("input[name=chk]").prop("checked",true);
           //클릭이 안되있으면
       }else{
           //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
           $("input[name=chk]").prop("checked",false);
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
						document.getElementById('addr2').focus();
					}
				}).open();
	}
</script>

<div class="schbox">
	<ul>
		<li>
			<label for="date01">최종검사일자:</label>
			<input type="text" id="sDate" class="datepicker sDate"> ~ <input type="text" id="eDate" class="datepicker eDate">
			<label for="sel01" class="ml20">검사차수:</label>
			<select id="examSn">
			</select>
		</li>
		<li>
			<label for="idValue">이름(차트번호):</label>
			<input type="text" class="" id="idValue" onkeypress="passwdKeypress(event);"/>
			<label for="gender" class="ml20">성별:</label>
			<select id="gender">
			</select>
			<label for="ageGroup" class="ml20">연령대:</label>
			<select id="ageGroup">
			</select>
		</li>
	</ul>
	<a href="#" class="schbox_sch"><em class="btn_sch">조회</em></a>
</div>

<section class="mt35">
	<ul class="title_align">
		<li><h2>대상자목록</h2></li>
		<li><a href="#pop_new_input" class="btn_all new btn-layer" onclick="regTrgterInfoPage();" >신규등록</a>
			<a href="#pop_text_in" class="btn_all test btn-layer" onclick="reqExamPage();">검사의뢰</a></li>
	</ul>
	<table class="boardlist topb" id="tbsort">
		<caption>검사결과목록</caption>
		<colgroup>
			<col width="5%">
			<col width="15%">
			<col width="*">
			<col width="10%">
			<col width="7%">
			<col width="10%">
			<col width="10%">
			<col width="15%">
			<col width="15%">
		</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" id="checkAll" name="" onclick="fn_checkAll();" class="ck_cmd board"/><label for="checkAll"><span></span></label></th>
				<th scope="col">이름</th>
				<th scope="col">차트번호</th>
				<th scope="col">성별</th>
				<th scope="col">나이</th>
				<th scope="col">최종검사</th>
				<th scope="col">검사차수</th>
				<th scope="col">최종검사일자</th>
				<th scope="col">등록일자</th>
			</tr>
		</thead>
		<tbody id="list">
		</tbody>
	</table>
	<div class="paginate">
	</div>
</section>	
