<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var change;
var sessOrgCd = "${SESS_ORG_CD}";


	$(document).ready(function(){
		searchCmmnCd(".user_org_part","CM009","","","전체|null");
		searchCmmnCd(".user_job_clf","CM010","","","전체|null");
		searchCmmnCd(".user_gender","CM002","","","전체|null");
		searchCmmnCd(".user_use_yn","CM007","","");
		
		console.log(user_id);	
		console.log("-------------");	
	if(isNullToString(user_id)!=""){
		searchCmmnCd(".user_org_nm","TC_CM_ORG","","","","in|"+org_cd,false);
		$('.user_org_nm').attr('disabled', true);
		search();
		$(".userInfoReg").text("사용자 정보 변경");
		$(".btn_saves").text("저장");
		change="Y";
	}else{
		if("^T001".indexOf(sessOrgCd) > 0){
			searchCmmnCd(".user_org_nm","TC_CM_ORG","",orgCd,"전체","",false);
		}else{
			searchCmmnCd(".user_org_nm","TC_CM_ORG","","","","in|"+sessOrgCd,false);
			$('.user_org_nm').attr('disabled', true);
		}
		$(".userInfoReg").text("사용자 신규 등록");
		$(".btn_saves").text("등록");
		var endDate = getRecentDate();
		$(".user_regdit").text(endDate);
		change="N";
		}
	});

	//현재 날짜 불러오기
	function getRecentDate(){
	    var dt = new Date();
	    var recentYear = dt.getFullYear();
	    var recentMonth = dt.getMonth() + 1;
	    var recentDay = dt.getDate();
	 
	    if(recentMonth < 10) recentMonth = "0" + recentMonth;
	    if(recentDay < 10) recentDay = "0" + recentDay;
	 
	    return recentYear + "-" + recentMonth + "-" + recentDay;
	}
	
	
	function search(){
		cfn.ajax({
			  "url"			:	"/sm/userInfoSelect.do" 
			, "data"		:	{
								   "USER_ID"	:	user_id
								 , "ORG_CD"		:	org_cd
								 , "BIRTH"		:	birth
			}
			, "dataType"	: 	"json"
			, "method"		:	"POST"
			, "success"		: 	userInfoCre
		});
	}
	function userInfoCre(data){
		$(".user_nm").val(data.rsList.USER_NM);
		$(".user_org_part").val(data.rsList.ORG_PART);
		$(".user_job_clf").val(data.rsList.JOB_CLF);
		$(".user_gender").val(data.rsList.GENDER);
		$(".user_login_id").val(data.rsList.LOGIN_ID);
		$(".user_use_yn").val(data.rsList.USE_YN);
		$(".user_birth").val(data.rsList.BIRTH);
		$(".user_regdit").text(data.rsList.REG_DML_DT);
		$(".user_tel_1").val(data.rsList.TEL_NO_1);
		$(".user_tel_2").val(data.rsList.TEL_NO_2);
		$(".user_tel_3").val(data.rsList.TEL_NO_3);
		$(".user_id_reg").val(data.rsList.USER_ID);
		$(".user_pw").val(data.rsList.PW);
	}

</script>

<div id="user_mod" class="layer-wrap" style="display:inline;">
	<div class="pop-layer wid400" style="margin-left:32%;">
		<ul class="pop_title_ul_box">
		<li><h2 class="userInfoReg"></h2></li>
			<li>
				<a href="#" class="btn-layerClose">Close</a>
			</li>
		</ul>
	<div class="pop_input_box01">
	
		<table class="table_type dis topb">
			<colgroup>
				<col width="40%">
				<col width="60%">
			</colgroup>
			<tbody id="userList">
				<tr>
					<th scope="col">기관명</th>
					<td><select class="user_org_nm"></select></td>
	 		   </tr>
	 		  	<tr>
	 		  		<th scope="col">진료과</th>
	 		  		<td><select class="user_org_part"></select></td>
	 			</tr>
	 			<tr>
	 				<th scope="col">담당업무</th>
	 				<td><select class="user_job_clf"></select></td>
	 			</tr>
	 			<tr>
					<th scope="col">사용자명</th>
					<td><input type="text" class="user_nm" id="" placeholder=""></td>
				</tr>
				<tr>
					<th scope="col">사용여부</th>
					<td><select class="user_use_yn"></select>
				</tr>
				<tr>
					<th scope="col">성별</th>
					<td><select class="user_gender"></select></td>
				</tr>
				<tr>
					<th scope="col">생년월일</th>
	 		  		<td><input type="text" class="user_birth" maxlength="10"></td>
				</tr>
				<tr>
					<th scope="col">전화번호</th>
					<td><select class="user_tel_1" style="width:60px;">
	 		  		<option value="">전체</option>
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="019">019</option>
	 		  		</select>-<input type="text" style="width:50px;" class="user_tel_2" maxlength="4">-<input type="text" style="width:50px;" class="user_tel_3" maxlength="4"></td>
				</tr>
				<tr>
					<th scope="col">로그인_ID</th>
	 		  		<td><input type="text" class="user_login_id"></td>
				</tr>
				<tr>
					<th scope="col">PW</th>
	 		  		<td><input type="password" class="user_pw" /></td>
				</tr>
				 <tr>
			  		<th scope="col">등록일</th>
	 		  		<td class="user_regdit"></td>
			  	</tr>
	 		 </tbody>
		</table>
				<input type="hidden" class="user_id_reg" />
		<div class="btncenter">
					 <a href="#" class="btn_all btn_cancle">취소</a> <a href="" class="btn_all col01 btn_saves">저장</a>
				</div>
		</div>	
	</div>	
</div>