<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<style>
tr>td>img {
	width: 100px;
	display: inline-block;
	margin-right: 25px;
}

.my-transparent-button {
	background-color: transparent !important;
	background-image: none !important;
	border-color: transparent;
	border: none;
	color: #123123;
}
</style>
<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg"
	style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>MemberSearched List</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>MemberSearched List</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="shoping-cart spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="shoping__cart__table">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.memberID"
							var="ses_memberID" />


						<script>
var abc;

function isSubscribe(sendID, receiveID) {
	let header = $("meta[name='_csrf_header']")
			.attr("content");
	let token = $("meta[name='_csrf']").attr(
			"content");
	$.ajax({
		url : "/member/isSubscribe",
		type : "post",
		async : false,
		data : {
			smID : sendID,
			rmID : receiveID
		},
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}

	}).done(function(result) {
		abc = result;

	});
	return abc;
}

$(document).on("click",".subBtn",function() {
	let rmID_val = $(this).data("mid");
	let smID_val = '<c:out value="${ses_memberID}"/>';
	let header = $("meta[name='_csrf_header']").attr("content");
	let token = $("meta[name='_csrf']").attr("content");
	$.ajax({
		url : "/member/subscribe",
		type : "post",
		data : {
				smID : smID_val,
				rmID : rmID_val},
		beforeSend : function(xhr) {
					xhr.setRequestHeader(header,token);
				}
			}).done(function(result) {
						if (parseInt(result) == 1) {
							
							$("#"+ rmID_val).attr("class","fa fa-toggle-on my-transparent-button subBtn");
							$("#"+ rmID_val).css("visibility","visible");
						} else if (parseInt(result) == 2) {
							
							$("#"+ rmID_val).attr("class","fa fa-toggle-off my-transparent-button subBtn");
							$("#"+ rmID_val).css("visibility","visible");
						} else if (parseInt(result) == 3) {

						} else {
							alert("구독오류");
						}
						print_btn();
					});
});

$(document).on("click", ".goIndex", function() {
	location.href = "/member/login";
});
</script>


	<table>
		<thead>
			<tr>
				<th>아이디</th>
				<th>프로필사진</th>
				<th>이름</th>
				<th>리뷰보기</th>
				<th>위시리스트</th>
				<th>구독상태</th>
			</tr>
		</thead>
		<c:choose>
			<c:when test="${ms_list.size() ne 0 }">
				<tbody>
					<c:forEach items="${ms_list }" var="mvo">
						<tr>
							<td>${mvo.memberID }</td>
							<c:choose>
								<c:when test="${mvo.fvo.ftype > 0 }">
									<td><img
										src="/upload/${mvo.fvo.savedir}/${mvo.fvo.uuid}_th_${mvo.fvo.fname}"
										alt="이미지없음" width="100" height="100"></td>
								</c:when>
								<c:otherwise>
									<td><img src="/resources/images/member/person.png"
										alt="기본이미지" width="100" height="100"></td>
								</c:otherwise>

							</c:choose>

							<td>${mvo.memberName }</td>
							<td><a href="/review/myList?memberID=${mvo.memberID }"><i class='fas fa-book' style='font-size:36px;color:#7fad39;'></i></a>
							<td><a href="/wish/wishList?mno=${mvo.mno }" class="fas fa-gift" style="font-size: 36px;color:#7fad39;"></a></td>
							<td><button type="button" id="${mvo.memberID }"
									data-mid=${mvo.memberID } class="subBtn"
									style="visibility: hidden; font-size: 36px; color: #7fad39;"></button></td>
									
							<script>
								function print_btn() {
									let smID_val = '<c:out value="${ses_memberID}"/>';
									let rmID_val = '';
									rmID_val = '<c:out value="${mvo.memberID}"/>';
									abc = isSubscribe(smID_val,rmID_val);
									if (parseInt(abc) == 1) {
										$("#" + rmID_val).attr("class","fa fa-toggle-off my-transparent-button subBtn");
										$("#" + rmID_val).css("visibility","visible");
									} else if (parseInt(abc) == 2) {
										$("#" + rmID_val).attr("class","fa fa-toggle-on my-transparent-button subBtn");
										$("#" + rmID_val).css("visibility","visible");
									} else if (parseInt(abc) == 3) {

									} else {

									}

								}
							</script>
							<script>
								print_btn()
							</script>

						</tr>

					</c:forEach>
				</tbody>
			</c:when>
			<c:otherwise>
				<tbody>
					<tr>
						<td colspan="5" class="text-center">
							<h2>등록된 회원이 없습니다!</h2>
						</td>
					</tr>
				</tbody>
			</c:otherwise>
		</c:choose>
		<tfoot>
			<tr>
				
				<td colspan="6"><jsp:include page="sPagingMem.jsp"></jsp:include>
					</td>
				</tr>
			</tfoot>


		</table>
</div>
				
				</sec:authorize>

				<!-- 비로그인시 -->
				<sec:authorize access="isAnonymous()">
					<div class="container">
						<script>
							$(document).on("click", ".goIndex", function() {
								location.href = "/member/login";
							});
						</script>


						<table>
							<thead>
								<tr>
									<th>아이디</th>
									<th>프로필사진</th>
									<th>이름</th>
									<th>리뷰보기</th>
									<th>위시리스트</th>
									<th>구독상태</th>
								</tr>
							</thead>
							<c:choose>
								<c:when test="${ms_list.size() ne 0 }">
									<tbody>
										<c:forEach items="${ms_list }" var="mvo">
											<tr>`
												<td>${mvo.memberID }</td>
												<c:choose>


													<c:when test="${mvo.fvo.ftype > 0 }">
														<td><img
															src="/upload/${mvo.fvo.savedir}/${mvo.fvo.uuid}_th_${mvo.fvo.fname}"
															alt="이미지없음" width="100" height="100"></td>
													</c:when>
													<c:otherwise>
														<td><img src="/resources/images/member/person.png"
															alt="기본이미지" width="100" height="100"></td>
													</c:otherwise>
												</c:choose>
								
							

							<td>${mvo.memberName }</td>
							<td><a href="/review/myList?memberID=${mvo.memberID }"><i class='fas fa-book' style='font-size:36px;color:#7fad39;'></i></a>
							<td><a href="/wish/wishList?mno=${mvo.mno }" class="fas fa-gift" style="font-size: 36px;color:#7fad39;"></a></td>
													<td><button class="my-transparent-button" type="button" data-toggle="modal" data-target="#login-modal" ><i
                           class="fa fa-user"></i> Login</button></td>


							</tr>
							</c:forEach>
							</tbody>
							</c:when>
							<c:otherwise>
								<tbody>
									<tr>
										<td colspan="5" class="text-center">
											<h2>등록된 회원이 없습니다!</h2>
										</td>
									</tr>
								</tbody>
							</c:otherwise>
							</c:choose>
							<tfoot>
			<tr>
				
				<td colspan="6"><jsp:include page="sPagingMem.jsp"></jsp:include>
					</td>
				</tr>
			</tfoot>


						</table>
					</div>
					
				</sec:authorize>
			</div>
		</div>
	</div>
</section>

<jsp:include page="../common/footer.jsp" />
