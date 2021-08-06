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
JsonArray array = bla.bestArray("bestList", pageNo);
List<BookVO> temp = bla.makeBookList(array);
List<BookVO> list = new ArrayList<>();
for (int i = 0; i < temp.size(); i++) {
	list.add(temp.get(i));
}
request.setAttribute("list", list);
if (pageNo == 1) {
	List<BookVO> best = new ArrayList<>();
	for (int i = 0; i < 3; i++) {
		best.add(temp.get(i));
	}
	request.setAttribute("best", best);
}
%>
<link rel="stylesheet" type="text/css" href="/resources/css/bookList.css">
<%-- 간이css ---%>
<style>
.best {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	justify-content: center;
}

.card {
	float: left;
	width: 20vw;
	min-width: 320px;
}

.wrapper {
	background-color: #fff;
	height: 20vw;
	min-height: 300px;
	position: relative;
	overflow: hidden;
	box-shadow: 0 19px 38px rgba(#000, 0.3), 0 15px 12px rgba(#000, 0.2);
}

.wrapper:hover .data {
	transform: translateY(0);
}

.data {
	position: absolute;
	bottom: 0;
	width: 100%;
	transform: translateY(calc(55px + 5em));
	transition: transform 0.3s;
}

.data .content {
	padding: 1em;
	position: relative;
	z-index: 1;
}

.author {
	font-size: 12px;
}

.wrapper .title {
	margin-top: 10px;
	font-size: 20px;
}

.text {
	height: 70px;
	margin: 0;
	text-overflow: ellipsis;
	overflow: hidden;
	line-height: 1.2;
	font-size: 15px;
	word-wrap: break-word;
}

.list_header {
	color: #fff;
	padding: 1em;
}

.list_header .date {
	float: left;
	font-size: 12px;
}

.wrapper  a {
	color: #fff;
	text-decoration: none;
}

.author, .text {
	color: #fff;
}

.button {
	display: block;
	width: 100px;
	margin: 2em auto 1em;
	text-align: center;
	font-size: 12px;
	color: #fff;
	line-height: 1;
	position: relative;
	font-weight: 700;
}

.button ::after {
	content: '\2192';
	opacity: 0;
	position: absolute;
	right: 0;
	top: 50%;
	transform: translate(0, -50%);
	transition: all 0.3s;
}

.button:hover ::after {
	transform: translate(5px, -50%);
	opacity: 1;
}

@media all and (max-width:1023px) {
	.card {
		width: 32vw;
		min-width: 0px;
	}
	.book-card, .book-cards {
		width: 96vw;
		min-width: 0px;
	}
}
</style>
<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Bestseller List</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>Best List</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<div class="search_result" style="margin-top: 20px;">
	<div class="item best">
		<c:forEach items="${best }" var="bvo">
			<div class="card">
				<div class="wrapper"
					style="background: linear-gradient(
          rgba(0, 0, 0, 0.2), 
          rgba(0, 0, 0, 0.2)
        ), url(${bvo.coverImg}) center / cover no-repeat">
					<div class="list_header">
						<div class="date">
							<i class='fas fa-crown' style='font-size:18px; color: #ffd700'><span class="day"> ${bvo.bestRank}</span></i>
						</div>
					</div>
					<div class="data">
						<div class="content">
							<span class="author">${bvo.author}</span>
							<h1 class="title">
								<a href="bookInfo?book_isbn=${bvo.isbn}">${bvo.title}</a>
							</h1>
							<p class="text">${bvo.description}</p>
							<a href="bookInfo?book_isbn=${bvo.isbn}" class="button">Read more</a>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="book-cards">
		<c:forEach items="${list }" var="bvo" varStatus="status">

			<div class="book-card">
				<div class="content-wrapper">
					<a href="bookInfo?book_isbn=${bvo.isbn}"><img src="${bvo.coverImg}"
						alt="${bvo.title}" class="book-card-img"></a>
					<div class="card-content">
						<div class="book-name">
							<a href="bookInfo?book_isbn=${bvo.isbn}">${bvo.title}</a>
						</div>
						<div class="book-by">by ${bvo.author}</div>
						<div class="rate">
							<span class="book-voters card-vote"><span class="fa fa-star checked"></span> ${bvo.reviewRank} / 10</span>
						</div>
						<div class="book-sum card-sum">${bvo.description}</div>
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
						<form action="/review/register" method="get">
						<input type="hidden" name="title" value="${bvo.title}">
						<input type="hidden" name="link" value="/book/bookInfo?book_isbn=${bvo.isbn}">
						<input type="hidden" name="coverImg" value="${bvo.coverImg}">
						<input type="hidden" name="isbn" value="${bvo.isbn}">
						<sec:authorize access="isAuthenticated()">
						<button type="submit" ><i class="fa fa-pencil " style="color: #00c3ff;" ></i> 리뷰작성</button>
						</sec:authorize>
						<sec:authorize access="isAnonymous()">
						<button type="button" data-toggle="modal" data-target="#login-modal" ><i
                           class="fa fa-user"></i> Login</button>
						</sec:authorize>
						</form>
				</div>
			</div>

		</c:forEach>
	</div>
	<div class="step" style="display: flex; padding: 15px 100px; margin: 15px; align-items: center; background-color: #fff; position: relative;">
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
	location.href = 'bestList?page=1';
});
sb.addEventListener('click', function () {
	location.href = 'bestList?page=' + (page*1 - 10);
});
sf.addEventListener('click', function () {
	location.href = 'bestList?page=' + (page*1 + 10);
});
ff.addEventListener('click', function () {
	location.href = 'bestList?page=50';
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
		pb.innerHTML += '<li class="page-item"><a class="page-link" href="bestList?page='+ i + '">' + i + '</a></li>'
	}
} else {
	for (let i = minp; i < maxp; i++) {
		pb.innerHTML += '<li class="page-item"><a class="page-link" href="bestList?page='+ i + '">' + i + '</a></li>'
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