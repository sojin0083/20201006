<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
	
	$(document).ready(function(){
		searchCmmnCd(".trgter_gender","CM002","","","전체|null");
		searchCmmnCd(".trgter_year","CM008","","","전체|null");
		searchCmmnCd(".trgter_exam","SV001","","","전체|null");
		searchCmmnCd(".trgter_exam_sn","SV005","","","전체|null");
		datePickerFn();
		$('.TBGN_DE').val(getDateShift("",'M',-5,"YYYY-MM-DD"));			
		$('.TEND_DE').val(setDateFormat("","YYYY-MM-DD"));
		search();
	});
	
	function search(){
		cfn.ajax({
				  "url"			:	"/sv/trgterResultList.do"
				, "data"		:	{
										"EXAM_BGN_DE"		:		$(".TBGN_DE").val().replace(/\-/g,"")
									  , "EXAM_END_DE"		:		$(".TEND_DE").val().replace(/\-/g,"")
									  , "EXAM_SN"			:		$(".trgter_exam_sn").val()
									  , "GENDER"			:		$(".trgter_gender").val()
									  , "EXAM_DIV"			:		$(".trgter_exam").val()
									  , "NAME"				:		$("#trgter_nm").val()
									  , "YEAR"				:		$(".trgter_year").val()
				}
			 	, "dataType"	:	"json"
			 	, "method"		:	"POST"
			 	, "success"		:	searchList
		});
	}
	
	function searchList(data){
		$(".userReq").remove();
		$(".userNotReq").remove();
		var userTb = new StringBuffer();
		var userList = data.rsList.length;
		if(userList==0){
			userTb.append("<tr class='userNotReq'");
			userTb.append("<td colspan='8'></td>");
			userTb.append("<td colspan='8'>등록된 대상자가 없습니다.</td>");
			userTb.append("</tr>");
		}else{
		  for(var i=0;i<userList;i++){
			  userTb.append("<tr class='userReq tableUser' style='cursor:pointer;'>");
			  userTb.append("<td style='text-algin:center;' class='userReq'>"+data.rsList[i].EXAM_CMP_DATE+"</td>");
			  userTb.append("<td style='text-algin:center;' class='userReq'>"+data.rsList[i].NAME+"</td>");
			  userTb.append("<td style='text-algin:center;' class='userReq'>"+data.rsList[i].EXAM_SN+"차</td>");
			  userTb.append("<td style='text-algin:center; display:none;' class='userReq'>"+data.rsList[i].EXAM_SN+"</td>");
			  userTb.append("<td style='text-algin:center; display:none;' class='userReq'>"+data.rsList[i].R_NUMBER+"</td>");
			  if(data.rsList[i].C_NUMBER == undefined){
				  userTb.append("<td style='text-algin:center;' class='userReq'>-</td>");
			  }else{
				  userTb.append("<td style='text-algin:center;' class='userReq'>"+data.rsList[i].C_NUMBER+"</td>");	
      		  }
			  userTb.append("<td style='text-algin:center;' class='userReq'>"+data.rsList[i].GENDER+"</td>");
			  userTb.append("<td style='text-algin:center;' class='userReq'>"+data.rsList[i].AGE+"</td>");
			  userTb.append("<td style='text-algin:center;' class='userReq'>"+data.rsList[i].EXAM_DIV+"</td>");
			  userTb.append("<td style='text-algin:center;   display:none;' class='userReq'>"+data.rsList[i].EXAM_DIVV+"</td>");
			  userTb.append("<td style='text-algin:center;   display:none;' class='userReq'>"+data.rsList[i].EXAM_NO+"</td>");
			  userTb.append("<td  class='userButton'><a class='btn_style'>보기</a></td>");
			  
			  userTb.append("</tr>");
		  }
		}
		$("#userList").append(userTb.toString());
		fn_commonPagination(".regExamList",".pagination", 10, "1");
	}
	
	$(document).on("click",".btn_search",function(){
		search();
	});
	
	$(document).on('keypress', '#trgter_nm', function(e){
		if(e.keyCode == 13){
			search();
		}
	});
	
	$(document).on("click",".userButton",function(e){
		var R_Number  = $(this).parent().children().eq(4).text();
		var Exam_Sn   = $(this).parent().children().eq(3).text();
		var Exam_DIVV = $(this).parent().children().eq(9).text();
		var Exam_No   = $(this).parent().children().eq(10).text();
		$("#EXAM_NO").val(Exam_No);
		$("#R_NUMBER").val(R_Number);
		$("#EXAM_SN").val(Exam_Sn);
		$("#EXAM_DIV").val(Exam_DIVV);		
		$("#menuCd").val("${menuInfo.MENU_CD}");
		if(Exam_DIVV=="M"){
			$("#MENU_URL").val("/sv/trgterExamMReportPage.do");	   
		}
		if(Exam_DIVV=="L"){  
			$("#MENU_URL").val("/sv/trgterExamLReport.do");	   
		} 
		if(Exam_DIVV=="S"){
			$("#MENU_URL").val("/sv/trgterExamSReportPage.do");	   
		}  
	    $("#userInfoForm").attr("action", "/alExam/pageNavi.do");		    
	    $("#userInfoForm").submit();	
	});
	
	$(document).on("click","td.userReq",function(){
		var R_Number  = $(this).parent().children().eq(4).text();
		var Exam_Sn   = $(this).parent().children().eq(3).text();
		var Exam_DIVV = $(this).parent().children().eq(9).text();
		var Exam_No   = $(this).parent().children().eq(10).text();
		$("#EXAM_NO").val(Exam_No);
		$("#R_NUMBER").val(R_Number);
		$("#EXAM_SN").val(Exam_Sn);
		$("#EXAM_DIV").val(Exam_DIVV); 
		$("#menuCd").val("${menuInfo.MENU_CD}");
	    $("#MENU_URL").val("/sv/trgterExamLResultDtls.do");	   
		$("#userInfoForm").attr("action", "/alExam/pageNavi.do");		    
		$("#userInfoForm").submit();	
	
	});	
</script>

<form id="userInfoForm" method="POST">
	<input type="hidden" id="R_NUMBER" name="R_NUMBER"/>
	<input type="hidden" id="EXAM_SN" name="EXAM_SN" />
	<input type="hidden" id="EXAM_DIV" name="EXAM_DIV" />	
	<input type="hidden" id="EXAM_NO" name="EXAM_NO" />
	<input type="hidden" id="menuCd" name="menuCd" />
	<input type="hidden" id="MENU_URL" name="MENU_URL" />
</form>


<div class="schbox">
	<ul>
		<li>
			<label for="date01">검사완료일:</label>
				<input type="text" class="datepicker TBGN_DE" id="date01"  maxlength="10"/>
				~
				<input type="text" class="datepicker TEND_DE" id="date02"  maxlength="10"/>
				<label for="sel01" class="ml20" style="margin-right:2%;">검사차수:</label><select id="" class=" trgter_exam_sn"></select>	
		</li>
		<li>		
			<label for="name">이름(차트번호):</label>
			<input type="text" id="trgter_nm" />
			<label for="sel02" class="ml20">성별:</label>
			<select id="sel02" class="trgter_gender"></select>
			<label for="sel03" class="ml20">연령대:</label>
			<select id="sel03" class="trgter_year"></select>
		</li>
		<li>
			<label for="name">검사종류:</label>
			<select id="sel03" class="trgter_exam"></select>
		</li>
	</ul>	
	<a href="#" class="schbox_sch btn_search"><em id="" class="btn_sch">조회</em></a>
</div>
	<section class="mt35">
		<h2>검사결과목록</h2>
		<table class="boardlist topb">
			<caption>검사결과목록</caption>
			<colgroup>
				<col width="14%">
				<col width="11%">
				<col width="11%">
				<col width="*">
				<col width="11%">
				<col width="11%">
				<col width="13%">
				<col width="13%">
			</colgroup>	
			<thead>
				<tr>
					<th scope="col">검사완료일</th>
					<th scope="col">이름</th>
					<th scope="col">검사차수</th>
					<th scope="col">차트번호</th>
					<th scope="col">성별</th>
					<th scope="col">나이</th>
					<th scope="col">검사종류</th>
					<th scope="col">결과지보기</th>
				</tr>	
			</thead>
			<tbody id="userList">
			</tbody>	
		</table>
	<div class="paginate pagination">
	</div>
	</section>
