<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/head.jsp" />
<c:import url="/WEB-INF/views/layout/adminheader.jsp" />
<!-- header end -->

<!-- 개별 스타일 및 스크립트 영역 -->

<script type="text/javascript">
$(document).ready(function(){
	$("#btnDelete").click(function(){
		var answer = confirm("선택한 공지사항을 삭제하시겠습니까?")
		var delchk = [];
   
	    $('.chk:checked').each(function(){
	        delchk.push($(this).val());
	    });
		if( answer == true ){
			location.href="/admin/notice/delete?noticeNo="+delchk;
		} else {
			return false;
		}
	})

})
</script>

<style type="text/css">

table {
	text-align: center;
	margin: auto;
}

th, td {
	text-align: center;
}

label {
	font-weight: normal !important;
}

</style>

<!-- 개별 영역 끝 -->

<div class="wrap">
<div class="container">

<h3>문의 목록</h3>
<hr>
<table class="table table-hover table-condensed">
<tr>
	<th>	</th>
	<th>공지 번호</th>
	<th width="45%">제목</th>
	<th>조회수</th>
	<th>작성일</th>
</tr>
<c:forEach items="${list }" var="i">
<tr>
	<td><input type="checkbox" id="${i.noticeNo }" value="${i.noticeNo }" class="chk" /></td>
	<td><label for="${i.noticeNo}">${i.noticeNo }</label></td>
	<td><label for="${i.noticeNo }"><a href="/admin/notice/detail?noticeNo=${i.noticeNo }">${i.noticeTitle }</a></label></td>
	<td><label for="${i.noticeNo }">${i.noticeHit }</label></td>
	<td><fmt:formatDate value="${i.noticeDate }" pattern="yyyy-MM-dd"/></td>
</tr>
</c:forEach>
</table>
<button id="btnDelete" class="pull-left">삭제</button>
<span class="pull-right">총 ${paging.totalCount }개</span>
<div class="clearfix"></div>
<c:import url="/WEB-INF/views/layout/paging.jsp" />


</div><!-- .container end -->
</div><!-- .wrap end -->

<!-- footer start -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />