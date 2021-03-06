<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
table {
	table-layout: fixed;
}

table, th, td {
	text-align: left;
}

td:nth-child(2) {
	text-align: left;
}

.ellipsis2 {
	display: -webkit-box;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	/* 	line-height: 24px; */
	/* 	max-height: 1.2em; */
	word-wrap: break-word;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
	width: 268px;
}

.ellipsis {
	display: -webkit-box;
	overflow: hidden;
	text-overflow: ellipsis;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
	max-height: 18px;
	white-space: normal;
	word-break: break-all;
	word-wrap: break-word;
	word-break: break-word;
}

#photoList {
	display: flex;
	margin: 0px;
	padding: 0px;
	/* 	justify-content: space-between; */
	flex-wrap: wrap;
	width: 100%;
	margin-top: 50px;
}

#photoList li {
	margin-right: 15px;
	display: inline-block;
	width: 296px;
	margin-bottom: 35px;
	border-radius: 1px;
	overflow: hidden;
	box-shadow: rgba(0, 0, 0, 0.15) 3px 3px 3px;
}

#photoList li:nth-child(3n+0) {
	margin-right: 0;
}

</style>

<!-- <div> -->
<!-- <div id="ajaxArea"> -->
<ul id="photoList">
	<c:forEach items="${list}" var="list">
		<li>
			<c:if test="${list.REPORT_STATUS eq 'n' }">
				<div style="width: 100%; height: 250px;">
					<a href="/ask/detail?askNo=${list.ASK_NO}"> <img
						style="height: 100%; width: 100%; object-fit: cover;"  alt="#"
						src="/upload/${list.FILE_STORED}">
					</a>
				</div>
			</c:if>
			<c:if test="${list.REPORT_STATUS eq 'y' }">
				<div style="width: 100%; height: 250px;">
					<a style="cursor: pointer;" onclick="reportStatusY();">
						<img style="height: 100%;" alt="금지" src="https://i.imgur.com/OlYEpre.png">
					</a>
				</div>
			</c:if>
			<div style="box-sizing: border-box; padding: 0 5px 10px;">
				<div style="padding-top: 8px; display: flex;">
					<c:if test="${list.REPORT_STATUS eq 'n' }">
						<a href="/ask/detail?askNo=${list.ASK_NO}"> <span
							class="ellipsis" style="text-align: left;">제목:
								${list.ASK_TITLE}</span>
						</a>
					</c:if>
					<c:if test="${list.REPORT_STATUS eq 'y' }">
						<a style="cursor: pointer;" onclick="reportStatusY();">
							<span class="ellipsis" style="text-align: left;">제목:
								${list.ASK_TITLE}</span>
						</a>
					</c:if>
					<c:if test="${not empty list.ASK_COM_CNT }">
						<c:if test="${list.REPORT_STATUS eq 'n' }">
							<strong><span class="tomato"><a href="/ask/detail?askNo=${list.ASK_NO }&commentFocus=true">&nbsp;[${list.ASK_COM_CNT}]</a></span></strong>
						</c:if>
					</c:if>
					<c:if test="${not empty list.ASK_COM_CNT }">
						<c:if test="${list.REPORT_STATUS eq 'y' }">
							<strong><span class="tomato"><a style="cursor: pointer;" onclick="reportStatusY();">&nbsp;[${list.ASK_COM_CNT}]</a></span></strong>
						</c:if>
					</c:if>
				</div>

				<div
					style="display: flex; align-items: flex-start; justify-content: space-between;">
					<c:if test="${list.USER_NICK eq null}">
						<span>탈퇴한 회원</span>
					</c:if>
					<c:if test="${list.USER_NICK ne null }">
						<span>닉네임: <img alt="#" src="${list.GRADE_URL}"
							style="width: 20px;">${list.USER_NICK}</span>
					</c:if>
				</div>

				<%-- 시간를 변환(yyyyMMdd)하여 변수에 저장하기 --%>
				<fmt:formatDate value="${list.ASK_DATE }" pattern="yyyyMMdd"
					var="timeStr" />

				<%--  현재 날짜 --%>
				<fmt:formatDate value="<%=new Date()%>" pattern="yyyyMMdd"
					var="nowStr" />
				<div
					style="display: flex; align-items: flex-start; justify-content: space-between;">
					<c:choose>
						<c:when test="${timeStr lt nowStr }">
							<span>작성일: <fmt:formatDate value="${list.ASK_DATE }"
									pattern="yy-MM-dd" /></span>
						</c:when>
						<c:when test="${timeStr eq nowStr }">
							<span>작성일: <fmt:formatDate value="${list.ASK_DATE}"
									pattern="HH:mm" /></span>
						</c:when>
					</c:choose>
					<span class="">조회수: ${list.ASK_HIT}</span>
				</div>
			</div>
		</li>
	</c:forEach>
</ul>

<c:if test="${login }">
	<button id="btnWrite" class="btn btn-primary pull-right">글쓰기</button>
</c:if>
<span class="pull-left">total : ${paging.totalCount }</span>
<div class="clearfix"></div>

<div class="form-inline text-center">
	<input class="form-control" type="text" id="search"
		value="${param.search }" />
	<button id="btnSearch" class="btn btnSearch">검색</button>
</div>
<c:import url="/WEB-INF/views/review/paging.jsp" />
<!-- 	</div>.container -->
<!-- </div>.wrap end -->