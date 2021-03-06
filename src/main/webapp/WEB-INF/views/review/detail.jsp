<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/head.jsp" />
<c:import url="/WEB-INF/views/layout/header.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/reportPopup.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<!-- header end -->

<script>
function getParameterByName(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
	return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}


$(document).ready(function() {
	
	var patId = getParameterByName('commentFocus');
	
	if(patId == 'true') {
		document.getElementById('commentBody').scrollIntoView();
	}

	$('.layerpopup').click(function(e) {
		$('#layer').show();
		
	});
	
	$('#layerClose').click(function() {
		$('#layer').css('display', 'none');
	});

})

</script>

<script type="text/javascript">
function message () {
	 action_popup.confirm('쪽지를 보내시겠습니까?', function (answer) {
        
		if(answer) {
		
			window.open('/message/write?userNick=${review.USER_NICK }', '쪽지 보내기', 'height=500, width=620, left=400, top=500, resizable=no');
	
		} else {
			return false;
		}
	
	 })
	 
	 /* 닫는 창으로 꼭 필요함 */
	 $(".modal_close").on("click", function () {
      action_popup.close(this);
      });      	
}

function userinfo() {

	window.open('/member/detail?userNick=${review.USER_NICK }', '회원정보 조회', 'width=620, height=640, left=400, top=500, resizable=no');
		
}
</script>

<script type="text/javascript">
$(document).ready(function() {
	if(${isScrap}) {
		$("#scrap")
			.html('스크랩 취소');
	} else {
		$("#scrap")
			.html('스크랩');
	}
	
	$("#scrap").click(function() {
		
		$.ajax({
			type: "get"
			, url: "/review/scrap"
			, data: { "reviewNo": '${review.REVIEW_NO }' }
			, dataType: "json"
			, success: function( data ) {
				console.log("성공");
	
				if( data.resultScrap ) { //스크랩 성공
					$("#scrap")
					.html('스크랩 취소');
				
				} else { //스크랩 취소 성공
					$("#scrap")
					.html('스크랩');
				}
// 				//추천수 적용
// 				$("#recommend").html(data.cnt);
			}
			, error: function() {
				console.log("실패");
			}
		}); //ajax end
		
	}); //$("#scrap").click() end

	$("#setReport").click(function() {
			
		var content = $("#reportContent").val() ;
		var category = $("#reportCategory").val();
		if(content == "") {
			
// 			alert("신고사유를 입력해주세요")
			action_popup.alert("신고사유를 입력해주세요")
			
			/* 닫는 창으로 꼭 필요함 */
			$(".modal_close").on("click", function () {
		     action_popup.close(this);
		    });
			return;
			
		} else {
			$.ajax({
				type: "post"
				, url: "/review/report"
				, data: {reportCategory: category, reportContent: content, "reviewNo": '${review.REVIEW_NO }'}
				, dataType: "json"
				, success: function( data ) {
					console.log("성공");
					$('.popupWrap1').addClass('hide1');
					$('#reportContent').val('');
					
					if(data.reportCheck) {
						action_popup.alert("신고가 완료되었습니다.");
					} else {
						action_popup.alert("이미 신고한 게시글입니다.");
					}
					/* 닫는 창으로 꼭 필요함 */
				    $(".modal_close").on("click", function () {
				        action_popup.close(this);
				    });
				}
				, error: function() {
					console.log("실패");
				}
			}); //ajax end
		}
	});	//$("#setReport").click() end

}); //$(document).ready() end
</script>

<script type="text/javascript">
var reviewComCount = ${review.REVIEW_COM_COUNT }

function insertComment() {
	
	var textarea = $("#reviewComContent").val();
	var content = textarea.replace(/(\n|\r\n)/g, '<br>');
	
	$.ajax({
		type: "post"
		, url: "/review/comment/write"
		, dataType: "json"
		, data: {
			reviewNo: ${review.REVIEW_NO }
			, reviewComContent: content
		}
		, success: function(data){
			if(data.success) {
			
			$("#reviewComCount").html(++reviewComCount, reviewComCount);	
				
// 			console.log("안녕!")
			
			var userNo = '<%=session.getAttribute("userNo")%>';
			var reviewComDate = moment(data.addComment.reviewComDate).format("YY-MM-DD HH:mm:ss");
				
			$('#appendArea').before('<tr data-updateReviewComNo="'+data.addComment.reviewComNo+'"></tr>' +
				'<tr data-reviewComNo="'+data.addComment.reviewComNo+'">' +
				'<td></td>' +

				'<td style="width: 15%; padding: 5px; text-align: left;"> ' +
				'<img alt="#" src="'+data.gradeUrl+'" width="20px;" height="20px;">' +data.userNick+'</td>' +
// 				'<td id="td'+ data.addComment.reviewComNo +'" style="text-align: left;">'+ data.addComment.reviewComContent +'</td>' +
				'<td id="td'+ data.addComment.reviewComNo +'" style="text-align: left;">'+ content+'</td>' +
				'<td id="dateTd'+data.addComment.reviewComNo +'" style="width: 10%; padding: 5px;">'+ reviewComDate+'</td>' +
				'<td>' +
				'<button class="btn btn_d btn-xs" onclick="deleteComment('+data.addComment.reviewComNo+');">삭제</button> ' +
				'<button class="btn btn_u btn-xs" onclick="updateComment('+data.addComment.reviewComNo+');">수정</button>' +
				'</td>' +
				'</tr>');
			
				$('#reviewComContent').val('');
				
				var textEle = $('#reviewComContent');
				textEle[0].style.height = '45px';
				var textEleHeight = textEle.prop('scrollHeight');
				textEle.css('height', textEleHeight);
				
			} else {
				alert("댓글 작성 실패");
			}
		}
		 ,error: function() {
			console.log("error");
		}
	});
} //insertComment() end

function updateComment(reviewComNo) {
	
    var reviewText = $("#td"+reviewComNo).html();
    var content = reviewText.replace(/<br>/ig, '\n');
    
    console.log("왜 수정이 안되는 거니")
    
	$("[data-reviewComNo='"+reviewComNo+"']").css("display", "none");
	$("[data-updateReviewComNo='"+reviewComNo+"']").append(
		'<div class="CommentWriter" style="width: 1020px;>' +
		'<div class="comment_inbox">' +
		'<span class="comment_inbox_name pull-left" id="userNick">' +
		'<img alt="#" src="${grade }" style="width: 20px; height: 20px;">&nbsp;${userNick }' +
		'</span>'+
		'<textarea  onkeyup="adjustHeight(this);" rows="1" class="comment_inbox_text" style="overflow: hidden;'+ 
			'overflow-wrap: break-word; height: 45px;" id="reviewComUpdateContent'+reviewComNo+'">'+content+'</textarea>' + 
		'<div class="register_box">' +
		'<button id="btnCommUpdateCancel" onclick="cancelCom('+reviewComNo+');">취소</button>' +
		'<button id="btnCommUpdate" onclick="updateCom('+reviewComNo+');">등록</button>　' +
		'</div>' +
		'</div>' +
		'</div>');
	
	var textEle = $('#reviewComUpdateContent' + reviewComNo);
	textEle[0].style.height = '45px';
	var textEleHeight = textEle.prop('scrollHeight');
	textEle.css('height', textEleHeight);
}

function updateCom(reviewComNo) {
	
	var textarea = $("#reviewComUpdateContent"+ reviewComNo).val();
	var content = textarea.replace(/(\n|\r\n)/g, '<br>');
	
	$.ajax({
		type: "post"
		, url: "/review/comment/update"
		, dataType: "json"
		, data: {
			reviewComNo: reviewComNo
			, reviewComContent: content
		}
		, success: function(data){
			if(data.success) {

				console.log(data.reviewComment.reviewComDate)
				
				var reviewComDate = moment(data.reviewComment.reviewComDate).format("YY-MM-DD HH:mm:ss");
			
				$("[data-reviewComNo='"+reviewComNo+"']").css("display", "table-row");
				$("#td"+reviewComNo).html(data.reviewComment.reviewComContent);
				$("#dateTd"+reviewComNo).html(reviewComDate);
				$("[data-updateReviewComNo='"+reviewComNo+"']").html('');
			} else {
				alert("댓글 수정 실패");
			}
		}
		, error: function() {
			console.log("error");
		}
	});
}

function cancelCom(reviewComNo) {
	$("[data-reviewComNo='"+reviewComNo+"']").css("display", "table-row");
	$("[data-updateReviewComNo='"+reviewComNo+"']").html('');
}

function deleteComment(reviewComNo) {
	
	action_popup.confirm("댓글을 삭제하시겠습니까?", function (del) {
		if(del) {

			/* ----------------------------------------- */
			
			$.ajax({
				type: "post"
				, url: "/review/comment/delete"
				, dataType: "json"
				, data: {
					reviewComNo: reviewComNo
				}
				, success: function(data){
					if(data.success) {
						
						$("#reviewComCount").html(--reviewComCount, reviewComCount);
						$("[data-reviewComNo='"+reviewComNo+"']").remove();
					
						} else {
							alert("댓글 삭제 실패");
						}
					}
					, error: function() {
						console.log("error");
					}
				});
		
		/* ----------------------------------------- */
		
		}
	})		

	/* 닫는 창으로 꼭 필요함 */
	$(".modal_close").on("click", function () {
	    action_popup.close(this);
	});
		
}


$(function() {
	
// 	$(document).on("click", "#btnList", function(){
// 		location.href="/review/list";
// 	});
	
	$(document).on("click", "#btnDelete", function(){
		action_popup.confirm("후기글을 삭제하시겠습니까?", function (res){
			if(res){
				
// 				console.log("reviewNo="+${review.REVIEW_NO }+"&userNo="+${review.USER_NO })
// 				location.href="/review/delete?reviewNo="+${review.REVIEW_NO }+"&userNo="+${review.USER_NO };

				location.href="/review/delete?reviewNo="+${review.REVIEW_NO };
			}
		})
	});

	$(".modal_close").on("click", function () {
	       action_popup.close(this);
	});
	
})/* $(function(){}) end */

function adjustHeight(obj) {
    obj.style.height = '45px';
    obj.style.height = (obj.scrollHeight) + 'px';
};
</script>

<style type="text/css">

.layerbox {
	position: relative;
	display: inline-block;
}

.layerpopup {
	width: 500px;
}

.layerpopup:hover {
	width: 500px;
	cursor: pointer;
	text-decoration: underline;
	color: #667F92;
}

#layer {
	display: none;
	padding: 10px;
	background: #fff;
	position: absolute;
	top: 24px;
	left: 0;
	z-index: 1;
	width: 110px;
	height: 120px;
	box-shadow: rgba(0, 0, 0, 0.15) 1.95px 1.95px 2.6px;
	padding: 0;
}

#layer>ul {
	list-style: none;
	padding-left: 0;
}

#layer>ul>li {
	line-height: 40px;
}

#layer>ul>li:hover {
	background-color: #a1b8c9;
	cursor: pointer;
}

#layer>ul>li>a {
	display: block;
	color: #667F92;
}

#layer>ul>li>a:hover {
	color: #FFF;
	cursor: pointer;
	text-decoration: none;
}

.layerClose {
	font-size: 15px;
	float: right;
}

.layerpopup:hover, #layerClose:hover {
	cursor: pointer;
}
.wrap {
/* 	margin-bottom: 50px; */
	background:#f2f2f2; 
}

table {
	table-layout: fixed;
}

table, th {
	text-align: center;
}

.success {
	width: 65px;
	height: 65px;
}

#item {
	margin: 15px auto 15px;
	padding: 50px 0;
	border-top: 1px solid #000;
	display: flex;
}

#votedate {
	text-align: center;
	font-size: 20px;
	margin-top: 60px;
}

.check {
	display: flex;
	justify-content: space-between;
	text-align: center;
	width: 641px;
	margin: 0 auto;
	text-align: center;
}

#itemImg {
	
	object-fit: scale-down;
}

.vote {
	width: 60px;
	height: 60px;
}

.cnt {
	font-size: 20px;
	margin: 0 10px;
}

#chartBox {
	width: 418px;
	margin: 15px;
    height: 35px;
    border-radius: 20px;
    overflow: hidden;
}

.item-wrapper {
	height: 35px !important;
	
}

.item-percentage {
	line-height: 32px;
	color: #f2f2f2 !important;
}

.recipeWrap {
/*  	width: 700px; */
	width: 1050px;
	margin: 50px auto 0;
	padding: 15px;
	background: #fff;
	padding: 50px;
	border-bottom-left-radius: 20px;
	border-bottom-right-radius: 20px;
}

.logo {
	margin: 25px 0 15px;
	text-align: center;
}

.logo img {
	width: 200px;
}

.title p:nth-child(1) {
	font-size: 32px;
	font-weight: 500;
	margin: 30px 0;
}

.title .bar {
	display: inline-block;
	margin: 0 15px;
	color: #777777;
}

.title .username {
	cursor: pointer;
}

.btnWrap {
	text-align: right;
}

.btnWrap button {
	width: 83px;
	height: 35px;
	background: transparent;
	border: 1px solid #333;
	font-weight: 600;
	margin-left: 3px;
}


.lineInfo {
	margin-top: 20px;
	border-bottom: 3px solid #585858;
	border-top: 3px solid #585858;
}

.lineInfo ul {
	padding: 10px 0;
	margin: 0;
	list-style: none;
	overflow: hidden;
}

.lineInfo li {
	float: left;
	line-height: 30px;
}

.lineInfo li+li {
	position: relative;
}

.lineInfo li+li:after {
	position: absolute;
/* 	top: 6px; */
 	top: 1px; 
	left: 0;
	content: '';
	clear: both;
	display: inline-block;
	width: 1px;
/* 	height: 15px; */
 	height: 28px; 
	background: #333;
}

.lineInfo li:nth-child(1) {
	width: 20%;
}

.lineInfo li:nth-child(2) {
	width: 40%;
}

.lineInfo li:nth-child(3) {
	width: 40%;
}

.lineInfo li dl {
	margin: 0;
	padding: 5px 0;
}

.lineInfo li dl dt, .lineInfo li dl dd {
	float: left;
}

.lineInfo li dl dt {
	width: 80px;
}

.lineInfo li dl dd {
	text-align: left;
	width: calc(100% - 80px);
	word-break: break-all;
}

.barcode {
	position: relative;
	margin: 0 auto;
	background: #fff;
	border-top-left-radius: 20px;
	border-top-right-radius: 20px;
	/* 	border-bottom-left-radius: 6px; */
	/* 	border-bottom-right-radius: 6px; */
/* 	width: 700px; */
	width: 1050px;
	padding: 20px 25px;
}

.barcode:before {
	position: absolute;
	top: 0;
	left: 16px;
	content: '';
	clear: both;
	display: inline-block;
/* 	width: 665px; */
	width: 1050px;
	border-top: 3px dashed #f2f2f2;
	content: '';
}

.barcode img {
	width: 100%;
	margin-top: 20px;
	padding-right: 10px;
}

.bottom {
	position: absolute;
	bottom: -18px;
	left: -1px;
	width: 100%;
	height: 21px;
	background-image: url("/resources/img/bottom.png");
	background-repeat: repeat;
	background-repeat-y: no-repeat;
}

.content {
	text-align: center; 
	padding: 30px 0 15px 0;
	margin: 0 20px 0 20px;
}

.content + p {
	margin: 0px;
}

.priceWrap {
	display: flex;
	justify-content: space-between;
	font-weight: 700;
	font-size: 24px;
}

.priceText {
	text-align: left;
	margin-left: 20px;
}

.price {
	text-align: right;
	margin-right: 20px;
}

#btnUpdate, #btnDelete, #btnList {
	background: #808080;
	border-radius: 0px;
	height: 35px;
	border: 1px solid #808080;
	color: #fff;
	padding: 0 15px;
}

#btnUpdate:hover, #btnDelete:hover, #btnList:hover {
	border: 1px solid #808080;
	background: #fff;
	color: #808080;
	transition: all .2s ease-in-out;
}
</style>

<style type="text/css">
ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

.CommentWriter {
	margin: 12px 0 29px;
    padding: 20px;
    border: 2px solid #9f9d9d;
    border-radius: 6px;
    box-sizing: border-box;
    background: #fff;
}
.CommentWriter .comment_inbox_text {
    overflow-x: hidden;
    overflow-y: auto;
    display: block;
    width: 100%;
    min-height: 17px;
    padding-right: 1px;
    border: 0;
    font-size: 13px;
    -webkit-appearance: none;
    resize: none;
    box-sizing: border-box;
    background: transparent;
    color: var(--skinTextColor);
    outline: 0;
}
.CommentWriter .register_box {
    text-align: right;
}

comment_inbox {
	text-align: left;
}

#btn_register, #btnCommUpdate, #btnCommUpdateCancel, .btn_u, .btn_d  {
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid #5b6e7a;
    border-radius: 4px;
    background-color: #5b6e7a;
    width: 65px;
    color: #fff;
}

#btnCommUpdateCancel {
	margin-right: 8px;
    border: 1px solid #ddd;
    background-color: #ddd;
}

.btn_d {
    border: 1px solid #ddd;
    background-color: #ddd;
}

#btnCommUpdate {
 	margin-right: -15px;
}

.btn_d, .btn_u {
	padding: 2px 5px;
	width: 44px;
}

</style>

<div class="wrap">
<div class="container" style="background: #f2f2f2;">
	<div class="recipeWrap">
		<div class="logo">
			<img alt="#" src="https://i.imgur.com/fdRrD3i.png">
		</div>
		<div class="title">
			<p style="text-align: center;">${review.REVIEW_TITLE }</p>
		</div>
		<div class="layerbox">
		<span>		
			<c:if test="${review.USER_NO eq null }">
				탈퇴한 회원
			</c:if>
			<c:if test="${sessionScope.userNo eq review.USER_NO || empty sessionScope.userNo }">
			<c:if test="${review.USER_NO ne null }">
				<span class="confirmation username">
					<img alt="#" src="${review.GRADE_URL}" style="width: 20px; height: 20px;">
						${review.USER_NICK }
				</span>
			</c:if>
			</c:if>
			<c:if test="${review.USER_NO ne null and sessionScope.userNo ne review.USER_NO and !empty sessionScope.userNo }">
				<span class="confirmation username layerpopup">
					<img alt="#" src="${review.GRADE_URL}" style="width: 20px; height: 20px;">
						${review.USER_NICK }
				</span>
			</c:if>
		</span>
			<div id="layer">
				<ul>
					<li><a onclick="userinfo();">회원정보 보기</a></li>
					<li><a onclick="message();">쪽지 보내기</a></li>
					<li><a id="layerClose">닫기</a></li>
				</ul>
			</div>
		</div><!-- #layerbox end -->
				
		<span class="bar">&nbsp;&nbsp;|&nbsp;&nbsp;</span>
		<span><fmt:formatDate value="${review.REVIEW_DATE }" pattern="yy-MM-dd HH:mm"/></span>
		<span class="bar">&nbsp;&nbsp;|&nbsp;&nbsp;</span>				
		<span>조회 <span id="cntCom">${review.REVIEW_HIT }</span></span>
		<span class="bar">&nbsp;&nbsp;|&nbsp;&nbsp;</span><span>댓글 ${review.REVIEW_COM_CNT}</span>
		<div class="btnWrap">

<%-- 			<c:if test="${review.USER_NO ne null and sessionScope.userNo ne review.USER_NO and !empty sessionScope.userNo }"> --%>
			<c:if test="${sessionScope.userNo ne review.USER_NO and !empty sessionScope.userNo }">
				<button id="scrap">스크랩</button>
				<c:if test="${review.USER_NO ne null }">
					<button id="report" class="popupOpen1">신고</button>
				</c:if>
			</c:if>
		</div>
			
		<div class="lineInfo">
			<ul>
				<li>
					<dl class="clearfix">
						<dt>NO</dt>
						<dd>${review.REVIEW_NO }</dd>
					</dl>
				</li>
				<li>
					<dl class="clearfix">
						<dt>BRAND</dt>
						<dd>${item.itemBrand}</dd>
					</dl>
				</li>
				<li>
					<dl class="clearfix">
						<dt>NAME</dt>
						<dd>${item.itemName }</dd>
					</dl>
				</li>
			</ul>
		</div>

		<div id="item">
			<img id="itemImg" src="/upload/${file.fileStored}" alt="상품사진" 
				class="img-responsive center-block" alt="Responsive image" />
		</div>

<%-- 			<div style="text-align: center; padding: 20px 0; border-top: 1px solid #000;">${ask.askContent }</div> --%>
			<div style="border-top: 1px solid #000;">
				<div class="content">
					${review.REVIEW_CONTENT }
				</div>
			</div>
			<div class="priceWrap" style="text-align: center; padding: 20px 0; border-top: 1px solid #000;">
				<p class="priceText">PRICE</p>
				<p class="price">
					￦ <fmt:formatNumber type="number" maxFractionDigits="3" value="${item.itemPrice }"/>
				</p>
			</div>
		</div>
		<div class="barcode">
			<img alt="#" src="/resources/img/askBarcode2.png">
			<div class="bottom"></div>
		</div>
	
	<br> <br>
	<hr>
	
	<!-- 댓글 리스트 -->
	<table class="table table-condensed">
	<thead>
	<tr>
		<th style="width: 1.6%;"></th>
		<th style="width: 15%;">닉네임</th>
		<th style="width: 58%;">댓글</th>
		<th style="width: 13%;">작성일</th>
		<th style="width: 10%;"></th>
	</tr>
	</thead>
	
	<tbody id="commentBody">
		<c:forEach items="${commentList }" var="reviewComment">
			<tr data-updateReviewComNo="${reviewComment.REVIEW_COM_NO }" ></tr>
			<tr data-reviewComNo="${reviewComment.REVIEW_COM_NO }">
				<td></td>
				<c:if test="${reviewComment.USER_NICK eq null }">
					<td style="text-align: left;">탈퇴한 회원</td>
				</c:if>
				<c:if test="${reviewComment.USER_NICK ne null }">
					<td style="text-align: left;">
						<img alt="#" src="${reviewComment.GRADE_URL}" style="width: 20px; height: 20px;">&nbsp;${reviewComment.USER_NICK }
					</td>
				</c:if>
				
				<td id="td${reviewComment.REVIEW_COM_NO }" style="text-align: left;">${reviewComment.REVIEW_COM_CONTENT }</td>
				<td id="dateTd${reviewComment.REVIEW_COM_NO }">
					<fmt:formatDate value="${reviewComment.REVIEW_COM_DATE}" pattern="yy-MM-dd HH:mm:ss" />
				</td>
				
				<td style="width: 10%;">
				<c:if test="${sessionScope.userNo eq reviewComment.USER_NO and !empty userNo }">
					<button class="btn_d" onclick="deleteComment(${reviewComment.REVIEW_COM_NO });">삭제</button>
					<button class="btn_u" onclick="updateComment(${reviewComment.REVIEW_COM_NO });">수정</button>
				</c:if>
				</td>
			</tr>
		</c:forEach>
		<tr id="appendArea"></tr>
	</tbody>
</table>

<!-- 로그인상태 -->
<c:if test="${login }">
<!-- 댓글 입력 -->
<div class="CommentWriter">
	<div class="comment_inbox">
		<span class="comment_inbox_name pull-left" id="userNick">
			<img alt="#" src="${grade }" style="width: 20px; height: 20px;">&nbsp;${userNick }
		</span>
			<textarea onkeyup="adjustHeight(this);" placeholder="댓글을 남겨보세요" rows="1" class="comment_inbox_text" 
				style="overflow: hidden; overflow-wrap: break-word; height: 45px;" id="reviewComContent" onkeyup="adjustHeight();"></textarea>
		<div class="register_box">
			<button role="button" id="btn_register" onclick="insertComment();">등록</button>
		</div>
	</div>
</div>
</c:if>
<br>

<div class="text-right" style="margin-bottom: 100px;">
	<button type="button" id="btnList" class="button" 
		style="float: left; margin-bottom: 20px;" onclick="location.href='/review/list';" >목록</button>
		<c:if test="${login }">
			<c:if test="${sessionScope.userNo eq review.USER_NO }">
				<a href="/review/update?reviewNo=${review.REVIEW_NO }">
				<button type="button" id="btnUpdate" class="button" >수정</button></a>
				<button type="button" id="btnDelete">삭제</button>
			</c:if>
		</c:if>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp" /><!-- footer start -->

</div><!-- .container end -->
</div><!-- .wrap end -->


<!-- 신고 처리 코드 영역 -->
<div class="popupWrap1 hide1">
	<div class="popup1">
		<div class="title">
			<p>신고 하기</p><span class="close1">❌</span>
		</div>
		<select id="reportCategory" name="reportCategory" class="select">
			<option value="A">부적절한 홍보 게시글</option>
			<option value="B">음란성 또는 청소년에게 부적합한 내용</option>
			<option value="C">명예훼손/사생활 침해 및 저작권침해등</option>
			<option value="D">기타</option>
		</select>	
		<textarea name="reportContent" id="reportContent" cols="30" rows="10"></textarea>
		<div class="btnWrap1">
			<button id="setReport">보내기</button>
		</div>
	</div>
</div>

<script>
$('.popupOpen1').on('click', function() {
	$('.popupWrap1').removeClass('hide1');
});

$('.close1').on('click', function() {
	$(this).parents('.popupWrap1').addClass('hide1');
	$(this).parents('.popup1').children('textarea').val('');
});
</script>