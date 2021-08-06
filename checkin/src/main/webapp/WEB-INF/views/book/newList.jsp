<%-- java클래스 임포 ---%>
<%@page import="com.myweb.domain.BookVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.myweb.api.BookListApi"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<%
int pageNo = Integer.parseInt(request.getParameter("page"));
// api 호출
BookListApi bla = new BookListApi();
JsonArray array = bla.newArray(pageNo);
List<BookVO> temp = bla.makeBookList(array);
List<BookVO> list = new ArrayList<>();
for (int i = 0; i < temp.size(); i++) {
	list.add(temp.get(i));
}
request.setAttribute("list", list);
%>
<link rel="stylesheet" type="text/css" href="/resources/css/bookList.css">
<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Brand New List</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>New List</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<div class="search_result">
			<div class="book-cards">
	<c:forEach items="${list }" var="bvo" varStatus="status">

    <div class="book-card">
      <div class="content-wrapper">
        <a href="bookInfo?book_isbn=${bvo.isbn}"><img src="${bvo.coverImg}" alt="${bvo.title}" class="book-card-img"></a>
        <div class="card-content">
          <div class="book-name"><a href="bookInfo?book_isbn=${bvo.isbn}">${bvo.title}</a></div>
          <div class="book-by">by ${bvo.author}</div>
          <div class="rate">
            <span class="book-voters card-vote"><span class="fa fa-star checked"></span> ${bvo.reviewRank} / 10</span>
          </div>
          <div class="book-sum card-sum">${bvo.description} </div>
        </div>
      </div>
      <div class="option">
      		<form action="bookInfo?" method="get">
						<input type="hidden" name="book_isbn" value="${bvo.isbn}">
						<button type="submit"><i class='fa fa-book' style="color: #7fad39;"></i> 상세보기</button>
					</form>
        <form action="/review/searchedList?" method="get">
          <input type="hidden" name="book_isbn" value="${bvo.isbn}">
          <button type="submit"><i class='fa fa-search' style="color: #ffd700;"></i> 리뷰검색</button>
        </form>
					<%-- <sec:authorize access="isAuthenticated()"> --%>
						<form action="/review/register" method="get">
						<input type="hidden" name="title" value="${bvo.title}">
						<input type="hidden" name="link" value="/book/bookInfo?book_isbn=${bvo.isbn}">
						<input type="hidden" name="coverImg" value="${bvo.coverImg}">
						<input type="hidden" name="isbn" value="${bvo.isbn}">
						<button type="submit" ><i class="fa fa-pencil " style="color: #00c3ff;" ></i> 리뷰작성</button>
					</form>
					<%-- </sec:authorize>
					<sec:authorize access="isAnonymous()">
						<button onclick="alert('로그인이 필요합니다.')"><i class="fa fa-pencil " style="color: #00c3ff" ></i> 리뷰작성</button>
					</sec:authorize> --%>
      </div>
    </div>

	</c:forEach>
	  </div>
	  <div style="display: flex; padding: 15px 100px; margin: 15px; align-items: center; background-color: #fff; position: relative;">
		<button id="fb" type="button" class="pbtn zhide" style="left: 2%;"><i class="fas fa-step-backward"></i></button>
		<button id="sb" type="button" class="pbtn zhide" style="left: 10%;"><i class="fas fa-backward"></i></button>
		<ul id="pb" class="pagination"></ul>
		<button id="sf" type="button" class="pbtn" style="left: 90%;"><i class="fas fa-forward"></i></button>
		<button id="ff" type="button" class="pbtn" style="left: 98%;"><i class="fas fa-step-forward"></i></button>
	</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script>
const fb = document.getElementById('fb');
const sb = document.getElementById('sb');
const sf = document.getElementById('sf');
const ff = document.getElementById('ff');
const url = new URL(document.location.href);
const urlParams = url.searchParams;
const page = urlParams.get('page');
const pb = document.getElementById('pb');
if(page > 50 || page < 1) {
	window.location.href='/book/bestList?page=1';
}
let minp;
let maxp;

if (page > 49) {
	ff.classList.add('zhide');
}
if (page > 40) {
	sf.classList.add('zhide');
}
if (page > 10) {
	sb.classList.remove('zhide');
}
if (page > 1) {
	fb.classList.remove('zhide');
}
fb.addEventListener('click', function () {
	location.href = 'newList?page=1';
});
sb.addEventListener('click', function () {
	location.href = 'newList?page=' + (page*1 - 10);
});
sf.addEventListener('click', function () {
	location.href = 'newList?page=' + (page*1 + 10);
});
ff.addEventListener('click', function () {
	location.href = 'newList?page=50';
});

if (page >= 45) {
	minp = 41
	maxp = 51;
} else {
	minp = (page * 1) - 4;
	maxp = (page * 1) + 6;
}
if (page < 5) {
	for (let i = 1; i < 11; i++) {
		pb.innerHTML += '<li class="page-item"><a class="page-link" href="newList?page='+ i + '">' + i + '</a></li>'
	}
} else {
	for (let i = minp; i < maxp; i++) {
		pb.innerHTML += '<li class="page-item"><a class="page-link" href="newList?page='+ i + '">' + i + '</a></li>'
	}
}
const pba = pb.getElementsByTagName('li');
if (page < 5) {
		for (let j = 0; j < 10; j++) {
			if (j == page-1) {
				pba[j].classList.add('active');
			} else {
				pba[j].classList.remove('active');
			}
	}
} else if (page >= 45) {
	for (let j = 0; j < 10; j++) {
		if (j == page - minp) {
			pba[j].classList.add('active');
		} else {
			pba[j].classList.remove('active');
		}
	}
} else {
		for (let j = 0; j < 10; j++) {
			if (j == 4) {
				pba[j].classList.add('active');
			} else {
				pba[j].classList.remove('active');
			}
		}
}
</script>