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
	width: 162px;
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
    box-shadow: rgba(0, 0, 0, 0.15) 1.95px 1.95px 2.6px;
}

#photoList li:nth-child(3n+0) {

  margin-right: 0;

} 
</style>

<!-- <div> -->
<!-- <div id="ajaxArea"> -->
	<ul id="photoList">
		<c:forEach items="${tradeList }" var="list">
			<li>
				<div style="width: 100%; height: 250px;">
						<c:if test="${empty list.FILE_STORED}">
							<c:if test="${list.REPORT_STATUS eq 'n' }">
								<div style="display: none;">Icons made by <a href="https://www.flaticon.com/authors/good-ware" title="좋은 상품">좋은 상품</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
								<a href="/trade/detail?tradeNo=${list.TRADE_NO}">
									<img style="height: 100%;" alt="#" src="/resources/img/unknownPic.png">
								</a>
							</c:if>
							<c:if test="${list.REPORT_STATUS eq 'y' }">
								<div style="display: none;">Icons made by <a href="https://www.flaticon.com/authors/good-ware" title="좋은 상품">좋은 상품</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
								<a onclick="reportStatusY();">
									<img style="height: 100%;" alt="#" src="https://i.imgur.com/OlYEpre.png">
								</a>
							</c:if>
						</c:if>
						<c:if test="${!empty list.FILE_STORED}">
							<c:if test="${list.REPORT_STATUS eq 'n' }">
								<a href="/trade/detail?tradeNo=${list.TRADE_NO}">
									<img style="height: 100%; width: 100%; object-fit: cover;" alt="#" src="/upload/${list.FILE_STORED}">
								</a>
							</c:if>
							<c:if test="${list.REPORT_STATUS eq 'y' }">
								<a onclick="reportStatusY();">
									<img style="height: 100%;" alt="#" src="/resources/img/unknownPic.png">
								</a>
							</c:if>
						</c:if>
				</div>
				<div style="border: 1px solid #ccc; border-top: none; box-sizing: border-box; padding: 0 5px 10px; ">
					<div style="padding-top: 8px; display:flex; align-items: flex-start; justify-content: space-between;">
						<span class="ellipsis2" style="text-align: left;">
							제목: ${list.TRADE_TITLE}
							<c:if test="${!empty list.TRADE_COM_CNT }">
								<c:if test="${list.REPORT_STATUS eq 'y' }">
									<strong class="tomato"><a onclick="reportStatusY();">[${list.TRADE_COM_CNT }]</a></strong>
								</c:if>
								<c:if test="${list.REPORT_STATUS eq 'n' }">
									<strong class="tomato"><a href="/trade/detail?tradeNo=${list.TRADE_NO }&commentFocus=true">[${list.TRADE_COM_CNT }]</a></strong>
								</c:if>
							</c:if>
						</span>
						<span>조회수: ${list.TRADE_HIT}</span>
					</div>
		
					<div style="display:flex; align-items: flex-start; justify-content: space-between;">
						<c:if test="${list.USER_NICK eq null }">
							<span>탈퇴한 회원</span> 
						</c:if>
						<c:if test="${list.USER_NICK ne null }">
							<span>닉네임: <img alt="#" src="${list.GRADE_URL}" style="width: 20px;">${list.USER_NICK}</span> 
						</c:if>
						<span>작성일: <fmt:formatDate value="${list.TRADE_DATE}" pattern="yy-MM-dd" /></span>
					</div>
				</div>
			</li>
		</c:forEach>
	</ul>
	
	<c:if test="${login }">
		<button id="btnWrite" class="btn btn-primary pull-left">글쓰기</button>
	</c:if>
	<span class="pull-right">total : ${paging.totalCount }</span>
	<div class="clearfix"></div>
	
	<div class="form-inline text-center">
		<input class="form-control" type="text" id="search" value="${param.search }" />
		<button id="btnSearch" class="btnSearch">검색</button>
	</div>
	<c:import url="/WEB-INF/views/review/paging.jsp" />
	
<!-- 	</div>.container -->
<!-- </div>.wrap end -->