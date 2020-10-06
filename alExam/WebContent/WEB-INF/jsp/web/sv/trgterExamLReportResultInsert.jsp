<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

var exam_no="${EXAM_NO}";
var r_number="${R_NUMBER}";
var exam_sn="${EXAM_SN}";
var exam_div="${EXAM_DIV}";
var count=0;
var total=0;
var answer= new Array();
var answercddtls = new Array();
var answercd	= new Array();
var rmkanswer = new Array();
var examsize;
var mmseData;
var controllsize;
var yesone;
var noone;
var yestwo;
var notwo;
var oldexam_div;
var s_count=0;
var s_yesone;
var s_noone;
var s_yestwo;
var s_notwo;
var s_answer= new Array();
var s_answercddtls = new Array();
var s_answercd	= new Array();
var s_rmkanswer = new Array();

	$(document).ready(function(){
		searchCmmnCd("#examSttus", "SV002", "", "01", "전체|null");//진행상태
		oldexam_div=exam_div; //목록 쪽에서 들어올때 검사종류 저장
			if(oldexam_div=="M"){  
					$(".Mlica").addClass("current");
					$(".Exam_M_LICA").addClass("on");
					$(".lica").removeClass("current");
					$(".Exam_LICA").removeClass("on");
					$(".Slica").removeClass("current");
					$(".Exam_S_LICA").removeClass("on");
					$(".selectListinfo2").show();
					$(".selectListinfo").hide();
					$(".selectListinfo3").hide();
					$("#tab3").addClass("current");
					$("#tab1").removeClass("current");
					$("#tab2").removeClass("current");
					//MMSE 정보 불러오기
					getMmseList();
			}
			if(oldexam_div=="L"){    //목록에서 LINDA 클릭시 
					$(".lica").addClass("current");
					$(".Exam_LICA").addClass("on");
					$(".Mlica").removeClass("current");
					$(".Exam_M_LICA").removeClass("on");
					$(".Slica").removeClass("current");
					$(".Exam_S_LICA").removeClass("on");
					$("#tab1").addClass("current");
					$("#tab2").removeClass("current");
					$("#tab3").removeClass("current");
					$(".selectListinfo").show();
					$(".selectListinfo2").hide();
					$(".selectListinfo3").hide();
			}
			if(oldexam_div=="S"){		 //목록에서 SLINDA 클릭시 
				$(".Slica").addClass("current");
				$(".Exam_S_LICA").addClass("on");
				$(".Mlica").removeClass("current");
				$(".Exam_M_LICA").removeClass("on");
				$(".lica").removeClass("current");
				$(".Exam_LICA").removeClass("on");
				$("#tab2").addClass("current");
				$("#tab1").removeClass("current");
				$("#tab3").removeClass("current");
				$(".selectListinfo3").show();
				$(".selectListinfo2").hide();
				$(".selectListinfo").hide();
		}
			drawList2();   //SLINDA 그리기
			drawList();	    //LINDA 그리기
			ExamHistList();
		});

		//점수 초기화 이벤트
		$(document).on("click","#btn_reset",function(){
			pointSearch(); 
		});

		//mmseList데이터 불러오기
 		function getMmseList(){
			cfn.ajax({
				   "url"		:	"/sv/getMmseList.do" 
				 , "data"		:	{
									  "EXAM_NO"	:	exam_no
					}
				 , "dataType"	: 	"json"
				 , "method"		:	"POST"
				 , "success" : function(data){
					setMmsePoint(data.rsList)
				 }
				 , "error" : function(data){
					alert("통신실패");
				 }
			});
		} 
		
		//mmsetList셋팅(초기화)
		function setMmsePoint(data){
			if(data != "reset"){
				mmseData = data;
			}
			for(var i=0; i<mmseData.length; i++){
				var id = mmseData[i].EXAM_ITEM_CD + mmseData[i].EXAM_ITEM_CD_DTLS
				$("#" + id).val(mmseData[i].POINT);
			}
			//$("#mmseTotPoint").html(mmseData[0].TOT_POINT + "/30");
		//	$("#mmseTotPoint").val(mmseData[0].TOT_POINT);
		}

		//mmse점수변경 이벤트
		function mmseChangePoint(){
			var mmsePoint = 0;
		    $(".mmsePoint").each(function(){ 
		    	mmsePoint += parseInt($(this).val());
		    });
		    $("#mmseTotPoint").html(mmsePoint + "/30");
		    $("#mmseTotPoint").val(mmsePoint);
		};

	//mmse점수입력 
	function insertMmsePoint(){
		var mmseData = [];
		$(".mmsePoint").each(function(){
			var data = {
				 //ID를 EXAM_ITEM_CD + EXAM_ITME_CD_DTLS 로 만들었기에 분리해서 담아 보낸다
				 EXAM_ITEM_CD		: $(this).attr('id').substr(0,3)
				,EXAM_ITEM_CD_DTLS	: $(this).attr('id').substr(3,4)
				,POINT				: $(this).val()
			}
			mmseData.push(data);
		});
		var mmseDataList = JSON.stringify(mmseData);
		cfn.ajax({
			   "url"		:	"/sv/insertMmsePoint.do" 
			 , "data"		:	{
				 				   "R_NUMBER"	:	r_number
				 				  ,"EXAM_ITEM_NO"	:	1
								  ,"EXAM_NO"	:	exam_no
								  ,"TOT_POINT" : $("#mmseTotPoint").val()
								  ,"mmseDataList" : mmseDataList
				}
			 , "dataType"	: 	"json"
			 , "method"		:	"POST"
			 , "success" : function(data){
				 if(data > 0){
					 alert("저장되었습니다.");
					 location.reload();
					 MSttsChange(data.rsList);
				 }else{
					 alert("실패하였습니다. 관리자에게 문의하세요"); 
				 }
			 }
			 , "error" : function(data){
				alert("통신실패");
				}
		});
	}
	
	
	// 진행상태 변경
	function MSttsChange(){
			cfn.ajax({
				"url"	:	"/sv/MSttsChange.do",
				"data"	:	{"EXAM_NO"	:	exam_no},
				"method" : "POST",
				"dataType" : "JSON",
				"success" : function(data) {
					if (data.rsInt != 0){
						alert("저장되었습니다.");
						alert("실패");
						location.reload();
					}
					else {
						alert("실패");
					}
				},
				"error"	:	function(data) {
					alert("통신실패");
				}
			});
		} 
	
	
		function ExamHistList(){
		if(exam_div != oldexam_div){  //목록에서 불러온 검사종류랑  클릭시 검사종류 비교후 변경
			exam_div = oldexam_div;
		}
		cfn.ajax({
			  "url"			:	"/sv/trgterExamHistList.do" 
			, "data"		:	{
								  "R_NUMBER"	:	r_number
				 				 , "EXAM_NO"	:	exam_no
				 				 , "EXAM_DIV"	:	exam_div
				}
			, "dataType"	: 	"json"
			, "method"		:	"POST"
			, "success"		: 	ExamHistListSucc
			});
	}

	function pointSearch(){
		if(exam_div != oldexam_div){	//목록에서 불러온 검사종류랑  클릭시 검사종류 비교후 변경
			exam_div = oldexam_div;
		}
		cfn.ajax({
			  "url"			:	"/sv/trgterExamLResultInsertPoint.do"
			, "data"		:	{
									"R_NUMBER"	:r_number
								  , "EXAM_NO"	:exam_no
								  , "EXAM_DIV"	:exam_div
								  , "EXAM_SN"	:exam_sn
			}
		 	, "dataType"	:	"json"
		 	, "method"		:	"POST"
		 	, "success"		:	pointSearchSucc
		});
	}
	
	function drawList(){			//LINDA 그리기
		exam_div='L';
		cfn.ajax({
			  "url"			:	"/sv/trgterExamDrawKindsList.do"
			, "data"		:	{
									"R_NUMBER"	:r_number
								  , "EXAM_NO"	:exam_no
								  , "EXAM_DIV"	:exam_div
								  , "EXAM_SN"	:exam_sn
			}
		 	, "dataType"	:	"json"
		 	, "method"		:	"POST"
		 	, "success"		:	drawListSucc
		});
	}
	
	function drawList2(){		//SLINDA 그리기
		exam_div='S';
		cfn.ajax({
			  "url"			:	"/sv/trgterExamDrawKindsList.do"
			, "data"		:	{
									"R_NUMBER"	:r_number
								  , "EXAM_NO"	:exam_no
								  , "EXAM_DIV"	:exam_div
								  , "EXAM_SN"	:exam_sn
			}
		 	, "dataType"	:	"json"
		 	, "method"		:	"POST"
		 	, "success"		:	drawListSucc2
		});
	}	
	//항목별 세부정보 그리기 및 세부정보 결과상세  그리기 LINDA 그리기
	function drawListSucc(data){
						controllsize=data.examItemNm.length;
						var userTb = new StringBuffer();
						userTb.append("<ul class='title_align'>");
						userTb.append("<li><h2>항목별 세부정보</h2></li>");
						userTb.append("<li><a href='#pop_new_input' id='btn_reset' class='btn_all col01' style='margin-right: 10px;'>원점수 조회</a>");
						userTb.append("<a href='#pop_text_in' id='btn_update' class='btn_all btn_upd' style='margin-right: 10px;'>점수 수정</a>");
						userTb.append("<input type='checkbox' id='all'  name='' class='ck_cmd board all_List'/>");
						userTb.append("<label for='all'><span></span>전체 펼치기</label></li>");
						userTb.append("</ul>");
						userTb.append("<div class='accordion-box'>");
						userTb.append("<ul class='list'>");
		 for(var i=0;i<data.examItemNm.length;i++){
						userTb.append("<li>");
						userTb.append("<div class='title clickchange "+data.examItemNm[i].EXAM_ITEM_CD+"'>");
						userTb.append("<h3>"+data.examItemNm[i].EXAM_ITEM_NM+"</h3>");
		      if(data.examItemNm[i].EXAM_ITEM_CD=="L06"){
						userTb.append("<div class='right'><em>정답수 변환점수</em><input type='text'  readonly='readonly' class='clean tot_score2"+i+"'/><span>/15점</span></div>");
						userTb.append("<div class='right'><em>수행시간 변환점수</em><input type='text' readonly='readonly' class='clean tot_score"+i+"'/><span>/10점</span></div>");
		    } if(data.examItemNm[i].EXAM_ITEM_CD=="L10"){
						userTb.append("<div class='right'><em>예:</em><input type='text'  readonly='readonly' class='clean tot_score2"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE/2)+"점</span></div>");
						userTb.append("<div class='right'><em>아니요:</em><input type='text' readonly='readonly'  class='clean tot_score"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE/2)+"점</span></div>");
		 	} if(data.examItemNm[i].EXAM_ITEM_CD=="L12"){
						userTb.append("<div class='right' style='padding-right:5%;'><em>예:</em><input type='text'  readonly='readonly' class='clean tot_score2"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE/2)+"점</span></div>");
						userTb.append("<div class='right'><em>아니요:</em><input type='text'  readonly='readonly' class='clean tot_score"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE/2)+"점</span></div>");
		 	} if(data.examItemNm[i].EXAM_ITEM_CD!="L05" && data.examItemNm[i].EXAM_ITEM_CD!="L06" && data.examItemNm[i].EXAM_ITEM_CD!="L10" && data.examItemNm[i].EXAM_ITEM_CD!="L12"  && data.examItemNm[i].EXAM_ITEM_CD!="L14" ){
						userTb.append("<div class='right'><input type='text'  readonly='readonly' class='clean tot_score"+i+"'/><span>/"+data.examItemNm[i].TOT_SCORE+"점</span></div>");
			} if(data.examItemNm[i].EXAM_ITEM_CD=="L05"){
						userTb.append("<div class='right'><input type='text'  readonly='readonly' class='clean tot_score"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE*2)+"점</span></div>");
			} if(data.examItemNm[i].EXAM_ITEM_CD=="L14"){
						userTb.append("<div class='right'><div><em>의미모양-색깔-속성 총점:</em><input type='text' value=''  readonly='readonly' class='clean tot_score2"+i+"'/><span>/"+data.examItemNm[i].TOT_SCORE+"점</span></div>");
						userTb.append("<div class='mt5 btnright' style='margin-right: -10px;'><em>이름대기  총점:</em><input type='text' value='' readonly='readonly' class='clean tot_score"+i+"'/><span>/"+data.examItemNm[i].TOT_SCORE+"점<span></div>");
						userTb.append("</div>");
			}
						userTb.append("</div>");
						userTb.append("<div class='con_box EXAM_"+data.examItemNm[i].EXAM_ITEM_CD+" ALL_EXAM'>");
						userTb.append("</div>");
						userTb.append("</li>");
					}
						userTb.append("</ul>");
						$(".selectListinfo").append(userTb.toString());
						clickable();
						examsize = data.examItemNm.length;
		//세부정보 그리기	
		for(var i=0;i<data.examItemNm.length;i++){
			if(data.examItemNm[i].EXAM_ITEM_CD=="L01"){
						var userTb = new StringBuffer();
						userTb.append("<table class='boardlist'>");
						userTb.append("<caption>검사결과목록</caption>");
						userTb.append("<colgroup>");
						userTb.append("<col width=25%>");
						userTb.append("<col width=25%>");
						userTb.append("<col width=25%>");
						userTb.append("<col width=25%>");
						userTb.append("</colgroup>");
						userTb.append("<thead>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' colspan='2'>병전(원래)기능에 대한 보호자 보고</th>");
						userTb.append("<th scope='col' colspan='2'>환자검사</th>");
						userTb.append("</tr>");
						userTb.append("<tr>");
						userTb.append("<td>쓰기</td>");
						userTb.append("<td>읽기</td>");
						userTb.append("<td>쓰기</td>");
						userTb.append("<td>읽기</td>");
						userTb.append("</tr>");
						userTb.append("</thead>");
						userTb.append("<tbody>");
						userTb.append("<tr>");
						userTb.append("<td>");
						userTb.append("<select class='wid50 searchList answers"+(count++)+"'></select>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' />");
						userTb.append("</td>");
						userTb.append("<td>");
						userTb.append("<select class='wid50 searchList answers"+(count++)+"'></select>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					    userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' />");
						userTb.append("</td>");
						userTb.append("<td>");
						userTb.append("<select class='wid50 searchList answers"+(count++)+"'></select>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					    userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' />");
						userTb.append("</td>");
						userTb.append("<td>");
						userTb.append("<select class='wid50 searchList answers"+(count++)+"'></select>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' />");
						userTb.append("</td>");
						userTb.append("</tr>");
						userTb.append("</tbody>");
						userTb.append("</table>");
						userTb.append("</div>");
						$(".EXAM_L01").append(userTb.toString());
			}
			
 		//1.이야기회상-즉각회상-그리기 끝
		if(data.examItemNm[i].EXAM_ITEM_CD=="L02"){
						var userTb = new StringBuffer();
						userTb.append("<table class='boardlist'>");
						userTb.append("<caption>검사결과목록</caption>");
						userTb.append("<colgroup>");
						userTb.append("<col width='10%'>");
						userTb.append("<col width='45%'>");
						userTb.append("<col width='15%'>");
						userTb.append("<col width='15%'>");
						userTb.append("<col width='15%'>");
						userTb.append("</colgroup>");
						userTb.append("<thead>");
						userTb.append("<tr>");
						userTb.append("<th scope='col'>번호</th>");
						userTb.append("<th scope='col'>이야기</th>");
						userTb.append("<th scope='col' colspan='3'>점수</th>");
						userTb.append("</tr>");
						userTb.append("</thead>");
						userTb.append("<tbody>");
		  for(var j=0;j<20;j++){
						userTb.append("<tr class='answer"+(count++)+"'>");
						userTb.append("<td class='bg'>"+(j+1)+"</td>");
						userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
						userTb.append("<td><button class='dscore proce btn_all tabtn'></button></td>");
						userTb.append("<td><button class='ascore proce btn_all tabtn'></button></td>");
						userTb.append("<td><button class='bscore proce btn_all tabtn'></button></td>");
						userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>"); 
						userTb.append("</tr>");
			}
						userTb.append("</tbody>");
						userTb.append("</table>");	
						userTb.append("</div>");
						$(".EXAM_L02").append(userTb.toString());
		}
		
 		//2.막대구성
		if(data.examItemNm[i].EXAM_ITEM_CD=="L03"){
				 		var userTb = new StringBuffer();
						 userTb.append("<table class='boardlist'>");
						 userTb.append("<caption>검사결과목록</caption>");
						 userTb.append("<colgroup>");
				 		 userTb.append("<col style='width:10%'>");
					 	 userTb.append("<col style='width:45%'>");
						 userTb.append("<col style='width:15%'>");
						 userTb.append("<col style='width:15%'>");
						 userTb.append("<col style='width:15%'>");
						 userTb.append("</colgroup>");
						 userTb.append("<thead>");
						 userTb.append("<tr>");
						 userTb.append("<th scope='col'>순서</th>");
						 userTb.append("<th scope='col'>채점용</th>");
						 userTb.append("<th scope='col' colspan='3'>점수</th>");
						 userTb.append("</tr>");
						 userTb.append("</thead>");
						 userTb.append("<tbody>");
		  for(var j=0;j<10;j++){
						userTb.append("<tr class='answer"+(count++)+"'>");
						userTb.append("<td class='bg'>"+(j+1)+"</td>");
						userTb.append("<td class='bg'><img style='width:100px; height:100px;margin-left:30px;' src='"+ABSOLUTE_URL+"/images/web/question/LICA_"+(j+1)+".png'</td>");
						userTb.append("<td><button class='dscore proce btn_all tabtn'></button></td>");
						userTb.append("<td><button class='ascore proce btn_all tabtn'></button></td>");
						userTb.append("<td><button class='bscore proce btn_all tabtn'></button></td>");
						userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' id=''/>");
						userTb.append("</tr>");
			}
						userTb.append("</tbody>");
						userTb.append("</table>");	
						userTb.append("</div>");
						$(".EXAM_L03").append(userTb.toString());
		}
 		
 		//3.단어회상-즉각회상
		if(data.examItemNm[i].EXAM_ITEM_CD=="L04"){
			 for(var z=1;z<4;z++){
				 var userTb = new StringBuffer();
			  if(z==1){
						userTb.append("<div style='width:48.8%;'>");
					 	userTb.append("<table class='boardlist'>");
					 	userTb.append("<caption>검사결과목록</caption>");
						userTb.append("<colgroup>");
						userTb.append("<col width='10%'>");
						userTb.append("<col width='*'>");
						userTb.append("<col width='28%'>");
						userTb.append("<col width='28%'>");
						userTb.append("</colgroup>");
						userTb.append("<thead>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' rowspan='2'>번호</th>");
						userTb.append("<th scope='col' rowspan='2'>항목</th>");
						userTb.append("<th scope='col' colspan='2'>시행"+z+"</th>");
						userTb.append("</tr>");
						userTb.append("<tr class='blb_r'>");
						userTb.append("<th colspan='2'>점수</th>");
						userTb.append("</tr>");
						userTb.append("</thead>");
						userTb.append("<tbody class='bb'>");
				 for(var j=20;j<30;j++){
						userTb.append("<tr class='answer"+(count++)+"'>");
						userTb.append("<td class='bg'>"+(j-19)+"</td>");
						userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
						userTb.append("<td><button class='dscore proce btn_all tabtn'></button></td>");
						userTb.append("<td><button class='bscore proce btn_all tabtn'></button></td>");
						userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' id=''/>");
						userTb.append("</tr>");
					}
						userTb.append("</tbody>");
						userTb.append("</table>");
						userTb.append("</div>");
						$(".EXAM_L04").append(userTb.toString());
				}else {
						userTb.append("<div style='width:25%; margin-left:0.5%;'>");
						userTb.append("<table class='boardlist'>");
						userTb.append("<thead>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' class='blb' colspan='2'>시행"+z+"</th>");
						userTb.append("</tr>");
						userTb.append("<tr>");
						userTb.append("<th colspan='2'>점수</th>");
						userTb.append("</tr>");
						userTb.append("</thead>");
						userTb.append("<tbody>");
			     for(var j=20;j<30;j++){
						userTb.append("<tr class='answer"+(count++)+"'>");
						userTb.append("<td><button class='dis dscore proce btn_all tabtn'></button></td>");
						userTb.append("<td><button class='dis bscore proce btn_all tabtn'></button></td>");
						userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' id=''/>");
						userTb.append("</tr>");
				}
						userTb.append("</tbody>");
						userTb.append("</table>");
						userTb.append("</div>");
					    $(".EXAM_L04").append(userTb.toString());
				}
			 }
		}
 		
 		//4.시공간주의력
		if(data.examItemNm[i].EXAM_ITEM_CD=="L05"){
						$(".EXAM_L05").addClass("w3");
			for(z=1;z<5;z++){
						 var userTb = new StringBuffer();
				if(z==1){
						userTb.append("<div style='width:57.4%;'>");
						userTb.append("<table class='boardlist selecttablefive"+z+"'>");
						userTb.append("<caption>검사결과목록</caption>");
						userTb.append("<colgroup>");
						userTb.append("<col width='10%'>");
						userTb.append("<col width='*'>");
						userTb.append("<col width='23%'>");
						userTb.append("<col width='23%'>");
						userTb.append("</colgroup>");
						userTb.append("<thead>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' colspan='4'>4-1)바로 따라하기</th>");
						userTb.append("</tr>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' rowspan='2'>번호</th>");
						userTb.append("<th scope='col' rowspan='2'>항목</th>");
						userTb.append("<th scope='col' colspan='2'>시행"+z+"</th>");
						userTb.append("</tr>");
						userTb.append("<tr class='blb_r'>");
						userTb.append("<th colspan='2'>점수</th>");
						userTb.append("</tr>");
						userTb.append("</thead>");
						userTb.append("<tbody class='selecttablefive"+z+"'>");
		for(var j=50;j<57;j++){
						userTb.append("<tr class='answer"+(count++)+"'>");
						userTb.append("<td class='bg'>"+(j-49)+"</td>");
						userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
						userTb.append("<td><button class='dscore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");
						if(j==50){
						userTb.append("<td><button class='escore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");
						}
						else{
						userTb.append("<td><button name='fourcheck' class='bscore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");	
						}
						userTb.append("<input type='hidden' name='fourcheck' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' name='missingfour' class='totanswer"+(count-1)+"' id=''/>");
						
						userTb.append("</tr>");
				 }
						userTb.append("</tbody>");
						userTb.append("</table>");
						userTb.append("</div>");
						$(".EXAM_L05").append(userTb.toString());
		  }else if(z==2){
						userTb.append("<div style='width:42%; margin-left:0.5%;'>");
						userTb.append("<table class='boardlist selecttablefive"+z+"'>");
						userTb.append("<caption>검사결과목록</caption>");
						userTb.append("<colgroup>");
						userTb.append("<col width='*'>");
						userTb.append("<col width='25%'>");
						userTb.append("<col width='25%'>");
						userTb.append("</colgroup>");
						userTb.append("<thead>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' colspan='3'>&nbsp;</th>");
						userTb.append("</tr>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' rowspan='2' class='blb'>항목</th>");
						userTb.append("<th scope='col' colspan='2'>시행"+z+"</th>");
						userTb.append("</tr>");
						userTb.append("<tr>");
						userTb.append("<th style='border-left: 1px solid #dbdbdb;' colspan='2'>점수</th>");
						userTb.append("</tr>");
						userTb.append("</thead>");
						userTb.append("<tbody class='selecttablefive"+z+"'>");
			for(var j=57;j<64;j++){
				userTb.append("<tr class='answer"+(count++)+"'>");
						userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
						userTb.append("<td><button name='fourcheck' class='dscore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");
						if(j==57){
						userTb.append("<td><button name='fourcheck' class='escore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");
						}
						else{
						userTb.append("<td><button name='fourcheck' class='bscore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");	
						}
						userTb.append("<input type='hidden' name='fourcheck' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' name='missingfour' class='totanswer"+(count-1)+"' id=''/>");
						userTb.append("</tr>");
				}
						userTb.append("</tbody>");
						userTb.append("</table>");
						userTb.append("</div>");
						$(".EXAM_L05").append(userTb.toString());
			}else if(z==3){
						userTb.append("<div style='width:57.4%;'>");
						userTb.append("<table class='boardlist selecttablefive"+z+"'>");
						userTb.append("<caption>검사결과목록</caption>");
						userTb.append("<colgroup>");
						userTb.append("<col width='10%'>");
						userTb.append("<col width='*'>");
						userTb.append("<col width='23%'>");
						userTb.append("<col width='23%'>");
						userTb.append("</colgroup>");
						userTb.append("<thead>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' colspan='4'>4-2)거꾸로 따라하기</th>");
						userTb.append("</tr>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' rowspan='2'>번호</th>");
						userTb.append("<th scope='col' rowspan='2'>항목</th>");
						userTb.append("<th scope='col' colspan='2'>시행"+(z-2)+"</th>");
						userTb.append("</tr>");
						userTb.append("<tr class='blb_r'>");
						userTb.append("<th colspan='2'>점수</th>");
						userTb.append("</tr>");
						userTb.append("</thead>");
						userTb.append("<tbody class='selecttablefive"+z+"'>");
		      for(var j=64;j<71;j++){
						userTb.append("<tr class='answer"+(count++)+"'>");
						userTb.append("<td class='bg'>"+(j-56)+"</td>");
						userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
						userTb.append("<td><button name='fourtwocheck' class='dscore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");
						if(j==64){
						userTb.append("<td><button name='fourtwocheck' class='escore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");
						}
						else{
						userTb.append("<td><button name='fourtwocheck' class='bscore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");	
						}
						userTb.append("<input type='hidden' name='fourtwoCheckbox' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' name='missingfourtwo' class='totanswer"+(count-1)+"' id=''/>");
						userTb.append("</tr>");
				 }
						userTb.append("</tbody>");
						userTb.append("</table>");
						userTb.append("</div>");
						$(".EXAM_L05").append(userTb.toString());
		    }else if(z==4){
						userTb.append("<div style='width:42%; margin-left:0.5%;'>");
						userTb.append("<table class='boardlist selecttablefive"+z+"'>");
						userTb.append("<caption>검사결과목록</caption>");
						userTb.append("<colgroup>");
						userTb.append("<col width='*'>");
						userTb.append("<col width='20%'>");
						userTb.append("<col width='20%'>");
						userTb.append("</colgroup>");
						userTb.append("<thead>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' colspan='3'>&nbsp;</th>");
						userTb.append("</tr>");
						userTb.append("<tr>");
						userTb.append("<th scope='col' class='blb' rowspan='2'>항목</th>");
						userTb.append("<th scope='col' colspan='2'>시행"+(z-2)+"</th>");
						userTb.append("</tr>");
						userTb.append("<tr>");
						userTb.append("<th colspan='2'>점수</th>");
						userTb.append("</tr>");
						userTb.append("</thead>");
						userTb.append("<tbody class='selecttablefive"+z+"'>");
		       for(var j=71;j<78;j++){
						userTb.append("<tr class='answer"+(count++)+"'>");
						userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
						userTb.append("<td><button name='fourtwocheck' class='dscore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");
						if(j==71){
						userTb.append("<td><button name='fourtwocheck' class='escore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");
						}
						else{
						userTb.append("<td><button name='fourtwocheck' class='bscore controllbtn"+(count-1)+" proce btn_all tabtn'></button></td>");	
						}
						userTb.append("<input type='hidden' name='fourtwoCheckbox' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						userTb.append("<input type='hidden' value='' name='missingfourtwo' class='totanswer"+(count-1)+"' id=''/>");
						userTb.append("</tr>");
				}
						userTb.append("</tbody>");
						userTb.append("</table>");
						userTb.append("</div>");
						$(".EXAM_L05").append(userTb.toString());
			}
		}
	}
 		
		//5.숫자 스트룹
		if(data.examItemNm[i].EXAM_ITEM_CD=="L06"){
			for(var z=1;z<3;z++){
						 var userTb = new StringBuffer();
			 if(z==1){
						 userTb.append("<div style='width:50.4%;'>");
						 userTb.append("<table class='boardlist'>");
						 userTb.append("<caption>검사결과목록</caption>");
						 userTb.append("<colgroup>");
						 userTb.append("<col width='10%'>");
						 userTb.append("<col width='*'>");
						 userTb.append("<col width='30%'>");
						 userTb.append("<col width='30%'>");
						 userTb.append("</colgroup>");
						 userTb.append("<thead>");
						 userTb.append("<tr>");
						 userTb.append("<th scope='col'>번호</th>");
						 userTb.append("<th scope='col' colspan='2'>항목</th>");
						 userTb.append("<th scope='col'>시행"+z+"</th>");
						 userTb.append("</tr>");
						 userTb.append("</thead>");
						 userTb.append("<tbody>");
			for(var j=78;j<81;j++){
				if(j==78){
						 userTb.append("<tr class='answer"+(count++)+"'>");
						 userTb.append("<td class='bg'>"+(j-77)+"</td>");
						 userTb.append("<td rowspan='3'><img style='width:100px; height:100px;' src='"+ABSOLUTE_URL+"/images/web/question/LICA_5_1.jpg'/></td>");
						 userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
						 userTb.append("<td><input type='text' value='' class='totanswer"+(count-1)+"' disabled='disabled'/></td>");
						 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
						 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
						 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
						 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' id=''/>");
						 userTb.append("</tr>");
				}
			 if(j==79){
					 data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM="오답 수(0-50)";
					 userTb.append("<tr>");
					 userTb.append("<td class='bg'>"+(j-77)+"</td>");
					 userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' disabled='disabled' value=''/></td>");
					 userTb.append("</tr>");
			 }
			 if(j==80){
					 data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM="수행시간";	
					 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-77)+"</td>");
					 userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' value='' maxlength='3' class='succTot"+(count-1)+"' /></td>");
					 userTb.append("<input type='hidden' value='' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' id=''/>");
			 	}
			 }
					 userTb.append("</tbody>");
				 	 userTb.append("</table>");
					 userTb.append("</div>");
					 $(".EXAM_L06").append(userTb.toString());
			}
			else{
					 userTb.append("<div style='width:49%; margin-left:0.5%;'>");
					 userTb.append("<table class='boardlist'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='*'>");
					 userTb.append("<col width='30%'>");
					 userTb.append("<col width='30%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col' colspan='2'>항목</th>");
					 userTb.append("<th scope='col'>시행"+z+"</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody>");
		for(var j=78;j<81;j++){
		   if(j==78){
					 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td rowspan='3'><img style='width:100px; height:100px;' src='"+ABSOLUTE_URL+"/images/web/question/LICA_5_1.jpg'/></td>");
					 userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><select style='width:100px; height:26px;' name='collection' class='wid50 correct'></select></td>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"' id=''/>");
					 userTb.append("<input type='hidden' value='' class='answer"+(count-1)+" answers"+(count-1)+"' disabled='disabled'/>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("</tr>");
					}
		  if(j==79){
					 data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM="오답 수(0-50)";
					 userTb.append("<tr>");
				     userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' disabled='disabled' value=''/></td>");
					 userTb.append("</tr>");
			 }
		  if(j==80){
				 	 data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM="수행시간";	
					 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' value='' maxlength='3' class='succTot"+(count-1)+"'/></td>");
					 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					 	}
			 }
					 userTb.append("</tbody>");
					 userTb.append("</table>");
					 userTb.append("</div>");
					 $(".EXAM_L06").append(userTb.toString());
			}
		}
	}
		
		//6.계산
		if(data.examItemNm[i].EXAM_ITEM_CD=="L07"){
					var title='더하기';
		  for(var z=1;z<3;z++){
					var userTb = new StringBuffer();
			if(z==1){
					 userTb.append("<div style='width:57.4%;'>");
					 userTb.append("<table class='boardlist selecttablesix'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='15%'>");
					 userTb.append("<col width='10%'>");
					 userTb.append("<col width='*%'>");
					 userTb.append("<col width='12%'>");
					 userTb.append("<col width='12%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col' rowspan='2'>영역</th>");
					 userTb.append("<th scope='col' rowspan='2'>번호</th>");
					 userTb.append("<th scope='col' colspan='3'>시행"+z+"</th>");
					 userTb.append("</tr>");
					 userTb.append("<tr class='blb_r'>");
					 userTb.append("<th scope='col'>항목</th>");
					 userTb.append("<th scope='col' colspan='2'>점수</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody class='selecttablesix'>");
			for(var j=82;j<94;j++){
				if(j>=85 && j<88){
					title='빼기';
				}
				if(j>=88 && j<91){
					title='곱하기';
				}
				if(j>=91){
					title='나누기';
				}
				     userTb.append("<tr class='answer"+(count++)+"'>");
				 if(j % 3 == 1){
				 	 userTb.append("<td class='bg' rowspan='3'>"+title+"</td>");
				 }
					 userTb.append("<td style='border-left: 1px solid #dbdbdb;' class='bg'>"+(j-81)+"</td>");
					 userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><button class='dscore proce btn_all tabtn controllbtn"+(count-1)+"'></button></td>");
					 userTb.append("<td><button class='bscore proce btn_all tabtn controllbtn"+(count-1)+"'></button></td>");
					 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					 userTb.append("</tr>");
				}
				     userTb.append("</tbody>");
				 	 userTb.append("</table>");
				 	 userTb.append("</div>");
				 	 $(".EXAM_L07").append(userTb.toString());
				}else {
					 userTb.append("<div style='width:42%; margin-left:0.5%;'>");
					 userTb.append("<table style='height : fit-content;' class='boardlist selecttablesixtwo'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='*'>");
					 userTb.append("<col width='15%'>");
					 userTb.append("<col width='15%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col' colspan='3'>시행"+z+"</th>");
					 userTb.append("</tr>");
					 userTb.append("<tr class='blb_r'>");
					 userTb.append("<th scope='col'>항목</th>");
					 userTb.append("<th scope='col' colspan='2'>점수</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody class='selecttablesixtwo'>");
			for(var j=82;j<94;j++){
					 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><button class='dscore proce btn_all tabtn controllbtn"+(count-1)+"'></button></td>");
					 userTb.append("<td><button class='bscore proce btn_all tabtn controllbtn"+(count-1)+"'></button></td>");
					 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					 userTb.append("</tr>");
			   }
					 userTb.append("</tbody>");
					 userTb.append("</table>");
				 	 userTb.append("</div>");
				 	 $(".EXAM_L07").append(userTb.toString());
				}
			}
		}
		
		//7.이야기회상-지연회상
		if(data.examItemNm[i].EXAM_ITEM_CD=="L08"){
					var userTb = new StringBuffer();
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='10%'>");
					userTb.append("<col width='45%'>");
					userTb.append("<col width='15%'>");
					userTb.append("<col width='15%'>");
					userTb.append("<col width='15%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>이야기</th>");
					userTb.append("<th scope='col' colspan='3'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		 for(var j=0;j<20;j++){
					userTb.append("<tr class='answer"+(count++)+"'>");
					userTb.append("<td class='bg'>"+(j+1)+"</td>");
					userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					userTb.append("<td><button class='dscore proce btn_all tabtn'></button></td>");
					userTb.append("<td><button class='ascore proce btn_all tabtn'></button></td>");
					userTb.append("<td><button class='bscore proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					userTb.append("</tr>");
			}
					userTb.append("</tbody>");
					userTb.append("</table>");	
					userTb.append("</div>");
					$(".EXAM_L08").append(userTb.toString());
		}

		//8.이야기회상-재인
		if(data.examItemNm[i].EXAM_ITEM_CD=="L09"){
					var userTb = new StringBuffer();
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='10%'>");
					userTb.append("<col width='*'>");
					userTb.append("<col width='15%'>");
					userTb.append("<col width='15%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>질문</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		 for(var j=126;j<136;j++){
					 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td>"+(j-125)+"</td>");
					 userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><button class='dscore proce btn_all tabtn'></button></td>");
					 userTb.append("<td><button class='bscore proce btn_all tabtn'></button></td>");
					 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					 userTb.append("</tr>");				
			}
					 userTb.append("</tbody>");
					 userTb.append("</table>");	
				 	$(".EXAM_L09").append(userTb.toString());
		}
		
		//9.막대재인
		if(data.examItemNm[i].EXAM_ITEM_CD=="L10"){
					var userTb = new StringBuffer();
					userTb.append("<div style='width:49.7%;'>");
					userTb.append("<table class='boardlist' >");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='30%'>");
					userTb.append("<col width='35%'>");
					userTb.append("<col width='35%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody class='selecttableten'>");
		 for(var j=136;j<146;j++){
					 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TP"){
					 userTb.append("<td class='focus_bg' value='1'><button class='yesbtn"+j+" proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='nofocus_bg' value='0'><button class='nobtn"+j+" proce btn_all tabtn'></button></td>");
			 }
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TN"){
					 userTb.append("<td class='nofocus_bg' value='0'><button class='yesbtn"+j+" proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='focus_bg' value='1'><button class='nobtn"+j+" proce btn_all tabtn'></button></td>");
			 }
					 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					 userTb.append("</tr>");
		 		}
					 userTb.append("</tbody>");
					 userTb.append("</table>");
					 userTb.append("</div>");
					 userTb.append("<div style='width:49.7%; margin-left:0.5%;'>");
					 userTb.append("<table class='boardlist'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='30%'>");
				 	 userTb.append("<col width='35%'>");
					 userTb.append("<col width='35%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col'>번호</th>");
					 userTb.append("<th scope='col' colspan='2'>점수</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody class='selecttableten'>");
		for(var j=146;j<156;j++){
					 userTb.append("<tr class='answer"+(count++)+"'>");
				     userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TP"){
					 userTb.append("<td class='focus_bg' value='1'><button class='yesbtn"+j+" proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='nofocus_bg' value='0'><button class='nobtn"+j+" proce btn_all tabtn'></button></td>");
			 }
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TN"){
					 userTb.append("<td class='nofocus_bg' value='0'><button class='yesbtn"+j+" proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='focus_bg' value='1'><button class='nobtn"+j+" proce btn_all tabtn'></button></td>");
			 }
					 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					 userTb.append("</tr>");
			 	}
					 userTb.append("</tbody>");
					 userTb.append("</table>");	
					 $(".EXAM_L10").append(userTb.toString());
			}
		
		//10.단어회상-지연회상
		if(data.examItemNm[i].EXAM_ITEM_CD=="L11"){
					var userTb = new StringBuffer();
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='10%'>");
					userTb.append("<col width='*'>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='20%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>항목</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		 for(var j=156;j<166;j++){
					userTb.append("<tr class='answer"+(count++)+"'>");
					userTb.append("<td class='bg'>"+(j-155)+"</td>");
					userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					userTb.append("<td><button class='dscore proce btn_all tabtn'></button></td>");
					userTb.append("<td><button class='bscore proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
				    userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
				    userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					userTb.append("</tr>");
			 }
				 	userTb.append("</tbody>");
				 	userTb.append("</table>");	
				 	$(".EXAM_L11").append(userTb.toString());
			}
		
		//11.단어회상-재인
		if(data.examItemNm[i].EXAM_ITEM_CD=="L12"){
					var userTb = new StringBuffer();
					userTb.append("<div style='width:49.7%;'>");
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='10%'>");
					userTb.append("<col width='*'>");
					userTb.append("<col width='25%'>");
					userTb.append("<col width='25%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>번호</th>");	
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody class='selecttableeleven'>");
		 for(var j=166;j<176;j++){
					 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-165)+"</td>");
					 userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TP"){
					 userTb.append("<td class='focus_bg' value='1'><button class='yesbtn"+j+" proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='nofocus_bg' value='0'><button class='nobtn"+j+" proce btn_all tabtn'></button></td>");
			 }
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TN"){
					 userTb.append("<td class='nofocus_bg' value='0'><button class='yesbtn"+j+" proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='focus_bg' value='1'><button class='nobtn"+j+" proce btn_all tabtn'></button></td>");
			 }
					 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					 userTb.append("</tr>");
		 		}
					 userTb.append("</tbody>");
					 userTb.append("</table>");
					 userTb.append("</div>");
					 userTb.append("<div style='width:49.7%; margin-left:0.5%;'>");
					 userTb.append("<table class='boardlist'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='10%'>");
					 userTb.append("<col width='*'>");
					 userTb.append("<col width='25%'>");
					 userTb.append("<col width='25%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col'>번호</th>");
					 userTb.append("<th scope='col'>번호</th>");	
					 userTb.append("<th scope='col' colspan='2'>점수</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody class='selecttableeleven'>");
		for(var j=176;j<186;j++){
				 	 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-175)+"</td>");
			    	 userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TP"){
					 userTb.append("<td class='focus_bg' value='1'><button class='yesbtn"+j+" proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='nofocus_bg' value='0'><button class='nobtn"+j+" proce btn_all tabtn'></button></td>");
			 }
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TN"){
					 userTb.append("<td class='nofocus_bg' value='0'><button class='yesbtn"+j+" proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='focus_bg' value='1'><button class='nobtn"+j+" proce btn_all tabtn'></button></td>");
			 }
					 userTb.append("<input type='hidden' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='totanswer"+(count-1)+"'/>");
					 userTb.append("</tr>");
			 	}
					 userTb.append("</tbody>");
					 userTb.append("</table>");	
					 userTb.append("</div>");
					 $(".EXAM_L12").append(userTb.toString());
			}	
		
		//12.단어유창성-동물이름대기
		if(data.examItemNm[i].EXAM_ITEM_CD=="L13"){
					var userTb = new StringBuffer();
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='15%'>");
					userTb.append("<col width='*'>");
					userTb.append("<col width='25%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>항목</th>");	
					userTb.append("<th scope='col' colspan='2'>갯수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		 for(var j=186;j<190;j++){
					 userTb.append("<tr class='answer"+(count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-185)+"</td>");
				     userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' value='' class='totanswer"+(count-1)+"'/></td>");
					 userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='answertext"+(count-1)+" answers"+(count-1)+"' maxlength='3'/>");
					 userTb.append("</tr>");
		 }
					 userTb.append("</tbody>");
					 userTb.append("</table>");	
				 	 $(".EXAM_L13").append(userTb.toString());
			}
		
		//의미 모양-색깔 속성/이름대기
		if(data.examItemNm[i].EXAM_ITEM_CD=="L14"){
					var userTb = new StringBuffer();
					userTb.append("<div style='width:49.7%;'>");
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='30%'>");
					userTb.append("<col width='30%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col' class='blb' colspan='4'>의미 모양-색깔 속성 검사</th>");
					userTb.append("</tr>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>항목</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		for(var j=190;j<205;j++){	
					userTb.append("<tr class='answer"+(count++)+"'>");
				    userTb.append("<td class='bg' style='border-left: 1px solid #dbdbdb;'>"+(j-189)+"</td>");
					userTb.append("<td class='bg' style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					userTb.append("<td><button name='thirteenonecheck' class='dscore proce btn_all tabtn'></button></td>");
					userTb.append("<td><button name='thirteenonecheck' class='bscore proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' name='thirteenonecheck' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					userTb.append("<input type='hidden' name='missingthirteen' value='' class='totanswer"+(count-1)+"'/>");
					userTb.append("</tr>");
			}
					userTb.append("</tbody>");
					userTb.append("</table>");
					userTb.append("</div>");
					userTb.append("<div style='width:49.7%; margin-left:0.5%;'>");
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='30%'>");
					userTb.append("<col width='30%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col' class='blb' colspan='4'>이름 대기 검사</th>");
					userTb.append("</tr>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>항목</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		for(var j=190;j<205;j++){	
					userTb.append("<tr class='answer"+(count++)+"'>");
					userTb.append("<td class='bg' style='border-left: 1px solid #dbdbdb;'>"+(j-189)+"</td>");
			  		userTb.append("<td class='bg' style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					userTb.append("<td><button name='thirteentwocheck' class='dscore proce btn_all tabtn'></button></td>");
					userTb.append("<td><button name='thirteentwocheck' class='bscore proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' name='thirteentwocheck' class='answers"+(count-1)+" answer"+(count-1)+"'>");
					userTb.append("<input type='hidden' class='answercddtls_"+(count-1)+"'>");
					userTb.append("<input type='hidden' class='answercd_"+(count-1)+"'>");
					userTb.append("<input type='hidden' value='' name='missingthirteentwo' class='totanswer"+(count-1)+"' />");
					userTb.append("</tr>");
			}
					userTb.append("</tbody>");
					userTb.append("</table>");
					userTb.append("</div>");
					$(".EXAM_L14").append(userTb.toString());
		}
	}
		$(".ascore").text("0.5");
		$(".bscore").text("1");
		$(".cscore").text("1.5");
		$(".dscore").text("0");
		$(".escore").text("2");
		$(".escore").val("2");
		$(".ascore").val("0.5");
		$(".bscore").val("1");
		$(".cscore").val("1.5");
		$(".dscore").val("0");
		$(".yesbtn").text("예");
		$(".nobtn").text("아니요");
		$(".yesbtn").val("0");
		$(".nobtn").val("1");
		pointSearch();
		searchCmmnCd(".searchList","SV008","","","");
		
		//막대재인 단어회상-재인 tP/TN  사용 하기 위해
		for(var n=0;n<count;n++){
			$(".yesbtn"+n).text("예");
			$(".nobtn"+n).text("아니요");
			$(".yesbtn"+n).val("0");
			$(".nobtn"+n).val("1");
			try {
				if(data.examItemCdDtlsNm[n].EXAM_ANSWR=="TN"){
					$(".yesbtn"+n).val("0");
					$(".nobtn"+n).val("1");
				} 
				if(data.examItemCdDtlsNm[n].EXAM_ANSWR=="TP"){
					$(".yesbtn"+n).val("1");
					$(".nobtn"+n).val("0");
					}
			} catch (e) {
			}	
		}
	}

	//검사이력 리스트 이벤트
	function ExamHistListSucc(data){
		$(".examlistList").remove();
		var examTb = new StringBuffer();
		var examlist = data.rsList.length;
		if(examlist==0){
				examTb.append("<tr class='examlist examlistList'>");
				examTb.append("<td colspan='30' class='examlistNo'>진행된 검사이력이 존재하지 않습니다.</td>");
				examTb.append("</tr>");
		}else {
			for(var i=0;i<examlist;i++){
				examTb.append("<tr class='examlist  examlistList' style='cursor:pointer;'>");
				examTb.append("<td style='text-align:center;' class='examlist' scope='row'>"+data.rsList[i].EXAM_CMP_DATE+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].EXAM_SN+"차"+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].TOT_POINT+"</td>");
				examTb.append("<td style='text-align:center; display:none;' class='examlist'>"+data.rsList[i].EXAM_DIV+"</td>");
				examTb.append("<td style='text-align:center; display:none;'  class='examlist'>"+data.rsList[i].EXAM_NO+"</td>");
				examTb.append("<td style='text-align:center; display:none;'  class='examlist'>"+data.rsList[i].EXAM_SN+"</td>");
				if(exam_div=="L"){
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L01+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L02+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L03+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L04+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L05+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L06+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L07+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L08+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L09+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L10+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L11+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L12+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L13+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].L14+"</td>");
				examTb.append("</tr>");
			}
			if(exam_div=="S"){
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S01+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S02+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S03+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S04+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S05+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S06+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S07+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S08+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].S09+"</td>");
				examTb.append("</tr>");
				}
			if(exam_div=="M"){
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M01+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M02+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M03+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M04+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M05+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M06+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M07+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M08+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M09+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M10+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M11+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M12+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M13+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M14+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M15+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M16+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M17+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M18+"</td>");
				examTb.append("<td style='text-align:center;' class='examlist'>"+data.rsList[i].M19+"</td>");
				examTb.append("</tr>");
				}
			}
		}
				$(".examHistList").append(examTb.toString());
	}

	//검사정보 조회 및 항목별 세부정보 값 대입 및 버튼 색상 클래스 및 데이터 불러오기
	function pointSearchSucc(data){
		var valsum=0;
		var valsum1=0;
		var valsum2=0;
		var valsum3=0;
		var valsum4=0;
		var valsum5=0;
		var scoretot=0;
		var scoretot2=0;
		var scoretot3=0;
		var scoretot4=0;
		var scoretot5=0;
		var scoretot6=0;
		if(data.userExamInfo.length!=0){
			$(".userInfo1").text(data.userExamInfo[0].REQ_CD);
			$(".userInfo2").text(data.userExamInfo[0].C_NUMBER);
			$(".userInfo3").text(data.userExamInfo[0].EXAM_REQ_DATE);
			$(".userInfo4").text(data.userExamInfo[0].EXAM_SN);
			$(".userInfo5").text(data.userExamInfo[0].ORG_NM);
			$(".userInfo6").text(data.userExamInfo[0].REQ_INS_NM+"("+data.userExamInfo[0].REQ_PART+")");
			$(".userInfo7").text(data.userExamInfo[0].REQ_NM);
			$(".userInfo8").text(data.userExamInfo[0].MEMO);
			$(".cha").text(data.userExamInfo[0].EXAM_SN+"차");
		if(data.userExamInfo[0].EXAM_SN==1){
			$(".prev_point").hide();
			$(".prev_cha").hide();
		}else if(data.userExamInfo[0].EXAM_SN!=1){
			$(".prev_cha").text(data.userExamInfo[0].EXAM_SN-1+"차");
			$(".prev_point").show();
			$(".prev_cha").show();
		}
		if(isNullToString(data.userExamInfo[0].PREV_POINT)!=""){
			var score = data.userExamInfo[0].TOT_POINT-data.userExamInfo[0].PREV_POINT;
			if(score>=0){
				score="+"+score;
				$(".point").text(data.userExamInfo[0].TOT_POINT);
				$(".prev_point").text(data.userExamInfo[0].PREV_POINT);
				$(".point").append("<span class='pointscore'></span>");
				$(".pointscore").text("("+score+")");
			}else{
				$(".prev_point").text(data.userExamInfo[0].PREV_POINT);
				$(".point").text(data.userExamInfo[0].TOT_POINT);
				$(".point").append("<span class='pointscore'></span>");
				$(".pointscore").text("("+score+")");
			}
		}else{
			$(".point").text(data.userExamInfo[0].TOT_POINT);
			}
		}
		if(exam_div=="L"){
		$(".proce").removeClass("new_select btn_select");
		$(".clean").removeClass("bg_orange");
		for(var j=0;j<data.examTotScore.length;j++){
			if(data.examTotScore[j].EXAM_ITEM_CD=="L04"){	
				scoretot+= Number(data.examTotScore[j].POINT);
				$(".tot_score3").val(scoretot);
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L05"){	
				scoretot2+= Number(data.examTotScore[j].POINT);
					$(".tot_score4").val(scoretot2);
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L07"){	
				scoretot3+= Number(data.examTotScore[j].POINT);
				$(".tot_score6").val(scoretot3);
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L08"){	
				$(".tot_score7").val(data.examTotScore[j].POINT);
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L09"){	
				$(".tot_score8").val(data.examTotScore[j].POINT);
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L10" && data.examTotScore[j].EXAM_ANSWR=="TP"){
				$(".tot_score29").val(data.examTotScore[j].POINT);
				yesone = data.examTotScore[j].POINT;
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L10" && data.examTotScore[j].EXAM_ANSWR=="TN"){	
				$(".tot_score9").val(data.examTotScore[j].POINT);
				noone = data.examTotScore[j].POINT;
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L11" ){	
				$(".tot_score10").val(data.examTotScore[j].POINT);
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L12" && data.examTotScore[j].EXAM_ANSWR=="TP"){	
				$(".tot_score211").val(data.examTotScore[j].POINT);
				yestwo = data.examTotScore[j].POINT;
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L12" && data.examTotScore[j].EXAM_ANSWR=="TN"){	
				$(".tot_score11").val(data.examTotScore[j].POINT);
				notwo= data.examTotScore[j].POINT;
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L13"){	
				$(".tot_score12").val(data.examTotScore[j].POINT);
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L14" && data.examTotScore[j].EXAM_ITEM_NO=="1"){	
				$(".tot_score213").val(data.examTotScore[j].POINT);
			}
			if(data.examTotScore[j].EXAM_ITEM_CD=="L14" && data.examTotScore[j].EXAM_ITEM_NO=="2"){	
				$(".tot_score13").val(data.examTotScore[j].POINT);
			}
			if(j!=29){
				$(".tot_score"+j).val(data.examTotScore[j].POINT);
				}
		}	
		//버튼 색상 클래스 추가 이벤트
		for(var i=0;i<data.rsList.length;i++){	
			if(data.rsList[i].POINT==$(".answer"+i).children().children().eq(0).text() && "focus_bg"!= $(".answer"+i).children().eq(2).attr("class")){
				$(".answer"+i).children().children().eq(0).addClass("btn_select");
			}
			 if(data.rsList[i].POINT==$(".answer"+i).children().children().eq(1).text() && "focus_bg"!= $(".answer"+i).children().eq(2).attr("class")){
				 $(".answer"+i).children().children().eq(1).addClass("btn_select");
			}
			if(data.rsList[i].POINT==$(".answer"+i).children().children().eq(2).text()){
				$(".answer"+i).children().children().eq(2).addClass("btn_select");
			}
			if(data.rsList[i].POINT==$(".answer"+i).children().children().eq(3).text()){
				$(".answer"+i).children().children().eq(3).addClass("btn_select");
			}
			
			//막대 재인 일시 td에 정답 클래스 넣어줌
			if(data.rsList[i].EXAM_ITEM_CD=="L10"){
				if(data.rsList[i].POINT==$(".answer"+i).children().eq(1).attr("value") && "focus_bg"==$(".answer"+i).children().eq(1).attr("class")){
					$(".answer"+i).children().children().eq(0).addClass("btn_select");
				}
				if(data.rsList[i].POINT==$(".answer"+i).children().eq(2).attr("value") && "focus_bg"==$(".answer"+i).children().eq(2).attr("class")){
					$(".answer"+i).children().children().eq(1).addClass("btn_select");
				}
				if(data.rsList[i].POINT==0 && "nofocus_bg"==$(".answer"+i).children().eq(1).attr("class")){
					 $(".answer"+i).children().children().eq(0).addClass("btn_select");
				}
				if(data.rsList[i].POINT==0 && "nofocus_bg"==$(".answer"+i).children().eq(2).attr("class")){
					 $(".answer"+i).children().children().eq(1).addClass("btn_select");
				}
			}
			
			//단어회상-재인 일시 td에 정답 클래스 넣어줌
			if(data.rsList[i].EXAM_ITEM_CD=="L12"){
				if(data.rsList[i].POINT==$(".answer"+i).children().eq(2).attr("value") && "focus_bg"==$(".answer"+i).children().eq(2).attr("class")){
					$(".answer"+i).children().children().eq(0).addClass("btn_select");
				}
				if(data.rsList[i].POINT==$(".answer"+i).children().eq(3).attr("value") && "focus_bg"==$(".answer"+i).children().eq(3).attr("class")){
					$(".answer"+i).children().children().eq(1).addClass("btn_select");
				}
				if(data.rsList[i].POINT==0 && "nofocus_bg"==$(".answer"+i).children().eq(2).attr("class")){
					 $(".answer"+i).children().children().eq(0).addClass("btn_select");
				}
				if(data.rsList[i].POINT==0 && "nofocus_bg"==$(".answer"+i).children().eq(3).attr("class")){
					 $(".answer"+i).children().children().eq(1).addClass("btn_select");
				}
			}
			//hidden값으로  update 시 값 불러오기
			$(".answertext"+i).val(data.rsList[i].POINT);
			$(".answers"+i).val(data.rsList[i].POINT);
			$(".totanswer"+i).val(data.rsList[i].RMK);
			$(".succTot"+i).val(data.rsList[i].RMK);
			$(".answercddtls_"+i).val(data.rsList[i].EXAM_ITEM_CD);
			$(".answercd_"+i).val(data.rsList[i].EXAM_ITEM_CD_DTLS);
			if(data.rsList[i].EXAM_ITEM_CD=="L05"){
				if(i>=64 && i<=70){	
						if($(".answers"+i).val()=="0" && data.rsList[(i+7)].POINT=="0"){
						 for(var j=i;j<=68;j++){
								$(".controllbtn"+(j+2)).attr("disabled",true); 	
								$(".controllbtn"+(j+9)).attr("disabled",true);
							 }
								}
							}
				if(i>=78 && i<=84){
					if($(".answers"+i).val()=="0" && data.rsList[(i+7)].POINT=="0"){
					 for(var j=i;j<=82;j++){
							$(".controllbtn"+(j+2)).attr("disabled",true); 	
							$(".controllbtn"+(j+9)).attr("disabled",true);
						 }
							}
						}
			}
		}
		$(".tot_score25").val($(".answers94").val());
		$(".tot_score5").val($(".answers95").val());
		searchCmmnCd(".correct","TC_SV_TRANS_SCORE","",$(".totanswer94").val(),"");
		}else if(exam_div=="S"){   //SLINDA 총점 
			$(".s_proce").removeClass("new_select btn_select");
			$(".s_clean").removeClass("bg_orange");
			
		 for(var j=0;j<data.examTotScore.length;j++){
				if(data.examTotScore[j].EXAM_ITEM_CD=="S03"){	
					scoretot+= Number(data.examTotScore[j].POINT);
					$(".s_tot_score2").val(scoretot);
			  } if(data.examTotScore[j].EXAM_ITEM_CD=="S05" && data.examTotScore[j].EXAM_ANSWR=="TP"){
					$(".s_tot_score24").val(data.examTotScore[j].POINT);
					s_yesone = data.examTotScore[j].POINT;
			  } if(data.examTotScore[j].EXAM_ITEM_CD=="S05" && data.examTotScore[j].EXAM_ANSWR=="TN"){	
					$(".s_tot_score4").val(data.examTotScore[j].POINT);
					s_noone = data.examTotScore[j].POINT;
			  } if(data.examTotScore[j].EXAM_ITEM_CD=="S07" && data.examTotScore[j].EXAM_ANSWR=="TP"){	
					$(".s_tot_score26").val(data.examTotScore[j].POINT);
					s_yestwo = data.examTotScore[j].POINT;
			  } if(data.examTotScore[j].EXAM_ITEM_CD=="S07" && data.examTotScore[j].EXAM_ANSWR=="TN"){	
					$(".s_tot_score6").val(data.examTotScore[j].POINT);
					s_notwo= data.examTotScore[j].POINT;
			  } if(data.examTotScore[j].EXAM_ITEM_CD=="S09" && data.examTotScore[j].EXAM_ITEM_NO=="1"){	
					$(".s_tot_score28").val(data.examTotScore[j].POINT);
			  } if(data.examTotScore[j].EXAM_ITEM_CD=="S09" && data.examTotScore[j].EXAM_ITEM_NO=="2"){	
					$(".s_tot_score8").val(data.examTotScore[j].POINT);
			  } if(data.examTotScore[j].EXAM_ITEM_CD=="S06"){ 
					 $(".s_tot_score5").val(data.examTotScore[j].POINT);
			  } if(data.examTotScore[j].EXAM_ITEM_CD=="S08"){ 
					 $(".s_tot_score7").val(data.examTotScore[j].POINT);
				  } 
				 $(".s_tot_score"+j).val(data.examTotScore[j].POINT);
			}
		   for(var i=0;i<data.rsList.length;i++){
			 if(data.rsList[i].POINT==$(".s_answer"+i).children().children().eq(0).text() && "focus_bg"!= $(".s_answer"+i).children().eq(2).attr("class")){
				$(".s_answer"+i).children().children().eq(0).addClass("btn_select");
		   } if(data.rsList[i].POINT==$(".s_answer"+i).children().children().eq(1).text() && "focus_bg"!= $(".s_answer"+i).children().eq(2).attr("class")){
				 $(".s_answer"+i).children().children().eq(1).addClass("btn_select");
		   } if(data.rsList[i].POINT==$(".s_answer"+i).children().children().eq(2).text()){
				$(".s_answer"+i).children().children().eq(2).addClass("btn_select");
		   } if(data.rsList[i].POINT==$(".s_answer"+i).children().children().eq(3).text()){
				$(".s_answer"+i).children().children().eq(3).addClass("btn_select");
				}
		    //막대 재인 일시 td에 정답 클래스 넣어줌
			if(data.rsList[i].EXAM_ITEM_CD=="S05"){
				if(data.rsList[i].POINT==$(".s_answer"+i).children().eq(1).attr("value") && "focus_bg"==$(".s_answer"+i).children().eq(1).attr("class")){
					$(".s_answer"+i).children().children().eq(0).addClass("btn_select");
				}
				if(data.rsList[i].POINT==$(".s_answer"+i).children().eq(2).attr("value") && "focus_bg"==$(".s_answer"+i).children().eq(2).attr("class")){
					$(".s_answer"+i).children().children().eq(1).addClass("btn_select");
				}
				if(data.rsList[i].POINT==0 && "nofocus_bg"==$(".s_answer"+i).children().eq(1).attr("class")){
					 $(".s_answer"+i).children().children().eq(0).addClass("btn_select");
				}
				if(data.rsList[i].POINT==0 && "nofocus_bg"==$(".s_answer"+i).children().eq(2).attr("class")){
					 $(".s_answer"+i).children().children().eq(1).addClass("btn_select");
				}
			}
			//단어회상-재인 일시 td에 정답 클래스 넣어줌
			if(data.rsList[i].EXAM_ITEM_CD=="S07"){
				if(data.rsList[i].POINT==$(".s_answer"+i).children().eq(2).attr("value") && "focus_bg"==$(".s_answer"+i).children().eq(2).attr("class")){
					$(".s_answer"+i).children().children().eq(0).addClass("btn_select");
				}
				if(data.rsList[i].POINT==$(".s_answer"+i).children().eq(3).attr("value") && "focus_bg"==$(".s_answer"+i).children().eq(3).attr("class")){
					$(".s_answer"+i).children().children().eq(1).addClass("btn_select");
				}
				if(data.rsList[i].POINT==0 && "nofocus_bg"==$(".s_answer"+i).children().eq(2).attr("class")){
					 $(".s_answer"+i).children().children().eq(0).addClass("btn_select");
				}
				if(data.rsList[i].POINT==0 && "nofocus_bg"==$(".s_answer"+i).children().eq(3).attr("class")){
					 $(".s_answer"+i).children().children().eq(1).addClass("btn_select");
				}
			}
			$(".s_answertext"+i).val(data.rsList[i].POINT);
			$(".s_answers"+i).val(data.rsList[i].POINT);
			$(".s_totanswer"+i).val(data.rsList[i].RMK);
			$(".s_succTot"+i).val(data.rsList[i].RMK);
			$(".s_answercddtls_"+i).val(data.rsList[i].EXAM_ITEM_CD);
			$(".s_answercd_"+i).val(data.rsList[i].EXAM_ITEM_CD_DTLS);
		   }
			$(".s_tot_score23").val($(".s_answers46").val());
			$(".s_tot_score3").val($(".s_answers47").val());
			searchCmmnCd(".s_correct","TC_SV_TRANS_SCORE","",$(".s_totanswer46").val(),""); 
		}
	}
	
	//리스트 클릭 이벤트
	$(document).on("click","tr.examlist",function(){
		var Exam_Div  = $(this).children().eq(3).text();
		var Exam_No   = $(this).children().eq(4).text();
		var Exam_Sn   = $(this).children().eq(5).text();
		exam_div=Exam_Div;
		exam_no=Exam_No;
		exam_sn=Exam_Sn;
		if(exam_div=="L"){
			$(".selectListinfo").show();
			$(".selectListinfo2").hide();
			$(".selectListinfo3").hide();
			ExamHistList();
			pointSearch();
			searchCmmnCd(".searchList","SV008","","","");
		}else if(exam_div=="M"){
			$(".selectListinfo").hide();
			$(".selectListinfo3").hide();
			$(".selectListinfo2").show();
			pointSearch();
			getMmseList();
		}else if(exam_div=="S"){
			$(".selectListinfo2").hide();
			$(".selectListinfo").hide();
			$(".selectListinfo3").show();
			pointSearch();
		}
	});
	
	//더보기 버튼 
	//showClass   : 보여줄 class 명
	//openbutton  : 클릭할 button 클래스
	//closebutton : 닫을  button 클래스 
	function click(showClass,openbutton,closebutton){
		$(document).on("click","."+openbutton,function(){
			$("."+showClass).css("display","block");
			$("."+openbutton).addClass("on");
			$("."+openbutton).addClass(closebutton);
			$("."+closebutton).removeClass(openbutton);
		});
	}
	
	//더보기 닫기 버튼
	//showClass   : 숨길 class 명
	//openbutton  : 클릭할 button 클래스
	//closebutton : 닫을  button 클래스 
	function closeclick(hideClass,openbutton,closebutton){
		$(document).on("click","."+openbutton,function(){
			$("."+hideClass).css("display","none");
			$("."+openbutton).removeClass("on");
			$("."+openbutton).addClass(closebutton);
			$("."+closebutton).removeClass(openbutton);
		});
	}
	
	//더보기 버튼 이벤트 함수
	function clickable(){
		click("EXAM_L01","L01","A01");
		closeclick("EXAM_L01","A01","L01");
		
		click("EXAM_L02","L02","A02");
		closeclick("EXAM_L02","A02","L02");
		
		click("EXAM_L03","L03","A03");
		closeclick("EXAM_L03","A03","L03");
		
		click("EXAM_L04","L04","A04");
		closeclick("EXAM_L04","A04","L04");
		
		click("EXAM_L05","L05","A05");
		closeclick("EXAM_L05","A05","L05");
		
		click("EXAM_L06","L06","A06");
		closeclick("EXAM_L06","A06","L06");
		
		click("EXAM_L07","L07","A07");
		closeclick("EXAM_L07","A07","L07");
		
		click("EXAM_L08","L08","A08");
		closeclick("EXAM_L08","A08","L08");
		
		click("EXAM_L09","L09","A09");
		closeclick("EXAM_L09","A09","L09");
		
		click("EXAM_L10","L10","A10");
		closeclick("EXAM_L10","A10","L10");
		
		click("EXAM_L11","L11","A11");
		closeclick("EXAM_L11","A11","L11");
		
		click("EXAM_L12","L12","A12");
		closeclick("EXAM_L12","A12","L12");
		
		click("EXAM_L13","L13","A13");
		closeclick("EXAM_L13","A13","L13");
		
		click("EXAM_L14","L14","A14");
		closeclick("EXAM_L14","A14","L14");
		
		//SLINDA 클릭 이벤트
		
		click("EXAM_S01","S01","s_A01");
		closeclick("EXAM_S01","s_A01","S01");
		
		click("EXAM_S02","S02","s_A02");
		closeclick("EXAM_S02","s_A02","S02");
		
		click("EXAM_S03","S03","s_A03");
		closeclick("EXAM_S03","s_A03","S03");
		
		click("EXAM_S04","S04","s_A04");
		closeclick("EXAM_S04","s_A04","S04");
		
		click("EXAM_S05","S05","s_A05");
		closeclick("EXAM_S05","s_A05","S05");
		
		click("EXAM_S06","S06","s_A06");
		closeclick("EXAM_S06","s_A06","S06");
		
		click("EXAM_S07","S07","s_A07");
		closeclick("EXAM_S07","s_A07","S07");
		
		click("EXAM_S08","S08","s_A08");
		closeclick("EXAM_S08","s_A08","S08");
		
		click("EXAM_S09","S09","s_A09");
		closeclick("EXAM_S09","s_A09","S09");
	}
	
	$(document).on("click","#Exam_LICA",function(){
		exam_div="L";
		if(exam_div != oldexam_div){			//목록에서 불러온 검사종류랑  클릭시 검사종류 비교후 변경
			oldexam_div=exam_div;
		}
		ExamHistList();
	});

	$(document).on("click","#Exam_S_LICA",function(){
		exam_div="S";
		if(exam_div != oldexam_div){			//목록에서 불러온 검사종류랑  클릭시 검사종류 비교후 변경
			oldexam_div=exam_div;
		}
		ExamHistList();
	});

	$(document).on("click","#Exam_M_LICA",function(){
		exam_div="M";
		if(exam_div != oldexam_div){			//목록에서 불러온 검사종류랑  클릭시 검사종류 비교후 변경
			oldexam_div=exam_div;
		}
		ExamHistList();
	});
	
	//버튼 체크 이벤트
	$(document).on("click","tr .proce",function(){
		var count=0;
		var childproce =$(this).text();//내값
		var childrenproce =$(this).parent().parent().attr("class"); //class 값
 		var childrenprocetable =$(this).parent().parent().parent().parent().attr("class"); //table
		var childrenprocetbody =$(this).parent().parent().parent().attr("class");   //tbody
		var subchildren=Number(childrenproce.substr(6));
		$("."+childrenproce).val($(this).val()); //클릭시 값 변경	
		$("."+childrenproce).children().children().removeClass("btn_select new_select");
		doubleselect(childrenprocetbody,"selecttablefive1",subchildren,childrenproce);  //시공간 주의력 4-1) 따라하기 1점시 시행 2 1점으로 변환
		doubleselect(childrenprocetbody,"selecttablefive3",subchildren,childrenproce);	//시공간 주의력 4-2) 따라하기 1점시 시행 2 1점으로 변환
		doubleselect(childrenprocetbody,"selecttablesix",subchildren,childrenproce);  //계산) 따라하기 1점시 시행 2 1점으로 변환
		var sumButton=(Number(subchildren)+(Number(controllsize/2)));
		var minButton=(Number(subchildren)-(Number(controllsize/2)));
		
		var sixsumButton=(Number(subchildren)+(Number(controllsize-2)));
		var sixminButton=(Number(subchildren)-(Number(controllsize-2)));
		
		if(subchildren<=98){
			clickdisabled2(childrenprocetbody,"selecttablesix",sixsumButton,subchildren,childrenproce,controllsize,childrenproce,"98");
		}
		if(subchildren>98 && subchildren<=101){
			clickdisabled2(childrenprocetbody,"selecttablesix",sixsumButton,subchildren,childrenproce,controllsize,childrenproce,"101");
		}
		if(subchildren>101 && subchildren<=104){
			clickdisabled2(childrenprocetbody,"selecttablesix",sixsumButton,subchildren,childrenproce,controllsize,childrenproce,"104");	
		}
		if(subchildren>104 && subchildren<=107){
			clickdisabled2(childrenprocetbody,"selecttablesix",sixsumButton,subchildren,childrenproce,controllsize,childrenproce,"107");
		}
		
		if(subchildren>107 && subchildren<=110){
			clickdisabledreverse2(childrenprocetbody,"selecttablesixtwo",sixminButton,subchildren,childrenproce,controllsize,childrenproce,"110");
		}
		if(subchildren>110 && subchildren<=113){
			clickdisabledreverse2(childrenprocetbody,"selecttablesixtwo",sixminButton,subchildren,childrenproce,controllsize,childrenproce,"113");
		}
		if(subchildren>113 && subchildren<=116){
			clickdisabledreverse2(childrenprocetbody,"selecttablesixtwo",sixminButton,subchildren,childrenproce,controllsize,childrenproce,"116");	
		}
		if(subchildren>116 && subchildren<=119){
			clickdisabledreverse2(childrenprocetbody,"selecttablesixtwo",sixminButton,subchildren,childrenproce,controllsize,childrenproce,"119");
		}
		
		clickdisabled(childrenprocetbody,"selecttablefive1",sumButton,subchildren,childrenproce,controllsize,childrenproce,"70");
		clickdisabled(childrenprocetbody,"selecttablefive3",sumButton,subchildren,childrenproce,controllsize,childrenproce,"84");
		clickdisabledreverse(childrenprocetbody,"selecttablefive2",minButton,subchildren,childrenproce,controllsize,childrenproce,"77");
		clickdisabledreverse(childrenprocetbody,"selecttablefive4",minButton,subchildren,childrenproce,controllsize,childrenproce,"91");
		$(this).addClass("new_select");		
		
		if(childrenprocetbody=="selecttableten"){
		var yesanswer=0;
		var noanswer=0;
		for(var i=150;i<170;i++){
			if($(".answers"+i).val()==$(".answer"+i).children().eq(1).attr("value") && $(".answer"+i).children().eq(1).attr("class")=="focus_bg"){
				yesanswer++;
				}
			if($(".answers"+i).val()==$(".answer"+i).children().eq(2).attr("value") && $(".answer"+i).children().eq(2).attr("class")=="focus_bg"){
				noanswer++;
				}
			}
				$(".tot_score29").val(yesanswer);
				$(".tot_score29").addClass("bg_orange");
				$(".tot_score9").val(noanswer);
				$(".tot_score9").addClass("bg_orange");
		}
		if(childrenprocetbody=="selecttableeleven"){
			var yesanswer2=0;
			var noanswer2=0;
			for(var i=180;i<200;i++){
				if($(".answers"+i).val()==$(".answer"+i).children().eq(2).attr("value") && $(".answer"+i).children().eq(2).attr("class")=="focus_bg"){
					yesanswer2++;
					}
				if($(".answers"+i).val()== $(".answer"+i).children().eq(3).attr("value") && $(".answer"+i).children().eq(3).attr("class")=="focus_bg"){
					noanswer2++;
					}
				}
				$(".tot_score211").val(yesanswer2);
				$(".tot_score211").addClass("bg_orange");
				$(".tot_score11").val(noanswer2);
				$(".tot_score11").addClass("bg_orange");
			}		
		//점수 변경시 세부점수 합계 변경
		sum(4,24,"tot_score1");
		sum(24,34,"tot_score2");
		sum(34,64,"tot_score3");
		fivesum(71,78,85,92,"tot_score4");
		sum(96,120,"tot_score6");
		sum(120,140,"tot_score7");
		sum(140,150,"tot_score8");
		sum(170,180,"tot_score10");
		sum(204,219,"tot_score213");
		sum(219,234,"tot_score13");

	});
	
	$(document).on("change",".searchList",function(){
		sum(0,4,"tot_score0");
	});
	
	$(document).on("change",".correct",function(){
		if($(".tot_score25").val()!=$(".correct").val()){
			$(".tot_score25").addClass("bg_orange");
		}
		$(".tot_score25").val($(".correct").val());
		$(".totanswer94").val($(".correct option:selected").text())
		$(".answers94").val($(".correct").val());
	});
	
	//시공간주의력 클릭 시 이벤트 
	//	bodyclass : tr의 tbody 값 -> 클릭 시 
	//	classname : tr의 tbody 값 -> 기준 tbody
	//	subchildren : 클릭된 class값 자르기
	//	childrenproce : 클릭된 class 값
	function doubleselect(bodyclass,classname,subchildren,childrenproce){
		var listcount = Number(subchildren)+Number(($("."+bodyclass+" tbody tr").length));
		if(bodyclass==classname){
			if(Number($("."+childrenproce).val())=="1"){
				$(".answer"+listcount).children().children().removeClass("btn_select new_select");
				$(".answer"+listcount).children().children().eq(1).addClass("new_select");
				$(".answers"+listcount).val("1");
			}
			if(Number($("."+childrenproce).val())=="2"){
				$(".answer"+listcount).children().children().removeClass("btn_select new_select");
				$(".answer"+listcount).children().children().eq(1).addClass("new_select");
				$(".answers"+listcount).val("2");
			}
		}
	} 
	
	//  시공간 주의력 이벤트   시행 1일 시
	//	bodyclass : tr의 tbody 값 -> 클릭 시 
	//	classname : tr의 tbody 값 -> 기준 tbody
	//  sumButton : 시행 2버튼 class
	//	subchildren : 클릭된 class값 자르기
	//	childrenproce : 클릭된 class 값
	//  controllsize  : 사이즈 갯수
	//  lengths    : for 갯수
	function clickdisabled(bodyclass,classname,sumButton,subchildren,childrenproce,controllsize,childrenproce,lengths){
		if(bodyclass==classname){    // 시행 1값일시에 시행2 1값 disabled 해줌
			if($("."+childrenproce).val()=="1" || $("."+childrenproce).val()=="2"){ //시행 1이 1일때 시행 2버튼  disabled		
				$(".controllbtn"+sumButton).prop("disabled",true);
				$(".controllbtn"+(subchildren+1)).prop("disabled",false);
			}
			if($("."+childrenproce).val()=="0"){
				$(".controllbtn"+sumButton).prop("disabled",false);
			}
			if($("."+childrenproce).val()=="0" && $(".answers"+sumButton).val()=="0"){
				for(var i=(subchildren+1);i<=lengths;i++){
					$(".controllbtn"+(i+(Number(controllsize/2)))).prop("disabled",true);
					$(".controllbtn"+i).prop("disabled",true);
					$(".answer"+i).children().children().removeClass("btn_select new_select");
					$(".answer"+(i+(Number(controllsize/2)))).children().children().removeClass("btn_select new_select");
					$(".answer"+i).val("");
					$(".answer"+(i+(Number(controllsize/2)))).val("");
				}
			}
		}
	}
	
	//  시공간 주의력 이벤트  시행 2
	//	bodyclass : tr의 tbody 값 -> 클릭 시 
	//	classname : tr의 tbody 값 -> 기준 tbody
	//  minButton : 시행 1버튼 class
	//	subchildren : 클릭된 class값 자르기
	//	childrenproce : 클릭된 class 값
	//  controllsize  : 사이즈 갯수
	//  lengths    : for 갯수
	function clickdisabledreverse(bodyclass,classname,minButton,subchildren,childrenproce,controllsize,childrenproce,lengths){
		if(bodyclass==classname){    				// 시행 2값
			if($("."+childrenproce).val()=="1" && $(".controllbtn"+subchildren-(Number(controllsize/2))).val()!="" || $("."+childrenproce).val()=="2"){
				$(".controllbtn"+(subchildren-(Number(controllsize/2))+1)).prop("disabled",false);
			}
			if($("."+childrenproce).val()=="0" && $(".answers"+minButton).val()=="0"){
				for(var i=lengths;i>=(subchildren+1);i--){
					$(".controllbtn"+(i-(Number(controllsize/2)))).prop("disabled",true);
					$(".controllbtn"+i).prop("disabled",true);
					$(".answer"+i).children().children().removeClass("btn_select new_select");
					$(".answer"+(i-(Number(controllsize/2)))).children().children().removeClass("btn_select new_select");
					$(".answer"+i).val("");
					$(".answer"+(i-(Number(controllsize/2)))).val("");
				}
			}
		}
	}
	
	//계산 항목 버튼  disabled 이벤트
	function clickdisabled2(bodyclass,classname,sumButton,subchildren,childrenproce,controllsize,childrenproce,lengths){
		if(bodyclass==classname){    // 시행 1값일시에 시행2 1값 disabled 해줌
			if($("."+childrenproce).val()=="1"){ //시행 1이 1일때 시행 2버튼  disabled		
				$(".controllbtn"+sumButton).prop("disabled",true);
				$(".controllbtn"+(subchildren+1)).prop("disabled",false);
			}
			if($("."+childrenproce).val()=="0"){
				$(".controllbtn"+sumButton).prop("disabled",false);
			}
			if($("."+childrenproce).val()=="0" && $(".answers"+sumButton).val()=="0"){
				for(var i=(subchildren+1);i<=lengths;i++){
					$(".controllbtn"+(i+(Number(controllsize-2)))).prop("disabled",true);
					$(".controllbtn"+i).prop("disabled",true);
					$(".answer"+i).children().children().removeClass("btn_select new_select");
					$(".answer"+(i+(Number(controllsize-2)))).children().children().removeClass("btn_select new_select");
					$(".answer"+i).val("");
					$(".answer"+(i+(Number(controllsize-2)))).val("");
				}
			}
		}
	}
	
	
	//계산 항목 버튼  disabled 이벤트
	function clickdisabledreverse2(bodyclass,classname,minButton,subchildren,childrenproce,controllsize,childrenproce,lengths){
		if(bodyclass==classname){    				// 시행 2값
			if($("."+childrenproce).val()=="1" && $(".controllbtn"+subchildren-(Number(controllsize-2))).val()!=""){
				$(".controllbtn"+(subchildren-(Number(controllsize-2))+1)).prop("disabled",false);
			}
			if($("."+childrenproce).val()=="0" && $(".answers"+minButton).val()=="0"){
				for(var i=lengths;i>=(subchildren+1);i--){
					$(".controllbtn"+(i-(Number(controllsize-2)))).prop("disabled",true);
					$(".controllbtn"+i).prop("disabled",true);
					$(".answer"+i).children().children().removeClass("btn_select new_select");
					$(".answer"+(i-(Number(controllsize-2)))).children().children().removeClass("btn_select new_select");
					$(".answer"+i).val("");
					$(".answer"+(i-(Number(controllsize-2)))).val("");
				}
			}
		}
	}
	function transTimeScore(firstcir,secondcir,scoreput,answer){
		var transScore = 0;
		var transfScore=0;							
		 transScore=Number($("."+secondcir).val())-Number($("."+firstcir).val());
		 if(transScore<=10){
			 transfScore=10;
		 }
		 else if(transScore>=11 && transScore<=20 ){
			 transfScore=9;
		 }
		 else if(transScore>=21 && transScore<=30 ){
			 transfScore=8;
		 }
		 else if(transScore>=31 && transScore<=40 ){
			 transfScore=7;
		 }
		 else if(transScore>=41 && transScore<=50 ){
			 transfScore=6;
		 }
		 else if(transScore>=51 && transScore<=60 ){
			 transfScore=5;
		 }
		 else if(transScore>=61 && transScore<=70 ){
			 transfScore=4;
		 }
		 else if(transScore>=71 && transScore<=80 ){
			 transfScore=3;
		 }
		 else if(transScore>=81 && transScore<=90 ){
			 transfScore=2;
		 }
		 else if(transScore>=91 && transScore<=100 ){
			 transfScore=1;
		 }
		 else if(transScore>=101){
			 transfScore=0;
		 }
		 if(transfScore!=$("."+scoreput).val()){
			 $("."+scoreput).addClass("bg_orange");
		 }
		 $("."+scoreput).val(transfScore);
		 $("."+answer).val(transfScore);
	}
	//숫자 스트룹 텍스트 박스 숫자만 입력 및 점수 변환 이벤트
	  $(document).on("keyup",".succTot93",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var inputVal = numChk;
			 $(".succTot93").val(inputVal);	
			 transTimeScore("succTot93","succTot95","tot_score5","answers95");
			 $(".totanswer93").val(inputVal);
		  });
	
	//숫자 스트룹 텍스트 박스 숫자만 입력 및 점수 변환 이벤트
	  $(document).on("keyup",".succTot95",function(event){
		 	 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var inputVal = numChk;
			 $(".succTot95").val(inputVal);
			 transTimeScore("succTot93","succTot95","tot_score5","answers95");
			 $(".totanswer95").val(inputVal);
		  });
	
	//단어유창성-동물이름대기 텍스트 박스 숫자만 입력  이벤트
	  $(document).on("keyup",".totanswer200",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var numChkLength = numChk.length;
			 var inputVal = numChk;
				$(".totanswer200").val(inputVal);	
				sum(200,204,"tot_score12");
		  });
	
	//단어유창성-동물이름대기 텍스트 박스 숫자만 입력  이벤트
	  $(document).on("keyup",".totanswer201",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var numChkLength = numChk.length;
			 var inputVal = numChk;
				$(".totanswer201").val(inputVal);	
				sum(200,204,"tot_score12");

		  });    
	
	//단어유창성-동물이름대기 텍스트 박스 숫자만 입력  이벤트
	  $(document).on("keyup",".totanswer202",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var numChkLength = numChk.length;
			 var inputVal = numChk;
				$(".totanswer202").val(inputVal);	
				sum(200,204,"tot_score12");
		  });
	
	 //단어유창성-동물이름대기 텍스트 박스 숫자만 입력  이벤트
	  $(document).on("keyup",".totanswer203",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var numChkLength = numChk.length;
			 var inputVal = numChk;
				$(".totanswer203").val(inputVal);	
				sum(200,204,"tot_score12");
		  });
	
	function sum(sizestart,size,queClss){
		var listscore=0;
		var listscore2=0;
		for(var i=sizestart;i<size;i++){
			if(i<size){
				listscore+=Number($(".answers"+i).val());
			}
			if(i<size && i>=200 && i<=203){
				listscore2+=Number($(".totanswer"+i).val());
			}
		}
		if(sizestart >=200 && sizestart<=203){
			if($("."+queClss).val()!=listscore2){
				if(listscore2>=22){
					listscore2=22;
				}
				$("."+queClss).addClass("bg_orange").val(listscore2);
			}
		}else{
		if($("."+queClss).val()!=listscore){
			$("."+queClss).addClass("bg_orange").val(listscore);
		}
		}
	}
	
	//시공간 주의력 세부 항목 합계 함수
	function fivesum(sizestart,size,secondstart,secondsize,queClss){
		var listscore=0;
		var secondscore=0;
		for(var i=sizestart;i<size;i++){
			if(i<size){
					listscore+=Number($(".answers"+i).val());
			}
		}
		for(var j=secondstart;j<secondsize;j++){
			if(j<secondsize){
					secondscore+=Number($(".answers"+j).val());
			}
		}
			if($("."+queClss).val()!=listscore+secondscore){
				$("."+queClss).addClass("bg_orange").val(listscore+secondscore);
		}
		if(listscore>=100){
			alert("점수를 다시 입력해주세요.");
			return;
		}
	}
	
	//전체 버튼 클릭 시 펼치고 닫기 이벤트
	$(document).on("change",".all_List",function(){
		if($(".all_List").is(":checked")){
			$(".ALL_EXAM").css("display","block");	
			$(".clickchange").addClass("on");
			for(var i=0;i<examsize;i++){
				if(i<10){
					i="0"+i;
					$(".L"+i).addClass("A"+i);
					$(".A"+i).removeClass("L"+i);
				}else{
					i=i;
					$(".L"+i).addClass("A"+i);
					$(".A"+i).removeClass("L"+i);
				}
			}
		}else{
			$(".ALL_EXAM").css("display","none");
			$(".clickchange").removeClass("on");
			for(var i=0;i<examsize;i++){
				if(i<10){
					i="0"+i;
					$(".A"+i).addClass("L"+i);
					$(".L"+i).removeClass("A"+i);
				}else{
					i=i;
					$(".A"+i).addClass("L"+i);
					$(".L"+i).removeClass("A"+i);
				}
			}
		}
	});
	
	//점수 수정 이벤트
	$(document).on("click",".btn_upd",function(){
		$(".btn_upd").addClass("btn_save");
		$(".btn_save").removeClass("btn_upd");
		$(".btn_save").text("점수 저장");
		
	});
	
	//점수 저장 이벤트
	$(document).on("click",".btn_save",function(){
		answer=[];
		answercddtls=[];
		answercd=[];
		rmkanswer=[];
		if(exam_div=="L"){
		for(var k=0;k<count;k++){
			if(k==95){
				answer[k]=$(".tot_score5").val();
			}else if(k==203){
				answer[k]=$(".tot_score12").val();
			}else{
			answer[k]=$(".answers"+k).val();
			}
			answercddtls[k]=$(".answercd_"+k).val();
			answercd[k]=$(".answercddtls_"+k).val();
			rmkanswer[k]=$(".totanswer"+k).val();
		}
	}else if(exam_div=="S"){
		for(var j=0;j<s_count;j++){
			if(j==46){
				answer[j]=$(".s_tot_score23").val();
			}else if(j==47){
				answer[j]=$(".s_tot_score3").val();
			}else if(j==101){
				answer[j]=$(".s_tot_score7").val();
			}else{
				answer[j]=$(".s_answers"+j).val();
			}
			answercddtls[j]=$(".s_answercd_"+j).val();
			answercd[j]=$(".s_answercddtls_"+j).val();
			rmkanswer[j]=$(".s_totanswer"+j).val();
		}
	}	
		if(confirm("저장하시겠습니까?")){
		    trgterExamResultPointInsert();
			$(".btn_save").addClass("btn_upd");
			$(".btn_upd").removeClass("btn_save");
			$(".btn_upd").text("점수 수정");	
		}
	});
	
	//점수 총 점수 및 세부 점수 입력
	function trgterExamResultPointInsert(){
		var answerCdUpd="";
		var answerCdDtlsUpd="";
		var answerUpd ="";
		var rmkanswerUpd="";
		var sumPoint=0;
		if(exam_div=="L"){
		for(var i=0;i<answercddtls.length;i++){
			if(i!=answercddtls.length){
/* 				alert("값 : " + answercd[i]);
				alert("값 : " + answercddtls[i]);
				alert("값 : " + answer[i]); */
				answerCdUpd += answercd[i];
				answerCdDtlsUpd += answercddtls[i];
				answerUpd += answer[i];
				rmkanswerUpd +=rmkanswer[i];
				if(i>=64 && i<=70){
				}else if(i>=78 && i<=84){	
				}else {sumPoint +=Number(answer[i])};
			if(i!=answer.length){
				answerUpd+=",";
				answerCdUpd+=",";
				answerCdDtlsUpd+=",";
				rmkanswerUpd+=",";
				}
			}
		}	
	}else if(exam_div=="S"){
		for(var i=0;i<answercddtls.length;i++){
			if(i!=answercddtls.length){
				answerCdUpd += answercd[i];
				answerCdDtlsUpd += answercddtls[i];
				answerUpd += answer[i];
				rmkanswerUpd +=rmkanswer[i];
				sumPoint +=Number(answer[i]);
				if(i!=answer.length){
					answerUpd+=",";
					answerCdUpd+=",";
					answerCdDtlsUpd+=",";
					rmkanswerUpd+=",";
					}
			}
			}
	}
		cfn.ajax({
			  "url"			:	"/sv/trgterExamResultPointInsert.do"
			, "data"		:	{
									"R_NUMBER"				:	r_number
								  , "EXAM_NO"				:	exam_no
								  , "EXAM_ITEM_CD"			:	answerCdUpd
								  , "EXAM_ITEM_CD_DTLS"		:	answerCdDtlsUpd
								  , "POINT"					:	answerUpd
								  , "TOT_POINT"				:	sumPoint	
								  , "RMK"					:	rmkanswerUpd
								  , "EXAM_DIV"				:	exam_div
			}
		 	, "dataType"	:	"json"
		 	, "method"		:	"POST"
		 	, "success"		:	pointSaveSucc
		});
	}
	
	function pointSaveSucc(){
		sttsChange();
  		location.reload(); 
	}
	
	// 진행상태 변경
 	function sttsChange(){
		cfn.ajax({
			"url"	:	"/sv/sttsChange.do",
			"data"	:	{"EXAM_NO"	:	exam_no},
			"method" : "POST",
			"dataType" : "JSON",
			"success" : function(data) {
				if (data.rsInt != 0){
					alert("저장되었습니다.");
					location.reload();
				}
				else {
					alert("실패");
				}
			},
			"error"	:	function(data) {
				alert("통신실패");
			}
		});
	}  
	
	/* ********************	*/
	/* SLINDA 그리기 및 이벤트 생성 */
	/* ********************	 */
	
	function drawListSucc2(data){  //SLINDA 그리기 
		// 			controllsize=data.examItemNm.length;
					var userTb = new StringBuffer();
					userTb.append("<ul class='title_align'>");
					userTb.append("<li><h2>항목별 세부정보</h2></li>");
					userTb.append("<li><a href='#pop_new_input' id='btn_reset' class='btn_all col01' style='margin-right: 10px;'>원점수 조회</a>");
					userTb.append("<a href='#pop_text_in' id='' class='btn_all btn_upd' style='margin-right: 10px;'>점수 입력</a>");
					userTb.append("<input type='checkbox' id='all_s'  name='' class='ck_cmd board s_all_List'/>");
					userTb.append("<label for='all_s'><span></span>전체 펼치기</label></li>");
					userTb.append("</ul>");
					userTb.append("<div class='accordion-box'>");
					userTb.append("<ul class='list'>");
		for(var i=0;i<data.examItemNm.length;i++){
					userTb.append("<li>");
					userTb.append("<div class='title s_clickchange "+data.examItemNm[i].EXAM_ITEM_CD+"'>");
					userTb.append("<h3>"+data.examItemNm[i].EXAM_ITEM_NM+"</h3>");
		 if(data.examItemNm[i].EXAM_ITEM_CD=="S04"){
					userTb.append("<div class='right'><em>정답수 변환점수</em><input type='text'  readonly='readonly' class='s_clean s_tot_score2"+i+"'/><span>/15점</span></div>");
					userTb.append("<div class='right'><em>수행시간 변환점수</em><input type='text' readonly='readonly' class='s_clean s_tot_score"+i+"'/><span>/10점</span></div>");
	   } if(data.examItemNm[i].EXAM_ITEM_CD=="S05"){
					userTb.append("<div class='right'><em>예:</em><input type='text'  readonly='readonly' class='s_clean s_tot_score2"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE/2)+"점</span></div>");
					userTb.append("<div class='right'><em>아니요:</em><input type='text' readonly='readonly'  class='s_clean s_tot_score"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE/2)+"점</span></div>");
	   } if(data.examItemNm[i].EXAM_ITEM_CD=="S07"){
					userTb.append("<div class='right' style='padding-right:5%;'><em>예:</em><input type='text'  readonly='readonly' class='s_clean s_tot_score2"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE/2)+"점</span></div>");
					userTb.append("<div class='right'><em>아니요:</em><input type='text'  readonly='readonly' class='s_clean s_tot_score"+i+"'/><span>/"+(data.examItemNm[i].TOT_SCORE/2)+"점</span></div>");
	   } if(data.examItemNm[i].EXAM_ITEM_CD=="S09"){
					userTb.append("<div class='right'><div><em>의미모양-색깔-속성 총점:</em><input type='text' value=''  readonly='readonly' class='s_clean s_tot_score2"+i+"'/><span>/"+data.examItemNm[i].TOT_SCORE+"점</span></div>");
					userTb.append("<div class='mt5 btnright' style='margin-right: -10px;'><em>이름대기  총점:</em><input type='text' value='' readonly='readonly' class='s_clean s_tot_score"+i+"'/><span>/"+data.examItemNm[i].TOT_SCORE+"점<span></div>");
					userTb.append("</div>");
	   } if(data.examItemNm[i].EXAM_ITEM_CD!="S04" && data.examItemNm[i].EXAM_ITEM_CD!="S05" && data.examItemNm[i].EXAM_ITEM_CD!="S07" && data.examItemNm[i].EXAM_ITEM_CD!="S09"){
					userTb.append("<div class='right'><input type='text'  readonly='readonly' class='s_clean s_tot_score"+i+"'/><span>/"+data.examItemNm[i].TOT_SCORE+"점</span></div>");
				}
					userTb.append("</div>");
					userTb.append("<div class='con_box EXAM_"+data.examItemNm[i].EXAM_ITEM_CD+" s_ALL_EXAM'>");
					userTb.append("</div>");
					userTb.append("</li>");
			}
					userTb.append("</ul>");
					$(".selectListinfo3").append(userTb.toString());
					clickable();
		for(var i=0; i<data.examItemNm.length;i++){
				//0.SLINDA 비문해
			if(data.examItemNm[i].EXAM_ITEM_CD=="S01"){
					var userTb = new StringBuffer();
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width=25%>");
					userTb.append("<col width=25%>");
					userTb.append("<col width=25%>");
					userTb.append("<col width=25%>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col' colspan='2'>병전(원래)기능에 대한 보호자 보고</th>");
					userTb.append("<th scope='col' colspan='2'>환자검사</th>");
					userTb.append("</tr>");
					userTb.append("<tr>");
					userTb.append("<td>쓰기</td>");
					userTb.append("<td>읽기</td>");
					userTb.append("<td>쓰기</td>");
					userTb.append("<td>읽기</td>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
					userTb.append("<tr>");
					userTb.append("<td>");
					userTb.append("<select class='wid50 s_searchList s_answers"+(s_count++)+"'></select>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</td>");
					userTb.append("<td>");
					userTb.append("<select class='wid50 s_searchList s_answers"+(s_count++)+"'></select>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</td>");
					userTb.append("<td>");
					userTb.append("<select class='wid50 s_searchList s_answers"+(s_count++)+"'></select>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</td>");
					userTb.append("<td>");
					userTb.append("<select class='wid50 s_searchList s_answers"+(s_count++)+"'></select>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</td>");
					userTb.append("</tr>");
					userTb.append("</tbody>");
					userTb.append("</table>");
					userTb.append("</div>");
					$(".EXAM_S01").append(userTb.toString());
				}
		 		//1.SLINDA 막대구성
			if(data.examItemNm[i].EXAM_ITEM_CD=="S02"){
			 		var userTb = new StringBuffer();
					 userTb.append("<table class='boardlist'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
			 		 userTb.append("<col style='width:10%'>");
				 	 userTb.append("<col style='width:45%'>");
					 userTb.append("<col style='width:15%'>");
					 userTb.append("<col style='width:15%'>");
					 userTb.append("<col style='width:15%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col'>순서</th>");
					 userTb.append("<th scope='col'>채점용</th>");
					 userTb.append("<th scope='col' colspan='3'>점수</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody>");
			  for(var j=0;j<10;j++){
					userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					userTb.append("<td class='bg'>"+(j+1)+"</td>");
					userTb.append("<td class='bg'><img style='width:100px; height:100px;margin-left:30px;' src='"+ABSOLUTE_URL+"/images/web/question/LICA_"+(j+1)+".png'</td>");
					userTb.append("<td><button class='dscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<td><button class='ascore s_proce btn_all tabtn'></button></td>");
					userTb.append("<td><button class='bscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</tr>");
					}
					userTb.append("</tbody>");
					userTb.append("</table>");	
					userTb.append("</div>");
					$(".EXAM_S02").append(userTb.toString());
				}
				//2.SLINDA단어회상-즉각회상
			if(data.examItemNm[i].EXAM_ITEM_CD=="S03"){
				 for(var z=1;z<4;z++){
					 var userTb = new StringBuffer();
			  if(z==1){
					userTb.append("<div style='width:48.8%;'>");
				 	userTb.append("<table class='boardlist'>");
				 	userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='10%'>");
					userTb.append("<col width='*'>");
					userTb.append("<col width='28%'>");
					userTb.append("<col width='28%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col' rowspan='2'>번호</th>");
					userTb.append("<th scope='col' rowspan='2'>항목</th>");
					userTb.append("<th scope='col' colspan='2'>시행"+z+"</th>");
					userTb.append("</tr>");
					userTb.append("<tr class='blb_r'>");
					userTb.append("<th colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody class='bb'>");
				 for(var j=0;j<10;j++){
					userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					userTb.append("<td class='bg'>"+j+"</td>");
					userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					userTb.append("<td><button class='dscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<td><button class='bscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</tr>");
				}
					userTb.append("</tbody>");
					userTb.append("</table>");
					userTb.append("</div>");
					$(".EXAM_S03").append(userTb.toString());
				}else {
					userTb.append("<div style='width:25%; margin-left:0.5%;'>");
					userTb.append("<table class='boardlist'>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col' class='blb' colspan='2'>시행"+z+"</th>");
					userTb.append("</tr>");
					userTb.append("<tr>");
					userTb.append("<th colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		     for(var j=0;j<10;j++){
					userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					userTb.append("<td><button class='dis dscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<td><button class='dis bscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</tr>");
			}
					userTb.append("</tbody>");
					userTb.append("</table>");
					userTb.append("</div>");
				    $(".EXAM_S03").append(userTb.toString());
			}
		 }
		}	
			//4.SLINDA숫자 스트룹
			if(data.examItemNm[i].EXAM_ITEM_CD=="S04"){
				for(var z=1;z<3;z++){
				 var userTb = new StringBuffer();
			  if(z==1){
					 userTb.append("<div style='width:50.4%;'>");
					 userTb.append("<table class='boardlist'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='10%'>");
					 userTb.append("<col width='*'>");
					 userTb.append("<col width='30%'>");
					 userTb.append("<col width='30%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col'>번호</th>");
					 userTb.append("<th scope='col' colspan='2'>항목</th>");
					 userTb.append("<th scope='col'>시행"+z+"</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody>");
			for(var j=10;j<14;j++){
				if(j==10){
					 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-10)+"</td>");
					 userTb.append("<td rowspan='3'><img style='width:100px; height:100px;' src='"+ABSOLUTE_URL+"/images/web/question/LICA_5_1.jpg'/></td>");
					 userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' value='' class='s_totanswer"+(s_count-1)+"' disabled='disabled'/></td>");
					 userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" answer"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					 userTb.append("</tr>");
				}
			 if(j==12){
					 data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM="오답 수(0-50)";
					 userTb.append("<tr>");
					 userTb.append("<td class='bg'>"+(j-10)+"</td>");
					 userTb.append("<td>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' disabled='disabled' value=''/></td>");
					 userTb.append("</tr>");
			 }
			 if(j==13){
					 data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM="수행시간";	
					 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-10)+"</td>");
					 userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' value='' maxlength='3' class='s_succTot"+(s_count-1)+"' id=''/></td>");
					 userTb.append("<input type='hidden' value='' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
			 	}
			 }
					 userTb.append("</tbody>");
				 	 userTb.append("</table>");
					 userTb.append("</div>");
					 $(".EXAM_S04").append(userTb.toString());
			}
			else{
					 userTb.append("<div style='width:49%; margin-left:0.5%;'>");
					 userTb.append("<table class='boardlist'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='*'>");
					 userTb.append("<col width='30%'>");
					 userTb.append("<col width='30%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col' colspan='2'>항목</th>");
					 userTb.append("<th scope='col'>시행"+z+"</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody>");
		for(var j=10;j<14;j++){
		   if(j==10){
					 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					 userTb.append("<td rowspan='3'><img style='width:100px; height:100px;' src='"+ABSOLUTE_URL+"/images/web/question/LICA_5_1.jpg'/></td>");
					 userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><select style='width:100px; height:26px;' name='s_collection' class='wid50 s_correct'></select></td>");
					 userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					 userTb.append("<input type='hidden' value='' class='s_answer"+(s_count-1)+" s_answers"+(s_count-1)+"' disabled='disabled'/>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("</tr>");
					}
		  if(j==12){
					 data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM="오답 수(0-50)";
					 userTb.append("<tr>");
				     userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' disabled='disabled' value=''/></td>");
					 userTb.append("</tr>");
			 }
		  if(j==13){
				 	 data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM="수행시간";	
					 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					 userTb.append("<td style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' value='' maxlength='3' class='s_succTot"+(s_count-1)+"'/></td>");
					 userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					 	}
			 }
					 userTb.append("</tbody>");
					 userTb.append("</table>");
					 userTb.append("</div>");
					 $(".EXAM_S04").append(userTb.toString());
			}
		}
	}		
		//9.SLINDA 막대재인
		if(data.examItemNm[i].EXAM_ITEM_CD=="S05"){
					var userTb = new StringBuffer();
					userTb.append("<div style='width:49.7%;'>");
					userTb.append("<table class='boardlist' >");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='30%'>");
					userTb.append("<col width='35%'>");
					userTb.append("<col width='35%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody class='s_selecttableten'>");
		 for(var j=14;j<24;j++){
					 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					 userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TP"){
					 userTb.append("<td class='focus_bg' value='1'><button class='s_yesbtn"+j+" s_proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='nofocus_bg' value='0'><button class='s_nobtn"+j+" s_proce  btn_all tabtn'></button></td>");
			 }
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TN"){
					 userTb.append("<td class='nofocus_bg' value='0'><button class='s_yesbtn"+j+" s_proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='focus_bg' value='1'><button class='s_nobtn"+j+" s_proce btn_all tabtn'></button></td>");
			 }
					 userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					 userTb.append("</tr>");
		 		}
					 userTb.append("</tbody>");
					 userTb.append("</table>");
					 userTb.append("</div>");
					 userTb.append("<div style='width:49.7%; margin-left:0.5%;'>");
					 userTb.append("<table class='boardlist'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='30%'>");
				 	 userTb.append("<col width='35%'>");
					 userTb.append("<col width='35%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col'>번호</th>");
					 userTb.append("<th scope='col' colspan='2'>점수</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody class='s_selecttableten'>");
		for(var j=24;j<34;j++){
					 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
				     userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TP"){
					 userTb.append("<td class='focus_bg' value='1'><button class='s_yesbtn"+j+" s_proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='nofocus_bg' value='0'><button class='s_nobtn"+j+" s_proce btn_all tabtn'></button></td>");
			 }
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TN"){
					 userTb.append("<td class='nofocus_bg' value='0'><button class='s_yesbtn"+j+" s_proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='focus_bg' value='1'><button class='s_nobtn"+j+" s_proce btn_all tabtn'></button></td>");
			 }
					 userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					 userTb.append("</tr>");
			 	}
					 userTb.append("</tbody>");
					 userTb.append("</table>");	
					 $(".EXAM_S05").append(userTb.toString());
				}
		//5.SLINDA 단어회상-지연회상
		if(data.examItemNm[i].EXAM_ITEM_CD=="S06"){
					var userTb = new StringBuffer();
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='10%'>");
					userTb.append("<col width='*'>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='20%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>항목</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		 for(var j=34;j<44;j++){
					userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					userTb.append("<td class='bg'>"+(j-33)+"</td>");
					userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					userTb.append("<td><button class='dscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<td><button class='bscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
				    userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
				    userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</tr>");
			 }
				 	userTb.append("</tbody>");
				 	userTb.append("</table>");	
				 	$(".EXAM_S06").append(userTb.toString());
			}
		
		//7.SLINDA 단어회상-재인
		if(data.examItemNm[i].EXAM_ITEM_CD=="S07"){
					var userTb = new StringBuffer();
					userTb.append("<div style='width:49.7%;'>");
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='10%'>");
					userTb.append("<col width='*'>");
					userTb.append("<col width='25%'>");
					userTb.append("<col width='25%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>번호</th>");	
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody class='s_selecttableeleven'>");
		 for(var j=44;j<54;j++){
					 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-43)+"</td>");
					 userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TP"){
					 userTb.append("<td class='focus_bg' value='1'><button class='s_yesbtn"+j+" s_proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='nofocus_bg' value='0'><button class='s_nobtn"+j+" s_proce btn_all tabtn'></button></td>");
			 }
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TN"){
					 userTb.append("<td class='nofocus_bg' value='0'><button class='s_yesbtn"+j+" s_proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='focus_bg' value='1'><button class='s_nobtn"+j+" s_proce btn_all tabtn'></button></td>");
			 }
					 userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					 userTb.append("</tr>");
		 		}
					 userTb.append("</tbody>");
					 userTb.append("</table>");
					 userTb.append("</div>");
					 userTb.append("<div style='width:49.7%; margin-left:0.5%;'>");
					 userTb.append("<table class='boardlist'>");
					 userTb.append("<caption>검사결과목록</caption>");
					 userTb.append("<colgroup>");
					 userTb.append("<col width='10%'>");
					 userTb.append("<col width='*'>");
					 userTb.append("<col width='25%'>");
					 userTb.append("<col width='25%'>");
					 userTb.append("</colgroup>");
					 userTb.append("<thead>");
					 userTb.append("<tr>");
					 userTb.append("<th scope='col'>번호</th>");
					 userTb.append("<th scope='col'>번호</th>");	
					 userTb.append("<th scope='col' colspan='2'>점수</th>");
					 userTb.append("</tr>");
					 userTb.append("</thead>");
					 userTb.append("<tbody class='s_selecttableeleven'>");
		for(var j=54;j<64;j++){
				 	 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-43)+"</td>");
			    	 userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TP"){
					 userTb.append("<td class='focus_bg' value='1'><button class='s_yesbtn"+j+" s_proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='nofocus_bg' value='0'><button class='s_nobtn"+j+" s_proce btn_all tabtn'></button></td>");
			 }
			 if(data.examItemCdDtlsNm[j].EXAM_ANSWR=="TN"){
					 userTb.append("<td class='nofocus_bg' value='0'><button class='s_yesbtn"+j+" s_proce btn_all tabtn'></button></td>");
					 userTb.append("<td class='focus_bg' value='1'><button class='s_nobtn"+j+" s_proce btn_all tabtn'></button></td>");
			 }
					 userTb.append("<input type='hidden' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='s_totanswer"+(s_count-1)+"'/>");
					 userTb.append("</tr>");
			 	}
					 userTb.append("</tbody>");
					 userTb.append("</table>");	
					 userTb.append("</div>");
					 $(".EXAM_S07").append(userTb.toString());
			}

		//8.SLINDA 단어유창성-동물이름대기
		if(data.examItemNm[i].EXAM_ITEM_CD=="S08"){
					var userTb = new StringBuffer();
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='15%'>");
					userTb.append("<col width='*'>");
					userTb.append("<col width='25%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>항목</th>");	
					userTb.append("<th scope='col' colspan='2'>갯수</th>");
					userTb.append("</tr>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		 for(var j=64;j<68;j++){
					 userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					 userTb.append("<td class='bg'>"+(j-63)+"</td>");
				     userTb.append("<td class='bg'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					 userTb.append("<td><input type='text' value='' class='s_totanswer"+(s_count-1)+"'/></td>");
					 userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					 userTb.append("<input type='hidden' value='' class='s_answertext"+(s_count-1)+" s_answers"+(s_count-1)+"' maxlength='3'/>");
					 userTb.append("</tr>");
		 }
					 userTb.append("</tbody>");
					 userTb.append("</table>");	
				 	 $(".EXAM_S08").append(userTb.toString());
			}
		
		//9.SLINDA 의미 모양-색깔 속성/이름대기
		if(data.examItemNm[i].EXAM_ITEM_CD=="S09"){
					var userTb = new StringBuffer();
					userTb.append("<div style='width:49.7%;'>");
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='30%'>");
					userTb.append("<col width='30%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col' class='blb' colspan='4'>의미 모양-색깔 속성 검사</th>");
					userTb.append("</tr>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col'>항목</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		for(var j=68;j<83;j++){	
					userTb.append("<tr class='s_answer"+(s_count++)+"'>");
				    userTb.append("<td class='bg' style='border-left: 1px solid #dbdbdb;'>"+(j-67)+"</td>");
					userTb.append("<td class='bg' style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					userTb.append("<td><button name='s_thirteenonecheck' class='dscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<td><button name='s_thirteenonecheck' class='bscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' name='s_thirteenonecheck' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' name='s_missingthirteen' value='' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</tr>");
			}
					userTb.append("</tbody>");
					userTb.append("</table>");
					userTb.append("</div>");
					userTb.append("<div style='width:49.7%; margin-left:0.5%;'>");
					userTb.append("<table class='boardlist'>");
					userTb.append("<caption>검사결과목록</caption>");
					userTb.append("<colgroup>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='20%'>");
					userTb.append("<col width='30%'>");
					userTb.append("<col width='30%'>");
					userTb.append("</colgroup>");
					userTb.append("<thead>");
					userTb.append("<tr>");
					userTb.append("<th scope='col' class='blb' colspan='4'>이름 대기 검사</th>");
					userTb.append("</tr>");
					userTb.append("<tr>");
					userTb.append("<th scope='col'> </th>");
					userTb.append("<th scope='col'>번호</th>");
					userTb.append("<th scope='col' colspan='2'>점수</th>");
					userTb.append("</thead>");
					userTb.append("<tbody>");
		for(var j=83;j<98;j++){	
					userTb.append("<tr class='s_answer"+(s_count++)+"'>");
					userTb.append("<td class='bg' style='border-left: 1px solid #dbdbdb;'>"+(j-82)+"</td>");
			  		userTb.append("<td class='bg' style='border-left: 1px solid #dbdbdb;'>"+data.examItemCdDtlsNm[j].EXAM_ITEM_CD_DTLS_NM+"</td>");
					userTb.append("<td><button name='s_thirteentwocheck' class='dscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<td><button name='s_thirteentwocheck' class='bscore s_proce btn_all tabtn'></button></td>");
					userTb.append("<input type='hidden' name='s_thirteentwocheck' class='s_answers"+(s_count-1)+" s_answer"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercddtls_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' class='s_answercd_"+(s_count-1)+"'>");
					userTb.append("<input type='hidden' value='' name='s_missingthirteentwo' class='s_totanswer"+(s_count-1)+"'/>");
					userTb.append("</tr>");
			}
					userTb.append("</tbody>");
					userTb.append("</table>");
					userTb.append("</div>");
					$(".EXAM_S09").append(userTb.toString());
		}
			}		
					searchCmmnCd(".s_searchList","SV008","","","");	
					$(".ascore").text("0.5");
					$(".bscore").text("1");
					$(".cscore").text("1.5");
					$(".dscore").text("0");
					$(".escore").text("2");
					$(".escore").val("2");
					$(".ascore").val("0.5");
					$(".bscore").val("1");
					$(".cscore").val("1.5");
					$(".dscore").val("0");
					$(".s_yesbtn").text("예");
					$(".s_nobtn").text("아니요");
					$(".s_yesbtn").val("1");
					$(".s_nobtn").val("0");
		//막대재인 단어회상-재인 tP/TN  사용 하기 위해
			for(var n=0;n<s_count;n++){
				$(".s_yesbtn"+n).text("예");
				$(".s_nobtn"+n).text("아니요");
				$(".s_yesbtn"+n).val("0");
				$(".s_nobtn"+n).val("1");
				try {
					if(data.examItemCdDtlsNm[n].EXAM_ANSWR=="TN"){
						$(".s_yesbtn"+n).val("0");
						$(".s_nobtn"+n).val("1");
					} 
					if(data.examItemCdDtlsNm[n].EXAM_ANSWR=="TP"){
						$(".s_yesbtn"+n).val("1");
						$(".s_nobtn"+n).val("0");
						}
				} catch (e) {
				}	
			}
			}
	
	//전체 버튼 클릭 시 펼치고 닫기 이벤트
	$(document).on("change",".s_all_List",function(){
		if($(".s_all_List").is(":checked")){
			$(".s_ALL_EXAM").css("display","block");	
			$(".s_clickchange").addClass("on");
			for(var i=0;i<examsize;i++){
					i="0"+i;
					$(".S"+i).addClass("s_A"+i);
					$(".s_A"+i).removeClass("S"+i);
			}
		}else{
			$(".s_ALL_EXAM").css("display","none");
			$(".s_clickchange").removeClass("on");
			for(var i=0;i<examsize;i++){
					i="0"+i;
					$(".s_A"+i).addClass("S"+i);
					$(".S"+i).removeClass("s_A"+i);
			}
		}
	});
		
	$(document).on("click","tr .s_proce",function(){
		var childproce =$(this).text();//내값
		var childrenproce =$(this).parent().parent().attr("class"); //class 값
 		var childrenprocetable =$(this).parent().parent().parent().parent().attr("class"); //table
		var childrenprocetbody =$(this).parent().parent().parent().attr("class");   //tbody
		var subchildren=Number(childrenproce.substr(6));
		$("."+childrenproce).val($(this).val()); //클릭시 값 변경	
		$("."+childrenproce).children().children().removeClass("btn_select new_select");//class remove
		$(this).addClass("new_select");	
		if(childrenprocetbody=="s_selecttableten"){
			var yesanswer=0;
			var noanswer=0;
			for(var i=48;i<68;i++){
				if($(".s_answers"+i).val()==$(".s_answer"+i).children().eq(1).attr("value") && $(".s_answer"+i).children().eq(1).attr("class")=="focus_bg"){
					yesanswer++;
					}
				if($(".s_answers"+i).val()==$(".s_answer"+i).children().eq(2).attr("value") && $(".s_answer"+i).children().eq(2).attr("class")=="focus_bg"){
					noanswer++;
					}
				}
					$(".s_tot_score24").val(yesanswer);
					$(".s_tot_score24").addClass("bg_orange");
					$(".s_tot_score4").val(noanswer);
					$(".s_tot_score4").addClass("bg_orange");
			}
			if(childrenprocetbody=="s_selecttableeleven"){
				var yesanswer2=0;
				var noanswer2=0;
				for(var i=78;i<98;i++){
					if($(".s_answers"+i).val()==$(".s_answer"+i).children().eq(2).attr("value") && $(".s_answer"+i).children().eq(2).attr("class")=="focus_bg"){
						yesanswer2++;
						}
					if($(".s_answers"+i).val()== $(".s_answer"+i).children().eq(3).attr("value") && $(".s_answer"+i).children().eq(3).attr("class")=="focus_bg"){
						noanswer2++;
						}
					}
					$(".s_tot_score26").val(yesanswer2);
					$(".s_tot_score26").addClass("bg_orange");
					$(".s_tot_score6").val(noanswer2);
					$(".s_tot_score6").addClass("bg_orange");
				}
			s_sum(4,14,"s_tot_score1");
			s_sum(14,44,"s_tot_score2");
			s_sum(68,78,"s_tot_score5");
			s_sum(102,117,"s_tot_score28"); 
			s_sum(117,132,"s_tot_score8");
	});
	

	//단어유창성-동물이름대기 텍스트 박스 숫자만 입력  이벤트
	  $(document).on("keyup",".s_totanswer98",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var numChkLength = numChk.length;
			 var inputVal = numChk;
				$(".s_totanswer98").val(inputVal);	
				s_sum(98,102,"s_tot_score7");
		  });
	
	//단어유창성-동물이름대기 텍스트 박스 숫자만 입력  이벤트
	  $(document).on("keyup",".s_totanswer99",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var numChkLength = numChk.length;
			 var inputVal = numChk;
				$(".s_totanswer99").val(inputVal);	
				s_sum(98,102,"s_tot_score7");

		  });
	
	//단어유창성-동물이름대기 텍스트 박스 숫자만 입력  이벤트
	  $(document).on("keyup",".s_totanswer100",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var numChkLength = numChk.length;
			 var inputVal = numChk;
				$(".s_totanswer100").val(inputVal);	
				s_sum(98,102,"s_tot_score7");
		  });
	
	 //단어유창성-동물이름대기 텍스트 박스 숫자만 입력  이벤트
	  $(document).on("keyup",".s_totanswer101",function(event){
			 var prev 	= $(this).val();
			 var numChk	= prev.replace(/[^0-9]/g,"");
			 var numChkLength = numChk.length;
			 var inputVal = numChk;
				$(".s_totanswer101").val(inputVal);	
				s_sum(98,102,"s_tot_score7");
		  });
	 
		//SLINDA 덧셈
		function s_sum(sizestart,size,queClss){
			var listscore=0;
			var listscore2=0;
			for(var i=sizestart;i<size;i++){
				if(i<size){
					listscore+=Number($(".s_answers"+i).val());
				}
				if(i<size && i>=98 && i<=102){
					listscore2+=Number($(".s_totanswer"+i).val());
				}
			}
			if(sizestart >=98 && sizestart<102){
				if($("."+queClss).val()!=listscore2){
					if(listscore2>=22){
						listscore2=22;
					}
					$("."+queClss).addClass("bg_orange").val(listscore2);
				}
			}else{
			if($("."+queClss).val()!=listscore){
				$("."+queClss).addClass("bg_orange").val(listscore);
				}
			}
		}
		
		$(document).on("change",".s_searchList",function(){
			s_sum(0,4,"s_tot_score0");
		});
		
		$(document).on("change",".s_correct",function(){
			if($(".s_tot_score23").val()!=$(".s_correct").val()){
				$(".s_tot_score23").addClass("bg_orange");
			}
			$(".s_tot_score23").val($(".s_correct").val());
			$(".s_totanswer46").val($(".s_correct option:selected").text())
			$(".s_answers46").val($(".correct").val());
		});
		//숫자 스트룹 텍스트 박스 숫자만 입력 및 점수 변환 이벤트
		  $(document).on("keyup",".s_succTot45",function(event){
				 var prev 	= $(this).val();
				 var numChk	= prev.replace(/[^0-9]/g,"");
				 var inputVal = numChk;
				 $(".s_succTot45").val(inputVal);	
				 transTimeScore("s_succTot45","s_succTot47","s_tot_score3","s_answers47");
				 $(".s_totanswer45").val(inputVal);
			  });
		
		//숫자 스트룹 텍스트 박스 숫자만 입력 및 점수 변환 이벤트
		  $(document).on("keyup",".s_succTot47",function(event){
			 	 var prev 	= $(this).val();
				 var numChk	= prev.replace(/[^0-9]/g,"");
				 var inputVal = numChk;
				 $(".s_succTot47").val(inputVal);
				 transTimeScore("s_succTot45","s_succTot47","s_tot_score3","s_answers47");
				 $(".s_totanswer47").val(inputVal);
			  });
</script>

<div class="btnright">
	<a href="/alExam/pageNavi.do?menuCd=NSV100" class="btn_all col01 btn_return">목록</a>
</div>
	<section class="">
		<h2>인적사항</h2>
		<table class="table_type topb">
			<colgroup>
				<col width="16%">
				<col width="16%">
				<col width="16%">
				<col width="16%">
				<col width="*">
				<col width="16%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">이름</th>
					<td>${userInfo.NAME}</td>
					<th scope="col">성별</th>
					<td>${userInfo.GENDER}</td>
					<th scope="col">생년월일(만 나이)</th>
					<td>${userInfo.BIRTH}(${userInfo.AGE})</td>
				</tr>
				<tr>
					<th scope="col">교육년수</th>
					<td>${userInfo.EDU_YEAR} 년</td>
					<th scope="col">손잡이</th>
					<td>${userInfo.HAND_CD}</td>
					<th scope="col">보호자(동거여부)</th>
					<td>${userInfo.INMATE_NAME}(${userInfo.INMATE_YN})</td>
				</tr>	
			</tbody>
		</table> 
	</section>
	
<section class="mt35">
	<h2>검사이력</h2>
		<div class="tab_box">
		<ul class="tab tab_Exam_Hist">
				<li class="lica current" data-tab="tab1"><a href="#" id="Exam_LICA" class="on">LINDA(${examCount.LINDA})</a></li>
				<li class="Slica" data-tab="tab2"><a href="#" id="Exam_S_LICA" class="">S-LINDA(${examCount.S_LINDA})</a></li>
				<li class="Mlica " data-tab="tab3"><a href="#" id="Exam_M_LICA" class="">MMSE_DS(${examCount.MMSE_DS})</a></li>
			</ul>
		
		<div id="tab1" class="tabcontent current">	
			<table class="boardlist">
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
			<thead >
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
			<tbody class="examHistList">
		</table>
			</div>
			
			<div id="tab2" class="tabcontent">	
			<table class="boardlist">
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
			<tbody class="examHistList">
			</tbody>
		</table>
			</div>
			<div id="tab3" class="tabcontent">	
			<table class="boardlist">
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
			<tbody class="examHistList">
			</tbody>
		</table>
			</div>
		</div>
	</section>
	
<section class="mt35 section_div_set">
	<div>
		<h2>검사정보</h2>
		<table class="table_type topb bg_grey">
			<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="20%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">검사종류</th>
						<td colspan="3" class="userInfo1"></td>
					</tr>
					<tr>
						<th scope="col">차트번호</th>
						<td class="userInfo2"></td>
						<th scope="col">검사일</th>
						<td class="userInfo3"></td>
					</tr>
					<tr>
						<th scope="col">검사차수</th>
						<td class="userInfo4"></td>
						<th scope="col">검사기관</th>
						<td class="userInfo5"></td>
					</tr>
					<tr>
						<th scope="col">의료의사</th>
						<td class="userInfo6"></td>
						<th scope="col">검사자</th>
						<td class="userInfo7"></td>
					</tr>
				</tbody>
		</table>
	</div>
	<div>
		<h2>검사 의뢰 메모</h2>
		<textarea class="userInfo8" placeholder="메모입니다." disabled="disabled"></textarea>
		<ul>
			<li>
				<h2 class="prev_cha userInfo9"></h2>
				<p class="bg_grey prev_point userInfo10"></p>
			</li>
			<li>
				<h2 class="cha userInfo11"></h2>
				<p class="bg_orange point userInfo12"><span class="pointscore"></span></p>
			</li>	
		</ul>
	</div>
</section>	

<section class="mt35 selectListinfo">
</section>


<!-- MMSE-DS 항목별 세부정보 리스트 -->
<section class="mt35 selectListinfo2">
	<ul class="title_align">
		<li><h2>항목별 세부정보</h2></li>
		<li><a href="#" class="btn_all col01" onclick="setMmsePoint('reset');">원점수 조회</a> <a href="#" class="btn_all" onclick="insertMmsePoint();">점수 입력</a></li>
	</ul>
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
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M011101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>지금은 무슨 계절 입니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M021101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>오늘은 며칠 입니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M031101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>오늘은 무슨 요일 입니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M041101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>지금은 몇 월 입니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M051101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td rowspan="5">장소</td>
				<td>우리가 있는 이곳은 무슨 광역시 입니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M061101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>여기는 무슨 구 입니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M071101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>여기는 무슨 동 입니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M081101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>우리는 지금 이 건물의 몇 층에 있습니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M091101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>이 장소의 이름은 무엇입니까?</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M101101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td rowspan="6">기억력</td>
				<td  class="t_al_ct">1</td>
				<td rowspan="3">기억등록</td>
				<td>세 가지 단어 즉시 기억하기(나무)</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M111101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>세 가지 단어 즉시 기억하기(자동차)</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M111102">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>세 가지 단어 즉시 기억하기(모자)</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M111103">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td rowspan="3">기억회상</td>
				<td>조금전에 말했던 단어를 다시 말해주세요.(나무)</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M121101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>조금전에 말했던 단어를 다시 말해주세요.(자동차)</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M121102">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				
				<td>조금전에 말했던 단어를 다시 말해주세요.(모자)</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M121103">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td rowspan="5">주위집중 및 계산</td>
				<td class="t_al_ct">1</td>
				<td rowspan="5">수리력</td>
				<td>"100에서 7을 빼면 얼마가 됩니까?(1회)"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M131101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>"거기에서 7을 빼면 얼마가 됩니까?(2회)"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M131102">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>"거기에서 7을 빼면 얼마가 됩니까?(3회)"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M131103">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>"거기에서 7을 빼면 얼마가 됩니까?(4회)"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M131104">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>"거기에서 7을 빼면 얼마가 됩니까?(5회)"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M131105">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td rowspan="7">언어기능</td>
				<td class="t_al_ct">1</td>
				<td rowspan="2">이름 맞추기</td>
				<td>이것을 무엇이라고 합니까?(시계)</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M141101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>이것을 무엇이라고 합니까?(연필)</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M141102">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td rowspan="3">3단계 명령</td>
				<td>"제가 지금 말하는걸 말씀드린대로 해보세요"<br>"오른손으로 종이를받아서"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M151101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>"제가 지금 말하는걸 말씀드린대로 해보세요"<br>"반으로 접어서"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M151102">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>"제가 지금 말하는걸 말씀드린대로 해보세요"<br>"무릎 위에 올려주세요."</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M151103">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>복사</td>
				<td>오각형 두개 겹쳐 그리기</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M161101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>반복</td>
				<td>"간장 공장 공장장" 따라하기</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M171101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td rowspan="2">이해 및 판단</td>
				<td  class="t_al_ct">1</td>
				<td>이해</td>
				<td>"옷을 왜 빨아서 입습니까?"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M181101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bll_d">1</td>
				<td>판단</td>
				<td>"티끌 모아 태산은 무슨 뜻입니까?"</td>
				<td>
					<select onchange="mmseChangePoint();" class="mmsePoint" id="M191101">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>전체 총점</td>
				<td colspan="4" id="mmseTotPoint"></td>
			</tr>
		</tfoot>
	</table>
</section>

<section class="mt35 selectListinfo3">
</section>