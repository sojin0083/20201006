var CMMN_SPCL_CHAR = "[`~!.,/@#$%^&*():;?+<>='|\\\"_-]";
var CMMN_TRIM = "(\\s*)";

/********************************************************************
 * jQuery Ajax 공통 함수.
 * 사용 예제 : cmmnAjax("/noticeList.do", {param1 : "param1", param2 : "param2"}, callback, "GET", "TEXT");
 * @param	sUrl		- 요청 URL
 * 			aData		- 배열 형식의 전달 값 {}
 * 			sCallback	- Ajax 통신 후 처리되는 함수명(사용 시 함수명을 "" 없이 사용하세요. 문자열 안됨.)
 * 			aOption		- bAsync, sType, sDataType 등 option 설정
 * 			sType		- GET, POST
 * 			sDataType	- TEXT, JSON, JSONP
 * 			bAsync		- true, false 문자값으로 전달
 * @returns	fnCallback
 *******************************************************************/
function cmmnAjax(sUrl, aParams, fnCallback, aOption)
{
	if(isNullToString(sUrl) == ""){
		alert("url은 필수 항목입니다.");
		return;
	}
	if(aOption == null) aOption = {};
	$.ajax({
		async		: eval(isNullToString(aOption.bAsync,"true")),
		type		: isNullToString(aOption.sType,"POST"),
		url			: sUrl,
		data		: aParams,//params,
		dataType	: isNullToString(aOption.sDataType,"JSON"),
		success		: function (data) {
			//메시지 반환 시 메시지 출력
			if(isNullToString(data.msg, "") != "")
				alert(data.msg);
			if(typeof fnCallback === "function")
				fnCallback(data.rsList || data);
		},
		beforeSend	: function () {
			if(eval(isNullToString(aOption.bLoading,"true"))){
//				$.mobile.loading("show");
			}
		},
		complete	: function () {
			if(eval(isNullToString(aOption.bLoading,"true"))){
//				$.mobile.loading("hide");
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert("Error: " + xhr.status + "\n" +
			      "Message: " + xhr.statusText + "\n" +
			      "Response: " + xhr.responseText + "\n" + thrownError);
		}
	});
}


/********************************************************************
 * jQuery Ajax 공통코드 조회 함수.
 * 사용 예제 : searchCmmnCd("#selectTag","CM001","","","===전체===|*","in|10,20,30");
 * @param	sSelector	- # 혹은 . 를 꼭 붙이세요.
 * 			sLclasCd	- 공통코드 대분류 코드값
 * 			sSclasCd	- 공통코드 소분류 코드값, 간혹 코드값이 필요한 상황에 사용. 단건 셀렉트임...
 * 			sBindData	- 기본 설정할 값 지정
 * 			sInst		- 첫 줄에 추가할 내용 입력. 예) 전체, 선택 등
 * @returns
 *******************************************************************/
function searchCmmnCd(sSelector, sCmmnCd, sCmmnDtlsCd, sBindData, sInst, sFilter,bSyncFlag)
{	

	if(isNullToString(sSelector) == "") return;
	if(isNullToString(sCmmnCd) == "") return;
	
	var bSync = isNullToString(sCmmnDtlsCd) == "" || ",TC_CM_AUTH,TC_CM_ORG,TC_CM_CMMN_CD_LCLAS,TC_SV_TRANS_SCORE".indexOf(sCmmnCd) > 0;
	var rtnVal = "";
	

	
	$.ajax({
		async: bSyncFlag != null ? bSyncFlag : bSync,
		type: "POST",
		url: "./cmmn/selectCmmnCd.do",
		data : { CMMN_CD : sCmmnCd, CMMN_DTLS_CD : sCmmnDtlsCd },//params,
		dataType: "JSON",
		success: function (data) {


			if(!bSync){
				rtnVal = isNullToString(""+data[0].CMMN_NM);
			}else{
				var oCmb = $(sSelector);
				//선택한 태그 초기화
				oCmb.empty();
				
				if(isNullToString(sInst) != ""){
					var aSplit = sInst.split("|");
					oCmb.append("<option value='" + isNullToString(""+aSplit[1]) + "'>" + isNullToString(""+aSplit[0]) + "</option>");
				}
				if(isNullToString(sFilter) != ""){
					data = getFilterData(data,sFilter);
				}
				
				for (var i = 0; i < data.length; i++){
					oCmb.append("<option value='" + isNullToString(""+data[i].CMMN_CD) + "'>" + isNullToString(""+data[i].CMMN_NM) + "</option>");
				}
				
				if(isNullToString(sBindData) != ""){
					oCmb.val(sBindData);
					if(sCmmnCd=="TC_SV_TRANS_SCORE"){
						$("select[name='"+oCmb.attr("name")+"'] option:eq('"+sBindData+"')").attr("selected", "selected");
					}
				}
				if($.mobile) oCmb.selectmenu('refresh');
			}
			
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert("Error: " + xhr.status + "\n" +
			      "Message: " + xhr.statusText + "\n" +
			      "Response: " + xhr.responseText + "\n" + thrownError);
		}
	});
	
	if(!bSync) return rtnVal;
}

function getFilterData(dataVal,sFilter){

	dataVal = dataVal.filter(function(dataVal, index, arr){
		
		var rtnBoolean = false;
		var sclasCd = dataVal.CMMN_CD;
		var arrFilter = sFilter.split("|");
		if(arrFilter[0] === "like"){
			rtnBoolean = sclasCd.indexOf(arrFilter[1]) > -1;
		}else if(arrFilter[0] === "notlike"){
			rtnBoolean = sclasCd.indexOf(arrFilter[1]) == -1;
		}
		if(arrFilter[0] === "in"){
			rtnBoolean = arrFilter[1].indexOf(sclasCd) > -1;
		}else if(arrFilter[0] === "notin"){
			rtnBoolean = arrFilter[1].indexOf(sclasCd) < 0;
		}
		if("<,>,<=,>=,==,!=".indexOf(arrFilter[0]) > -1){
			rtnBoolean = eval(sclasCd + " " + arrFilter[0] + " " + arrFilter[1]);
		}else if("<>,><,<=>,>=<,<=>=,>=<=".indexOf(arrFilter[0]) > -1){
			var nSubstrVal = arrFilter[0].length < 3 ? 1 : 2;
			rtnBoolean = eval(sclasCd + " " + arrFilter[0].substr(0,nSubstrVal) + " " + arrFilter[1] + " && " + sclasCd + " " + arrFilter[0].substr(nSubstrVal) + " " + arrFilter[2]);
		}
		return rtnBoolean;
	});

	
	return dataVal;
}


/********************************************************************
 * javascript로 java에서 사용하는 stringbuffer 기능 구현
 * 사용 예제 :	var sbuf = new StringBuffer();
 * 			sbuf.append("text");
 * 			sbuf.append("text");
 * 			sbuf.toString();
 * @param
 * @returns
 *******************************************************************/
var StringBuffer = function() {
    this.buffer = new Array();
}

StringBuffer.prototype.append = function(obj) {
     this.buffer.push(obj);
}

StringBuffer.prototype.toString = function() {
     return this.buffer.join("");
}
/*******************************************************************/


/********************************************************************
 * 입력된 변수의 값이 null 또는 "" 일때 치환 문자를 반환한다.
 * 사용 예제 :	if( isNullToString(sParam, "") != "" ) {
 * @param	sParam	- 타멧 문자열
 * 			sSubst	- 치환 문자
 * @returns	string
 *******************************************************************/
function isNullToString(sParam, sSubst)
{
	if(sSubst == null){ sSubst = "";}
	if(sParam == null || sParam == undefined || sParam == "" || sParam == "undefined" || sParam == "null"){
		return sSubst;
	}
	return sParam;
}

function getReplace(str, rep, tok){ 
	return str.replace(new RegExp(rep,"gi"),tok);
}

String.prototype.toTrim = function(){
	return this.replace(new RegExp(CMMN_TRIM,"gi"),"");
};

String.prototype.isNull = function(){
	return this == null || this == '';
};

String.prototype.isNotNull = function(){
	return this != null && this != '';
};

String.prototype.addComma = function(strTxt) {
	
	return this.concat(',').concat(strTxt);
}




Array.prototype.indexOf = function(object) {
    for (var i = 0, length = this.length; i < length; i++)
        if (this[i] == object) return i;
    return -1;
};

Array.prototype.addObj = function(object) {
	if(typeof object === "object"){
		$.each(object,function(key,value){
			this[key] = value;
		});
	}
	return this;
};



Map = function(){
	 this.map = new Object();
}; 

Map.prototype = {   
  put : function(key, value){   
      this.map[key] = value;
  },   
  get : function(key){   
      return this.map[key];
  },
  containsKey : function(key){    
   return key in this.map;
  },
  containsValue : function(value){    
   for(var prop in this.map){
    if(this.map[prop] == value) return true;
   }
   return false;
  },
  isEmpty : function(key){    
   return (this.size() == 0);
  },
  clear : function(){   
   for(var prop in this.map){
    delete this.map[prop];
   }
  },
  remove : function(key){    
   delete this.map[key];
  },
  keys : function(){   
      var keys = new Array();   
      for(var prop in this.map){   
          keys.push(prop);
      }   
      return keys;
  },
  values : function(){   
   var values = new Array();   
      for(var prop in this.map){   
       values.push(this.map[prop]);
      }   
      return values;
  },
  size : function(){
    var count = 0;
    for (var prop in this.map) {
      count++;
    }
    return count;
  }
};

ArrayList = function ArrayList(){
	this.list = [];
};

ArrayList.prototype ={
	
	add : function(item){
		this.list.push(item);
	},	
	get : function(idx){
		return this.list[idx];
	},
	removeAll : function(){
		this.list = [];
	},
	size : function(){
		return this.list.length;
	},
	remove : function(index){
		var newList = [];
		for(var i=0;i<this.list.length;i++){
			if(i != index){
				newList.push(this.list[i]);
			}
		}
		this.list = newList;
	},
	removeItem : function(item){
		var newList = [];
		for(var i=0;i<this.list.length;i++){
			if(this.list[i] != this.list[item]){
				newList.push(this.list[i]);
			}
		}
		this.list = newList;
	}
};


function makeStringToList(pStr){
	if(isNullToString(pStr) == "") return;
	if(typeof pStr !== "string"){
		alert("makeStringToList 함수는 스트링만 받습니다.");
		return;
	}
	
	pStr = pStr.replace(/\[/g,"").replace(/\]/g,"");
	var arrStr;
	if(pStr.indexOf("},{") < 0){
		arrStr = pStr.split("}, {");
	}else{
		arrStr = pStr.split("},{");
	}
	
	var rtnList = new Array();
	for (var row = 0; row < arrStr.length; row++) {
		var strMap = arrStr[row].replace(/\{/g,"").replace(/\}/g,"");
		var arrMap = strMap.split(",");
		var colMap = new Object();
		for (var col = 0; col < arrMap.length; col++) {
			var arrVal = arrMap[col].split("=");
			if(arrVal.length == 2){
				if(isNullToString(arrVal[0]) != ""){
					if(arrVal[0].indexOf("\"") == 0) arrVal[0] = arrVal[0].substring(1);
					if(arrVal[0].lastIndexOf("\"") == arrVal[0].length - 1) arrVal[0] = arrVal[0].substring(0,arrVal[0].length - 2);
				}
				if(isNullToString(arrVal[1]) != ""){
					if(arrVal[1].indexOf("\"") == 0) arrVal[1] = arrVal[1].substring(1);
					if(arrVal[1].lastIndexOf("\"") == arrVal[1].length - 1) arrVal[1] = arrVal[1].substring(0,arrVal[1].length - 2);
				}
				colMap[arrVal[0].trim()] = arrVal[1];
			}
		}
		rtnList[row] = colMap;
	}
	return rtnList;
}

/**
 *  공통메시지 
 *  ex)  alert(commonMsg['save.success']); 
 */
var commonMsg = {
	  'insert.wait':'저장 중입니다. 잠시만 기다려 주십시오.'
	, 'update.wait':'수정 중입니다. 잠시만 기다려 주십시오.'
	, 'delete.wait':'삭제 중입니다. 잠시만 기다려 주십시오.'
	, 'insert.success':'저장이 완료되었습니다.'
	, 'update.success':'수정이 완료되었습니다.'
	, 'delete.success':'삭제가 완료되었습니다.'
	, 'insert.fail':'저장이 실패하였습니다.'
	, 'update.fail':'수정이 실패하였습니다.'
	, 'delete.fail':'삭제가 실패하였습니다.'

};



//태그 변환 함수
function tagChange(chkObj){
	var str = chkObj.val();
	str = getReplace(str, "&", "&amp;");
	str = getReplace(str, "<", "&lt;");
	str = getReplace(str, ">", "&gt;"); 
	chkObj.val(str); 
}



//해당 클래스 명을 갖은 오브젝트 밸류체크 	
function valueCheck(formObj, chkClassNm){
	var chk =true;

	$(formObj).find(chkClassNm).each(function(){   
		$chkobj=$(this); 
		
		if($(this).attr('name')!=undefined && $(this).attr('name')!=''){
			if($chkobj.is(':radio')||$chkobj.is(':checkbox')){     
				var radioNm = $chkobj.attr('name');
				if($('input[name="'+radioNm+'"]:checked').length==0){
					alert($chkobj.attr('title')+'을(를) 입력하세요.'); 
					$chkobj.focus();  
					chk = false;
					return false;  
				}  
			}
			if($chkobj.is('select')){
				var selNm = $chkobj.attr('name');
				if($('select[name="'+selNm+'"] > option:selected')==0){
					alert($chkobj.attr('title')+'을(를) 입력하세요.');
					$chkobj.focus();
					chk = false;
					return false;
				}
			}else if($chkobj.val()==null||$chkobj.val()==''){
				alert($chkobj.attr('title')+'을(를) 입력하세요.');   
				$chkobj.focus();  
				chk = false;
				return false;    
			} 	
		}
	});
	
	$(formObj).find('textarea').each(function(){   
		tagChange($(this));
	});	
	$(formObj).find('input:text').each(function(){   
		tagChange($(this));
	});	

	return chk; 
}


/********************************************************************
 * 날짜 8자를 년 월 일로 구분
 * 사용 예제 :	if( isNullToString(sParam, "") != "" ) {
 * @param	sParam	- 타멧 문자열
 * 			sSubst	- 치환 문자
 * @returns	string
 *******************************************************************/
function getFullDate(sParam){
	if(isNullToString(sParam) == "") return;
	
	var yy = sParam.substring(0, 4);
	var mm = sParam.substring(4, 6);
	var dd = sParam.substring(6, 8);
	
	var fullDate = "";
    fullDate = yy+"년 " + mm + "월 " + dd + "일";
	
	return fullDate;
}


/**웹쪽 공통 ajax **/
var cfn = {

		MAX_ROW_SIZE : 10, //paging 시 한번에 가져올 사이즈
		CUR_PAGE : 1,		//paging 시 현재 페이지
		init : function(){
			console.log("common.js init");	
			
			
		},
		ajax : function(param){
			
			if(param.url == undefined){
				alert('ajax url undefined');
				return;
			}
			param.url = "."+param.url;
			
			param.beforeSend = param.beforeSend || this.ajaxBeforeSendFun;
			param.success = param.success || this.ajaxSuccFun;
			param.error = param.error || this.ajaxErrFun;
			param.complete = param.complete || this.ajaxCompleteFun;
			param.dataType = param.dataType || 'jsonp';
			param.method = param.method || 'GET';
			//param.data = this.getAllParam(param.data);
			param.data =param.data;
			//페이지 관련 파라미터 추가
			if((param.page != undefined && param.page != '')&&(param.data != undefined && param.data != '')){
				param.data.page = param.page;
				param.data.limit = this.MAX_ROW_SIZE;
				this.CUR_PAGE = param.page;
			}
			$.ajax(param);
		},
		
		getAllParam : function(addParam){
			var param = {};
			
			if(typeof addParam === 'string'){
				var arr = addParam.split('&');
				for(var i=0; i<arr.length; i++){
					var row = arr[i].split('=');
					if(row.length>1)
						param[row[0]]=row[1];
				}
			}else if(typeof addParam === 'object'){				
				if(this.isArray(addParam)){
					for(var i=0; i<addParam.length; i++){
						var key = addParam[i].name;
						var val = addParam[i].value;
						param[key] = val;
					}
				}else{
					param = addParam;
				}
			}
			
			return param;
		},
		ajaxBeforeSendFun : function(xhr){
			console.log('ajaxBeforeSenddFun');   

		},		
		ajaxSuccFun : function(data){
			if(data.chkYn == 'Y'){
				
			}
		},
		ajaxErrFun : function(jqXHR, textStatus, errorThrown){
			console.log('ajaxErrFun');
		},
		ajaxFailFun : function(jqXHR, textStatus, errorThrown){
			console.log('ajaxErrFun');
		},
		ajaxAlwaysFun : function(data, textStatus, jqXHR){
			console.log('ajaxAlwaysFun');
		},
		ajaxCompleteFun : function(data, textStatus, jqXHR){
			console.log('ajaxCompleteFun');
		},
		getMaxRs : function(){
			return this.MAX_ROW_SIZE;
		},
		getNextPage : function(){
			return this.CUR_PAGE+1;
		}, 
		
		setCombo : function(cboObj,grpCode,value){
			
			this.ajax({
				url : '/cmmn/selectCmmnCd.do',	
				data : {'method': 'listView', 'grpCode': grpCode, 'mobile': 'Y' },
				success : function(data){

					cboObj.children().not(':eq(0)').remove();
					if(data.rsList.length>0){
						
						$.each(data.rsList,function(i,item){
							
							var option = $('<option value="'+item.value+'">'+item.text+'</option>');
							if(value != undefined && item.value == value){
								option.prop('selected',true);
							}
							option.appendTo(cboObj);
						});

					}
					cboObj.selectmenu("refresh");
				}
			});
			
		},
		
		setFormData : function(formObj, item){
			
			formObj.find('input, textarea, select').each(function(i){
				//console.log('setFormData  name='+$(this).attr('name')+' value='+item[$(this).attr('name')]);
				if(!$.isPlainObject(item)){
					if(item.get($(this).attr('name')) != undefined){
						if($(this).is('select')){
							$(this).children('option[value="'+item.get($(this).attr('name'))+'"]').prop('selected','selected');
						}else if($(this).is('input:radio')){
							if($(this).val() == item.get($(this).attr('name')))
								$(this).attr('checked', 'checked');
						}else{
							$(this).val(item.get($(this).attr('name'))); 
						}
					}
				}else{
					if(item[$(this).attr('name')] != undefined){					
						if($(this).is('select')){
							$(this).children('option[value="'+item[$(this).attr('name')]+'"]').prop('selected','selected');
						}else if($(this).is('input:radio')){
							if($(this).val() == item[$(this).attr('name')])
								$(this).attr('checked', 'checked');
						}else{
							$(this).val(item[$(this).attr('name')]); 
						}
					}	
				}
			});
		},
		
		addFormData : function(formObj,key,value){
			var name = formObj.find('[name='+key+']').attr('name');
			
			if(name != undefined){
				formObj.find('[name='+key+']').val(value);
			}else{
				formObj.append('<input type="hidden" name="'+key+'" value="'+value+'" />');
			}
			
			//console.log("addFormData::"+formObj.serialize());
		},
		
		
		isArray : function (arr) {
		    return Object.prototype.toString.call(arr) === '[object Array]';
		}
};


// 2016.08.05 이태석 추가
// 화면 디자인 부분 추가 
/* 달력 */
function datePickerFn(){

	$('.datepicker').datepicker({
		showOn:'both',
		buttonImage:ABSOLUTE_URL+'/images/web/btn/btn_date.png',
		buttonImageOnly: true,
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		yearSuffix: '년',
		onClose: function(){
			if($('.BGN_DE').val() != null && $('.END_DE').val() != null && $('.BGN_DE').val() !='' && $('.END_DE').val() !='') {
				return false;
			}
			if($('.BGN_DE').val() != null && $('.BGN_DE').val() !=''){
				$('.END_DE').focus();
				return true;
			}
			if($('.END_DE').val() != null && $('.END_DE').val() !='') {
				$('.BGN_DE').focus();
				return true;
			}
		}
	});
	 $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('.BGN_DE').datepicker();
	    $('.BGN_DE').datepicker("option", "maxDate", $(".END_DE").val());
	    $('.BGN_DE').datepicker("option", "onClose", function ( selectedDate ) {
	        $(".END_DE").datepicker( "option", "minDate", selectedDate );
	    });
	 
	    $('.END_DE').datepicker();
	    $('.END_DE').datepicker("option", "minDate", $(".BGN_DE").val());
	    $('.END_DE').datepicker("option", "onClose", function ( selectedDate ) {
	        $(".BGN_DE").datepicker( "option", "maxDate", selectedDate );
	    });
	
	// 2016.08.17 이태석 추가
	// 화면 디자인 부분 추가 
	$('.datepicker2').datepicker({
		showOn:'both',
		buttonImage:'../images/web/btn/btn_date2.png',
		buttonImageOnly: true,
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		yearSuffix: '년',
		onClose: function(){
			if($('.BGN_DE').val() != null && $('.END_DE').val() != null && $('.BGN_DE').val() !='' && $('.END_DE').val() !='') {
				return false;
			}
			if($('.BGN_DE').val() != null && $('.BGN_DE').val() !=''){
				$('.END_DE').focus();
				return true;
			}
			if($('.END_DE').val() != null && $('.END_DE').val() !='') {
				$('.BGN_DE').focus();
				return true;
			}
		}
	});
}

//월단위로 달력 선택
function datePickerFn2(){
	$('.datepicker').datepicker({
		showOn:'both',
		buttonImage:'../../images/web/btn/btn_date.png',
		buttonImageOnly: true,
		dateFormat: 'yy-mm',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		yearSuffix: '년',
		onClose: function(){
			if($('.BGN_DE').val() != null && $('.END_DE').val() != null && $('.BGN_DE').val() !='' && $('.END_DE').val() !='') {
				return false;
			}
			if($('.BGN_DE').val() != null && $('.BGN_DE').val() !=''){
				$('.END_DE').focus();
				return true;
			}
			if($('.END_DE').val() != null && $('.END_DE').val() !='') {
				$('.BGN_DE').focus();
				return true;
			}
		}
	});
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	
	//날짜 최소, 최대 선택 가능 값 설정
	var bgnSelDt = "", bgnYy = "", bgnMth = "";
	var endSelDt = "", endYy = "", endMth = "";
	
	bgnSelDt = $(".BGN_DE").val().split("-");
	bgnYy 	 = Number(bgnSelDt[0]);
	bgnMth   = Number(bgnSelDt[1]) - 1;
	
	endSelDt = $(".END_DE").val().split("-");
	endYy 	 = Number(endSelDt[0]);
	endMth	 = Number(endSelDt[1]) - 1;
	
	//시작일 달력 버튼 닫기 이벤트
    $('.BGN_DE').datepicker("option", "onClose", function (selectedDate){
    	bgnSelDt = selectedDate.split("-");
    	bgnYy    = Number(bgnSelDt[0]);
    	bgnMth   = Number(bgnSelDt[1]) - 1;
    	
    	setMinMaxDt();
    });

	//종료일 달력 버튼 닫기 이벤트
    $('.END_DE').datepicker("option", "onClose", function (selectedDate){
    	endSelDt = selectedDate.split("-");
    	endYy 	 = Number(endSelDt[0]);
    	endMth	 = Number(endSelDt[1]) - 1;

        setMinMaxDt();
    });

    setMinMaxDt();
    
    function setMinMaxDt(){
		$('.BGN_DE').datepicker("option" , "defaultDate", new Date(bgnYy, bgnMth, 1));
		$('.BGN_DE').datepicker('setDate', new Date(bgnYy, bgnMth, 1));
		$(".BGN_DE").datepicker("option" , "maxDate", new Date(endYy, endMth, 1));

		$('.END_DE').datepicker("option" , "defaultDate", new Date(endYy, endMth, 1));
		$('.END_DE').datepicker('setDate', new Date(endYy, endMth, 1));
		$(".END_DE").datepicker("option" , "minDate", new Date(bgnYy, bgnMth, 1));
	}
}



//달력 숫자만 입력
function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( event.keyCode >=48 && event.keyCode <= 57 ) || ( event.keyCode >=96 && event.keyCode <= 105 ) ) {
		return;
	} else {
		event.returnValue = false;
	}

}
//달력 입력시 자동 '-' 입력
function auto_date_format( e, oThis ){
//    $('.BGN_DE').datepicker('show');
	
    var num_arr = [ 
        97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57
    ]
    
//    var key_code = ( e.which ) ? e.which : e.keyCode;
    if( num_arr.indexOf( Number( e.keyCode ) ) != -1 ){
    
        var len = oThis.value.length;
        if( len == 4 ) oThis.value += "-";
        if( len == 7 ) oThis.value += "-";
    
    }
    
}
//달력 조건
function date_set() {
	if($('.BGN_DE').val() != null && $('.BGN_DE').val() != '') {
		if($('.END_DE').val() == null || $('.END_DE').val() == '') {
			alert('조회 조건을 확인하세요.');
			return false;
		} else if($('.END_DE').val() != null || $('.END_DE').val() != ''){
			
		}
	}
	if($('.END_DE').val() != null && $('.END_DE').val() != '') {
		if($('.BGN_DE').val() == null || $('.BGN_DE').val() == '') {
			alert('조회 조건을 확인하세요.');
			return false;
		} else if($('.BGN_DE').val() != null || $('.BGN_DE').val() != ''){
			
		}
	}	
}


//2016.08.012 이태석 추가
//화면 디자인 부분 추가
function customRadio(){ 
	var radio = $('.rdo > input');
	if(radio.length < 1){return;}

	radio.each(function(){
		this.flag = $(this).prop('checked') ? true : false;
		if(this.flag){$(this).parent().addClass('on');}
	});

	radio.bind('click', function(){
		var _name = $(this).attr('name');
		var _parent = $(this).parent();
		var _siblings = $("input[name="+_name+"]").parent();

		_siblings.removeClass('on');
		_parent.addClass('on');
	});
}
/* modalView */
function modalView(fileurl) {
//	$('html').addClass('layer-wrap');
	$('body').bind('touchmove',function(e){e.preventDefault()});
	$("#wrap_content").append($('<div class="wid400"></div>'));
//	$('body').append($('<div class=""></div>'));
//	$('.wid400').append($('<div class="layer-wrap"></div>'));
	$('.wid400').load(fileurl, function(){
		var modalpopWidth = $('.layer-wrap').width();
		$('.layer-wrap').css('margin-left',-modalpopWidth/2+'px');
		var modalpopHeight = $('.modalpop').height();
		$('.layer-wrap').css('margin-top',-modalpopHeight/2+'px');
		var windowHeight = $(window).height();
		var windowWidth = $(window).width();
		function modalCssChange(width, height) {
			var width = parseInt(width);
			var height = parseInt(height);
			if (height < modalpopHeight){
				$('body').addClass('a-height');
			} else {
				$('body').removeClass('a-height');
			}
			if (width < modalpopWidth){
				$('body').addClass('a-width');
			} else {
				$('body').removeClass('a-width');
			}
		}
		$(function() {
			$(window).resize(function() {
				modalCssChange($(this).width(), $(this).height());
			}).resize();
		});
	});
}
function modalHide() {
//	$('html').removeClass('ovh').removeClass('a-width').removeClass('a-height');
	$('body').removeClass('a-width').removeClass('a-height');
	$('body').unbind();
	$('.wid400').remove();
	$('.layer-wrap').remove();
//	$('.modalpop').remove();
}

$(document).ready(function(){
	customRadio();
	
	// a 태그 위로가는 것 방지
	$("a").on("click", function(e){
		if($(this).attr("href").indexOf("#") > -1)
			e.preventDefault();
	});
});


/**
 * web에서 backspace 버튼 막기(ie기준)
 */
$(document).keydown(function (e) {
	var filter = "text,password,email,search,url,tel,datetime-local,month,week,number";
	if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){
		if(e.keyCode === 8)
			return false;
	}else if(e.target.nodeName == "INPUT" && filter.indexOf(e.target.type) < 0){// || e.target.readOnly
		if(e.keyCode === 8)
			return false;
	}else if(e.target.readOnly){
		if(e.keyCode === 8)
			return false;
	}
});

/**
 * 설정한 태그로 scroll 위치 이동
 */
function scrollMove(objParam){
	if(objParam == null) return;
	if(objParam.tag == null) return;
	if(objParam.diff == null) objParam.diff = 0;
    var offset = $(objParam.tag).offset();
    $('html, body').animate({scrollTop : offset.top + objParam.diff}, 400);
}


/********************************************************************
 * input type = "number"  에서 최대 자리수 제한하기
 * 사용 예제 : maxlength="10" oninput="maxLengthCheck(this)"
 * @param	object
 * @returns	null
 *******************************************************************/
function maxLengthCheck(object){
	if(object.value.length > object.maxLength){
		object.value = object.value.slice(0, object.maxLength);
		
	}
}





function formateDate(date){
	var da = date.toLocaleDateString().split("/"); 
	var dt = date;
	var YY = date.getFullYear();
	var MM = date.getMonth()+1+"";
	var DD = date.getDate();
	if(MM < 10) {
	   MM = "0" + MM;
	}	    
	if(DD < 10) {
	   DD = "0" + DD;
	}
    var selDate = YY+MM+DD	
    return selDate;
	
}

//YYYYMMDD -> YYYY-MM-DD 날짜에 하이픈 넣기 style 에 따른 변환
function YMDFormatter(num, style){
     if(!num) return "";
     var formatNum = '';
     num=num.replace(/\s/gi, "");

     try{
          if(num.length == 8) {
        	  if(style == "dot"){
        		  formatNum = num.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');
        	  }else if(style = "hy"){
        		  formatNum = num.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');  
        	  }else{
        		  formatNum = num.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
        	  }
          }
     } catch(e) {
          formatNum = num;
     }
     return formatNum;
}



//테이블 페이징 
//sSelector : 대상이될 row 클래스  			ex : .List
//nSelector : 이전 다음 페이지넘버를 그릴 클레스      ex : .paging / $paging
//rowNum	: 페이지당 갯수 				    ex : 5

function fn_commonPagination(sSelector, nSelector, rowNum, clas){

	var paging;
	var pagingnext;
	var current_link=1;
	var PagingTrue=true;
	paging=-1;
	$(nSelector).empty();
	var num_row = rowNum;				//보여주는 갯수
	var list=$(sSelector);
	var total_num_row = list.length;
	var num_page=5;
	pagingnext=num_row;
	if(total_num_row / num_row <1){
		num_page = total_num_row/num_row;
		num_page=1;
		$(nSelector).append("<li style='list-style:none;'>");
		$(nSelector).append("<a href='#' class='prev prev"+clas+"'>이전</a>");
		for(var i=1; i<=num_page;i++){
			$(nSelector).append("<a href='#' class='pageint"+clas+"'>"+i+"</a>");
			}
		$(".pageint"+clas).eq(0).addClass("strong");
		$(nSelector).append("<a href='#' class='next next"+clas+"'>다음</a>");
	}
	if(total_num_row / num_row >=1){
		var aa=total_num_row/num_row;
		if(aa<num_page){
			aa++;
			num_page=aa;
		}
		num_page=Math.floor(num_page++);
		$(nSelector).append("<li style='list-style:none;'>");
		$(nSelector).append("<a href='#' class='prev prev"+clas+"'>이전</a>");
	if(total_num_row % num_row ==0){	
		if((total_num_row / num_row)<=num_page){
			for(var i=1; i<num_page;i++){
				$(nSelector).append("<a href='#' class='pageint"+clas+"'>"+i+"</a>");
				}
		}
		if((total_num_row / num_row)>num_page){
			for(var i=1; i<=num_page;i++){
				$(nSelector).append("<a href='#' class='pageint"+clas+"'>"+i+"</a>");
				}
			}
	}else{
		for(var i=1; i<=num_page;i++){
			$(nSelector).append("<a href='#' class='pageint"+clas+"'>"+i+"</a>");
			
		}
	}
		$(".pageint"+clas).eq(0).addClass("strong");
		$(nSelector).append("<a href='#' class='next next"+clas+"'>다음</a>");
		$(nSelector).append("</li>");

	}
		list.each(function(i){
			$(this).hide();
			if(i+1 <=num_row){
				list.eq(i).show();
				}
	});
		
	//페이징 숫자 클릭 이벤트
	$(document).on("click",".pageint"+clas,function(){
		list.hide();
		var page =$(this).text();
		var temp = page-1;
		var start = temp * num_row;
		current_link=(temp+1);
		for(var i=0;i<num_row;i++){
			list.eq(start+i).show();
		}
		pagingnext= rowNum*current_link;
		paging=--start;
		$(".pageint"+clas).removeClass("strong");
		$(this).addClass("strong");
	});
	
	//다음 버튼 클릭 이벤트
	var asc=1;
	var point;
	$(".next"+clas).off('click').on("click",function(){
		if(pagingnext>=total_num_row){
			alert("마지막 페이지 입니다.");
			return false;
		}else{
			list.hide();
			$(".pageint"+clas).removeClass("strong");
			$(".pageint"+clas).eq((current_link)).addClass("strong");	
			if((current_link+1) >=num_page){
				$(".pageint"+clas).eq((current_link % num_page)).addClass("strong");	
			}
			for(var i = 0 ; i<num_row;i++){
				list.eq((pagingnext+i)).show();
			}
			current_link++;
			pagingnext= pagingnext+(num_row);
			paging= pagingnext-(num_row+1);
		}
		if(((num_page)*asc)<current_link){
			asc++;
			$(".pageint"+clas).remove();
		for(var i=current_link; i<=((num_page)*asc);i++){
			if(i<=Math.ceil(list.length/rowNum)){
				$(".next"+clas).before("<a href='#' class='pageint"+clas+"'>"+i+"</a>");
				}
			}
		if((current_link) >=num_page){
			$(".pageint"+clas).eq((current_link-1) % num_page).addClass("strong");	//eq 0일때 체크
		}
		}	
	});
		
	//이전 버튼 클릭 이벤트
	$(".prev"+clas).off('click').on("click",function(){
		if(paging <=-1 || isNullToString(paging)==""){
			alert("처음 페이지 입니다.");
			return false;
		}else {
			list.hide();
			current_link--;
			$(".pageint"+clas).removeClass("strong");
			$(".pageint"+clas).eq((current_link-1)).addClass("strong");	
			for(var i=0;i<num_row;i++){
				list.eq((paging-i)).show();
			}
			paging= paging-(num_row);
			pagingnext= paging+(num_row+1);
		}
		if((num_page)*(asc-1)==current_link){
			 asc--;
				$(".pageint"+clas).remove();
			 for(var i=(((num_page)*(asc-1))+1);i<=current_link;i++){
					$(".next"+clas).before("<a href='#' class='pageint"+clas+"'>"+i+"</a>");
			}
		}
		if((current_link) >=num_page){
			$(".pageint"+clas).eq((current_link-1) % num_page).addClass("strong");	//eq 0일때 체크
		}
	});
}

//숫자확인
function isNumeric(num, opt){
	// 좌우 trim(공백제거)을 해준다.
	num = String(num).replace(/^\s+|\s+$/g, "");
	 
	if(typeof opt == "undefined" || opt == "1"){
		// 모든 10진수 (부호 선택, 자릿수구분기호 선택, 소수점 선택)
		var regex = /^[+\-]?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
	}else if(opt == "2"){
		// 부호 미사용, 자릿수구분기호 선택, 소수점 선택
		var regex = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
	}else if(opt == "3"){
		// 부호 미사용, 자릿수구분기호 미사용, 소수점 선택
		var regex = /^[0-9]+(\.[0-9]+)?$/g;
	}else{
		// only 숫자만(부호 미사용, 자릿수구분기호 미사용, 소수점 미사용)
		var regex = /^[0-9]$/g;
	}
	 
	if( regex.test(num) ){
		num = num.replace(/,/g, "");
		return isNaN(num) ? false : true;
	}else{
		return false;
	}
}

//파라미터 받아오기
function getParameter(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

//만나이계산
function calcAge(birth) {                 
    var date = new Date();
    var year = date.getFullYear();
    var month = (date.getMonth() + 1);
    var day = date.getDate();       
    if (month < 10) month = '0' + month;
    if (day < 10) day = '0' + day;
    var monthDay = month + day;
    
    birth = birth.replace('-', '').replace('-', '');

    var birthdayy = birth.substr(0, 4);
    var birthdaymd = birth.substr(4, 4);
    var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;

    return age;
} 

//글자수계산
function fnChkByte(obj) {
    var maxByte = 4000; //최대 입력 바이트 수
    var str = obj.value;
    var str_len = str.length;
 
    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";
 
    for (var i = 0; i < str_len; i++) {
        one_char = str.charAt(i);
        if (escape(one_char).length > 4) {
            rbyte += 2; //한글2Byte
        } else {
            rbyte++; //영문 등 나머지 1Byte
        }
        if (rbyte <= maxByte) {
            rlen = i + 1; //return할 문자열 갯수
        }
    }
    if (rbyte > maxByte) {
        alert("평가 종합 소견은 한글 " + (maxByte / 2) + "자 / 영문 " + maxByte + "자를 초과 입력할 수 없습니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
    } else {
        document.getElementsByClassName('ChkByte').innerText = rbyte;
    }
}

//textarea 크기변경 클레스명 resizeArea
$(document).on("keyup",".resizeArea",function(){
	$(this).css('height', 'auto' );
	$(this).height( this.scrollHeight );
});
