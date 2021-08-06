<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<style>
tr > td > img{
	width: 100px;
	display: inline-block;
	margin-right: 25px;
}
.reduce>h5{
	overflow: hidden;
	text-overflow: ellipsis;
	display:-webkit-box;
	-webkit-line-clamp:3;
	-webkit-box-orient: vertical;
}
</style>

<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Bookly Review List</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>Review List</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Breadcrumb Section End -->

<!-- Shoping Cart Section Begin -->
<section class="shoping-cart spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
		<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />
				
				</sec:authorize>
				<div class="shoping__cart__table">
				<c:if test="${ses_memberID ne '' && ses_memberID ne null }">
					<div class="m-2 float-right btn btn-outline-success" id="write">
						<a href="/review/register" id="write"><i
							class="fa fa-pencil-square" aria-hidden="true"
							style="color: #7fad39;"></i>리뷰작성</a>

					</div>
				</c:if>
					<table>
						<thead>
							<tr>
								<th style="width :80px;">리뷰번호</th>
								<th>책</th>
								<th>Title</th>
								<th style="width: 200px">책 제목</th>
								<th style="width :90px;">작성자</th>
								<th>별점</th>
								<th>등록일</th>
								<th>좋아요 수</th>
								<th>조회수</th>
							</tr>
						</thead>
						<c:choose>
							<c:when test="${list.size() ne 0 }">
								<tbody>
									<c:forEach items="${list }" var="rvo">
										<tr>
											<td>${rvo.rno }</td>
											<td><img src="${rvo.cover }"
												alt="이미지 없음" style="text-align: left";></td>
											<td><h3>
											<a href="/review/detail?rno=${rvo.rno }&pageIndex=${pghdl.pgvo.pageIndex}&countPerPage=${pghdl.pgvo.countPerPage}&range=${pghdl.pgvo.range}&keyword=${pghdl.pgvo.keyword}">${rvo.title }</a></h3></td>
											<td class="reduce" style="vertical-align: middle;"><h5>${rvo.bname }</h5></td>
											<td>${rvo.memberID }</td>
											
											<c:if test="${rvo.recommend >0 }">
											<td>
											<c:forEach varStatus="1" begin="1" end="${rvo.recommend }">
								            		<i class="fa fa-star" style="color:#ffd700;"></i>
							            	</c:forEach></td>
							            	</c:if>
							            	<c:if test="${rvo.recommend eq 0}">
							            	<td><i class="fa fa-star-o" style="color:#ffd700;"></i></td>
							            	</c:if>
											<td>${rvo.regdate }</td>
											<c:if test="${rvo.likey > 0 }">
											<td><i class='fas fa-heart' style='font-size:24px;color:red;'></i>x${rvo.likey }</td>
											</c:if>
											<c:if test="${rvo.likey eq 0 }">
											<td><i class='fas fa-heart' style='font-size:24px;color:grey;'></i>x${rvo.likey }</td>
											</c:if>
											<td>${rvo.readCount}</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot style="margin-top: 60px;">
									<tr>
									<td colspan="9" >
										<jsp:include page="paging.jsp" />
										</td>
									</tr>
								</tfoot>
							</c:when>
							<c:otherwise>
								<tbody>
									<tr>
									<td colspan="3"></td>
										<td colspan="4" class="text-center">
											<h2>등록된 리뷰가 없습니다!</h2>
										</td>
									</tr>
								</tbody>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
			</div>
		</div>
	</div>
</section>

		


		<jsp:include page="../common/footer.jsp" />