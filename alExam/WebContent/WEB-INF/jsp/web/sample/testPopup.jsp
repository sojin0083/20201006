<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

		$(document).ready(function(){
			alert("팝업 호출");
			
		});	
</script>	

<div class="pop-layer">
	<ul class="pop_title_ul_box">
		<li><h2>검사의뢰</h2></li>
		<li>
			<a href="#" class="btn-layerClose">Close</a>
		</li>
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
					<th scope="col">검사종류</th>
					<td colspan="3">
						<select id="" style="width:100%">
							<option value="">LICA 비문해 노인특성반영 인지기능검사</option>
							<option value=""></option>
							<option value=""></option>
						</select>
					</td>
				</tr>
				<tr>			
					<th scope="col">검사기관</th>
					<td><input type="text" value="000000병원" id="" style="width:100%"></td>
					<th scope="col">검사의뢰자</th>
					<td><input type="text" value="왕박사" id="" style="width:100%"></td>
				</tr>
				<tr>			
					<th scope="col">검사일자</th>
					<td>2020-05-19</td>
					<th scope="col">검사자</th>
					<td><input type="text" value="태박사" id="" style="width:100%"></td>
				</tr>
				<tr>			
					<th scope="col">메모</th>
					<td colspan="3"><textarea>오늘 검사 2명 의뢰합니다.</textarea></td>
				</tr>
			</tbody>
		</table>

		<div class="pop_group_box">
			<span>홍길동 외 2명</span> 
			<select id="">
				<option value="">그룹없음</option>
				<option value=""></option>
				<option value=""></option>
			</select>
			<a href="#pop_new_input" class="btn_all">그룹추가</a>
		</div>

		<div class="btncenter">
			<a href="#" class="btn_all">취소</a> <a href="#pop_new_input" class="btn_all col01">검사의뢰</a> 
		</div>
	</div>
</div>	 


		