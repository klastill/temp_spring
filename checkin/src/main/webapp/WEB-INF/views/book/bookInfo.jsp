<%@page import="com.myweb.domain.review.ReviewVO"%>
<%@page import="com.myweb.service.review.ReviewService"%>
<%@page import="javax.inject.Inject"%>
<%@page import="com.myweb.domain.BookVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.*"%>
<%@page import="com.myweb.api.BookListApi"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<%
String book_isbn = request.getParameter("book_isbn");
// api 호출
BookListApi bla = new BookListApi();
JsonObject obj = bla.lookUp(book_isbn);
String title = obj.get("title").getAsString();
String author = obj.get("author").getAsString();
String link = obj.get("link").getAsString();
String desc = obj.get("description").getAsString();
String cover = obj.get("cover").getAsString();
String isbn = obj.get("isbn").getAsString();
int price = obj.get("priceSales").getAsInt();
int review = obj.get("customerReviewRank").getAsInt();
int mile = obj.get("mileage").getAsInt();
BookVO book = new BookVO(isbn, price, title, author, link, desc, cover, review, mile);
request.setAttribute("book", book);
%>
<style>
.book_card button {
    background-color: transparent !important;
    background-image: none !important;
    border-color: transparent;
    border: none;
}
.book_card {
	width: fit-content;
  box-sizing: border-box;
  background-color: #fff;
	box-shadow: 0 30px 60px -12px rgba(50, 50, 93, 0.25),
    0 18px 36px -18px rgba(0, 0, 0, 0.3), 0 -12px 36px -8px rgba(0, 0, 0, 0.025);
  padding: 20px;
  display: flex;
  justify-content: space-between;
  flex-direction: column;
}
.book_container {
  width: 80vw;
  max-width: 1000px;
  min-width: 660px;
  padding: 20px;
  display: flex;
  justify-content: space-between;
  margin: 10px;
}
.book_container:nth-child(1) {
	border-bottom: 1px solid #ddd;
}
.book_container * {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
.book_cover {
	width: 200px;
}
.book_cover img {
	box-shadow: 0px 1px 7px 2px #c7c9d3;
	width: 200px;
	height: 300px;
	display: inline-block;
  transition: .3s ease;
  object-fit: contain;
}
.book_cover img:hover {
	transform: scale(1.04);
}
.info_list {
	list-style: none;
}
.info_list li {
	margin-bottom: 20px;
	font-size: 14px;
	font-weight: 300;
}
.info_list li:nth-child(1) {
	font-size: 20px;
	font-weight: 700;
}
.review_table {
	width: 100%;
}
.review_table th {
	border-bottom: 1px solid #666;
}
.review_con {
  border-top: 1px solid #bbb;
	border-bottom: 1px solid #999;
	width: 100%;
}
.review_con p {
	max-width: 100%;
	padding-left: 20px;
	white-space: normals;
	word-break: normal;
}
.btns {
	display: flex;
	width: 100%;
	justify-content: space-around;
}
.checked {
	color: #ffd400;
}
th, td {
	text-align: center;
}
@media screen and (max-width: 768px) {
	.book_card {
		box-shadow: none;
		width: 100%
	}
	.book_cover {
		width: 150px;
	}
	.book_cover img {
		box-shadow: 0px 1px 7px 2px #c7c9d3;
		min-width: 150px;
		height: 220px;
	}
	.btns {
		flex-wrap: wrap;
	}
	.book_container {
		width: 100%;
		min-width: 100px;
		margin: 0;
		padding:0;
	}
}

</style>
<div class="content-section" style="display: flex; flex-direction: column; align-items: center; padding:0; margin:0;">
<div class="book_card">
<div class="book_container">
	<div class="book_cover">
		<img src="${book.coverImg }"></img>
	</div>
	<div style="width: 70%; padding:20px; position: relative;">
		<a href="javascript:history.back();" style="position: absolute; top: -5%; right: 0;"><i class='fa fa-arrow-left'></i> 뒤로가기</a>
		<ul class="info_list">
			<li>${book.title }</li>
			<li>by ${book.author }</li>
			<li><span class="fa fa-star checked"></span> ${book.reviewRank} / 10</li>
			<li>${book.description }</li>
			<li>price : ${book.price }원 & mileage : ${book.mile }p</li>
		</ul>
		<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />
		    <sec:authentication property="principal.mno" var="mno"/>
		<c:if test="${ses_memberID ne null && ses_memberID ne '' }">
		<div class="btns">
		<button type="button" onclick="insertWish('${mno}', '${book.title}', '${book.coverImg}', '${book.price}', '${book.isbn}', '${book.author }', '${book.description }')"><i class="fa fa-heart" style="color: #ff3300;"></i> 위시리스트</button>
		<button type="button" onclick="insertCart('${book.title}', '${book.isbn}', '${book.price}', '${book.coverImg}', '${ses_memberID}', '${book.mile}')"><i class="fa fa-shopping-bag" style="color: #7fad39;"></i> 장바구니</button>
		<form action="/cart/order" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="hidden" name="price" value="${book.price }">	
			<input type="hidden" name="memberID" value="${ses_memberID }">	
			<input type="hidden" name="bname" value="${book.title }">	
			<input type="hidden" name="isbn" value="${book.isbn }">	
			<input type="hidden" name="cover" value="${book.coverImg }">	
			<input type="hidden" name="mileage" value="${book.mile }">	
			<input type="hidden" name="qty" value="1">	
			<button type="submit" id="quickOrder"><i class='fa fa-shopping-cart' style="color: #ffd700;"></i> 바로구매</button>
		</form>
		<form action="/review/register" method="get">
			<input type="hidden" name="title" value="${book.title}">
			<input type="hidden" name="link" value="/book/bookInfo?book_isbn=${book.isbn}">
			<input type="hidden" name="coverImg" value="${book.coverImg}">
			<input type="hidden" name="isbn" value="${book.isbn}">
			<button type="submit" ><i class="fa fa-pencil " style="color: #00c3ff" ></i> 리뷰작성</button>
		</form>
		</div>
		</c:if>
		</sec:authorize>
	</div>
</div>
<div class="book_container">
	<div style="width: 100%;">
	<c:choose>
		<c:when test="${bnlist.size() ne 0 }">
    <table class="review_table">
   		  <colgroup>
    			<col width="50%" />
	    		<col width="25%" />
	    		<col width="25%" />
 			  </colgroup>
        <th style="text-align: left;">제목</th>
        <th>작성자</th>
        <th>추천도</th>
			<c:forEach items="${bnlist }" var="rvo">
				<tr>
            <td style="text-align: left;"><a href="/review/detail?rno=${rvo.rno }&pageIndex=1&countPerPage=10"><p>${rvo.title }</p></a></td>
            <td><p>${rvo.memberID }</p></td>
            <td><p>
            	<c:forEach varStatus="1" begin="1" end="${rvo.recommend }">
            		<i class="fa fa-star" style="color:#ffd700;"></i>
            	</c:forEach>
            </p></td>
        </tr>
        <tr class="review_con">
            <td colspan="3" style="text-align: left;"><p style="font-weight: 100; font-size: 14px;  padding-left: 10px;">${rvo.content }</p></td>
        </tr>
			</c:forEach>
					<tr>
						<td colspan="3">
							<form action="/review/searchedList?" method="get" style="display:flex; justify-content: space-around; padding-top: 20px;">
						 		<input type="hidden" name="book_isbn" value="${book.isbn}">
								<button type="submit" style="color: #7fad39;">리뷰 더보기</button>
							</form>
						</td>
					</tr>
    </table>
    </c:when>
			<c:otherwise>
				<tbody>
					<tr>
						<td colspan="3">
							<h5>등록된 리뷰가 없습니다!</h5>
						</td>
					</tr>
				</tbody>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script>
function insertCart(title, isbn, price, coverImg, memberID, mile){
	let header = $("meta[name='_csrf_header']").attr("content");
	let token =  $("meta[name='_csrf']").attr("content");
	$.ajax({
		url:"/cart/"+ isbn,
		type:"post",
		data:{
			book_name: title,
			book_isbn: isbn,
			book_price: price,
			book_cover: coverImg,
			member_id: memberID,
			book_mile: mile,
			quantity: 1,
		},
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}
	}).done(function(result){
		if (result > 0) {
			alert("장바구니 추가 성공");
			cartCount();
		} else {
			alert("장바구니 추가 실패");
		}
	});
}

function insertWish(mno, title, coverImg, price, isbn, author, description){
	let header = $("meta[name='_csrf_header']").attr("content");
	let token =  $("meta[name='_csrf']").attr("content");
	$.ajax({
		url:"/wish/register",
		type:"post",
		data:{
			mno: mno,
			bname: title,
			book_cover: coverImg,
			book_price: price,
			book_isbn: isbn,
			book_author: author,
			book_description: description,
		},
	beforeSend: function(xhr){
		xhr.setRequestHeader(header, token);
	}
	}).done(function(result){
		if (result > 0) {
			console.log("성공"+result);
			alert("위시리스트 추가 성공");
			wishCount();
		} else {
			console.log("실패"+result);
			alert("위시리스트 추가 실패");
		}
	});
}
</script>