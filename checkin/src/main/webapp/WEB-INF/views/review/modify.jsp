<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<style>
.star-rating {
	display: flex;
	flex-direction: row-reverse;
	font-size: 2.25rem;
	line-height: 2.5rem;
	justify-content: space-around;
	padding: 0 0.2em;
	text-align: center;
	width: 5em;
	margin-bottom: 10px;
}

.star-rating input {
	display: none;
}

.star-rating label {
	-webkit-text-fill-color: transparent;
	/* Will override color (regardless of order) */
	-webkit-text-stroke-width: 2.3px;
	-webkit-text-stroke-color: #2b2a29;
	cursor: pointer;
}

.star-rating :checked ~ label {
	-webkit-text-fill-color: gold;
}

.star-rating label:hover, .star-rating label:hover ~ label {
	-webkit-text-fill-color: #fff58c;
}
</style>

<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Review Modify</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>Review Modify</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

	
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberID" var="ses_memberID" />
	<sec:authentication property="principal.auth" var="auth" />
	<sec:authentication property="principal.mno" var="ses_mno" />
	
	<c:choose>
	<c:when test="${ses_memberID eq rvo.memberID}"> 
	<section class="checkout spad">
		<div class="container">
			<div class="row">
								<div class="col-lg-12">
									<h6>
										<span class="icon_tag_alt"></span> 수정취소하겠습니까? <a
										href="/review/detail?rno=${rvo.rno }&pageIndex=${pgvo.pageIndex }&countPerPage=${pgvo.countPerPage}&range=${pgvo.range}&keyword=${pgvo.keyword}">Review detail</a>
									</h6>
								</div>
							</div>
			<div class="checkout__form">
				<h4>Review Modify</h4>

				<form action="/review/modify" method="post" name="registerForm">
					<input type="hidden" name="url" value="${url }">
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }"> <input type="hidden" name="rno"
						value="${rvo.rno }"> <input type="hidden" name="pageIndex"
						value="${pgvo.pageIndex }"> <input type="hidden"
						name="countPerPage" value="${pgvo.countPerPage }"> <input
						type="hidden" name="range" value="${pgvo.range }"> <input
						type="hidden" name="keyword" value="${pgvo.keyword }">

					

						<div class="row">
							<div class="col-lg-8 col-md-6">
								<div class="checkout__input">
									<p>
										Title<span>*</span>
									</p>
									<input type="text" class="form-control" value="${rvo.title }"
										id="title" name="title">
								</div>
								<div class="checkout__input">
									<p>
										추천도<span>*</span>
									</p>

									<div class="star-rating space-x-4 mx-auto ">
										<input type="radio" id="5-stars" name="recommend" value="5"
											v-model="ratings" /> <label for="5-stars" class="star pr-4">★</label>
										<input type="radio" id="4-stars" name="recommend" value="4"
											v-model="ratings" /> <label for="4-stars" class="star">★</label>
										<input type="radio" id="3-stars" name="recommend" value="3"
											v-model="ratings" /> <label for="3-stars" class="star">★</label>
										<input type="radio" id="2-stars" name="recommend" value="2"
											v-model="ratings" /> <label for="2-stars" class="star">★</label>
										<input type="radio" id="1-star" name="recommend" value="1"
											v-model="ratings" /> <label for="1-star" class="star">★</label>
									</div>
									<script>
										$(function() {
											let recmd = '<c:out value="${rvo.recommend}"/>';
											console.log(recmd);
											let starId = recmd + '-stars';
											$('#' + starId).prop('checked',
													true);
										});
									</script>
								</div>

								<div class="checkout__input">
									<p>
										Writer<span>*</span>
									</p>
									<input type="text" class="form-control" id="memberID" name="memberID"
							value="${rvo.memberID }" disabled>
								</div>
								
								
								<div class="checkout__input">
									<p>
										Content<span>*</span>
									</p>
									<textarea class="form-control" rows="5" id="content"
										name="content" style="resize: none;">${rvo.content }${rvo.content2 }</textarea>
										<br>
												<span id="counter">(0/최대 2400자)</span>
											<script>
											function print(){
												var content=$("#content").val();
												$("#counter").html("("+content.length+"/최대2400자)");
											}
											
											$("#content").keyup(function (e){
												var content=$(this).val();
												$("#counter").html("("+content.length+"/최대2400자)");
												if((content.length) >2400){
													alert("최대 2400자까지 입력가능합니다");
													$(this).val(content.substring(0,2400));
													$("#counter").html("(2400/최대 2400자)");
												}
											});
											
											
											</script>
								</div>
								<input type="hidden" class="" name="link"
									value="/book/bookInfo?book_isbn=${bvo.isbn}"> <input
									type="hidden" class="" name="isbn" value="${bvo.isbn }">
								<input type="hidden" class="" name="cover"
									value="${bvo.coverImg }"> <input type="hidden" class=""
									name="mno" value="${ses_mno}">

							</div>
							<!--경게1  -->
							<div class="col-lg-4 col-md-6">
								<div class="checkout__order">
									<h4>책 정보</h4>
									<div class="checkout__order__products search">
										${rvo.bname }
									</div>

									

									<div id="imgbox" class="blog__item__pic">
										<img alt="" src="${rvo.cover }">
									</div>

									<button type="submit" id="sbmReviewBtn" class="site-btn">수정</button>
									
			
								</div>
							</div>
						</div>
				</form>
			</div>
		</div>
		
	</section>
	<script>
	$(function(){
		print();
	});
	</script>
	
	 </c:when> 
	<%--  <c:otherwise>
	 <script>
		alert("로그인이 필요한 페이지입니다.")
		location.replace("/");
	</script>
	</c:otherwise> --%>
</c:choose> 
</sec:authorize>

<jsp:include page="../common/footer.jsp" />