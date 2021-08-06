<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Wish List</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>관심 있는 책들</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<div class="container" style="clear: both; margin-top: 10px;">
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />
		<sec:authentication property="principal.mno" var="ses_mno" />
  <table class="table table-hover" >
    <thead>
      <tr>
        <th>관심도서</th>
        <th>도서정보</th>
        <th style="min-width: 100px;">도서금액</th>
        <th style="min-width: 60px;">취소</th>
      </tr>
    </thead>
    
    <!-- c:when:자신의 위시리스트  // c:otherwise: 로그인된상태에서 다른사람의 위시리스트 -->
<c:choose>
<c:when test="${ses_mno eq model_mno }">
    <tbody id="wishList2">
   </tbody>
  </c:when>
 
  <c:otherwise>
   <tbody id="wishList3">
	</c:otherwise>
</c:choose>
  </table>
</sec:authorize>
	<!-- 비로그인시 위시리스트 -->
<sec:authorize access="isAnonymous()">
<table class="table table-hover" >
    <thead>
      <tr>
        <th>관심도서</th>
        <th>도서정보</th>
        <th style="min-width: 100px;">도서금액</th>
        <th style="min-width: 60px;">취소</th>
      </tr>
    </thead>
    <tbody id="wishList3">
   </tbody>
  </table>
</sec:authorize>
	
</div>
<script>
$(".menu-first li").removeClass("active");
$(".menu-first li:nth-child(5)").addClass("active");
$(function() {
	 list_wish(); 
});
$(function() {
	 list_wish2(); 
});
$(document).on("click",".fa-remove",function(){
	let mno_val=$(this).data("mno");
	let isbn_val=$(this).data("isbn");
	remove_wish(mno_val, isbn_val);
});
 function list_wish() {
	let header = $("meta[name='_csrf_header']").attr("content");
	let token =  $("meta[name='_csrf']").attr("content");
	let mno ='<c:out value="${model_mno}"/>';
	console.log("mno"+ mno);
	$.ajax({
		url:"/wish/wishList",
		type:"post",
		data:{
			mno:mno
		},
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType:"json"
	}).done(function (result) {
		let inbody="";
		if (result.length == 0) {
			$("#orderBtn").attr('type', 'button');
			inbody += '<tr><td colspan="4" class="text-center">위시리스트에 담은 도서가 없습니다.</td></tr>'
		} else {
		for (var i = 0; i < result.length; i++) {
			inbody+='<tr>'
			inbody+='<td><img src="'+result[i].cover+'"></td>'
			inbody+='    <td><p><a href="/book/bookInfo?book_isbn='+result[i].isbn+'">'+result[i].bname+'</a></p>'
			inbody+='<p>'+result[i].author+'</p>'
			inbody+='<p>'+result[i].description+'</p></td>'
			inbody+='        <td style="vertical-align: middle;">'+result[i].price+'원</td>'
			inbody+='      <td style="vertical-align: middle;"><i class="fa fa-remove" style="font-size:24px" data-mno="'+result[i].mno+'" data-isbn="'+result[i].isbn+'"></i></td>'
			inbody+='    </tr>'
			console.info(result[i].isbn);
		}}
		$("#wishList2").html(inbody);
	});
} 
 function list_wish2() {
		let header = $("meta[name='_csrf_header']").attr("content");
		let token =  $("meta[name='_csrf']").attr("content");
		let mno ='<c:out value="${model_mno}"/>';
		console.log("mno"+ mno);
		$.ajax({
			url:"/wish/wishList",
			type:"post",
			data:{
				mno:mno
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			dataType:"json"
		}).done(function (result) {
			let inbody="";
			if (result.length == 0) {
				$("#orderBtn").attr('type', 'button');
				inbody += '<tr><td colspan="4" class="text-center">위시리스트에 담은 도서가 없습니다.</td></tr>'
			} else {
			for (var i = 0; i < result.length; i++) {
				inbody+='<tr>'
				inbody+='<td><img src="'+result[i].cover+'"></td>'
				inbody+='    <td><p><a href="/book/bookInfo?book_isbn='+result[i].isbn+'">'+result[i].bname+'</a></p>'
				inbody+='<p>'+result[i].author+'</p>'
				inbody+='<p>'+result[i].description+'</p></td>'
				inbody+='        <td style="vertical-align: middle;">'+result[i].price+'원</td>'
				inbody+='    </tr>'
				console.info(result[i].isbn);
			}}
			$("#wishList3").html(inbody);
		});
	} 
function remove_wish(mno, isbn){
	let header = $("meta[name='_csrf_header']").attr("content");
	let token =  $("meta[name='_csrf']").attr("content");
	$.ajax({
		url:"/wish/"+mno+"/"+isbn,
		type:"delete",
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	}).done(function(result){
		alert("위시리스트 삭제 성공");
		list_wish(); 
	});
}
</script>

<jsp:include page="../common/footer.jsp" />