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
int pageNo;
if(request.getParameter("page") != null) {
	pageNo = Integer.parseInt(request.getParameter("page"));
} else {
	pageNo = 1;
}

String kw = request.getParameter("keyword");
// api 호출
BookListApi bla = new BookListApi();
JsonArray array = bla.searchedArray(kw, pageNo);
List<BookVO> temp = bla.makeBookList(array);
List<BookVO> list = new ArrayList<>();
for (int i = 0; i < temp.size(); i++) {
	list.add(temp.get(i));
}
request.setAttribute("list", list);
request.setAttribute("kw", kw);
%>
<link rel="stylesheet" type="text/css" href="/resources/css/bookList.css">

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
					<sec:authorize access="isAuthenticated()">
						<form action="/review/register" method="get">
						<input type="hidden" name="title" value="${bvo.title}">
						<input type="hidden" name="link" value="/book/bookInfo?book_isbn=${bvo.isbn}">
						<input type="hidden" name="coverImg" value="${bvo.coverImg}">
						<input type="hidden" name="isbn" value="${bvo.isbn}">
						<button type="submit" ><i class="fa fa-pencil " style="color: #00c3ff;" ></i> 리뷰작성</button>
					</form>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<button onclick="alert('로그인이 필요합니다.')"><i class="fa fa-pencil " style="color: #00c3ff" ></i> 리뷰작성</button>
					</sec:authorize>
      </div>
    </div>

	</c:forEach>
	  </div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>