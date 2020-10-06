

/********************************************************************
 * jquery datapicker 기본 설정
 * @param	 
 * @returns	
 *******************************************************************/
//$.datepicker.setDefaults({
//// 	showOn: null,
////	buttonImage: "",
////	buttonImageOnly: false,
//	showAnim: "slideDown",
//	changeMonth: false,
//	changeYear: false,
//	nextText: "다음 달",
//	prevText: "이전 달",
//	numberOfMonths: 1,
//// 	yearRange: 10,
//// 	stepMonths: "",
//	showButtonPanel: false,
//	closeText: "닫기",
//	dateFormat: "yy-mm-dd",
//	dayNames: ["월요일","화요일","수요일","목요일","금요일","토요일","일요일"],
//	dayNamesMin: ["월","화","수","목","금","토","일"],
//	monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
//	monthNamesShort: ["1","2","3","4","5","6","7","8","9","10","11","12"],
//	showOtherMonths: false,
//	selectOtherMonths: false,
//	minDate: "",//예 : 한달 전까지만 선택 가능하게 할 시 -30으로 설정 또는 "-30D"
//	maxDate: "",//예 : 한달 후까지만 선택 가능하게 할 시 +30으로 설정 또는 "+30D"
//	showWeek: false
//});

function setDatepickerSelectDate(formTarget,toTarget,option)
{
	option.onClose = function( selectedDate ) {
//		$(targetEle).val("");
		$(toTarget).datepicker( "option", "minDate", selectedDate );
		$(toTarget).focus();
	};
	$(formTarget).datepicker(option);
	
	option.onClose = function( selectedDate ) {
		$(formTarget).datepicker( "option", "maxDate", selectedDate );
	};
	$(toTarget).datepicker(option);
}


/********************************************************************
 * 화면에 표현할 날짜포멧 설정
 * @param	sDate	- 년월일 시분초 max 14자리 문자열, 만약 ""을 입력하면 today() 적용
 * 			sFormat	- "YYYY년 MM월 DD일 HH시 MI분 SS초", "YYYY년 MM월 DD일 HH:MI:SS", "YYYY/MM/DD" 등 적용하고 싶은 포멧 입력 
 * @returns	string
 *******************************************************************/
function setDateFormat(sDate, sFormat)//sCase, sSprt
{
	var sRtnStr = "";
	
	//dDate is null = TODATE
	if(isNullToString(sDate) == "") sDate = today("",sFormat.indexOf("AP") > -1);
	if(isNullToString(sFormat) == "") sFormat = "YYYYMMDD";
	
	sDate = getReplace(sDate,CMMN_SPCL_CHAR,"").toTrim();
	
	var sTime = parseInt(isNullToString(sDate.substr(8,2),"00"));
	var rtnTime = (sTime > 12 ? sTime % 12 : sTime);
	rtnTime = rtnTime < 10 ? "0"+rtnTime : ""+rtnTime;
	rtnTime = sFormat.indexOf("AP") < 0 ? isNullToString(sDate.substr(8,2),"00") : rtnTime;
	sRtnStr = sFormat.replace("YYYY",sDate.substr(0,4))
					.replace("MM",sDate.substr(4,2))
					.replace("DD",sDate.substr(6,2))
					.replace("AP",sTime > 11 ? "오후" : "오전")
					.replace("HH",rtnTime)
					.replace("MI",isNullToString(sDate.substr(10,2),"00"))
					.replace("SS",isNullToString(sDate.substr(12,2),"00"));
	
	return sRtnStr;
}

/********************************************************************
 * 입력된 변수의 값이 null 또는 "" 일때 치환 문자를 반환한다.
 * @param	sDate	- 년월일 시분초 max 14자리 문자열
 * 			sFormat	- "YYYY년 MM월 DD일 HH시 MM분 DD초", "YYYY년 MM월 DD일 HH:MM:DD", "YYYY/MM/DD" 등 적용하고 싶은 포멧 입력 
 * @returns	string
 *******************************************************************/
function today(sSprt,bFlag)
{
	sSprt = isNullToString(sSprt);
	bFlag = isNullToString(bFlag,false);
	var rtnVal = "";
    var now = new Date();

    var year= now.getFullYear();
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
    rtnVal = year + sSprt + mon + sSprt + day;
    
    if(bFlag){
    	var hour   = now.getHours(); 
    	var minute = now.getMinutes(); 
    	var second = now.getSeconds();
    	
    	if (hour < 10) {
    		  hour = "0" + hour; 
    		} else if (minute < 10){ 
    		  minute = "0" + minute; 
    		} else if(second < 10){ 
    		  second = "0" + second;
    		} 
    	rtnVal =  year + sSprt + mon + sSprt + day + hour + minute + second;
    }
            
    return rtnVal;
}

/********************************************************************
 * 입력된 날짜 +- 계산
 * @param	sDate	- 년월일 시분초 max 14자리 문자열
 * 			sMode	- Y:년, M:월, D:일
 * 			nShift	- 더하기 또는 빼기 숫자 빼기는 "-" 표시하세요.
 * 			sFormat	- "YYYY년 MM월 DD일 HH시 MM분 DD초", "YYYY년 MM월 DD일 HH:MM:DD", "YYYY/MM/DD" 등 적용하고 싶은 포멧 입력 
 * @returns	string
 *******************************************************************/
function getDateShift(sDate, sMode, nShift, sFormat)
{
	sDate = isNullToString(sDate,today());
	nShift = isNullToString(nShift,"0");
	sMode = isNullToString(sMode,"D");
	var year= sDate.substr(0,4);
	var mon = sDate.substr(4,2);
	var day = sDate.substr(6,2);
    var now = new Date(year, mon - 1, day);
    
    if(typeof nShift !== "number") nShift = parseInt(nShift);
    if(sMode == "Y") {
    	now.setFullYear(now.getFullYear() + nShift);
    } else if(sMode == "M") {
    	now.setMonth(now.getMonth() + nShift);
    } else {
    	now.setDate(now.getDate() + nShift);
    }
    
    year= now.getFullYear();
    mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
    
    return setDateFormat(year + mon + day,sFormat);
}

/********************************************************************
 * 날짜 구분에 따른 입력한 날짜의 기간 반환
 * getDatePeriod($("#dateText"), "W", -7, "YYYY년 MM월 DD일");
 * @param	sDate	- 년월일 8자리 문자열
 * 			sMode	- Y:년, M:월, D:일, W:주
 * 			nShift	- 더하기 또는 빼기 숫자 빼기는 "-" 표시하세요.
 * 			sFormat	- "YYYY년 MM월 DD일 HH시 MM분 DD초", "YYYY년 MM월 DD일 HH:MM:DD", "YYYY/MM/DD" 등 적용하고 싶은 포멧 입력 
 * @returns	rtnMap
 *******************************************************************/
function getDatePeriod(oDate, sMode, nShift, sFormat)
{
	$targetObj = null;
	var sDate = "";
	var startDay = "";
	var endDay = "";
	var shiftVal = "";
	
	//숫자형으로 변환
    if(typeof nShift !== "number") nShift = parseInt(nShift);
    //예를들어 6개월 간격으로 이동하려고 할때 Date 함수 쪽에서는 6월 15일 부터 6개월인 12월 15일을 반환한다. 그렇기 때문에 5개월을 기준으로 기간을 구한다.
    if(sMode != "W") nShift = nShift > 1 ? nShift - 1 : nShift < -1 ? nShift + 1 : nShift;
    if(typeof oDate === 'object'){
		$targetObj = oDate;								//jQuery 객체로 받기
		sDate = $targetObj.children("span").html();		//기존에 저장되어있는 span 태그 호출
		var aSplit = new String(sDate).split("|");		//start|end 데이터를 split으로 분리한다.
		sDate = sMode == "W" ? aSplit[0] : nShift < 0 ? aSplit[0] : aSplit[1];	//W일때는 기준일을 그냥 반환하고, 이전/이후 버튼 클릭에 따라서 맞는 데이터 설정
	}else{
		sDate = oDate;
	}
	
	sDate = isNullToString(nShift == 0 ? "" : sDate,today());//date값이 널이면 오늘날짜로 설정(nShift가 0이면 초기화를 위해 오늘 날짜를 설정한다.)
	sFormat = isNullToString(sFormat,"YYYYMMDD");		//기본 포멧 설정
	
	if(sMode == "W") {									//주 이동 시
		shiftVal = getDateShift(sDate, "D", nShift);	//기준일로부터 7일을 뺀다.
		var nWeek = new Date(shiftVal.substr(0,4), shiftVal.substr(4,2) - 1, shiftVal.substr(6,2)).getDay();
		if(nWeek == 0){									//일요일 일때..
			startDay = getDateShift(shiftVal, "D", -6);
			endDay = sDate;
		}else{											//월~토요일 일때..
			startDay = getDateShift(shiftVal, "D", 1 - nWeek);
			endDay = getDateShift(shiftVal, "D", 7 - nWeek);
		}
		sDate = setDateFormat(startDay, sFormat) + ' - '+setDateFormat(endDay, sFormat);
	}else{
		if(sMode.length > 1){							//달력 기간을 초기 설정하기 위해 "M_3" 형태의 initData 추가.
			var aInit = new String(sMode).split("_");	//초기화를 위해 날짜 종류와 기간을 분리.
			sMode = aInit[0];							//날짜 종류 다시 설정
			nShift = parseInt("-"+aInit[1]) + 1;		//날짜 기간 다시 설정
		}
		shiftVal = getDateShift(sDate, sMode, nShift);
		//조회한 방법에 따라 start 및 end date 설정 shift date가 태그 혹은 사용자에게 받은 날짜보다 작거나 같으면 start에 shift date를 설정한다. 그 반대로 shift date가 크면 end에 설정한다.
		if(parseInt(shiftVal) <= parseInt(sDate)){
			startDay = shiftVal;
			endDay = Math.abs(nShift) > 1 ? sDate : shiftVal;
		} else {
			startDay = Math.abs(nShift) > 1 ? sDate : shiftVal;
			endDay = shiftVal;
		}
		if(Math.abs(nShift) > 1){
			sDate = setDateFormat(startDay, sFormat) + ' - '+setDateFormat(endDay, sFormat);
		}else{
			sDate = setDateFormat(shiftVal, sFormat);
		}
	}

	if(typeof oDate === 'object'){
		$targetObj.empty();
		$targetObj.append(sDate + '<span style="display:none;">' + startDay + '|' + endDay +'</span>');//alert(sDate + '<span style="display:none;">'+shiftVal+'</span>');
	}
	
    var rtnMap = new Map();
    rtnMap.put("sDate",startDay);
    rtnMap.put("eDate",endDay);
    rtnMap.put("sDateFm",setDateFormat(startDay, sFormat));
    rtnMap.put("eDateFm",setDateFormat(endDay, sFormat));
    return rtnMap;
}


/**********************************************************************************
 * 현재시간과 등록된 시간의 차를 메시지로 리턴한다.
 * @param	sDate	- "YYYYMMDDHHMISS형식 또는 YYYY-MM-DD HH:MI:SS" 형식의 날짜스트링
 * @returns	string
 *********************************************************************************/
function diffTimeCheck(sDateTmp)
{
	var sec = 60;
	var mins = 60;
	var hours = 24;
	var days = 30;
	var month =12;
	var sDate='';
	if(sDateTmp.length==14){
		sDate=setDateFormat(sDateTmp,"YYYY-MM-DD HH:MI:SS");
	}else{
		sDate=sDateTmp;
	}
	 //시간차 비교 : 현재시간 - 등록된시간
	 //현재시간
	 var tday = new Date();
	 var cday = new Date(sDate);
	 //alert(sDate);
	 var difftime = Math.floor((tday - cday)/1000);
	 var msg="";
	 if(sDate == "0000-00-00 00:00:00"){
		 msg = 0;
	 }
	 else if(difftime < sec){
		 msg="방금";
	 }else if((difftime /=sec) < mins){
		 msg=Math.floor(difftime) + "분";
	 }else if((difftime /=mins) < hours){
		 msg=Math.floor(difftime) + "시간";
	 }else if((difftime /=hours) < days){
		 msg=Math.floor(difftime) + "일";
	 }else if((difftime /=days) < month){
		 msg=Math.floor(difftime) + "달";
	 }else {
		 msg=Math.floor(difftime) + "년";
	 }
	return msg+"전";
} 


/**********************************************************************************
 * default 날짜값으로 오늘날짜를 placeholder 에 나타낼 수 있다.
 * @param	클래스 아이디
 * @returns	string
 *********************************************************************************/

//function todayPlaceholder(toTarget){
function todayPlaceholder(toStartTarget,toEndTarget){
	var date = new Date();
	var YY = date.getFullYear();
	var MM = date.getMonth()+1+"";
	var DD = date.getDate();
	if(MM < 10) {
	   MM = "0" + MM;
	}
	    
	if(DD < 10) {
	   DD = "0" + DD;
	}
    var today = YY+"-"+MM+"-"+DD;
//    $(toTarget).attr("placeHolder",today);
    $(toStartTarget).val(today);
    $(toEndTarget).val(today);
}