<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

		<style>
.content-section {
	margin-top: 0;
	padding-top: 0;
}

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

.select {
	background-color: transparent !important;
	background-image: none !important;
	border-color: transparent;
	border: none;
}
</style>
		<section class="breadcrumb-section set-bg"
			data-setbg="/resources/img/book-diary-bookmark.jpg">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-center">
						<div class="breadcrumb__text">
							<h2>Review Register</h2>
							<div class="breadcrumb__option">
								<a href="/">Home</a> <span>Review Register</span>
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
				<c:when test="${ auth eq 'ADM'  || auth eq 'MEM'}">
					<section class="checkout spad">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<h6>
										<span class="icon_tag_alt"></span> 작성취소하겠습니까? <a
											href="/review/list">Review List</a>
									</h6>
								</div>
							</div>
							<div class="checkout__form">
								<h4>Review Register</h4>
								<form
									action="/review/register?${_csrf.parameterName }=${_csrf.token}"
									method="post" name="registerForm">
									<div class="row">
										<div class="col-lg-8 col-md-6">
											<div class="checkout__input">
												<p>
													책이름<span>*</span>
												</p>
												<input type="text" class="form-control" id="bname"
													name="bname" value="${bvo.title }" placeholder="Use search" readonly required>
											</div>
											<div class="checkout__input">
												<p>
													추천도<span>*</span>
												</p>

												<div class="star-rating space-x-4 mx-auto ">
													<input type="radio" id="5-stars" name="recommend" value="5"
														v-model="ratings" /> <label for="5-stars"
														class="star pr-4">★</label> <input type="radio"
														id="4-stars" name="recommend" value="4" v-model="ratings" />
													<label for="4-stars" class="star">★</label> <input
														type="radio" id="3-stars" name="recommend" value="3"
														v-model="ratings" /> <label for="3-stars" class="star">★</label>
													<input type="radio" id="2-stars" name="recommend" value="2"
														v-model="ratings" /> <label for="2-stars" class="star">★</label>
													<input type="radio" id="1-star" name="recommend" value="1"
														v-model="ratings" /> <label for="1-star" class="star">★</label>
												</div>
											</div>
											<div class="checkout__input">
												<p>
													Title<span>*</span>
												</p>
												<input type="text" class="form-control"
													placeholder="Enter title" id="title" name="title" required>
											</div>
											<div class="checkout__input">
												<p>
													Writer<span>*</span>
												</p>
												<input type="text" class="form-control" id="memberID"
													name="memberID" value="${ses_memberID}" readonly >
											</div>
											<div class="checkout__input">
												<p>
													Content<span>*</span>
												</p>
												<textarea class="form-control" rows="5" id="content"
													name="content" style="resize: none;" required></textarea>
												<br>
												<span id="counter">(0/최대 2400자)</span>
											<script>
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
												value="${bvo.coverImg }">
											 <input type="hidden"
												class="" name="mno" value="${ses_mno}">
											
										</div>
										<!--경게1  -->
										<div class="col-lg-4 col-md-6">
											<div class="checkout__order">
												<h4>책 검색</h4>
												<div class="checkout__order__products search">
												<input id="search_book" class="form-control" type="text"
												style=" display: inline-block;" onkeypress="if( event.keyCode == 13 ){event.preventDefault();search();}">
												
												 
												<button id="getBname" type="button" class="btn btn-default"  >검색</button>
												</div>



												<div id="box" class="box"
													style="display: none; height: 500px; overflow-y: scroll;">
													<ul id="slist" style="padding: 0">
													</ul>
												</div>
					
												<div id="imgbox" class="blog__item__pic" >
                                    			<img src="${bvo.coverImg}" alt="">
                                				</div>
												
												<button type="submit" id="sbmReviewBtn" class="site-btn">등록</button>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</section>
					
<script>
	function search(){
		box.style.display = 'block';
		let kw = document.getElementById("search_book").value;
		$.ajax({
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			url : '../book/wrreview',
			type : 'post',
			data : {
				keyword : kw,
			}
		}).done(
				function(data) {
					
					let json_obj = JSON.parse(data);
					let inbody = '';
					
					let json_arr = json_obj.searchedList;
					let i = 0;
					$.each(json_arr, function(idx, bvo) {
						if (bvo.author != "") {
							inbody += '<li><button type="button" class="select">' + bvo.title
									+ '</button>';
							$("#slist").html(inbody);
						}
						;
						let btns = document.getElementsByClassName("select");
						for (let i = 0; i < btns.length; i++) {
							btns[i].addEventListener("click", function() {
								let title = json_arr[i].title;
								$('input[name=bname]').attr('value', title);
								let isbn = json_arr[i].isbn;
								$('input[name=isbn]').attr('value', isbn);
								let link = "/book/bookInfo?book_isbn="
										+ json_arr[i].isbn;
								;
								$('input[name=link]').attr('value', link);
								let cover = json_arr[i].cover;
								let imgbody='';
								imgbody +='<img src="'+cover+'" alt="">';
								imgbox.html(imgbody);
								$('input[name=cover]').attr('value', cover);
								box.style.display = 'none';
							});
						}
					});

				});
	}
	const URLSearch = new URLSearchParams(location.href);
	const token = $("meta[name='_csrf']").attr("content");
	const header = $("meta[name='_csrf_header']").attr("content");
	const box = document.getElementById("box");
	const getBname = document.getElementById("getBname");
	let imgbox=$("#imgbox");
	getBname.addEventListener("click", search);
	
	
	</script>

</c:when>
<c:otherwise>
	<script>
		alert("로그인이 필요한 페이지입니다.")
		location.replace("/");
	</script>
</c:otherwise>
</c:choose>
</sec:authorize>

<jsp:include page="../common/footer.jsp" />