<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/head.jsp" />
<c:import url="/WEB-INF/views/layout/header.jsp" />
<!-- header end -->

<!-- 개별 스타일 및 스크립트 영역 -->
<script type="text/javascript">
$(document).ready(function() {
	$("#btnWrite").click(function() {
		submitContents($("#btnWrite"));
		
		$("form").submit();
		history.go(-1);
	})
	
	$("#btnCancel").click(function() {
		history.go(-1);
	})
})
</script>

<!-- 개별 영역 끝 -->

<div class="wrap">
<div class="container">

<h1>상대 지정해서 쪽지 작성하기</h1>
<hr>

<form action="/message/mem/write" method="post">


	<label for="userNick">받는 사람</label>
	<input type="text" id="userNick" name="userNick" />
	<br>

	<label for="title">제목</label>
	<input type="text" id="msgTitle" name="msgTitle" />
	<br>

	<label for="content">내용</label>
	<textarea rows="10" id="msgContent" name="msgContent"></textarea>
	<br>

	<button id="btnWrite">발송</button>
	<button id="btnCancel">취소</button>


</form>


</div><!-- .container end -->
</div><!-- .wrap end -->

<!-- footer start -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />






