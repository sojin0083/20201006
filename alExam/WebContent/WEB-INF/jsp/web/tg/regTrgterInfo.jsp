<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	$(document).ready(function() {

		datePickerFn();

		init();
	});

	function init() {
		//코드값으로 콤보박스 불러오기
		searchCmmnCd("#trgterEduYear", "CM011", "", "", "");
		searchCmmnCd("#inmateTelNo1", "CM014", "", "", "선택|null");
		searchCmmnCd("#telNo1", "CM014", "", "", "선택|null");

		getCNum()
	}

	function getCNum() {
		cfn.ajax({
			"url" : "/tg/getCNum.do",
			"data" : {
				"ORG_CD" : "${SESS_ORG_CD}"
			},
			"method" : "POST",
			"dataType" : "JSON",
			"success" : function(data) {
				$("#C_NUMBER").val(data.rsNum.C_NUMBER);
			},
			"error" : function(data) {
				alert("통신실패");
			}
		});
	}

	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		}
	}

	//나이자동계산
	function fn_calcAge() {
		$("#age").val(calcAge($("#bTrgterBirth").val()));
	}
</script>

<div id="regTrgterInfo" class="layer-wrap" style="display: inline;">
	<div class="pop-layer wid800" style="margin-left: 35%;">
		<ul class="pop_title_ul_box">
			<li><h2>대상자 등록</h2></li>
			<li><a href="#" class="btn-layerClose modalHide">Close</a></li>
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
						<th scope="col">이름</th>
						<td><input type="text" value="" id="trgterName" name="trgterName" style="width: 100%"></td>
						<th scope="col">차트번호</th>
						<td><input type="number" value="" id="C_NUMBER" maxlength="5" oninput="maxLengthCheck(this)" style="width: 100%"></td>
					</tr>
					<tr>
						<th scope="col">생년월일</th>
						<td colspan="3">
							<ul>
								<li><input type="date" value="" id="bTrgterBirth" name="bTrgterBirth" style="width: 150px" onchange="fn_calcAge()"></li>
								<input type="hidden" id="trgterBirth" name="trgterBirth" />
								<li>
								<input type="radio" name="trgterDivBirth" id="ar1" value="1"><label for="ar1">양력</label> 
								<input type="radio" name="trgterDivBirth" id="ar2" value="2"><label for="ar2">음력</label>
								</li>
								<li>만 <input type="text" value="" id="age" name="age" style="width: 30px" disabled> 세</li>
							</ul>
						</td>
					</tr>
					<tr>
						<th scope="col">성별</th>
						<td colspan="3">
						<input type="radio" name="trgterGender" id="m" value="M"><label for="m">남</label> 
						<input type="radio" name="trgterGender" id="f" value="F"><label for="f">여</label></td>
					</tr>
					<tr>
						<th scope="col">손잡이</th>
						<td>
						<input type="radio" name="trgterHandCd" id="f" value="R"><label for="r">오른손</label> 
						<input type="radio" name="trgterHandCd" id="l" value="L"><label for="l">왼손</label> 
						<input type="radio" name="trgterHandCd" id="rl" value="B"><label for="rl">양손</label></td>
						<th scope="col">교육년수</th>
						<td><select id="trgterEduYear" name="trgterEduYear" style="width: 100%">
						</select></td>
					</tr>
					<tr>
						<th scope="col">보호자명</th>
						<td><input type="text" value="" id="trgterInmateName" name="trgterInmateName" style="width: 100%"></td>
						<th scope="col">보호자동거여부</th>
						<td><input type="radio" name="trgterInmateYn" id="o" value="Y"><label for="o">동거</label> 
							<input type="radio" name="trgterInmateYn" id="n" value="N"><label for="n">비동거</label></td>
					</tr>
					<tr>
						<th scope="col">연락처</th>
						<td><select id="telNo1" name="telNo1" style="width: 31%"></select> 
						- <input type="number" maxlength="4" oninput="maxLengthCheck(this)" value="" id="telNo2" name="telNo2" style="width: 26%"> 
						- <input type="number" maxlength="4" oninput="maxLengthCheck(this)" value="" id="telNo3" name="telNo3" style="width: 26%"></td>
						<th scope="col">E-Mail</th>
						<td><input type="text" value="" id="email" name="email" style="width: 100%"></td>
					</tr>
					<tr>
					<th scope="col">보호자 연락처</th>
					<td><select id="inmateTelNo1" name="inmateTelNo1" style="width: 31%"></select>
					 - <input type="number" maxlength="4" oninput="maxLengthCheck(this)" value="" id="inmateTelNo2" name="telNo2" style="width: 26%">
					 - <input type="number" maxlength="4" oninput="maxLengthCheck(this)" value="" id="inmateTelNo3" name="telNo3" style="width: 26%"></td>
					<th scope="col">보호자 E-Mail</th>
					<td><input type="text" value="" id="inmateEmail" name="inmateEmail" style="width: 100%"></td>
					</tr>
					<tr>
						<th scope="col">우편번호</th>
						<td colspan="3"><input type="button" name="zip_cd" class="zip_cd" onclick="sample6_execDaumPostcode()" id="zip_cd" style="width: 50%" /><td>
					<tr>
						<th scope="col">주소</th>
						<td><input type="text" name="address1" class="addr" id="addr" readonly></td>
						<th scope="col">주소 상세</th>
						<td>
						<input type="text" name="address2" class="addr2" id="addr2">
						<input type="hidden" name="sido" id="sido" class="sido" readonly>
						<input type="hidden" name="sigungu" id="sigungu" class="sigungu" readonly>
						<input type="hidden" name="bname" id="bname" class="bname" readonly></td>
					</tr>
				</tbody>
			</table>

			<div class="btncenter">
				<a href="#" class="btn_all col01" onclick="fn_regTrgterInfoForm()">등록</a>
				<a href="#" class="btn_all modalHide">취소</a>
			</div>
		</div>
	</div>
</div>