<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/head.jsp" />
<c:import url="/WEB-INF/views/layout/header.jsp" />
<!-- header end -->

<!-- 개별 스타일 및 스크립트 영역 -->
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/main.css" />
<!-- 개별 영역 끝 -->

<%
    Date date = new Date();
    SimpleDateFormat simpleDate = new SimpleDateFormat("MMdd");
    String fmtDate = simpleDate.format(date);
%>

<div class="wrap">
    <div class="container-fluid" style="background-image: url(https://i.imgur.com/yJFIiNB.png)">
        <div class="container" style="padding: 0; margin-bottom: 25px; margin-top: 20px;">
            <div class="col-md-8" style="margin-top: 25px; padding-left: 0;">
            	<div>
	                <div>
			           	<!-- 인기 게시글 -->
						<div class="table-responsive" style="background-color:#eee;">
							<p style="font-size: 25px; text-align: left;">
								<img alt="fire" src="https://i.imgur.com/9LX0LXQ.png" width="30px;" height="30px;"> 현재 뜨거운 게시글
							</p>
                            <c:set var="setDate" value="<%= date %>" />
                            <c:set var="fmtDate" value="<%= fmtDate %>" />
                            <table class="table" id="popular_table">
                            	
                            	<tr>
                            		<th rowspan="2" style="cursor: pointer;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[0].ASK_NO }'">
                            			<img alt="#" src="/upload/${popularBoard[0].FILE_STORED }">
                            		</th>
                            		<td style="cursor: pointer; text-align: left; width: 200px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[0].ASK_NO }'">
	                                    <c:if test="${popularBoard[0].VOTE_END gt setDate }">
	                                        [진행]<br> ${popularBoard[0].ASK_TITLE }
	                                    </c:if>
	                                    <c:if test="${popularBoard[0].VOTE_END lt setDate }">
	                                        [종료]<br> ${popularBoard[0].ASK_TITLE }
	                                    </c:if>
                            		</td>
                            		<th rowspan="2" style="cursor: pointer;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[1].ASK_NO }'">
                            			<img alt="#" src="/upload/${popularBoard[1].FILE_STORED }">
                            		</th>
                            		<td style="cursor: pointer; text-align: left; width: 200px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[1].ASK_NO }'">
	                                    <c:if test="${popularBoard[1].VOTE_END gt setDate }">
	                                        [진행]<br> ${popularBoard[1].ASK_TITLE }
	                                    </c:if>
	                                    <c:if test="${popularBoard[1].VOTE_END lt setDate }">
	                                        [종료]<br> ${popularBoard[1].ASK_TITLE }
	                                    </c:if>
                            		</td>
                            	</tr>
                            	<tr>
                            		<td style="cursor: pointer; border-top: 0; height: 30px; font-size: 14px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[0].ASK_NO }'">
	                                    <img alt="#" src="${popularBoard[0].GRADE_URL }"
	                                    	 style="width: 20px; height: 20px; vertical-align: sub;">
	                                    ${popularBoard[0].USER_NICK } /
                                        <c:if test="${popularBoard[0].MMDDASK_DATE eq fmtDate }">
                                            <fmt:formatDate value="${popularBoard[0].ASK_DATE }"  pattern="HH:mm"/>
                                        </c:if>
                                        <c:if test="${popularBoard[0].MMDDASK_DATE ne fmtDate }">
                                            <fmt:formatDate value="${popularBoard[0].ASK_DATE }"  pattern="MM-dd"/>
                                        </c:if>
                            		</td>
                            		<td style="cursor: pointer; border-top: 0; height: 30px; font-size: 14px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[1].ASK_NO }'">
	                                    <img alt="#" src="${popularBoard[1].GRADE_URL }"
	                                    	 style="width: 20px; height: 20px; vertical-align: sub;">
	                                    ${popularBoard[1].USER_NICK } / 
                                        <c:if test="${popularBoard[1].MMDDASK_DATE eq fmtDate }">
                                            <fmt:formatDate value="${popularBoard[1].ASK_DATE }"  pattern="HH:mm"/>
                                        </c:if>
                                        <c:if test="${popularBoard[1].MMDDASK_DATE ne fmtDate }">
                                            <fmt:formatDate value="${popularBoard[1].ASK_DATE }"  pattern="MM-dd"/>
                                        </c:if>
                            		</td>
                            	</tr>
                            	
                            	<tr>
                            		<th rowspan="2" style="cursor: pointer;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[2].ASK_NO }'">
                            			<img alt="#" src="/upload/${popularBoard[2].FILE_STORED }">
                            		</th>
                            		<td style="cursor: pointer; text-align: left; width: 200px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[2].ASK_NO }'">
	                                    <c:if test="${popularBoard[2].VOTE_END gt setDate }">
	                                        [진행]<br> ${popularBoard[2].ASK_TITLE }
	                                    </c:if>
	                                    <c:if test="${popularBoard[2].VOTE_END lt setDate }">
	                                        [종료]<br> ${popularBoard[2].ASK_TITLE }
	                                    </c:if>
                            		</td>
                            		<th rowspan="2" style="cursor: pointer;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[3].ASK_NO }'">
                            			<img alt="#" src="/upload/${popularBoard[3].FILE_STORED }">
                            		</th>
                            		<td style="cursor: pointer; text-align: left; width: 200px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[3].ASK_NO }'">
	                                    <c:if test="${popularBoard[3].VOTE_END gt setDate }">
	                                        [진행]<br> ${popularBoard[3].ASK_TITLE }
	                                    </c:if>
	                                    <c:if test="${popularBoard[3].VOTE_END lt setDate }">
	                                        [종료]<br> ${popularBoard[3].ASK_TITLE }
	                                    </c:if>
                            		</td>
                            	</tr>
                            	<tr>
                            		<td style="cursor: pointer; border-top: 0; height: 30px; font-size: 14px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[2].ASK_NO }'">
	                                    <img alt="#" src="${popularBoard[2].GRADE_URL }"
	                                    	 style="width: 20px; height: 20px; vertical-align: sub;">
	                                    ${popularBoard[2].USER_NICK } / 
                                        <c:if test="${popularBoard[2].MMDDASK_DATE eq fmtDate }">
                                            <fmt:formatDate value="${popularBoard[2].ASK_DATE }"  pattern="HH:mm"/>
                                        </c:if>
                                        <c:if test="${popularBoard[2].MMDDASK_DATE ne fmtDate }">
                                            <fmt:formatDate value="${popularBoard[2].ASK_DATE }"  pattern="MM-dd"/>
                                        </c:if>
                            		</td>
                            		<td style="cursor: pointer; border-top: 0; height: 30px; font-size: 14px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[3].ASK_NO }'">
	                                    <img alt="#" src="${popularBoard[3].GRADE_URL }"
	                                    	 style="width: 20px; height: 20px; vertical-align: sub;">
	                                    ${popularBoard[3].USER_NICK } / 
                                        <c:if test="${popularBoard[3].MMDDASK_DATE eq fmtDate }">
                                            <fmt:formatDate value="${popularBoard[3].ASK_DATE }"  pattern="HH:mm"/>
                                        </c:if>
                                        <c:if test="${popularBoard[3].MMDDASK_DATE ne fmtDate }">
                                            <fmt:formatDate value="${popularBoard[3].ASK_DATE }"  pattern="MM-dd"/>
                                        </c:if>
                            		</td>
                            	</tr>
                            	
                            	<tr>
                            		<th rowspan="2" style="cursor: pointer;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[4].ASK_NO }'">
                            			<img alt="#" src="/upload/${popularBoard[4].FILE_STORED }">
                            		</th>
                            		<td style="cursor: pointer; text-align: left; width: 200px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[4].ASK_NO }'">
	                                    <c:if test="${popularBoard[4].VOTE_END gt setDate }">
	                                        [진행]<br> ${popularBoard[4].ASK_TITLE }
	                                    </c:if>
	                                    <c:if test="${popularBoard[4].VOTE_END lt setDate }">
	                                        [종료]<br> ${popularBoard[4].ASK_TITLE }
	                                    </c:if>
                            		</td>
                            		<th rowspan="2" style="cursor: pointer;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[5].ASK_NO }'">
                            			<img alt="#" src="/upload/${popularBoard[5].FILE_STORED }">
                            		</th>
                            		<td style="cursor: pointer; text-align: left; width: 200px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[5].ASK_NO }'">
	                                    <c:if test="${popularBoard[5].VOTE_END gt setDate }">
	                                        [진행]<br> ${popularBoard[5].ASK_TITLE }
	                                    </c:if>
	                                    <c:if test="${popularBoard[5].VOTE_END lt setDate }">
	                                        [종료]<br> ${popularBoard[5].ASK_TITLE }
	                                    </c:if>
                            		</td>
                            	</tr>
                            	<tr>
                            		<td style="cursor: pointer; border-top: 0; height: 30px; font-size: 14px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[4].ASK_NO }'">
	                                    <img alt="#" src="${popularBoard[4].GRADE_URL }"
	                                    	 style="width: 20px; height: 20px; vertical-align: sub;">
	                                    ${popularBoard[4].USER_NICK } / 
                                        <c:if test="${popularBoard[4].MMDDASK_DATE eq fmtDate }">
                                            <fmt:formatDate value="${popularBoard[4].ASK_DATE }"  pattern="HH:mm"/>
                                        </c:if>
                                        <c:if test="${popularBoard[4].MMDDASK_DATE ne fmtDate }">
                                            <fmt:formatDate value="${popularBoard[4].ASK_DATE }"  pattern="MM-dd"/>
                                        </c:if>
                            		</td>
                            		<td style="cursor: pointer; border-top: 0; height: 30px; font-size: 14px;"
                            			onclick="location.href='/ask/detail?askNo=${popularBoard[5].ASK_NO }'">
	                                    <img alt="#" src="${popularBoard[5].GRADE_URL }"
	                                    	 style="width: 20px; height: 20px; vertical-align: sub;">
	                                    ${popularBoard[5].USER_NICK } / 
                                        <c:if test="${popularBoard[5].MMDDASK_DATE eq fmtDate }">
                                            <fmt:formatDate value="${popularBoard[5].ASK_DATE }"  pattern="HH:mm"/>
                                        </c:if>
                                        <c:if test="${popularBoard[5].MMDDASK_DATE ne fmtDate }">
                                            <fmt:formatDate value="${popularBoard[5].ASK_DATE }"  pattern="MM-dd"/>
                                        </c:if>
                            		</td>
                            	</tr>
                            	
                            	
                            </table>
						</div>
					</div>
					<br>
					<!-- 메인 멘트 -->
	                <div style="background-color:#eee; height: 153px; padding: 8px;">
                		<c:if test="${mainment eq null }">
		                	<p style="font-size: 35px; margin-top: 14px;">회원가입을 통해 서로 의견을 나누고</p>
		                	<p style="font-size: 35px;">원하는 물건의 구매의사를 확인하세요!</p>
                		</c:if>
                		<c:if test="${mainment ne null }">
		                	<p class="pull-right" style="font-size: 14px;">회원님이 이번 달 아낀 돈은 
		                	<fmt:formatNumber type="number" maxFractionDigits="3" value="${moneyAndPercent.saveMoney }" /> 원입니다.</p>
		                	<p style="font-size: 25px;">당신을 위한 오늘의 멘트</p>
		                	<p style="font-size: 35px;">${mainment }</p>
                		</c:if>
	                </div>
                </div>
            </div>
            
            <div class="col-md-1"></div>
            
            <!-- 영수증 -->
            <div class="col-md-4" id="bill" style="background-color:#eee; margin: 24px 0 24px 0; padding-bottom: 15px;">
                <p>[주문(대기)번호]</p>
                <div>
	                <c:choose>
	                	<c:when test="${!empty userNo }">
			                <span style="font-size: 30px; background-color: gray;">${userNo }</span>
	                	</c:when>
	                	<c:when test="${empty userNo }">
			                <span style="font-size: 30px; background-color: gray;">1004</span>
	                	</c:when>
	                </c:choose>
                </div>
                <div style="text-align: left;">
		            <span>주문내역</span>
                <hr style="border: 3px solid black; margin: 0 10px 10px 0; width: 98%;">
	            </div>
                
                <div style="width: auto; height: 446px; overflow: auto;">
                    <c:set var = "sum" value = "0" />
                    <c:forEach items="${mainBill }" var="mainBill">
                    	<p style="display: flex;">
                            <span class="ellipsis2" style="text-align: left;">
                                [${mainBill.ITEM_END }] ${mainBill.ITEM_NAME }
                            </span>
                            <span class="pull-right" style="text-align: right; width: 40%">
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${mainBill.ITEM_PRICE }" /> 원
                            </span>
                        </p>
                        <c:set var="sum" value="${sum + mainBill.ITEM_PRICE}"/>
                    </c:forEach>
                </div>
                
                <hr style="border: 2px dashed black; margin: 0 10px 10px 0; width: 98%;">
                <span style="float: left;">총 주문금액</span>
                <span style="float: right;">
                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${sum }" /> 원
                </span>
                <img alt="barcode" src="https://i.imgur.com/hGHStFZ.png" style="margin-top: 10px; width: 100%;">
                <span id="time" style="float: right;"></span>
                
            </div>
        </div>
    </div>
<div class="container" id="main">

<hr class="featurette-divider">

	<!-- 등수 -->
	<div class="row">
		<p style="font-size: 30px;">
			<img alt="good" src="https://i.imgur.com/jGvv25B.png" width="30px;" height="30px;"> 너가 최고야!
		</p>
		<div class="col-lg-4">
		<div style="display: none;">Icons made by <a href="https://www.flaticon.com/authors/pixel-buddha" title="픽셀 부처">픽셀 부처</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
			<img class="img-circle"
				src="https://i.imgur.com/VoScoul.png"
				alt="일반 자리 표시자 이미지" width="140" height="140">
			<h2>1등</h2>
			<p style="width: 137px; margin: auto;">
				<img alt="#" src="${userTen[0].GRADE_URL }" width="20px" height="20px"> ${userTen[0].USER_NICK }
			</p>
		</div>
		<div style="display: none;">Icons made by <a href="https://www.flaticon.com/authors/pixel-buddha" title="픽셀 부처">픽셀 부처</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
		<div class="col-lg-4">
			<img class="img-circle"
				src="https://i.imgur.com/4XpO6Tc.png"
				alt="일반 자리 표시자 이미지" width="140" height="140">
			<h2>2등</h2>
			<p style="width: 137px; margin: auto;">
				<img alt="#" src="${userTen[1].GRADE_URL }" width="20px" height="20px"> ${userTen[1].USER_NICK }
			</p>
		</div>
		<div style="display: none;">Icons made by <a href="https://www.flaticon.com/authors/pixel-buddha" title="Pixel Buddha">Pixel Buddha</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
		<div class="col-lg-4">
			<img class="img-circle"
				src="https://i.imgur.com/mIveggd.png"
				alt="일반 자리 표시자 이미지" width="140" height="140">
			<h2>3등</h2>
			<p style="width: 137px; margin: auto;">
				<img alt="#" src="${userTen[2].GRADE_URL }" width="20px" height="20px"> ${userTen[2].USER_NICK }
			</p>
		</div>
	</div>

	<hr class="featurette-divider">

		<div class="row featurette">
			<!-- 공지사항 -->
			<div class="col-md-9">
				<div class="table-responsive">
					<table class="table table-hover" id="notice_table" style="height: 350px;">
						<tr>
							<th style="text-align: center; font-size: 20px; background-color: gray;">공지사항</th>
						</tr>
						<c:forEach var="i" begin="0" end="5">
							<tr>
								<td style="text-align: left;">
									<p class="ellipsis3" style="margin-bottom: 0;">
										<a href="/notice/detail?noticeNo=${noticeSix[i].noticeNo }">
											${noticeSix[i].noticeTitle }
										</a>
									</p>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			
			<div class="col-md-1"></div>
			
			<!-- 랭킹 table -->
			<div class="col-md-3">
				<table class="table table-hover" id="rank_table" style="height: 342px;">
					<c:forEach var="i" begin="3" end="9">
						<tr>
							<td>${i+1 }</td>
							<td style="text-align: left;">
								<img alt="#" src="${userTen[i].GRADE_URL }" width="20px" height="20px"> 
								${userTen[i].USER_NICK }
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>

		<hr class="featurette-divider">
	<p class="pull-right"><a href="#">맨 위로</a></p>
	


</div><!-- .container #main end -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />
</div><!-- .wrap end -->

<!-- footer start -->
<script src="/resources/js/main.js"></script>
