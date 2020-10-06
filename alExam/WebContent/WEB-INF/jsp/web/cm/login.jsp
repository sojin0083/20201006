<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>${menuInfo.MENU_NM}</title>
	<c:import url="/cmmn/importResourceFile.do" var="jsimport" charEncoding="utf-8">
		<c:param name="pageMode">grid</c:param>
	</c:import>
	<c:out value="${jsimport}" escapeXml="false"/>
	<script type="text/javascript">
		 if('${msg}' != ''){
			 alert('${msg}');
 		 }
		 
		 function getCookie() {			
			 var cook = document.cookie + ';';			 
			 var idx = cook.indexOf('loginId', 0);			 
			 var val = '';			 
			 if(idx != -1) {
				 cook = cook.substring(idx, cook.length);				 
				 begin = cook.indexOf('=', 0) + 1;
				 end = cook.indexOf(';', begin);
				 val = unescape(cook.substring(begin, end));
			 }
			 return val;
		}	
		 
		function serviceLogin(){
			if($('.login_id').val() == ''){
				alert('아이디를 입력하세요.');
				$('.login_id').focus();
				return false;
			}
			if(isNullToString($('.login_pwd').val()) == ''){
				alert('비밀번호를 입력하세요.');
				$('.login_pwd').focus();
				return false;
			}
			if($('#chk01').val() == 'on'){
				setCookie('loginId', $('.login_id').val(), 7);
			}else{
				setCookie('loginId', $('.login_id').val(), -1);
			}				
			
			//$('#loginFrm').submit();
			var loginParam = $("#loginFrm").serialize();
			cfn.ajax({
				   "url" : "/login/loginInfoChk.do"
				 , "data" : loginParam
				 , "method" : "POST"
				 , "dataType" : "JSON"
				 , "success" : function(data){
			
					 var sessGb = data.sessGb;
						if(sessGb == "N"){
							alert(data.msg);
						}else{
							$("#userId").val(data.USER_ID);							
							loginSubmit(sessGb);
						}
				 	}	 
				 , "error" : function(data){
					 //alert("로그인 실패하였습니다.");
				 }
			});			
		}

		function loginSubmit(sessGb){
			var trg = document.getElementById("loginFrm");
			trg.action = "./login/loginUserInfo.do";
			trg.sessGb.value = sessGb;
			trg.submit();
		}
		
		function setCookie(name, value, expiredays) {
			var today = new Date();
			today.setDate( today.getDate() + expiredays );
			document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + today.toGMTString() + ';'
		}
		
		function passwdKeypress(e){
			if(e.keyCode == 13){
	    		serviceLogin();
			}
		}

		$(document).ready(function() {
			 var cookie_loginId = getCookie();
			 if(cookie_loginId != "") {
				 $('#inp01').val(cookie_loginId);
				 $('#chk01').attr('checked', true);			 
			 }
		    $('input').placeholder();
		});		
		
		$(document).on('keypress', '.txt', function(e){			
			if(e.keyCode == 13){
				pageInit();
			}
		});		
		
	</script>
</head>
<body>
	<div class="wrap">
		<div class="login_container">
			<div class="login_area">
				<h1>심리 검사 결과 관리 프로그램</h1>
				<div class="login_box">			
					<form id="loginFrm" method="post">
						<fieldset>
						<input type="hidden" name="loginGb" id="loginGb" value="loginOld" />
						<input type="hidden" name="sessGb" id="sessGb" value="" />
						<input type="hidden" name="userId" id="userId" value="" >				
							<div class="loginput">
								<div>
									<label for="loginId">아이디</label>
									<input type="text" id="inp01" class="forminput login_id" name="loginId" placeholder="아이디" />								
								</div>
								<div>
									<label for="inp02">비밀번호</label>
									<input type="password" id="inp02" class="forminput login_pwd" name="loginPwd" onkeypress="javascript:passwdKeypress(event);" placeholder="비밀번호" />								
								</div>
							</div>
						</fieldset>
					</form>
					<button class="button_login" title="로그인" value="로그인" onclick="javascrpit:serviceLogin()">로그인</button>
				</div>
			</div>	
		</div>
	</div>
</body>
</html>